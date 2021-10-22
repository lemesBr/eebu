unit NfeCobrDup;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TNfeCobrDup = class(TModel)
  private
    FEMPRESA_ID: String;
    FNFE_ID: String;
    FNDUP: String;
    FDVENC: TDateTime;
    FVDUP: Extended;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function findByNfeId(NfeId: string): TObjectList<TNfeCobrDup>; overload;
    class procedure findByNfeId(NfeId: string; DataSet: TFDMemTable); overload;
    class function removeByNfeId(NfeId: string): Boolean;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeId: String  read FNFE_ID write FNFE_ID;
    property Ndup: String  read FNDUP write FNDUP;
    property Dvenc: TDateTime  read FDVENC write FDVENC;
    property Vdup: Extended  read FVDUP write FVDUP;

  end;

implementation

uses
  AuthService;

{ TNfeCobrDup }

constructor TNfeCobrDup.Create;
begin
  Self.Table:= 'NFE_COBR_DUP';
end;

class function TNfeCobrDup.findByNfeId(NfeId: string): TObjectList<TNfeCobrDup>;
const
  FSql: string =
  'SELECT * FROM NFE_COBR_DUP WHERE (NFE_ID = :NFE_ID)' +
  ' AND (DELETED_AT IS NULL) ORDER BY NDUP';
var
  FDQuery: TFDQuery;
  Dup: TNfeCobrDup;
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
        Result:= TObjectList<TNfeCobrDup>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Dup:= TNfeCobrDup.Create;
          Dup.Id:= FDQuery.FieldByName('ID').AsString;
          Dup.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
          Dup.NfeId:= FDQuery.FieldByName('NFE_ID').AsString;
          Dup.Ndup:= FDQuery.FieldByName('NDUP').AsString;
          Dup.Dvenc:= FDQuery.FieldByName('DVENC').AsDateTime;
          Dup.Vdup:= FDQuery.FieldByName('VDUP').AsExtended;
          Dup.CreatedAt:= FDQuery.FieldByName('CREATED_AT').AsDateTime;
          Dup.UpdatedAt:= FDQuery.FieldByName('UPDATED_AT').AsDateTime;
          Dup.Synchronized:= FDQuery.FieldByName('SYNCHRONIZED').AsString;
          Result.Add(Dup);
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

class procedure TNfeCobrDup.findByNfeId(NfeId: string; DataSet: TFDMemTable);
var
  VList: TObjectList<TNfeCobrDup>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  VList:= TNfeCobrDup.findByNfeId(NfeId);
  if Assigned(VList) then
  begin
    for I := 0 to Pred(VList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= VList.Items[I].Id;
      DataSet.FieldByName('NDUP').AsString:= VList.Items[I].Ndup;
      DataSet.FieldByName('DVENC').AsDateTime:= VList.Items[I].Dvenc;
      DataSet.FieldByName('VDUP').AsExtended:= VList.Items[I].Vdup;
      DataSet.Post;
    end;
    FreeAndNil(VList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TNfeCobrDup.removeByNfeId(NfeId: string): Boolean;
const
  FSql: string = 'DELETE FROM NFE_COBR_DUP WHERE NFE_ID = :NFE_ID';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('NFE_ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('NFE_ID').AsString:= NfeId;
      FDQuery.ExecSQL;
    except on e: Exception do
      begin
        Result:= False;
        raise Exception.Create('DUPLICATA. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeCobrDup.save: Boolean;
begin
  Result:= inherited;
end;

function TNfeCobrDup.store: Boolean;
const
  FSql: string =
  'INSERT INTO NFE_COBR_DUP (' +
  '  ID,                     ' +
  '  EMPRESA_ID,             ' +
  '  NFE_ID,                 ' +
  '  NDUP,                   ' +
  '  DVENC,                  ' +
  '  VDUP,                   ' +
  '  CREATED_AT,             ' +
  '  UPDATED_AT)             ' +
  'VALUES (                  ' +
  '  :ID,                    ' +
  '  :EMPRESA_ID,            ' +
  '  :NFE_ID,                ' +
  '  :NDUP,                  ' +
  '  :DVENC,                 ' +
  '  :VDUP,                  ' +
  '  :CREATED_AT,            ' +
  '  :UPDATED_AT)            ';
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
      FDQuery.Params.ParamByName('NDUP').DataType:= ftWideString;
      FDQuery.Params.ParamByName('DVENC').DataType:= ftDate;
      FDQuery.Params.ParamByName('VDUP').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NFE_ID').AsString:= Self.NfeId;
      FDQuery.Params.ParamByName('NDUP').AsString:= Self.Ndup;
      FDQuery.Params.ParamByName('DVENC').AsDate:= Self.Dvenc;
      FDQuery.Params.ParamByName('VDUP').AsFMTBCD:= Self.Vdup;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: Exception do
      begin
        Result:= False;
        raise Exception.Create('DUPLICATA. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeCobrDup.update: Boolean;
const
  FSql: string =
  'UPDATE NFE_COBR_DUP              ' +
  'SET NDUP = :NDUP,                ' +
  '    DVENC = :DVENC,              ' +
  '    VDUP = :VDUP,                ' +
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
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NDUP').DataType:= ftWideString;
      FDQuery.Params.ParamByName('DVENC').DataType:= ftDate;
      FDQuery.Params.ParamByName('VDUP').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('NDUP').AsString:= Self.Ndup;
      FDQuery.Params.ParamByName('DVENC').AsDate:= Self.Dvenc;
      FDQuery.Params.ParamByName('VDUP').AsFMTBCD:= Self.Vdup;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('DUPLICATA. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
