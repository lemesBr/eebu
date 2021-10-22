unit Role;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  Permission;

type
  TRole = class(TModel)
  private
    FNOME: String;
    function getNome: String;
    procedure setNome(const Value: String);
  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    function delete(): Boolean;
    function removePermission(PermissionId: string): Boolean;
    function includePermission(PermissionId: string): Boolean;
    procedure listPermissions(search: string; DataSet: TFDMemTable);
    class function find(id: string): TRole;
    class function list(search: string): TObjectList<TRole>; overload;
    class function remove(id: string): Boolean;
    class procedure list(search: string; DataSet: TFDMemTable); overload;
    property Nome: String  read getNome write setNome;

  end;

implementation

{ TRole }

uses Helper;

constructor TRole.Create;
begin
  Self.Table:= 'ROLES';
end;

function TRole.delete: Boolean;
const
  FSql: string =
  'UPDATE ROLES                   ' +
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
        raise Exception.Create('falha ao remover o papéu. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TRole.find(id: string): TRole;
const
  FSql: string = 'SELECT * FROM ROLES WHERE (ID = :ID) AND DELETED_AT IS NULL';
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
        Result:= TRole.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.Nome:= FDQuery.FieldByName('NOME').AsString;
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

function TRole.getNome: String;
begin
  Result:= THelper.RemoveAcentos(FNOME);
end;

function TRole.includePermission(PermissionId: string): Boolean;
const
  FSql: string =
  'INSERT INTO ROLE_PERMISSIONS (ROLE_ID,PERMISSION_ID) ' +
  'VALUES (:ROLE_ID,:PERMISSION_ID)';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  Self.removePermission(PermissionId);
  try
    FDQuery:= TModel.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ROLE_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PERMISSION_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('ROLE_ID').AsString:= id;
      FDQuery.Params.ParamByName('PERMISSION_ID').AsString:= PermissionId;
      FDQuery.ExecSQL;
    except
      Result:= False;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class procedure TRole.list(search: string; DataSet: TFDMemTable);
var
  VList: TObjectList<TRole>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  VList:= TRole.list(search);
  if Assigned(VList) then
  begin
    for I := 0 to Pred(VList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= VList.Items[I].Id;
      DataSet.FieldByName('NOME').AsString:= VList.Items[I].Nome;
      DataSet.Post;
    end;
    FreeAndNil(VList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

procedure TRole.listPermissions(search: string; DataSet: TFDMemTable);
const
  FSql: string =
  'SELECT P.* FROM PERMISSIONS P ' +
  'JOIN ROLE_PERMISSIONS RP ON(RP.PERMISSION_ID = P.ID) ' +
  'WHERE (RP.ROLE_ID = :ROLE_ID) AND ((P.NOME LIKE :SEARCH) ' +
  'OR (P.PERMISSION LIKE :SEARCH))';
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
    FDQuery.Params.ParamByName('ROLE_ID').DataType:= ftFixedWideChar;
    FDQuery.Params.ParamByName('ROLE_ID').AsString:= Self.Id;
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

class function TRole.remove(id: string): Boolean;
var
  Role: TRole;
begin
  Result:= False;
  Role:= TRole.find(id);
  if not Assigned(Role) then
  begin
    THelper.Mensagem('Papéu não encontrado. O papéu pode ter sido previamente excluído por outro usuário!');
    Exit();
  end;

  try
    if not THelper.Mensagem('Confirmar a exclusão deste papéu?', 1) then
      Exit();

    Result:= Role.delete();
  finally
    FreeAndNil(Role);
  end;
end;

function TRole.removePermission(PermissionId: string): Boolean;
const
  FSql: string =
  'DELETE FROM ROLE_PERMISSIONS WHERE ' +
  '(ROLE_ID = :ROLE_ID) AND (PERMISSION_ID = :PERMISSION_ID)';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= TModel.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ROLE_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PERMISSION_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('ROLE_ID').AsString:= id;
      FDQuery.Params.ParamByName('PERMISSION_ID').AsString:= PermissionId;
      FDQuery.ExecSQL;
    except
      Result:= False;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TRole.list(search: string): TObjectList<TRole>;
const
  FSql: string =
  'SELECT * FROM ROLES WHERE ' +
  '(NOME LIKE :SEARCH) '+
  'AND (DELETED_AT IS NULL)';
var
  FDQuery: TFDQuery;
  Role: TRole;
begin
  try
    FDQuery:= TModel.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('SEARCH').AsString:= '%' + search + '%';
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TRole>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Role:= TRole.Create;
          Role.Id:= FDQuery.FieldByName('ID').AsString;;
          Role.Nome:= FDQuery.FieldByName('NOME').AsString;
          Role.CreatedAt:= FDQuery.FieldByName('CREATED_AT').AsDateTime;
          Role.UpdatedAt:= FDQuery.FieldByName('UPDATED_AT').AsDateTime;
          Role.Synchronized:= FDQuery.FieldByName('SYNCHRONIZED').AsString;
          Result.Add(Role);
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

function TRole.save: Boolean;
begin
  Result:= inherited;
end;

procedure TRole.setNome(const Value: String);
begin
  FNOME:= THelper.RemoveAcentos(Value);
end;

function TRole.store: Boolean;
const
  FSql: string =
  'INSERT INTO ROLES (ID,NOME,CREATED_AT,UPDATED_AT) ' +
  'VALUES (:ID,:NOME,:CREATED_AT,:UPDATED_AT)';
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
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      Self.Id:= Self.generateId;
      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.Nome <> EmptyStr) then
        FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
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

function TRole.update: Boolean;
const
  FSql: string =
  'UPDATE ROLES SET NOME = :NOME,' +
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
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.Nome <> EmptyStr) then
        FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
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

end.
