unit uformBalancaConfiguracaoCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, ACBrBAL, System.TypInfo, ACBrDevice,
  BalancaConfiguracao, System.Math, System.StrUtils;

type
  TformBalancaConfiguracaoCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_confirmar: TButton;
    btn_cancelar: TButton;
    pnl_body: TPanel;
    acl_config: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    cbx_modelo: TComboBox;
    cbx_handshake: TComboBox;
    cbx_parity: TComboBox;
    cbx_stop: TComboBox;
    cbx_data: TComboBox;
    cbx_baud: TComboBox;
    cbx_porta: TComboBox;
    lb_modelo: TLabel;
    lb_handshake: TLabel;
    lb_parity: TLabel;
    lb_stop: TLabel;
    lb_data: TLabel;
    lb_baud: TLabel;
    lb_porta: TLabel;
    lbe_time_out: TLabeledEdit;
    lbe_digito_inicial: TLabeledEdit;
    lbe_digitos: TLabeledEdit;
    lbe_produto_digito_inicial: TLabeledEdit;
    lbe_produto_digito_final: TLabeledEdit;
    lbe_peso_digito_inicial: TLabeledEdit;
    lbe_peso_digito_final: TLabeledEdit;
    lbe_peso_digitos_decimal: TLabeledEdit;
    Bevel1: TBevel;
    cbx_peso: TComboBox;
    lb_peso: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    BalancaConfiguracao: TBalancaConfiguracao;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();
  public
    { Public declarations }
  end;

var
  formBalancaConfiguracaoCreateEdit: TformBalancaConfiguracaoCreateEdit;

implementation

{$R *.dfm}

uses udmRepository, Helper;

procedure TformBalancaConfiguracaoCreateEdit.act_cancelarExecute(
  Sender: TObject);
begin
  Close();
end;

procedure TformBalancaConfiguracaoCreateEdit.act_confirmarExecute(
  Sender: TObject);
begin
  save();
end;

procedure TformBalancaConfiguracaoCreateEdit.EdtToObj;
begin
  BalancaConfiguracao.Modelo:= cbx_modelo.ItemIndex;
  BalancaConfiguracao.Handshake:= cbx_handshake.ItemIndex;
  BalancaConfiguracao.Parity:= cbx_parity.ItemIndex;
  BalancaConfiguracao.Stop:= cbx_stop.ItemIndex;
  BalancaConfiguracao.Data:= StrToIntDef(cbx_data.Text, 8);
  BalancaConfiguracao.baud:= StrToIntDef(cbx_baud.Text, 8);
  BalancaConfiguracao.porta:= cbx_porta.Text;
  BalancaConfiguracao.Peso:= 'N';
  BalancaConfiguracao.TimeOut:= StrToIntDef(lbe_time_out.Text, 2000);
  BalancaConfiguracao.Digitos:= StrToIntDef(lbe_digitos.Text, 13);
  BalancaConfiguracao.DigitoInicial:= StrToIntDef(lbe_digito_inicial.Text, 2);
  BalancaConfiguracao.ProdutoDigitoInicial:= StrToIntDef(lbe_produto_digito_inicial.Text, 2);
  BalancaConfiguracao.ProdutoDigitoFinal:= StrToIntDef(lbe_produto_digito_final.Text, 6);
  BalancaConfiguracao.PesoDigitoInicial:= StrToIntDef(lbe_peso_digito_inicial.Text, 7);
  BalancaConfiguracao.PesoDigitoFinal:= StrToIntDef(lbe_peso_digito_final.Text, 13);
  BalancaConfiguracao.PesoDigitosDecimal:= StrToIntDef(lbe_peso_digitos_decimal.Text, 3);
  BalancaConfiguracao.Peso:= IfThen(cbx_peso.ItemIndex = 0, 'S', 'N');
end;

procedure TformBalancaConfiguracaoCreateEdit.FormCreate(Sender: TObject);
var
  vModelo: TACBrBALModelo;
  vHandshake: TACBrHandShake;
  vParity: TACBrSerialParity;
  vStop: TACBrSerialStop;
begin
  inherited;
  cbx_modelo.Items.Clear;
  for vModelo:= Low(TACBrBALModelo) to High(TACBrBALModelo) do
    cbx_modelo.Items.Add(GetEnumName(TypeInfo(TACBrBALModelo), integer(vModelo)));
  cbx_modelo.ItemIndex:= 0;

  cbx_handshake.Items.Clear;
  for vHandshake:= Low(TACBrHandShake) to High(TACBrHandShake) do
    cbx_handshake.Items.Add(GetEnumName(TypeInfo(TACBrHandShake), integer(vHandshake)));
  cbx_handshake.ItemIndex:= 0;

  cbx_parity.Items.Clear;
  for vParity:= Low(TACBrSerialParity) to High(TACBrSerialParity) do
    cbx_parity.Items.Add(GetEnumName(TypeInfo(TACBrSerialParity), integer(vParity)));
  cbx_parity.ItemIndex:= 0;

  cbx_stop.Items.Clear;
  for vStop:= Low(TACBrSerialStop) to High(TACBrSerialStop) do
    cbx_stop.Items.Add(GetEnumName(TypeInfo(TACBrSerialStop), integer(vStop)));
  cbx_stop.ItemIndex:= 0;

  BalancaConfiguracao:= TBalancaConfiguracao.find();
  if not Assigned(BalancaConfiguracao) then
    BalancaConfiguracao:= TBalancaConfiguracao.Create();
  ObjToEdt();
end;

procedure TformBalancaConfiguracaoCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(BalancaConfiguracao);
end;

procedure TformBalancaConfiguracaoCreateEdit.ObjToEdt;
begin
  if (BalancaConfiguracao.Id = '') then Exit();

  cbx_modelo.ItemIndex:= BalancaConfiguracao.Modelo;
  cbx_handshake.ItemIndex:= BalancaConfiguracao.Handshake;
  cbx_parity.ItemIndex:= BalancaConfiguracao.Parity;
  cbx_stop.ItemIndex:= BalancaConfiguracao.Stop;
  cbx_data.ItemIndex:= cbx_data.Items.IndexOf(BalancaConfiguracao.Data.ToString());
  cbx_baud.ItemIndex:= cbx_baud.Items.IndexOf(BalancaConfiguracao.baud.ToString());
  cbx_porta.ItemIndex:= cbx_porta.Items.IndexOf(BalancaConfiguracao.porta);
  lbe_time_out.Text:= BalancaConfiguracao.TimeOut.ToString();

  lbe_digitos.Text:= BalancaConfiguracao.Digitos.ToString();
  lbe_digito_inicial.Text:= BalancaConfiguracao.DigitoInicial.ToString();
  lbe_produto_digito_inicial.Text:= BalancaConfiguracao.ProdutoDigitoInicial.ToString();
  lbe_produto_digito_final.Text:= BalancaConfiguracao.ProdutoDigitoFinal.ToString();
  lbe_peso_digito_inicial.Text:= BalancaConfiguracao.PesoDigitoInicial.ToString();
  lbe_peso_digito_final.Text:= BalancaConfiguracao.PesoDigitoFinal.ToString();
  lbe_peso_digitos_decimal.Text:= BalancaConfiguracao.PesoDigitosDecimal.ToString();
  cbx_peso.ItemIndex:= IfThen(BalancaConfiguracao.Peso = 'S', 0, 1);
end;

procedure TformBalancaConfiguracaoCreateEdit.save;
begin
  EdtToObj;
  try
    if BalancaConfiguracao.save() then
      Close;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

end.
