unit uformConfiguracaoFiscalList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Tabs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Actions, Vcl.ActnList, ConfiguracaoFiscal, ConfiguracaoFiscalIpi,
  CustomEditHelper, ConfiguracaoFiscalPis, ConfiguracaoFiscalCofins;

type
  TformConfiguracaoFiscalList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_head: TPanel;
    ts_configuracoes: TTabSet;
    ntb_configuracoes: TNotebook;
    pnl_configuracoes_body: TPanel;
    bvl_3: TBevel;
    pnl_configuracoes_footer: TPanel;
    btn_configuracao_store: TButton;
    btn_configuracao_update: TButton;
    btn_rollback: TButton;
    dbg_configuracoes: TDBGrid;
    pnl_configuracoes_search: TPanel;
    lbe_configuracoes_search: TLabeledEdit;
    pnl_icms_body: TPanel;
    bvl_4: TBevel;
    dbg_icms: TDBGrid;
    pnl_icms_footer: TPanel;
    btn_icms_update: TButton;
    btn_icms_store: TButton;
    pnl_ipi_body: TPanel;
    pnl_ipi_footer: TPanel;
    btn_ipi_confirmar: TButton;
    btn_ipi_rollback: TButton;
    bvl_5: TBevel;
    acl_configuracoes: TActionList;
    act_rollback: TAction;
    act_configuracao_store: TAction;
    act_configuracao_update: TAction;
    tmr_focus: TTimer;
    ds_configuracoes: TDataSource;
    fdmt_configuracoes: TFDMemTable;
    fdmt_configuracoesID: TStringField;
    fdmt_configuracoesOPERACAO_FISCAL: TStringField;
    fdmt_configuracoesGRUPO_TRIBUTARIO: TStringField;
    act_icms_store: TAction;
    fdmt_icms: TFDMemTable;
    ds_icms: TDataSource;
    fdmt_icmsID: TStringField;
    fdmt_icmsUF_DESTINO: TStringField;
    bvl_6: TBevel;
    act_icms_update: TAction;
    act_icms_rollback: TAction;
    btn_icms_rollback: TButton;
    act_ipi_rollback: TAction;
    act_ipi_confirmar: TAction;
    lbe_clenq: TLabeledEdit;
    lbe_cnpjprod: TLabeledEdit;
    lbe_cselo: TLabeledEdit;
    lbe_qselo: TLabeledEdit;
    lbe_cenq: TLabeledEdit;
    lbe_pipi: TLabeledEdit;
    lbe_vunid: TLabeledEdit;
    pnl_pis_body: TPanel;
    bvl_7: TBevel;
    pnl_pis_footer: TPanel;
    btn_pis_confirmar: TButton;
    btn_pis_rollback: TButton;
    act_pis_rollback: TAction;
    act_pis_confirmar: TAction;
    lbe_ppis: TLabeledEdit;
    lbe_valiqprod: TLabeledEdit;
    lbe_ppisst: TLabeledEdit;
    lbe_valiqprodst: TLabeledEdit;
    pnl_cofins_body: TPanel;
    lbe_pcofins: TLabeledEdit;
    lbe_cofins_valiqprod: TLabeledEdit;
    lbe_pcofinsst: TLabeledEdit;
    lbe_cofins_valiqprodst: TLabeledEdit;
    bvl_8: TBevel;
    pnl_cofins_footer: TPanel;
    btn_cofins_confirmar: TButton;
    btn_cofins_rollback: TButton;
    act_cofins_rollback: TAction;
    act_cofins_confirmar: TAction;
    btn_configuracao_destroy: TButton;
    act_configuracao_destroy: TAction;
    btn_icms_destroy: TButton;
    act_icms_destroy: TAction;
    lb_ipi_hint: TLabel;
    cbx_ipi_cst: TComboBox;
    lb_ipi_cst: TLabel;
    cbx_cofins_cst: TComboBox;
    lb_cofins_cst: TLabel;
    lb_cofins_hint: TLabel;
    cbx_pis_cst: TComboBox;
    lb_pis_cst: TLabel;
    lb_pis_hint: TLabel;
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_configuracao_storeExecute(Sender: TObject);
    procedure act_configuracao_updateExecute(Sender: TObject);
    procedure dbg_configuracoesDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure acl_configuracoesUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure act_icms_storeExecute(Sender: TObject);
    procedure ts_configuracoesChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure act_icms_updateExecute(Sender: TObject);
    procedure act_icms_rollbackExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure act_ipi_rollbackExecute(Sender: TObject);
    procedure act_ipi_confirmarExecute(Sender: TObject);
    procedure act_pis_rollbackExecute(Sender: TObject);
    procedure act_pis_confirmarExecute(Sender: TObject);
    procedure act_cofins_rollbackExecute(Sender: TObject);
    procedure act_cofins_confirmarExecute(Sender: TObject);
    procedure lbe_configuracoes_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmr_focusTimer(Sender: TObject);
    procedure act_configuracao_destroyExecute(Sender: TObject);
    procedure act_icms_destroyExecute(Sender: TObject);
    procedure lbe_clenqEnter(Sender: TObject);
    procedure cbx_cofins_cstEnter(Sender: TObject);
    procedure cbx_pis_cstEnter(Sender: TObject);
  private
    { Private declarations }
    var CF: TConfiguracaoFiscal;
    var IPI: TConfiguracaoFiscalIpi;
    var PIS: TConfiguracaoFiscalPis;
    var COFINS: TConfiguracaoFiscalCofins;
    procedure list(search: string);

    procedure IPIObjToEdt;
    procedure IPIEdtToObj;
    procedure IPIsave();

    procedure PISObjToEdt;
    procedure PISEdtToObj;
    procedure PISsave();

    procedure COFINSObjToEdt;
    procedure COFINSEdtToObj;
    procedure COFINSsave();
  public
    { Public declarations }
  end;

var
  formConfiguracaoFiscalList: TformConfiguracaoFiscalList;

implementation

uses
  AuthService, uformConfiguracaoFiscalCreateEdit, ConfiguracaoFiscalIcms,
  uformConfiguracaoFiscalIcmsCreateEdit, udmRepository, Helper;

{$R *.dfm}

procedure TformConfiguracaoFiscalList.acl_configuracoesUpdate(
  Action: TBasicAction; var Handled: Boolean);
begin
  ts_configuracoes.Enabled:= (fdmt_configuracoes.RecordCount >= 1);
  if ts_configuracoes.Enabled then ntb_configuracoes.PageIndex:= ts_configuracoes.TabIndex;
  tmr_focus.Enabled:= (not lbe_configuracoes_search.Focused);
end;

procedure TformConfiguracaoFiscalList.act_cofins_rollbackExecute(
  Sender: TObject);
begin
  ts_configuracoes.TabIndex:= 3;
end;

procedure TformConfiguracaoFiscalList.act_cofins_confirmarExecute(Sender: TObject);
begin
  COFINSsave();
end;

procedure TformConfiguracaoFiscalList.act_configuracao_destroyExecute(
  Sender: TObject);
begin
  if TConfiguracaoFiscal.remove(fdmt_configuracoesID.AsString) then
    fdmt_configuracoes.Delete;
end;

procedure TformConfiguracaoFiscalList.act_configuracao_storeExecute(
  Sender: TObject);
var
  v_form: TformConfiguracaoFiscalCreateEdit;
begin
  TAuthService.ConfiguracaoFiscalId:= EmptyStr;
  try
    v_form:= TformConfiguracaoFiscalCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.ConfiguracaoFiscalId = EmptyStr) then
    list(Trim(lbe_configuracoes_search.Text));
end;

procedure TformConfiguracaoFiscalList.act_configuracao_updateExecute(
  Sender: TObject);
var
  v_form: TformConfiguracaoFiscalCreateEdit;
begin
  TAuthService.ConfiguracaoFiscalId:= fdmt_configuracoesID.AsString;
  try
    v_form:= TformConfiguracaoFiscalCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.ConfiguracaoFiscalId = EmptyStr) then
    list(Trim(lbe_configuracoes_search.Text));
end;

procedure TformConfiguracaoFiscalList.act_icms_destroyExecute(Sender: TObject);
begin
  if TConfiguracaoFiscalIcms.remove(fdmt_icmsID.AsString) then
    fdmt_icms.Delete;
end;

procedure TformConfiguracaoFiscalList.act_icms_rollbackExecute(Sender: TObject);
begin
  ts_configuracoes.TabIndex:= 0;
end;

procedure TformConfiguracaoFiscalList.act_icms_storeExecute(Sender: TObject);
var
  v_form: TformConfiguracaoFiscalIcmsCreateEdit;
begin
  TAuthService.ConfiguracaoFiscalId:= CF.Id;
  TAuthService.ConfiguracaoFiscalIcmsId:= EmptyStr;
  try
    v_form:= TformConfiguracaoFiscalIcmsCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.ConfiguracaoFiscalIcmsId <> EmptyStr) then
    TConfiguracaoFiscalIcms.listByConfiguracaoFiscalId(CF.Id, fdmt_icms);
end;

procedure TformConfiguracaoFiscalList.act_icms_updateExecute(Sender: TObject);
var
  v_form: TformConfiguracaoFiscalIcmsCreateEdit;
begin
  TAuthService.ConfiguracaoFiscalIcmsId:= fdmt_icmsID.AsString;
  try
    v_form:= TformConfiguracaoFiscalIcmsCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.ConfiguracaoFiscalIcmsId <> EmptyStr) then
    TConfiguracaoFiscalIcms.listByConfiguracaoFiscalId(CF.Id, fdmt_icms);
end;

procedure TformConfiguracaoFiscalList.act_ipi_rollbackExecute(Sender: TObject);
begin
  ts_configuracoes.TabIndex:= 1;
end;

procedure TformConfiguracaoFiscalList.act_ipi_confirmarExecute(Sender: TObject);
begin
  IPIsave();
end;

procedure TformConfiguracaoFiscalList.act_pis_rollbackExecute(Sender: TObject);
begin
  ts_configuracoes.TabIndex:= 2;
end;

procedure TformConfiguracaoFiscalList.act_pis_confirmarExecute(Sender: TObject);
begin
  PISsave();
end;

procedure TformConfiguracaoFiscalList.act_rollbackExecute(Sender: TObject);
begin
  Close;
end;

procedure TformConfiguracaoFiscalList.cbx_cofins_cstEnter(Sender: TObject);
begin
  lb_cofins_hint.Caption:= UpperCase(THelper.RemoveAcentos(TControl(Sender).Hint));
end;

procedure TformConfiguracaoFiscalList.cbx_pis_cstEnter(Sender: TObject);
begin
  lb_pis_hint.Caption:= UpperCase(THelper.RemoveAcentos(TControl(Sender).Hint));
end;

procedure TformConfiguracaoFiscalList.COFINSEdtToObj;
begin
  COFINS.ConfiguracaoFiscalId:= CF.Id;
  COFINS.Cst:= cbx_cofins_cst.Items[cbx_cofins_cst.ItemIndex];
  COFINS.Pcofins:= THelper.StringToExtended(lbe_pcofins.Text);
  COFINS.Valiqprod:= THelper.StringToExtended(lbe_cofins_valiqprod.Text);
  COFINS.Pcofinsst:= THelper.StringToExtended(lbe_pcofinsst.Text);
  COFINS.Valiqprodst:= THelper.StringToExtended(lbe_cofins_valiqprodst.Text);
end;

procedure TformConfiguracaoFiscalList.COFINSObjToEdt;
begin
  cbx_cofins_cst.ItemIndex:= cbx_cofins_cst.Items.IndexOf(COFINS.Cst);
  lbe_pcofins.Text:= THelper.ExtendedToString(COFINS.Pcofins);
  lbe_cofins_valiqprod.Text:= THelper.ExtendedToString(COFINS.Valiqprod);
  lbe_pcofinsst.Text:= THelper.ExtendedToString(COFINS.Pcofinsst);
  lbe_cofins_valiqprodst.Text:= THelper.ExtendedToString(COFINS.Valiqprodst);
end;

procedure TformConfiguracaoFiscalList.COFINSsave;
begin
  COFINSEdtToObj;
  try
    if COFINS.save then act_cofins_rollbackExecute(Self);
  except on e: exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformConfiguracaoFiscalList.dbg_configuracoesDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  If (gdSelected in state) then
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);
end;

procedure TformConfiguracaoFiscalList.FormCreate(Sender: TObject);
begin
  inherited;
  TCustomEdit(lbe_pipi).EditFloat;
  TCustomEdit(lbe_vunid).EditFloat;

  TCustomEdit(lbe_ppis).EditFloat;
  TCustomEdit(lbe_valiqprod).EditFloat;
  TCustomEdit(lbe_ppisst).EditFloat;
  TCustomEdit(lbe_valiqprodst).EditFloat;

  TCustomEdit(lbe_pcofins).EditFloat;
  TCustomEdit(lbe_cofins_valiqprod).EditFloat;
  TCustomEdit(lbe_pcofinsst).EditFloat;
  TCustomEdit(lbe_cofins_valiqprodst).EditFloat;

  list('');

  ts_configuracoes.TabIndex:= 0;
  ntb_configuracoes.PageIndex:= 0;
end;

procedure TformConfiguracaoFiscalList.FormDestroy(Sender: TObject);
begin
  FreeAndNil(CF);
  FreeAndNil(IPI);
  FreeAndNil(PIS);
  FreeAndNil(COFINS);
end;

procedure TformConfiguracaoFiscalList.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    27:begin
       case ts_configuracoes.TabIndex of
          0: act_rollbackExecute(Sender);
          1: act_icms_rollbackExecute(Sender);
          2: act_ipi_rollbackExecute(Sender);
       end;
    end;
    113:begin
      case ts_configuracoes.TabIndex of
          0: act_configuracao_storeExecute(Sender);
          1: act_icms_storeExecute(Sender);
       end;
    end;
    114:begin
      case ts_configuracoes.TabIndex of
          0: act_configuracao_updateExecute(Sender);
          1: act_icms_updateExecute(Sender);
       end;
    end;
  end;
end;

procedure TformConfiguracaoFiscalList.IPIEdtToObj;
begin
  IPI.ConfiguracaoFiscalId:= CF.Id;
  IPI.Clenq:=  lbe_clenq.Text;
  IPI.Cnpjprod:= lbe_cnpjprod.Text;
  IPI.Cselo:= lbe_cselo.Text;
  IPI.Qselo:= StrToIntDef(lbe_qselo.Text, 0);
  IPI.Cenq:= lbe_cenq.Text;
  IPI.Cst:= cbx_ipi_cst.Items[cbx_ipi_cst.ItemIndex];
  IPI.Pipi:= THelper.StringToExtended(lbe_pipi.Text);
  IPI.Vunid:= THelper.StringToExtended(lbe_vunid.Text);
end;

procedure TformConfiguracaoFiscalList.IPIObjToEdt;
begin
  lbe_clenq.Text:= IPI.Clenq;
  lbe_cnpjprod.Text:= IPI.Cnpjprod;
  lbe_cselo.Text:= IPI.Cselo;
  if (IPI.Qselo >= 1) then
  lbe_qselo.Text:= IPI.Qselo.ToString();
  lbe_cenq.Text:= IPI.Cenq;
  cbx_ipi_cst.ItemIndex:= cbx_ipi_cst.Items.IndexOf(IPI.Cst);
  lbe_pipi.Text:= THelper.ExtendedToString(IPI.Pipi);
  lbe_vunid.Text:= THelper.ExtendedToString(IPI.Vunid);
end;

procedure TformConfiguracaoFiscalList.IPIsave;
begin
  IPIEdtToObj;
  try
    if IPI.save then act_ipi_rollbackExecute(Self);
  except on e: exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformConfiguracaoFiscalList.lbe_clenqEnter(Sender: TObject);
begin
  lb_ipi_hint.Caption:= UpperCase(THelper.RemoveAcentos(TControl(Sender).Hint));
end;

procedure TformConfiguracaoFiscalList.lbe_configuracoes_searchKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN: begin
      if (Trim(TCustomEdit(Sender).Text) <> EmptyStr) then
        list(Trim(TCustomEdit(Sender).Text));
    end;
    38: begin
      fdmt_configuracoes.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_configuracoes.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformConfiguracaoFiscalList.list(search: string);
begin
  TConfiguracaoFiscal.list(search,fdmt_configuracoes);
end;

procedure TformConfiguracaoFiscalList.PISEdtToObj;
begin
  PIS.ConfiguracaoFiscalId:= CF.Id;
  PIS.Cst:= cbx_pis_cst.Items[cbx_pis_cst.ItemIndex];
  PIS.Ppis:= THelper.StringToExtended(lbe_ppis.Text);
  PIS.Valiqprod:= THelper.StringToExtended(lbe_valiqprod.Text);
  PIS.Ppisst:= THelper.StringToExtended(lbe_ppisst.Text);
  PIS.Valiqprodst:= THelper.StringToExtended(lbe_valiqprodst.Text);
end;

procedure TformConfiguracaoFiscalList.PISObjToEdt;
begin
  cbx_pis_cst.ItemIndex:= cbx_pis_cst.Items.IndexOf(PIS.Cst);
  lbe_ppis.Text:= THelper.ExtendedToString(PIS.Ppis);
  lbe_valiqprod.Text:= THelper.ExtendedToString(PIS.Valiqprod);
  lbe_ppisst.Text:= THelper.ExtendedToString(PIS.Ppisst);
  lbe_valiqprodst.Text:= THelper.ExtendedToString(PIS.Valiqprodst);
end;

procedure TformConfiguracaoFiscalList.PISsave;
begin
  PISEdtToObj;
  try
    if PIS.save then act_pis_rollbackExecute(Self);
  except on e: exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformConfiguracaoFiscalList.tmr_focusTimer(Sender: TObject);
begin
  try
    if (ntb_configuracoes.PageIndex = 0) and (not lbe_configuracoes_search.Focused) then
      lbe_configuracoes_search.SetFocus
    else if (ntb_configuracoes.PageIndex = 0) then TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

procedure TformConfiguracaoFiscalList.ts_configuracoesChange(Sender: TObject;
  NewTab: Integer; var AllowChange: Boolean);
begin
  if (NewTab >= 1) then
  begin
    if Assigned(CF) then FreeAndNil(CF);
    CF:= TConfiguracaoFiscal.find(fdmt_configuracoesID.AsString);
  end;

  case NewTab of
    1: TConfiguracaoFiscalIcms.listByConfiguracaoFiscalId(CF.Id,fdmt_icms);
    2: begin
      if Assigned(IPI) then FreeAndNil(IPI);
      IPI:= TConfiguracaoFiscalIpi.findByConfiguracaoFiscalId(CF.Id);
      if not Assigned(IPI) then IPI:= TConfiguracaoFiscalIpi.Create;
      IPIObjToEdt;
    end;
    3: begin
      if Assigned(PIS) then FreeAndNil(PIS);
      PIS:= TConfiguracaoFiscalPis.findByConfiguracaoFiscalId(CF.Id);
      if not Assigned(PIS) then PIS:= TConfiguracaoFiscalPis.Create;
      PISObjToEdt;
    end;
    4: begin
      if Assigned(COFINS) then FreeAndNil(COFINS);
      COFINS:= TConfiguracaoFiscalCofins.findByConfiguracaoFiscalId(CF.Id);
      if not Assigned(COFINS) then COFINS:= TConfiguracaoFiscalCofins.Create;
      COFINSObjToEdt;
    end;
  end;
end;

end.
