unit NfeInfadfisco;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TNfeInfadfisco = class(TModel)
  private
    FEMPRESA_ID: String;
    FNOME: String;
    FINFADFISCO: String;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    function delete(): Boolean;

    class function find(id: string): TNfeInfadfisco;
    class function list(search: string): TObjectList<TNfeInfadfisco>; overload;
    class procedure list(search: string; DataSet: TFDMemTable); overload;
    class function remove(id: string): Boolean;
    
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property Nome: String  read FNOME write FNOME;
    property Infadfisco: String  read FINFADFISCO write FINFADFISCO;

  end;

implementation

uses
  AuthService, Helper;

{ TNfeInfadfisco }

constructor TNfeInfadfisco.Create;
begin
  Self.Table:= 'NFE_INFADFISCO';
end;

function TNfeInfadfisco.delete: Boolean;
const
  FSql: string =
  'UPDATE NFE_INFADFISCO            ' +
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
        raise Exception.Create('falha ao remover info complementar ao fisco. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TNfeInfadfisco.find(id: string): TNfeInfadfisco;
const
  FSql: string = 'SELECT * FROM NFE_INFADFISCO WHERE (ID = :ID)';
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
        Result:= TNfeInfadfisco.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.Nome:= FDQuery.FieldByName('NOME').AsString;
        Result.Infadfisco:= FDQuery.FieldByName('INFADFISCO').AsString;
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

class procedure TNfeInfadfisco.list(search: string; DataSet: TFDMemTable);
var
  v_list: TObjectList<TNfeInfadfisco>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  v_list:= TNfeInfadfisco.list(search);
  if Assigned(v_list) then
  begin
    for I := 0 to Pred(v_list.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= v_list.Items[I].Id;
      DataSet.FieldByName('NOME').AsString:= v_list.Items[I].Nome;
      DataSet.FieldByName('INFADFISCO').AsString:= v_list.Items[I].Infadfisco;
      DataSet.Post;
    end;
    FreeAndNil(v_list);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TNfeInfadfisco.list(search: string): TObjectList<TNfeInfadfisco>;
const
  FSql: string =
  'SELECT I.ID FROM NFE_INFADFISCO I ' +
  'WHERE (I.EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (I.DELETED_AT IS NULL) ' +
  'AND (I.NOME LIKE :SEARCH OR I.INFADFISCO LIKE :SEARCH)';
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
        Result:= TObjectList<TNfeInfadfisco>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TNfeInfadfisco.find(FDQuery.FieldByName('ID').AsString));
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

class function TNfeInfadfisco.remove(id: string): Boolean;
var
  infadfisco: TNfeInfadfisco;
begin
  Result:= False;
  infadfisco:= TNfeInfadfisco.find(id);
  if not Assigned(infadfisco) then
  begin
    THelper.Mensagem('Info complementar ao fisco não encontrada. A info complementar ao fisco pode ter sido previamente excluída por outro usuário!');
    Exit();
  end;

  try
    if not THelper.Mensagem('Confirmar a exclusão desta info complementar ao fisco?', 1) then
      Exit();

    Result:= infadfisco.delete();
  finally
    FreeAndNil(infadfisco);
  end;
end;

function TNfeInfadfisco.save: Boolean;
begin
  Result:= inherited;
end;

function TNfeInfadfisco.store: Boolean;
const
  FSql: string =
  'INSERT INTO NFE_INFADFISCO (' +
  '  ID,                       ' +
  '  EMPRESA_ID,               ' +
  '  NOME,                     ' +
  '  INFADFISCO,               ' +
  '  CREATED_AT,               ' +
  '  UPDATED_AT)               ' +
  'VALUES (                    ' +
  '  :ID,                      ' +
  '  :EMPRESA_ID,              ' +
  '  :NOME,                    ' +
  '  :INFADFISCO,              ' +
  '  :CREATED_AT,              ' +
  '  :UPDATED_AT)              ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= TModel.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NOME').DataType:= ftWideString;
      FDQuery.Params.ParamByName('INFADFISCO').DataType:= ftMemo;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      FDQuery.Params.ParamByName('INFADFISCO').Value:= Self.Infadfisco;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('falha ao inserir info complementar ao fisco. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeInfadfisco.update: Boolean;
const
  FSql: string =
  'UPDATE NFE_INFADFISCO            ' +
  'SET NOME = :NOME,                ' +
  '    INFADFISCO = :INFADFISCO,    ' +
  '    UPDATED_AT = :UPDATED_AT,    ' +
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
      FDQuery.Params.ParamByName('NOME').DataType:= ftWideString;
      FDQuery.Params.ParamByName('INFADFISCO').DataType:= ftMemo;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      FDQuery.Params.ParamByName('INFADFISCO').Value:= Self.Infadfisco;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('falha ao atualizar info complementar ao fisco. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
