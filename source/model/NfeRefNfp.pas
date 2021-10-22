unit NfeRefNfp;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TNfeRefNfp = class(TModel)
  private
    FEMPRESA_ID: String;
    FNFE_ID: String;
    FCUF: Integer;
    FAAMM: String;
    FCNPJCPF: String;
    FIE: String;
    FMODELO: String;
    FSERIE: Integer;
    FNNF: Integer;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function findByNfeId(NfeId: string): TObjectList<TNfeRefNfp>; overload;
    class procedure findByNfeId(NfeId: string; DataSet: TFDMemTable); overload;
    class function remove(Id: string): Boolean;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeId: String  read FNFE_ID write FNFE_ID;
    property Cuf: Integer  read FCUF write FCUF;
    property Aamm: String  read FAAMM write FAAMM;
    property Cnpjcpf: String  read FCNPJCPF write FCNPJCPF;
    property Ie: String  read FIE write FIE;
    property Modelo: String  read FMODELO write FMODELO;
    property Serie: Integer  read FSERIE write FSERIE;
    property Nnf: Integer  read FNNF write FNNF;

  end;

implementation

uses
  AuthService;

{ TNfeRefNfp }

constructor TNfeRefNfp.Create;
begin
  Self.Table:= 'NFE_REF_NFP';
end;

class function TNfeRefNfp.findByNfeId(NfeId: string): TObjectList<TNfeRefNfp>;
const
  FSql: string =
  'SELECT * FROM NFE_REF_NFP WHERE (NFE_ID = :NFE_ID)' +
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
        Result:= TObjectList<TNfeRefNfp>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TNfeRefNfp.Create);
          Result.Last.Id:= FDQuery.FieldByName('ID').AsString;
          Result.Last.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
          Result.Last.NfeId:= FDQuery.FieldByName('NFE_ID').AsString;
          Result.Last.Cuf:= FDQuery.FieldByName('CUF').AsInteger;
          Result.Last.Aamm:= FDQuery.FieldByName('AAMM').AsString;
          Result.Last.Cnpjcpf:= FDQuery.FieldByName('CNPJCPF').AsString;
          Result.Last.Ie:= FDQuery.FieldByName('IE').AsString;
          Result.Last.Modelo:= FDQuery.FieldByName('MODELO').AsString;
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

class procedure TNfeRefNfp.findByNfeId(NfeId: string; DataSet: TFDMemTable);
var
  v_list: TObjectList<TNfeRefNfp>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  v_list:= TNfeRefNfp.findByNfeId(NfeId);
  if Assigned(v_list) then
  begin
    for I := 0 to Pred(v_list.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= v_list.Items[I].Id;
      DataSet.FieldByName('CUF').AsInteger:= v_list.Items[I].Cuf;
      DataSet.FieldByName('AAMM').AsString:= v_list.Items[I].Aamm;
      DataSet.FieldByName('CNPJCPF').AsString:= v_list.Items[I].Cnpjcpf;
      DataSet.FieldByName('IE').AsString:= v_list.Items[I].Ie;
      DataSet.FieldByName('MODELO').AsString:= v_list.Items[I].Modelo;
      DataSet.FieldByName('SERIE').AsInteger:= v_list.Items[I].Serie;
      DataSet.FieldByName('NNF').AsInteger:= v_list.Items[I].Nnf;
      DataSet.Post;
    end;
    FreeAndNil(v_list);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TNfeRefNfp.remove(Id: string): Boolean;
const
  FSql: string = 'DELETE FROM NFE_REF_NFP WHERE ID = :ID';
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
        raise Exception.Create('falha ao tentar remover NFP referenciada. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeRefNfp.save: Boolean;
begin
  Result:= inherited;
end;

function TNfeRefNfp.store: Boolean;
const
  FSql: string =
  'INSERT INTO NFE_REF_NFP (' +
  '  ID,                    ' +
  '  EMPRESA_ID,            ' +
  '  NFE_ID,                ' +
  '  CUF,                   ' +
  '  AAMM,                  ' +
  '  CNPJCPF,               ' +
  '  IE,                    ' +
  '  MODELO,                ' +
  '  SERIE,                 ' +
  '  NNF,                   ' +
  '  CREATED_AT,            ' +
  '  UPDATED_AT)            ' +
  'VALUES (                 ' +
  '  :ID,                   ' +
  '  :EMPRESA_ID,           ' +
  '  :NFE_ID,               ' +
  '  :CUF,                  ' +
  '  :AAMM,                 ' +
  '  :CNPJCPF,              ' +
  '  :IE,                   ' +
  '  :MODELO,               ' +
  '  :SERIE,                ' +
  '  :NNF,                  ' +
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
      FDQuery.Params.ParamByName('CUF').DataType:= ftInteger;
      FDQuery.Params.ParamByName('AAMM').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CNPJCPF').DataType:= ftWideString;
      FDQuery.Params.ParamByName('IE').DataType:= ftWideString;
      FDQuery.Params.ParamByName('MODELO').DataType:= ftFixedWideChar;
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
      FDQuery.Params.ParamByName('CNPJCPF').AsString:= Self.Cnpjcpf;
      FDQuery.Params.ParamByName('IE').AsString:= Self.Ie;
      FDQuery.Params.ParamByName('MODELO').AsString:= Self.Modelo;
      FDQuery.Params.ParamByName('SERIE').AsInteger:= Self.Serie;
      FDQuery.Params.ParamByName('NNF').AsInteger:= Self.Nnf;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('falha ao inserir a NFP referenciada. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeRefNfp.update: Boolean;
begin
  Result:= True;
end;

end.
