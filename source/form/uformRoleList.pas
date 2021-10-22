unit uformRoleList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Vcl.Grids, Vcl.DBGrids, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Actions, Vcl.ActnList, Vcl.Tabs, Role;

type
  TformRoleList = class(TformBase)
    acl_roles: TActionList;
    act_rollback: TAction;
    act_role_store: TAction;
    act_role_update: TAction;
    act_role_export: TAction;
    fdmt_roles: TFDMemTable;
    fdmt_rolesID: TStringField;
    fdmt_rolesNOME: TStringField;
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_head: TPanel;
    tmr_focus: TTimer;
    ds_roles: TDataSource;
    ts_roles: TTabSet;
    ntb_roles: TNotebook;
    pnl_roles_body: TPanel;
    bvl_3: TBevel;
    pnl_roles_footer: TPanel;
    btn_role_export: TButton;
    btn_role_store: TButton;
    btn_role_update: TButton;
    btn_rollback: TButton;
    dbg_roles: TDBGrid;
    pnl_roles_search: TPanel;
    lbe_roles_search: TLabeledEdit;
    bvl_4: TBevel;
    pnl_permissions_footer: TPanel;
    btn_permission_remove: TButton;
    btn_permission_include: TButton;
    dbg_permissions: TDBGrid;
    pnl_permissions_search: TPanel;
    lbe_permissions_search: TLabeledEdit;
    pnl_permissions_body: TPanel;
    act_permission_include: TAction;
    act_permission_remove: TAction;
    ds_permissions: TDataSource;
    fdmt_permissions: TFDMemTable;
    StringField1: TStringField;
    StringField2: TStringField;
    act_role_destroy: TAction;
    Button1: TButton;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_role_exportExecute(Sender: TObject);
    procedure dbg_rolesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure lbe_roles_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure act_role_updateExecute(Sender: TObject);
    procedure act_role_storeExecute(Sender: TObject);
    procedure tmr_focusTimer(Sender: TObject);
    procedure acl_rolesUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure act_permission_includeExecute(Sender: TObject);
    procedure act_permission_removeExecute(Sender: TObject);
    procedure ts_rolesChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure lbe_permissions_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure act_role_destroyExecute(Sender: TObject);
    procedure dbg_rolesDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    var Role: TRole;
    procedure list(search: string);
  end;

var
  formRoleList: TformRoleList;

implementation

uses
  AuthService, uformRoleCreateEdit, uformPermissionList, udmRepository;

{$R *.dfm}

{ TformRoleList }

procedure TformRoleList.acl_rolesUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  ts_roles.Enabled:= (fdmt_roles.RecordCount >= 1);
  if ts_roles.Enabled then ntb_roles.PageIndex:= ts_roles.TabIndex;

  act_role_update.Enabled:= (fdmt_roles.RecordCount >= 1);
  act_role_destroy.Enabled:= (fdmt_roles.RecordCount >= 1);
  act_role_export.Visible:= (Self.Tag = 1);
  tmr_focus.Enabled:= (not lbe_roles_search.Focused) and (ts_roles.TabIndex = 0)
    or (not lbe_permissions_search.Focused) and (ts_roles.TabIndex = 1);
end;

procedure TformRoleList.act_role_updateExecute(Sender: TObject);
begin
  inherited;
  TAuthService.RoleId:= fdmt_rolesID.AsString;
  try
    formRoleCreateEdit:= TformRoleCreateEdit.Create(nil);
    formRoleCreateEdit.ShowModal;
  finally
    FreeAndNil(formRoleCreateEdit);
  end;

  if (TAuthService.RoleId <> EmptyStr) then
    list(Trim(lbe_roles_search.Text));
end;

procedure TformRoleList.act_role_storeExecute(Sender: TObject);
begin
  inherited;
  TAuthService.RoleId:= EmptyStr;
  try
    formRoleCreateEdit:= TformRoleCreateEdit.Create(nil);
    formRoleCreateEdit.ShowModal;
  finally
    FreeAndNil(formRoleCreateEdit);
  end;

  if (TAuthService.RoleId <> EmptyStr) then
    list(Trim(lbe_roles_search.Text));
end;

procedure TformRoleList.act_permission_includeExecute(Sender: TObject);
begin
  inherited;
  TAuthService.PermissionId:= EmptyStr;
  try
    formPermissionList:= TformPermissionList.Create(nil);
    formPermissionList.Tag:= 1;
    formPermissionList.ShowModal;
  finally
    FreeAndNil(formPermissionList);
  end;

  if (TAuthService.PermissionId <> EmptyStr) then
  begin
    if Role.includePermission(TAuthService.PermissionId) then
      Role.listPermissions('',fdmt_permissions);
  end;
end;

procedure TformRoleList.act_permission_removeExecute(Sender: TObject);
begin
  inherited;
  if Role.removePermission(fdmt_permissions.FieldByName('ID').AsString) then
    fdmt_permissions.Delete;
end;

procedure TformRoleList.act_role_destroyExecute(Sender: TObject);
begin
  inherited;
  if (TRole.remove(fdmt_rolesID.AsString)) then
    fdmt_roles.Delete;
end;

procedure TformRoleList.act_role_exportExecute(Sender: TObject);
begin
  inherited;
  TAuthService.RoleId:= fdmt_rolesID.AsString;
  Close;
end;

procedure TformRoleList.act_rollbackExecute(Sender: TObject);
begin
  inherited;
  if ts_roles.TabIndex = 1 then
  begin
    ts_roles.TabIndex:= 0;
    Exit;
  end;
  TAuthService.RoleId:= EmptyStr;
  Close;
end;

procedure TformRoleList.dbg_rolesDblClick(Sender: TObject);
begin
  if not (Self.Tag = 1) then Exit();

  TAuthService.RoleId:= fdmt_rolesID.AsString;
  Close;
end;

procedure TformRoleList.dbg_rolesDrawColumnCell(Sender: TObject;
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

procedure TformRoleList.FormCreate(Sender: TObject);
begin
  inherited;
  ntb_roles.PageIndex:= 0;
  ts_roles.TabIndex:= 0;
  list('');
end;

procedure TformRoleList.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Role);
end;

procedure TformRoleList.lbe_permissions_searchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN: begin
      if (Trim(TCustomEdit(Sender).Text) <> EmptyStr) then
        Role.listPermissions(Trim(TCustomEdit(Sender).Text),fdmt_permissions);
    end;
    38: begin
      fdmt_permissions.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_permissions.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformRoleList.lbe_roles_searchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN: begin
      list(Trim(TCustomEdit(Sender).Text));
    end;
    38: begin
      fdmt_roles.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_roles.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformRoleList.list(search: string);
begin
  TRole.list(search,fdmt_roles);
end;

procedure TformRoleList.tmr_focusTimer(Sender: TObject);
begin
  inherited;
  try
    if not lbe_roles_search.Focused and (ts_roles.TabIndex = 0) then lbe_roles_search.SetFocus
    else if not lbe_permissions_search.Focused and (ts_roles.TabIndex = 1) then lbe_permissions_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

procedure TformRoleList.ts_rolesChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  inherited;
  if (NewTab = 1) then
  begin
    if Assigned(Role) then FreeAndNil(Role);
    Role:= TRole.find(fdmt_rolesID.AsString);
    Role.listPermissions('',fdmt_permissions);
  end;
end;

end.
