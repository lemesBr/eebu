unit uformNfeCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Nfe, System.Actions, Vcl.ActnList, Vcl.ComCtrls, System.StrUtils,
  System.DateUtils, System.Math;

type
  TformNfeCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_confirmar: TButton;
    pnl_body: TPanel;
    btn_cancelar: TButton;
    lbe_operacao_fiscal: TLabeledEdit;
    lbe_chnfe: TLabeledEdit;
    lbe_serie: TLabeledEdit;
    lbe_nnf: TLabeledEdit;
    lbe_cmunfg: TLabeledEdit;
    lbe_cdv: TLabeledEdit;
    lbe_xjust: TLabeledEdit;
    act_nfe: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    cbx_cuf: TComboBox;
    lb_cuf: TLabel;
    cbx_indpag: TComboBox;
    lb_indpag: TLabel;
    lb_demi: TLabel;
    dtp_demi: TDateTimePicker;
    dtp_dsaient: TDateTimePicker;
    lb_dsaient: TLabel;
    cbx_iddest: TComboBox;
    lb_iddest: TLabel;
    cbx_tpimp: TComboBox;
    lb_tpimp: TLabel;
    cbx_tpemis: TComboBox;
    lb_tpemis: TLabel;
    cbx_finnfe: TComboBox;
    lb_finnfe: TLabel;
    cbx_indfinal: TComboBox;
    lb_indfinal: TLabel;
    cbx_indpres: TComboBox;
    lb_indpres: TLabel;
    cbx_procemi: TComboBox;
    lb_procemi: TLabel;
    dtp_dhcont: TDateTimePicker;
    lb_dhcont: TLabel;
    cbx_modelo: TComboBox;
    lb_modelo: TLabel;
    cbx_tpnf: TComboBox;
    lb_tpnf: TLabel;
    ckb_auto_calculo: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbe_operacao_fiscalKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure act_nfeUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure cbx_modeloSelect(Sender: TObject);
  private
    { Private declarations }
    Nfe: TNfe;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();
  public
    { Public declarations }
  end;

var
  formNfeCreateEdit: TformNfeCreateEdit;

implementation

uses
  AuthService, uformOperacaoFiscalList, udmRepository, Helper;

{$R *.dfm}

{ TformNfeCreateEdit }

procedure TformNfeCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.NfeId:= EmptyStr;
  Close;
end;

procedure TformNfeCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformNfeCreateEdit.act_nfeUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  lb_dhcont.Visible:= (cbx_tpemis.ItemIndex >= 1);
  dtp_dhcont.Visible:= (cbx_tpemis.ItemIndex >= 1);
  lbe_xjust.Visible:= (cbx_tpemis.ItemIndex >= 1);
end;

procedure TformNfeCreateEdit.cbx_modeloSelect(Sender: TObject);
begin
  lbe_serie.ReadOnly:= (cbx_modelo.ItemIndex in[3,4]);
  lbe_nnf.ReadOnly:= lbe_serie.ReadOnly;
  if (Nfe.Empresa.NfeConfiguracao.FormaEmissaoCodigo = '2') then
  begin
    case cbx_modelo.ItemIndex of
      3: cbx_tpemis.ItemIndex:= 1;
      4: cbx_tpemis.ItemIndex:= 7;
    end;
    dtp_dhcont.Date:= Now;
    lbe_xjust.Text:= 'SEM ACESSO A INTERNET.';
  end;
end;

procedure TformNfeCreateEdit.EdtToObj;
begin
  if Assigned(Nfe.OperacaoFiscal) then
    Nfe.Natop:= Nfe.OperacaoFiscal.Natop;
  case cbx_modelo.ItemIndex of
    0: Nfe.Modelo:= '01';
    1: Nfe.Modelo:= '1B';
    2: Nfe.Modelo:= '04';
    3: Nfe.Modelo:= '55';
    4: Nfe.Modelo:= '65';
  end;
  Nfe.Serie:= StrToIntDef(lbe_serie.Text, 0);
  Nfe.Nnf:= StrToIntDef(lbe_nnf.Text, 0);
  Nfe.Cdv:= StrToIntDef(lbe_cdv.Text, 0);
  Nfe.Demi:= dtp_demi.DateTime;
  Nfe.Dsaient:= dtp_dsaient.DateTime;
  case cbx_tpnf.ItemIndex of
    0: Nfe.Tpnf:= '0';
    1: Nfe.Tpnf:= '1';
  end;
  case cbx_indpag.ItemIndex of
    0: Nfe.Indpag:= '0';
    1: Nfe.Indpag:= '1';
    2: Nfe.Indpag:= '2';
  end;
  case cbx_tpemis.ItemIndex of
    0: Nfe.Tpemis:= '1';
    1: Nfe.Tpemis:= '2';
    2: Nfe.Tpemis:= '3';
    3: Nfe.Tpemis:= '4';
    4: Nfe.Tpemis:= '5';
    5: Nfe.Tpemis:= '6';
    6: Nfe.Tpemis:= '7';
    7: Nfe.Tpemis:= '9';
  end;
  case cbx_finnfe.ItemIndex of
    0: Nfe.Finnfe:= '1';
    1: Nfe.Finnfe:= '2';
    2: Nfe.Finnfe:= '3';
    3: Nfe.Finnfe:= '4';
  end;
  case cbx_tpimp.ItemIndex of
    0: Nfe.Tpimp:= '0';
    1: Nfe.Tpimp:= '1';
    2: Nfe.Tpimp:= '2';
    3: Nfe.Tpimp:= '3';
    4: Nfe.Tpimp:= '4';
    5: Nfe.Tpimp:= '5';
  end;
  case cbx_indfinal.ItemIndex of
    0: Nfe.Indfinal:= '0';
    1: Nfe.Indfinal:= '1';
  end;
  case cbx_iddest.ItemIndex of
    0: Nfe.Iddest:= '1';
    1: Nfe.Iddest:= '2';
    2: Nfe.Iddest:= '3';
  end;
  case cbx_indpres.ItemIndex of
    0: Nfe.Indpres:= '0';
    1: Nfe.Indpres:= '1';
    2: Nfe.Indpres:= '2';
    3: Nfe.Indpres:= '3';
    4: Nfe.Indpres:= '4';
    5: Nfe.Indpres:= '5';
    6: Nfe.Indpres:= '9';
  end;
  Nfe.Cuf:= cbx_cuf.Text;
  Nfe.Cmunfg:= lbe_cmunfg.Text;
  case cbx_procemi.ItemIndex of
    0: Nfe.Procemi:= '0';
    1: Nfe.Procemi:= '1';
    2: Nfe.Procemi:= '2';
    3: Nfe.Procemi:= '3';
  end;
  Nfe.AutoCalculo:= IfThen(ckb_auto_calculo.Checked, 'S', 'N');
  if (StrToIntDef(Nfe.Tpemis, 1) >= 2) then
  begin
    Nfe.Dhcont:= dtp_dhcont.Date;
    Nfe.Xjust:= lbe_xjust.Text;
  end
  else
  begin
    Nfe.Dhcont:= 0;
    Nfe.Xjust:= '';
  end;
  Nfe.Tpamb:= Nfe.Empresa.NfeConfiguracao.AmbienteCodigo;
end;

procedure TformNfeCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  if TAuthService.NfeId = EmptyStr then Nfe:= TNfe.Create
  else Nfe:= TNfe.find(TAuthService.NfeId);
  ObjToEdt;
end;

procedure TformNfeCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Nfe);
end;

procedure TformNfeCreateEdit.lbe_operacao_fiscalKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  v_form: TformOperacaoFiscalList;
begin
  case Key of
    112: begin
      TAuthService.OperacaoFiscalId:= EmptyStr;
      try
        v_form:= TformOperacaoFiscalList.Create(nil);
        v_form.Tag:= 1;
        v_form.ShowModal;
      finally
        FreeAndNil(v_form);
      end;

      if (TAuthService.OperacaoFiscalId <> EmptyStr) then
      begin
        Nfe.OperacaoFiscalId:= TAuthService.OperacaoFiscalId;
        lbe_operacao_fiscal.Text:= Nfe.OperacaoFiscal.Natop;
        cbx_modelo.ItemIndex:= cbx_modelo.Items.IndexOf(Nfe.OperacaoFiscal.Modelo);
        case cbx_modelo.ItemIndex of
          3: lbe_serie.Text:= Nfe.Empresa.NfeConfiguracao.SerieNfe.ToString();
          4: lbe_serie.Text:= Nfe.Empresa.NfeConfiguracao.SerieNfce.ToString();
        end;
        cbx_modeloSelect(cbx_modelo);
        if (Nfe.OperacaoFiscal.Tpnf <> EmptyStr) then
        cbx_tpnf.ItemIndex:= StrToIntDef(Nfe.OperacaoFiscal.Tpnf, 0);
        if (Nfe.OperacaoFiscal.Iddest <> EmptyStr) then
        cbx_iddest.ItemIndex:= StrToIntDef(Nfe.OperacaoFiscal.Iddest, 1) - 1;
        if (Nfe.OperacaoFiscal.Tpimp <> EmptyStr) then
        cbx_tpimp.ItemIndex:= StrToIntDef(Nfe.OperacaoFiscal.Tpimp, 1);
        if (Nfe.OperacaoFiscal.Finnfe <> EmptyStr) then
        cbx_finnfe.ItemIndex:= StrToIntDef(Nfe.OperacaoFiscal.Finnfe, 1) - 1;
        if (Nfe.OperacaoFiscal.Indfinal <> EmptyStr) then
        cbx_indfinal.ItemIndex:= StrToIntDef(Nfe.OperacaoFiscal.Indfinal, 0);
        if (Nfe.OperacaoFiscal.Indpres <> EmptyStr) then
        cbx_indpres.ItemIndex:= StrToIntDef(Nfe.OperacaoFiscal.Indpres, 0);
      end;
    end;
  end;
end;

procedure TformNfeCreateEdit.ObjToEdt;
begin
  if (Nfe.Id = EmptyStr) then
  begin
    pnl_header.Caption:= 'NOVA NOTA FISCAL';
    Nfe.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;
    Nfe.TpnfWt:= 1;
    lbe_operacao_fiscal.Text:= '';
    cbx_modelo.ItemIndex:= 3;
    cbx_modeloSelect(cbx_modelo);
    lbe_serie.Text:= Nfe.Empresa.NfeConfiguracao.SerieNfe.ToString();
    lbe_nnf.Text:= '';
    lbe_cdv.Text:= '';
    dtp_demi.DateTime:= Now;
    dtp_dsaient.DateTime:= Now;
    cbx_tpnf.ItemIndex:= 1;
    cbx_indpag.ItemIndex:= 0;
    cbx_tpemis.ItemIndex:= IfThen(Nfe.Empresa.NfeConfiguracao.FormaEmissaoCodigo = '1', 0, 1);
    cbx_finnfe.ItemIndex:= 0;
    cbx_tpimp.ItemIndex:= 1;
    cbx_indfinal.ItemIndex:= 0;
    cbx_iddest.ItemIndex:= 0;
    cbx_indpres.ItemIndex:= 1;
    cbx_cuf.ItemIndex:= cbx_cuf.Items.IndexOf(Nfe.Empresa.Uf);
    lbe_cmunfg.Text:= Nfe.Empresa.CodigoMunicipio;
    cbx_procemi.ItemIndex:= 0;
    lbe_chnfe.Text:= '';
    dtp_dhcont.DateTime:= Now;

    if (cbx_tpemis.ItemIndex = 1) then
      lbe_xjust.Text:= 'SEM ACESSO A INTERNET.';

    ckb_auto_calculo.Checked:= True;
    Exit();
  end;

  pnl_header.Caption:= 'EDITAR NOTA FISCAL';
  if Assigned(Nfe.OperacaoFiscal) then
    lbe_operacao_fiscal.Text:= Nfe.OperacaoFiscal.Natop;

  cbx_modelo.ItemIndex:= AnsiIndexStr(Nfe.Modelo, ['01','1B','04','55', '65']);
  cbx_modeloSelect(cbx_modelo);
  lbe_serie.Text:= Nfe.Serie.ToString();
  lbe_nnf.Text:= Nfe.Nnf.ToString();
  lbe_cdv.Text:= Nfe.Cdv.ToString();
  dtp_demi.DateTime:= Nfe.Demi;
  dtp_dsaient.DateTime:= Nfe.Dsaient;
  cbx_tpnf.ItemIndex:= StrToIntDef(Nfe.Tpnf, 0);
  cbx_indpag.ItemIndex:= StrToIntDef(Nfe.Indpag, 0);
  cbx_tpemis.ItemIndex:= AnsiIndexStr(Nfe.Tpemis, ['1','2','3','4', '5','6','7','9']);
  cbx_finnfe.ItemIndex:= StrToIntDef(Nfe.Finnfe, 1) - 1;
  cbx_tpimp.ItemIndex:= StrToIntDef(Nfe.Tpimp, 1);
  cbx_indfinal.ItemIndex:= StrToIntDef(Nfe.Indfinal, 0);
  cbx_iddest.ItemIndex:= StrToIntDef(Nfe.Iddest, 1) - 1;
  cbx_indpres.ItemIndex:= IfThen(StrToIntDef(Nfe.Indpres, 0) <= 5, StrToIntDef(Nfe.Indpres, 0), 6);
  cbx_cuf.ItemIndex:= cbx_cuf.Items.IndexOf(Nfe.Empresa.Uf);
  lbe_cmunfg.Text:= Nfe.Empresa.CodigoMunicipio;
  cbx_procemi.ItemIndex:= StrToIntDef(Nfe.Procemi, 0);
  lbe_chnfe.Text:= Nfe.Chnfe;
  dtp_dhcont.DateTime:= Nfe.Dhcont;
  lbe_xjust.Text:= Nfe.Xjust;
  ckb_auto_calculo.Checked:= (Nfe.AutoCalculo = 'S');
end;

procedure TformNfeCreateEdit.save;
begin
  EdtToObj;
  try
    if Nfe.save then
    begin
      TAuthService.NfeId:= Nfe.Id;
      Close;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

end.
