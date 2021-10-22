unit uformContaCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Conta, System.Actions, Vcl.ActnList, Vcl.ComCtrls;

type
  TformContaCreateEdit = class(TformBase)
    pnl_body: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_confirmar: TButton;
    pnl_main: TPanel;
    btn_cancelar: TButton;
    lbe_nome: TLabeledEdit;
    lbe_saldo_inicial: TLabeledEdit;
    acl_conta: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    dtp_data_saldo_inicial: TDateTimePicker;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
  private
    { Private declarations }
    Conta: TConta;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();
  public
    { Public declarations }
  end;

var
  formContaCreateEdit: TformContaCreateEdit;

implementation

uses
  AuthService, Helper, CustomEditHelper, udmRepository, System.StrUtils;

{$R *.dfm}

{ TformContaCreateEdit }

procedure TformContaCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.ContaId:= EmptyStr;
  Close;
end;

procedure TformContaCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformContaCreateEdit.EdtToObj;
begin
  Conta.Nome:= lbe_nome.Text;
  Conta.SaldoInicial:= THelper.StringToExtended(lbe_saldo_inicial.Text);
  Conta.DataSaldoInicial:= dtp_data_saldo_inicial.DateTime;
end;

procedure TformContaCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  TCustomEdit(lbe_saldo_inicial).EditFloat();

  if TAuthService.ContaId = EmptyStr then Conta:= TConta.Create
  else Conta:= TConta.find(TAuthService.ContaId);
  ObjToEdt;
end;

procedure TformContaCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Conta);
end;

procedure TformContaCreateEdit.ObjToEdt;
begin
  if Conta.Id = EmptyStr then
  begin
    pnl_header.Caption:= 'NOVA CONTA';
    Exit;
  end
  else
    pnl_header.Caption:= 'EDITAR CONTA';

  lbe_nome.Text:= Conta.Nome;
  lbe_saldo_inicial.Text:= THelper.ExtendedToString(Conta.SaldoInicial);
  if Conta.DataSaldoInicial > StrToDate('01/01/1900') then
    dtp_data_saldo_inicial.DateTime:= Conta.DataSaldoInicial
  else
    dtp_data_saldo_inicial.DateTime:= Now;
end;

procedure TformContaCreateEdit.save;
begin
  EdtToObj;
  try
    if THelper.ValidaCamposObrigatorios(pnl_main) then
    begin
      if Conta.save() then
      begin
        TAuthService.ContaId:= Conta.Id;
        Close;
      end;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

end.
