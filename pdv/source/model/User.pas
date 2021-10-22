unit User;

interface

uses
  Model, Classes,  Generics.Collections, SysUtils, FireDAC.Comp.Client,
  Data.DB;

type
  TUser = class(TModel)
  private
    FEMPRESA_ID: String;
    FNOME: String;
    FSOBRENOME: String;
    FEMAIL: String;
    FSENHA: String;

  public 
    constructor Create();
    function save(): Boolean;

    class function login(senha: string): TUser;
    class function find(Id: string): TUser;
    class function all(): TObjectList<TUser>;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property Nome: String  read FNOME write FNOME;
    property Sobrenome: String  read FSOBRENOME write FSOBRENOME;
    property Email: String  read FEMAIL write FEMAIL;
    property Senha: String  read FSENHA write FSENHA;

  end;

implementation

uses
  AuthService;

{ TUser }

class function TUser.all: TObjectList<TUser>;
const
  FSql: string =
  'SELECT ID FROM USERS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TObjectList<TUser>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TUser.find(FDQuery.FieldByName('ID').AsString));
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

constructor TUser.Create;
begin
  Self.Table:= 'USERS';
end;

class function TUser.find(Id: string): TUser;
const
  FSql: string = 'SELECT * FROM USERS WHERE (ID = :ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('ID').AsString:= Id;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TUser.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.Nome:= FDQuery.FieldByName('NOME').AsString;
        Result.Sobrenome:= FDQuery.FieldByName('SOBRENOME').AsString;
        Result.Email:= FDQuery.FieldByName('EMAIL').AsString;
        Result.Senha:= FDQuery.FieldByName('SENHA').AsString;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TUser.login(senha: string): TUser;
const
  FSql: string =
  'SELECT ID FROM USERS WHERE (SENHA = :SENHA) ';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('SENHA').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('SENHA').AsString:= senha;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
        Result:= TUser.find(FDQuery.FieldByName('ID').AsString);
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TUser.save: Boolean;
const
  FSql: string =
  'UPDATE OR INSERT INTO USERS ( ' +
  '  ID,                         ' +
  '  EMPRESA_ID,                 ' +
  '  NOME,                       ' +
  '  SOBRENOME,                  ' +
  '  EMAIL,                      ' +
  '  SENHA)                      ' +
  'VALUES (                      ' +
  '  :ID,                        ' +
  '  :EMPRESA_ID,                ' +
  '  :NOME,                      ' +
  '  :SOBRENOME,                 ' +
  '  :EMAIL,                     ' +
  '  :SENHA) MATCHING (ID)       ';
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
      FDQuery.Params.ParamByName('NOME').DataType:= ftString;
      FDQuery.Params.ParamByName('SOBRENOME').DataType:= ftString;
      FDQuery.Params.ParamByName('EMAIL').DataType:= ftString;
      FDQuery.Params.ParamByName('SENHA').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      if (Self.Sobrenome <> EmptyStr) then
      FDQuery.Params.ParamByName('SOBRENOME').AsString:= Self.Sobrenome;
      FDQuery.Params.ParamByName('EMAIL').AsString:= Self.Email;
      FDQuery.Params.ParamByName('SENHA').AsString:= Self.Senha;
      FDQuery.ExecSQL();
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao gravar dados do user. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
