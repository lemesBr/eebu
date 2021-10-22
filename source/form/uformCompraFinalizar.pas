unit uformCompraFinalizar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Vcl.Grids, Vcl.DBGrids, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Compra, System.Math, Conta,
  Categoria;

type
  TformCompraFinalizar = class(TformBase)
    acl_compra_finalizar: TActionList;
    act_retornar: TAction;
    act_confirmar: TAction;
    fdmt_parcelas: TFDMemTable;
    fdmt_parcelasVENCIMENTO: TDateField;
    fdmt_parcelasVALOR: TCurrencyField;
    fdmt_parcelasNUMERO: TIntegerField;
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_confirmar: TButton;
    btn_retornar: TButton;
    pnl_body: TPanel;
    dbg_parcelas: TDBGrid;
    ds_parcelas: TDataSource;
    Panel1: TPanel;
    Bevel2: TBevel;
    cbx_parcelas: TComboBox;
    lb_parcelas: TLabel;
    dtp_vencimento: TDateTimePicker;
    lb_vencimento: TLabel;
    lbe_conta: TLabeledEdit;
    lbe_categoria: TLabeledEdit;
    procedure act_retornarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbx_parcelasSelect(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbe_contaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_categoriaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbg_parcelasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    Conta: TConta;
    Categoria: TCategoria;
    procedure populaCbxParcelas();
  public
    { Public declarations }
  end;

var
  formCompraFinalizar: TformCompraFinalizar;

implementation

uses
  AuthService, Helper, Pagamento, EmpresaConfiguracao, uformContaList,
  uformCategoriaList, Nfe;

{$R *.dfm}

procedure TformCompraFinalizar.act_retornarExecute(Sender: TObject);
begin
  TAuthService.CompraId:= EmptyStr;
  Close();
end;

procedure TformCompraFinalizar.act_confirmarExecute(Sender: TObject);
begin
  if not Assigned(Conta) then
  begin
    lbe_conta.Color:= $00AAAAFF;
    lbe_conta.SetFocus;
    Exit();
  end;

  if not Assigned(Categoria) then
  begin
    lbe_categoria.Color:= $00AAAAFF;
    lbe_categoria.SetFocus;
    Exit();
  end;

  if not THelper.Mensagem('Deseja realmente confirmar?', 1) then Exit();

  try
    TAuthService.Compra.Situacao:= 'F';
    TAuthService.Compra.Acrescimo:= 0;
    TAuthService.Compra.Desconto:= 0;
    TAuthService.Compra.Total:= TAuthService.Compra.Subtotal +
                                TAuthService.Compra.Acrescimo -
                                TAuthService.Compra.Desconto;

    TAuthService.Compra.Pagamentos.Clear;

    if (fdmt_parcelas.RecordCount >= 1) then
    begin
      fdmt_parcelas.DisableControls;
      fdmt_parcelas.First;
      while not fdmt_parcelas.Eof do
      begin
        TAuthService.Compra.Pagamentos.Add(TPagamento.Create);
        TAuthService.Compra.Pagamentos.Last.ContaId:= Conta.Id;
        TAuthService.Compra.Pagamentos.Last.PessoaId:= TAuthService.Compra.PessoaId;
        TAuthService.Compra.Pagamentos.Last.CategoriaId:= Categoria.Id;
        TAuthService.Compra.Pagamentos.Last.Descricao:= fdmt_parcelasNUMERO.AsString + '/' +
          fdmt_parcelas.RecordCount.ToString() + ' - COMPRA ' + TAuthService.Compra.Referencia.ToString();
        TAuthService.Compra.Pagamentos.Last.Competencia:= TAuthService.Compra.Competencia;
        TAuthService.Compra.Pagamentos.Last.Valor:= fdmt_parcelasVALOR.AsExtended;
        TAuthService.Compra.Pagamentos.Last.Vencimento:= fdmt_parcelasVENCIMENTO.AsDateTime;
        TAuthService.Compra.Pagamentos.Last.Situacao:= 'A';

        fdmt_parcelas.Next;
      end;
      fdmt_parcelas.First;
      fdmt_parcelas.EnableControls;
    end
    else
    begin
      case cbx_parcelas.ItemIndex of
        0: begin
          TAuthService.Compra.Pagamentos.Add(TPagamento.Create);
          TAuthService.Compra.Pagamentos.Last.ContaId:= Conta.Id;
          TAuthService.Compra.Pagamentos.Last.PessoaId:= TAuthService.Compra.PessoaId;
          TAuthService.Compra.Pagamentos.Last.CategoriaId:= Categoria.Id;
          TAuthService.Compra.Pagamentos.Last.Descricao:= '1/1 - COMPRA ' + TAuthService.Compra.Referencia.ToString();
          TAuthService.Compra.Pagamentos.Last.Competencia:= TAuthService.Compra.Competencia;
          TAuthService.Compra.Pagamentos.Last.Valor:= TAuthService.Compra.Total;
          TAuthService.Compra.Pagamentos.Last.DescontosTaxas:= 0;
          TAuthService.Compra.Pagamentos.Last.JurosMulta:= 0;
          TAuthService.Compra.Pagamentos.Last.ValorPago:= TAuthService.Compra.Total;
          TAuthService.Compra.Pagamentos.Last.Vencimento:= dtp_vencimento.Date;
          TAuthService.Compra.Pagamentos.Last.Pagamento:= dtp_vencimento.Date;
          TAuthService.Compra.Pagamentos.Last.Situacao:= 'F';
        end;
        1: begin
          TAuthService.Compra.Pagamentos.Add(TPagamento.Create);
          TAuthService.Compra.Pagamentos.Last.ContaId:= Conta.Id;
          TAuthService.Compra.Pagamentos.Last.PessoaId:= TAuthService.Compra.PessoaId;
          TAuthService.Compra.Pagamentos.Last.CategoriaId:= Categoria.Id;
          TAuthService.Compra.Pagamentos.Last.Descricao:= '1/1 - COMPRA ' + TAuthService.Compra.Referencia.ToString();
          TAuthService.Compra.Pagamentos.Last.Competencia:= TAuthService.Compra.Competencia;
          TAuthService.Compra.Pagamentos.Last.Valor:= TAuthService.Compra.Total;
          TAuthService.Compra.Pagamentos.Last.Vencimento:= dtp_vencimento.Date;
          TAuthService.Compra.Pagamentos.Last.Situacao:= 'A';
        end;
      end;
    end;

    if TAuthService.Compra.save() then
    begin
      TAuthService.CompraId:= TAuthService.Compra.Id;
      Close();
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformCompraFinalizar.cbx_parcelasSelect(Sender: TObject);
var
  I: Integer;
  vDataParcela: TDate;
  vQuantidadeParcelas: Integer;
  vParcela,
  vTotalParcelas: Extended;
begin
  fdmt_parcelas.Open();
  fdmt_parcelas.DisableControls;
  fdmt_parcelas.EmptyDataSet;
  if (cbx_parcelas.ItemIndex >= 2) then
  begin
    vDataParcela:= dtp_vencimento.Date;
    vQuantidadeParcelas:= cbx_parcelas.ItemIndex;
    vParcela:= THelper.TruncateValue(SimpleRoundTo((TAuthService.Compra.Subtotal / vQuantidadeParcelas), -2), 2);
    vTotalParcelas:= 0;

    for I:= 1 to cbx_parcelas.ItemIndex do
    begin
      vTotalParcelas:= (vTotalParcelas + vParcela);
      fdmt_parcelas.Append();
      fdmt_parcelasNUMERO.AsInteger:= I;
      fdmt_parcelasVENCIMENTO.AsDateTime:= vDataParcela;
      fdmt_parcelasVALOR.AsExtended:= vParcela;
      if (I = vQuantidadeParcelas) then
        fdmt_parcelasVALOR.AsExtended:= vParcela + (TAuthService.Compra.Subtotal - vTotalParcelas);
      fdmt_parcelas.Post();

      vDataParcela:= IncMonth(vDataParcela);
    end;
  end;
  fdmt_parcelas.EnableControls;
end;

procedure TformCompraFinalizar.dbg_parcelasDrawColumnCell(Sender: TObject;
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

procedure TformCompraFinalizar.FormCreate(Sender: TObject);
var
  vNfe: TNfe;
  I: Integer;
begin
  inherited;
  dtp_vencimento.Date:= Now();
  populaCbxParcelas();

  pnl_header.Caption:= 'TOTAL DA COMPRA: ' +
                       THelper.ExtendedToString(TAuthService.Compra.Subtotal);

  if not (TAuthService.Compra.NfeId = '') then
  begin
    vNfe:= TNfe.find(TAuthService.Compra.NfeId);
    if Assigned(vNfe) then
    begin
      if (vNfe.Dup.Count >= 1) then
      begin
        dtp_vencimento.Date:= vNfe.Dup.First.Dvenc;
        cbx_parcelas.ItemIndex:= vNfe.Dup.Count;
        if (vNfe.Dup.Count >= 2) then
        begin
          fdmt_parcelas.Open();
          fdmt_parcelas.DisableControls();
          fdmt_parcelas.EmptyDataSet();
          for I:= 0 to Pred(vNfe.Dup.Count) do
          begin
            fdmt_parcelas.Append();
            fdmt_parcelasNUMERO.AsInteger:= (I + 1);
            fdmt_parcelasVENCIMENTO.AsDateTime:= vNfe.Dup.Items[I].Dvenc;
            fdmt_parcelasVALOR.AsExtended:= vNfe.Dup.Items[I].Vdup;
            fdmt_parcelas.Post();
          end;
          fdmt_parcelas.EnableControls();
        end;
      end;
      FreeAndNil(vNfe);
    end;
  end;
end;

procedure TformCompraFinalizar.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Conta);
  FreeAndNil(Categoria);
end;

procedure TformCompraFinalizar.lbe_categoriaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  vFM: TformCategoriaList;
begin
  case Key of
    112: begin
      TAuthService.CategoriaId:= EmptyStr;
      TAuthService.TipoCategoria:= 'D';
      try
        vFM:= TformCategoriaList.Create(nil);
        vFM.Tag:= 1;
        vFM.ShowModal;
      finally
        FreeAndNil(vFM);
      end;

      if (TAuthService.CategoriaId <> EmptyStr) then
      begin
        FreeAndNil(Categoria);
        Categoria:= TCategoria.find(TAuthService.CategoriaId);
        lbe_categoria.Text:= Categoria.Nome;
        lbe_categoria.Color:= clWindow;
      end;
    end;
  end;
end;

procedure TformCompraFinalizar.lbe_contaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  vFM: TformContaList;
begin
  case Key of
    112: begin
      TAuthService.ContaId:= EmptyStr;
      try
        vFM:= TformContaList.Create(nil);
        vFM.Tag:= 1;
        vFM.ShowModal;
      finally
        FreeAndNil(vFM);
      end;

      if (TAuthService.ContaId <> EmptyStr) then
      begin
        FreeAndNil(Conta);
        Conta:= TConta.find(TAuthService.ContaId);
        lbe_conta.Text:= Conta.Nome;
        lbe_conta.Color:= clWindow;
      end;
    end;
  end;
end;

procedure TformCompraFinalizar.populaCbxParcelas;
var
  I: Integer;
begin
  cbx_parcelas.Items.Clear;
  cbx_parcelas.Items.Add('Á vista');
  for I:= 1 to 48 do
  begin
    cbx_parcelas.Items.Add(I.ToString() +  'x');
  end;
  cbx_parcelas.ItemIndex:= 0;
end;

end.
