unit Contabilista;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client,
  Data.DB, ACBrValidador;

type
  TContabilista = class(TModel)
  private
    FEMPRESA_ID: String;
    FNOME: String;
    FCPF: String;
    FCRC: String;
    FCNPJ: String;
    FCEP: String;
    FLOGRADOURO: String;
    FNUMERO: String;
    FCOMPLEMENTO: String;
    FBAIRRO: String;
    FCODIGO_MUNICIPIO: String;
    FFONE: String;
    FFAX: String;
    FEMAIL: String;
    procedure getBairro(const Value: String);
    procedure getComplemento(const Value: String);
    procedure getEmail(const Value: String);
    procedure getLogradouro(const Value: String);
    procedure getNome(const Value: String);
    function setBairro: String;
    function setComplemento: String;
    function setEmail: String;
    function setLogradouro: String;
    function setNome: String;
  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    function validate: Boolean;
    class function find(id: string): TContabilista;
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property Nome: String  read setNome write getNome;
    property Cpf: String  read FCPF write FCPF;
    property Crc: String  read FCRC write FCRC;
    property Cnpj: String  read FCNPJ write FCNPJ;
    property Cep: String  read FCEP write FCEP;
    property Logradouro: String  read setLogradouro write getLogradouro;
    property Numero: String  read FNUMERO write FNUMERO;
    property Complemento: String  read setComplemento write getComplemento;
    property Bairro: String  read setBairro write getBairro;
    property CodigoMunicipio: String  read FCODIGO_MUNICIPIO write FCODIGO_MUNICIPIO;
    property Fone: String  read FFONE write FFONE;
    property Fax: String  read FFAX write FFAX;
    property Email: String  read setEmail write getEmail;

  end;

implementation

uses
  AuthService, Helper;

{ TContabilista }

constructor TContabilista.Create;
begin
  Self.Table:= 'CONTABILISTAS';
end;

class function TContabilista.find(id: string): TContabilista;
const
  FSql: string = 'SELECT * FROM CONTABILISTAS WHERE (ID = :ID) AND DELETED_AT IS NULL';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= TModel.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('ID').AsString:= id;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TContabilista.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.Nome:= FDQuery.FieldByName('NOME').AsString;
        Result.Cpf:= FDQuery.FieldByName('CPF').AsString;
        Result.Crc:= FDQuery.FieldByName('CRC').AsString;
        Result.Cnpj:= FDQuery.FieldByName('CNPJ').AsString;
        Result.Cep:= FDQuery.FieldByName('CEP').AsString;
        Result.Logradouro:= FDQuery.FieldByName('LOGRADOURO').AsString;
        Result.Numero:= FDQuery.FieldByName('NUMERO').AsString;
        Result.Complemento:= FDQuery.FieldByName('COMPLEMENTO').AsString;
        Result.Bairro:= FDQuery.FieldByName('BAIRRO').AsString;
        Result.CodigoMunicipio:= FDQuery.FieldByName('CODIGO_MUNICIPIO').AsString;
        Result.Fone:= FDQuery.FieldByName('FONE').AsString;
        Result.Fax:= FDQuery.FieldByName('FAX').AsString;
        Result.Email:= FDQuery.FieldByName('EMAIL').AsString;
        Result.CreatedAt:= FDQuery.FieldByName('CREATED_AT').AsDateTime;
        Result.UpdatedAt:= FDQuery.FieldByName('UPDATED_AT').AsDateTime;
        Result.Synchronized:= FDQuery.FieldByName('SYNCHRONIZED').AsString;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

procedure TContabilista.getBairro(const Value: String);
begin
  FBAIRRO:= THelper.RemoveAcentos(Value);
end;

procedure TContabilista.getComplemento(const Value: String);
begin
  FCOMPLEMENTO:= THelper.RemoveAcentos(Value);
end;

procedure TContabilista.getEmail(const Value: String);
begin
  FEMAIL:= THelper.RemoveAcentos(Value);
end;

procedure TContabilista.getLogradouro(const Value: String);
begin
  FLOGRADOURO:= THelper.RemoveAcentos(Value);
end;

procedure TContabilista.getNome(const Value: String);
begin
  FNOME:= THelper.RemoveAcentos(Value);
end;

function TContabilista.save: Boolean;
begin
  Result:= inherited;
end;

function TContabilista.setBairro: String;
begin
  Result:= THelper.RemoveAcentos(FBAIRRO);
end;

function TContabilista.setComplemento: String;
begin
  Result:= THelper.RemoveAcentos(FCOMPLEMENTO);
end;

function TContabilista.setEmail: String;
begin
  Result:= THelper.RemoveAcentos(FEMAIL);
end;

function TContabilista.setLogradouro: String;
begin
  Result:= THelper.RemoveAcentos(FLOGRADOURO);
end;

function TContabilista.setNome: String;
begin
  Result:= THelper.RemoveAcentos(FNOME);
end;

function TContabilista.store: Boolean;
const
  FSql: string =
  'INSERT INTO CONTABILISTAS (ID,EMPRESA_ID,NOME,CPF,CRC,CNPJ,CEP,LOGRADOURO,' +
  'NUMERO,COMPLEMENTO,BAIRRO,CODIGO_MUNICIPIO,FONE,FAX,EMAIL,CREATED_AT,' +
  'UPDATED_AT) VALUES (:ID,:EMPRESA_ID,:NOME,:CPF,:CRC,:CNPJ,:CEP,:LOGRADOURO,' +
  ':NUMERO,:COMPLEMENTO,:BAIRRO,:CODIGO_MUNICIPIO,:FONE,:FAX,:EMAIL,' +
  ':CREATED_AT,:UPDATED_AT)';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= TModel.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NOME').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CPF').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CRC').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CNPJ').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CEP').DataType:= ftWideString;
      FDQuery.Params.ParamByName('LOGRADOURO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('NUMERO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('COMPLEMENTO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('BAIRRO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CODIGO_MUNICIPIO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('FONE').DataType:= ftWideString;
      FDQuery.Params.ParamByName('FAX').DataType:= ftWideString;
      FDQuery.Params.ParamByName('EMAIL').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.EmpresaId <> EmptyStr) then
        FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      if (Self.Nome <> EmptyStr) then
        FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      if (Self.Cpf <> EmptyStr) then
        FDQuery.Params.ParamByName('CPF').AsString:= Self.Cpf;
      if (Self.Crc <> EmptyStr) then
        FDQuery.Params.ParamByName('CRC').AsString:= Self.Crc;
      if (Self.Cnpj <> EmptyStr) then
        FDQuery.Params.ParamByName('CNPJ').AsString:= Self.Cnpj;
      if (Self.Cep <> EmptyStr) then
        FDQuery.Params.ParamByName('CEP').AsString:= Self.Cep;
      if (Self.Logradouro <> EmptyStr) then
        FDQuery.Params.ParamByName('LOGRADOURO').AsString:= Self.Logradouro;
      if (Self.Numero <> EmptyStr) then
        FDQuery.Params.ParamByName('NUMERO').AsString:= Self.Numero;
      if (Self.Complemento <> EmptyStr) then
        FDQuery.Params.ParamByName('COMPLEMENTO').AsString:= Self.Complemento;
      if (Self.Bairro <> EmptyStr) then
        FDQuery.Params.ParamByName('BAIRRO').AsString:= Self.Bairro;
      if (Self.CodigoMunicipio <> EmptyStr) then
        FDQuery.Params.ParamByName('CODIGO_MUNICIPIO').AsString:= Self.CodigoMunicipio;
      if (Self.Fone <> EmptyStr) then
        FDQuery.Params.ParamByName('FONE').AsString:= Self.Fone;
      if (Self.Fax <> EmptyStr) then
        FDQuery.Params.ParamByName('FAX').AsString:= Self.Fax;
      if (Self.Email <> EmptyStr) then
        FDQuery.Params.ParamByName('EMAIL').AsString:= Self.Email;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except
      Result:= False;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TContabilista.update: Boolean;
const
  FSql: string =
  'UPDATE CONTABILISTAS SET NOME = :NOME, CPF = :CPF, CRC = :CRC, CNPJ = :CNPJ,' +
  'CEP = :CEP, LOGRADOURO = :LOGRADOURO, NUMERO = :NUMERO, ' +
  'COMPLEMENTO = :COMPLEMENTO, BAIRRO = :BAIRRO, ' +
  'CODIGO_MUNICIPIO = :CODIGO_MUNICIPIO, FONE = :FONE, FAX = :FAX, EMAIL = :EMAIL, ' +
  'UPDATED_AT = :UPDATED_AT, SYNCHRONIZED = :SYNCHRONIZED WHERE (ID = :ID)';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= TModel.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NOME').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CPF').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CRC').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CNPJ').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CEP').DataType:= ftWideString;
      FDQuery.Params.ParamByName('LOGRADOURO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('NUMERO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('COMPLEMENTO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('BAIRRO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CODIGO_MUNICIPIO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('FONE').DataType:= ftWideString;
      FDQuery.Params.ParamByName('FAX').DataType:= ftWideString;
      FDQuery.Params.ParamByName('EMAIL').DataType:= ftWideString;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.Nome <> EmptyStr) then
        FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      if (Self.Cpf <> EmptyStr) then
        FDQuery.Params.ParamByName('CPF').AsString:= Self.Cpf;
      if (Self.Crc <> EmptyStr) then
        FDQuery.Params.ParamByName('CRC').AsString:= Self.Crc;
      if (Self.Cnpj <> EmptyStr) then
        FDQuery.Params.ParamByName('CNPJ').AsString:= Self.Cnpj;
      if (Self.Cep <> EmptyStr) then
        FDQuery.Params.ParamByName('CEP').AsString:= Self.Cep;
      if (Self.Logradouro <> EmptyStr) then
        FDQuery.Params.ParamByName('LOGRADOURO').AsString:= Self.Logradouro;
      if (Self.Numero <> EmptyStr) then
        FDQuery.Params.ParamByName('NUMERO').AsString:= Self.Numero;
      if (Self.Complemento <> EmptyStr) then
        FDQuery.Params.ParamByName('COMPLEMENTO').AsString:= Self.Complemento;
      if (Self.Bairro <> EmptyStr) then
        FDQuery.Params.ParamByName('BAIRRO').AsString:= Self.Bairro;
      if (Self.CodigoMunicipio <> EmptyStr) then
        FDQuery.Params.ParamByName('CODIGO_MUNICIPIO').AsString:= Self.CodigoMunicipio;
      if (Self.Fone <> EmptyStr) then
        FDQuery.Params.ParamByName('FONE').AsString:= Self.Fone;
      if (Self.Fax <> EmptyStr) then
        FDQuery.Params.ParamByName('FAX').AsString:= Self.Fax;
      if (Self.Email <> EmptyStr) then
        FDQuery.Params.ParamByName('EMAIL').AsString:= Self.Email;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except
      Result:= False;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TContabilista.validate: Boolean;
var
  vMensagem: string;
  vTitle: string;
begin
  Result:= True;
  try
    vTitle:= 'OPSSS!' + #13;

    if (Trim(Self.Cpf) <> '')
    and (ValidarCPF(Trim(Self.Cpf)) <> '') then
    begin
      vMensagem:= 'CPF informado é inválido.';
      Exit();
    end;

    if (Trim(Self.Cnpj) <> '')
    and (ValidarCNPJ(Trim(Self.Cnpj)) <> '') then
    begin
      vMensagem:= 'CNPJ informado é inválido.';
      Exit();
    end;

    if (Trim(Self.Cep) <> '')
    and (Trim(Self.Cep).Length <= 7) then
    begin
      vMensagem:= 'CEP informado é inválido.';
      Exit();
    end;
  finally
    if (vMensagem <> '') then
    begin
      THelper.Mensagem(vTitle + vMensagem);
      Result:= False;
    end;
  end;
end;

end.
