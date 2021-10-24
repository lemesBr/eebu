unit uformItemList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Vcl.Grids, Vcl.DBGrids, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Actions, Vcl.ActnList, Vcl.Mask;

type
  TformItemList = class(TformBase)
    acl_itens: TActionList;
    act_rollback: TAction;
    act_item_store: TAction;
    act_item_update: TAction;
    act_item_export: TAction;
    fdmt_itens: TFDMemTable;
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_itens_head: TPanel;
    pnl_itens_foooter: TPanel;
    btn_item_export: TButton;
    btn_item_store: TButton;
    btn_item_update: TButton;
    btn_rollback: TButton;
    pnl_itens_body: TPanel;
    bvl_3: TBevel;
    pnl_itens_search: TPanel;
    lbe_itens_search: TLabeledEdit;
    dbg_itens: TDBGrid;
    ds_itens: TDataSource;
    fdmt_itensID: TStringField;
    tmr_focus: TTimer;
    act_item_destroy: TAction;
    btn_item_destroy: TButton;
    fdmt_itensREFERENCIA: TIntegerField;
    fdmt_itensEAN: TStringField;
    fdmt_itensNOME: TStringField;
    fdmt_itensPRECO_VENDA: TFloatField;
    fdmt_itensESTOQUE_DISPONIVEL: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure acl_itensUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure act_item_exportExecute(Sender: TObject);
    procedure act_rollbackExecute(Sender: TObject);
    procedure dbg_itensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure lbe_itens_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmr_focusTimer(Sender: TObject);
    procedure act_item_storeExecute(Sender: TObject);
    procedure act_item_updateExecute(Sender: TObject);
    procedure act_item_destroyExecute(Sender: TObject);
  private
    { Private declarations }
    procedure list(search: string);
  public
    { Public declarations }
  end;

var
  formItemList: TformItemList;

implementation

uses
  Item, AuthService, uformItemCreateEdit, udmRepository;

{$R *.dfm}

{ TformItemList }

procedure TformItemList.acl_itensUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_item_update.Enabled:= (fdmt_itens.RecordCount >= 1);
  act_item_destroy.Enabled:= (fdmt_itens.RecordCount >= 1);
  act_item_export.Visible:= (Self.Tag = 1);
  act_item_export.Enabled:= (Self.Tag = 1) and (fdmt_itens.RecordCount >= 1);
  tmr_focus.Enabled:= (not lbe_itens_search.Focused);
end;

procedure TformItemList.act_item_destroyExecute(Sender: TObject);
begin
  if (TItem.remove(fdmt_itensID.AsString)) then
    fdmt_itens.Delete;
end;

procedure TformItemList.act_item_exportExecute(Sender: TObject);
begin
  if not (Self.Tag = 1) then Exit();

  TAuthService.ItemId:= fdmt_itensID.AsString;
  Close;
end;

procedure TformItemList.act_item_storeExecute(Sender: TObject);
var
  v_form: TformItemCreateEdit;
begin
  TAuthService.ItemId:= EmptyStr;
  try
    v_form:= TformItemCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.ItemId <> EmptyStr) then
    list(Trim(lbe_itens_search.Text));
end;

procedure TformItemList.act_item_updateExecute(Sender: TObject);
var
  v_form: TformItemCreateEdit;
begin
  TAuthService.ItemId:= fdmt_itensID.AsString;
  try
    v_form:= TformItemCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.ItemId <> EmptyStr) then
    list(Trim(lbe_itens_search.Text));
end;

procedure TformItemList.act_rollbackExecute(Sender: TObject);
begin
  TAuthService.ItemId:= EmptyStr;
  Close;
end;

procedure  TformItemList.dbg_itensDrawColumnCell(Sender: TObject;
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

procedure TformItemList.FormCreate(Sender: TObject);
begin
  inherited;
  list('');
end;

procedure TformItemList.lbe_itens_searchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: begin
      if (Trim(TCustomEdit(Sender).Text) <> EmptyStr) then
        list(Trim(TCustomEdit(Sender).Text));
    end;
    38: begin
      fdmt_itens.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_itens.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformItemList.list(search: string);
begin
  Titem.list(search, fdmt_itens);
end;

procedure TformItemList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_itens_search.Focused then lbe_itens_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
