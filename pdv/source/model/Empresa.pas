unit Empresa;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  NfeConfiguracao;

type
  TEmpresa = class(TModel)
  private
    FTIPO_PESSOA: String;
    FREFERENCIA: Integer;
    FNOME: String;
    FRAZAO_SOCIAL: String;
    FDOCUMENTO: String;
    FIE: String;
    FIEST: String;
    FIM: String;
    FCNAE: String;
    FCRT: String;
    FCEP: String;
    FLOGRADOURO: String;
    FNUMERO: String;
    FCOMPLEMENTO: String;
    FBAIRRO: String;
    FCODIGO_MUNICIPIO: String;
    FNOME_MUNICIPIO: String;
    FUF: String;
    FFONE: String;
    FCELULAR: String;
    FEMAIL: String;

    FNFECONFIGURACAO: TNfeConfiguracao;

    function getNfeConfiguracao: TNfeConfiguracao;

  protected

  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    class function find(id: string): TEmpresa;

    property TipoPessoa: String  read FTIPO_PESSOA write FTIPO_PESSOA;
    property Referencia: Integer  read FREFERENCIA write FREFERENCIA;
    property Nome: String  read FNOME write FNOME;
    property RazaoSocial: String  read FRAZAO_SOCIAL write FRAZAO_SOCIAL;
    property Documento: String  read FDOCUMENTO write FDOCUMENTO;
    property Ie: String  read FIE write FIE;
    property Iest: String  read FIEST write FIEST;
    property Im: String  read FIM write FIM;
    property Cnae: String  read FCNAE write FCNAE;
    property Crt: String  read FCRT write FCRT;
    property Cep: String  read FCEP write FCEP;
    property Logradouro: String  read FLOGRADOURO write FLOGRADOURO;
    property Numero: String  read FNUMERO write FNUMERO;
    property Complemento: String  read FCOMPLEMENTO write FCOMPLEMENTO;
    property Bairro: String  read FBAIRRO write FBAIRRO;
    property CodigoMunicipio: String  read FCODIGO_MUNICIPIO write FCODIGO_MUNICIPIO;
    property NomeMunicipio: String  read FNOME_MUNICIPIO write FNOME_MUNICIPIO;
    property Uf: String  read FUF write FUF;
    property Fone: String  read FFONE write FFONE;
    property Celular: String  read FCELULAR write FCELULAR;
    property Email: String  read FEMAIL write FEMAIL;

    property NfeConfiguracao: TNfeConfiguracao read getNfeConfiguracao;

  end;

implementation

{ TEmpresa }

constructor TEmpresa.Create;
begin
  Self.Table:= 'EMPRESAS';
end;

destructor TEmpresa.Destroy;
begin
  if Assigned(Self.FNFECONFIGURACAO) then FreeAndNil(Self.FNFECONFIGURACAO);

  inherited;
end;

class function TEmpresa.find(id: string): TEmpresa;
const
  FSql: string = 'SELECT * FROM EMPRESAS WHERE (ID = :ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ID').AsString:= id;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TEmpresa.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.TipoPessoa:= FDQuery.FieldByName('TIPO_PESSOA').AsString;
        Result.Referencia:= FDQuery.FieldByName('REFERENCIA').AsInteger;
        Result.Nome:= FDQuery.FieldByName('NOME').AsString;
        Result.RazaoSocial:= FDQuery.FieldByName('RAZAO_SOCIAL').AsString;
        Result.Documento:= FDQuery.FieldByName('DOCUMENTO').AsString;
        Result.Ie:= FDQuery.FieldByName('IE').AsString;
        Result.Iest:= FDQuery.FieldByName('IEST').AsString;
        Result.Im:= FDQuery.FieldByName('IM').AsString;
        Result.Cnae:= FDQuery.FieldByName('CNAE').AsString;
        Result.Crt:= FDQuery.FieldByName('CRT').AsString;
        Result.Cep:= FDQuery.FieldByName('CEP').AsString;
        Result.Logradouro:= FDQuery.FieldByName('LOGRADOURO').AsString;
        Result.Numero:= FDQuery.FieldByName('NUMERO').AsString;
        Result.Complemento:= FDQuery.FieldByName('COMPLEMENTO').AsString;
        Result.Bairro:= FDQuery.FieldByName('BAIRRO').AsString;
        Result.CodigoMunicipio:= FDQuery.FieldByName('CODIGO_MUNICIPIO').AsString;
        Result.NomeMunicipio:= FDQuery.FieldByName('NOME_MUNICIPIO').AsString;
        Result.Uf:= FDQuery.FieldByName('UF').AsString;
        Result.Fone:= FDQuery.FieldByName('FONE').AsString;
        Result.Celular:= FDQuery.FieldByName('CELULAR').AsString;
        Result.Email:= FDQuery.FieldByName('EMAIL').AsString;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TEmpresa.getNfeConfiguracao: TNfeConfiguracao;
const
  FSql: string =
  'SELECT FIRST 1 ID FROM NFE_CONFIGURACOES ' +
  'WHERE EMPRESA_ID = :EMPRESA_ID';
var
  FDQuery: TFDQuery;
begin
  if not Assigned(Self.FNFECONFIGURACAO) then
  begin
    try
      FDQuery:= Self.createQuery;
      try
        FDQuery.SQL.Add(FSql);
        FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
        FDQuery.Prepare();
        FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.Id;
        FDQuery.Open();
        if (FDQuery.RecordCount = 0) then Self.FNFECONFIGURACAO:= nil
        else Self.FNFECONFIGURACAO:= TNfeConfiguracao.find(FDQuery.FieldByName('ID').AsString);
      except
        Self.FNFECONFIGURACAO:= nil;
      end;
    finally
      FreeAndNil(FDQuery);
    end;
  end;
  Result:= Self.FNFECONFIGURACAO;
end;

function TEmpresa.save: Boolean;
const
  FSql: string =
  'UPDATE OR INSERT INTO EMPRESAS ( ' +
  '  ID,                            ' +
  '  TIPO_PESSOA,                   ' +
  '  REFERENCIA,                    ' +
  '  NOME,                          ' +
  '  RAZAO_SOCIAL,                  ' +
  '  DOCUMENTO,                     ' +
  '  IE,                            ' +
  '  IEST,                          ' +
  '  IM,                            ' +
  '  CNAE,                          ' +
  '  CRT,                           ' +
  '  CEP,                           ' +
  '  LOGRADOURO,                    ' +
  '  NUMERO,                        ' +
  '  COMPLEMENTO,                   ' +
  '  BAIRRO,                        ' +
  '  CODIGO_MUNICIPIO,              ' +
  '  NOME_MUNICIPIO,                ' +
  '  UF,                            ' +
  '  FONE,                          ' +
  '  CELULAR,                       ' +
  '  EMAIL)                         ' +
  'VALUES (                         ' +
  '  :ID,                           ' +
  '  :TIPO_PESSOA,                  ' +
  '  :REFERENCIA,                   ' +
  '  :NOME,                         ' +
  '  :RAZAO_SOCIAL,                 ' +
  '  :DOCUMENTO,                    ' +
  '  :IE,                           ' +
  '  :IEST,                         ' +
  '  :IM,                           ' +
  '  :CNAE,                         ' +
  '  :CRT,                          ' +
  '  :CEP,                          ' +
  '  :LOGRADOURO,                   ' +
  '  :NUMERO,                       ' +
  '  :COMPLEMENTO,                  ' +
  '  :BAIRRO,                       ' +
  '  :CODIGO_MUNICIPIO,             ' +
  '  :NOME_MUNICIPIO,               ' +
  '  :UF,                           ' +
  '  :FONE,                         ' +
  '  :CELULAR,                      ' +
  '  :EMAIL) MATCHING (ID)          ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('TIPO_PESSOA').DataType:= ftString;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NOME').DataType:= ftString;
      FDQuery.Params.ParamByName('RAZAO_SOCIAL').DataType:= ftString;
      FDQuery.Params.ParamByName('DOCUMENTO').DataType:= ftString;
      FDQuery.Params.ParamByName('IE').DataType:= ftString;
      FDQuery.Params.ParamByName('IEST').DataType:= ftString;
      FDQuery.Params.ParamByName('IM').DataType:= ftString;
      FDQuery.Params.ParamByName('CNAE').DataType:= ftString;
      FDQuery.Params.ParamByName('CRT').DataType:= ftString;
      FDQuery.Params.ParamByName('CEP').DataType:= ftString;
      FDQuery.Params.ParamByName('LOGRADOURO').DataType:= ftString;
      FDQuery.Params.ParamByName('NUMERO').DataType:= ftString;
      FDQuery.Params.ParamByName('COMPLEMENTO').DataType:= ftString;
      FDQuery.Params.ParamByName('BAIRRO').DataType:= ftString;
      FDQuery.Params.ParamByName('CODIGO_MUNICIPIO').DataType:= ftString;
      FDQuery.Params.ParamByName('NOME_MUNICIPIO').DataType:= ftString;
      FDQuery.Params.ParamByName('UF').DataType:= ftString;
      FDQuery.Params.ParamByName('FONE').DataType:= ftString;
      FDQuery.Params.ParamByName('CELULAR').DataType:= ftString;
      FDQuery.Params.ParamByName('EMAIL').DataType:= ftString;
      FDQuery.Prepare();

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.TipoPessoa <> EmptyStr) then
        FDQuery.Params.ParamByName('TIPO_PESSOA').AsString:= Self.TipoPessoa;
      if (Self.Referencia > 0) then
        FDQuery.Params.ParamByName('CODIGO_REFERENCIA').AsInteger:= Self.Referencia;
      if (Self.Nome <> EmptyStr) then
        FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      if (Self.RazaoSocial <> EmptyStr) then
        FDQuery.Params.ParamByName('RAZAO_SOCIAL').AsString:= Self.RazaoSocial;
      if (Self.Documento <> EmptyStr) then
        FDQuery.Params.ParamByName('DOCUMENTO').AsString:= Self.Documento;
      if (Self.Ie <> EmptyStr) then
        FDQuery.Params.ParamByName('IE').AsString:= Self.Ie;
      if (Self.Iest <> EmptyStr) then
        FDQuery.Params.ParamByName('IEST').AsString:= Self.Iest;
      if (Self.Im <> EmptyStr) then
        FDQuery.Params.ParamByName('IM').AsString:= Self.Im;
      if (Self.Cnae <> EmptyStr) then
        FDQuery.Params.ParamByName('CNAE').AsString:= Self.Cnae;
      if (Self.Crt <> EmptyStr) then
        FDQuery.Params.ParamByName('CRT').AsString:= Self.Crt;
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
      if (Self.NomeMunicipio <> EmptyStr) then
        FDQuery.Params.ParamByName('NOME_MUNICIPIO').AsString:= Self.NomeMunicipio;
      if (Self.Uf <> EmptyStr) then
        FDQuery.Params.ParamByName('UF').AsString:= Self.Uf;
      if (Self.Fone <> EmptyStr) then
        FDQuery.Params.ParamByName('FONE').AsString:= Self.Fone;
      if (Self.Celular <> EmptyStr) then
        FDQuery.Params.ParamByName('CELULAR').AsString:= Self.Celular;
      if (Self.Email <> EmptyStr) then
        FDQuery.Params.ParamByName('EMAIL').AsString:= Self.Email;
      FDQuery.ExecSQL();
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao inserir a empresa. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
