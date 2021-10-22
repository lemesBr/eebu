unit uformCompraItensAjuste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, System.Actions, Vcl.ActnList, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Compra, System.Math;

type
  TformCompraItensAjuste = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    dbg_itens: TDBGrid;
    fdmt_itens: TFDMemTable;
    ds_itens: TDataSource;
    fdmt_itensITEM_ID: TStringField;
    fdmt_itensREFERENCIA: TIntegerField;
    fdmt_itensNOME: TStringField;
    fdmt_itensUNIDADE: TStringField;
    btn_retornar: TButton;
    btn_prosseguir: TButton;
    acl_ajuste: TActionList;
    act_retornar: TAction;
    act_prosseguir: TAction;
    bvl_3: TBevel;
    pnl_search: TPanel;
    lbe_search: TLabeledEdit;
    pnl_totais: TPanel;
    Bevel1: TBevel;
    lbe_preco_compra: TLabeledEdit;
    fdmt_itensPRECO_COMPRA: TFloatField;
    fdmt_itensPRECO_VENDA: TFloatField;
    fdmt_itensPRECO_ULTIMA_COMPRA: TFloatField;
    fdmt_itensDIFERENCA_PERCENTUAL: TFloatField;
    fdmt_itensDIFERENCA: TFloatField;
    fdmt_itensMARGEM_PERCENTUAL: TFloatField;
    fdmt_itensMARGEM: TFloatField;
    lbe_preco_ultima_compra: TLabeledEdit;
    lbe_diferenca_percentual: TLabeledEdit;
    lbe_diferenca: TLabeledEdit;
    lbe_preco_ultima_compra_01: TLabeledEdit;
    lbe_preco_venda: TLabeledEdit;
    lbe_margem_percentual: TLabeledEdit;
    lbe_margem: TLabeledEdit;
    btn_salvar: TButton;
    act_salvar: TAction;
    procedure FormCreate(Sender: TObject);
    procedure dbg_itensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure act_retornarExecute(Sender: TObject);
    procedure act_prosseguirExecute(Sender: TObject);
    procedure lbe_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure fdmt_itensAfterScroll(DataSet: TDataSet);
    procedure act_salvarExecute(Sender: TObject);
    procedure acl_ajusteUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
    procedure onChange(Sender: TObject);
    procedure onEnter(Sender: TObject);
    procedure onExit(Sender: TObject);
  public
    { Public declarations }
  end;

var
  formCompraItensAjuste: TformCompraItensAjuste;

implementation

uses
  AuthService, udmRepository, CustomEditHelper, Helper, Item,
  uformCompraFinalizar;

{$R *.dfm}

procedure TformCompraItensAjuste.acl_ajusteUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_salvar.Enabled:=
    not (THelper.ExtendedToString(fdmt_itensPRECO_VENDA.AsExtended) = lbe_preco_venda.Text);
end;

procedure TformCompraItensAjuste.act_retornarExecute(Sender: TObject);
begin
  TAuthService.CompraId:= EmptyStr;
  Close();
end;

procedure TformCompraItensAjuste.act_prosseguirExecute(Sender: TObject);
var
  vFM: TformCompraFinalizar;
  vItem: TItem;
begin
  try
    vFM:= TformCompraFinalizar.Create(nil);
    vFM.ShowModal();
  finally
    FreeAndNil(vFM);
  end;

  if (TAuthService.CompraId = EmptyStr) then
    Exit();

  fdmt_itens.DisableControls();
  fdmt_itens.First();
  while not fdmt_itens.Eof do
  begin
    vItem:= TItem.find(fdmt_itensITEM_ID.AsString);
    vItem.PrecoCompra:= fdmt_itensPRECO_ULTIMA_COMPRA.AsExtended;
    vItem.PrecoVenda:= fdmt_itensPRECO_VENDA.AsExtended;
    vItem.save();
    FreeAndNil(vItem);
    fdmt_itens.Next();
  end;
  fdmt_itens.First();
  fdmt_itens.EnableControls();

  Close();
end;

procedure TformCompraItensAjuste.act_salvarExecute(Sender: TObject);
begin
  lbe_search.SetFocus();

  fdmt_itens.Edit();
  fdmt_itensPRECO_VENDA.AsExtended:= THelper.StringToExtended(lbe_preco_venda.Text);
  fdmt_itensMARGEM_PERCENTUAL.AsExtended:= THelper.StringToExtended(lbe_margem_percentual.Text);
  fdmt_itensMARGEM.AsExtended:= THelper.StringToExtended(lbe_margem.Text);
  fdmt_itens.Post();
end;

procedure TformCompraItensAjuste.dbg_itensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  if (fdmt_itensDIFERENCA.AsExtended > 0) then
    TDBGrid(Sender).Canvas.Font.Color:= clRed
  else if (fdmt_itensDIFERENCA.AsExtended < 0) then
    TDBGrid(Sender).Canvas.Font.Color:= clGreen;

  if (gdSelected in State) then
  begin
    TDBGrid(Sender).Canvas.Font.Style:= [fsBold];
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;
  end;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);
end;

procedure TformCompraItensAjuste.fdmt_itensAfterScroll(DataSet: TDataSet);
begin
  lbe_preco_compra.Text:= THelper.ExtendedToString(DataSet.FieldByName('PRECO_COMPRA').AsExtended);
  lbe_preco_ultima_compra.Text:= THelper.ExtendedToString(DataSet.FieldByName('PRECO_ULTIMA_COMPRA').AsExtended);
  lbe_diferenca_percentual.Text:= THelper.ExtendedToString(DataSet.FieldByName('DIFERENCA_PERCENTUAL').AsExtended);
  lbe_diferenca.Text:= THelper.ExtendedToString(DataSet.FieldByName('DIFERENCA').AsExtended);
  lbe_preco_ultima_compra_01.Text:= THelper.ExtendedToString(DataSet.FieldByName('PRECO_ULTIMA_COMPRA').AsExtended);
  lbe_preco_venda.Text:= THelper.ExtendedToString(DataSet.FieldByName('PRECO_VENDA').AsExtended);
  lbe_margem_percentual.Text:= THelper.ExtendedToString(DataSet.FieldByName('MARGEM_PERCENTUAL').AsExtended);
  lbe_margem.Text:= THelper.ExtendedToString(DataSet.FieldByName('MARGEM').AsExtended);
end;

procedure TformCompraItensAjuste.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  inherited;
  TCustomEdit(lbe_preco_compra).EditFloat();
  TCustomEdit(lbe_preco_ultima_compra).EditFloat();
  TCustomEdit(lbe_diferenca_percentual).EditFloat();
  TCustomEdit(lbe_diferenca).EditFloat();
  TCustomEdit(lbe_preco_ultima_compra_01).EditFloat();
  TCustomEdit(lbe_preco_venda).EditFloat();
  TCustomEdit(lbe_margem_percentual).EditFloat();
  TCustomEdit(lbe_margem).EditFloat();

  lbe_preco_venda.OnEnter:= onEnter;
  lbe_preco_venda.OnExit:= onExit;
  lbe_margem_percentual.OnEnter:= onEnter;
  lbe_margem_percentual.OnExit:= onExit;
  lbe_margem.OnEnter:= onEnter;
  lbe_margem.OnExit:= onExit;

  fdmt_itens.Open();
  fdmt_itens.DisableControls();
  for I:= 0 to Pred(TAuthService.Compra.Itens.Count) do
  begin
    fdmt_itens.Append();
    fdmt_itensITEM_ID.AsString:= TAuthService.Compra.Itens.Items[I].ItemId;
    fdmt_itensREFERENCIA.AsInteger:= TAuthService.Compra.Itens.Items[I].Item.Referencia;
    fdmt_itensNOME.AsString:= TAuthService.Compra.Itens.Items[I].Item.Nome;
    fdmt_itensUNIDADE.AsString:= TAuthService.Compra.Itens.Items[I].Item.Unidade.Unidade;
    fdmt_itensPRECO_COMPRA.AsExtended:= TAuthService.Compra.Itens.Items[I].Item.PrecoCompra;
    fdmt_itensPRECO_VENDA.AsExtended:= TAuthService.Compra.Itens.Items[I].Item.PrecoVenda;
    fdmt_itensPRECO_ULTIMA_COMPRA.AsExtended:= TAuthService.Compra.Itens.Items[I].Unitario;
    fdmt_itensDIFERENCA_PERCENTUAL.AsExtended:=
      THelper.TruncateValue(SimpleRoundTo(
        (((fdmt_itensPRECO_ULTIMA_COMPRA.AsExtended - fdmt_itensPRECO_COMPRA.AsExtended) * 100) /
          fdmt_itensPRECO_COMPRA.AsExtended), -6), 2);
    fdmt_itensDIFERENCA.AsExtended:=
      (fdmt_itensPRECO_ULTIMA_COMPRA.AsExtended - fdmt_itensPRECO_COMPRA.AsExtended);
    fdmt_itensMARGEM_PERCENTUAL.AsExtended:=
      THelper.TruncateValue(SimpleRoundTo(
        (((fdmt_itensPRECO_VENDA.AsExtended - fdmt_itensPRECO_ULTIMA_COMPRA.AsExtended) * 100) /
          fdmt_itensPRECO_ULTIMA_COMPRA.AsExtended), -6), 2);
    fdmt_itensMARGEM.AsExtended:=
      (fdmt_itensPRECO_VENDA.AsExtended - fdmt_itensPRECO_ULTIMA_COMPRA.AsExtended);
    fdmt_itens.Post();
  end;
  fdmt_itens.First();
  fdmt_itens.EnableControls();
end;

procedure TformCompraItensAjuste.lbe_searchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    13: begin
      fdmt_itens.Locate('NOME', Trim(lbe_search.Text), [loPartialKey]);
    end;
    38: begin
      fdmt_itens.Prior();
      Key:= 35;
    end;
    40: begin
      fdmt_itens.Next();
      Key:= 35;
    end;
  end;
end;

procedure TformCompraItensAjuste.onChange(Sender: TObject);
var
  vCompra,
  vVenda,
  vPercentual,
  vMargem: Extended;
begin
  if (TLabeledEdit(Sender).Name = 'lbe_preco_venda') then
  begin
    vCompra:= THelper.StringToExtended(lbe_preco_ultima_compra.Text);
    vVenda:= THelper.StringToExtended(lbe_preco_venda.Text);
    vPercentual:= THelper.TruncateValue(SimpleRoundTo(
      (((vVenda - vCompra) * 100) / vCompra)), 2);
    vMargem:= (vVenda - vCompra);
  end
  else if (TLabeledEdit(Sender).Name = 'lbe_margem_percentual') then
  begin
    vCompra:= THelper.StringToExtended(lbe_preco_ultima_compra.Text);
    vPercentual:= THelper.StringToExtended(lbe_margem_percentual.Text);
    vVenda:= THelper.TruncateValue(SimpleRoundTo(
      (vCompra + ((vCompra * vPercentual) / 100))), 2);
    vMargem:= (vVenda - vCompra);
  end
  else if (TLabeledEdit(Sender).Name = 'lbe_margem') then
  begin
    vCompra:= THelper.StringToExtended(lbe_preco_ultima_compra.Text);
    vMargem:= THelper.StringToExtended(lbe_margem.Text);
    vVenda:= (vCompra + vMargem);
    vPercentual:= THelper.TruncateValue(SimpleRoundTo(
      (((vVenda - vCompra) * 100) / vCompra)), 2);
  end;

  lbe_preco_venda.Text:= THelper.ExtendedToString(vVenda);
  lbe_margem_percentual.Text:= THelper.ExtendedToString(vPercentual);
  lbe_margem.Text:= THelper.ExtendedToString(vMargem);
end;

procedure TformCompraItensAjuste.onEnter(Sender: TObject);
begin
  lbe_preco_venda.OnChange:= nil;
  lbe_margem_percentual.OnChange:= nil;
  lbe_margem.OnChange:= nil;
  TLabeledEdit(Sender).OnChange:= onChange;
end;

procedure TformCompraItensAjuste.onExit(Sender: TObject);
begin
  lbe_preco_venda.OnChange:= nil;
  lbe_margem_percentual.OnChange:= nil;
  lbe_margem.OnChange:= nil;
end;

end.
