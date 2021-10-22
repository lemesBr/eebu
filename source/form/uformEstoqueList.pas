unit uformEstoqueList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TformEstoqueList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    btn_estoque_imprimir: TButton;
    btn_estoque_item_movimento: TButton;
    btn_estoque_inventario: TButton;
    acl_estoque: TActionList;
    act_rollback: TAction;
    act_estoque_inventario: TAction;
    act_estoque_item_movimento: TAction;
    act_estoque_imprimir: TAction;
    btn_rollback: TButton;
    pnl_estoque_search: TPanel;
    lbe_estoque_search: TLabeledEdit;
    dbg_estoque: TDBGrid;
    pnl_totais: TPanel;
    bvl_3: TBevel;
    bvl_4: TBevel;
    fdmt_estoque: TFDMemTable;
    ds_estoque: TDataSource;
    tmr_focus: TTimer;
    fdmt_estoqueID: TStringField;
    fdmt_estoqueREFERENCIA: TIntegerField;
    fdmt_estoqueNOME: TStringField;
    fdmt_estoqueUNIDADE: TStringField;
    fdmt_estoquePRECO_COMPRA: TFloatField;
    fdmt_estoquePRECO_VENDA: TFloatField;
    fdmt_estoqueESTOQUE: TFloatField;
    fdmt_estoqueCUSTO_TOTAL: TFloatField;
    lb_qtd_estoque: TLabel;
    lb_custo_estoque: TLabel;
    lb_qtd_itens: TLabel;
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_estoque_inventarioExecute(Sender: TObject);
    procedure act_estoque_item_movimentoExecute(Sender: TObject);
    procedure act_estoque_imprimirExecute(Sender: TObject);
    procedure dbg_estoqueDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure lbe_estoque_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmr_focusTimer(Sender: TObject);
    procedure acl_estoqueUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
    procedure list(search: string);
  public
    { Public declarations }
  end;

var
  formEstoqueList: TformEstoqueList;

implementation

uses
  Item, Helper, udmRepository, uformItemMovimentoList,
  uformItemInventarioCreate, AuthService;

{$R *.dfm}

procedure TformEstoqueList.acl_estoqueUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_estoque_item_movimento.Enabled:= (fdmt_estoque.RecordCount >= 1);
  act_estoque_imprimir.Enabled:= (fdmt_estoque.RecordCount >= 1);
  tmr_focus.Enabled:= (not lbe_estoque_search.Focused);
end;

procedure TformEstoqueList.act_estoque_imprimirExecute(Sender: TObject);
begin
  lbe_estoque_search.SetFocus;
  TItem.imprimirEstoque(Trim(lbe_estoque_search.Text));
end;

procedure TformEstoqueList.act_estoque_inventarioExecute(Sender: TObject);
var
  v_form: TformItemInventarioCreate;
begin
  try
    v_form:= TformItemInventarioCreate.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;
end;

procedure TformEstoqueList.act_estoque_item_movimentoExecute(Sender: TObject);
var
  v_form: TformItemMovimentoList;
begin
  TAuthService.ItemId:= fdmt_estoqueID.AsString;
  try
    v_form:= TformItemMovimentoList.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;
end;

procedure TformEstoqueList.act_rollbackExecute(Sender: TObject);
begin
  Close;
end;

procedure TformEstoqueList.dbg_estoqueDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  If (gdSelected in state) then
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);
end;

procedure TformEstoqueList.lbe_estoque_searchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN: list(Trim(TCustomEdit(Sender).Text));
    38: begin
      fdmt_estoque.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_estoque.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformEstoqueList.list(search: string);
var
  vTotalEstoque,
  vCustoTotal: Extended;
begin
  TItem.listEstoque(search,fdmt_estoque);
  fdmt_estoque.DisableControls;
  fdmt_estoque.First;
  vTotalEstoque:= 0;
  vCustoTotal:= 0;
  while not fdmt_estoque.Eof do
  begin
    if (fdmt_estoqueESTOQUE.AsExtended > 0) then
    begin
      vTotalEstoque:= vTotalEstoque + fdmt_estoqueESTOQUE.AsExtended;
      vCustoTotal:= vCustoTotal + fdmt_estoqueCUSTO_TOTAL.AsExtended;
    end;
    fdmt_estoque.Next;
  end;
  fdmt_estoque.First;
  fdmt_estoque.EnableControls;

  lb_qtd_itens.Caption:= 'Itens: ' + fdmt_estoque.RecordCount.ToString();
  lb_qtd_estoque.Caption:= 'Quantidade total em estoque: ' + THelper.ExtendedToString(vTotalEstoque, False);
  lb_custo_estoque.Caption:= 'Custo total em estoque: ' + THelper.ExtendedToString(vCustoTotal);
end;

procedure TformEstoqueList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_estoque_search.Focused then lbe_estoque_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
