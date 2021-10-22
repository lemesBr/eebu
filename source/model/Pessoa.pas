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
    FOBSERVACAO: String;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    function delete(): Boolean;
    function validate(vtype: integer = 0): Boolean;
    class function find(id: string): TPessoa;
    class function findByDocumento(Documento: string): TPessoa;
    class function list(search: string): TObjectList<TPessoa>; overload;
    class procedure list(search: string; DataSet: TFDMemTable); overload;
    class function remove(id: string): Boolean;

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
    property Observacao: String  read FOBSERVACAO write FOBSERVACAO;

  end;

implementation

uses
  AuthService, Helper, uformPessoaCreateEdit;

{ TPessoa }

constructor TPessoa.Create;
begin
  Self.Table:= 'PESSOAS';
end;

function TPessoa.delete: Boolean;
const
  FSql: string =
  'UPDATE PESSOAS                   ' +
  'SET UPDATED_AT = :UPDATED_AT,    ' +
  '    DELETED_AT = :DELETED_AT,    ' +
  '    SYNCHRONIZED = :SYNCHRONIZED ' +
  'WHERE (ID = :ID)                 ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('DELETED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('DELETED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('falha ao remover a pessoa. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TPessoa.find(id: string): TPessoa;
const
  FSql: string = 'SELECT * FROM PESSOAS WHERE (ID = :ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ID').AsString:= id;
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
        Result.Observacao:= FDQuery.FieldByName('OBSERVACAO').AsString;
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

class function TPessoa.findByDocumento(Documento: string): TPessoa;
const
  FSql: string = 'SELECT ID FROM PESSOAS WHERE (DOCUMENTO = :DOCUMENTO)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('DOCUMENTO').DataType:= ftWideString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('DOCUMENTO').AsString:= Documento;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
        Result:= TPessoa.find(FDQuery.FieldByName('ID').AsString);
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class procedure TPessoa.list(search: string; DataSet: TFDMemTable);
var
  vList: TObjectList<TPessoa>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  vList:= TPessoa.list(search);
  if Assigned(vList) then
  begin
    for I := 0 to Pred(vList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= vList.Items[I].Id;
      DataSet.FieldByName('CODIGO').AsInteger:= vList.Items[I].Referencia;
      DataSet.FieldByName('NOME').AsString:= vList.Items[I].Nome;
      DataSet.FieldByName('EMAIL').AsString:= vList.Items[I].Email;
      if Length(vList.Items[I].Documento) > 11 then
        DataSet.FieldByName('DOCUMENTO').AsString:= THelper.CNPJMask(vList.Items[I].Documento)
      else
        DataSet.FieldByName('DOCUMENTO').AsString:= THelper.CPFMask(vList.Items[I].Documento);
      DataSet.FieldByName('FONE').AsString:= THelper.FONEMask(vList.Items[I].Fone);
      DataSet.Post;
    end;
    FreeAndNil(vList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TPessoa.remove(id: string): Boolean;
var
  Pessoa: TPessoa;
begin
  Result:= False;
  Pessoa:= TPessoa.find(id);
  if not Assigned(Pessoa) then
  begin
    THelper.Mensagem('Pessoa não encontrada. A pessoa pode ter sido previamente excluída por outro usuário!');
    Exit();
  end;

  try
    if not THelper.Mensagem('Confirmar a exclusão desta pessoa?', 1) then
      Exit();

    Result:= Pessoa.delete();
  finally
    FreeAndNil(Pessoa);
  end;
end;

class function TPessoa.list(search: string): TObjectList<TPessoa>;
const
  FSql: string =
  'SELECT P.ID FROM PESSOAS P ' +
  'WHERE (P.EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (DELETED_AT IS NULL) ' +
  'AND ((P.NOME LIKE :SEARCH) ' +
  'OR (P.DOCUMENTO LIKE :SEARCH)) ORDER BY P.NOME';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('SEARCH').DataType:= ftWideString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('SEARCH').AsString:= '%' + search + '%';
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TPessoa>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TPessoa.find(FDQuery.FieldByName('ID').AsString));
          FDQuery.Next;
        end;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TPessoa.save: Boolean;
begin
  Result:= inherited;
end;

function TPessoa.store: Boolean;
const
  FSql: string =
  'INSERT INTO PESSOAS (        ' +
  '  ID,                        ' +
  '  EMPRESA_ID,                ' +
  '  TIPO_PESSOA,               ' +
  '  REFERENCIA,                ' +
  '  NOME,                      ' +
  '  RAZAO_SOCIAL,              ' +
  '  DOCUMENTO,                 ' +
  '  IDESTRANGEIRO,             ' +
  '  IM,                        ' +
  '  ISUF,                      ' +
  '  SIMPLES,                   ' +
  '  INDIEDEST,                 ' +
  '  IE,                        ' +
  '  DATA_FUNDACAO_NASCIMENTO,  ' +
  '  CEP,                       ' +
  '  LOGRADOURO,                ' +
  '  NUMERO,                    ' +
  '  COMPLEMENTO,               ' +
  '  BAIRRO,                    ' +
  '  CODIGO_MUNICIPIO,          ' +
  '  NOME_MUNICIPIO,            ' +
  '  UF,                        ' +
  '  FONE,                      ' +
  '  CELULAR,                   ' +
  '  EMAIL,                     ' +
  '  OBSERVACAO,                ' +
  '  CREATED_AT,                ' +
  '  UPDATED_AT)                ' +
  'VALUES (                     ' +
  '  :ID,                       ' +
  '  :EMPRESA_ID,               ' +
  '  :TIPO_PESSOA,              ' +
  '  :REFERENCIA,               ' +
  '  :NOME,                     ' +
  '  :RAZAO_SOCIAL,             ' +
  '  :DOCUMENTO,                ' +
  '  :IDESTRANGEIRO,            ' +
  '  :IM,                       ' +
  '  :ISUF,                     ' +
  '  :SIMPLES,                  ' +
  '  :INDIEDEST,                ' +
  '  :IE,                       ' +
  '  :DATA_FUNDACAO_NASCIMENTO, ' +
  '  :CEP,                      ' +
  '  :LOGRADOURO,               ' +
  '  :NUMERO,                   ' +
  '  :COMPLEMENTO,              ' +
  '  :BAIRRO,                   ' +
  '  :CODIGO_MUNICIPIO,         ' +
  '  :NOME_MUNICIPIO,           ' +
  '  :UF,                       ' +
  '  :FONE,                     ' +
  '  :CELULAR,                  ' +
  '  :EMAIL,                    ' +
  '  :OBSERVACAO,               ' +
  '  :CREATED_AT,               ' +
  '  :UPDATED_AT)               ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('TIPO_PESSOA').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NOME').DataType:= ftWideString;
      FDQuery.Params.ParamByName('RAZAO_SOCIAL').DataType:= ftWideString;
      FDQuery.Params.ParamByName('DOCUMENTO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('IDESTRANGEIRO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('IM').DataType:= ftWideString;
      FDQuery.Params.ParamByName('ISUF').DataType:= ftWideString;
      FDQuery.Params.ParamByName('SIMPLES').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('INDIEDEST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('IE').DataType:= ftWideString;
      FDQuery.Params.ParamByName('DATA_FUNDACAO_NASCIMENTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('CEP').DataType:= ftWideString;
      FDQuery.Params.ParamByName('LOGRADOURO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('NUMERO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('COMPLEMENTO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('BAIRRO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CODIGO_MUNICIPIO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('NOME_MUNICIPIO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('UF').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('FONE').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CELULAR').DataType:= ftWideString;
      FDQuery.Params.ParamByName('EMAIL').DataType:= ftWideString;
      FDQuery.Params.ParamByName('OBSERVACAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;
      Self.Referencia:= Self.nextReferencia(Self.Referencia);

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
      if (Self.Observacao <> EmptyStr) then
        FDQuery.Params.ParamByName('OBSERVACAO').AsString:= Self.Observacao;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('falha ao inserir a pessoa. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TPessoa.update: Boolean;
const
  FSql: string =
  'UPDATE PESSOAS                                            ' +
  'SET TIPO_PESSOA = :TIPO_PESSOA,                           ' +
  '    REFERENCIA = :REFERENCIA,                             ' +
  '    NOME = :NOME,                                         ' +
  '    RAZAO_SOCIAL = :RAZAO_SOCIAL,                         ' +
  '    DOCUMENTO = :DOCUMENTO,                               ' +
  '    IDESTRANGEIRO = :IDESTRANGEIRO,                       ' +
  '    IM = :IM,                                             ' +
  '    ISUF = :ISUF,                                         ' +
  '    SIMPLES = :SIMPLES,                                   ' +
  '    INDIEDEST = :INDIEDEST,                               ' +
  '    IE = :IE,                                             ' +
  '    DATA_FUNDACAO_NASCIMENTO = :DATA_FUNDACAO_NASCIMENTO, ' +
  '    CEP = :CEP,                                           ' +
  '    LOGRADOURO = :LOGRADOURO,                             ' +
  '    NUMERO = :NUMERO,                                     ' +
  '    COMPLEMENTO = :COMPLEMENTO,                           ' +
  '    BAIRRO = :BAIRRO,                                     ' +
  '    CODIGO_MUNICIPIO = :CODIGO_MUNICIPIO,                 ' +
  '    NOME_MUNICIPIO = :NOME_MUNICIPIO,                     ' +
  '    UF = :UF,                                             ' +
  '    FONE = :FONE,                                         ' +
  '    CELULAR = :CELULAR,                                   ' +
  '    EMAIL = :EMAIL,                                       ' +
  '    OBSERVACAO = :OBSERVACAO,                             ' +
  '    UPDATED_AT = :UPDATED_AT,                             ' +
  '    SYNCHRONIZED = :SYNCHRONIZED                          ' +
  'WHERE (ID = :ID)                                          ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('TIPO_PESSOA').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NOME').DataType:= ftWideString;
      FDQuery.Params.ParamByName('RAZAO_SOCIAL').DataType:= ftWideString;
      FDQuery.Params.ParamByName('DOCUMENTO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('IDESTRANGEIRO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('IM').DataType:= ftWideString;
      FDQuery.Params.ParamByName('ISUF').DataType:= ftWideString;
      FDQuery.Params.ParamByName('SIMPLES').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('INDIEDEST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('IE').DataType:= ftWideString;
      FDQuery.Params.ParamByName('DATA_FUNDACAO_NASCIMENTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('CEP').DataType:= ftWideString;
      FDQuery.Params.ParamByName('LOGRADOURO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('NUMERO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('COMPLEMENTO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('BAIRRO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CODIGO_MUNICIPIO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('NOME_MUNICIPIO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('UF').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('FONE').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CELULAR').DataType:= ftWideString;
      FDQuery.Params.ParamByName('EMAIL').DataType:= ftWideString;
      FDQuery.Params.ParamByName('OBSERVACAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
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
      if (Self.Observacao <> EmptyStr) then
        FDQuery.Params.ParamByName('OBSERVACAO').AsString:= Self.Observacao;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('falha ao atualizar a pessoa. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TPessoa.validate(vtype: integer): Boolean;
var
  v_nfeValidate: Integer;
  v_form: TformPessoaCreateEdit;
  v_title: string;
  v_msg: string;
begin
  Result:= True;
  case vtype of
    0: begin
      try
        v_title:= 'OPSSS!' + #13;

        if (Self.TipoPessoa = 'F')
        and (Trim(Self.Documento) <> '')
        and (not THelper.ValidarCPF(Trim(Self.Documento))) then
        begin
          v_msg:= 'CPF informado é inválido.';
          Exit();
        end
        else if (Self.TipoPessoa = 'F')
        and (Trim(Self.Documento) <> '')
        and (not Self.unicValueInTable('DOCUMENTO',Trim(Self.Documento))) then
        begin
          v_msg:= 'Já existe um registro cadastrado com este CPF.';
          Exit();
        end;

        if (Self.TipoPessoa = 'J')
        and (Trim(Self.Documento) <> '')
        and (not THelper.ValidarCNPJ(Trim(Self.Documento))) then
        begin
          v_msg:= 'CNPJ informado é inválido.';
          Exit();
        end
        else if (Self.TipoPessoa = 'J')
        and (Trim(Self.Documento) <> '')
        and (not Self.unicValueInTable('DOCUMENTO',Trim(Self.Documento))) then
        begin
          v_msg:= 'Já existe um registro cadastrado com este CNPJ.';
          Exit();
        end;

        if (Trim(Self.Cep) <> '')
        and (Trim(Self.Cep).Length <= 7) then
        begin
          v_msg:= 'CEP informado é inválido.';
          Exit();
        end;
      finally
        if (v_msg <> '') then
        begin
          THelper.Mensagem(v_title + v_msg);
          Result:= False;
        end;
      end;
    end;
    1: begin
      v_nfeValidate:= 0;
      if (Trim(Self.Nome) = '') then Inc(v_nfeValidate);
      if (Self.TipoPessoa = 'J') and (Trim(Self.RazaoSocial) = '') then Inc(v_nfeValidate);
      if (Trim(Self.Documento) = '') then Inc(v_nfeValidate);
      if (Trim(Self.Cep) = '') then Inc(v_nfeValidate);
      if (Trim(Self.Logradouro) = '') then Inc(v_nfeValidate);
      if (Trim(Self.Numero) = '') then Inc(v_nfeValidate);
      if (Trim(Self.Bairro) = '') then Inc(v_nfeValidate);
      if (Trim(Self.NomeMunicipio) = '') then Inc(v_nfeValidate);
      if (Trim(Self.CodigoMunicipio) = '') then Inc(v_nfeValidate);
      if (Trim(Self.Uf) = '') then Inc(v_nfeValidate);
      if (v_nfeValidate >= 1) then
      begin
        try
          TAuthService.PessoaId:= Self.Id;
          v_form:= TformPessoaCreateEdit.Create(nil);
          v_form.Tag:= 1;
          v_form.ShowModal;
        finally
          FreeAndNil(v_form);
        end;
        Result:= (TAuthService.PessoaId <> EmptyStr);
      end;
    end;
    2: Result:= Self.unicValueInTable('DOCUMENTO', Self.Documento);
  end;
end;

end.
