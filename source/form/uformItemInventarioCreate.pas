unit uformItemInventarioCreate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Actions, Vcl.ActnList, User, Item;

type
  TformItemInventarioCreate = class(TformBase)
    acl_inventario: TActionList;
    act_remover_item: TAction;
    act_cancelar: TAction;
    act_confirmar: TAction;
    fdmt_itens: TFDMemTable;
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_confirmar: TButton;
    btn_cancelar: TButton;
    btn_remover_item: TButton;
    pnl_body: TPanel;
    bvl_3: TBevel;
    Bevel2: TBevel;
    pnl_categorias_search: TPanel;
    lbe_user: TLabeledEdit;
    dbg_itens: TDBGrid;
    Panel2: TPanel;
    lbe_item: TLabeledEdit;
    edt_item_nome: TEdit;
    lbe_item_preco: TLabeledEdit;
    lbe_estoque_informado: TLabeledEdit;
    lbe_diferenca: TLabeledEdit;
    ds_itens: TDataSource;
    lbe_item_unidade: TLabeledEdit;
    lbe_estoque_atual: TLabeledEdit;
    lbe_competencia: TLabeledEdit;
    fdmt_itensITEM_ID: TStringField;
    fdmt_itensITEM_REFERENCIA: TIntegerField;
    fdmt_itensITEM_NOME: TStringField;
    fdmt_itensUNIDADE_ID: TStringField;
    fdmt_itensUNIDADE: TStringField;
    fdmt_itensPRECO_COMPRA: TFloatField;
    fdmt_itensESTOQUE_ATUAL: TFloatField;
    fdmt_itensESTOQUE_INFORMADO: TFloatField;
    fdmt_itensDIFERENCA: TFloatField;
    fdmt_itensTIPO: TIntegerField;
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_remover_itemExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbg_itensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure lbe_itemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_item_unidadeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_item_precoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_estoque_informadoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure acl_inventarioUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
    User: TUser;
    Item: TItem;
    vTipo: Integer;
    procedure setItem(vtype: Integer = 0);
    procedure cleanItem();
    procedure findItem;
    procedure onChance(Sender: TObject);
    procedure itemConfirmar();
  public
    { Public declarations }
  end;

var
  formItemInventarioCreate: TformItemInventarioCreate;

implementation

{$R *.dfm}

uses CustomEditHelper, AuthService, udmRepository, Helper, uformItemList,
  uformUnidadeList, ItemInventario;

procedure TformItemInventarioCreate.acl_inventarioUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_remover_item.Enabled:= (fdmt_itens.RecordCount >= 1);
  act_confirmar.Enabled:= (fdmt_itens.RecordCount >= 1);
end;

procedure TformItemInventarioCreate.act_cancelarExecute(Sender: TObject);
begin
  if (fdmt_itens.RecordCount = 0) or THelper.Mensagem('Deseja realmente cancelar?', 1) then
    Close;
end;

procedure TformItemInventarioCreate.act_confirmarExecute(Sender: TObject);
var
  vItem: TItemInventario;
begin
  if not THelper.Mensagem('Deseja realmente confirmar?', 1) then Exit();

  fdmt_itens.DisableControls;
  fdmt_itens.First;
  while not fdmt_itens.Eof do
  begin
    try
      vItem:= TItemInventario.Create;
      try
        vItem.UserId:= User.Id;
        vItem.ItemId:= fdmt_itensITEM_ID.AsString;
        vItem.UnidadeId:= fdmt_itensUNIDADE_ID.AsString;
        vItem.Competencia:= Now;
        vItem.PrecoCompra:= fdmt_itensPRECO_COMPRA.AsExtended;
        vItem.EstoqueAtual:= fdmt_itensESTOQUE_ATUAL.AsExtended;
        vItem.EstoqueInformado:= fdmt_itensESTOQUE_INFORMADO.AsExtended;
        vItem.Diferenca:= fdmt_itensDIFERENCA.AsExtended;
        vItem.Tipo:= fdmt_itensTIPO.AsInteger;
        if vItem.save() then
          fdmt_itens.Delete
        else
          fdmt_itens.Next;
      except on e: Exception do
        begin
          THelper.Mensagem(e.Message);
          fdmt_itens.Next;
        end;
      end;
    finally
      FreeAndNil(vItem);
    end;
  end;
  fdmt_itens.EnableControls;
  cleanItem();
end;

procedure TformItemInventarioCreate.act_remover_itemExecute(Sender: TObject);
begin
  lbe_item.SetFocus;
  if THelper.Mensagem('Deseja realmente remover o item selecionado?', 1) then
    fdmt_itens.Delete;
end;

procedure TformItemInventarioCreate.cleanItem;
begin
  lbe_item.Text:= EmptyStr;
  edt_item_nome.Text:= EmptyStr;
  lbe_item_unidade.Text:= EmptyStr;
  lbe_item_preco.Text:= '0,00';
  lbe_item_preco.ReadOnly:= True;
  lbe_estoque_atual.Text:= '0,000';
  lbe_estoque_informado.Text:= '0,000';
  lbe_estoque_informado.ReadOnly:= True;
  lbe_diferenca.Text:= '0,00';
  FreeAndNil(Item);
  lbe_item.SetFocus;
end;

procedure TformItemInventarioCreate.dbg_itensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  If (gdSelected in state) then
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);

  if not fdmt_itens.IsEmpty then
  begin
    if Column.FieldName = 'TIPO' then
    begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      if (fdmt_itensTIPO.AsInteger >= 1) then
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 7, Rect.Top + 1, 7)
      else
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 7, Rect.Top + 1, 6);
    end;
  end;
end;

procedure TformItemInventarioCreate.findItem;
var
  v_form: TformItemList;
begin
  TAuthService.ItemId:= EmptyStr;
  try
    v_form:= TformItemList.Create(nil);
    v_form.Tag:= 1;
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.ItemId <> EmptyStr) then
  begin
    if Assigned(Item) then FreeAndNil(Item);
    Item:= TItem.find(TAuthService.ItemId);
    setItem;
  end;
end;

procedure TformItemInventarioCreate.FormCreate(Sender: TObject);
begin
  inherited;
  TCustomEdit(lbe_item_preco).EditFloat();
  lbe_estoque_atual.Tag:= 1;
  TCustomEdit(lbe_estoque_atual).EditFloat();
  lbe_estoque_informado.Tag:= 1;
  lbe_estoque_informado.OnChange:= onChance;
  TCustomEdit(lbe_estoque_informado).EditFloat();
  lbe_diferenca.Tag:= 1;
  TCustomEdit(lbe_diferenca).EditFloat();
  fdmt_itens.Open;

  User:= TUser.find(TAuthService.getAuthenticatedUserId);
  lbe_user.Text:= User.Nome;
  lbe_competencia.Text:= DateToStr(Now);
end;

procedure TformItemInventarioCreate.FormDestroy(Sender: TObject);
begin
  FreeAndNil(User);
  FreeAndNil(Item);
end;

procedure TformItemInventarioCreate.itemConfirmar;
begin
  if not Assigned(Item) then
  begin
    cleanItem;
    Exit();
  end;

  if (THelper.StringToExtended(lbe_diferenca.Text) <= 0) then Exit;

  if fdmt_itens.Locate('ITEM_ID',Item.Id,[]) then
  begin
    fdmt_itens.Edit;
    fdmt_itensITEM_ID.AsString:= Item.Id;
    fdmt_itensITEM_REFERENCIA.AsInteger:= Item.Referencia;
    fdmt_itensITEM_NOME.AsString:= Item.Nome;
    fdmt_itensUNIDADE_ID.AsString:= Item.Unidade.Id;
    fdmt_itensUNIDADE.AsString:= Item.Unidade.Unidade;
    fdmt_itensPRECO_COMPRA.AsExtended:= THelper.StringToExtended(lbe_item_preco.Text);
    fdmt_itensESTOQUE_ATUAL.AsExtended:= THelper.StringToExtended(lbe_estoque_atual.Text);
    fdmt_itensESTOQUE_INFORMADO.AsExtended:= THelper.StringToExtended(lbe_estoque_informado.Text);
    fdmt_itensDIFERENCA.AsExtended:= THelper.StringToExtended(lbe_diferenca.Text);
    fdmt_itensTIPO.AsInteger:= vTipo;
    fdmt_itens.Post;
  end
  else
  begin
    fdmt_itens.Append;
    fdmt_itensITEM_ID.AsString:= Item.Id;
    fdmt_itensITEM_REFERENCIA.AsInteger:= Item.Referencia;
    fdmt_itensITEM_NOME.AsString:= Item.Nome;
    fdmt_itensUNIDADE_ID.AsString:= Item.Unidade.Id;
    fdmt_itensUNIDADE.AsString:= Item.Unidade.Unidade;
    fdmt_itensPRECO_COMPRA.AsExtended:= THelper.StringToExtended(lbe_item_preco.Text);
    fdmt_itensESTOQUE_ATUAL.AsExtended:= THelper.StringToExtended(lbe_estoque_atual.Text);
    fdmt_itensESTOQUE_INFORMADO.AsExtended:= THelper.StringToExtended(lbe_estoque_informado.Text);
    fdmt_itensDIFERENCA.AsExtended:= THelper.StringToExtended(lbe_diferenca.Text);
    fdmt_itensTIPO.AsInteger:= vTipo;
    fdmt_itens.Post;
  end;
  cleanItem;
end;

procedure TformItemInventarioCreate.lbe_estoque_informadoKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) then  itemConfirmar();
end;

procedure TformItemInventarioCreate.lbe_itemKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    13: begin
      TCustomEdit(Sender).Text:= Trim(TCustomEdit(Sender).Text);
      if (fdmt_itens.RecordCount >= 1) and (TCustomEdit(Sender).Text = EmptyStr) then
      begin
        act_confirmarExecute(Sender);
        Exit();
      end
      else if (TCustomEdit(Sender).Text = EmptyStr) then Exit();
      if Assigned(Item) then FreeAndNil(Item);
      Item:= TItem.findByReferencia(StrToIntDef(TCustomEdit(Sender).Text, 0));
      if Assigned(Item) then
      begin
        setItem;
        Exit();
      end;
      Item:= TItem.findByEan(TCustomEdit(Sender).Text);
      if Assigned(Item) then
      begin
        setItem(1);
        Exit();
      end;
      findItem;
    end;
    27: cleanItem;
    38: begin
      fdmt_itens.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_itens.Next;
      Key:= 35;
    end;
    112: findItem;
  end;
end;

procedure TformItemInventarioCreate.lbe_item_precoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if not Assigned(Item) then
  begin
    lbe_item.SetFocus;
    Exit();
  end;

  if (Key = VK_RETURN) then lbe_estoque_informado.SetFocus;
end;

procedure TformItemInventarioCreate.lbe_item_unidadeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  v_form: TformUnidadeList;
begin
  if not Assigned(Item) then
  begin
    lbe_item.SetFocus;
    Exit();
  end;

  case Key of
    13: lbe_item_preco.SetFocus;
    112: begin
      TAuthService.UnidadeId:= EmptyStr;
      try
        v_form:= TformUnidadeList.Create(nil);
        v_form.Tag:= 1;
        v_form.ShowModal;
      finally
        FreeAndNil(v_form);
      end;

      if (TAuthService.UnidadeId <> EmptyStr) then
      begin
        Item.UnidadeId:= TAuthService.UnidadeId;
        lbe_item_unidade.Text:= Item.Unidade.Unidade;
        lbe_item_preco.SetFocus;
      end;
    end;
  end;
end;

procedure TformItemInventarioCreate.onChance(Sender: TObject);
begin
  if not Assigned(Item) then Exit();
  if THelper.StringToExtended(lbe_estoque_atual.Text) >=
    THelper.StringToExtended(lbe_estoque_informado.Text) then
  begin
    lbe_diferenca.Text:=
      THelper.ExtendedToString(THelper.StringToExtended(lbe_estoque_atual.Text) -
        THelper.StringToExtended(lbe_estoque_informado.Text));

    vTipo:= 0;
  end
  else
  begin
    lbe_diferenca.Text:=
      THelper.ExtendedToString(THelper.StringToExtended(lbe_estoque_informado.Text) -
        THelper.StringToExtended(lbe_estoque_atual.Text));

    vTipo:= 1;
  end;
end;

procedure TformItemInventarioCreate.setItem(vtype: Integer);
begin
  case vtype of
    0,
    1: begin
      lbe_item.Text:= Item.Referencia.ToString();
      edt_item_nome.Text:= Item.Nome;
      lbe_item_unidade.Text:= Item.Unidade.Unidade;
      lbe_item_preco.Text:= THelper.ExtendedToString(Item.PrecoCompra);
      lbe_item_preco.ReadOnly:= False;
      lbe_estoque_atual.Text:= THelper.ExtendedToString(Item.estoque, False);
      lbe_estoque_informado.Text:= '0,000';
      lbe_estoque_informado.ReadOnly:= False;
      lbe_diferenca.Text:= '0,000';

      lbe_item_unidade.SetFocus;
    end;
  end;
end;

end.
