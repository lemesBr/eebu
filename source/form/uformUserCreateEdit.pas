unit uformUserCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  User, System.Actions, Vcl.ActnList, Vcl.Mask;

type
  TformUserCreateEdit = class(TformBase)
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
    lbe_email: TLabeledEdit;
    lbe_senha: TLabeledEdit;
    acl_usuario: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    lbe_confirma_senha: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    User: TUser;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();

    procedure setRequired(Obj: TObject);
    procedure onEnter(Sender: TObject);
    function validaCamposObrigatorios(): Boolean;
  public
    { Public declarations }
  end;

var
  formUserCreateEdit: TformUserCreateEdit;

implementation

uses
  AuthService, udmRepository, Helper;

{$R *.dfm}

{ TformAuthCreate }

procedure TformUserCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  Close();
end;

procedure TformUserCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformUserCreateEdit.EdtToObj;
begin
  User.Nome:= lbe_nome.Text;
  User.Email:= lbe_email.Text;
  User.Senha:= lbe_senha.Text;
end;

procedure TformUserCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  if (TAuthService.UserId = EmptyStr) then User:= TUser.Create
  else User:= TUser.find(TAuthService.UserId);
  ObjToEdt;
end;

procedure TformUserCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(User);
end;

procedure TformUserCreateEdit.ObjToEdt;
begin
  if (User.Id = EmptyStr) then
  begin
    pnl_header.Caption:= 'NOVO USUÁRIO';
    Exit();
  end;

  pnl_header.Caption:= 'EDITAR USUÁRIO';
  lbe_nome.Text:= User.Nome;
  lbe_email.Text:= User.Email;
end;

procedure TformUserCreateEdit.onEnter(Sender: TObject);
begin
  if (Sender is TLabeledEdit) then
  begin
    TLabeledEdit(Sender).Color:= clWhite;
    TLabeledEdit(Sender).OnEnter:= nil;
  end
  else if (Sender is TMaskEdit) then
  begin
    TMaskEdit(Sender).Color:= clWhite;
    TMaskEdit(Sender).OnEnter:= nil;
  end
  else if (Sender is TComboBox) then
  begin
    TComboBox(Sender).Color:= clWhite;
    TComboBox(Sender).OnEnter:= nil;
  end;
end;

procedure TformUserCreateEdit.save;
begin
  EdtToObj;
  try
    if validaCamposObrigatorios() then
    begin
      if User.validate() then
      begin
        if User.save() then
        begin
          TAuthService.UserId:= User.Id;
          Close();
        end;
      end;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformUserCreateEdit.setRequired(Obj: TObject);
begin
  if (Obj is TLabeledEdit) then
  begin
    TLabeledEdit(Obj).Color:= $00AAAAFF;
    TLabeledEdit(Obj).OnEnter:= onEnter;
  end
  else if (Obj is TMaskEdit) then
  begin
    TMaskEdit(Obj).Color:= $00AAAAFF;
    TMaskEdit(Obj).OnEnter:= onEnter;
  end
  else if (Obj is TComboBox) then
  begin
    TComboBox(Obj).Color:= $00AAAAFF;
    TComboBox(Obj).OnEnter:= onEnter;
  end;
end;

function TformUserCreateEdit.validaCamposObrigatorios: Boolean;
var
  vRequired: Integer;
begin
  vRequired:= 0;
  if (Trim(lbe_nome.Text) = '') then
  begin
    setRequired(lbe_nome);
    Inc(vRequired);
  end;

  if (Trim(lbe_email.Text) = '') then
  begin
    setRequired(lbe_email);
    Inc(vRequired);
  end;

  if (Trim(lbe_senha.Text) = '') then
  begin
    setRequired(lbe_senha);
    Inc(vRequired);
  end;

  if (Trim(lbe_confirma_senha.Text) = '')
   or (Trim(lbe_senha.Text) <> Trim(lbe_confirma_senha.Text)) then
  begin
    setRequired(lbe_confirma_senha);
    Inc(vRequired);
  end;

  Result:= (vRequired = 0);
  if (not Result) then  THelper.Mensagem('Preencha os dados obrigatórios do usuário.');
end;

end.
