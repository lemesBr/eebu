unit NfeRefNfe;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TNfeRefNfe = class(TModel)
  private
    FEMPRESA_ID: String;
    FNFE_ID: String;
    FCHNFE: String;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function findByNfeId(NfeId: string): TObjectList<TNfeRefNfe>; overload;
    class procedure findByNfeId(NfeId: string; DataSet: TFDMemTable); overload;
    class function remove(Id: string): Boolean;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeId: String  read FNFE_ID write FNFE_ID;
    property Chnfe: String  read FCHNFE write FCHNFE;

  end;

implementation

uses
  AuthService;

{ TNfeRefNfe }

constructor TNfeRefNfe.Create;
begin
  Self.Table:= 'NFE_REF_NFE';
end;

class function TNfeRefNfe.findByNfeId(NfeId: string): TObjectList<TNfeRefNfe>;
const
  FSql: string =
  'SELECT * FROM NFE_REF_NFE WHERE (NFE_ID = :NFE_ID)' +
  ' AND (DELETED_AT IS NULL)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('NFE_ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('NFE_ID').AsString:= NfeId;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TNfeRefNfe>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TNfeRefNfe.Create);
          Result.Last.Id:= FDQuery.FieldByName('ID').AsString;
          Result.Last.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
          Result.Last.NfeId:= FDQuery.FieldByName('NFE_ID').AsString;
          Result.Last.Chnfe:= FDQuery.FieldByName('CHNFE').AsString;
          Result.Last.CreatedAt:= FDQuery.FieldByName('CREATED_AT').AsDateTime;
          Result.Last.UpdatedAt:= FDQuery.FieldByName('UPDATED_AT').AsDateTime;
          Result.Last.Synchronized:= FDQuery.FieldByName('SYNCHRONIZED').AsString;
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

class procedure TNfeRefNfe.findByNfeId(NfeId: string; DataSet: TFDMemTable);
var
  v_list: TObjectList<TNfeRefNfe>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  v_list:= TNfeRefNfe.findByNfeId(NfeId);
  if Assigned(v_list) then
  begin
    for I := 0 to Pred(v_list.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= v_list.Items[I].Id;
      DataSet.FieldByName('CHNFE').AsString:= v_list.Items[I].Chnfe;
      DataSet.Post;
    end;
    FreeAndNil(v_list);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TNfeRefNfe.remove(Id: string): Boolean;
const
  FSql: string = 'DELETE FROM NFE_REF_NFE WHERE ID = :ID';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ID').AsString:= Id;
      FDQuery.ExecSQL;
    except on e: Exception do
      begin
        Result:= False;
        raise Exception.Create('falha ao tentar remover NFE referenciada. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeRefNfe.save: Boolean;
begin
  Result:= inherited;
end;

function TNfeRefNfe.store: Boolean;
const
  FSql: string =
  'INSERT INTO NFE_REF_NFE (' +
  '  ID,                    ' +
  '  EMPRESA_ID,            ' +
  '  NFE_ID,                ' +
  '  CHNFE,                 ' +
  '  CREATED_AT,            ' +
  '  UPDATED_AT)            ' +
  'VALUES (                 ' +
  '  :ID,                   ' +
  '  :EMPRESA_ID,           ' +
  '  :NFE_ID,               ' +
  '  :CHNFE,                ' +
  '  :CREATED_AT,           ' +
  '  :UPDATED_AT)           ';
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
      FDQuery.Params.ParamByName('NFE_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CHNFE').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NFE_ID').AsString:= Self.NfeId;
      FDQuery.Params.ParamByName('CHNFE').AsString:= Self.Chnfe;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('falha ao inserir a NFE referenciada. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeRefNfe.update: Boolean;
begin
  Result:= True;
end;

end.
