unit uformNfeDetCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Nfe, Vcl.Tabs, System.StrUtils;

type
  TformNfeDetCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_confirmar: TButton;
    btn_cancelar: TButton;
    acl_nfe_det: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    scb_main: TScrollBox;
    pnl_det: TPanel;
    lbe_item: TLabeledEdit;
    lbe_det_cprod: TLabeledEdit;
    lbe_det_nitem: TLabeledEdit;
    lbe_det_cean: TLabeledEdit;
    lbe_det_ncm: TLabeledEdit;
    lbe_det_extipi: TLabeledEdit;
    lbe_det_cfop: TLabeledEdit;
    lbe_det_ucom: TLabeledEdit;
    lbe_det_qcom: TLabeledEdit;
    lbe_det_vuncom: TLabeledEdit;
    lbe_det_vprod: TLabeledEdit;
    lbe_det_ceantrib: TLabeledEdit;
    lbe_det_utrib: TLabeledEdit;
    lbe_det_qtrib: TLabeledEdit;
    lbe_det_vuntrib: TLabeledEdit;
    lbe_det_vfrete: TLabeledEdit;
    lbe_det_vseg: TLabeledEdit;
    lbe_det_vdesc: TLabeledEdit;
    lbe_det_voutro: TLabeledEdit;
    lbe_det_xped: TLabeledEdit;
    lbe_det_nitemped: TLabeledEdit;
    lbe_det_nrecopi: TLabeledEdit;
    lbe_det_nfci: TLabeledEdit;
    lbe_det_cest: TLabeledEdit;
    lbe_det_infadprod: TLabeledEdit;
    lbe_icms_predbc: TLabeledEdit;
    lbe_icms_vbc: TLabeledEdit;
    lbe_icms_picms: TLabeledEdit;
    lbe_icms_vicms: TLabeledEdit;
    lbe_icms_pmvast: TLabeledEdit;
    lbe_icms_predbcst: TLabeledEdit;
    lbe_icms_vbcst: TLabeledEdit;
    lbe_icms_picmsst: TLabeledEdit;
    lbe_icms_vicmsst: TLabeledEdit;
    lbe_icms_pbcop: TLabeledEdit;
    lbe_icms_vbcstret: TLabeledEdit;
    lbe_icms_vicmsstret: TLabeledEdit;
    lbe_icms_pcredsn: TLabeledEdit;
    lbe_icms_vcredicmssn: TLabeledEdit;
    lbe_icms_vbcstdest: TLabeledEdit;
    lbe_icms_vicmsstdest: TLabeledEdit;
    lbe_icms_vicmsdeson: TLabeledEdit;
    lbe_icms_vicmsop: TLabeledEdit;
    lbe_icms_pdif: TLabeledEdit;
    lbe_icms_vicmsdif: TLabeledEdit;
    lbe_icms_vbcfcp: TLabeledEdit;
    lbe_icms_pfcp: TLabeledEdit;
    lbe_icms_vfcp: TLabeledEdit;
    lbe_icms_vbcfcpst: TLabeledEdit;
    lbe_icms_pfcpst: TLabeledEdit;
    lbe_icms_vfcpst: TLabeledEdit;
    lbe_icms_vbcfcpstret: TLabeledEdit;
    lbe_icms_pfcpstret: TLabeledEdit;
    lbe_icms_vfcpstret: TLabeledEdit;
    lbe_icms_pst: TLabeledEdit;
    lbe_ipi_clenq: TLabeledEdit;
    lbe_ipi_cnpjprod: TLabeledEdit;
    lbe_ipi_cselo: TLabeledEdit;
    lbe_ipi_qselo: TLabeledEdit;
    lbe_ipi_cenq: TLabeledEdit;
    lbe_ipi_vbc: TLabeledEdit;
    lbe_ipi_qunid: TLabeledEdit;
    lbe_ipi_vunid: TLabeledEdit;
    lbe_ipi_pipi: TLabeledEdit;
    lbe_ipi_vipi: TLabeledEdit;
    lbe_ii_vbc: TLabeledEdit;
    lbe_ii_vdespadu: TLabeledEdit;
    lbe_ii_vii: TLabeledEdit;
    lbe_ii_viof: TLabeledEdit;
    lbe_pis_vbc: TLabeledEdit;
    lbe_pis_ppis: TLabeledEdit;
    lbe_pis_qbcprod: TLabeledEdit;
    lbe_pis_valiqprod: TLabeledEdit;
    lbe_pis_vpis: TLabeledEdit;
    lbe_pisst_vbc: TLabeledEdit;
    lbe_pisst_ppis: TLabeledEdit;
    lbe_pisst_qbcprod: TLabeledEdit;
    lbe_pisst_valiqprod: TLabeledEdit;
    lbe_pisst_vpis: TLabeledEdit;
    lbe_cofins_vbc: TLabeledEdit;
    lbe_cofins_pcofins: TLabeledEdit;
    lbe_cofins_qbcprod: TLabeledEdit;
    lbe_cofins_vbcprod: TLabeledEdit;
    lbe_cofins_valiqprod: TLabeledEdit;
    lbe_cofins_vcofins: TLabeledEdit;
    lbe_cofinsst_vbc: TLabeledEdit;
    lbe_cofinsst_pcofins: TLabeledEdit;
    lbe_cofinsst_qbcprod: TLabeledEdit;
    lbe_cofinsst_valiqprod: TLabeledEdit;
    lbe_cofinsst_vcofins: TLabeledEdit;
    lbe_icms_uf_dest_vbcufdest: TLabeledEdit;
    lbe_icms_uf_dest_vbcfcpufdest: TLabeledEdit;
    lbe_icms_uf_dest_pfcpufdest: TLabeledEdit;
    lbe_icms_uf_dest_picmsufdest: TLabeledEdit;
    lbe_icms_uf_dest_picmsinter: TLabeledEdit;
    lbe_icms_uf_dest_picmsinterpart: TLabeledEdit;
    lbe_icms_uf_dest_vicmsufdest: TLabeledEdit;
    lbe_icms_uf_dest_vfcpufdest: TLabeledEdit;
    lbe_icms_uf_dest_vicmsufremet: TLabeledEdit;
    ts_nfe_det: TTabSet;
    ntb_nfe_det: TNotebook;
    pnl_dados_body: TPanel;
    bvl_1: TBevel;
    ckb_det_indtot: TCheckBox;
    pnl_tributos_body: TPanel;
    lbe_det_vtottrib: TLabeledEdit;
    pnl_tributos: TPanel;
    bvl_3: TBevel;
    ts_tributos: TTabSet;
    ntb_tributos: TNotebook;
    pnl_tributos_icms: TPanel;
    pnl_tributos_ipi: TPanel;
    pnl_tributos_cofins: TPanel;
    pnl_tributos_pis: TPanel;
    pnl_tributos_icms_interestadual: TPanel;
    pnl_tributos_ipi_devolvido: TPanel;
    pnl_tributos_imposto_importacao: TPanel;
    lbe_det_pdevol: TLabeledEdit;
    lbe_det_vipidevol: TLabeledEdit;
    cbx_cofins_cst: TComboBox;
    lb_cofins_cst: TLabel;
    cbx_pis_cst: TComboBox;
    lb_pis_cst: TLabel;
    cbx_ipi_cst: TComboBox;
    Label1: TLabel;
    cbx_icms_cst: TComboBox;
    cbx_icms_csosn: TComboBox;
    cbx_icms_orig: TComboBox;
    cbx_icms_modbc: TComboBox;
    cbx_icms_modbcst: TComboBox;
    cbx_icms_ufst: TComboBox;
    cbx_icms_motdesicms: TComboBox;
    lb_icms_cst_csosn: TLabel;
    lb_icms_orig: TLabel;
    lb_icms_modbc: TLabel;
    lb_icms_modbcst: TLabel;
    lb_icms_ufst: TLabel;
    lb_icms_motdesicms: TLabel;
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbe_itemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure acl_nfe_detUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
    Nfe: TNfe;
    NfeDetIndex: Integer;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();
  public
    { Public declarations }
  end;

var
  formNfeDetCreateEdit: TformNfeDetCreateEdit;

implementation

uses
  AuthService, NfeDet, CustomEditHelper, uformItemList, Helper, ViewCfIcms,
  ViewCfIpi, ViewCfPis, ViewCfCofins, udmRepository;

{$R *.dfm}

procedure TformNfeDetCreateEdit.acl_nfe_detUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  ntb_nfe_det.PageIndex:= ts_nfe_det.TabIndex;
  ntb_tributos.PageIndex:= ts_tributos.TabIndex;

  cbx_icms_cst.Visible:= StrToIntDef(Nfe.Empresa.Crt, 1) = 3;
  cbx_icms_csosn.Visible:= StrToIntDef(Nfe.Empresa.Crt, 1) <= 2;
end;

procedure TformNfeDetCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.NfeDetId:= EmptyStr;
  Close;
end;

procedure TformNfeDetCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformNfeDetCreateEdit.EdtToObj;
begin
  with Nfe.Det.Items[NfeDetIndex] do
  begin
    Cprod:= lbe_det_cprod.Text;
    Nitem:= (NfeDetIndex + 1);
    Cean:= lbe_det_cean.Text;
    Xprod:= lbe_item.Text;
    Ncm:= lbe_det_ncm.Text;
    Extipi:= lbe_det_extipi.Text;
    Cfop:= lbe_det_cfop.Text;
    Ucom:= lbe_det_ucom.Text;
    Qcom:= THelper.StringToExtended(lbe_det_qcom.Text);
    Vuncom:= THelper.StringToExtended(lbe_det_vuncom.Text);
    Vprod:= THelper.StringToExtended(lbe_det_vprod.Text);
    Ceantrib:= lbe_det_ceantrib.Text;
    Utrib:= lbe_det_utrib.Text;
    Qtrib:= THelper.StringToExtended(lbe_det_qtrib.Text);
    Vuntrib:= THelper.StringToExtended(lbe_det_vuntrib.Text);
    Vfrete:= THelper.StringToExtended(lbe_det_vfrete.Text);
    Vseg:= THelper.StringToExtended(lbe_det_vseg.Text);
    Vdesc:= THelper.StringToExtended(lbe_det_vdesc.Text);
    Voutro:= THelper.StringToExtended(lbe_det_voutro.Text);
    Indtot:= IfThen(ckb_det_indtot.Checked, '1', '0');
    Xped:= lbe_det_xped.Text;
    Nitemped:= lbe_det_nitemped.Text;
    Nrecopi:= lbe_det_nrecopi.Text;
    Nfci:= lbe_det_nfci.Text;
    Cest:= lbe_det_cest.Text;
    Vtottrib:= THelper.StringToExtended(lbe_det_vtottrib.Text);
    Pdevol:= THelper.StringToExtended(lbe_det_pdevol.Text);
    Vipidevol:= THelper.StringToExtended(lbe_det_vipidevol.Text);
    Infadprod:= lbe_det_infadprod.Text;
  
    ICMSCreate();
    ICMS.Orig:= cbx_icms_orig.Items[cbx_icms_orig.ItemIndex];
    ICMS.Cst:= cbx_icms_cst.Items[cbx_icms_cst.ItemIndex];
    ICMS.Csosn:= cbx_icms_csosn.Items[cbx_icms_csosn.ItemIndex];
    ICMS.Modbc:= cbx_icms_modbc.Items[cbx_icms_modbc.ItemIndex];
    ICMS.Predbc:= THelper.StringToExtended(lbe_icms_predbc.Text);
    ICMS.Vbc:= THelper.StringToExtended(lbe_icms_vbc.Text);
    ICMS.Picms:= THelper.StringToExtended(lbe_icms_picms.Text);
    ICMS.Vicms:= THelper.StringToExtended(lbe_icms_vicms.Text);
    ICMS.Modbcst:= cbx_icms_modbcst.Items[cbx_icms_modbcst.ItemIndex];
    ICMS.Pmvast:= THelper.StringToExtended(lbe_icms_pmvast.Text);
    ICMS.Predbcst:= THelper.StringToExtended(lbe_icms_predbcst.Text);
    ICMS.Vbcst:= THelper.StringToExtended(lbe_icms_vbcst.Text);
    ICMS.Picmsst:= THelper.StringToExtended(lbe_icms_picmsst.Text);
    ICMS.Vicmsst:= THelper.StringToExtended(lbe_icms_vicmsst.Text);
    ICMS.Ufst:= cbx_icms_ufst.Items[cbx_icms_ufst.ItemIndex];
    ICMS.Pbcop:= THelper.StringToExtended(lbe_icms_pbcop.Text);
    ICMS.Vbcstret:= THelper.StringToExtended(lbe_icms_vbcstret.Text);
    ICMS.Vicmsstret:= THelper.StringToExtended(lbe_icms_vicmsstret.Text);
    ICMS.Motdesicms:= cbx_icms_motdesicms.Items[cbx_icms_motdesicms.ItemIndex];
    ICMS.Pcredsn:= THelper.StringToExtended(lbe_icms_pcredsn.Text);
    ICMS.Vcredicmssn:= THelper.StringToExtended(lbe_icms_vcredicmssn.Text);
    ICMS.Vbcstdest:= THelper.StringToExtended(lbe_icms_vbcstdest.Text);
    ICMS.Vicmsstdest:= THelper.StringToExtended(lbe_icms_vicmsstdest.Text);
    ICMS.Vicmsdeson:= THelper.StringToExtended(lbe_icms_vicmsdeson.Text);
    ICMS.Vicmsop:= THelper.StringToExtended(lbe_icms_vicmsop.Text);
    ICMS.Vicmsop:= THelper.StringToExtended(lbe_icms_vicmsop.Text);
    ICMS.Pdif:= THelper.StringToExtended(lbe_icms_pdif.Text);
    ICMS.Vicmsdif:= THelper.StringToExtended(lbe_icms_vicmsdif.Text);
    ICMS.Vbcfcp:= THelper.StringToExtended(lbe_icms_vbcfcp.Text);
    ICMS.Pfcp:= THelper.StringToExtended(lbe_icms_pfcp.Text);
    ICMS.Vfcp:= THelper.StringToExtended(lbe_icms_vfcp.Text);
    ICMS.Vbcfcpst:= THelper.StringToExtended(lbe_icms_vbcfcpst.Text);
    ICMS.Pfcpst:= THelper.StringToExtended(lbe_icms_pfcpst.Text);
    ICMS.Vfcpst:= THelper.StringToExtended(lbe_icms_vfcpst.Text);
    ICMS.Vbcfcpstret:= THelper.StringToExtended(lbe_icms_vbcfcpstret.Text);
    ICMS.Pfcpstret:= THelper.StringToExtended(lbe_icms_pfcpstret.Text);
    ICMS.Vfcpstret:= THelper.StringToExtended(lbe_icms_vfcpstret.Text);
    ICMS.Pst:= THelper.StringToExtended(lbe_icms_pst.Text);

    ICMSUFDestCreate();
    ICMSUFDest.Vbcufdest:= THelper.StringToExtended(lbe_icms_uf_dest_vbcufdest.Text);
    ICMSUFDest.Vbcfcpufdest:= THelper.StringToExtended(lbe_icms_uf_dest_vbcfcpufdest.Text);
    ICMSUFDest.Pfcpufdest:= THelper.StringToExtended(lbe_icms_uf_dest_pfcpufdest.Text);
    ICMSUFDest.Picmsufdest:= THelper.StringToExtended(lbe_icms_uf_dest_picmsufdest.Text);
    ICMSUFDest.Picmsinter:= THelper.StringToExtended(lbe_icms_uf_dest_picmsinter.Text);
    ICMSUFDest.Picmsinterpart:= THelper.StringToExtended(lbe_icms_uf_dest_picmsinterpart.Text);
    ICMSUFDest.Vfcpufdest:= THelper.StringToExtended(lbe_icms_uf_dest_vfcpufdest.Text);
    ICMSUFDest.Vicmsufdest:= THelper.StringToExtended(lbe_icms_uf_dest_vicmsufdest.Text);
    ICMSUFDest.Vicmsufremet:= THelper.StringToExtended(lbe_icms_uf_dest_vicmsufremet.Text);

    IPICreate();
    IPI.Clenq:= lbe_ipi_clenq.Text;
    IPI.Cnpjprod:= lbe_ipi_cnpjprod.Text;
    IPI.Cselo:= lbe_ipi_cselo.Text;
    IPI.Qselo:= StrToIntDef(lbe_ipi_qselo.Text, 0);
    IPI.Cenq:= lbe_ipi_cenq.Text;
    IPI.Cst:= cbx_ipi_cst.Items[cbx_ipi_cst.ItemIndex];
    IPI.Vbc:= THelper.StringToExtended(lbe_ipi_vbc.Text);
    IPI.Qunid:= THelper.StringToExtended(lbe_ipi_qunid.Text);
    IPI.Vunid:= THelper.StringToExtended(lbe_ipi_vunid.Text);
    IPI.Pipi:= THelper.StringToExtended(lbe_ipi_pipi.Text);
    IPI.Vipi:= THelper.StringToExtended(lbe_ipi_vipi.Text);

    IICreate();
    II.Vbc:= THelper.StringToExtended(lbe_ii_vbc.Text);
    II.Vdespadu:= THelper.StringToExtended(lbe_ii_vdespadu.Text);
    II.Vii:= THelper.StringToExtended(lbe_ii_vii.Text);
    II.Viof:= THelper.StringToExtended(lbe_ii_viof.Text);

    PISCreate();
    PIS.Cst:= cbx_pis_cst.Items[cbx_pis_cst.ItemIndex];
    PIS.Vbc:= THelper.StringToExtended(lbe_pis_vbc.Text);
    PIS.Ppis:= THelper.StringToExtended(lbe_pis_ppis.Text);
    PIS.Qbcprod:= THelper.StringToExtended(lbe_pis_qbcprod.Text);
    PIS.Valiqprod:= THelper.StringToExtended(lbe_pis_valiqprod.Text);
    PIS.Vpis:= THelper.StringToExtended(lbe_pis_vpis.Text);

    PISSTCreate();
    PISST.Vbc:= THelper.StringToExtended(lbe_pisst_vbc.Text);
    PISST.Ppis:= THelper.StringToExtended(lbe_pisst_ppis.Text);
    PISST.Qbcprod:= THelper.StringToExtended(lbe_pisst_qbcprod.Text);
    PISST.Valiqprod:= THelper.StringToExtended(lbe_pisst_valiqprod.Text);
    PISST.Vpis:= THelper.StringToExtended(lbe_pisst_vpis.Text);

    COFINSCreate();
    COFINS.Cst:= cbx_cofins_cst.Items[cbx_cofins_cst.ItemIndex];
    COFINS.Vbc:= THelper.StringToExtended(lbe_cofins_vbc.Text);
    COFINS.Pcofins:= THelper.StringToExtended(lbe_cofins_pcofins.Text);
    COFINS.Qbcprod:= THelper.StringToExtended(lbe_cofins_qbcprod.Text);
    COFINS.Vbcprod:= THelper.StringToExtended(lbe_cofins_vbcprod.Text);
    COFINS.Valiqprod:= THelper.StringToExtended(lbe_cofins_valiqprod.Text);
    COFINS.Vcofins:= THelper.StringToExtended(lbe_cofins_vcofins.Text);

    COFINSSTCreate();
    COFINSST.Vbc:= THelper.StringToExtended(lbe_cofinsst_vbc.Text);
    COFINSST.Pcofins:= THelper.StringToExtended(lbe_cofinsst_pcofins.Text);
    COFINSST.Qbcprod:= THelper.StringToExtended(lbe_cofinsst_qbcprod.Text);
    COFINSST.Valiqprod:= THelper.StringToExtended(lbe_cofinsst_valiqprod.Text);
    COFINSST.Vcofins:= THelper.StringToExtended(lbe_cofinsst_vcofins.Text);
  end;
end;

procedure TformNfeDetCreateEdit.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  inherited;
  lbe_det_qcom.Tag:= 1;
  lbe_det_qtrib.Tag:= 1;

  //--Det
  TCustomEdit(lbe_det_qcom).EditFloat;
  TCustomEdit(lbe_det_vuncom).EditFloat;
  TCustomEdit(lbe_det_vprod).EditFloat;
  TCustomEdit(lbe_det_qtrib).EditFloat;
  TCustomEdit(lbe_det_vuntrib).EditFloat;
  TCustomEdit(lbe_det_vfrete).EditFloat;
  TCustomEdit(lbe_det_vseg).EditFloat;
  TCustomEdit(lbe_det_vdesc).EditFloat;
  TCustomEdit(lbe_det_voutro).EditFloat;
  TCustomEdit(lbe_det_vtottrib).EditFloat;
  TCustomEdit(lbe_det_pdevol).EditFloat;
  TCustomEdit(lbe_det_vipidevol).EditFloat;
  //--ICMS
  TCustomEdit(lbe_icms_predbc).EditFloat;
  TCustomEdit(lbe_icms_vbc).EditFloat;
  TCustomEdit(lbe_icms_picms).EditFloat;
  TCustomEdit(lbe_icms_vicms).EditFloat;
  TCustomEdit(lbe_icms_pmvast).EditFloat;
  TCustomEdit(lbe_icms_predbcst).EditFloat;
  TCustomEdit(lbe_icms_vbcst).EditFloat;
  TCustomEdit(lbe_icms_picmsst).EditFloat;
  TCustomEdit(lbe_icms_vicmsst).EditFloat;
  TCustomEdit(lbe_icms_pbcop).EditFloat;
  TCustomEdit(lbe_icms_vbcstret).EditFloat;
  TCustomEdit(lbe_icms_vicmsstret).EditFloat;
  TCustomEdit(lbe_icms_pcredsn).EditFloat;
  TCustomEdit(lbe_icms_vcredicmssn).EditFloat;
  TCustomEdit(lbe_icms_vbcstdest).EditFloat;
  TCustomEdit(lbe_icms_vicmsstdest).EditFloat;
  TCustomEdit(lbe_icms_vicmsdeson).EditFloat;
  TCustomEdit(lbe_icms_vicmsop).EditFloat;
  TCustomEdit(lbe_icms_pdif).EditFloat;
  TCustomEdit(lbe_icms_vicmsdif).EditFloat;
  TCustomEdit(lbe_icms_vbcfcp).EditFloat;
  TCustomEdit(lbe_icms_pfcp).EditFloat;
  TCustomEdit(lbe_icms_vfcp).EditFloat;
  TCustomEdit(lbe_icms_vbcfcpst).EditFloat;
  TCustomEdit(lbe_icms_pfcpst).EditFloat;
  TCustomEdit(lbe_icms_vfcpst).EditFloat;
  TCustomEdit(lbe_icms_vbcfcpstret).EditFloat;
  TCustomEdit(lbe_icms_pfcpstret).EditFloat;
  TCustomEdit(lbe_icms_vfcpstret).EditFloat;
  TCustomEdit(lbe_icms_pst).EditFloat;
  //--IPI
  lbe_ipi_qunid.Tag:= 1;
  TCustomEdit(lbe_ipi_vbc).EditFloat;
  TCustomEdit(lbe_ipi_qunid).EditFloat;
  TCustomEdit(lbe_ipi_vunid).EditFloat;
  TCustomEdit(lbe_ipi_pipi).EditFloat;
  TCustomEdit(lbe_ipi_vipi).EditFloat;
  //--II
  TCustomEdit(lbe_ii_vbc).EditFloat;
  TCustomEdit(lbe_ii_vdespadu).EditFloat;
  TCustomEdit(lbe_ii_vii).EditFloat;
  TCustomEdit(lbe_ii_viof).EditFloat;
  //--PIS
  lbe_pis_qbcprod.Tag:= 1;
  TCustomEdit(lbe_pis_vbc).EditFloat;
  TCustomEdit(lbe_pis_ppis).EditFloat;
  TCustomEdit(lbe_pis_qbcprod).EditFloat;
  TCustomEdit(lbe_pis_valiqprod).EditFloat;
  TCustomEdit(lbe_pis_vpis).EditFloat;
  //--PIS ST
  lbe_pisst_qbcprod.Tag:= 1;
  TCustomEdit(lbe_pisst_vbc).EditFloat;
  TCustomEdit(lbe_pisst_ppis).EditFloat;
  TCustomEdit(lbe_pisst_qbcprod).EditFloat;
  TCustomEdit(lbe_pisst_valiqprod).EditFloat;
  TCustomEdit(lbe_pisst_vpis).EditFloat;
  //--COFINS
  lbe_cofins_qbcprod.Tag:= 1;
  TCustomEdit(lbe_cofins_vbc).EditFloat;
  TCustomEdit(lbe_cofins_pcofins).EditFloat;
  TCustomEdit(lbe_cofins_qbcprod).EditFloat;
  TCustomEdit(lbe_cofins_vbcprod).EditFloat;
  TCustomEdit(lbe_cofins_valiqprod).EditFloat;
  TCustomEdit(lbe_cofins_vcofins).EditFloat;
  //--COFINS ST
  lbe_cofinsst_qbcprod.Tag:= 1;
  TCustomEdit(lbe_cofinsst_vbc).EditFloat;
  TCustomEdit(lbe_cofinsst_pcofins).EditFloat;
  TCustomEdit(lbe_cofinsst_qbcprod).EditFloat;
  TCustomEdit(lbe_cofinsst_valiqprod).EditFloat;
  TCustomEdit(lbe_cofinsst_vcofins).EditFloat;
  //--ICMS UF DEST
  TCustomEdit(lbe_icms_uf_dest_vbcufdest).EditFloat;
  TCustomEdit(lbe_icms_uf_dest_vbcfcpufdest).EditFloat;
  TCustomEdit(lbe_icms_uf_dest_pfcpufdest).EditFloat;
  TCustomEdit(lbe_icms_uf_dest_picmsufdest).EditFloat;
  TCustomEdit(lbe_icms_uf_dest_picmsinter).EditFloat;
  TCustomEdit(lbe_icms_uf_dest_picmsinterpart).EditFloat;
  TCustomEdit(lbe_icms_uf_dest_vicmsufdest).EditFloat;
  TCustomEdit(lbe_icms_uf_dest_vfcpufdest).EditFloat;
  TCustomEdit(lbe_icms_uf_dest_vicmsufremet).EditFloat;

  ts_nfe_det.TabIndex:= 0;
  ntb_nfe_det.PageIndex:= 0;
  ts_tributos.TabIndex:= 0;
  ntb_tributos.PageIndex:= 0;

  Nfe:= TNfe.find(TAuthService.NfeId);

  if TAuthService.NfeDetId = EmptyStr then
  begin
    Nfe.Det.Add(TNfeDet.Create);
    NfeDetIndex:= Pred(Nfe.Det.Count);
  end
  else
  begin
    for I:= 0 to Pred(Nfe.Det.Count) do
      if (Nfe.Det.Items[I].Id = TAuthService.NfeDetId) then
        NfeDetIndex:= I;
  end;

  ObjToEdt;
end;

procedure TformNfeDetCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Nfe);
end;

procedure TformNfeDetCreateEdit.lbe_itemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  v_form: TformItemList;
  CFICMS: TViewCfIcms;
  IPI: TViewCfIpi;
  PIS: TViewCfPis;
  COFINS: TViewCfCofins;
  icms_uf: string;
begin
  FreeAndNil(CFICMS);
  FreeAndNil(IPI);
  FreeAndNil(PIS);
  FreeAndNil(COFINS);
  case Key of
    112:begin
      TAuthService.ItemId:= EmptyStr;
      try
        v_form:= TformItemList.Create(nil);
        v_form.Tag:= 1;
        v_form.ShowModal;
      finally
        FreeAndNil(v_form);
      end;

      if (TAuthService.ItemId <> EmptyStr) then
      begin
        Nfe.Det.Items[NfeDetIndex].ItemId:= TAuthService.ItemId;
        if not Nfe.Det.Items[NfeDetIndex].ITEM.validade(1) then
        begin
          Nfe.Det.Items[NfeDetIndex].ItemId:= EmptyStr;
          if not Assigned(Nfe.Det.Items[NfeDetIndex].ITEM) then Exit();
        end;

        lbe_item.Text:= Nfe.Det.Items[NfeDetIndex].ITEM.Nome;
        lbe_det_cprod.Text:= Nfe.Det.Items[NfeDetIndex].ITEM.Referencia.ToString();
        lbe_det_cean.Text:= Nfe.Det.Items[NfeDetIndex].ITEM.Ean;
        lbe_det_ncm.Text:= Nfe.Det.Items[NfeDetIndex].ITEM.Ncm;
        lbe_det_extipi.Text:= Nfe.Det.Items[NfeDetIndex].ITEM.Extipi;
        lbe_det_ucom.Text:= Nfe.Det.Items[NfeDetIndex].ITEM.Unidade.Unidade;
        lbe_det_qcom.Text:= THelper.ExtendedToString(1, False);
        lbe_det_vuncom.Text:= THelper.ExtendedToString(Nfe.Det.Items[NfeDetIndex].ITEM.PrecoVenda);
        lbe_det_vprod.Text:= THelper.ExtendedToString(Nfe.Det.Items[NfeDetIndex].ITEM.PrecoVenda);
        lbe_det_ceantrib.Text:= Nfe.Det.Items[NfeDetIndex].ITEM.EanTributavel;
        lbe_det_utrib.Text:= Nfe.Det.Items[NfeDetIndex].ITEM.UnidadeTributave.Unidade;
        lbe_det_qtrib.Text:= THelper.ExtendedToString(1, False);
        lbe_det_vuntrib.Text:= THelper.ExtendedToString(Nfe.Det.Items[NfeDetIndex].ITEM.PrecoVenda);
        lbe_det_cest.Text:= Nfe.Det.Items[NfeDetIndex].ITEM.Cest;

        if Assigned(Nfe.Participante) and (Trim(Nfe.Participante.Uf) <> EmptyStr) then
          icms_uf:= Nfe.Participante.Uf
        else
          icms_uf:= Nfe.Empresa.Uf;

        CFICMS:= TViewCfIcms.find(
          Nfe.OperacaoFiscalId,
          Nfe.Det.Items[NfeDetIndex].ITEM.GrupoTributarioId,
          icms_uf);

        if Assigned(CFICMS) then
        begin
          lbe_det_cfop.Text:= CFICMS.Cfop;
          cbx_icms_orig.ItemIndex:= cbx_icms_orig.Items.IndexOf(CFICMS.Orig);
          cbx_icms_cst.ItemIndex:= cbx_icms_cst.Items.IndexOf(CFICMS.Cst);
          cbx_icms_csosn.ItemIndex:= cbx_icms_csosn.Items.IndexOf(CFICMS.Csosn);
          cbx_icms_modbc.ItemIndex:= cbx_icms_modbc.Items.IndexOf(CFICMS.Modbc);
          lbe_icms_predbc.Text:= THelper.ExtendedToString(CFICMS.Predbc);
          lbe_icms_picms.Text:= THelper.ExtendedToString(CFICMS.Picms);
          cbx_icms_modbcst.ItemIndex:= cbx_icms_modbcst.Items.IndexOf(CFICMS.Modbcst);
          lbe_icms_pmvast.Text:= THelper.ExtendedToString(CFICMS.Pmvast);
          lbe_icms_predbcst.Text:= THelper.ExtendedToString(CFICMS.Predbcst);
          lbe_icms_picmsst.Text:= THelper.ExtendedToString(CFICMS.Picmsst);
          cbx_icms_motdesicms.ItemIndex:= cbx_icms_motdesicms.Items.IndexOf(CFICMS.Motdesicms);
          lbe_icms_pcredsn.Text:= THelper.ExtendedToString(CFICMS.Pcredsn);
          lbe_icms_pdif.Text:= THelper.ExtendedToString(CFICMS.Pdif);
          lbe_icms_pfcp.Text:= THelper.ExtendedToString(CFICMS.Pfcp);
          lbe_icms_pfcpst.Text:= THelper.ExtendedToString(CFICMS.Pfcpst);
          lbe_icms_pfcpstret.Text:= THelper.ExtendedToString(CFICMS.Pfcpstret);
          lbe_icms_uf_dest_pfcpufdest.Text:= THelper.ExtendedToString(CFICMS.Pfcpufdest);
          lbe_icms_uf_dest_picmsufdest.Text:= THelper.ExtendedToString(CFICMS.Picmsufdest);
          lbe_icms_uf_dest_picmsinter.Text:= THelper.ExtendedToString(CFICMS.Picmsinter);
          lbe_icms_uf_dest_picmsinterpart.Text:= THelper.ExtendedToString(CFICMS.Picmsinterpart);
          FreeAndNil(CFICMS);
        end;

        IPI:= TViewCfIpi.find(
          Nfe.OperacaoFiscalId,
          Nfe.Det.Items[NfeDetIndex].ITEM.GrupoTributarioId);

        if Assigned(IPI) then
        begin
          lbe_ipi_clenq.Text:= IPI.Clenq;
          lbe_ipi_cnpjprod.Text:= IPI.Cnpjprod;
          lbe_ipi_cselo.Text:= IPI.Cselo;
          if (IPI.Qselo > 0) then
          lbe_ipi_qselo.Text:= IPI.Qselo.ToString();
          lbe_ipi_cenq.Text:= IPI.Cenq;
          cbx_ipi_cst.ItemIndex:= cbx_ipi_cst.Items.IndexOf(IPI.Cst);
          lbe_ipi_pipi.Text:= THelper.ExtendedToString(IPI.Pipi);
          lbe_ipi_vunid.Text:= THelper.ExtendedToString(IPI.Vunid);
          FreeAndNil(IPI);
        end;

        PIS:= TViewCfPis.find(
          Nfe.OperacaoFiscalId,
          Nfe.Det.Items[NfeDetIndex].ITEM.GrupoTributarioId);

        if Assigned(PIS) then
        begin
          cbx_pis_cst.ItemIndex:= cbx_pis_cst.Items.IndexOf(PIS.Cst);
          lbe_pis_ppis.Text:= THelper.ExtendedToString(PIS.Ppis);
          lbe_pis_valiqprod.Text:= THelper.ExtendedToString(PIS.Valiqprod);
          lbe_pisst_ppis.Text:= THelper.ExtendedToString(PIS.Ppisst);
          lbe_pisst_valiqprod.Text:= THelper.ExtendedToString(PIS.Valiqprodst);
          FreeAndNil(PIS);
        end;

        COFINS:= TViewCfCofins.find(
          Nfe.OperacaoFiscalId,
          Nfe.Det.Items[NfeDetIndex].ITEM.GrupoTributarioId);

        if Assigned(COFINS) then
        begin
          cbx_cofins_cst.ItemIndex:= cbx_cofins_cst.Items.IndexOf(COFINS.Cst);
          lbe_cofins_pcofins.Text:= THelper.ExtendedToString(COFINS.Pcofins);
          lbe_cofins_valiqprod.Text:= THelper.ExtendedToString(COFINS.Valiqprod);
          lbe_cofinsst_pcofins.Text:= THelper.ExtendedToString(COFINS.Pcofinsst);
          lbe_cofinsst_valiqprod.Text:= THelper.ExtendedToString(COFINS.Valiqprodst);
          FreeAndNil(COFINS);
        end;
      end;
    end;
  end;
end;

procedure TformNfeDetCreateEdit.ObjToEdt;
begin
  if (Nfe.Det.Items[NfeDetIndex].Id = EmptyStr) then
  begin
    ckb_det_indtot.Checked:= True;
    Exit();
  end;

  lbe_item.Text:= Nfe.Det.Items[NfeDetIndex].ITEM.Nome;
  lbe_det_cprod.Text:= Nfe.Det.Items[NfeDetIndex].Cprod;
  lbe_det_nitem.Text:= (NfeDetIndex + 1).ToString();
  lbe_det_cean.Text:= Nfe.Det.Items[NfeDetIndex].Cean;
  lbe_det_ncm.Text:= Nfe.Det.Items[NfeDetIndex].Ncm;
  lbe_det_extipi.Text:= Nfe.Det.Items[NfeDetIndex].Extipi;
  lbe_det_cfop.Text:= Nfe.Det.Items[NfeDetIndex].Cfop;
  lbe_det_ucom.Text:= Nfe.Det.Items[NfeDetIndex].Ucom;
  lbe_det_qcom.Text:= THelper.ExtendedToString(Nfe.Det.Items[NfeDetIndex].Qcom, False);
  lbe_det_vuncom.Text:= THelper.ExtendedToString(Nfe.Det.Items[NfeDetIndex].Vuncom);
  lbe_det_vprod.Text:= THelper.ExtendedToString(Nfe.Det.Items[NfeDetIndex].Vprod);
  lbe_det_ceantrib.Text:= Nfe.Det.Items[NfeDetIndex].Ceantrib;
  lbe_det_utrib.Text:= Nfe.Det.Items[NfeDetIndex].Utrib;
  lbe_det_qtrib.Text:= THelper.ExtendedToString(Nfe.Det.Items[NfeDetIndex].Qtrib, False);
  lbe_det_vuntrib.Text:= THelper.ExtendedToString(Nfe.Det.Items[NfeDetIndex].Vuntrib);
  lbe_det_vfrete.Text:= THelper.ExtendedToString(Nfe.Det.Items[NfeDetIndex].Vfrete);
  lbe_det_vseg.Text:= THelper.ExtendedToString(Nfe.Det.Items[NfeDetIndex].Vseg);
  lbe_det_vdesc.Text:= THelper.ExtendedToString(Nfe.Det.Items[NfeDetIndex].Vdesc);
  lbe_det_voutro.Text:= THelper.ExtendedToString(Nfe.Det.Items[NfeDetIndex].Voutro);
  ckb_det_indtot.Checked:= (Nfe.Det.Items[NfeDetIndex].Indtot = '1');
  lbe_det_xped.Text:= Nfe.Det.Items[NfeDetIndex].Xped;
  lbe_det_nitemped.Text:= Nfe.Det.Items[NfeDetIndex].Nitemped;
  lbe_det_nrecopi.Text:= Nfe.Det.Items[NfeDetIndex].Nrecopi;
  lbe_det_nfci.Text:= Nfe.Det.Items[NfeDetIndex].Nfci;
  lbe_det_cest.Text:= Nfe.Det.Items[NfeDetIndex].Cest;
  lbe_det_vtottrib.Text:= THelper.ExtendedToString(Nfe.Det.Items[NfeDetIndex].Vtottrib);
  lbe_det_pdevol.Text:= THelper.ExtendedToString(Nfe.Det.Items[NfeDetIndex].Pdevol);
  lbe_det_vipidevol.Text:= THelper.ExtendedToString(Nfe.Det.Items[NfeDetIndex].Vipidevol);
  lbe_det_infadprod.Text:= Nfe.Det.Items[NfeDetIndex].Infadprod;

  with Nfe.Det.Items[NfeDetIndex] do
  begin
    if Assigned(ICMS) then
    begin
      cbx_icms_orig.ItemIndex:= cbx_icms_orig.Items.IndexOf(ICMS.Orig);
      cbx_icms_cst.ItemIndex:= cbx_icms_cst.Items.IndexOf(ICMS.Cst);
      cbx_icms_csosn.ItemIndex:= cbx_icms_csosn.Items.IndexOf(ICMS.Csosn);
      cbx_icms_modbc.ItemIndex:= cbx_icms_modbc.Items.IndexOf(ICMS.Modbc);
      lbe_icms_predbc.Text:= THelper.ExtendedToString(ICMS.Predbc);
      lbe_icms_vbc.Text:= THelper.ExtendedToString(ICMS.Vbc);
      lbe_icms_picms.Text:= THelper.ExtendedToString(ICMS.Picms);
      lbe_icms_vicms.Text:= THelper.ExtendedToString(ICMS.Vicms);
      cbx_icms_modbcst.ItemIndex:= cbx_icms_modbcst.Items.IndexOf(ICMS.Modbcst);
      lbe_icms_pmvast.Text:= THelper.ExtendedToString(ICMS.Pmvast);
      lbe_icms_predbcst.Text:= THelper.ExtendedToString(ICMS.Predbcst);
      lbe_icms_vbcst.Text:= THelper.ExtendedToString(ICMS.Vbcst);
      lbe_icms_picmsst.Text:= THelper.ExtendedToString(ICMS.Picmsst);
      lbe_icms_vicmsst.Text:= THelper.ExtendedToString(ICMS.Vicmsst);
      cbx_icms_ufst.ItemIndex:= cbx_icms_ufst.Items.IndexOf(ICMS.Ufst);
      lbe_icms_pbcop.Text:= THelper.ExtendedToString(ICMS.Pbcop);
      lbe_icms_vbcstret.Text:= THelper.ExtendedToString(ICMS.Vbcstret);
      lbe_icms_vicmsstret.Text:= THelper.ExtendedToString(ICMS.Vicmsstret);
      cbx_icms_motdesicms.ItemIndex:= cbx_icms_motdesicms.Items.IndexOf(ICMS.Motdesicms);
      lbe_icms_pcredsn.Text:= THelper.ExtendedToString(ICMS.Pcredsn);
      lbe_icms_vcredicmssn.Text:= THelper.ExtendedToString(ICMS.Vcredicmssn);
      lbe_icms_vbcstdest.Text:= THelper.ExtendedToString(ICMS.Vbcstdest);
      lbe_icms_vicmsstdest.Text:= THelper.ExtendedToString(ICMS.Vicmsstdest);
      lbe_icms_vicmsdeson.Text:= THelper.ExtendedToString(ICMS.Vicmsdeson);
      lbe_icms_vicmsop.Text:= THelper.ExtendedToString(ICMS.Vicmsop);
      lbe_icms_vicmsop.Text:= THelper.ExtendedToString(ICMS.Vicmsop);
      lbe_icms_pdif.Text:= THelper.ExtendedToString(ICMS.Pdif);
      lbe_icms_vicmsdif.Text:= THelper.ExtendedToString(ICMS.Vicmsdif);
      lbe_icms_vbcfcp.Text:= THelper.ExtendedToString(ICMS.Vbcfcp);
      lbe_icms_pfcp.Text:= THelper.ExtendedToString(ICMS.Pfcp);
      lbe_icms_vfcp.Text:= THelper.ExtendedToString(ICMS.Vfcp);
      lbe_icms_vbcfcpst.Text:= THelper.ExtendedToString(ICMS.Vbcfcpst);
      lbe_icms_pfcpst.Text:= THelper.ExtendedToString(ICMS.Pfcpst);
      lbe_icms_vfcpst.Text:= THelper.ExtendedToString(ICMS.Vfcpst);
      lbe_icms_vbcfcpstret.Text:= THelper.ExtendedToString(ICMS.Vbcfcpstret);
      lbe_icms_pfcpstret.Text:= THelper.ExtendedToString(ICMS.Pfcpstret);
      lbe_icms_vfcpstret.Text:= THelper.ExtendedToString(ICMS.Vfcpstret);
      lbe_icms_pst.Text:= THelper.ExtendedToString(ICMS.Pst);
    end;

    if Assigned(ICMSUFDest) then
    begin
      lbe_icms_uf_dest_vbcufdest.Text:= THelper.ExtendedToString(ICMSUFDest.Vbcufdest);
      lbe_icms_uf_dest_vbcfcpufdest.Text:= THelper.ExtendedToString(ICMSUFDest.Vbcfcpufdest);
      lbe_icms_uf_dest_pfcpufdest.Text:= THelper.ExtendedToString(ICMSUFDest.Pfcpufdest);
      lbe_icms_uf_dest_picmsufdest.Text:= THelper.ExtendedToString(ICMSUFDest.Picmsufdest);
      lbe_icms_uf_dest_picmsinter.Text:= THelper.ExtendedToString(ICMSUFDest.Picmsinter);
      lbe_icms_uf_dest_picmsinterpart.Text:= THelper.ExtendedToString(ICMSUFDest.Picmsinterpart);
      lbe_icms_uf_dest_vfcpufdest.Text:= THelper.ExtendedToString(ICMSUFDest.Vfcpufdest);
      lbe_icms_uf_dest_vicmsufdest.Text:= THelper.ExtendedToString(ICMSUFDest.Vicmsufdest);
      lbe_icms_uf_dest_vicmsufremet.Text:= THelper.ExtendedToString(ICMSUFDest.Vicmsufremet);
    end;

    if Assigned(IPI) then
    begin
      lbe_ipi_clenq.Text:= IPI.Clenq;
      lbe_ipi_cnpjprod.Text:= IPI.Cnpjprod;
      lbe_ipi_cselo.Text:= IPI.Cselo;
      if (IPI.Qselo > 0) then
      lbe_ipi_qselo.Text:= IPI.Qselo.ToString();
      lbe_ipi_cenq.Text:= IPI.Cenq;
      cbx_ipi_cst.ItemIndex:= cbx_ipi_cst.Items.IndexOf(IPI.Cst);
      lbe_ipi_vbc.Text:= THelper.ExtendedToString(IPI.Vbc);
      lbe_ipi_qunid.Text:= THelper.ExtendedToString(IPI.Qunid, False);
      lbe_ipi_vunid.Text:= THelper.ExtendedToString(IPI.Vunid);
      lbe_ipi_pipi.Text:= THelper.ExtendedToString(IPI.Pipi);
      lbe_ipi_vipi.Text:= THelper.ExtendedToString(IPI.Vipi);
    end;

    if Assigned(II) then
    begin
      lbe_ii_vbc.Text:= THelper.ExtendedToString(II.Vbc);
      lbe_ii_vdespadu.Text:= THelper.ExtendedToString(II.Vdespadu);
      lbe_ii_vii.Text:= THelper.ExtendedToString(II.Vii);
      lbe_ii_viof.Text:= THelper.ExtendedToString(II.Viof);
    end;

    if Assigned(PIS) then
    begin
      cbx_pis_cst.ItemIndex:= cbx_pis_cst.Items.IndexOf(PIS.Cst);
      lbe_pis_vbc.Text:= THelper.ExtendedToString(PIS.Vbc);
      lbe_pis_ppis.Text:= THelper.ExtendedToString(PIS.Ppis);
      lbe_pis_qbcprod.Text:= THelper.ExtendedToString(PIS.Qbcprod, False);
      lbe_pis_valiqprod.Text:= THelper.ExtendedToString(PIS.Valiqprod);
      lbe_pis_vpis.Text:= THelper.ExtendedToString(PIS.Vpis);
    end;

    if Assigned(PISST) then
    begin
      lbe_pisst_vbc.Text:= THelper.ExtendedToString(PISST.Vbc);
      lbe_pisst_ppis.Text:= THelper.ExtendedToString(PISST.Ppis);
      lbe_pisst_qbcprod.Text:= THelper.ExtendedToString(PISST.Qbcprod, False);
      lbe_pisst_valiqprod.Text:= THelper.ExtendedToString(PISST.Valiqprod);
      lbe_pisst_vpis.Text:= THelper.ExtendedToString(PISST.Vpis);
    end;

    if Assigned(COFINS) then
    begin
      cbx_cofins_cst.ItemIndex:= cbx_cofins_cst.Items.IndexOf(COFINS.Cst);
      lbe_cofins_vbc.Text:= THelper.ExtendedToString(COFINS.Vbc);
      lbe_cofins_pcofins.Text:= THelper.ExtendedToString(COFINS.Pcofins);
      lbe_cofins_qbcprod.Text:= THelper.ExtendedToString(COFINS.Qbcprod, False);
      lbe_cofins_vbcprod.Text:= THelper.ExtendedToString(COFINS.Vbcprod);
      lbe_cofins_valiqprod.Text:= THelper.ExtendedToString(COFINS.Valiqprod);
      lbe_cofins_vcofins.Text:= THelper.ExtendedToString(COFINS.Vcofins);
    end;

    if Assigned(COFINSST) then
    begin
      lbe_cofinsst_vbc.Text:= THelper.ExtendedToString(COFINSST.Vbc);
      lbe_cofinsst_pcofins.Text:= THelper.ExtendedToString(COFINSST.Pcofins);
      lbe_cofinsst_qbcprod.Text:= THelper.ExtendedToString(COFINSST.Qbcprod, False);
      lbe_cofinsst_valiqprod.Text:= THelper.ExtendedToString(COFINSST.Valiqprod);
      lbe_cofinsst_vcofins.Text:= THelper.ExtendedToString(COFINSST.Vcofins);
    end;
  end;
end;

procedure TformNfeDetCreateEdit.save;
begin
  EdtToObj;
  try
    Nfe.processaCalculos();
    if Nfe.save() then
    begin
      TAuthService.NfeDetId:= Nfe.Det.Items[NfeDetIndex].Id;
      Close;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

end.
