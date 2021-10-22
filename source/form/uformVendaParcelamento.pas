unit uformVendaParcelamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids, System.Math, Generics.Collections, Recebimento,
  Vcl.ComCtrls;

type
  TformVendaParcelamento = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_confirmar: TButton;
    pnl_body: TPanel;
    btn_cancelar: TButton;
    acl_venda_parcelamento: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    lbe_valor: TLabeledEdit;
    dbg_parcelas: TDBGrid;
    fdmt_parcelas: TFDMemTable;
    ds_parcelas: TDataSource;
    fdmt_parcelasVENCIMENTO: TDateField;
    fdmt_parcelasVALOR: TCurrencyField;
    fdmt_parcelasNUMERO: TIntegerField;
    dtp_vencimento: TDateTimePicker;
    cbx_parcelamento: TComboBox;
    lb_vencimento: TLabel;
    lb_parcelamento: TLabel;
    Bevel1: TBevel;
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure acl_venda_parcelamentoUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure cbx_parcelamentoSelect(Sender: TObject);
    procedure dbg_parcelasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    procedure populaCbxParcelas();
    procedure save();
  public
    { Public declarations }
  end;

var
  formVendaParcelamento: TformVendaParcelamento;

implementation

{$R *.dfm}

uses udmRepository, CustomEditHelper, AuthService, Helper;

procedure TformVendaParcelamento.acl_venda_parcelamentoUpdate(
  Action: TBasicAction; var Handled: Boolean);
begin
  act_confirmar.Enabled:= (fdmt_parcelas.RecordCount >= 1);
end;

procedure TformVendaParcelamento.act_cancelarExecute(Sender: TObject);
begin
  Close;
end;

procedure TformVendaParcelamento.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformVendaParcelamento.cbx_parcelamentoSelect(Sender: TObject);
var
  vLiq,
  vParcela,
  vTotalParcelas: Extended;
  vQuantidadeParcelas: Integer;
  vDataParcela: TDate;
  I: Integer;
begin
  vLiq:= THelper.StringToExtended(lbe_valor.Text);
  vDataParcela:= dtp_vencimento.Date;
  vQuantidadeParcelas:= (cbx_parcelamento.ItemIndex + 1);
  vParcela:= THelper.TruncateValue(SimpleRoundTo((vLiq / vQuantidadeParcelas), -6), 2);
  vTotalParcelas:= 0;

  fdmt_parcelas.Open();
  fdmt_parcelas.DisableControls;
  fdmt_parcelas.EmptyDataSet;
  for I:= 1 to vQuantidadeParcelas do
  begin
    vTotalParcelas:= (vTotalParcelas + vParcela);
    fdmt_parcelas.Append();
    fdmt_parcelasNUMERO.AsString:= I.ToString();
    fdmt_parcelasVENCIMENTO.AsDateTime:= vDataParcela;
    fdmt_parcelasVALOR.AsExtended:= vParcela;
    if (I = vQuantidadeParcelas) then
      fdmt_parcelasVALOR.AsExtended:= vParcela + (vLiq - vTotalParcelas);
    fdmt_parcelas.Post();

    vDataParcela:= IncMonth(vDataParcela);
  end;
  fdmt_parcelas.First;
  fdmt_parcelas.EnableControls;
end;

procedure TformVendaParcelamento.dbg_parcelasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  if (gdSelected in State) then
  begin
    TDBGrid(Sender).Canvas.Font.Style:= [fsBold];
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;
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

procedure TformVendaParcelamento.FormCreate(Sender: TObject);
begin
  inherited;
  TCustomEdit(lbe_valor).EditFloat();
  lbe_valor.Text:= THelper.ExtendedToString(TAuthService.vRestante);
  dtp_vencimento.Date:= Now;
  populaCbxParcelas();
end;

procedure TformVendaParcelamento.populaCbxParcelas;
var
  I: Integer;
begin
  cbx_parcelamento.Items.Clear;
  for I:= 1 to 48 do
  begin
    cbx_parcelamento.Items.Add(I.ToString() +  'x');
  end;
  cbx_parcelamento.ItemIndex:= -1;
end;

procedure TformVendaParcelamento.save;
begin
  if (fdmt_parcelas.RecordCount >= 1) then
  begin
    TAuthService.lParcelas:= TObjectList<TRecebimento>.Create;
    fdmt_parcelas.DisableControls;
    fdmt_parcelas.First;
    while not fdmt_parcelas.Eof do
    begin
      TAuthService.lParcelas.Add(TRecebimento.Create);
      TAuthService.lParcelas.Last.Competencia:= Now;
      TAuthService.lParcelas.Last.Parcela:= fdmt_parcelasNUMERO.AsInteger;
      TAuthService.lParcelas.Last.QtdeParcelas:= fdmt_parcelas.RecordCount;
      TAuthService.lParcelas.Last.Vencimento:= fdmt_parcelasVENCIMENTO.AsDateTime;
      TAuthService.lParcelas.Last.Valor:= fdmt_parcelasVALOR.AsExtended;

      fdmt_parcelas.Next;
    end;
    fdmt_parcelas.EnableControls;
    Close;
  end;
end;

end.
