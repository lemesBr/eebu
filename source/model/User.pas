unit User;

interface

uses
  Model, Generics.Collections, SysUtils, FireDAC.Comp.Client, Vcl.Dialogs,
  Data.DB, Empresa, Permission;

type
  TUser = class(TModel)
  private
    FEMPRESA_ID: String;
    FNOME: String;
    FEMAIL: String;
    FSENHA: String;
    FREMEMBER_TOKEN: String;
    FEMPRESA: TEmpresa;
    FPERMISSIONS: TObjectList<TPermission>;
    function getEmpresa: TEmpresa;
    function getPermissions: TObjectList<TPermission>;
    function getNome: String;
    procedure setNome(const Value: String);
    function getEmail: String;
    procedure setEmail(const Value: String);
  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    procedure setPermission(const Value: TPermission);
    function save(): Boolean;
    function delete(): Boolean;
    function validate(): Boolean;
    function removeRole(RoleId: string): Boolean;
    function includeRole(RoleId: string): Boolean;
    procedure listRoles(search: string; DataSet: TFDMemTable);
    class function login(pSenha: string): TUser;
    class function find(pId: string): TUser;
    class function list(search: string): TObjectList<TUser>; overload;
    class function list(): TObjectList<TUser>; overload;
    class function remove(id: string): Boolean;
    class procedure list(search: string; DataSet: TFDMemTable); overload;
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property Nome: String  read getNome write setNome;
    property Email: String  read getEmail write setEmail;
    property Senha: String  read FSENHA write FSENHA;
    property RememberToken: String  read FREMEMBER_TOKEN write FREMEMBER_TOKEN;
    property Empresa: TEmpresa read getEmpresa;
    property Permissions: TObjectList<TPermission> read getPermissions;

  end;

implementation

uses
  AuthService, Helper;

{ TUser }

constructor TUser.Create;
begin
  Self.Table:= 'USERS';
end;

function TUser.delete: Boolean;
const
  FSql: string =
  'UPDATE USERS                   ' +
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
        raise Exception.Create('falha ao remover o usuário. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

destructor TUser.Destroy;
begin
  if Assigned(Self.FEMPRESA) then FreeAndNil(Self.FEMPRESA);
  if Assigned(Self.FPERMISSIONS) then FreeAndNil(Self.FPERMISSIONS);
end;

class function TUser.find(pId: string): TUser;
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
      FDQuery.Params.ParamByName('ID').AsString:= pId;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TUser.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.Nome:= FDQuery.FieldByName('NOME').AsString;
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

function TUser.getEmail: String;
begin
  Result:= THelper.RemoveAcentos(FEMAIL);
end;

function TUser.getEmpresa: TEmpresa;
begin
  if not Assigned(Self.FEMPRESA) then
    Self.FEMPRESA:= TEmpresa.find(Self.EmpresaId);
  Result:= Self.FEMPRESA;
end;

function TUser.getNome: String;
begin
  Result:= THelper.RemoveAcentos(FNOME);
end;

function TUser.getPermissions: TObjectList<TPermission>;
const
  FSql: string =
  'SELECT DISTINCT P.* FROM PERMISSIONS P ' +
  'JOIN ROLE_PERMISSIONS RP ON(RP.PERMISSION_ID = P.ID) ' +
  'JOIN USER_ROLES UR ON(UR.ROLE_ID = RP.ROLE_ID) ' +
  'WHERE UR.USER_ID = :USER_ID';
var
  FDQuery: TFDQuery;
  Permission: TPermission;
begin
  if not Assigned(FPERMISSIONS) then
  begin
    FPERMISSIONS:= TObjectList<TPermission>.Create;
    try
      FDQuery:= TModel.createQuery;
      try
        FDQuery.SQL.Add(FSql);
        FDQuery.Prepare;
        FDQuery.Params.ParamByName('USER_ID').DataType:= ftFixedWideChar;
        FDQuery.Params.ParamByName('USER_ID').AsString:= Self.Id;
        FDQuery.Open();
        if FDQuery.RecordCount >= 1 then
        begin
          FDQuery.First;
          while not FDQuery.Eof do
          begin
            Permission:= TPermission.Create;
            Permission.Id:= FDQuery.FieldByName('ID').AsString;;
            Permission.Nome:= FDQuery.FieldByName('NOME').AsString;
            Permission.Permission:= FDQuery.FieldByName('PERMISSION').AsString;
            Permission.CreatedAt:= FDQuery.FieldByName('CREATED_AT').AsDateTime;
            Permission.UpdatedAt:= FDQuery.FieldByName('UPDATED_AT').AsDateTime;
            Permission.Synchronized:= FDQuery.FieldByName('SYNCHRONIZED').AsString;
            FPERMISSIONS.Add(Permission);
            FDQuery.Next;
          end;
        end;
      except
         FPERMISSIONS:= nil;
      end;
    finally
      FreeAndNil(FDQuery);
    end;
  end;
  Result:= FPERMISSIONS;
end;

function TUser.includeRole(RoleId: string): Boolean;
const
  FSql: string =
  'INSERT INTO USER_ROLES (USER_ID, ROLE_ID) ' +
  'VALUES (:USER_ID, :ROLE_ID)';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  Self.removeRole(RoleId);
  try
    FDQuery:= TModel.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('USER_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('ROLE_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('USER_ID').AsString:= id;
      FDQuery.Params.ParamByName('ROLE_ID').AsString:= RoleId;
      FDQuery.ExecSQL;
    except
      Result:= False;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TUser.list(search: string): TObjectList<TUser>;
const
  FSql: string =
  'SELECT U.* FROM USERS U ' +
  'JOIN USER_EMPRESAS UE ON(U.ID = UE.USER_ID) ' +
  'WHERE (UE.EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (U.DELETED_AT IS NULL) ' +
  'AND ((U.NOME LIKE :SEARCH) OR (U.EMAIL LIKE :SEARCH))';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= TModel.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('SEARCH').AsString:= '%' + search + '%';
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TUser>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TUser.find(FDQuery.FieldByName('ID').AsString));
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

class procedure TUser.list(search: string; DataSet: TFDMemTable);
var
  VList: TObjectList<TUser>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  VList:= TUser.list(search);
  if Assigned(VList) then
  begin
    for I := 0 to Pred(VList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= VList.Items[I].Id;
      DataSet.FieldByName('NOME').AsString:= VList.Items[I].Nome;
      DataSet.FieldByName('EMAIL').AsString:= VList.Items[I].Email;
      DataSet.Post;
    end;
    FreeAndNil(VList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TUser.list: TObjectList<TUser>;
const
  FSql: string =
  'SELECT ID FROM USERS ' +
  'WHERE (DELETED_AT IS NULL) ORDER BY EMAIL';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TObjectList<TUser>.Create;
        FDQuery.First();
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

procedure TUser.listRoles(search: string; DataSet: TFDMemTable);
const
  FSql: string =
  'SELECT R.* FROM ROLES R ' +
  'JOIN USER_ROLES UR ON(UR.ROLE_ID = R.ID) ' +
  'WHERE (UR.USER_ID = :USER_ID) AND (R.NOME LIKE :SEARCH)';
var
  FDQuery: TFDQuery;
begin
  try
    DataSet.Open();
    DataSet.DisableControls;
    DataSet.EmptyDataSet;

    FDQuery:= TModel.createQuery;
    FDQuery.SQL.Add(FSql);
    FDQuery.Prepare;
    FDQuery.Params.ParamByName('USER_ID').DataType:= ftFixedWideChar;
    FDQuery.Params.ParamByName('USER_ID').AsString:= Self.Id;
    FDQuery.Params.ParamByName('SEARCH').AsString:= '%' + search + '%';
    FDQuery.Open();
    if FDQuery.RecordCount >= 1 then
    begin
      FDQuery.First;
      while not FDQuery.Eof do
      begin
        DataSet.Append;
        DataSet.FieldByName('ID').AsString:= FDQuery.FieldByName('ID').AsString;
        DataSet.FieldByName('NOME').AsString:= FDQuery.FieldByName('NOME').AsString;
        DataSet.Post;
        FDQuery.Next;
      end;
    end;

    DataSet.First;
    DataSet.EnableControls;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TUser.login(pSenha: string): TUser;
const
  FSql: string = 'SELECT ID FROM USERS WHERE (SENHA = :SENHA) AND (DELETED_AT IS NULL)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('SENHA').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('SENHA').AsString:= pSenha;
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

class function TUser.remove(id: string): Boolean;
var
  User: TUser;
begin
  Result:= False;
  User:= TUser.find(id);
  if not Assigned(User) then
  begin
    THelper.Mensagem('Usuário não encontrado. O usuário pode ter sido previamente excluído por outro usuário!');
    Exit();
  end;

  try
    if not THelper.Mensagem('Confirmar a exclusão deste usuário?', 1) then
      Exit();

    Result:= User.delete();
  finally
    FreeAndNil(User);
  end;
end;

function TUser.removeRole(RoleId: string): Boolean;
const
  FSql: string =
  'DELETE FROM USER_ROLES WHERE ' +
  '(USER_ID = :USER_ID) AND (ROLE_ID = :ROLE_ID)';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= TModel.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('USER_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('ROLE_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('USER_ID').AsString:= id;
      FDQuery.Params.ParamByName('ROLE_ID').AsString:= RoleId;
      FDQuery.ExecSQL;
    except
      Result:= False;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TUser.save: Boolean;
begin
  Result:= inherited;
end;

procedure TUser.setEmail(const Value: String);
begin
  FEMAIL:= THelper.RemoveAcentos(Value);
end;

procedure TUser.setNome(const Value: String);
begin
  FNOME:= THelper.RemoveAcentos(Value);
end;

procedure TUser.setPermission(const Value: TPermission);
begin
  if not Assigned(FPERMISSIONS) then FPERMISSIONS:= TObjectList<TPermission>.Create;
  FPERMISSIONS.Add(Value);
end;

function TUser.store: Boolean;
const
  FSql: string =
  'INSERT INTO USERS ( ' +
  '  ID,               ' +
  '  EMPRESA_ID,       ' +
  '  NOME,             ' +
  '  EMAIL,            ' +
  '  SENHA,            ' +
  '  CREATED_AT,       ' +
  '  UPDATED_AT)       ' +
  'VALUES (            ' +
  '  :ID,              ' +
  '  :EMPRESA_ID,      ' +
  '  :NOME,            ' +
  '  :EMAIL,           ' +
  '  :SENHA,           ' +
  '  :CREATED_AT,      ' +
  '  :UPDATED_AT)      ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    Self.StartTransaction();
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('NOME').DataType:= ftString;
      FDQuery.Params.ParamByName('EMAIL').DataType:= ftString;
      FDQuery.Params.ParamByName('SENHA').DataType:= ftString;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare();

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;
      Self.Senha:= THelper.MD5String(Self.Email + Self.Senha);

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.EmpresaId <> EmptyStr) then
        FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      FDQuery.Params.ParamByName('EMAIL').AsString:= Self.Email;
      FDQuery.Params.ParamByName('SENHA').AsString:= Self.Senha;
      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.ExecSQL();

      if (Self.EmpresaId <> EmptyStr) then
      begin
        FDQuery.SQL.Clear();
        FDQuery.SQL.Add('INSERT INTO USER_EMPRESAS (USER_ID, EMPRESA_ID)VALUES (:USER_ID, :EMPRESA_ID)');
        FDQuery.Params.ParamByName('USER_ID').DataType:= ftString;
        FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
        FDQuery.Prepare();
        FDQuery.Params.ParamByName('USER_ID').AsString:= Self.Id;
        FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
        FDQuery.ExecSQL();
      end;

      Self.Commit();
    except on e: Exception do
      begin
        Self.Rollback();
        Result:= False;
        raise Exception.Create('Falha ao gravar dados do usuário. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TUser.update: Boolean;
const
  FSql: string =
  'UPDATE USERS                     ' +
  'SET EMPRESA_ID = :EMPRESA_ID,    ' +
  '    NOME = :NOME,                ' +
  '    UPDATED_AT = :UPDATED_AT,    ' +
  '    SYNCHRONIZED = :SYNCHRONIZED ' +
  'WHERE (ID = :ID);                ';
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
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftString;
      FDQuery.Prepare();

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL();
    except on e: Exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao gravar dados do usuário. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TUser.validate: Boolean;
var
  vMensagem: string;
  vTitle: string;
begin
  Result:= True;
  try
    vTitle:= 'OPSSS!' + #13;

    if not unicValueInTable('EMAIL', Self.Email) then
    begin
      vMensagem:= 'Email já encontra-se cadastrado.';
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
