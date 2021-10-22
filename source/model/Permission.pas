unit Permission;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TPermission = class(TModel)
  private
    FNOME: String;
    FPERMISSION: String;
    function getNome: String;
    function getPermission: String;
    procedure setNome(const Value: String);
    procedure setPermission(const Value: String);
  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    function delete(): Boolean;
    class function find(id: string): TPermission;
    class function list(search: string): TObjectList<TPermission>; overload;
    class function remove(id: string): Boolean;
    class procedure list(search: string; DataSet: TFDMemTable); overload;
    property Nome: String  read getNome write setNome;
    property Permission: String  read getPermission write setPermission;

  end;

implementation

{ TPermission }

uses Helper;

constructor TPermission.Create;
begin
  Self.Table:= 'PERMISSIONS';
end;

function TPermission.delete: Boolean;
const
  FSql: string =
  'UPDATE PERMISSIONS               ' +
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
        raise Exception.Create('falha ao remover o permissão. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TPermission.find(id: string): TPermission;
const
  FSql: string = 'SELECT * FROM PERMISSIONS WHERE (ID = :ID) AND DELETED_AT IS NULL';
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
        Result:= TPermission.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.Nome:= FDQuery.FieldByName('NOME').AsString;
        Result.Permission:= FDQuery.FieldByName('PERMISSION').AsString;
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

function TPermission.getNome: String;
begin
  Result:= THelper.RemoveAcentos(FNOME);
end;

function TPermission.getPermission: String;
begin
  Result:= THelper.RemoveAcentos(FPERMISSION);
end;

class procedure TPermission.list(search: string; DataSet: TFDMemTable);
var
  VList: TObjectList<TPermission>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  VList:= TPermission.list(search);
  if Assigned(VList) then
  begin
    for I := 0 to Pred(VList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= VList.Items[I].Id;
      DataSet.FieldByName('NOME').AsString:= VList.Items[I].Nome;
      DataSet.FieldByName('PERMISSION').AsString:= VList.Items[I].Permission;
      DataSet.Post;
    end;
    FreeAndNil(VList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TPermission.remove(id: string): Boolean;
var
  Permission: TPermission;
begin
  Result:= False;
  Permission:= TPermission.find(id);
  if not Assigned(Permission) then
  begin
    THelper.Mensagem('Permissão não encontrado. A permissão pode ter sido previamente excluído por outro usuário!');
    Exit();
  end;

  try
    if not THelper.Mensagem('Confirmar a exclusão desta permissão?', 1) then
      Exit();

    Result:= Permission.delete();
  finally
    FreeAndNil(Permission);
  end;
end;

class function TPermission.list(search: string): TObjectList<TPermission>;
const
  FSql: string =
  'SELECT * FROM PERMISSIONS WHERE ' +
  '(NOME LIKE :SEARCH) OR (PERMISSION LIKE :SEARCH)';
var
  FDQuery: TFDQuery;
  Permission: TPermission;
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
        Result:= TObjectList<TPermission>.Create;
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
          Result.Add(Permission);
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

function TPermission.save: Boolean;
begin
  Result:= inherited;
end;

procedure TPermission.setNome(const Value: String);
begin
  FNOME:= THelper.RemoveAcentos(Value);
end;

procedure TPermission.setPermission(const Value: String);
begin
  FPERMISSION:= THelper.RemoveAcentos(Value);
end;

function TPermission.store: Boolean;
const
  FSql: string =
  'INSERT INTO PERMISSIONS (ID,NOME,PERMISSION,CREATED_AT,UPDATED_AT) ' +
  'VALUES (:ID,:NOME,:PERMISSION,:CREATED_AT,:UPDATED_AT)';
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
      FDQuery.Params.ParamByName('PERMISSION').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      Self.Id:= Self.generateId;
      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.Nome <> EmptyStr) then
        FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      if (Self.Permission <> EmptyStr) then
        FDQuery.Params.ParamByName('PERMISSION').AsString:= Self.Permission;
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

function TPermission.update: Boolean;
const
  FSql: string =
  'UPDATE PERMISSIONS SET NOME = :NOME, PERMISSION = :PERMISSION,' +
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
      FDQuery.Params.ParamByName('PERMISSION').DataType:= ftWideString;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.Nome <> EmptyStr) then
        FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      if (Self.Permission <> EmptyStr) then
        FDQuery.Params.ParamByName('PERMISSION').AsString:= Self.Permission;
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
