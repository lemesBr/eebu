unit NfeRefNf;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TNfeRefNf = class(TModel)
  private
    FEMPRESA_ID: String;
    FNFE_ID: String;
    FCUF: Integer;
    FAAMM: String;
    FCNPJ: String;
    FMODELO: Integer;
    FSERIE: Integer;
    FNNF: Integer;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function findByNfeId(NfeId: string): TObjectList<TNfeRefNf>; overload;
    class procedure findByNfeId(NfeId: string; DataSet: TFDMemTable); overload;
    class function remove(Id: string): Boolean;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeId: String  read FNFE_ID write FNFE_ID;
    property Cuf: Integer  read FCUF write FCUF;
    property Aamm: String  read FAAMM write FAAMM;
    property Cnpj: String  read FCNPJ write FCNPJ;
    property Modelo: Integer  read FMODELO write FMODELO;
    property Serie: Integer  read FSERIE write FSERIE;
    property Nnf: Integer  read FNNF write FNNF;


  end;

implementation

uses
  AuthService;

{ TNfeRefNf }

constructor TNfeRefNf.Create;
begin
  Self.Table:= 'NFE_REF_NF';
end;

class function TNfeRefNf.findByNfeId(NfeId: string): TObjectList<TNfeRefNf>;
const
  FSql: string =
  'SELECT * FROM NFE_REF_NF WHERE (NFE_ID = :NFE_ID)' +
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
        Result:= TObjectList<TNfeRefNf>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TNfeRefNf.Create);
          Result.Last.Id:= FDQuery.FieldByName('ID').AsString;
          Result.Last.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
          Result.Last.NfeId:= FDQuery.FieldByName('NFE_ID').AsString;
          Result.Last.Cuf:= FDQuery.FieldByName('CUF').AsInteger;
          Result.Last.Aamm:= FDQuery.FieldByName('AAMM').AsString;
          Result.Last.Cnpj:= FDQuery.FieldByName('CNPJ').AsString;
          Result.Last.Modelo:= FDQuery.FieldByName('MODELO').AsInteger;
          Result.Last.Serie:= FDQuery.FieldByName('SERIE').AsInteger;
          Result.Last.Nnf:= FDQuery.FieldByName('NNF').AsInteger;
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

class procedure TNfeRefNf.findByNfeId(NfeId: string; DataSet: TFDMemTable);
var
  v_list: TObjectList<TNfeRefNf>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  v_list:= TNfeRefNf.findByNfeId(NfeId);
  if Assigned(v_list) then
  begin
    for I := 0 to Pred(v_list.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= v_list.Items[I].Id;
      DataSet.FieldByName('CUF').AsInteger:= v_list.Items[I].Cuf;
      DataSet.FieldByName('AAMM').AsString:= v_list.Items[I].Aamm;
      DataSet.FieldByName('CNPJ').AsString:= v_list.Items[I].Cnpj;
      DataSet.FieldByName('MODELO').AsInteger:= v_list.Items[I].Modelo;
      DataSet.FieldByName('SERIE').AsInteger:= v_list.Items[I].Serie;
      DataSet.FieldByName('NNF').AsInteger:= v_list.Items[I].Nnf;
      DataSet.Post;
    end;
    FreeAndNil(v_list);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TNfeRefNf.remove(Id: string): Boolean;
const
  FSql: string = 'DELETE FROM NFE_REF_NF WHERE ID = :ID';
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
        raise Exception.Create('falha ao tentar remover NF referenciada. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeRefNf.save: Boolean;
begin
  Result:= inherited;
end;

function TNfeRefNf.store: Boolean;
const
  FSql: string =
  'INSERT INTO NFE_REF_NF (' +
  '  ID,                   ' +
  '  EMPRESA_ID,           ' +
  '  NFE_ID,               ' +
  '  CUF,                  ' +
  '  AAMM,                 ' +
  '  CNPJ,                 ' +
  '  MODELO,               ' +
  '  SERIE,                ' +
  '  NNF,                  ' +
  '  CREATED_AT,           ' +
  '  UPDATED_AT)           ' +
  'VALUES (                ' +
  '  :ID,                  ' +
  '  :EMPRESA_ID,          ' +
  '  :NFE_ID,              ' +
  '  :CUF,                 ' +
  '  :AAMM,                ' +
  '  :CNPJ,                ' +
  '  :MODELO,              ' +
  '  :SERIE,               ' +
  '  :NNF,                 ' +
  '  :CREATED_AT,          ' +
  '  :UPDATED_AT)          ';
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
      FDQuery.Params.ParamByName('CUF').DataType:= ftInteger;
      FDQuery.Params.ParamByName('AAMM').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CNPJ').DataType:= ftWideString;
      FDQuery.Params.ParamByName('MODELO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('SERIE').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NNF').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NFE_ID').AsString:= Self.NfeId;
      FDQuery.Params.ParamByName('CUF').AsInteger:= Self.Cuf;
      FDQuery.Params.ParamByName('AAMM').AsString:= Self.Aamm;
      FDQuery.Params.ParamByName('CNPJ').AsString:= Self.Cnpj;
      FDQuery.Params.ParamByName('MODELO').AsInteger:= Self.Modelo;
      FDQuery.Params.ParamByName('SERIE').AsInteger:= Self.Serie;
      FDQuery.Params.ParamByName('NNF').AsInteger:= Self.Nnf;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('falha ao inserir a NF referenciada. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeRefNf.update: Boolean;
begin
  Result:= True;
end;

end.
