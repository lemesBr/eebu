unit uformMovimentoAberto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls;

type
  TformMovimentoAberto = class(TformBase)
    lbe_email: TLabeledEdit;
    lbe_senha: TLabeledEdit;
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    acl_movimento: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    btn_cancelar: TButton;
    btn_confirmar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure lbe_senhaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formMovimentoAberto: TformMovimentoAberto;

implementation

uses
  AuthService, Helper, udmRepository;

{$R *.dfm}

procedure TformMovimentoAberto.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.Authenticated:= False;
  Close();
end;

procedure TformMovimentoAberto.act_confirmarExecute(Sender: TObject);
var
  vEmail,
  vPassword: string;
begin
  vEmail:= lbe_email.Text;
  vPassword:= Trim(lbe_senha.Text);
  vPassword:= THelper.MD5String(vEmail + vPassword);

  if (TAuthService.Terminal.Movimento.Operador.Senha = vPassword) then
  begin
    TAuthService.Authenticated:= True;
    Close();
  end
  else
  begin
    lbe_senha.Text:= '';
    lbe_senha.SetFocus();
    THelper.Mensagem('Senha do operador inválida.');
  end;
end;

procedure TformMovimentoAberto.FormCreate(Sender: TObject);
begin
  inherited;
  TAuthService.Authenticated:= False;
  lbe_email.Text:= TAuthService.Terminal.Movimento.Operador.Email;
  lbe_senha.Text:= '';
end;

procedure TformMovimentoAberto.lbe_senhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = 13) then
    act_confirmarExecute(Sender);
end;

end.
