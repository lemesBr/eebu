unit uformAbrirMovimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Generics.Collections,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList;

type
  TformAbrirMovimento = class(TformBase)
    cbx_turno: TComboBox;
    lbe_suprimento: TLabeledEdit;
    cbx_operador: TComboBox;
    lbe_senha_operador: TLabeledEdit;
    cbx_gerente: TComboBox;
    lbe_senha_gerente: TLabeledEdit;
    acl_movimento: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    lb_turno: TLabel;
    lb_operador: TLabel;
    lb_gerente: TLabel;
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    btn_cancelar: TButton;
    btn_confirmar: TButton;
    btn_sincronizar: TButton;
    act_sincronizar: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure cbx_turnoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure act_sincronizarExecute(Sender: TObject);
  private
    { Private declarations }
    stlTurnos: TStringList;
  public
    { Public declarations }
  end;

var
  formAbrirMovimento: TformAbrirMovimento;

implementation

uses
  Turno, CustomEditHelper, User, AuthService, Movimento, Helper, Suprimento,
  Conexao, udmRepository, uformMovimentoList;

{$R *.dfm}

procedure TformAbrirMovimento.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.Authenticated:= False;
  Close();
end;

procedure TformAbrirMovimento.act_confirmarExecute(Sender: TObject);
var
  vMovimento: TMovimento;
  vUser: TUser;
  vSuprimento: TSuprimento;
  vEmail,
  vPassword: string;
begin
  lbe_senha_gerente.SetFocus();
  try
    TConexao.GetInstance.StartTransaction();
    vMovimento:= TMovimento.Create;
    vSuprimento:= nil;
    try
      vMovimento.TerminalId:= TAuthService.Terminal.Id;
      vMovimento.TurnoId:= stlTurnos[cbx_turno.ItemIndex];

      vEmail:= Trim(cbx_operador.Text);
      vPassword:= Trim(lbe_senha_operador.Text);
      vPassword:= THelper.MD5String(vEmail + vPassword);
      vUser:= TUser.login(vPassword);
      if not Assigned(vUser) then
        raise Exception.Create('Senha do operador inválida.');

      vMovimento.OperadorId:= vUser.Id;
      FreeAndNil(vUser);

      vEmail:= Trim(cbx_gerente.Text);
      vPassword:= Trim(lbe_senha_gerente.Text);
      vPassword:= THelper.MD5String(vEmail + vPassword);
      vUser:= TUser.login(vPassword);
      if not Assigned(vUser) then
        raise Exception.Create('Senha do gerente inválida.');

      vMovimento.GerenteId:= vUser.Id;
      FreeAndNil(vUser);

      vMovimento.Abertura:= Now;
      vMovimento.Suprimento:= THelper.StringToExtended(lbe_suprimento.Text);
      vMovimento.Situacao:= 'A';
      vMovimento.save();

      if (vMovimento.Suprimento > 0) then
      begin
        vSuprimento:= TSuprimento.Create;
        vSuprimento.Valor:= vMovimento.Suprimento;
        vSuprimento.save();
      end;

      TConexao.GetInstance.Commit();

      TAuthService.Authenticated:= True;

      if THelper.Mensagem('Deseja imprimir o comprovante?', 1) then
        TMovimento.imprimirAbertura(vMovimento.Id);

      Close();
    except on e: Exception do
      begin
        TConexao.GetInstance.Rollback();
        THelper.Mensagem(e.Message);
      end;
    end;
  finally
    FreeAndNil(vMovimento);
    if Assigned(vSuprimento) then FreeAndNil(vSuprimento);
  end;
end;

procedure TformAbrirMovimento.act_sincronizarExecute(Sender: TObject);
begin
  cbx_turno.SetFocus();
  try
    formMovimentoList:= TformMovimentoList.Create(nil);
    formMovimentoList.ShowModal();
  finally
    FreeAndNil(formMovimentoList);
  end;
end;

procedure TformAbrirMovimento.cbx_turnoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = 13) then
  begin
    case TWinControl(Sender).TabOrder of
      0: lbe_suprimento.SetFocus();
      1: cbx_operador.SetFocus();
      2: lbe_senha_operador.SetFocus();
      3: cbx_gerente.SetFocus();
      4: lbe_senha_gerente.SetFocus();
      5: act_confirmarExecute(Sender);
    end;
  end;
end;

procedure TformAbrirMovimento.FormCreate(Sender: TObject);
var
  vTurnos: TObjectList<TTurno>;
  vUsers: TObjectList<TUser>;
  I: Integer;
begin
  inherited;
  TAuthService.Authenticated:= False;
  stlTurnos:= TStringList.Create;
  TCustomEdit(lbe_suprimento).EditFloat();

  vTurnos:= TTurno.all();
  if Assigned(vTurnos) then
  begin
    stlTurnos.Clear();
    cbx_turno.Items.Clear();
    for I:= 0 to Pred(vTurnos.Count) do
    begin
      stlTurnos.Add(vTurnos.Items[I].Id);
      cbx_turno.Items.Add(vTurnos.Items[I].Nome);
    end;
    FreeAndNil(vTurnos);
  end;

  vUsers:= TUser.all();
  if Assigned(vUsers) then
  begin
    cbx_operador.Items.Clear();
    cbx_gerente.Items.Clear();
    for I:= 0 to Pred(vUsers.Count) do
    begin
      cbx_operador.Items.Add(vUsers.Items[I].Email);
      cbx_gerente.Items.Add(vUsers.Items[I].Email);
    end;
    FreeAndNil(vUsers);
  end;
end;

procedure TformAbrirMovimento.FormDestroy(Sender: TObject);
begin
  FreeAndNil(stlTurnos);
end;

end.
