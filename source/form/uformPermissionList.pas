unit uformPermissionList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Vcl.Grids, Vcl.DBGrids, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Actions, Vcl.ActnList;

type
  TformPermissionList = class(TformBase)
    acl_permissions: TActionList;
    act_rollback: TAction;
    act_permission_store: TAction;
    act_permission_update: TAction;
    act_permission_export: TAction;
    fdmt_permissions: TFDMemTable;
    fdmt_permissionsID: TStringField;
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_permissions_head: TPanel;
    pnl_permissions_footer: TPanel;
    btn_permission_export: TButton;
    btn_permission_store: TButton;
    btn_permission_update: TButton;
    btn_rollback: TButton;
    pnl_permissions_body: TPanel;
    bvl_3: TBevel;
    pnl_permissions_search: TPanel;
    lbe_permissions_search: TLabeledEdit;
    dbg_permissions: TDBGrid;
    tmr_focus: TTimer;
    ds_permissions: TDataSource;
    fdmt_permissionsNOME: TStringField;
    fdmt_permissionsPERMISSION: TStringField;
    act_permission_destroy: TAction;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure act_rollbackExecute(Sender: TObject);
    procedure acl_permissionsUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure tmr_focusTimer(Sender: TObject);
    procedure lbe_permissions_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure act_permission_exportExecute(Sender: TObject);
    procedure act_permission_storeExecute(Sender: TObject);
    procedure act_permission_updateExecute(Sender: TObject);
    procedure dbg_permissionsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure act_permission_destroyExecute(Sender: TObject);
    procedure dbg_permissionsDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure list(search: string);
  public
    { Public declarations }
  end;

var
  formPermissionList: TformPermissionList;

implementation

uses
  Permission, AuthService, uformPermissionCreateEdit, udmRepository;

{$R *.dfm}

{ TformPermissionList }

procedure TformPermissionList.acl_permissionsUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  act_permission_update.Enabled:= (fdmt_permissions.RecordCount >= 1);
  act_permission_destroy.Enabled:= (fdmt_permissions.RecordCount >= 1);
  act_permission_export.Visible:= (Self.Tag = 1);
  tmr_focus.Enabled:= (not lbe_permissions_search.Focused);
end;

procedure TformPermissionList.act_permission_updateExecute(Sender: TObject);
begin
  inherited;
  TAuthService.PermissionId:= fdmt_permissionsID.AsString;
  try
    formPermissionCreateEdit:= TformPermissionCreateEdit.Create(nil);
    formPermissionCreateEdit.ShowModal;
  finally
    FreeAndNil(formPermissionCreateEdit);
  end;

  if (TAuthService.PermissionId <> EmptyStr) then
    list(Trim(lbe_permissions_search.Text));
end;

procedure TformPermissionList.act_permission_storeExecute(Sender: TObject);
begin
  inherited;
  TAuthService.PermissionId:= EmptyStr;
  try
    formPermissionCreateEdit:= TformPermissionCreateEdit.Create(nil);
    formPermissionCreateEdit.ShowModal;
  finally
    FreeAndNil(formPermissionCreateEdit);
  end;

  if (TAuthService.PermissionId <> EmptyStr) then
    list(Trim(lbe_permissions_search.Text));
end;

procedure TformPermissionList.act_permission_destroyExecute(Sender: TObject);
begin
  inherited;
  if (TPermission.remove(fdmt_permissionsID.AsString)) then
    fdmt_permissions.Delete;
end;

procedure TformPermissionList.act_permission_exportExecute(Sender: TObject);
begin
  inherited;
  TAuthService.PermissionId:= fdmt_permissionsID.AsString;
  Close;
end;

procedure TformPermissionList.act_rollbackExecute(Sender: TObject);
begin
  inherited;
  TAuthService.PermissionId:= EmptyStr;
  Close;
end;

procedure TformPermissionList.dbg_permissionsDblClick(Sender: TObject);
begin
  inherited;
  if not (Self.Tag = 1) then Exit();

  TAuthService.PermissionId:= fdmt_permissionsID.AsString;
  Close;
end;

procedure TformPermissionList.dbg_permissionsDrawColumnCell(Sender: TObject;
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

procedure TformPermissionList.FormCreate(Sender: TObject);
begin
  inherited;
  list('');
end;

procedure TformPermissionList.lbe_permissions_searchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN: begin
      list(Trim(TCustomEdit(Sender).Text));
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

procedure TformPermissionList.list(search: string);
begin
  TPermission.list(search, fdmt_permissions);
end;

procedure TformPermissionList.tmr_focusTimer(Sender: TObject);
begin
  inherited;
  try
    if not lbe_permissions_search.Focused then lbe_permissions_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
