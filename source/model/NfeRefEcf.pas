unit NfeRefEcf;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TNfeRefEcf = class(TModel)
  private
    FEMPRESA_ID: String;
    FNFE_ID: String;
    FMODELO: String;
    FNECF: String;
    FNCOO: String;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function findByNfeId(NfeId: string): TObjectList<TNfeRefEcf>; overload;
    class procedure findByNfeId(NfeId: string; DataSet: TFDMemTable); overload;
    class function remove(Id: string): Boolean;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeId: String  read FNFE_ID write FNFE_ID;
    property Modelo: String  read FMODELO write FMODELO;
    property Necf: String  read FNECF write FNECF;
    property Ncoo: String  read FNCOO write FNCOO;

  end;

implementation

uses
  AuthService;

{ TNfeRefEcf }

constructor TNfeRefEcf.Create;
begin
  Self.Table:= 'NFE_REF_ECF';
end;

class function TNfeRefEcf.findByNfeId(NfeId: string): TObjectList<TNfeRefEcf>;
const
  FSql: string =
  'SELECT * FROM NFE_REF_ECF WHERE (NFE_ID = :NFE_ID)' +
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
        Result:= TObjectList<TNfeRefEcf>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TNfeRefEcf.Create);
          Result.Last.Id:= FDQuery.FieldByName('ID').AsString;
          Result.Last.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
          Result.Last.NfeId:= FDQuery.FieldByName('NFE_ID').AsString;
          Result.Last.Modelo:= FDQuery.FieldByName('MODELO').AsString;
          Result.Last.Necf:= FDQuery.FieldByName('NECF').AsString;
          Result.Last.Ncoo:= FDQuery.FieldByName('NCOO').AsString;
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

class procedure TNfeRefEcf.findByNfeId(NfeId: string; DataSet: TFDMemTable);
var
  v_list: TObjectList<TNfeRefEcf>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  v_list:= TNfeRefEcf.findByNfeId(NfeId);
  if Assigned(v_list) then
  begin
    for I := 0 to Pred(v_list.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= v_list.Items[I].Id;
      DataSet.FieldByName('MODELO').AsString:= v_list.Items[I].Modelo;
      DataSet.FieldByName('NECF').AsString:= v_list.Items[I].Necf;
      DataSet.FieldByName('NCOO').AsString:= v_list.Items[I].Ncoo;
      DataSet.Post;
    end;
    FreeAndNil(v_list);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TNfeRefEcf.remove(Id: string): Boolean;
const
  FSql: string = 'DELETE FROM NFE_REF_ECF WHERE ID = :ID';
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
        raise Exception.Create('falha ao tentar remover ECF referenciada. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeRefEcf.save: Boolean;
begin
  Result:= inherited;
end;

function TNfeRefEcf.store: Boolean;
const
  FSql: string =
  'INSERT INTO NFE_REF_ECF (' +
  '  ID,                    ' +
  '  EMPRESA_ID,            ' +
  '  NFE_ID,                ' +
  '  MODELO,                ' +
  '  NECF,                  ' +
  '  NCOO,                  ' +
  '  CREATED_AT,            ' +
  '  UPDATED_AT)            ' +
  'VALUES (                 ' +
  '  :ID,                   ' +
  '  :EMPRESA_ID,           ' +
  '  :NFE_ID,               ' +
  '  :MODELO,               ' +
  '  :NECF,                 ' +
  '  :NCOO,                 ' +
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
      FDQuery.Params.ParamByName('MODELO').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NECF').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NCOO').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NFE_ID').AsString:= Self.NfeId;
      FDQuery.Params.ParamByName('MODELO').AsString:= Self.Modelo;
      FDQuery.Params.ParamByName('NECF').AsString:= Self.Necf;
      FDQuery.Params.ParamByName('NCOO').AsString:= Self.Ncoo;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('falha ao inserir a ECF referenciada. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeRefEcf.update: Boolean;
begin
  Result:= True;
end;

end.
