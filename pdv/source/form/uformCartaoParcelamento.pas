unit uformCartaoParcelamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, System.Actions, Vcl.ActnList, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.StrUtils, Generics.Collections, Recebimento,
  System.DateUtils;

type
  TformCartaoParcelamento = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    dbg_cartao: TDBGrid;
    pnl_cartao: TPanel;
    bvl_3: TBevel;
    pnl_parcelamento: TPanel;
    dbg_parcelamento: TDBGrid;
    acl_cartao: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    fdmt_cartoes: TFDMemTable;
    fdmt_cartoesID: TStringField;
    fdmt_cartoesNOME: TStringField;
    ds_cartoes: TDataSource;
    btn_cancelar: TButton;
    btn_confirmar: TButton;
    fdmt_parcelamento: TFDMemTable;
    ds_parcelamento: TDataSource;
    fdmt_parcelamentoPARCELAMENTO: TIntegerField;
    fdmt_parcelamentoNOME: TStringField;
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbg_cartaoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbg_cartaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbg_parcelamentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_confirmarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    fModalidade: string;
    fTotal: Extended;
    fData: TDate;
    fOk: Boolean;
    procedure list();
    procedure processar();
  end;

var
  formCartaoParcelamento: TformCartaoParcelamento;

implementation

uses
  Cartao, Helper, System.Math, AuthService;

{$R *.dfm}

procedure TformCartaoParcelamento.act_cancelarExecute(Sender: TObject);
begin
  fOk:= False;
  Close();
end;

procedure TformCartaoParcelamento.act_confirmarExecute(Sender: TObject);
begin
  if not THelper.Mensagem('Confirmar os dados informados?', 1) then Exit();
  processar();
  if fOk then Close();
end;

procedure TformCartaoParcelamento.btn_confirmarKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    27: begin
      if (fModalidade = 'C') then
        dbg_parcelamento.SetFocus()
      else
        dbg_cartao.SetFocus();
    end;
  end;
end;

procedure TformCartaoParcelamento.dbg_cartaoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  if (gdSelected in State) then
  begin
    TDBGrid(Sender).Canvas.Font.Style:= [fsBold];
    if TDBGrid(Sender).Focused() then
      TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F
    else
      TDBGrid(Sender).Canvas.Brush.Color:= $00C1FF84;
  end;

  if not Odd(TDBGrid(Sender).DataSource.DataSet.RecNo) then
  begin
    if not (gdSelected in State) then
    begin
      TDBGrid(Sender).Canvas.Brush.Color:= $00E2E2E2;
      TDBGrid(Sender).Canvas.FillRect(Rect);
      TDBGrid(Sender).DefaultDrawDataCell(Rect,Column.Field,State);
    end;
  end;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);
end;

procedure TformCartaoParcelamento.dbg_cartaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    13: begin
      if (fModalidade = 'C') then
        dbg_parcelamento.SetFocus()
      else
        btn_confirmar.SetFocus();
    end;
    27: act_cancelarExecute(Sender);
  end;
end;

procedure TformCartaoParcelamento.dbg_parcelamentoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    13: btn_confirmar.SetFocus();
    27: dbg_cartao.SetFocus();
  end;
end;

procedure TformCartaoParcelamento.FormCreate(Sender: TObject);
begin
  inherited;
  fModalidade:= '';
  fTotal:= 0;
  fData:= Now();
  fOk:= False;
end;

procedure TformCartaoParcelamento.list;
var
  vParcela: Extended;
  I: Integer;
begin
  TCartao.listByModalidade(fModalidade, fdmt_cartoes);
  pnl_parcelamento.Visible:= False;

  if (fModalidade = 'C') then
  begin
    fdmt_parcelamento.Open();
    fdmt_parcelamento.DisableControls();
    fdmt_parcelamento.EmptyDataSet();
    for I:= 1 to TAuthService.Terminal.Parcelamento do
    begin
      fdmt_parcelamento.Append();
      fdmt_parcelamentoPARCELAMENTO.AsInteger:= I;
      vParcela:= THelper.TruncateValue(SimpleRoundTo((fTotal / I)), 2);
      fdmt_parcelamentoNOME.AsString:=
        IfThen(I <= 9, '0' + I.ToString(), I.ToString()) +
          ' X ' + THelper.ExtendedToString(vParcela);
      fdmt_parcelamento.Post();
    end;
    fdmt_parcelamento.First();
    fdmt_parcelamento.EnableControls();

    pnl_parcelamento.Visible:= True;
  end;

  pnl_header.Caption:= 'TOTAL ' + THelper.ExtendedToString(fTotal);
end;

procedure TformCartaoParcelamento.processar;
var
  vCartao: TCartao;
  qParcelas: Integer;
  nParcela: Integer;
  vParcela: Extended;
  vData: TDate;
  vTotal: Extended;
begin
  case AnsiIndexStr(fModalidade, ['C','D','A','R','P','T']) of
    0: begin
      vCartao:= TCartao.find(fdmt_cartoesID.AsString);
      qParcelas:= fdmt_parcelamentoPARCELAMENTO.AsInteger;
      vParcela:= THelper.TruncateValue(SimpleRoundTo((fTotal / qParcelas), -6), 2);
      vData:= fData;
      vTotal:= 0;
      for nParcela:= 1 to qParcelas do
      begin
        vTotal:= (vTotal + vParcela);
        vData:= IncDay(vData, vCartao.CompensaCredito);

        TAuthService.listCtRecebimento.Add(TRecebimento.Create);
        TAuthService.listCtRecebimento.Last.ContaId:=
          TAuthService.Terminal.ContaId;
        TAuthService.listCtRecebimento.Last.CategoriaId:=
          TAuthService.Terminal.CategoriaId;
        TAuthService.listCtRecebimento.Last.CartaoId:= vCartao.Id;
        TAuthService.listCtRecebimento.Last.Modalidade:= 'C';
        TAuthService.listCtRecebimento.Last.Parcela:= nParcela;
        TAuthService.listCtRecebimento.Last.QtdeParcelas:= qParcelas;
        TAuthService.listCtRecebimento.Last.Competencia:= fData;
        TAuthService.listCtRecebimento.Last.Valor:= vParcela;
        TAuthService.listCtRecebimento.Last.Vencimento:= vData;
        TAuthService.listCtRecebimento.Last.Recebimento:= vData;
        TAuthService.listCtRecebimento.Last.Situacao:= 'F';
        if (nParcela = qParcelas) then
          TAuthService.listCtRecebimento.Last.Valor:= vParcela + (fTotal - vTotal);
      end;
      FreeAndNil(vCartao);
    end;
    1: begin
      vCartao:= TCartao.find(fdmt_cartoesID.AsString);
      qParcelas:= 1;
      vParcela:= fTotal;
      vData:= fData;
      for nParcela:= 1 to qParcelas do
      begin
        vData:= IncDay(vData, vCartao.CompensaDebito);

        TAuthService.listCtRecebimento.Add(TRecebimento.Create);
        TAuthService.listCtRecebimento.Last.ContaId:=
          TAuthService.Terminal.ContaId;
        TAuthService.listCtRecebimento.Last.CategoriaId:=
          TAuthService.Terminal.CategoriaId;
        TAuthService.listCtRecebimento.Last.CartaoId:= vCartao.Id;
        TAuthService.listCtRecebimento.Last.Modalidade:= 'D';
        TAuthService.listCtRecebimento.Last.Parcela:= nParcela;
        TAuthService.listCtRecebimento.Last.QtdeParcelas:= qParcelas;
        TAuthService.listCtRecebimento.Last.Competencia:= fData;
        TAuthService.listCtRecebimento.Last.Valor:= vParcela;
        TAuthService.listCtRecebimento.Last.Vencimento:= vData;
        TAuthService.listCtRecebimento.Last.Recebimento:= vData;
        TAuthService.listCtRecebimento.Last.Situacao:= 'F';
      end;
      FreeAndNil(vCartao);
    end;
    2,3,4,5: begin
      vCartao:= TCartao.find(fdmt_cartoesID.AsString);
      qParcelas:= 1;
      vParcela:= fTotal;
      vData:= fData;
      for nParcela:= 1 to qParcelas do
      begin
        vData:= IncDay(vData, vCartao.CompensaCredito);

        TAuthService.listCtRecebimento.Add(TRecebimento.Create);
        TAuthService.listCtRecebimento.Last.ContaId:=
          TAuthService.Terminal.ContaId;
        TAuthService.listCtRecebimento.Last.CategoriaId:=
          TAuthService.Terminal.CategoriaId;
        TAuthService.listCtRecebimento.Last.CartaoId:= vCartao.Id;
        TAuthService.listCtRecebimento.Last.Modalidade:= 'C';
        TAuthService.listCtRecebimento.Last.Parcela:= nParcela;
        TAuthService.listCtRecebimento.Last.QtdeParcelas:= qParcelas;
        TAuthService.listCtRecebimento.Last.Competencia:= fData;
        TAuthService.listCtRecebimento.Last.Valor:= vParcela;
        TAuthService.listCtRecebimento.Last.Vencimento:= vData;
        TAuthService.listCtRecebimento.Last.Recebimento:= vData;
        TAuthService.listCtRecebimento.Last.Situacao:= 'F';
      end;
      FreeAndNil(vCartao);
    end;
  end;

  fOk:= True;
end;

end.
