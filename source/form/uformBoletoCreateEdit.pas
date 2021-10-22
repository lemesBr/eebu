unit uformBoletoCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Tabs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, System.Actions, Vcl.ActnList, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Mask, Vcl.Buttons,
  BoletoConfiguracao, System.StrUtils, Vcl.FileCtrl;

type
  TformBoletoCreateEdit = class(TformBase)
    pnl_body: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_cancelar: TButton;
    btn_confirmar: TButton;
    pnl_main: TPanel;
    acl_boleto: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    lb_tipo_cobranca: TLabel;
    spb_path: TSpeedButton;
    lb_mensagem: TLabel;
    lbe_carteira: TLabeledEdit;
    lbe_tarifa_cobranca: TLabeledEdit;
    lbe_multa: TLabeledEdit;
    lbe_juros: TLabeledEdit;
    lbe_local_pagamento: TLabeledEdit;
    lbe_nosso_numero: TLabeledEdit;
    ckb_multa_percentual: TCheckBox;
    ckb_juros_percentual: TCheckBox;
    lbe_dir_arq_remessa: TLabeledEdit;
    lbe_numero_remessa: TLabeledEdit;
    cbx_tipo_cobranca: TComboBox;
    mm_mensagem: TMemo;
    cbx_layout_remessa: TComboBox;
    lb_layout_remessa: TLabel;
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure spb_pathClick(Sender: TObject);
  private
    { Private declarations }
    BoletoConfiguracao: TBoletoConfiguracao;
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
  formBoletoCreateEdit: TformBoletoCreateEdit;

implementation

uses
  udmRepository, AuthService, Helper, CustomEditHelper;

{$R *.dfm}

procedure TformBoletoCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.BoletoConfiguracaoId:= EmptyStr;
  Close;
end;

procedure TformBoletoCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformBoletoCreateEdit.EdtToObj;
begin
  BoletoConfiguracao.TipoCobranca:= cbx_tipo_cobranca.ItemIndex;
  BoletoConfiguracao.Carteira:= lbe_carteira.Text;
  BoletoConfiguracao.TarifaCobranca:= THelper.StringToExtended(lbe_tarifa_cobranca.Text);
  BoletoConfiguracao.Multa:= THelper.StringToExtended(lbe_multa.Text);
  BoletoConfiguracao.MultaPercentual:= IfThen(ckb_multa_percentual.Checked, 'S', 'N');
  BoletoConfiguracao.Juros:= THelper.StringToExtended(lbe_juros.Text);
  BoletoConfiguracao.JurosPercentual:= IfThen(ckb_juros_percentual.Checked, 'S', 'N');
  BoletoConfiguracao.LocalPagamento:= lbe_local_pagamento.Text;
  BoletoConfiguracao.Mensagem:= mm_mensagem.Text;
  BoletoConfiguracao.NossoNumero:= lbe_nosso_numero.Text;
  BoletoConfiguracao.DirArqRemessa:= lbe_dir_arq_remessa.Text;
  BoletoConfiguracao.NumeroRemessa:= StrToIntDef(lbe_numero_remessa.Text, 0);
  BoletoConfiguracao.LayoutRemessa:= cbx_layout_remessa.ItemIndex;
end;

procedure TformBoletoCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  TCustomEdit(lbe_tarifa_cobranca).EditFloat();
  TCustomEdit(lbe_multa).EditFloat();
  TCustomEdit(lbe_juros).EditFloat();
  BoletoConfiguracao:= TBoletoConfiguracao.findByContaId(TAuthService.ContaId);
  if not Assigned(BoletoConfiguracao) then
    BoletoConfiguracao:= TBoletoConfiguracao.Create;

  ObjToEdt;
end;

procedure TformBoletoCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(BoletoConfiguracao);
end;

procedure TformBoletoCreateEdit.ObjToEdt;
begin
  if (BoletoConfiguracao.Id = EmptyStr) then
  begin
    BoletoConfiguracao.ContaId:= TAuthService.ContaId;
    cbx_tipo_cobranca.ItemIndex:= 0;
    cbx_layout_remessa.ItemIndex:= 0;
    Exit();
  end;

  cbx_tipo_cobranca.ItemIndex:= BoletoConfiguracao.TipoCobranca;
  lbe_carteira.Text:= BoletoConfiguracao.Carteira;
  lbe_tarifa_cobranca.Text:= THelper.ExtendedToString(BoletoConfiguracao.TarifaCobranca);
  lbe_multa.Text:= THelper.ExtendedToString(BoletoConfiguracao.Multa);
  ckb_multa_percentual.Checked:= BoletoConfiguracao.MultaPercentual = 'S';
  lbe_juros.Text:= THelper.ExtendedToString(BoletoConfiguracao.Juros);
  ckb_juros_percentual.Checked:= BoletoConfiguracao.JurosPercentual = 'S';
  lbe_local_pagamento.Text:= BoletoConfiguracao.LocalPagamento;
  mm_mensagem.Text:= BoletoConfiguracao.Mensagem;
  lbe_nosso_numero.Text:= BoletoConfiguracao.NossoNumero;
  lbe_dir_arq_remessa.Text:= BoletoConfiguracao.DirArqRemessa;
  lbe_numero_remessa.Text:= BoletoConfiguracao.NumeroRemessa.ToString();
  cbx_layout_remessa.ItemIndex:= BoletoConfiguracao.LayoutRemessa;
end;

procedure TformBoletoCreateEdit.onEnter(Sender: TObject);
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

procedure TformBoletoCreateEdit.save;
begin
  EdtToObj;
  try
    if validaCamposObrigatorios() then
    begin
      if BoletoConfiguracao.validate() then
      begin
        if BoletoConfiguracao.save then
        begin
          TAuthService.BoletoConfiguracaoId:= BoletoConfiguracao.Id;
          Close;
        end;
      end;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformBoletoCreateEdit.setRequired(Obj: TObject);
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

procedure TformBoletoCreateEdit.spb_pathClick(Sender: TObject);
var
  vDir: string;
begin
  if SelectDirectory(vDir, [sdAllowCreate, sdPerformCreate, sdPrompt], 1000) then
    lbe_dir_arq_remessa.Text:= vDir;
end;

function TformBoletoCreateEdit.validaCamposObrigatorios: Boolean;
var
  vRequired: Integer;
begin
  vRequired:= 0;
  if (Trim(lbe_carteira.Text) = '') then
  begin
    setRequired(lbe_carteira);
    Inc(vRequired);
  end;

  if (Trim(lbe_nosso_numero.Text) = '') then
  begin
    setRequired(lbe_nosso_numero);
    Inc(vRequired);
  end;

  if (Trim(lbe_numero_remessa.Text) = '') then
  begin
    setRequired(lbe_numero_remessa);
    Inc(vRequired);
  end;

  if (Trim(lbe_dir_arq_remessa.Text) = '') then
  begin
    setRequired(lbe_dir_arq_remessa);
    Inc(vRequired);
  end;

  Result:= (vRequired = 0);
  if (not Result) then  THelper.Mensagem('Preencha os dados obrigatórios do boleto.');
end;

end.
