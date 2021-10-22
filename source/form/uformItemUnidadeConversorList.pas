unit uformItemUnidadeConversorList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, System.Actions, Vcl.ActnList, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Item, AuthService;

type
  TformItemUnidadeConversorList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    pnl_search: TPanel;
    lbe_item: TLabeledEdit;
    bvl_3: TBevel;
    dbg_itens: TDBGrid;
    btn_rollback: TButton;
    btn_item_store: TButton;
    btn_item_update: TButton;
    btn_item_destroy: TButton;
    btn_item_export: TButton;
    fdmt_itens: TFDMemTable;
    fdmt_itensID: TStringField;
    ds_itens: TDataSource;
    tmr_focus: TTimer;
    acl_itens: TActionList;
    act_rollback: TAction;
    act_store: TAction;
    act_update: TAction;
    act_destroy: TAction;
    act_export: TAction;
    fdmt_itensDESCRICAO: TStringField;
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_storeExecute(Sender: TObject);
    procedure act_updateExecute(Sender: TObject);
    procedure act_destroyExecute(Sender: TObject);
    procedure act_exportExecute(Sender: TObject);
    procedure lbe_itemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure acl_itensUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
    Item: TItem;
    procedure list();
  public
    { Public declarations }
  end;

var
  formItemUnidadeConversorList: TformItemUnidadeConversorList;

implementation

{$R *.dfm}

uses udmRepository, uformItemUnidadeConversorCreateEdit,
  UnidadeConversao, uformItemList;

procedure TformItemUnidadeConversorList.acl_itensUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_update.Enabled:= (fdmt_itens.RecordCount >= 1);
  act_destroy.Enabled:= (fdmt_itens.RecordCount >= 1);
  act_export.Visible:= (Self.Tag = 1);
  act_export.Enabled:= (Self.Tag = 1) and (fdmt_itens.RecordCount >= 1);
  tmr_focus.Enabled:= (not lbe_item.Focused);
end;

procedure TformItemUnidadeConversorList.act_destroyExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TformItemUnidadeConversorList.act_exportExecute(Sender: TObject);
begin
  if not (Self.Tag = 1) then Exit();

  TAuthService.UnidadeConversaoId:= fdmt_itensID.AsString;
  Close;
end;

procedure TformItemUnidadeConversorList.act_rollbackExecute(Sender: TObject);
begin
  TAuthService.UnidadeConversaoId:= EmptyStr;
  Close;
end;

procedure TformItemUnidadeConversorList.act_storeExecute(Sender: TObject);
var
  v_form: TformItemUnidadeConversorCreateEdit;
begin
  TAuthService.UnidadeConversaoId:= EmptyStr;
  try
    v_form:= TformItemUnidadeConversorCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.UnidadeConversaoId <> EmptyStr) then
    list();
end;

procedure TformItemUnidadeConversorList.act_updateExecute(Sender: TObject);
var
  v_form: TformItemUnidadeConversorCreateEdit;
begin
  TAuthService.UnidadeConversaoId:= fdmt_itensID.AsString;
  try
    v_form:= TformItemUnidadeConversorCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.UnidadeConversaoId <> EmptyStr) then
    list();
end;

procedure TformItemUnidadeConversorList.FormCreate(Sender: TObject);
begin
  inherited;
  FreeAndNil(Item);
  if (TAuthService.ItemId <> EmptyStr) then
  begin
    Item:= TItem.find(TAuthService.ItemId);
    lbe_item.Text:= Item.Nome;
    list();
  end;
end;

procedure TformItemUnidadeConversorList.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Item);
end;

procedure TformItemUnidadeConversorList.lbe_itemKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  v_form: TformItemList;
begin
  case Key of
    112:begin
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
        lbe_item.Text:= Item.Nome;
        list();
      end;
    end;
  end;
end;

procedure TformItemUnidadeConversorList.list;
begin
  if not Assigned(Item) then Exit();
  TUnidadeConversao.findByItemId(Item.Id, fdmt_itens)
end;

end.
