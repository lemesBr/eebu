unit uformEmpresaCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Empresa, System.StrUtils, System.Math, Vcl.Mask, System.Actions, Vcl.ActnList,
  IPPeerClient, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  Vcl.ComCtrls, System.JSON;

type
  TformEmpresaCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    lbe_iest: TLabeledEdit;
    lbe_cnae: TLabeledEdit;
    cbx_crt: TComboBox;
    lb_crt: TLabel;
    bvl_3: TBevel;
    lb_fone: TLabel;
    lb_celular: TLabel;
    lbe_logradouro: TLabeledEdit;
    lbe_numero: TLabeledEdit;
    lbe_complemento: TLabeledEdit;
    lbe_bairro: TLabeledEdit;
    lbe_codigo_municipio: TLabeledEdit;
    lbe_nome_municipio: TLabeledEdit;
    lbe_email: TLabeledEdit;
    mke_cep: TMaskEdit;
    mke_fone: TMaskEdit;
    mke_celular: TMaskEdit;
    cbx_uf: TComboBox;
    lb_cep: TLabel;
    lb_uf: TLabel;
    cbx_tipo_pessoa: TComboBox;
    lb_tipo_pessoa: TLabel;
    lbe_nome: TLabeledEdit;
    lbe_razao_social: TLabeledEdit;
    mke_documento: TMaskEdit;
    lb_documento: TLabel;
    lbe_ie: TLabeledEdit;
    lbe_im: TLabeledEdit;
    acl_empresa: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    btn_cancelar: TButton;
    btn_confirmar: TButton;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    bvl_4: TBevel;
    dtp_controle_consulta: TDateTimePicker;
    lb_controle_consulta: TLabel;
    RESTCliEmpresa: TRESTClient;
    RESTReqEmpresa: TRESTRequest;
    RESTRespEmpresa: TRESTResponse;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbx_tipo_pessoaChange(Sender: TObject);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure mke_cepExit(Sender: TObject);
  private
    { Private declarations }
    Empresa: TEmpresa;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();

    procedure setRequired(Obj: TObject);
    procedure onEnter(Sender: TObject);
    function validaCamposObrigatorios(): Boolean;
    procedure clientewt();
  public
    { Public declarations }
  end;

var
  formEmpresaCreateEdit: TformEmpresaCreateEdit;

implementation

uses
  AuthService, udmRepository, Helper;

{$R *.dfm}

{ TformEmpresaCreateEdit }

procedure TformEmpresaCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  Close;
end;

procedure TformEmpresaCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformEmpresaCreateEdit.cbx_tipo_pessoaChange(Sender: TObject);
begin
  if cbx_tipo_pessoa.ItemIndex = 0 then
  begin
    lbe_razao_social.Text:= '';
    lbe_razao_social.EditLabel.Caption:= 'Razão social';
    lbe_razao_social.EditLabel.Font.Style:= [];
    lbe_razao_social.Enabled:= False;
    lbe_iest.Text:= '';
    lbe_iest.Enabled:= False;
    lbe_im.Text:= '';
    lbe_im.Enabled:= False;
    lbe_cnae.Text:= '';
    lbe_cnae.Enabled:= False;
    cbx_crt.ItemIndex:= 0;
    cbx_crt.Enabled:= False;
    lb_crt.Enabled:= False;
    mke_documento.Text:= '';
    mke_documento.EditMask:= '###.###.###-##;0;_';
    lb_documento.Caption:= '* CPF';
  end
  else
  begin
    lbe_razao_social.Text:= '';
    lbe_razao_social.EditLabel.Caption:= '* Razão social';
    lbe_razao_social.EditLabel.Font.Style:= [fsBold];
    lbe_razao_social.Enabled:= True;
    lbe_iest.Text:= '';
    lbe_iest.Enabled:= True;
    lbe_im.Text:= '';
    lbe_im.Enabled:= True;
    lbe_cnae.Text:= '';
    lbe_cnae.Enabled:= True;
    cbx_crt.ItemIndex:= 2;
    cbx_crt.Enabled:= True;
    lb_crt.Enabled:= True;
    mke_documento.Text:= '';
    mke_documento.EditMask:= '##.###.###/####-##;0;_';
    lb_documento.Caption:= '* CNPJ';
  end;
end;

procedure TformEmpresaCreateEdit.clientewt;
var
  jMessages: TJSONArray;
  vMessages: string;
  I: Integer;
begin
  if (Empresa.Id = EmptyStr) or (Empresa.Synchronized = EmptyStr) then
  begin
    try
      with RESTReqEmpresa.Params do
      begin
        ParameterByName('sistema_id').Value:= '1';
        ParameterByName('cidade_id').Value:= '1';
        ParameterByName('representante_id').Value:= '6';
        ParameterByName('nome').Value:= Empresa.Nome;
        ParameterByName('documento').Value:= Empresa.Documento;
        ParameterByName('ie').Value:= Empresa.Ie;
        ParameterByName('iest').Value:= Empresa.Iest;
        ParameterByName('im').Value:= Empresa.Im;
        ParameterByName('cnae').Value:= Empresa.Cnae;
        ParameterByName('crt').Value:= Empresa.Crt;
        ParameterByName('cep').Value:= Empresa.Cep;
        ParameterByName('logradouro').Value:= Empresa.Logradouro;
        ParameterByName('numero').Value:= Empresa.Numero;
        ParameterByName('complemento').Value:= Empresa.Complemento;
        ParameterByName('uf').Value:= Empresa.Uf;
        ParameterByName('bairro').Value:= Empresa.Bairro;
        ParameterByName('codigo_municipio').Value:= Empresa.CodigoMunicipio;
        ParameterByName('nome_municipio').Value:= Empresa.NomeMunicipio;
        ParameterByName('fone').Value:= Empresa.Fone;
        ParameterByName('celular').Value:= Empresa.Celular;
        ParameterByName('email').Value:= Empresa.Email;
        ParameterByName('mensalidade').Value:= '98.78';
      end;
      RESTReqEmpresa.Execute();
      if (RESTRespEmpresa.JSONValue.GetValue('error','') = 'true') then
      begin
        jMessages:= (RESTRespEmpresa.JSONValue.GetValue<TJSONArray>('messages') as TJSONArray);
        vMessages:= '';
        for I:= 0 to Pred(jMessages.Count) do
          vMessages:= vMessages + ' ' + jMessages.Items[I].ToString();

        raise Exception.Create(StringReplace(vMessages,'"','',[rfReplaceAll]));
      end;
    except on e: Exception do
      raise Exception.Create('Falha ao tentar registrar empresa no servidor. Erro: ' + e.Message);
    end;
  end;
end;

procedure TformEmpresaCreateEdit.EdtToObj;
begin
  Empresa.TipoPessoa:= IfThen(cbx_tipo_pessoa.ItemIndex = 0, 'F', 'J');
  Empresa.Nome:= lbe_nome.Text;
  Empresa.RazaoSocial:= lbe_razao_social.Text;
  Empresa.Documento:= mke_documento.Text;
  Empresa.Ie:= lbe_ie.Text;
  Empresa.Iest:= lbe_iest.Text;
  Empresa.Im:= lbe_im.Text;
  Empresa.Cnae:= lbe_cnae.Text;
  Empresa.Crt:= (cbx_crt.ItemIndex + 1).ToString();
  Empresa.Cep:= mke_cep.Text;
  Empresa.Logradouro:= lbe_logradouro.Text;
  Empresa.Numero:= lbe_numero.Text;
  Empresa.Complemento:= lbe_complemento.Text;
  Empresa.Bairro:= lbe_bairro.Text;
  Empresa.CodigoMunicipio:= lbe_codigo_municipio.Text;
  Empresa.NomeMunicipio:= lbe_nome_municipio.Text;
  Empresa.Uf:= cbx_uf.Text;
  Empresa.Fone:= mke_fone.Text;
  Empresa.Celular:= mke_celular.Text;
  Empresa.Email:= lbe_email.Text;
  Empresa.ControleConsulta:= dtp_controle_consulta.Date;
end;

procedure TformEmpresaCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  if TAuthService.getAuthenticatedEmpresaId = EmptyStr then Empresa:= TEmpresa.Create
  else Empresa:= TEmpresa.find(TAuthService.getAuthenticatedEmpresaId);
  ObjToEdt;
end;

procedure TformEmpresaCreateEdit.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Empresa);
end;

procedure TformEmpresaCreateEdit.mke_cepExit(Sender: TObject);
var
  vCep: string;
begin
  vCep:= Trim(mke_cep.Text);
  if not (vCep.Length = 8) then Exit();

  try
    RESTClient.BaseURL:= 'https://viacep.com.br/ws/' + vCep + '/json';
    RESTRequest.Execute;

    lbe_logradouro.Text:= THelper.RemoveAcentos(RESTResponse.JSONValue.GetValue('logradouro',''));
    lbe_logradouro.Color:= clWindow;
    lbe_complemento.Text:= THelper.RemoveAcentos(RESTResponse.JSONValue.GetValue('complemento',''));
    lbe_complemento.Color:= clWindow;
    lbe_bairro.Text:= THelper.RemoveAcentos(RESTResponse.JSONValue.GetValue('bairro',''));
    lbe_bairro.Color:= clWindow;
    lbe_nome_municipio.Text:= THelper.RemoveAcentos(RESTResponse.JSONValue.GetValue('localidade',''));
    lbe_nome_municipio.Color:= clWindow;
    lbe_codigo_municipio.Text:= RESTResponse.JSONValue.GetValue('ibge','');
    lbe_codigo_municipio.Color:= clWindow;
    cbx_uf.ItemIndex:= cbx_uf.Items.IndexOf(RESTResponse.JSONValue.GetValue('uf',''));
    cbx_uf.Color:= clWindow;
  except
    lbe_logradouro.Text:= '';
    lbe_complemento.Text:= '';
    lbe_bairro.Text:= '';
    lbe_nome_municipio.Text:= '';
    lbe_codigo_municipio.Text:= '';
    cbx_uf.ItemIndex:= -1;
  end;
end;

procedure TformEmpresaCreateEdit.ObjToEdt;
begin
  cbx_tipo_pessoa.ItemIndex:= IfThen(Empresa.TipoPessoa = 'F', 0, 1);
  cbx_tipo_pessoaChange(cbx_tipo_pessoa);

  lbe_nome.Text:= Empresa.Nome;
  lbe_razao_social.Text:= Empresa.RazaoSocial;
  mke_documento.Text:= Empresa.Documento;
  lbe_ie.Text:= Empresa.ie;
  lbe_iest.Text:= Empresa.Iest;
  lbe_im.Text:= Empresa.Im;
  lbe_cnae.Text:= Empresa.Cnae;
  cbx_crt.ItemIndex:= (StrToIntDef(Empresa.Crt,1) - 1);
  mke_cep.Text:= Empresa.Cep;
  lbe_logradouro.Text:= Empresa.Logradouro;
  lbe_numero.Text:= Empresa.Numero;
  lbe_complemento.Text:= Empresa.Complemento;
  lbe_bairro.Text:= Empresa.Bairro;
  lbe_codigo_municipio.Text:= Empresa.CodigoMunicipio;
  lbe_nome_municipio.Text:= Empresa.NomeMunicipio;
  cbx_uf.ItemIndex:= cbx_uf.Items.IndexOf(Empresa.Uf);
  mke_fone.Text:= Empresa.Fone;
  mke_celular.Text:= Empresa.Celular;
  lbe_email.Text:= Empresa.Email;
  
  if (Empresa.Id = EmptyStr) then
    dtp_controle_consulta.Date:= Now()
  else
    dtp_controle_consulta.Date:= Empresa.ControleConsulta;   
end;

procedure TformEmpresaCreateEdit.onEnter(Sender: TObject);
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

procedure TformEmpresaCreateEdit.save;
begin
  EdtToObj;
  try
    if validaCamposObrigatorios() then
    begin
      if Empresa.validate() then
      begin
        { TODO 1 -oThiago Ribeiro -cBaixa :
        É necessário fazer um meio de validação da empresa online.
        Não necessário a primeiro momento, mas a partir de 20 clientes
        pode se pensar. }
        //clientewt();
        if Empresa.save() then
        begin
          TAuthService.userAuthenticate(TAuthService.getAuthenticatedUserId);
          Close;
        end;
      end;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformEmpresaCreateEdit.setRequired(Obj: TObject);
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

function TformEmpresaCreateEdit.validaCamposObrigatorios(): Boolean;
var
  vRequired: Integer;
begin
  vRequired:= 0;
  if (Trim(lbe_nome.Text) = '') then
  begin
    setRequired(lbe_nome);
    Inc(vRequired);
  end;

  if (cbx_tipo_pessoa.ItemIndex = 1)
  and (Trim(lbe_razao_social.Text) = '') then
  begin
    setRequired(lbe_razao_social);
    Inc(vRequired);
  end;

  if (Trim(mke_documento.Text) = '') then
  begin
    setRequired(mke_documento);
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

  if (Trim(lbe_codigo_municipio.Text) = '') then
  begin
    setRequired(lbe_codigo_municipio);
    Inc(vRequired);
  end;

  if (Trim(mke_fone.Text) = '') then
  begin
    setRequired(mke_fone);
    Inc(vRequired);
  end;

  if (Trim(mke_celular.Text) = '') then
  begin
    setRequired(mke_celular);
    Inc(vRequired);
  end;

  if (Trim(lbe_email.Text) = '') then
  begin
    setRequired(lbe_email);
    Inc(vRequired);
  end;

  Result:= (vRequired = 0);
  if (not Result) then  THelper.Mensagem('Preencha os dados obrigatórios empresa.');
end;

end.