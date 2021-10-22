unit uformPermissionCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Permission, System.Actions, Vcl.ActnList;

type
  TformPermissionCreateEdit = class(TformBase)
    pnl_body: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    bvl_4: TBevel;
    btn_1: TButton;
    pnl_main: TPanel;
    Button1: TButton;
    lbe_nome: TLabeledEdit;
    lbe_permission: TLabeledEdit;
    acl_permission: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
  private
    { Private declarations }
    Permission: TPermission;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();
  public
    { Public declarations }
  end;

var
  formPermissionCreateEdit: TformPermissionCreateEdit;

implementation

uses
  AuthService, udmRepository, Helper;

{$R *.dfm}

{ TformPermissionCreateEdit }

procedure TformPermissionCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TformPermissionCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  inherited;
  save();
end;

procedure TformPermissionCreateEdit.EdtToObj;
begin
  Permission.Nome:= lbe_nome.Text;
  Permission.Permission:= lbe_permission.Text;
end;

procedure TformPermissionCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  if TAuthService.PermissionId = EmptyStr then Permission:= TPermission.Create
  else Permission:= TPermission.find(TAuthService.PermissionId);
  ObjToEdt;
end;

procedure TformPermissionCreateEdit.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Permission);
end;

procedure TformPermissionCreateEdit.ObjToEdt;
begin
  if Permission.Id = EmptyStr then
  begin
    pnl_header.Caption:= 'NOVA PERMISSÃO';
    Exit();
  end
  else
    pnl_header.Caption:= 'EDITAR PERMISSÃO';
  lbe_nome.Text:= Permission.Nome;
  lbe_permission.Text:= Permission.Permission;
end;

procedure TformPermissionCreateEdit.save;
begin
  EdtToObj;
  if THelper.ValidaCamposObrigatorios(pnl_main) then
  begin
    if Permission.save then
    begin
      TAuthService.PermissionId:= Permission.Id;
      Close;
    end;
  end;
end;

end.
