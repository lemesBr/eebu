unit uformRoleCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Role, System.Actions, Vcl.ActnList;

type
  TformRoleCreateEdit = class(TformBase)
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
    acl_role: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
  private
    { Private declarations }
    Role: TRole;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();
  public
    { Public declarations }
  end;

var
  formRoleCreateEdit: TformRoleCreateEdit;

implementation

uses
  AuthService, udmRepository, Helper;

{$R *.dfm}

{ TformRoleCreateEdit }

procedure TformRoleCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TformRoleCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  inherited;
  save();
end;

procedure TformRoleCreateEdit.EdtToObj;
begin
  Role.Nome:= lbe_nome.Text;
end;

procedure TformRoleCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  if TAuthService.RoleId = EmptyStr then Role:= TRole.Create
  else Role:= TRole.find(TAuthService.RoleId);
  ObjToEdt;
end;

procedure TformRoleCreateEdit.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Role);
end;

procedure TformRoleCreateEdit.ObjToEdt;
begin
  if Role.Id = EmptyStr then
  begin
    pnl_header.Caption:= 'NOVO PAPÉU';
    Exit();
  end
  else
    pnl_header.Caption:= 'EDITAR PAPÉU';
  lbe_nome.Text:= Role.Nome;
end;

procedure TformRoleCreateEdit.save;
begin
  EdtToObj;
  if THelper.ValidaCamposObrigatorios(pnl_main) then
  begin
    if Role.save() then
    begin
      TAuthService.RoleId:= Role.Id;
      Close;
    end;
  end;
end;

end.
