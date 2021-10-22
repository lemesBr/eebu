unit uformConfiguracaoFiscalIcmsCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  CustomEditHelper, ConfiguracaoFiscalIcms, System.Actions, Vcl.ActnList;

type
  TformConfiguracaoFiscalIcmsCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_confirmar: TButton;
    pnl_body: TPanel;
    btn_cancelar: TButton;
    lbe_cfop: TLabeledEdit;
    lbe_predbc: TLabeledEdit;
    lbe_picms: TLabeledEdit;
    lbe_pmvast: TLabeledEdit;
    lbe_predbcst: TLabeledEdit;
    lbe_picmsst: TLabeledEdit;
    lbe_pcredsn: TLabeledEdit;
    lbe_pdif: TLabeledEdit;
    lbe_pfcp: TLabeledEdit;
    lbe_pfcpst: TLabeledEdit;
    lbe_pfcpstret: TLabeledEdit;
    lbe_pfcpufdest: TLabeledEdit;
    lbe_picmsufdest: TLabeledEdit;
    lbe_picmsinter: TLabeledEdit;
    lbe_picmsinterpart: TLabeledEdit;
    acl_icms_uf: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    cbx_uf_destino: TComboBox;
    lb_icms_ufst: TLabel;
    cbx_csosn: TComboBox;
    cbx_cst: TComboBox;
    lb_icms_cst_csosn: TLabel;
    cbx_modbc: TComboBox;
    lb_icms_modbc: TLabel;
    cbx_modbcst: TComboBox;
    lb_icms_modbcst: TLabel;
    cbx_motdesicms: TComboBox;
    lb_icms_motdesicms: TLabel;
    lb_hint: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure cbx_uf_destinoEnter(Sender: TObject);
  private
    { Private declarations }
    Icms: TConfiguracaoFiscalIcms;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();
  public
    { Public declarations }
  end;

var
  formConfiguracaoFiscalIcmsCreateEdit: TformConfiguracaoFiscalIcmsCreateEdit;

implementation

uses
  AuthService, udmRepository, Helper, Empresa;

{$R *.dfm}

procedure TformConfiguracaoFiscalIcmsCreateEdit.act_cancelarExecute(
  Sender: TObject);
begin
  Close;
end;

procedure TformConfiguracaoFiscalIcmsCreateEdit.act_confirmarExecute(
  Sender: TObject);
begin
  save();
end;

procedure TformConfiguracaoFiscalIcmsCreateEdit.cbx_uf_destinoEnter(
  Sender: TObject);
begin
  lb_hint.Caption:= UpperCase(THelper.RemoveAcentos(TControl(Sender).Hint));
end;

procedure TformConfiguracaoFiscalIcmsCreateEdit.EdtToObj;
begin
  Icms.ConfiguracaoFiscalId:= TAuthService.ConfiguracaoFiscalId;
  Icms.UfDestino:= cbx_uf_destino.Items[cbx_uf_destino.ItemIndex];
  Icms.Cfop:= lbe_cfop.Text;
  Icms.Cst:= cbx_cst.Items[cbx_cst.ItemIndex];
  Icms.Csosn:= cbx_csosn.Items[cbx_csosn.ItemIndex];
  Icms.Modbc:= cbx_modbc.Items[cbx_modbc.ItemIndex];
  Icms.Predbc:= THelper.StringToExtended(lbe_predbc.Text);
  Icms.Picms:= THelper.StringToExtended(lbe_picms.Text);
  Icms.Modbcst:= cbx_modbcst.Items[cbx_modbcst.ItemIndex];
  Icms.Pmvast:= THelper.StringToExtended(lbe_pmvast.Text);
  Icms.Predbcst:= THelper.StringToExtended(lbe_predbcst.Text);
  Icms.Picmsst:= THelper.StringToExtended(lbe_picmsst.Text);
  Icms.Motdesicms:= cbx_motdesicms.Items[cbx_motdesicms.ItemIndex];
  Icms.Pcredsn:= THelper.StringToExtended(lbe_pcredsn.Text);
  Icms.Pdif:= THelper.StringToExtended(lbe_pdif.Text);
  Icms.Pfcp:= THelper.StringToExtended(lbe_pfcp.Text);
  Icms.Pfcpst:= THelper.StringToExtended(lbe_pfcpst.Text);
  Icms.Pfcpstret:= THelper.StringToExtended(lbe_pfcpstret.Text);
  Icms.Pfcpufdest:= THelper.StringToExtended(lbe_pfcpufdest.Text);
  Icms.Picmsufdest:= THelper.StringToExtended(lbe_picmsufdest.Text);
  Icms.Picmsinter:= THelper.StringToExtended(lbe_picmsinter.Text);
  Icms.Picmsinterpart:= THelper.StringToExtended(lbe_picmsinterpart.Text);
end;

procedure TformConfiguracaoFiscalIcmsCreateEdit.FormCreate(Sender: TObject);
var
  v_empresa: TEmpresa;
begin
  inherited;
  try
    v_empresa:= TEmpresa.find(TAuthService.getAuthenticatedEmpresaId);
    if Assigned(v_empresa) then
    begin
      if StrToIntDef(v_empresa.Crt, 1) = 3 then
      begin
        cbx_csosn.Visible:= False;
        cbx_cst.Visible:= True;
        lb_icms_cst_csosn.Caption:= '* CST';
        lb_icms_cst_csosn.Left:= 252;
      end
      else
      begin
        cbx_csosn.Visible:= True;
        cbx_cst.Visible:= False;
        lb_icms_cst_csosn.Caption:= '* CSOSN';
        lb_icms_cst_csosn.Left:= 234;
      end;
    end;
  finally
    FreeAndNil(v_empresa);
  end;
  TCustomEdit(lbe_predbc).EditFloat;
  TCustomEdit(lbe_picms).EditFloat;
  TCustomEdit(lbe_pmvast).EditFloat;
  TCustomEdit(lbe_predbcst).EditFloat;
  TCustomEdit(lbe_picmsst).EditFloat;
  TCustomEdit(lbe_pcredsn).EditFloat;
  TCustomEdit(lbe_pdif).EditFloat;
  TCustomEdit(lbe_pfcp).EditFloat;
  TCustomEdit(lbe_pfcpst).EditFloat;
  TCustomEdit(lbe_pfcpstret).EditFloat;
  TCustomEdit(lbe_pfcpufdest).EditFloat;
  TCustomEdit(lbe_picmsufdest).EditFloat;
  TCustomEdit(lbe_picmsinter).EditFloat;
  TCustomEdit(lbe_picmsinterpart).EditFloat;
  if TAuthService.ConfiguracaoFiscalIcmsId = EmptyStr then Icms:= TConfiguracaoFiscalIcms.Create
  else Icms:= TConfiguracaoFiscalIcms.find(TAuthService.ConfiguracaoFiscalIcmsId);
  ObjToEdt;
end;

procedure TformConfiguracaoFiscalIcmsCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Icms);
end;

procedure TformConfiguracaoFiscalIcmsCreateEdit.ObjToEdt;
begin
  cbx_uf_destino.ItemIndex:= cbx_uf_destino.Items.IndexOf(Icms.UfDestino);
  lbe_cfop.Text:= Icms.Cfop;
  cbx_cst.ItemIndex:= cbx_cst.Items.IndexOf(Icms.Cst);
  cbx_csosn.ItemIndex:= cbx_csosn.Items.IndexOf(Icms.Csosn);
  cbx_modbc.ItemIndex:= cbx_modbc.Items.IndexOf(Icms.Modbc);
  lbe_predbc.Text:= THelper.ExtendedToString(Icms.Predbc);
  lbe_picms.Text:= THelper.ExtendedToString(Icms.Picms);
  cbx_modbcst.ItemIndex:= cbx_modbcst.Items.IndexOf(Icms.Modbcst);
  lbe_pmvast.Text:= THelper.ExtendedToString(Icms.Pmvast);
  lbe_predbcst.Text:= THelper.ExtendedToString(Icms.Predbcst);
  lbe_picmsst.Text:= THelper.ExtendedToString(Icms.Picmsst);
  cbx_motdesicms.ItemIndex:= cbx_motdesicms.Items.IndexOf(Icms.Motdesicms);
  lbe_pcredsn.Text:= THelper.ExtendedToString(Icms.Pcredsn);
  lbe_pdif.Text:= THelper.ExtendedToString(Icms.Pdif);
  lbe_pfcp.Text:= THelper.ExtendedToString(Icms.Pfcp);
  lbe_pfcpst.Text:= THelper.ExtendedToString(Icms.Pfcpst);
  lbe_pfcpstret.Text:= THelper.ExtendedToString(Icms.Pfcpstret);
  lbe_pfcpufdest.Text:= THelper.ExtendedToString(Icms.Pfcpufdest);
  lbe_picmsufdest.Text:= THelper.ExtendedToString(Icms.Picmsufdest);
  lbe_picmsinter.Text:= THelper.ExtendedToString(Icms.Picmsinter);
  lbe_picmsinterpart.Text:= THelper.ExtendedToString(Icms.Picmsinterpart);
end;

procedure TformConfiguracaoFiscalIcmsCreateEdit.save;
begin
  EdtToObj;
  try
    if Icms.save then Close;
  except on e: exception do
    THelper.Mensagem(e.Message);
  end;
end;

end.
