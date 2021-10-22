unit uformNfeList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Tabs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, System.Actions, Vcl.ActnList, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Nfe, System.Math, NfeCobrDup,
  Vcl.Menus, Vcl.ComCtrls, System.DateUtils, System.StrUtils;

type
  TformNfeList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_head: TPanel;
    ts_nfes: TTabSet;
    ntb_nfes: TNotebook;
    pnl_nfes_body: TPanel;
    pnl_itens_body: TPanel;
    bvl_4: TBevel;
    bvl_6: TBevel;
    dbg_itens: TDBGrid;
    pnl_itens_footer: TPanel;
    btn_item_update: TButton;
    btn_item_store: TButton;
    btn_item_rollback: TButton;
    fdmt_nfes: TFDMemTable;
    ds_nfes: TDataSource;
    acl_nfes: TActionList;
    act_rollback: TAction;
    tmr_focus: TTimer;
    fdmt_nfesID: TStringField;
    fdmt_nfesSERIE: TIntegerField;
    fdmt_nfesNNF: TIntegerField;
    fdmt_nfesDEMI: TDateField;
    fdmt_nfesPARTICIPANTE: TStringField;
    fdmt_nfesVNF: TCurrencyField;
    bvl_3: TBevel;
    dbg_nfes: TDBGrid;
    pnl_nfes_footer: TPanel;
    btn_nfe_store: TButton;
    btn_nfe_update: TButton;
    btn_rollback: TButton;
    pnl_nfes_search: TPanel;
    lbe_nfes_search: TLabeledEdit;
    act_nfe_store: TAction;
    act_nfe_update: TAction;
    pnl_emitente_body: TPanel;
    pnl_emitente_footer: TPanel;
    btn_emitente_confirmar: TButton;
    btn_emitente_rollback: TButton;
    bvl_5: TBevel;
    act_rollback_listagem: TAction;
    pnl_destinatario_body: TPanel;
    bvl_7: TBevel;
    pnl_destinatario_footer: TPanel;
    btn_destinatario_confirmar: TButton;
    btn_destinatario_rollback: TButton;
    lbe_emit_cep: TLabeledEdit;
    lbe_emit_cmun: TLabeledEdit;
    lbe_emit_cnae: TLabeledEdit;
    lbe_emit_cnpjcpf: TLabeledEdit;
    lbe_emit_cpais: TLabeledEdit;
    lbe_emit_crt: TLabeledEdit;
    lbe_emit_fone: TLabeledEdit;
    lbe_emit_ie: TLabeledEdit;
    lbe_emit_iest: TLabeledEdit;
    lbe_emit_im: TLabeledEdit;
    lbe_emit_nro: TLabeledEdit;
    lbe_emit_uf: TLabeledEdit;
    lbe_emit_xbairro: TLabeledEdit;
    lbe_emit_xcpl: TLabeledEdit;
    lbe_emit_xlgr: TLabeledEdit;
    lbe_emit_xmun: TLabeledEdit;
    lbe_emit_xnome: TLabeledEdit;
    lbe_emit_xpais: TLabeledEdit;
    lbe_dest_cep: TLabeledEdit;
    lbe_dest_cmun: TLabeledEdit;
    lbe_dest_isuf: TLabeledEdit;
    lbe_dest_cnpjcpf: TLabeledEdit;
    lbe_dest_cpais: TLabeledEdit;
    lbe_dest_im: TLabeledEdit;
    lbe_dest_fone: TLabeledEdit;
    lbe_dest_idestrangeiro: TLabeledEdit;
    lbe_dest_indiedest: TLabeledEdit;
    lbe_dest_ie: TLabeledEdit;
    lbe_dest_nro: TLabeledEdit;
    lbe_dest_uf: TLabeledEdit;
    lbe_dest_xbairro: TLabeledEdit;
    lbe_dest_xcpl: TLabeledEdit;
    lbe_dest_xlgr: TLabeledEdit;
    lbe_dest_xmun: TLabeledEdit;
    lbe_dest_xnome: TLabeledEdit;
    lbe_dest_xpais: TLabeledEdit;
    lbe_dest_email: TLabeledEdit;
    pnl_itens_search: TPanel;
    lbe_itens_search: TLabeledEdit;
    act_destinatario_confirmar: TAction;
    act_item_store: TAction;
    act_item_update: TAction;
    fdmt_dets: TFDMemTable;
    ds_dets: TDataSource;
    fdmt_detsID: TStringField;
    btn_nota_fiscal: TButton;
    act_nfe_enviar: TAction;
    fdmt_nfesCHNFE: TStringField;
    fdmt_detsCPROD: TStringField;
    fdmt_detsXPROD: TStringField;
    fdmt_detsNCM: TStringField;
    fdmt_detsCST: TStringField;
    fdmt_detsCSOSN: TStringField;
    fdmt_detsCFOP: TStringField;
    fdmt_detsUCOM: TStringField;
    fdmt_detsQCOM: TFloatField;
    fdmt_detsVUNCOM: TFloatField;
    fdmt_detsVDESC: TFloatField;
    fdmt_detsVPROD: TFloatField;
    pnl_transporte_body: TPanel;
    pnl_transporte_footer: TPanel;
    btn_transporte_confirmar: TButton;
    btn_transporte_rollback: TButton;
    bvl_8: TBevel;
    lbe_transp_xnome: TLabeledEdit;
    lbe_transp_cnpjcpf: TLabeledEdit;
    lbe_transp_ie: TLabeledEdit;
    lbe_transp_xender: TLabeledEdit;
    lbe_transp_xmun: TLabeledEdit;
    lbe_transp_uf: TLabeledEdit;
    lbe_transp_vagao: TLabeledEdit;
    lbe_transp_balsa: TLabeledEdit;
    act_transporte_confirmar: TAction;
    pnl_totais_body: TPanel;
    pnl_totais_footer: TPanel;
    btn_totais_confirmar: TButton;
    btn_totais_rollback: TButton;
    bvl_9: TBevel;
    lbe_icmstot_vbc: TLabeledEdit;
    lbe_icmstot_vicms: TLabeledEdit;
    lbe_icmstot_vicmsdeson: TLabeledEdit;
    lbe_icmstot_vfcpufdest: TLabeledEdit;
    lbe_icmstot_vicmsufdest: TLabeledEdit;
    lbe_icmstot_vicmsufremet: TLabeledEdit;
    lbe_icmstot_vfcp: TLabeledEdit;
    lbe_icmstot_vbcst: TLabeledEdit;
    lbe_icmstot_vst: TLabeledEdit;
    lbe_icmstot_vfcpst: TLabeledEdit;
    lbe_icmstot_vfcpstret: TLabeledEdit;
    lbe_icmstot_vprod: TLabeledEdit;
    lbe_icmstot_vfrete: TLabeledEdit;
    lbe_icmstot_vseg: TLabeledEdit;
    lbe_icmstot_vdesc: TLabeledEdit;
    lbe_icmstot_vii: TLabeledEdit;
    lbe_icmstot_vipi: TLabeledEdit;
    lbe_icmstot_vipidevol: TLabeledEdit;
    lbe_icmstot_vpis: TLabeledEdit;
    lbe_icmstot_vcofins: TLabeledEdit;
    lbe_icmstot_voutro: TLabeledEdit;
    lbe_icmstot_vnf: TLabeledEdit;
    lbe_icmstot_vtottrib: TLabeledEdit;
    act_totais_confirmar: TAction;
    pnl_cobranca_body: TPanel;
    pnl_cobranca_footer: TPanel;
    btn_cobranca_confirmar: TButton;
    btn_cobranca_rollback: TButton;
    bvl_10: TBevel;
    act_cobranca_confirmar: TAction;
    lbe_cobranca_nfat: TLabeledEdit;
    lbe_cobranca_vorig: TLabeledEdit;
    lbe_cobranca_vdesc: TLabeledEdit;
    lbe_cobranca_vliq: TLabeledEdit;
    gpb_duplicatas: TGroupBox;
    DBGrid1: TDBGrid;
    lbe_cobranca_first_venc: TLabeledEdit;
    lbe_cobranca_parcelas: TLabeledEdit;
    fdmt_dups: TFDMemTable;
    fdmt_dupsNDUP: TStringField;
    fdmt_dupsDVENC: TDateField;
    fdmt_dupsVDUP: TFloatField;
    ds_dups: TDataSource;
    btn_gera_duplicatas: TButton;
    act_nfe_imprimir: TAction;
    fdmt_nfesCSTAT: TIntegerField;
    btn_item_destroy: TButton;
    act_item_destroy: TAction;
    ppm_nfe: TPopupMenu;
    F4EMITIRNOTAFISCAL: TMenuItem;
    F5IMPRIMIRNOTAFISCAL: TMenuItem;
    pnl_pagamento_body: TPanel;
    pnl_pagamento_footer: TPanel;
    btn_pagamento_confirmar: TButton;
    btn_pagamento_rollback: TButton;
    bvl_11: TBevel;
    act_pagamento_confirmar: TAction;
    lbe_pagamento_vpag: TLabeledEdit;
    lbe_pagamento_cnpj: TLabeledEdit;
    lbe_pagamento_caut: TLabeledEdit;
    lbe_pagamento_vtroco: TLabeledEdit;
    fdmt_pag: TFDMemTable;
    fdmt_pagTPAG: TStringField;
    fdmt_pagVPAG: TFloatField;
    fdmt_pagTPINTEGRA: TStringField;
    fdmt_pagCNPJ: TStringField;
    fdmt_pagTBAND: TStringField;
    fdmt_pagCAUT: TStringField;
    fdmt_pagVTROCO: TFloatField;
    gpb_pagamento: TGroupBox;
    dbg_pagamento: TDBGrid;
    ds_pag: TDataSource;
    btn_pagamento_adicionar: TButton;
    btn_pagamento_limpar: TButton;
    fdmt_dupsID: TStringField;
    fdmt_pagID: TStringField;
    lb_pagamento_total_nfe: TLabel;
    lb_pagamento_total: TLabel;
    pnl_referencias: TPanel;
    gpb_refcte: TGroupBox;
    gpb_refecf: TGroupBox;
    gpb_refnf: TGroupBox;
    gpb_refnfe: TGroupBox;
    gpb_refnfp: TGroupBox;
    btn_referencias_refcte_remover: TButton;
    btn_referencias_refcte_adicionar: TButton;
    lbe_refcte_chnfe: TLabeledEdit;
    fdmt_refcte: TFDMemTable;
    fdmt_refcteID: TStringField;
    fdmt_refcteCHNFE: TStringField;
    ds_refcte: TDataSource;
    act_referencias_refcte_remover: TAction;
    act_referencias_refcte_adicionar: TAction;
    dbg_refcte: TDBGrid;
    dbg_refecf: TDBGrid;
    fdmt_refecf: TFDMemTable;
    fdmt_refecfID: TStringField;
    fdmt_refecfMODELO: TStringField;
    fdmt_refecfNECF: TStringField;
    fdmt_refecfNCOO: TStringField;
    btn_referencias_refecf_remover: TButton;
    btn_referencias_refecf_adicionar: TButton;
    ds_refecf: TDataSource;
    lbe_refecf_modelo: TLabeledEdit;
    lbe_refecf_necf: TLabeledEdit;
    lbe_refecf_ncoo: TLabeledEdit;
    act_referencias_refecf_remover: TAction;
    act_referencias_refecf_adicionar: TAction;
    dbg_refnfe: TDBGrid;
    lbe_refnfe_chnfe: TLabeledEdit;
    btn_referencias_refnfe_remover: TButton;
    btn_referencias_refnfe_adicionar: TButton;
    fdmt_refnfe: TFDMemTable;
    fdmt_refnfeID: TStringField;
    fdmt_refnfeCHNFE: TStringField;
    ds_refnfe: TDataSource;
    act_referencias_refnfe_remover: TAction;
    act_referencias_refnfe_adicionar: TAction;
    dbg_refnf: TDBGrid;
    btn_referencias_refnf_remover: TButton;
    btn_referencias_refnf_adicionar: TButton;
    lbe_refnf_cuf: TLabeledEdit;
    lbe_refnf_aamm: TLabeledEdit;
    lbe_refnf_cnpj: TLabeledEdit;
    lbe_refnf_modelo: TLabeledEdit;
    lbe_refnf_serie: TLabeledEdit;
    lbe_refnf_nnf: TLabeledEdit;
    act_referencias_refnf_remover: TAction;
    act_referencias_refnf_adicionar: TAction;
    fdmt_refnf: TFDMemTable;
    fdmt_refnfID: TStringField;
    fdmt_refnfCUF: TIntegerField;
    fdmt_refnfAAMM: TStringField;
    fdmt_refnfCNPJ: TStringField;
    fdmt_refnfMODELO: TIntegerField;
    fdmt_refnfSERIE: TIntegerField;
    fdmt_refnfNNF: TIntegerField;
    ds_refnf: TDataSource;
    dbg_refnfp: TDBGrid;
    btn_referencias_refnfp_remover: TButton;
    btn_referencias_refnfp_adicionar: TButton;
    lbe_refnfp_cuf: TLabeledEdit;
    lbe_refnfp_aamm: TLabeledEdit;
    lbe_refnfp_cnpjcpf: TLabeledEdit;
    lbe_refnfp_modelo: TLabeledEdit;
    lbe_refnfp_serie: TLabeledEdit;
    lbe_refnfp_nnf: TLabeledEdit;
    lbe_refnfp_ie: TLabeledEdit;
    fdmt_refnfp: TFDMemTable;
    fdmt_refnfpID: TStringField;
    fdmt_refnfpCUF: TIntegerField;
    fdmt_refnfpAAMM: TStringField;
    fdmt_refnfpCNPJCPF: TStringField;
    fdmt_refnfpIE: TStringField;
    fdmt_refnfpMODELO: TStringField;
    fdmt_refnfpSERIE: TIntegerField;
    fdmt_refnfpNNF: TIntegerField;
    ds_refnfp: TDataSource;
    act_referencias_refnfp_remover: TAction;
    act_referencias_refnfp_adicionar: TAction;
    pnl_info_adicionais: TPanel;
    pnl_info_adicionais_footer: TPanel;
    btn_info_adicionais_rollback: TButton;
    bvl_12: TBevel;
    gpb_infcpl: TGroupBox;
    mm_infcpl: TMemo;
    gpb_infadfisco: TGroupBox;
    mm_infadfisco: TMemo;
    act_info_adicionais_confirmar: TAction;
    btn_info_adicionais_confirmar: TButton;
    act_nfe_cancelar: TAction;
    F6CANCELARNOTAFISCAL: TMenuItem;
    act_nfe_inutilizar: TAction;
    F7INUTILIZARNOTAFISCAL: TMenuItem;
    act_nfe_corrigir: TAction;
    F8CORRIGIRNOTAFISCAL: TMenuItem;
    fdmt_nfesNSEQEVENTO: TIntegerField;
    fdmt_nfesSITUACAO: TStringField;
    act_nfe_imprimir_carta: TAction;
    F5IMPRIMIRCARTA1: TMenuItem;
    dtp_start: TDateTimePicker;
    dtp_end: TDateTimePicker;
    act_nfe_exportar_xml: TAction;
    F10EXPORTARXML: TMenuItem;
    act_nfe_email: TAction;
    ENVIAREMAIL: TMenuItem;
    act_nfe_atualizar: TAction;
    ATUALIZAR: TMenuItem;
    fdmt_nfesMODELO: TStringField;
    cbx_transp_modfrete: TComboBox;
    lb_transp_modfrete: TLabel;
    cbx_pagamento_tpag: TComboBox;
    lb_pagamento_tpag: TLabel;
    ckb_pagamento_tpintegra: TCheckBox;
    cbx_pagamento_tband: TComboBox;
    lb_pagamento_tband: TLabel;
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_nfe_storeExecute(Sender: TObject);
    procedure dbg_nfesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure lbe_nfes_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure act_nfe_updateExecute(Sender: TObject);
    procedure act_rollback_listagemExecute(Sender: TObject);
    procedure acl_nfesUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure ts_nfesChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure lbe_dest_xnomeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure act_destinatario_confirmarExecute(Sender: TObject);
    procedure act_item_storeExecute(Sender: TObject);
    procedure act_item_updateExecute(Sender: TObject);
    procedure act_nfe_enviarExecute(Sender: TObject);
    procedure act_transporte_confirmarExecute(Sender: TObject);
    procedure lbe_transp_xnomeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_icmstot_vfreteChange(Sender: TObject);
    procedure act_totais_confirmarExecute(Sender: TObject);
    procedure act_cobranca_confirmarExecute(Sender: TObject);
    procedure lbe_cobranca_vorigChange(Sender: TObject);
    procedure btn_gera_duplicatasClick(Sender: TObject);
    procedure act_nfe_imprimirExecute(Sender: TObject);
    procedure act_item_destroyExecute(Sender: TObject);
    procedure act_pagamento_confirmarExecute(Sender: TObject);
    procedure btn_pagamento_adicionarClick(Sender: TObject);
    procedure btn_pagamento_limparClick(Sender: TObject);
    procedure act_referencias_refcte_removerExecute(Sender: TObject);
    procedure act_referencias_refcte_adicionarExecute(Sender: TObject);
    procedure act_referencias_refecf_removerExecute(Sender: TObject);
    procedure act_referencias_refecf_adicionarExecute(Sender: TObject);
    procedure act_referencias_refnfe_removerExecute(Sender: TObject);
    procedure act_referencias_refnfe_adicionarExecute(Sender: TObject);
    procedure act_referencias_refnf_removerExecute(Sender: TObject);
    procedure act_referencias_refnf_adicionarExecute(Sender: TObject);
    procedure act_referencias_refnfp_removerExecute(Sender: TObject);
    procedure act_referencias_refnfp_adicionarExecute(Sender: TObject);
    procedure mm_infcplKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mm_infadfiscoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure act_info_adicionais_confirmarExecute(Sender: TObject);
    procedure act_nfe_cancelarExecute(Sender: TObject);
    procedure act_nfe_inutilizarExecute(Sender: TObject);
    procedure act_nfe_corrigirExecute(Sender: TObject);
    procedure act_nfe_imprimir_cartaExecute(Sender: TObject);
    procedure tmr_focusTimer(Sender: TObject);
    procedure act_nfe_exportar_xmlExecute(Sender: TObject);
    procedure act_nfe_emailExecute(Sender: TObject);
    procedure act_nfe_atualizarExecute(Sender: TObject);
  private
    { Private declarations }
    Nfe: TNfe;
    procedure list(search: string);
    procedure EMITObjToEdt();
    procedure DESTObjToEdt();
    procedure TOTAISObjToEdt();
    procedure TRANSPObjToEdt();
    procedure EdtToObjTRANSP();
    procedure COBObjToEdt();
    procedure PAGObjToEdt();
    procedure REFObjToEdt();
    procedure INFObjToEdt();

    procedure ClearEditsPagamento();
    procedure SomaTotalPagamentos();
  public
    { Public declarations }
  end;

var
  formNfeList: TformNfeList;

implementation

uses
  AuthService, uformNfeCreateEdit, uformPessoaList, uformNfeDetCreateEdit,
  NfeDet, Pessoa, Helper, CustomEditHelper, udmRepository, NfePag, NfeRefCte,
  NfeRefEcf, NfeRefNfe, NfeRefNf, NfeRefNfp, uformInfCplList,
  uformInfadfiscoList, uformDescription;

{$R *.dfm}

procedure TformNfeList.acl_nfesUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  ts_nfes.Enabled:= (fdmt_nfes.RecordCount >= 1);
  if ts_nfes.Enabled then ntb_nfes.PageIndex:= ts_nfes.TabIndex;

  act_nfe_update.Enabled:= (fdmt_nfes.RecordCount >= 1) and
                           (fdmt_nfesCSTAT.AsInteger = 0);

  act_nfe_enviar.Enabled:= (fdmt_nfes.RecordCount >= 1) and
                           (fdmt_nfesCSTAT.AsInteger in[0,99]) and
                           (fdmt_nfesPARTICIPANTE.AsString <> EmptyStr) and
                           (StrToIntDef(fdmt_nfesMODELO.AsString, 0) in[55,65]);

  act_nfe_imprimir.Enabled:= (fdmt_nfes.RecordCount >= 1) and
                             (fdmt_nfesCSTAT.AsInteger in[99,100,150,101,151]);

  act_nfe_cancelar.Enabled:= (fdmt_nfes.RecordCount >= 1) and
                             (fdmt_nfesCSTAT.AsInteger in[100,150]);

  act_nfe_inutilizar.Enabled:= (fdmt_nfes.RecordCount >= 1) and
                               (fdmt_nfesCSTAT.AsInteger = 0) and
                               (StrToIntDef(fdmt_nfesMODELO.AsString, 0) in[55,65]);

  act_nfe_corrigir.Enabled:= (fdmt_nfes.RecordCount >= 1) and
                             (fdmt_nfesCSTAT.AsInteger in[100,150]) and
                             (fdmt_nfesMODELO.AsString = '55');

  act_nfe_imprimir_carta.Enabled:= (fdmt_nfes.RecordCount >= 1) and
                                   (fdmt_nfesCSTAT.AsInteger in[100,150]) and
                                   (fdmt_nfesNSEQEVENTO.AsInteger >= 1);

  act_nfe_exportar_xml.Enabled:= (fdmt_nfes.RecordCount >= 1) and
                                 (fdmt_nfesCSTAT.AsInteger in[100,150,101,151]);

  act_nfe_email.Enabled:= (fdmt_nfes.RecordCount >= 1) and
                          (fdmt_nfesCSTAT.AsInteger in[100,150,101,151]);

  act_nfe_atualizar.Enabled:= (fdmt_nfes.RecordCount >= 1) and
                              (fdmt_nfesCSTAT.AsInteger in[100,150,101,151]);

  act_destinatario_confirmar.Enabled:= (fdmt_nfesCSTAT.AsInteger = 0);

  act_item_store.Enabled:= (fdmt_nfesCSTAT.AsInteger = 0);
  act_item_update.Enabled:= (fdmt_nfesCSTAT.AsInteger = 0);
  act_item_destroy.Enabled:= (fdmt_nfesCSTAT.AsInteger = 0);

  act_totais_confirmar.Enabled:= (fdmt_nfesCSTAT.AsInteger = 0);

  act_transporte_confirmar.Enabled:= (fdmt_nfesCSTAT.AsInteger = 0);

  act_cobranca_confirmar.Enabled:= (fdmt_nfesCSTAT.AsInteger = 0);

  act_pagamento_confirmar.Enabled:= (fdmt_nfesCSTAT.AsInteger = 0) and
                                    (fdmt_pag.RecordCount >= 1);

  act_referencias_refcte_remover.Enabled:= (fdmt_refcte.RecordCount >= 1);
  act_referencias_refcte_adicionar.Enabled:= (Length(Trim(lbe_refcte_chnfe.Text)) = 44);

  act_referencias_refecf_remover.Enabled:= (fdmt_refecf.RecordCount >= 1);

  act_referencias_refnf_remover.Enabled:= (fdmt_refnf.RecordCount >= 1);

  act_referencias_refnfe_remover.Enabled:= (fdmt_refnfe.RecordCount >= 1);
  act_referencias_refnfe_adicionar.Enabled:= (Length(Trim(lbe_refnfe_chnfe.Text)) = 44);

  act_referencias_refnfp_remover.Enabled:= (fdmt_refnfp.RecordCount >= 1);

  act_info_adicionais_confirmar.Enabled:= (fdmt_nfesCSTAT.AsInteger = 0);

  tmr_focus.Enabled:= (ntb_nfes.PageIndex = 0) and (not lbe_nfes_search.Focused)
end;

procedure TformNfeList.act_nfe_emailExecute(Sender: TObject);
begin
  try
    TNfe.enviarEmail(fdmt_nfesID.AsString);
  except on e: exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformNfeList.act_cobranca_confirmarExecute(Sender: TObject);
begin
  try
    Nfe.Fat.Nfat:= lbe_cobranca_nfat.Text;
    Nfe.Fat.Vorig:= THelper.StringToExtended(lbe_cobranca_vorig.Text);
    Nfe.Fat.Vdesc:= THelper.StringToExtended(lbe_cobranca_vdesc.Text);
    Nfe.Fat.Vliq:= THelper.StringToExtended(lbe_cobranca_vliq.Text);

    Nfe.Dup.Clear;
    fdmt_dups.DisableControls;
    fdmt_dups.First;
    while not fdmt_dups.Eof do
    begin
      Nfe.Dup.Add(TNfeCobrDup.Create);
      Nfe.Dup.Last.Id:= fdmt_dupsID.AsString;
      Nfe.Dup.Last.Ndup:= fdmt_dupsNDUP.AsString;
      Nfe.Dup.Last.Dvenc:= fdmt_dupsDVENC.AsDateTime;
      Nfe.Dup.Last.Vdup:= fdmt_dupsVDUP.AsExtended;

      fdmt_dups.Next;
    end;
    fdmt_dups.First;
    fdmt_dups.EnableControls;

    if Nfe.save then ts_nfes.TabIndex:= 0;
  except on e: Exception do
    raise Exception.Create(e.Message);
  end;
end;

procedure TformNfeList.act_destinatario_confirmarExecute(Sender: TObject);
begin
  try
    if Nfe.save then ts_nfes.TabIndex:= 3;
  except on e: Exception do
    raise Exception.Create(e.Message);
  end;
end;

procedure TformNfeList.act_info_adicionais_confirmarExecute(Sender: TObject);
begin
  try
    if Nfe.save then ts_nfes.TabIndex:= 0;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformNfeList.act_item_destroyExecute(Sender: TObject);
begin
  //
end;

procedure TformNfeList.act_item_storeExecute(Sender: TObject);
var
  v_form: TformNfeDetCreateEdit;
begin
  TAuthService.NfeId:= Nfe.Id;;
  TAuthService.NfeDetId:= EmptyStr;
  try
    v_form:= TformNfeDetCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.NfeDetId <> EmptyStr) then
    TNfeDet.findByNfeId(Nfe.Id, fdmt_dets);
end;

procedure TformNfeList.act_item_updateExecute(Sender: TObject);
var
  v_form: TformNfeDetCreateEdit;
begin
  TAuthService.NfeId:= Nfe.Id;;
  TAuthService.NfeDetId:= fdmt_detsID.AsString;
  try
    v_form:= TformNfeDetCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.NfeDetId <> EmptyStr) then
    TNfeDet.findByNfeId(Nfe.Id, fdmt_dets);
end;

procedure TformNfeList.act_nfe_cancelarExecute(Sender: TObject);
var
  v_form: TformDescription;
begin
  TAuthService.Description:= 'JUSTIFICATIVA';
  try
    v_form:= TformDescription.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.Description = EmptyStr)  then Exit();

  try
    TNfe.cancelar(fdmt_nfesID.AsString);
    list(Trim(lbe_nfes_search.Text));
  except on e: exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformNfeList.act_nfe_atualizarExecute(Sender: TObject);
begin
  try
    TNfe.atualizar(fdmt_nfesID.AsString);
    list(Trim(lbe_nfes_search.Text));
  except on e: exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformNfeList.act_nfe_corrigirExecute(Sender: TObject);
var
  v_form: TformDescription;
begin
  TAuthService.Description:= 'CARTA';
  try
    v_form:= TformDescription.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.Description = EmptyStr) then Exit();

  try
    TNfe.corrigir(fdmt_nfesID.AsString);
    list(Trim(lbe_nfes_search.Text));
  except on e: exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformNfeList.act_nfe_enviarExecute(Sender: TObject);
begin
  try
    try
      Nfe:= TNfe.find(fdmt_nfesID.AsString);
      Nfe.processaCalculos();
      Nfe.save();
      Nfe.enviar();
      list(Trim(lbe_nfes_search.Text));
    except on e: exception do
      THelper.Mensagem(e.Message);
    end;
  finally
    FreeAndNil(Nfe);
  end;
end;

procedure TformNfeList.act_nfe_exportar_xmlExecute(Sender: TObject);
begin
  try
    TNfe.exportarXML(fdmt_nfesID.AsString,'');
  except on e: exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformNfeList.act_nfe_imprimirExecute(Sender: TObject);
begin
  case fdmt_nfesCSTAT.AsInteger of
    99,100,101,150,151: TNfe.imprimir(fdmt_nfesID.AsString, 0);
  end;
end;

procedure TformNfeList.act_nfe_imprimir_cartaExecute(Sender: TObject);
begin
  TNfe.imprimir(fdmt_nfesID.AsString, 1);
end;

procedure TformNfeList.act_nfe_inutilizarExecute(Sender: TObject);
var
  v_form: TformDescription;
begin
  TAuthService.Description:= 'JUSTIFICATIVA';
  try
    v_form:= TformDescription.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.Description = EmptyStr) then Exit();

  try
    TNfe.inutilizar(fdmt_nfesID.AsString);
    list(Trim(lbe_nfes_search.Text));
  except on e: exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformNfeList.act_nfe_storeExecute(Sender: TObject);
var
  v_form: TformNfeCreateEdit;
begin
  TAuthService.NfeId:= EmptyStr;
  try
    FreeAndNil(v_form);
    v_form:= TformNfeCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.NfeId <> EmptyStr) then
  begin
    list(Trim(lbe_nfes_search.Text));
  end;
end;

procedure TformNfeList.act_nfe_updateExecute(Sender: TObject);
var
  v_form: TformNfeCreateEdit;
begin
  TAuthService.NfeId:= fdmt_nfesID.AsString;
  try
    v_form:= TformNfeCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.NfeId <> EmptyStr) then
  begin
    list(Trim(lbe_nfes_search.Text));
  end;
end;

procedure TformNfeList.act_pagamento_confirmarExecute(Sender: TObject);
begin
  try
    Nfe.Pag.Clear;
    fdmt_pag.DisableControls;
    fdmt_pag.First;

    while not fdmt_pag.Eof do
    begin
      Nfe.Pag.Add(TNfePag.Create);
      Nfe.Pag.Last.Id:= fdmt_pagID.AsString;
      Nfe.Pag.Last.Tpag:= fdmt_pagTPAG.AsString;
      Nfe.Pag.Last.Vpag:= fdmt_pagVPAG.AsExtended;
      Nfe.Pag.Last.Tpintegra:= fdmt_pagTPINTEGRA.AsString;
      Nfe.Pag.Last.Cnpj:= fdmt_pagCNPJ.AsString;
      Nfe.Pag.Last.Tband:= fdmt_pagTBAND.AsString;
      Nfe.Pag.Last.Caut:= fdmt_pagCAUT.AsString;
      Nfe.Pag.Last.Vtroco:= fdmt_pagVTROCO.AsExtended;

      fdmt_pag.Next;
    end;
    fdmt_pag.First;
    fdmt_pag.EnableControls;

    if Nfe.save then ts_nfes.TabIndex:= 0;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformNfeList.act_referencias_refcte_adicionarExecute(Sender: TObject);
var
  v_refcte: TNfeRefCte;
begin
  try
    try
      v_refcte:= TNfeRefCte.Create;
      v_refcte.NfeId:= Nfe.Id;
      v_refcte.Chnfe:= Trim(lbe_refcte_chnfe.Text);
      if v_refcte.save then
      begin
        lbe_refcte_chnfe.Text:= EmptyStr;
        TNfeRefCte.findByNfeId(Nfe.Id, fdmt_refcte);
      end;
    except on e: Exception do
      THelper.Mensagem(e.Message);
    end;
  finally
    FreeAndNil(v_refcte);
  end;
end;

procedure TformNfeList.act_referencias_refcte_removerExecute(Sender: TObject);
begin
  if TNfeRefCte.remove(fdmt_refcteID.AsString) then
    TNfeRefCte.findByNfeId(Nfe.Id, fdmt_refcte);
end;

procedure TformNfeList.act_referencias_refecf_adicionarExecute(Sender: TObject);
var
  v_refecf: TNfeRefEcf;
begin
  try
    try
      v_refecf:= TNfeRefEcf.Create;
      v_refecf.NfeId:= Nfe.Id;
      v_refecf.Modelo:= Trim(lbe_refecf_modelo.Text);
      v_refecf.Necf:= Trim(lbe_refecf_necf.Text);
      v_refecf.Ncoo:= Trim(lbe_refecf_ncoo.Text);
      if v_refecf.save then
      begin
        lbe_refecf_modelo.Text:= EmptyStr;
        lbe_refecf_necf.Text:= EmptyStr;
        lbe_refecf_ncoo.Text:= EmptyStr;
        TNfeRefEcf.findByNfeId(Nfe.Id, fdmt_refecf);
      end;
    except on e: Exception do
      THelper.Mensagem(e.Message);
    end;
  finally
    FreeAndNil(v_refecf);
  end;
end;

procedure TformNfeList.act_referencias_refecf_removerExecute(Sender: TObject);
begin
  if TNfeRefEcf.remove(fdmt_refecfID.AsString) then
    TNfeRefEcf.findByNfeId(Nfe.Id, fdmt_refecf);
end;

procedure TformNfeList.act_referencias_refnfe_adicionarExecute(Sender: TObject);
var
  v_refnfe: TNfeRefNfe;
begin
  try
    try
      v_refnfe:= TNfeRefNfe.Create;
      v_refnfe.NfeId:= Nfe.Id;
      v_refnfe.Chnfe:= Trim(lbe_refnfe_chnfe.Text);
      if v_refnfe.save then
      begin
        lbe_refnfe_chnfe.Text:= EmptyStr;
        TNfeRefNfe.findByNfeId(Nfe.Id, fdmt_refnfe);
      end;
    except on e: Exception do
      THelper.Mensagem(e.Message);
    end;
  finally
    FreeAndNil(v_refnfe);
  end;
end;

procedure TformNfeList.act_referencias_refnfe_removerExecute(Sender: TObject);
begin
  if TNfeRefNfe.remove(fdmt_refcteID.AsString) then
    TNfeRefNfe.findByNfeId(Nfe.Id, fdmt_refnfe);
end;

procedure TformNfeList.act_referencias_refnfp_adicionarExecute(Sender: TObject);
var
  v_refnfp: TNfeRefNfp;
begin
  try
    try
      v_refnfp:= TNfeRefNfp.Create;
      v_refnfp.NfeId:= Nfe.Id;
      v_refnfp.Cuf:= StrToIntDef(lbe_refnfp_cuf.Text, 0);
      v_refnfp.Aamm:= Trim(lbe_refnfp_aamm.Text);
      v_refnfp.Cnpjcpf:= Trim(lbe_refnfp_cnpjcpf.Text);
      v_refnfp.Ie:= Trim(lbe_refnfp_ie.Text);
      v_refnfp.Modelo:= Trim(lbe_refnfp_modelo.Text);
      v_refnfp.Serie:= StrToIntDef(lbe_refnfp_serie.Text, 0);
      v_refnfp.Nnf:= StrToIntDef(lbe_refnfp_nnf.Text, 0);
      if v_refnfp.save then
      begin
        lbe_refnfp_cuf.Text:= EmptyStr;
        lbe_refnfp_aamm.Text:= EmptyStr;
        lbe_refnfp_cnpjcpf.Text:= EmptyStr;
        lbe_refnfp_ie.Text:= EmptyStr;
        lbe_refnfp_modelo.Text:= EmptyStr;
        lbe_refnfp_serie.Text:= EmptyStr;
        lbe_refnfp_nnf.Text:= EmptyStr;
        TNfeRefNfp.findByNfeId(Nfe.Id, fdmt_refnfp);
      end;
    except on e: Exception do
      THelper.Mensagem(e.Message);
    end;
  finally
    FreeAndNil(v_refnfp);
  end;
end;

procedure TformNfeList.act_referencias_refnfp_removerExecute(Sender: TObject);
begin
  if TNfeRefNfp.remove(fdmt_refnfpID.AsString) then
    TNfeRefNfp.findByNfeId(Nfe.Id, fdmt_refnfp);
end;

procedure TformNfeList.act_referencias_refnf_adicionarExecute(Sender: TObject);
var
  v_refnf: TNfeRefNf;
begin
  try
    try
      v_refnf:= TNfeRefNf.Create;
      v_refnf.NfeId:= Nfe.Id;
      v_refnf.Cuf:= StrToIntDef(lbe_refnf_cuf.Text, 0);
      v_refnf.Aamm:= Trim(lbe_refnf_aamm.Text);
      v_refnf.Cnpj:= Trim(lbe_refnf_cnpj.Text);
      v_refnf.Modelo:= StrToIntDef(lbe_refnf_modelo.Text, 0);
      v_refnf.Serie:= StrToIntDef(lbe_refnf_serie.Text, 0);
      v_refnf.Nnf:= StrToIntDef(lbe_refnf_nnf.Text, 0);
      if v_refnf.save then
      begin
        lbe_refnf_cuf.Text:= EmptyStr;
        lbe_refnf_aamm.Text:= EmptyStr;
        lbe_refnf_cnpj.Text:= EmptyStr;
        lbe_refnf_modelo.Text:= EmptyStr;
        lbe_refnf_serie.Text:= EmptyStr;
        lbe_refnf_nnf.Text:= EmptyStr;
        TNfeRefNf.findByNfeId(Nfe.Id, fdmt_refnf);
      end;
    except on e: Exception do
      THelper.Mensagem(e.Message);
    end;
  finally
    FreeAndNil(v_refnf);
  end;
end;

procedure TformNfeList.act_referencias_refnf_removerExecute(Sender: TObject);
begin
  if TNfeRefNf.remove(fdmt_refnfID.AsString) then
    TNfeRefNf.findByNfeId(Nfe.Id, fdmt_refnf);
end;

procedure TformNfeList.act_rollbackExecute(Sender: TObject);
begin
  Close;
end;

procedure TformNfeList.act_rollback_listagemExecute(Sender: TObject);
begin
  ts_nfes.TabIndex:= 0;
end;

procedure TformNfeList.act_totais_confirmarExecute(Sender: TObject);
var
  vFreteTotal,
  vFreteItem,
  vFreteSobra,
  vSegTotal,
  vSegItem,
  vSegSobra,
  vOutroTotal,
  vOutroItem,
  vOutroSobra,
  vProd,
  vDescTotal,
  pDescItem,
  vSomaDescItem: Extended;
  I: Integer;
begin
  try
    vFreteTotal:= THelper.StringToExtended(lbe_icmstot_vfrete.Text);
    vFreteItem:= THelper.TruncateValue(SimpleRoundTo((vFreteTotal / Nfe.Det.Count), -6), 2);
    vFreteSobra:= vFreteTotal - (vFreteItem * Nfe.Det.Count);

    vSegTotal:= THelper.StringToExtended(lbe_icmstot_vseg.Text);
    vSegItem:= THelper.TruncateValue(SimpleRoundTo((vSegTotal / Nfe.Det.Count), -6), 2);
    vSegSobra:= vSegTotal - (vSegItem * Nfe.Det.Count);

    vOutroTotal:= THelper.StringToExtended(lbe_icmstot_voutro.Text);
    vOutroItem:= THelper.TruncateValue(SimpleRoundTo((vOutroTotal / Nfe.Det.Count), -6), 2);
    vOutroSobra:= vOutroTotal - (vOutroItem * Nfe.Det.Count);

    vDescTotal:= THelper.StringToExtended(lbe_icmstot_vdesc.Text);
    if (vDescTotal > 0) then
    begin
      vProd:= THelper.StringToExtended(lbe_icmstot_vprod.Text);
      pDescItem:= THelper.TruncateValue(SimpleRoundTo((vDescTotal * 100) / vProd, -6), 2);
      vSomaDescItem:= 0;
    end;

    for I:= 0 to Pred(Nfe.Det.Count) do
    begin
      if (vFreteTotal > 0) then
      begin
        Nfe.Det.Items[I].Vfrete:= vFreteItem;
        if (I = Pred(Nfe.Det.Count)) then
          Nfe.Det.Items[I].Vfrete:= vFreteItem + vFreteSobra;
      end
      else Nfe.Det.Items[I].Vfrete:= 0;

      if (vSegTotal > 0) then
      begin
        Nfe.Det.Items[I].Vseg:= vSegItem;
        if (I = Pred(Nfe.Det.Count)) then
          Nfe.Det.Items[I].Vseg:= vSegItem + vSegSobra;
      end
      else Nfe.Det.Items[I].Vseg:= 0;

      if (vOutroTotal > 0) then
      begin
        Nfe.Det.Items[I].Voutro:= vOutroItem;
        if (I = Pred(Nfe.Det.Count)) then
          Nfe.Det.Items[I].Voutro:= vOutroItem + vOutroSobra;
      end
      else Nfe.Det.Items[I].Voutro:= 0;

      if (vDescTotal > 0) then
      begin
        Nfe.Det.Items[I].Vdesc:= THelper.TruncateValue(SimpleRoundTo((Nfe.Det.Items[I].Vprod * pDescItem) / 100, -6), 2);
        vSomaDescItem:= vSomaDescItem + Nfe.Det.Items[I].Vdesc;
        if (I = Pred(Nfe.Det.Count)) then
          Nfe.Det.Items[I].Vdesc:= Nfe.Det.Items[I].Vdesc + (vDescTotal - vSomaDescItem);
      end
      else Nfe.Det.Items[I].Vdesc:= 0;
    end;

    Nfe.processaCalculos();
    Nfe.save();
  except on e: Exception do
    raise Exception.Create(e.Message);
  end;
end;

procedure TformNfeList.act_transporte_confirmarExecute(Sender: TObject);
begin
  EdtToObjTRANSP();
  try
    if Nfe.save then ts_nfes.TabIndex:= 0;
  except on e: Exception do
    raise Exception.Create(e.Message);
  end;
end;

procedure TformNfeList.btn_gera_duplicatasClick(Sender: TObject);
var
  vNumeroFatura: string;
  vLiq,
  vParcela,
  vTotalParcelas: Extended;
  vQuantidadeParcelas: Integer;
  vDataParcela: TDate;
  I: Integer;
begin
  vNumeroFatura:= lbe_cobranca_nfat.Text;
  vLiq:= THelper.StringToExtended(lbe_cobranca_vliq.Text);
  vDataParcela:= StrToDateDef(lbe_cobranca_first_venc.Text, Now);
  vQuantidadeParcelas:= StrToIntDef(lbe_cobranca_parcelas.Text, 1);
  vParcela:= THelper.TruncateValue(SimpleRoundTo((vLiq / vQuantidadeParcelas), -6), 2);
  vTotalParcelas:= 0;

  fdmt_dups.Open();
  fdmt_dups.DisableControls;
  fdmt_dups.EmptyDataSet;
  for I:= 1 to vQuantidadeParcelas do
  begin
    vTotalParcelas:= (vTotalParcelas + vParcela);
    fdmt_dups.Append();
    fdmt_dupsNDUP.AsString:= vNumeroFatura + '-' + I.ToString();
    fdmt_dupsDVENC.AsDateTime:= vDataParcela;
    fdmt_dupsVDUP.AsExtended:= vParcela;
    if (I = vQuantidadeParcelas) then
      fdmt_dupsVDUP.AsExtended:= vParcela + (vLiq - vTotalParcelas);
    fdmt_dups.Post();

    vDataParcela:= IncMonth(vDataParcela);
  end;
  fdmt_dups.First;
  fdmt_dups.EnableControls;
end;

procedure TformNfeList.btn_pagamento_adicionarClick(Sender: TObject);
begin
  fdmt_pag.Append;
  case cbx_pagamento_tpag.ItemIndex of
    00: fdmt_pagTPAG.AsString:= '01';
    01: fdmt_pagTPAG.AsString:= '02';
    02: fdmt_pagTPAG.AsString:= '03';
    03: fdmt_pagTPAG.AsString:= '04';
    04: fdmt_pagTPAG.AsString:= '05';
    05: fdmt_pagTPAG.AsString:= '10';
    06: fdmt_pagTPAG.AsString:= '11';
    07: fdmt_pagTPAG.AsString:= '12';
    08: fdmt_pagTPAG.AsString:= '13';
    09: fdmt_pagTPAG.AsString:= '14';
    10: fdmt_pagTPAG.AsString:= '15';
    11: fdmt_pagTPAG.AsString:= '90';
    12: fdmt_pagTPAG.AsString:= '99';
  end;
  fdmt_pagVPAG.AsExtended:= THelper.StringToExtended(lbe_pagamento_vpag.Text);
  fdmt_pagTPINTEGRA.AsString:= IfThen(ckb_pagamento_tpintegra.Checked, '1', '2');
  fdmt_pagCNPJ.AsString:= lbe_pagamento_cnpj.Text;
  case cbx_pagamento_tband.ItemIndex of
    0: fdmt_pagTBAND.AsString:= '01';
    1: fdmt_pagTBAND.AsString:= '02';
    2: fdmt_pagTBAND.AsString:= '03';
    3: fdmt_pagTBAND.AsString:= '04';
    4: fdmt_pagTBAND.AsString:= '05';
    5: fdmt_pagTBAND.AsString:= '06';
    6: fdmt_pagTBAND.AsString:= '07';
    7: fdmt_pagTBAND.AsString:= '08';
    8: fdmt_pagTBAND.AsString:= '09';
    9: fdmt_pagTBAND.AsString:= '99';
    else
      fdmt_pagTBAND.AsString:= '';
  end;
  fdmt_pagCAUT.AsString:= lbe_pagamento_caut.Text;
  fdmt_pagVTROCO.AsExtended:= THelper.StringToExtended(lbe_pagamento_vtroco.Text);

  ClearEditsPagamento();
  SomaTotalPagamentos();
end;

procedure TformNfeList.btn_pagamento_limparClick(Sender: TObject);
begin
  fdmt_pag.EmptyDataSet;
  SomaTotalPagamentos();
  btn_pagamento_adicionar.Enabled:= not (fdmt_pag.RecordCount >=1);
end;

procedure TformNfeList.ClearEditsPagamento;
begin
  cbx_pagamento_tpag.ItemIndex:= 0;
  lbe_pagamento_vpag.Text:= THelper.ExtendedToString(0);
  ckb_pagamento_tpintegra.Checked:= False;
  lbe_pagamento_cnpj.Text:= EmptyStr;
  cbx_pagamento_tband.ItemIndex:= -1;
  lbe_pagamento_caut.Text:= EmptyStr;
  lbe_pagamento_vtroco.Text:= THelper.ExtendedToString(0);
end;

procedure TformNfeList.COBObjToEdt;
begin
  lbe_cobranca_nfat.Text:= Nfe.Fat.Nfat;
  if (Nfe.Fat.Nfat = EmptyStr) then
    lbe_cobranca_nfat.Text:= Nfe.Nnf.ToString();
  lbe_cobranca_vorig.Text:= THelper.ExtendedToString(Nfe.Fat.Vorig);
  lbe_cobranca_vdesc.Text:= THelper.ExtendedToString(Nfe.Fat.Vdesc);
  lbe_cobranca_vliq.Text:= THelper.ExtendedToString(Nfe.Fat.Vliq);
  if (Nfe.Dup.Count > 0) then
  begin
    lbe_cobranca_first_venc.Text:= FormatDateTime('dd/mm/yyyy', Nfe.Dup.First.Dvenc);
    lbe_cobranca_parcelas.Text:= Nfe.Dup.Count.ToString();
  end
  else
  begin
    lbe_cobranca_first_venc.Text:= FormatDateTime('dd/mm/yyyy', Now);
    lbe_cobranca_parcelas.Text:= '1';
  end;
  TNfeCobrDup.findByNfeId(Nfe.Id, fdmt_dups);
end;

procedure TformNfeList.dbg_nfesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  If (gdSelected in state) then
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);
end;

procedure TformNfeList.DESTObjToEdt;
var
  I: Integer;
begin
  if not Assigned(Nfe.Participante) then
  begin
    for I:= 0 to Pred(pnl_destinatario_body.ControlCount) do
      if (pnl_destinatario_body.Controls[I] is TLabeledEdit) then
        TLabeledEdit(pnl_destinatario_body.Controls[I]).Text:= EmptyStr;

    Exit();
  end;

  lbe_dest_xnome.Text:= Nfe.Participante.Nome;
  lbe_dest_cnpjcpf.Text:= Nfe.Participante.Documento;
  lbe_dest_idestrangeiro.Text:= Nfe.Participante.Idestrangeiro;
  lbe_dest_indiedest.Text:= Nfe.Participante.Indiedest;
  lbe_dest_ie.Text:= Nfe.Participante.Ie;
  lbe_dest_isuf.Text:= Nfe.Participante.Isuf;
  lbe_dest_im.Text:= Nfe.Participante.Im;
  lbe_dest_xlgr.Text:= Nfe.Participante.Logradouro;
  lbe_dest_nro.Text:= Nfe.Participante.Numero;
  lbe_dest_xcpl.Text:= Nfe.Participante.Complemento;
  lbe_dest_xbairro.Text:= Nfe.Participante.Bairro;
  lbe_dest_cmun.Text:= Nfe.Participante.CodigoMunicipio;
  lbe_dest_xmun.Text:= Nfe.Participante.NomeMunicipio;
  lbe_dest_uf.Text:= Nfe.Participante.Uf;
  lbe_dest_cep.Text:= Nfe.Participante.Cep;
  lbe_dest_cpais.Text:= '1058';
  lbe_dest_xpais.Text:= 'BRASIL';
  lbe_dest_fone.Text:= Nfe.Participante.Fone;
  lbe_dest_email.Text:= Nfe.Participante.Email;
end;

procedure TformNfeList.EdtToObjTRANSP;
begin
  case cbx_transp_modfrete.ItemIndex of
    0: Nfe.Transp.Modfrete:= '0';
    1: Nfe.Transp.Modfrete:= '1';
    2: Nfe.Transp.Modfrete:= '2';
    3: Nfe.Transp.Modfrete:= '3';
    4: Nfe.Transp.Modfrete:= '4';
    5: Nfe.Transp.Modfrete:= '9';
  end;
  Nfe.Transp.Xnome:= lbe_transp_xnome.Text;
  Nfe.Transp.Cnpjcpf:= lbe_transp_cnpjcpf.Text;
  Nfe.Transp.Ie:= lbe_transp_ie.Text;
  Nfe.Transp.Xender:= lbe_transp_xender.Text;
  Nfe.Transp.Xmun:= lbe_transp_xmun.Text;
  Nfe.Transp.Uf:= lbe_transp_uf.Text;
  Nfe.Transp.Vagao:= lbe_transp_vagao.Text;
  Nfe.Transp.Balsa:= lbe_transp_balsa.Text;
end;

procedure TformNfeList.EMITObjToEdt;
begin
  lbe_emit_xnome.Text:= Nfe.Empresa.RazaoSocial;
  lbe_emit_cnpjcpf.Text:= Nfe.Empresa.Documento;
  lbe_emit_ie.Text:= Nfe.Empresa.Ie;
  lbe_emit_iest.Text:= Nfe.Empresa.Iest;
  lbe_emit_im.Text:= Nfe.Empresa.im;
  lbe_emit_cnae.Text:= Nfe.Empresa.cnae;
  lbe_emit_crt.Text:= Nfe.Empresa.crt;
  lbe_emit_xlgr.Text:= Nfe.Empresa.Logradouro;
  lbe_emit_nro.Text:= Nfe.Empresa.Numero;
  lbe_emit_xcpl.Text:= Nfe.Empresa.Complemento;
  lbe_emit_xbairro.Text:= Nfe.Empresa.Bairro;
  lbe_emit_cmun.Text:= Nfe.Empresa.CodigoMunicipio;
  lbe_emit_xmun.Text:= Nfe.Empresa.NomeMunicipio;
  lbe_emit_uf.Text:= Nfe.Empresa.Uf;
  lbe_emit_cep.Text:= Nfe.Empresa.Cep;
  lbe_emit_cpais.Text:= '1058';
  lbe_emit_xpais.Text:= 'BRASIL';
  lbe_emit_fone.Text:= Nfe.Empresa.Fone;
end;

procedure TformNfeList.FormCreate(Sender: TObject);
begin
  inherited;
  dtp_start.Date:= StartOfTheMonth(Now);
  dtp_end.Date:= Now;

  TCustomEdit(lbe_icmstot_vbc).EditFloat();
  TCustomEdit(lbe_icmstot_vicms).EditFloat();
  TCustomEdit(lbe_icmstot_vicmsdeson).EditFloat();
  TCustomEdit(lbe_icmstot_vfcpufdest).EditFloat();
  TCustomEdit(lbe_icmstot_vicmsufdest).EditFloat();
  TCustomEdit(lbe_icmstot_vicmsufremet).EditFloat();
  TCustomEdit(lbe_icmstot_vfcp).EditFloat();
  TCustomEdit(lbe_icmstot_vbcst).EditFloat();
  TCustomEdit(lbe_icmstot_vst).EditFloat();
  TCustomEdit(lbe_icmstot_vfcpst).EditFloat();
  TCustomEdit(lbe_icmstot_vfcpstret).EditFloat();
  TCustomEdit(lbe_icmstot_vprod).EditFloat();
  TCustomEdit(lbe_icmstot_vfrete).EditFloat();
  TCustomEdit(lbe_icmstot_vseg).EditFloat();
  TCustomEdit(lbe_icmstot_vdesc).EditFloat();
  TCustomEdit(lbe_icmstot_vii).EditFloat();
  TCustomEdit(lbe_icmstot_vipi).EditFloat();
  TCustomEdit(lbe_icmstot_vipidevol).EditFloat();
  TCustomEdit(lbe_icmstot_vpis).EditFloat();
  TCustomEdit(lbe_icmstot_vcofins).EditFloat();
  TCustomEdit(lbe_icmstot_voutro).EditFloat();
  TCustomEdit(lbe_icmstot_vnf).EditFloat();
  TCustomEdit(lbe_icmstot_vtottrib).EditFloat();

  TCustomEdit(lbe_cobranca_vorig).EditFloat();
  TCustomEdit(lbe_cobranca_vdesc).EditFloat();
  TCustomEdit(lbe_cobranca_vliq).EditFloat();

  TCustomEdit(lbe_pagamento_vpag).EditFloat();
  TCustomEdit(lbe_pagamento_vtroco).EditFloat();

  ts_nfes.TabIndex:= 0;
  ntb_nfes.PageIndex:= 0;
  list('');
end;

procedure TformNfeList.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Nfe);
end;

procedure TformNfeList.INFObjToEdt;
begin
  mm_infcpl.Clear;
  mm_infadfisco.Clear;

  if Assigned(Nfe.Infcpl) then
    mm_infcpl.Text:= Nfe.Infcpl.Infcpl;
  if Assigned(Nfe.Infadfisco) then
    mm_infadfisco.Text:= Nfe.Infadfisco.Infadfisco;
end;

procedure TformNfeList.lbe_cobranca_vorigChange(Sender: TObject);
var
  vLiq: Extended;
begin
  vLiq:= THelper.StringToExtended(lbe_cobranca_vorig.Text)
         - THelper.StringToExtended(lbe_cobranca_vdesc.Text);

  lbe_cobranca_vliq.Text:= THelper.ExtendedToString(vLiq);
end;

procedure TformNfeList.lbe_dest_xnomeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  v_form: TformPessoaList;
begin
  case Key of
    112: begin
      TAuthService.PessoaId:= EmptyStr;
      try
        v_form:= TformPessoaList.Create(nil);
        v_form.Tag:= 1;
        v_form.ShowModal;
      finally
        FreeAndNil(v_form);
      end;

      if (TAuthService.PessoaId <> EmptyStr) then
      begin
        Nfe.ParticipanteId:= TAuthService.PessoaId;
        DESTObjToEdt;
      end;
    end;
  end;
end;

procedure TformNfeList.lbe_icmstot_vfreteChange(Sender: TObject);
var
  vpVNF: Extended;
begin
  vpVNF:=
    THelper.StringToExtended(lbe_icmstot_vprod.Text)
    - THelper.StringToExtended(lbe_icmstot_vdesc.Text)
    - THelper.StringToExtended(lbe_icmstot_vicmsdeson.Text)
    + THelper.StringToExtended(lbe_icmstot_vst.Text)
    + THelper.StringToExtended(lbe_icmstot_vfcpst.Text)
    + THelper.StringToExtended(lbe_icmstot_vfrete.Text)
    + THelper.StringToExtended(lbe_icmstot_vseg.Text)
    + THelper.StringToExtended(lbe_icmstot_voutro.Text)
    + THelper.StringToExtended(lbe_icmstot_vii.Text)
    + THelper.StringToExtended(lbe_icmstot_vipi.Text)
    + THelper.StringToExtended(lbe_icmstot_vipidevol.Text);

  lbe_icmstot_vnf.Text:= THelper.ExtendedToString(vpVNF);
end;

procedure TformNfeList.lbe_nfes_searchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: list(Trim(TCustomEdit(Sender).Text));
    38: begin
      fdmt_nfes.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_nfes.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformNfeList.lbe_transp_xnomeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  v_form: TformPessoaList;
begin
  case Key of
    112: begin
      TAuthService.PessoaId:= EmptyStr;
      try
        v_form:= TformPessoaList.Create(nil);
        v_form.Tag:= 1;
        v_form.ShowModal;
      finally
        FreeAndNil(v_form);
      end;

      if (TAuthService.PessoaId <> EmptyStr) then
      begin
        with TPessoa.find(TAuthService.PessoaId) do
        begin
          lbe_transp_xnome.Text:= Nome;
          lbe_transp_cnpjcpf.Text:= Documento;
          lbe_transp_ie.Text:= Ie;
          lbe_transp_xender.Text:= Logradouro + ', ' + Numero + ', ' + Bairro;
          lbe_transp_xmun.Text:= NomeMunicipio;
          lbe_transp_uf.Text:= Uf;
          Free;
        end;
      end;
    end;
  end;
end;

procedure TformNfeList.list(search: string);
begin
  TNfe.list(dtp_start.Date, dtp_end.Date, search, fdmt_nfes);
end;

procedure TformNfeList.mm_infadfiscoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  v_form: TformInfadfiscoList;
begin
  case Key of
    112: begin
      TAuthService.NfeInfadfiscoId:= EmptyStr;
      try
        v_form:= TformInfadfiscoList.Create(nil);
        v_form.Tag:= 1;
        v_form.ShowModal;
      finally
        FreeAndNil(v_form);
      end;

      if (TAuthService.NfeInfadfiscoId <> EmptyStr) then
      begin
        Nfe.NfeInfadfiscoId:= TAuthService.NfeInfadfiscoId;
        mm_infadfisco.Text:= Nfe.Infadfisco.Infadfisco;
      end;
    end;
  end;
end;

procedure TformNfeList.mm_infcplKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  v_form: TformInfCplList;
begin
  case Key of
    112: begin
      TAuthService.NfeInfcplId:= EmptyStr;
      try
        v_form:= TformInfCplList.Create(nil);
        v_form.Tag:= 1;
        v_form.ShowModal;
      finally
        FreeAndNil(v_form);
      end;

      if (TAuthService.NfeInfcplId <> EmptyStr) then
      begin
        Nfe.NfeInfcplId:= TAuthService.NfeInfcplId;
        mm_infcpl.Text:= Nfe.Infcpl.Infcpl;
      end;
    end;
  end;
end;

procedure TformNfeList.PAGObjToEdt;
begin
  ClearEditsPagamento();
  lb_pagamento_total_nfe.Caption:= 'Total da nota: ' + THelper.ExtendedToString(Nfe.ICMSTot.Vnf);
  TNfePag.findByNfeId(Nfe.Id, fdmt_pag);
  SomaTotalPagamentos();
  btn_pagamento_adicionar.Enabled:= not (fdmt_pag.RecordCount >=1);
end;

procedure TformNfeList.REFObjToEdt;
begin
  TNfeRefCte.findByNfeId(Nfe.Id, fdmt_refcte);
  TNfeRefEcf.findByNfeId(Nfe.Id, fdmt_refecf);
  TNfeRefNf.findByNfeId(Nfe.Id, fdmt_refnf);
  TNfeRefNfe.findByNfeId(Nfe.Id, fdmt_refnfe);
end;

procedure TformNfeList.SomaTotalPagamentos;
var
  v_total: Extended;
begin
  v_total:= 0;

  fdmt_pag.DisableControls;
  fdmt_pag.First;
  while not fdmt_pag.Eof do
  begin
    v_total:= v_total + (fdmt_pagVPAG.AsExtended - fdmt_pagVTROCO.AsExtended);
    fdmt_pag.Next;
  end;
  fdmt_pag.EnableControls;

  lb_pagamento_total.Caption:= 'Total recebido: ' + THelper.ExtendedToString(v_total);
end;

procedure TformNfeList.tmr_focusTimer(Sender: TObject);
begin
  try
    if (ntb_nfes.PageIndex = 0) and
    not lbe_nfes_search.Focused and
    not dtp_start.Focused and
    not dtp_end.Focused then lbe_nfes_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= False;
  end;
end;

procedure TformNfeList.TOTAISObjToEdt;
begin
  lbe_icmstot_vbc.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Vbc);
  lbe_icmstot_vicms.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Vicms);
  lbe_icmstot_vicmsdeson.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Vicmsdeson);
  lbe_icmstot_vfcpufdest.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Vfcpufdest);
  lbe_icmstot_vicmsufdest.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Vicmsufdest);
  lbe_icmstot_vicmsufremet.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Vicmsufremet);
  lbe_icmstot_vfcp.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Vfcp);
  lbe_icmstot_vbcst.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Vbcst);
  lbe_icmstot_vst.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Vst);
  lbe_icmstot_vfcpst.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Vfcpst);
  lbe_icmstot_vfcpstret.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Vfcpstret);
  lbe_icmstot_vprod.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Vprod);
  lbe_icmstot_vfrete.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Vfrete);
  lbe_icmstot_vseg.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Vseg);
  lbe_icmstot_vdesc.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Vdesc);
  lbe_icmstot_vii.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Vii);
  lbe_icmstot_vipi.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Vipi);
  lbe_icmstot_vipidevol.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Vipidevol);
  lbe_icmstot_vpis.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Vpis);
  lbe_icmstot_vcofins.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Vcofins);
  lbe_icmstot_voutro.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Voutro);
  lbe_icmstot_vnf.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Vnf);
  lbe_icmstot_vtottrib.Text:= THelper.ExtendedToString(Nfe.ICMSTot.Vtottrib);
end;

procedure TformNfeList.TRANSPObjToEdt;
begin
  cbx_transp_modfrete.ItemIndex:= AnsiIndexStr(Nfe.Transp.Modfrete, ['0', '1','2', '3', '4', '9']);
  lbe_transp_xnome.Text:= Nfe.Transp.Xnome;
  lbe_transp_cnpjcpf.Text:= Nfe.Transp.Cnpjcpf;
  lbe_transp_ie.Text:= Nfe.Transp.Ie;
  lbe_transp_xender.Text:= Nfe.Transp.Xender;
  lbe_transp_xmun.Text:= Nfe.Transp.Xmun;
  lbe_transp_uf.Text:= Nfe.Transp.Uf;
  lbe_transp_vagao.Text:= Nfe.Transp.Vagao;
  lbe_transp_balsa.Text:= Nfe.Transp.Balsa;
end;

procedure TformNfeList.ts_nfesChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  if (NewTab >= 1) then
  begin
    if Assigned(Nfe) then FreeAndNil(Nfe);
    Nfe:= TNfe.find(fdmt_nfesID.AsString);
  end
  else FreeAndNil(Nfe);

  case NewTab of
    0: list(Trim(lbe_nfes_search.Text));
    1: EMITObjToEdt();
    2: DESTObjToEdt();
    3: TNfeDet.findByNfeId(Nfe.Id, fdmt_dets);
    4: TOTAISObjToEdt();
    5: TRANSPObjToEdt();
    6: COBObjToEdt();
    7: PAGObjToEdt();
    8: REFObjToEdt();
    9: INFObjToEdt();
  end;
end;

end.
