unit uformUserList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Vcl.Grids, Vcl.DBGrids, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Actions, Vcl.ActnList, Vcl.Tabs, User;

type
  TformUserList = class(TformBase)
    acl_users: TActionList;
    act_rollback: TAction;
    act_user_store: TAction;
    act_user_update: TAction;
    act_user_export: TAction;
    fdmt_users: TFDMemTable;
    fdmt_usersID: TStringField;
    tmr_focus: TTimer;
    ds_users: TDataSource;
    fdmt_usersNOME: TStringField;
    fdmt_usersEMAIL: TStringField;
    pnl_principal: TPanel;
    bvl_1: TBevel;
    pnl_head: TPanel;
    ts_users: TTabSet;
    ntb_users: TNotebook;
    pnl_users_body: TPanel;
    bvl_3: TBevel;
    pnl_users_footer: TPanel;
    btn_user_export: TButton;
    btn_user_store: TButton;
    btn_user_update: TButton;
    btn_rollback: TButton;
    dbg_users: TDBGrid;
    pnl_users_search: TPanel;
    lbe_users_search: TLabeledEdit;
    pnl_roles_body: TPanel;
    bvl_4: TBevel;
    dbg_roles: TDBGrid;
    pnl_roles_footer: TPanel;
    btn_role_remove: TButton;
    btn_role_include: TButton;
    pnl_roles_search: TPanel;
    lbe_roles_search: TLabeledEdit;
    fdmt_roles: TFDMemTable;
    fdmt_rolesID: TStringField;
    fdmt_rolesNOME: TStringField;
    ds_roles: TDataSource;
    act_role_include: TAction;
    act_role_remove: TAction;
    bvl_2: TBevel;
    btn_pessoa_destroy: TButton;
    act_user_destroy: TAction;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure acl_usersUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure act_user_exportExecute(Sender: TObject);
    procedure act_rollbackExecute(Sender: TObject);
    procedure tmr_focusTimer(Sender: TObject);
    procedure act_user_storeExecute(Sender: TObject);
    procedure act_user_updateExecute(Sender: TObject);
    procedure lbe_users_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbg_usersDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure act_role_includeExecute(Sender: TObject);
    procedure act_role_removeExecute(Sender: TObject);
    procedure ts_usersChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure act_user_destroyExecute(Sender: TObject);
    procedure dbg_usersDblClick(Sender: TObject);
  private
    { Private declarations }
    var User: TUser;
    procedure list(search: string);
  public
    { Public declarations }
  end;

var
  formUserList: TformUserList;

implementation

uses
  AuthService, uformUserCreateEdit, uformRoleList, udmRepository;

{$R *.dfm}

{ TformUserList }

procedure TformUserList.acl_usersUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  ts_users.Enabled:= (fdmt_users.RecordCount >= 1);
  if ts_users.Enabled then ntb_users.PageIndex:= ts_users.TabIndex;

  act_user_update.Enabled:= (fdmt_users.RecordCount >=1);
  act_user_destroy.Enabled:= (fdmt_users.RecordCount >=1);
  act_user_export.Visible:= (Self.Tag = 1);
  tmr_focus.Enabled:= (not lbe_users_search.Focused) and (ts_users.TabIndex = 0)
    or (not lbe_roles_search.Focused) and (ts_users.TabIndex = 1);
end;

procedure TformUserList.act_user_updateExecute(Sender: TObject);
begin
  TAuthService.UserId:= fdmt_usersID.AsString;
  try
    formUserCreateEdit:= TformUserCreateEdit.Create(nil);
    formUserCreateEdit.ShowModal;
  finally
    FreeAndNil(formUserCreateEdit);
  end;

  if (TAuthService.UserId <> EmptyStr) then
    list(Trim(lbe_users_search.Text));
end;

procedure TformUserList.dbg_usersDblClick(Sender: TObject);
begin
  if not (Self.Tag = 1) then Exit();

  TAuthService.ItemId:= fdmt_usersID.AsString;
  Close;
end;

procedure TformUserList.dbg_usersDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  If (gdSelected in state) then
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);
end;

procedure TformUserList.act_user_storeExecute(Sender: TObject);
begin
  TAuthService.UserId:= EmptyStr;
  try
    formUserCreateEdit:= TformUserCreateEdit.Create(nil);
    formUserCreateEdit.ShowModal;
  finally
    FreeAndNil(formUserCreateEdit);
  end;

  if (TAuthService.UserId <> EmptyStr) then
    list(Trim(lbe_users_search.Text));
end;

procedure TformUserList.act_user_destroyExecute(Sender: TObject);
begin
  inherited;
  if (TUser.remove(fdmt_usersID.AsString)) then
    fdmt_users.Delete;
end;

procedure TformUserList.act_user_exportExecute(Sender: TObject);
begin
  TAuthService.UserId:= fdmt_usersID.AsString;
  Close;
end;

procedure TformUserList.act_role_includeExecute(Sender: TObject);
begin
  inherited;
  TAuthService.RoleId:= EmptyStr;
  try
    formRoleList:= TformRoleList.Create(nil);
    formRoleList.Tag:= 1;
    formRoleList.ShowModal;
  finally
    FreeAndNil(formRoleList);
  end;

  if (TAuthService.RoleId <> EmptyStr) then
  begin
    if User.includeRole(TAuthService.RoleId) then
      User.listRoles('', fdmt_roles);
  end;
end;

procedure TformUserList.act_role_removeExecute(Sender: TObject);
begin
  inherited;
  if User.removeRole(fdmt_rolesID.AsString) then
    fdmt_roles.Delete;
end;

procedure TformUserList.act_rollbackExecute(Sender: TObject);
begin
  if ts_users.TabIndex = 1 then
  begin
    ts_users.TabIndex:= 0;
    Exit;
  end;
  TAuthService.UserId:= EmptyStr;
  Close;
end;

procedure TformUserList.FormCreate(Sender: TObject);
begin
  inherited;
//  STORE:= TAuthService.getAuthenticatedPermission('USER-STORE');
//  UPDATE:= TAuthService.getAuthenticatedPermission('USER-UPDATE');
  ntb_users.PageIndex:= 0;
  ts_users.TabIndex:= 0;
  list('');
end;

procedure TformUserList.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(User);
end;

procedure TformUserList.lbe_users_searchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN: begin
      list(Trim(TCustomEdit(Sender).Text));
    end;
    38: begin
      fdmt_users.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_users.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformUserList.list(search: string);
begin
  TUser.list(search,fdmt_users);
end;

procedure TformUserList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_users_search.Focused and (ts_users.TabIndex = 0) then lbe_users_search.SetFocus
    else if not lbe_roles_search.Focused and (ts_users.TabIndex = 1) then lbe_roles_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

procedure TformUserList.ts_usersChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  inherited;
  if (NewTab = 1) then
  begin
    if Assigned(User) then FreeAndNil(User);
    User:= TUser.find(fdmt_usersID.AsString);
    User.listRoles('',fdmt_roles);
  end;
end;

end.
