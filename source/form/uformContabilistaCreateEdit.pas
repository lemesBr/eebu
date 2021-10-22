unit uformContabilistaCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Contabilista, System.Actions, Vcl.ActnList, Vcl.Mask, IPPeerClient,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope;

type
  TformContabilistaCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    lbe_crc: TLabeledEdit;
    acl_contabilista: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    mke_cnpj: TMaskEdit;
    lb_cnpj: TLabel;
    mke_cpf: TMaskEdit;
    lb_cpf: TLabel;
    lb_fone: TLabel;
    lb_fax: TLabel;
    lbe_codigo_municipio: TLabeledEdit;
    lbe_email: TLabeledEdit;
    mke_fone: TMaskEdit;
    mke_fax: TMaskEdit;
    lbe_nome: TLabeledEdit;
    bvl_3: TBevel;
    lbe_logradouro: TLabeledEdit;
    lbe_numero: TLabeledEdit;
    lbe_complemento: TLabeledEdit;
    lbe_bairro: TLabeledEdit;
    mke_cep: TMaskEdit;
    lb_cep: TLabel;
    btn_cancelar: TButton;
    btn_confirmar: TButton;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure mke_cepExit(Sender: TObject);
  private
    { Private declarations }
    Contabilista: TContabilista;
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
  formContabilistaCreateEdit: TformContabilistaCreateEdit;

implementation

uses
  Empresa, AuthService, udmRepository, Helper;

{$R *.dfm}

{ TformContabilistaCreateEdit }

procedure TformContabilistaCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  Close();
end;

procedure TformContabilistaCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformContabilistaCreateEdit.EdtToObj;
begin
  Contabilista.Nome:= lbe_nome.Text;
  Contabilista.Cpf:= mke_cpf.Text;
  Contabilista.Crc:= lbe_crc.Text;
  Contabilista.Cnpj:= mke_cnpj.Text;
  Contabilista.Cep:= mke_cep.Text;
  Contabilista.Logradouro:= lbe_logradouro.Text;
  Contabilista.Numero:= lbe_numero.Text;
  Contabilista.Complemento:= lbe_complemento.Text;
  Contabilista.Bairro:= lbe_bairro.Text;
  Contabilista.CodigoMunicipio:= lbe_codigo_municipio.Text;
  Contabilista.Fone:= mke_fone.Text;
  Contabilista.Fax:= mke_fax.Text;
  Contabilista.Email:= lbe_email.Text;
end;

procedure TformContabilistaCreateEdit.FormCreate(Sender: TObject);
var
  Empresa: TEmpresa;
  ContabilistaId: string;
begin
  inherited;
  try
    ContabilistaId:= EmptyStr;
    Empresa:= TEmpresa.find(TAuthService.getAuthenticatedEmpresaId);
    if Assigned(Empresa.Contabilista) then
      ContabilistaId:= Empresa.Contabilista.Id;
    if (ContabilistaId = EmptyStr) then Contabilista:= TContabilista.Create
    else Contabilista:= TContabilista.find(ContabilistaId);
    ObjToEdt;
  finally
    FreeAndNil(Empresa);
  end;
end;

procedure TformContabilistaCreateEdit.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Contabilista);
end;

procedure TformContabilistaCreateEdit.mke_cepExit(Sender: TObject);
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
    lbe_codigo_municipio.Text:= RESTResponse.JSONValue.GetValue('ibge','');
    lbe_codigo_municipio.Color:= clWindow;
  except
    lbe_logradouro.Text:= '';
    lbe_complemento.Text:= '';
    lbe_bairro.Text:= '';
    lbe_codigo_municipio.Text:= '';
  end;
end;

procedure TformContabilistaCreateEdit.ObjToEdt;
begin
  lbe_nome.Text:= Contabilista.Nome;
  mke_cpf.Text:= Contabilista.Cpf;
  lbe_crc.Text:= Contabilista.Crc;
  mke_cnpj.Text:= Contabilista.Cnpj;
  mke_cep.Text:= Contabilista.Cep;
  lbe_logradouro.Text:= Contabilista.Logradouro;
  lbe_numero.Text:= Contabilista.Numero;
  lbe_complemento.Text:= Contabilista.Complemento;
  lbe_bairro.Text:= Contabilista.Bairro;
  lbe_codigo_municipio.Text:= Contabilista.CodigoMunicipio;
  mke_fone.Text:= Contabilista.Fone;
  mke_fax.Text:= Contabilista.Fax;
  lbe_email.Text:= Contabilista.Email;
end;

procedure TformContabilistaCreateEdit.onEnter(Sender: TObject);
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

procedure TformContabilistaCreateEdit.save;
begin
  EdtToObj;
  try
    if validaCamposObrigatorios() then
    begin
      if Contabilista.validate() then
      begin
        if Contabilista.save() then
          Close;
      end;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformContabilistaCreateEdit.setRequired(Obj: TObject);
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

function TformContabilistaCreateEdit.validaCamposObrigatorios: Boolean;
var
  vRequired: Integer;
begin
  vRequired:= 0;
  if (Trim(lbe_nome.Text) = '') then
  begin
    setRequired(lbe_nome);
    Inc(vRequired);
  end;

  if (Trim(mke_cpf.Text) = '') then
  begin
    setRequired(mke_cpf);
    Inc(vRequired);
  end;

  if (Trim(mke_cnpj.Text) = '') then
  begin
    setRequired(mke_cnpj);
    Inc(vRequired);
  end;

  if (Trim(lbe_crc.Text) = '') then
  begin
    setRequired(lbe_crc);
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

  if (Trim(mke_fax.Text) = '') then
  begin
    setRequired(mke_fone);
    Inc(vRequired);
  end;

  if (Trim(lbe_email.Text) = '') then
  begin
    setRequired(lbe_email);
    Inc(vRequired);
  end;

  Result:= (vRequired = 0);
  if (not Result) then  THelper.Mensagem('Preencha os dados obrigatórios contabilista.');
end;

end.
