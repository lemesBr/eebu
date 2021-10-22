unit uformPessoaCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Pessoa, System.StrUtils, System.Math, System.Actions, Vcl.ActnList, Vcl.Mask,
  Vcl.ComCtrls, IPPeerClient, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope;

type
  TformPessoaCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_2: TBevel;
    pnl_pessoa_header: TPanel;
    pnl_pessoa_footer: TPanel;
    btn_confirmar: TButton;
    pnl_pessoa_body: TPanel;
    btn_cancelar: TButton;
    lbe_nome: TLabeledEdit;
    lbe_razao_social: TLabeledEdit;
    lbe_idestrangeiro: TLabeledEdit;
    lbe_im: TLabeledEdit;
    lbe_isuf: TLabeledEdit;
    ckb_simples: TCheckBox;
    lbe_ie: TLabeledEdit;
    acl_pessoa: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    lbe_logradouro: TLabeledEdit;
    lbe_numero: TLabeledEdit;
    lbe_complemento: TLabeledEdit;
    lbe_bairro: TLabeledEdit;
    lbe_codigo_municipio: TLabeledEdit;
    lbe_nome_municipio: TLabeledEdit;
    lbe_email: TLabeledEdit;
    Bevel1: TBevel;
    bvl_1: TBevel;
    cbx_indiedest: TComboBox;
    Label1: TLabel;
    Bevel2: TBevel;
    mke_documento: TMaskEdit;
    lbe_Document_label: TLabel;
    dtp_data_fundacao_nascimento: TDateTimePicker;
    lbe_Nascimento_fundacao_lbe: TLabel;
    mke_cep: TMaskEdit;
    Label2: TLabel;
    mke_fone: TMaskEdit;
    Label3: TLabel;
    mke_celular: TMaskEdit;
    Label4: TLabel;
    mm_observacao: TMemo;
    Label5: TLabel;
    cbx_uf: TComboBox;
    Label6: TLabel;
    cbx_TipoPessoa: TComboBox;
    Label7: TLabel;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure cbx_TipoPessoaChange(Sender: TObject);
    procedure mke_cepExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Pessoa: TPessoa;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();

    procedure setRequired(Obj: TObject);
    procedure onEnter(Sender: TObject);
    function validaCamposObrigatorios(vtype: Integer = 0): Boolean;
  public
    { Public declarations }
  end;

var
  formPessoaCreateEdit: TformPessoaCreateEdit;

implementation

uses
  AuthService, udmRepository, Helper;

{$R *.dfm}

procedure TformPessoaCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformPessoaCreateEdit.cbx_TipoPessoaChange(Sender: TObject);
begin
  if cbx_TipoPessoa.ItemIndex = 0 then
  begin
    lbe_razao_social.Text:= '';
    lbe_razao_social.Enabled:= False;
    mke_documento.MaxLength:= 11;
    lbe_im.Text:= '';
    lbe_im.Enabled:= False;
    lbe_isuf.Text:= '';
    lbe_isuf.Enabled:= False;
    ckb_simples.Enabled:= False;
    ckb_simples.Checked:= False;
    mke_documento.Text:= '';
    mke_documento.EditMask:= '###.###.###-##;0;_';
    lbe_Document_label.Caption:= '* CPF';
    lbe_Nascimento_fundacao_lbe.Caption:= '* Nascimento';
    cbx_indiedest.ItemIndex:= 2;
  end
  else
  begin
    lbe_razao_social.Enabled:= True;
    mke_documento.Text:= '';
    lbe_Document_label.Caption:= '* CNPJ';
    mke_documento.EditMask:= '##.###.###/####-##;0;_';
    lbe_im.Enabled:= True;
    lbe_isuf.Enabled:= True;
    ckb_simples.Enabled:= True;
    lbe_Nascimento_fundacao_lbe.Caption:= '* Fundação';
    cbx_indiedest.ItemIndex:= 0;
  end;
end;

procedure TformPessoaCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.PessoaId:= EmptyStr;
  Close;
end;

procedure TformPessoaCreateEdit.EdtToObj;
begin
  Pessoa.TipoPessoa:= IfThen(cbx_TipoPessoa.ItemIndex = 0, 'F', 'J');
  Pessoa.Nome:= lbe_nome.Text;
  Pessoa.RazaoSocial:= lbe_razao_social.Text;
  Pessoa.Documento:= mke_documento.Text;
  Pessoa.Idestrangeiro:= lbe_idestrangeiro.Text;
  Pessoa.Im:= lbe_im.Text;
  Pessoa.Isuf:= lbe_isuf.Text;
  Pessoa.Ie:= lbe_ie.Text;
  Pessoa.Simples:= IfThen(ckb_simples.Checked, 'S', 'N');
  case cbx_indiedest.ItemIndex of
    0: Pessoa.Indiedest:= '1';
    1: Pessoa.Indiedest:= '2';
    2: Pessoa.Indiedest:= '9';
  end;
  Pessoa.DataFundacaoNascimento:= dtp_data_fundacao_nascimento.DateTime;
  Pessoa.Cep:= mke_cep.Text;
  Pessoa.Logradouro:= lbe_logradouro.Text;
  Pessoa.Numero:= lbe_numero.Text;
  Pessoa.Complemento:= lbe_complemento.Text;
  Pessoa.Bairro:= lbe_bairro.Text;
  Pessoa.CodigoMunicipio:= lbe_codigo_municipio.Text;
  Pessoa.NomeMunicipio:= lbe_nome_municipio.Text;
  Pessoa.Uf:= cbx_uf.Text;
  Pessoa.Fone:= mke_fone.Text;
  Pessoa.Celular:= mke_celular.Text;
  Pessoa.Email:= lbe_email.Text;
  Pessoa.Observacao:= mm_observacao.Text;
end;

procedure TformPessoaCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  if TAuthService.PessoaId = EmptyStr then Pessoa:= TPessoa.Create
  else Pessoa:= TPessoa.find(TAuthService.PessoaId);
  ObjToEdt;
end;

procedure TformPessoaCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Pessoa);
end;

procedure TformPessoaCreateEdit.FormShow(Sender: TObject);
begin
  if (Self.Tag = 1) then
    validaCamposObrigatorios(1);
end;

procedure TformPessoaCreateEdit.mke_cepExit(Sender: TObject);
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

procedure TformPessoaCreateEdit.ObjToEdt;
begin
  if (Pessoa.Id = EmptyStr) then
  begin
    pnl_pessoa_header.Caption:= 'NOVA PESSOA';
    cbx_TipoPessoa.ItemIndex:= 0;
    cbx_TipoPessoaChange(cbx_TipoPessoa);
    cbx_indiedest.ItemIndex:= 2;
    dtp_data_fundacao_nascimento.Date:= Now;
    Exit();
  end;

  pnl_pessoa_header.Caption:= 'EDITAR PESSOA';
  cbx_TipoPessoa.ItemIndex:= IfThen(Pessoa.TipoPessoa = 'F', 0, 1);
  cbx_TipoPessoaChange(cbx_TipoPessoa);
  lbe_nome.Text:= Pessoa.Nome;
  lbe_razao_social.Text:= Pessoa.RazaoSocial;
  mke_documento.Text:= Pessoa.Documento;
  lbe_idestrangeiro.Text:= Pessoa.Idestrangeiro;
  lbe_im.Text:= Pessoa.Im;
  lbe_isuf.Text:= Pessoa.Isuf;
  lbe_ie.Text:= Pessoa.Ie;
  ckb_simples.Checked:= (Pessoa.Simples = 'S');
  case StrToIntDef(Pessoa.Indiedest, 1) of
    1: cbx_indiedest.ItemIndex:= 0;
    2: cbx_indiedest.ItemIndex:= 1;
    9: cbx_indiedest.ItemIndex:= 2;
  end;
  dtp_data_fundacao_nascimento.Date:= Pessoa.DataFundacaoNascimento;
  mke_cep.Text:= Pessoa.Cep;
  lbe_logradouro.Text:= Pessoa.Logradouro;
  lbe_numero.Text:= Pessoa.Numero;
  lbe_complemento.Text:= Pessoa.Complemento;
  lbe_bairro.Text:= Pessoa.Bairro;
  lbe_codigo_municipio.Text:= Pessoa.CodigoMunicipio;
  lbe_nome_municipio.Text:= Pessoa.NomeMunicipio;
  cbx_uf.ItemIndex:= cbx_uf.Items.IndexOf(Pessoa.Uf);
  mke_fone.Text:= Pessoa.Fone;
  mke_celular.Text:= Pessoa.Celular;
  lbe_email.Text:= Pessoa.Email;
  mm_observacao.Text:= Pessoa.Observacao;
end;

procedure TformPessoaCreateEdit.onEnter(Sender: TObject);
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

procedure TformPessoaCreateEdit.save;
begin
  EdtToObj;
  try
    if validaCamposObrigatorios(Self.Tag) then
    begin
      if Pessoa.validate() then
      begin
        if Pessoa.save then
        begin
          TAuthService.PessoaId:= Pessoa.Id;
          Close;
        end;
      end;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

function TformPessoaCreateEdit.validaCamposObrigatorios(
  vtype: Integer): Boolean;
var
  v_required: Integer;
begin
  v_required:= 0;
  case vtype of
    0: begin
      if (Trim(lbe_nome.Text) = '') then
      begin
        setRequired(lbe_nome);
        Inc(v_required);
      end;

      if (Trim(lbe_razao_social.Text) = '') and (cbx_TipoPessoa.ItemIndex = 1) then
      begin
        setRequired(lbe_razao_social);
        Inc(v_required);
      end;

      if (Trim(mke_documento.Text) = '') then
      begin
        setRequired(mke_documento);
        Inc(v_required);
      end;
    end;
    1:begin
      if (Trim(lbe_nome.Text) = '') then
      begin
        setRequired(lbe_nome);
        Inc(v_required);
      end;

      if (Trim(lbe_razao_social.Text) = '') and (cbx_TipoPessoa.ItemIndex = 1) then
      begin
        setRequired(lbe_razao_social);
        Inc(v_required);
      end;

      if (Trim(mke_documento.Text) = '') then
      begin
        setRequired(mke_documento);
        Inc(v_required);
      end;

      if (Trim(mke_cep.Text) = '') then
      begin
        setRequired(mke_cep);
        Inc(v_required);
      end;

      if (Trim(lbe_logradouro.Text) = '') then
      begin
        setRequired(lbe_logradouro);
        Inc(v_required);
      end;

      if (Trim(lbe_numero.Text) = '') then
      begin
        setRequired(lbe_numero);
        Inc(v_required);
      end;

      if (Trim(lbe_bairro.Text) = '') then
      begin
        setRequired(lbe_bairro);
        Inc(v_required);
      end;

      if (Trim(cbx_uf.Items[cbx_uf.ItemIndex]) = '') then
      begin
        setRequired(cbx_uf);
        Inc(v_required);
      end;

      if (Trim(lbe_nome_municipio.Text) = '') then
      begin
        setRequired(lbe_nome_municipio);
        Inc(v_required);
      end;

      if (Trim(lbe_codigo_municipio.Text) = '') then
      begin
        setRequired(lbe_codigo_municipio);
        Inc(v_required);
      end;
    end;
  end;

  Result:= (v_required = 0);
  if (not Result) then  THelper.Mensagem('Preencha os dados obrigatórios da pessoa.');
end;

procedure TformPessoaCreateEdit.setRequired(Obj: TObject);
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

end.
