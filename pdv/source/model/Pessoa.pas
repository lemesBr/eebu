unit Pessoa;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TPessoa = class(TModel)
  private
    FEMPRESA_ID: String;
    FTIPO_PESSOA: String;
    FREFERENCIA: Integer;
    FNOME: String;
    FRAZAO_SOCIAL: String;
    FDOCUMENTO: String;
    FIDESTRANGEIRO: String;
    FIM: String;
    FISUF: String;
    FSIMPLES: String;
    FINDIEDEST: String;
    FIE: String;
    FDATA_FUNDACAO_NASCIMENTO: TDateTime;
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

  public
    constructor Create();
    function save(): Boolean;

    class function find(Id: string): TPessoa;
    class function list(pSearch: string): TObjectList<TPessoa>; overload;
    class procedure list(pSearch: string; pDt: TFDMemTable); overload;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property TipoPessoa: String  read FTIPO_PESSOA write FTIPO_PESSOA;
    property Referencia: Integer  read FREFERENCIA write FREFERENCIA;
    property Nome: String  read FNOME write FNOME;
    property RazaoSocial: String  read FRAZAO_SOCIAL write FRAZAO_SOCIAL;
    property Documento: String  read FDOCUMENTO write FDOCUMENTO;
    property Idestrangeiro: String  read FIDESTRANGEIRO write FIDESTRANGEIRO;
    property Im: String  read FIM write FIM;
    property Isuf: String  read FISUF write FISUF;
    property Simples: String  read FSIMPLES write FSIMPLES;
    property Indiedest: String  read FINDIEDEST write FINDIEDEST;
    property Ie: String  read FIE write FIE;
    property DataFundacaoNascimento: TDateTime  read FDATA_FUNDACAO_NASCIMENTO write FDATA_FUNDACAO_NASCIMENTO;
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

  end;

implementation

uses
  AuthService, Helper;

{ TPessoa }

constructor TPessoa.Create;
begin
  Self.Table:= 'PESSOAS';
end;

class function TPessoa.find(Id: string): TPessoa;
const
  FSql: string = 'SELECT * FROM PESSOAS WHERE (ID = :ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ID').AsString:= Id;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TPessoa.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.TipoPessoa:= FDQuery.FieldByName('TIPO_PESSOA').AsString;
        Result.Referencia:= FDQuery.FieldByName('REFERENCIA').AsInteger;
        Result.Nome:= FDQuery.FieldByName('NOME').AsString;
        Result.RazaoSocial:= FDQuery.FieldByName('RAZAO_SOCIAL').AsString;
        Result.Documento:= FDQuery.FieldByName('DOCUMENTO').AsString;
        Result.Idestrangeiro:= FDQuery.FieldByName('IDESTRANGEIRO').AsString;
        Result.Im:= FDQuery.FieldByName('IM').AsString;
        Result.Isuf:= FDQuery.FieldByName('ISUF').AsString;
        Result.Simples:= FDQuery.FieldByName('SIMPLES').AsString;
        Result.Indiedest:= FDQuery.FieldByName('INDIEDEST').AsString;
        Result.Ie:= FDQuery.FieldByName('IE').AsString;
        Result.DataFundacaoNascimento:= FDQuery.FieldByName('DATA_FUNDACAO_NASCIMENTO').AsDateTime;
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

class function TPessoa.list(pSearch: string): TObjectList<TPessoa>;
const
  FSql: string =
  'SELECT ID FROM PESSOAS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND ((NOME LIKE :SEARCH) ' +
  'OR (DOCUMENTO LIKE :SEARCH)) ORDER BY NOME';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('SEARCH').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Params.ParamByName('SEARCH').AsString:= '%' + pSearch + '%';
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TObjectList<TPessoa>.Create;
        FDQuery.First();
        while not FDQuery.Eof do
        begin
          Result.Add(TPessoa.find(FDQuery.FieldByName('ID').AsString));
          FDQuery.Next();
        end;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class procedure TPessoa.list(pSearch: string; pDt: TFDMemTable);
var
  vList: TObjectList<TPessoa>;
  I: Integer;
begin
  pDt.Open();
  pDt.DisableControls();
  pDt.EmptyDataSet();
  vList:= TPessoa.list(pSearch);
  if Assigned(vList) then
  begin
    for I := 0 to Pred(vList.Count) do
    begin
      pDt.Append();
      pDt.FieldByName('ID').AsString:= vList.Items[I].Id;
      pDt.FieldByName('REFERENCIA').AsInteger:= vList.Items[I].Referencia;
      pDt.FieldByName('NOME').AsString:= vList.Items[I].Nome;
      pDt.FieldByName('EMAIL').AsString:= vList.Items[I].Email;
      if Length(vList.Items[I].Documento) > 11 then
        pDt.FieldByName('DOCUMENTO').AsString:= THelper.CNPJMask(vList.Items[I].Documento)
      else
        pDt.FieldByName('DOCUMENTO').AsString:= THelper.CPFMask(vList.Items[I].Documento);
      pDt.FieldByName('FONE').AsString:= THelper.FONEMask(vList.Items[I].Fone);
      pDt.Post();
    end;
    FreeAndNil(vList);
  end;
  pDt.First();
  pDt.EnableControls();
end;

function TPessoa.save: Boolean;
const
  FSql: string =
  'UPDATE OR INSERT INTO PESSOAS ( ' +
  '  ID,                           ' +
  '  EMPRESA_ID,                   ' +
  '  TIPO_PESSOA,                  ' +
  '  REFERENCIA,                   ' +
  '  NOME,                         ' +
  '  RAZAO_SOCIAL,                 ' +
  '  DOCUMENTO,                    ' +
  '  IDESTRANGEIRO,                ' +
  '  IM,                           ' +
  '  ISUF,                         ' +
  '  SIMPLES,                      ' +
  '  INDIEDEST,                    ' +
  '  IE,                           ' +
  '  DATA_FUNDACAO_NASCIMENTO,     ' +
  '  CEP,                          ' +
  '  LOGRADOURO,                   ' +
  '  NUMERO,                       ' +
  '  COMPLEMENTO,                  ' +
  '  BAIRRO,                       ' +
  '  CODIGO_MUNICIPIO,             ' +
  '  NOME_MUNICIPIO,               ' +
  '  UF,                           ' +
  '  FONE,                         ' +
  '  CELULAR,                      ' +
  '  EMAIL)                        ' +
  'VALUES (                        ' +
  '  :ID,                          ' +
  '  :EMPRESA_ID,                  ' +
  '  :TIPO_PESSOA,                 ' +
  '  :REFERENCIA,                  ' +
  '  :NOME,                        ' +
  '  :RAZAO_SOCIAL,                ' +
  '  :DOCUMENTO,                   ' +
  '  :IDESTRANGEIRO,               ' +
  '  :IM,                          ' +
  '  :ISUF,                        ' +
  '  :SIMPLES,                     ' +
  '  :INDIEDEST,                   ' +
  '  :IE,                          ' +
  '  :DATA_FUNDACAO_NASCIMENTO,    ' +
  '  :CEP,                         ' +
  '  :LOGRADOURO,                  ' +
  '  :NUMERO,                      ' +
  '  :COMPLEMENTO,                 ' +
  '  :BAIRRO,                      ' +
  '  :CODIGO_MUNICIPIO,            ' +
  '  :NOME_MUNICIPIO,              ' +
  '  :UF,                          ' +
  '  :FONE,                        ' +
  '  :CELULAR,                     ' +
  '  :EMAIL) MATCHING (ID)         ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('TIPO_PESSOA').DataType:= ftString;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NOME').DataType:= ftString;
      FDQuery.Params.ParamByName('RAZAO_SOCIAL').DataType:= ftString;
      FDQuery.Params.ParamByName('DOCUMENTO').DataType:= ftString;
      FDQuery.Params.ParamByName('IDESTRANGEIRO').DataType:= ftString;
      FDQuery.Params.ParamByName('IM').DataType:= ftString;
      FDQuery.Params.ParamByName('ISUF').DataType:= ftString;
      FDQuery.Params.ParamByName('SIMPLES').DataType:= ftString;
      FDQuery.Params.ParamByName('INDIEDEST').DataType:= ftString;
      FDQuery.Params.ParamByName('IE').DataType:= ftString;
      FDQuery.Params.ParamByName('DATA_FUNDACAO_NASCIMENTO').DataType:= ftDate;
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
      if (Self.EmpresaId <> EmptyStr) then
        FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      if (Self.TipoPessoa <> EmptyStr) then
        FDQuery.Params.ParamByName('TIPO_PESSOA').AsString:= Self.TipoPessoa;
      if (Self.Referencia > 0) then
        FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= Self.Referencia;
      if (Self.Nome <> EmptyStr) then
        FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      if (Self.RazaoSocial <> EmptyStr) then
        FDQuery.Params.ParamByName('RAZAO_SOCIAL').AsString:= Self.RazaoSocial;
      if (Self.Documento <> EmptyStr) then
        FDQuery.Params.ParamByName('DOCUMENTO').AsString:= Self.Documento;
      if (Self.Idestrangeiro <> EmptyStr) then
        FDQuery.Params.ParamByName('IDESTRANGEIRO').AsString:= Self.Idestrangeiro;
      if (Self.Im <> EmptyStr) then
        FDQuery.Params.ParamByName('IM').AsString:= Self.Im;
      if (Self.Isuf <> EmptyStr) then
        FDQuery.Params.ParamByName('ISUF').AsString:= Self.Isuf;
      if (Self.Simples <> EmptyStr) then
        FDQuery.Params.ParamByName('SIMPLES').AsString:= Self.Simples;
      if (Self.Indiedest <> EmptyStr) then
        FDQuery.Params.ParamByName('INDIEDEST').AsString:= Self.Indiedest;
      if (Self.Ie <> EmptyStr) then
        FDQuery.Params.ParamByName('IE').AsString:= Self.Ie;
      if (Self.DataFundacaoNascimento > 0) then
        FDQuery.Params.ParamByName('DATA_FUNDACAO_NASCIMENTO').AsDate:= Self.DataFundacaoNascimento;
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
        raise Exception.Create('Falha ao gravar dados da pessoa. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
