unit uformAuthLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, System.Generics.Collections;

type
  TformAuthLogin = class(TformBase)
    pnl_Logo: TPanel;
    img_email: TImage;
    img_senha: TImage;
    lb_criar_conta: TLabel;
    lbe_senha: TLabeledEdit;
    cbx_email: TComboBox;
    Panel1: TPanel;
    Panel2: TPanel;
    lb_sistema: TLabel;
    Label1: TLabel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label2: TLabel;
    Label3: TLabel;
    procedure lb_criar_contaClick(Sender: TObject);
    procedure lb_criar_contaMouseEnter(Sender: TObject);
    procedure lb_criar_contaMouseLeave(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure cbx_emailSelect(Sender: TObject);
    procedure lbe_senhaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Panel2Click(Sender: TObject);
  private
    { Private declarations }
    procedure Authenticate(email, senha: string);
  public
    { Public declarations }
  end;

var
  formAuthLogin: TformAuthLogin;

implementation

uses
  AuthService, uformUserCreateEdit, Helper, User;

{$R *.dfm}

procedure TformAuthLogin.Authenticate(email, senha: string);
begin
  if not TAuthService.userAuthenticate(email, senha) then
  begin
    THelper.Mensagem('Usuário ou Senha inválido.');
    lbe_senha.Text:= '';
    lbe_senha.SetFocus;
  end
  else
    Close;
end;

procedure TformAuthLogin.cbx_emailSelect(Sender: TObject);
begin
  lbe_senha.Text:= '';
  lbe_senha.SetFocus;
end;

procedure TformAuthLogin.FormCreate(Sender: TObject);
var
  lUser: TObjectList<TUser>;
  I: Integer;
begin
  inherited;
  lUser:= TUser.list();
  cbx_email.Items.Clear;
  if Assigned(lUser) then
  begin
    for I:= 0 to Pred(lUser.Count) do
      cbx_email.Items.Add(lUser.Items[I].Email);

    cbx_email.ItemIndex:= 0;
    lbe_senha.Text:= '';

    FreeAndNil(lUser);
  end;

  lb_criar_conta.Visible:= not (cbx_email.Items.Count >= 1);
end;

procedure TformAuthLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TformAuthLogin.lbe_senhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    13: Panel2Click(Sender);
  end;
end;

procedure TformAuthLogin.lb_criar_contaClick(Sender: TObject);
begin
  try
    formUserCreateEdit:= TformUserCreateEdit.Create(nil);
    formUserCreateEdit.ShowModal;
    if TAuthService.userAuthenticate(TAuthService.UserId) then Close;
  finally
    FreeAndNil(formUserCreateEdit);
  end;
end;

procedure TformAuthLogin.lb_criar_contaMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Style:= [fsUnderline];
end;

procedure TformAuthLogin.lb_criar_contaMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Style:= [];
end;

procedure TformAuthLogin.Panel2Click(Sender: TObject);
begin
  Authenticate(cbx_email.Items[cbx_email.ItemIndex], lbe_senha.Text);
end;

end.
