unit uformMensagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, AuthService, System.Actions, Vcl.ActnList;

type
  TformMensagem = class(TformBase)
    pnl_principal: TPanel;
    lbl_sorriso: TLabel;
    lbl_mensagem: TLabel;
    btn_no: TBitBtn;
    btn_yes: TBitBtn;
    acl_mensagem: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    procedure FormShow(Sender: TObject);
    procedure acl_mensagemUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formMensagem: TformMensagem;

implementation

{$R *.dfm}

procedure TformMensagem.acl_mensagemUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_cancelar.Visible:= (TAuthService.TipoMensagem = 1);
end;

procedure TformMensagem.act_cancelarExecute(Sender: TObject);
begin
  Self.Tag:= 0;
  Close;
end;

procedure TformMensagem.act_confirmarExecute(Sender: TObject);
begin
  Self.Tag:= 1;
  Close;
end;

procedure TformMensagem.FormCreate(Sender: TObject);
begin
  inherited;
  Application.ProcessMessages;
end;

procedure TformMensagem.FormShow(Sender: TObject);
begin
  if (TAuthService.TipoMensagem = 1) then
    btn_no.SetFocus
  else
    btn_yes.SetFocus;
end;

end.
