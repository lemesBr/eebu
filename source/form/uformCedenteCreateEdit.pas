unit uformCedenteCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Cedente, Vcl.Mask, System.StrUtils,
  IPPeerClient, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope;

type
  TformCedenteCreateEdit = class(TformBase)
    pnl_body: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_main: TPanel;
    acl_cedente: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    btn_cancelar: TButton;
    btn_confirmar: TButton;
    lbl1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel2: TBevel;
    lb_cep: TLabel;
    lb_fone: TLabel;
    lb_uf: TLabel;
    lbe_codigo_cedente: TLabeledEdit;
    lbe_codigo_transmissao: TLabeledEdit;
    lbe_agencia: TLabeledEdit;
    lbe_agencia_digito: TLabeledEdit;
    lbe_conta: TLabeledEdit;
    lbe_conta_digito: TLabeledEdit;
    lbe_modalidade: TLabeledEdit;
    lbe_convenio: TLabeledEdit;
    lbe_nome: TLabeledEdit;
    cbx_tipo_cateira: TComboBox;
    cbx_tipo_documento: TComboBox;
    cbx_respon_emissao: TComboBox;
    cbx_carac_titulo: TComboBox;
    lbe_logradouro: TLabeledEdit;
    lbe_numero: TLabeledEdit;
    lbe_complemento: TLabeledEdit;
    lbe_bairro: TLabeledEdit;
    lbe_nome_municipio: TLabeledEdit;
    mke_cep: TMaskEdit;
    mke_fone: TMaskEdit;
    cbx_uf: TComboBox;
    lbe_cnpjcpf: TLabeledEdit;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mke_cepExit(Sender: TObject);
  private
    { Private declarations }
    Cedente: TCedente;
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
  formCedenteCreateEdit: TformCedenteCreateEdit;

implementation

{$R *.dfm}

uses udmRepository, AuthService, Helper;

procedure TformCedenteCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.CedenteId:= EmptyStr;
  Close;
end;

procedure TformCedenteCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformCedenteCreateEdit.EdtToObj;
begin
  Cedente.Nome:= lbe_nome.Text;
  Cedente.CodigoCedente:= lbe_codigo_cedente.Text;
  Cedente.CodigoTransmissao:= lbe_codigo_transmissao.Text;
  Cedente.Agencia:= lbe_agencia.Text;
  Cedente.AgenciaDigito:= lbe_agencia_digito.Text;
  Cedente.Conta:= lbe_conta.Text;
  Cedente.ContaDigito:= lbe_conta_digito.Text;
  Cedente.Modalidade:= lbe_modalidade.Text;
  Cedente.Convenio:= lbe_convenio.Text;
  Cedente.TipoDocumento:= cbx_tipo_documento.ItemIndex + 1;
  Cedente.TipoCarteira:= cbx_tipo_cateira.ItemIndex;
  Cedente.ResponEmissao:= cbx_respon_emissao.ItemIndex;
  Cedente.CaracTitulo:= cbx_carac_titulo.ItemIndex;
  Cedente.Cnpjcpf:= lbe_cnpjcpf.Text;
  Cedente.TipoInscricao:= IfThen(Cedente.Cnpjcpf.Length = 14, 'J', 'F');
  Cedente.Logradouro:= lbe_logradouro.Text;
  Cedente.NumeroRes:= lbe_numero.Text;
  Cedente.Complemento:= lbe_complemento.Text;
  Cedente.Bairro:= lbe_bairro.Text;
  Cedente.Cidade:= lbe_nome_municipio.Text;
  Cedente.Uf:= cbx_uf.Text;
  Cedente.Cep:= mke_cep.Text;
  Cedente.Telefone:= mke_fone.Text;
end;

procedure TformCedenteCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  Cedente:= TCedente.findByContaId(TAuthService.ContaId);
  if not Assigned(Cedente) then
    Cedente:= TCedente.Create;
  ObjToEdt();
end;

procedure TformCedenteCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Cedente);
end;

procedure TformCedenteCreateEdit.mke_cepExit(Sender: TObject);
var
  vCep: string;
begin
  vCep:= Trim(mke_cep.Text);
  if not (vCep.Length = 8) then Exit();

  try
    RESTClient.BaseURL:= 'https://viacep.com.br/ws/' + vCep + '/json';
    RESTRequest.Execute;

    lbe_logradouro.Text:= THelper.RemoveAcentos(RESTResponse.JSONValue.GetValue('logradouro',''));
    lbe_complemento.Text:= THelper.RemoveAcentos(RESTResponse.JSONValue.GetValue('complemento',''));
    lbe_bairro.Text:= THelper.RemoveAcentos(RESTResponse.JSONValue.GetValue('bairro',''));
    cbx_uf.ItemIndex:= cbx_uf.Items.IndexOf(RESTResponse.JSONValue.GetValue('uf',''));
    lbe_nome_municipio.Text:= THelper.RemoveAcentos(RESTResponse.JSONValue.GetValue('localidade',''));
  except
    lbe_logradouro.Text:= '';
    lbe_complemento.Text:= '';
    lbe_bairro.Text:= '';
    cbx_uf.ItemIndex:= -1;
    lbe_nome_municipio.Text:= '';
  end;
end;

procedure TformCedenteCreateEdit.ObjToEdt;
begin
  if (Cedente.Id = EmptyStr) then
  begin
    Cedente.ContaId:= TAuthService.ContaId;
    cbx_tipo_documento.ItemIndex:= 0;
    cbx_tipo_cateira.ItemIndex:= 0;
    cbx_respon_emissao.ItemIndex:= 0;
    cbx_carac_titulo.ItemIndex:= 0;
    cbx_uf.ItemIndex:= 12;
    Exit();
  end;

  lbe_nome.Text:= Cedente.Nome;
  lbe_codigo_cedente.Text:= Cedente.CodigoCedente;
  lbe_codigo_transmissao.Text:= Cedente.CodigoTransmissao;
  lbe_agencia.Text:= Cedente.Agencia;
  lbe_agencia_digito.Text:= Cedente.AgenciaDigito;
  lbe_conta.Text:= Cedente.Conta;
  lbe_conta_digito.Text:= Cedente.ContaDigito;
  lbe_modalidade.Text:= Cedente.Modalidade;
  lbe_convenio.Text:= Cedente.Convenio;
  cbx_tipo_documento.ItemIndex:= Cedente.TipoDocumento -1;
  cbx_tipo_cateira.ItemIndex:= Cedente.TipoCarteira;
  cbx_respon_emissao.ItemIndex:= Cedente.ResponEmissao;
  cbx_carac_titulo.ItemIndex:= Cedente.CaracTitulo;
  lbe_cnpjcpf.Text:= Cedente.Cnpjcpf;
  lbe_logradouro.Text:= Cedente.Logradouro;
  lbe_numero.Text:= Cedente.NumeroRes;
  lbe_complemento.Text:= Cedente.Complemento;
  lbe_bairro.Text:= Cedente.Bairro;
  lbe_nome_municipio.Text:= Cedente.Cidade;
  cbx_uf.ItemIndex:= cbx_uf.Items.IndexOf(Cedente.Uf);
  mke_cep.Text:= Cedente.Cep;
  mke_fone.Text:= Cedente.Telefone;
end;

procedure TformCedenteCreateEdit.onEnter(Sender: TObject);
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

procedure TformCedenteCreateEdit.save;
begin
  EdtToObj;
  try
    if validaCamposObrigatorios() then
    begin
      if Cedente.validate() then
      begin
        if Cedente.save then
        begin
          TAuthService.CedenteId:= Cedente.Id;
          Close;
        end;
      end;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformCedenteCreateEdit.setRequired(Obj: TObject);
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

function TformCedenteCreateEdit.validaCamposObrigatorios: Boolean;
var
  vRequired: Integer;
begin
  vRequired:= 0;
  if (Trim(lbe_codigo_cedente.Text) = '') then
  begin
    setRequired(lbe_codigo_cedente);
    Inc(vRequired);
  end;

  if (Trim(lbe_nome.Text) = '') then
  begin
    setRequired(lbe_nome);
    Inc(vRequired);
  end;

  if (Trim(lbe_cnpjcpf.Text) = '') then
  begin
    setRequired(lbe_cnpjcpf);
    Inc(vRequired);
  end;

  if (Trim(lbe_agencia.Text) = '') then
  begin
    setRequired(lbe_agencia);
    Inc(vRequired);
  end;

  if (Trim(lbe_agencia_digito.Text) = '') then
  begin
    setRequired(lbe_agencia_digito);
    Inc(vRequired);
  end;

  if (Trim(lbe_conta.Text) = '') then
  begin
    setRequired(lbe_conta);
    Inc(vRequired);
  end;

  if (Trim(lbe_conta_digito.Text) = '') then
  begin
    setRequired(lbe_conta_digito);
    Inc(vRequired);
  end;

  if (Trim(lbe_modalidade.Text) = '') then
  begin
    setRequired(lbe_modalidade);
    Inc(vRequired);
  end;

  if (Trim(mke_cep.Text) = '') then
  begin
    setRequired(mke_cep);
    Inc(vRequired);
  end;

  if (Trim(lbe_logradouro.Text) = '') then
  begin
    setRequired(lbe_logradouro);
    Inc(vRequired);
  end;

  if (Trim(lbe_numero.Text) = '') then
  begin
    setRequired(lbe_numero);
    Inc(vRequired);
  end;

  if (Trim(lbe_bairro.Text) = '') then
  begin
    setRequired(lbe_bairro);
    Inc(vRequired);
  end;

  if (Trim(cbx_uf.Text) = '') then
  begin
    setRequired(cbx_uf);
    Inc(vRequired);
  end;

  if (Trim(lbe_nome_municipio.Text) = '') then
  begin
    setRequired(lbe_nome_municipio);
    Inc(vRequired);
  end;

  if (Trim(mke_fone.Text) = '') then
  begin
    setRequired(mke_fone);
    Inc(vRequired);
  end;

  Result:= (vRequired = 0);
  if (not Result) then  THelper.Mensagem('Preencha os dados obrigatórios do cedente.');
end;

end.
