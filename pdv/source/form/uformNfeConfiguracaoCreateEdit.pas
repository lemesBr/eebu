unit uformNfeConfiguracaoCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  NfeConfiguracao, System.StrUtils, System.Actions, Vcl.ActnList, Vcl.Buttons,
  Vcl.FileCtrl, Winapi.ShellAPI, Vcl.ExtDlgs, ACBrBase, ACBrDFe, ACBrNFe,
  ACBrDFeSSL, System.TypInfo;

type
  TformNfeConfiguracaoCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_confirmar: TButton;
    pnl_body: TPanel;
    btn_cancelar: TButton;
    lbe_id_csc: TLabeledEdit;
    lbe_csc: TLabeledEdit;
    lbe_senha: TLabeledEdit;
    lbe_serie_nfe: TLabeledEdit;
    lbe_serie_nfce: TLabeledEdit;
    acl_config: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    cbx_uf: TComboBox;
    lb_uf: TLabel;
    open_picture: TOpenPictureDialog;
    ACBrNFe: TACBrNFe;
    cbx_versao_df: TComboBox;
    cbx_ambiente_codigo: TComboBox;
    cbx_forma_emissao_codigo: TComboBox;
    lb_versao_df: TLabel;
    lb_forma_emissao_codigo: TLabel;
    lb_ambiente_codigo: TLabel;
    bed_numero_serie: TButtonedEdit;
    lb_numero_serie: TLabel;
    bvl_3: TBevel;
    bed_logo: TButtonedEdit;
    lb_logo: TLabel;
    bed_path_nfe: TButtonedEdit;
    lb_path_nfe: TLabel;
    bed_path_inu: TButtonedEdit;
    lb_path_inu: TLabel;
    bed_path_evento: TButtonedEdit;
    lb_path_evento: TLabel;
    bed_path_salvar: TButtonedEdit;
    lb_path_salvar: TLabel;
    bed_path_schemas: TButtonedEdit;
    lb_path_schemas: TLabel;
    bed_arquivo_pfx: TButtonedEdit;
    lb_arquivo_pfx: TLabel;
    bed_path_pdf: TButtonedEdit;
    lb_path_pdf: TLabel;
    bvl_4: TBevel;
    cbx_ssllib: TComboBox;
    lb_ssllib: TLabel;
    lbe_aguardar_consulta_ret: TLabeledEdit;
    lbe_intervalo_tentativas: TLabeledEdit;
    lbe_tentativas: TLabeledEdit;
    ckb_ajusta_aguarda_consulta_ret: TCheckBox;
    procedure FormDestroy(Sender: TObject);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bed_numero_serieChange(Sender: TObject);
    procedure bed_numero_serieLeftButtonClick(Sender: TObject);
    procedure bed_numero_serieRightButtonClick(Sender: TObject);
    procedure bed_logoLeftButtonClick(Sender: TObject);
    procedure bed_path_nfeLeftButtonClick(Sender: TObject);
  private
    { Private declarations }
    NfeConfiguracao: TNfeConfiguracao;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();

  public
    { Public declarations }
  end;

var
  formNfeConfiguracaoCreateEdit: TformNfeConfiguracaoCreateEdit;

implementation

uses
  Empresa, AuthService, udmRepository, Helper;

{$R *.dfm}

{ TformNfeConfiguracaoCreateEdit }

procedure TformNfeConfiguracaoCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  Close;
end;

procedure TformNfeConfiguracaoCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformNfeConfiguracaoCreateEdit.bed_logoLeftButtonClick(
  Sender: TObject);
begin
  if open_picture.Execute() then
    bed_logo.Text:= open_picture.FileName;
end;

procedure TformNfeConfiguracaoCreateEdit.bed_numero_serieChange(
  Sender: TObject);
begin
  TButtonedEdit(Sender).LeftButton.Visible:= (Trim(TButtonedEdit(Sender).Text) = '');
  TButtonedEdit(Sender).RightButton.Visible:= (Trim(TButtonedEdit(Sender).Text) <> '');
end;

procedure TformNfeConfiguracaoCreateEdit.bed_numero_serieLeftButtonClick(
  Sender: TObject);
begin
  try
    bed_numero_serie.Text:= ACBrNFe.SSL.SelecionarCertificado();
  except
    bed_numero_serie.Text:= '';
  end;
end;

procedure TformNfeConfiguracaoCreateEdit.bed_numero_serieRightButtonClick(
  Sender: TObject);
begin
  TButtonedEdit(Sender).Text:= '';
end;

procedure TformNfeConfiguracaoCreateEdit.bed_path_nfeLeftButtonClick(
  Sender: TObject);
var
  Path: string;
begin
  Path:= 'C:\';
  if SelectDirectory(Path, [sdAllowCreate, sdPerformCreate, sdPrompt], 1000) then
    TButtonedEdit(Sender).Text:= Path;
end;

procedure TformNfeConfiguracaoCreateEdit.EdtToObj;
begin
  case cbx_versao_df.ItemIndex of
    0: NfeConfiguracao.VersaoDf:= '2.00';
    1: NfeConfiguracao.VersaoDf:= '3.00';
    2: NfeConfiguracao.VersaoDf:= '3.10';
    3: NfeConfiguracao.VersaoDf:= '4.00';
  end;
  NfeConfiguracao.AtualizarXmlCancelado:= 'S';
  NfeConfiguracao.IncluirQrcodeXmlNfce:= 'S';
  NfeConfiguracao.GeralSalvar:= 'S';
  NfeConfiguracao.ExibirErroSchema:= 'S';
  NfeConfiguracao.RetirarAcentos:= 'S';
  NfeConfiguracao.RetirarEspacos:= 'S';
  NfeConfiguracao.IdentarXml:= 'N';
  NfeConfiguracao.ValidarDigest:= 'S';
  NfeConfiguracao.EmissaoPathNfe:= 'N';
  NfeConfiguracao.SalvarEvento:= 'N';
  NfeConfiguracao.SalvarApenasNfeProcessadas:= 'N';
  NfeConfiguracao.ArquivosSalvar:= 'S';
  NfeConfiguracao.AdicionarLiteral:= 'S';
  NfeConfiguracao.SepararPorCnpj:= 'S';
  NfeConfiguracao.SepararPorModelo:= 'N';
  NfeConfiguracao.SepararPorMes:= 'S';
  NfeConfiguracao.Visualizar:= 'N';
  NfeConfiguracao.VerificarValidade:= 'S';
  NfeConfiguracao.IdCsc:= lbe_id_csc.Text;
  NfeConfiguracao.Csc:= lbe_csc.Text;
  case cbx_forma_emissao_codigo.ItemIndex of
    0: NfeConfiguracao.FormaEmissaoCodigo:= '1';
    1: NfeConfiguracao.FormaEmissaoCodigo:= '2';
  end;
  NfeConfiguracao.PathNfe:= bed_path_nfe.Text;
  NfeConfiguracao.PathInu:= bed_path_inu.Text;
  NfeConfiguracao.PathEvento:= bed_path_evento.Text;
  NfeConfiguracao.PathSalvar:= bed_path_salvar.Text;
  NfeConfiguracao.PathSchemas:= bed_path_schemas.Text;
  NfeConfiguracao.Uf:= cbx_uf.Text;
  case cbx_ambiente_codigo.ItemIndex of
    0: NfeConfiguracao.AmbienteCodigo:= '1';
    1: NfeConfiguracao.AmbienteCodigo:= '2';
  end;
  NfeConfiguracao.ArquivoPfx:= bed_arquivo_pfx.Text;
  NfeConfiguracao.NumeroSerie:= bed_numero_serie.Text;
  NfeConfiguracao.Senha:= lbe_senha.Text;
  NfeConfiguracao.PathPdf:= bed_path_pdf.Text;
  NfeConfiguracao.Logo:= bed_logo.Text;
  NfeConfiguracao.SerieNfe:= StrToIntDef(lbe_serie_nfe.Text, 1);
  NfeConfiguracao.SerieNfce:= StrToIntDef(lbe_serie_nfce.Text, 1);
  NfeConfiguracao.Ssllib:= cbx_ssllib.ItemIndex.ToString();
  NfeConfiguracao.AguardarConsultaRet:= StrToIntDef(lbe_aguardar_consulta_ret.Text, 5000);
  NfeConfiguracao.IntervaloTentativas:= StrToIntDef(lbe_intervalo_tentativas.Text, 3000);
  NfeConfiguracao.Tentativas:= StrToIntDef(lbe_tentativas.Text, 10);
  NfeConfiguracao.AjustaAguardaConsultaRet:= IfThen(ckb_ajusta_aguarda_consulta_ret.Checked, 'S', 'N');
end;

procedure TformNfeConfiguracaoCreateEdit.FormCreate(Sender: TObject);
var
  Empresa: TEmpresa;
  NfeConfiguracaoId: string;
  vSSLLib: TSSLLib;
begin
  inherited;
  cbx_ssllib.Items.Clear;
  for vSSLLib:= Low(TSSLLib) to High(TSSLLib) do
    cbx_ssllib.Items.Add(GetEnumName(TypeInfo(TSSLLib), integer(vSSLLib)));
  cbx_ssllib.ItemIndex:= 0;

  try
    NfeConfiguracaoId:= EmptyStr;
    Empresa:= TEmpresa.find(TAuthService.Terminal.EmpresaId);
    if Assigned(Empresa.NfeConfiguracao) then
      NfeConfiguracaoId:= Empresa.NfeConfiguracao.Id;
    if (NfeConfiguracaoId = EmptyStr) then NfeConfiguracao:= TNfeConfiguracao.Create
    else NfeConfiguracao:= TNfeConfiguracao.find(NfeConfiguracaoId);
    ObjToEdt;
  finally
    FreeAndNil(Empresa);
  end;
end;

procedure TformNfeConfiguracaoCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(NfeConfiguracao);
end;

procedure TformNfeConfiguracaoCreateEdit.ObjToEdt;
var
  vPath: string;
begin
  if (NfeConfiguracao.Id = EmptyStr) then
  begin
    vPath:= ExtractFileDir(Application.ExeName);
    cbx_versao_df.ItemIndex:= 3;
    cbx_forma_emissao_codigo.ItemIndex:= 0;
    cbx_ambiente_codigo.ItemIndex:= 1;
    cbx_uf.ItemIndex:= 12;
    bed_path_nfe.Text:= vPath + '\xmls\nfe';
    bed_path_inu.Text:= vPath + '\xmls\inutilizadas';
    bed_path_evento.Text:= vPath + '\xmls\eventos';
    bed_path_salvar.Text:= vPath + '\xmls\salvar';
    bed_path_schemas.Text:= vPath + '\schemas\nfe';
    bed_path_pdf.Text:= vPath + '\xmls\pdf';
    cbx_ssllib.ItemIndex:= 2;
    lbe_aguardar_consulta_ret.Text:= '5000';
    lbe_intervalo_tentativas.Text:= '3000';
    lbe_tentativas.Text:= '10';
    ckb_ajusta_aguarda_consulta_ret.Checked:= True;
    Exit();
  end;

  cbx_versao_df.ItemIndex:= AnsiIndexStr(NfeConfiguracao.VersaoDf,['2.00', '3.00','3.10','4.00']);
  lbe_id_csc.Text:= NfeConfiguracao.IdCsc;
  lbe_csc.Text:= NfeConfiguracao.Csc;
  cbx_forma_emissao_codigo.ItemIndex:= AnsiIndexStr(NfeConfiguracao.FormaEmissaoCodigo,['1', '2']);
  bed_path_nfe.Text:= NfeConfiguracao.PathNfe;
  bed_path_inu.Text:= NfeConfiguracao.PathInu;
  bed_path_evento.Text:= NfeConfiguracao.PathEvento;
  bed_path_salvar.Text:= NfeConfiguracao.PathSalvar;
  bed_path_schemas.Text:= NfeConfiguracao.PathSchemas;
  cbx_uf.ItemIndex:= cbx_uf.Items.IndexOf(NfeConfiguracao.Uf);
  cbx_ambiente_codigo.ItemIndex:= AnsiIndexStr(NfeConfiguracao.AmbienteCodigo,['1', '2']);
  bed_arquivo_pfx.Text:= NfeConfiguracao.ArquivoPfx;
  bed_numero_serie.Text:= NfeConfiguracao.NumeroSerie;
  lbe_senha.Text:= NfeConfiguracao.Senha;
  bed_path_pdf.Text:= NfeConfiguracao.PathPdf;
  bed_logo.Text:= NfeConfiguracao.Logo;
  lbe_serie_nfe.Text:= NfeConfiguracao.SerieNfe.ToString();
  lbe_serie_nfce.Text:= NfeConfiguracao.SerieNfce.ToString();
  cbx_ssllib.ItemIndex:= NfeConfiguracao.Ssllib.ToInteger();
  lbe_aguardar_consulta_ret.Text:= NfeConfiguracao.AguardarConsultaRet.ToString();
  lbe_intervalo_tentativas.Text:= NfeConfiguracao.IntervaloTentativas.ToString();
  lbe_tentativas.Text:= NfeConfiguracao.Tentativas.ToString();
  ckb_ajusta_aguarda_consulta_ret.Checked:= NfeConfiguracao.AjustaAguardaConsultaRet = 'S';
end;

procedure TformNfeConfiguracaoCreateEdit.save;
begin
  EdtToObj;
  try
    if NfeConfiguracao.validate() then
    begin
      if NfeConfiguracao.save() then
        Close;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

end.
