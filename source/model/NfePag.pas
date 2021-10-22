unit NfePag;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TNfePag = class(TModel)
  private
    FEMPRESA_ID: String;
    FNFE_ID: String;
    FTPAG: String;
    FVPAG: Extended;
    FTPINTEGRA: String;
    FCNPJ: String;
    FTBAND: String;
    FCAUT: String;
    FVTROCO: Extended;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function findByNfeId(NfeId: string): TObjectList<TNfePag>; overload;
    class procedure findByNfeId(NfeId: string; DataSet: TFDMemTable); overload;
    class function removeByNfeId(NfeId: string): Boolean;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeId: String  read FNFE_ID write FNFE_ID;
    property Tpag: String  read FTPAG write FTPAG;
    property Vpag: Extended  read FVPAG write FVPAG;
    property Tpintegra: String  read FTPINTEGRA write FTPINTEGRA;
    property Cnpj: String  read FCNPJ write FCNPJ;
    property Tband: String  read FTBAND write FTBAND;
    property Caut: String  read FCAUT write FCAUT;
    property Vtroco: Extended  read FVTROCO write FVTROCO;

  end;

implementation

uses
  AuthService;

{ TNfePag }

constructor TNfePag.Create;
begin
  Self.Table:= 'NFE_PAG';
end;

class function TNfePag.findByNfeId(NfeId: string): TObjectList<TNfePag>;
const
  FSql: string =
  'SELECT * FROM NFE_PAG WHERE (NFE_ID = :NFE_ID)' +
  ' AND (DELETED_AT IS NULL) ORDER BY TPAG';
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
        Result:= TObjectList<TNfePag>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TNfePag.Create);
          Result.Last.Id:= FDQuery.FieldByName('ID').AsString;
          Result.Last.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
          Result.Last.NfeId:= FDQuery.FieldByName('NFE_ID').AsString;
          Result.Last.Tpag:= FDQuery.FieldByName('TPAG').AsString;
          Result.Last.Vpag:= FDQuery.FieldByName('VPAG').AsExtended;
          Result.Last.Tpintegra:= FDQuery.FieldByName('TPINTEGRA').AsString;
          Result.Last.Cnpj:= FDQuery.FieldByName('CNPJ').AsString;
          Result.Last.Tband:= FDQuery.FieldByName('TBAND').AsString;
          Result.Last.Caut:= FDQuery.FieldByName('CAUT').AsString;
          Result.Last.Vtroco:= FDQuery.FieldByName('VTROCO').AsExtended;
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

class procedure TNfePag.findByNfeId(NfeId: string; DataSet: TFDMemTable);
var
  v_list: TObjectList<TNfePag>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  v_list:= TNfePag.findByNfeId(NfeId);
  if Assigned(v_list) then
  begin
    for I := 0 to Pred(v_list.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= v_list.Items[I].Id;
      DataSet.FieldByName('TPAG').AsString:= v_list.Items[I].Tpag;
      DataSet.FieldByName('VPAG').AsExtended:= v_list.Items[I].Vpag;
      DataSet.FieldByName('TPINTEGRA').AsString:= v_list.Items[I].Tpintegra;
      DataSet.FieldByName('CNPJ').AsString:= v_list.Items[I].Cnpj;
      DataSet.FieldByName('TBAND').AsString:= v_list.Items[I].Tband;
      DataSet.FieldByName('CAUT').AsString:= v_list.Items[I].Caut;
      DataSet.FieldByName('VTROCO').AsExtended:= v_list.Items[I].Vtroco;
      DataSet.Post;
    end;
    FreeAndNil(v_list);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TNfePag.removeByNfeId(NfeId: string): Boolean;
const
  FSql: string = 'DELETE FROM NFE_PAG WHERE NFE_ID = :NFE_ID';
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
        raise Exception.Create('PAGAMENTO. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfePag.save: Boolean;
begin
  Result:= inherited;
end;

function TNfePag.store: Boolean;
const
  FSql: string =
  'INSERT INTO NFE_PAG (' +
  '  ID,                ' +
  '  EMPRESA_ID,        ' +
  '  NFE_ID,            ' +
  '  TPAG,              ' +
  '  VPAG,              ' +
  '  TPINTEGRA,         ' +
  '  CNPJ,              ' +
  '  TBAND,             ' +
  '  CAUT,              ' +
  '  VTROCO,            ' +
  '  CREATED_AT,        ' +
  '  UPDATED_AT)        ' +
  'VALUES (             ' +
  '  :ID,               ' +
  '  :EMPRESA_ID,       ' +
  '  :NFE_ID,           ' +
  '  :TPAG,             ' +
  '  :VPAG,             ' +
  '  :TPINTEGRA,        ' +
  '  :CNPJ,             ' +
  '  :TBAND,            ' +
  '  :CAUT,             ' +
  '  :VTROCO,           ' +
  '  :CREATED_AT,       ' +
  '  :UPDATED_AT)       ';
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
      FDQuery.Params.ParamByName('TPAG').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('VPAG').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('TPINTEGRA').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CNPJ').DataType:= ftWideString;
      FDQuery.Params.ParamByName('TBAND').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CAUT').DataType:= ftWideString;
      FDQuery.Params.ParamByName('VTROCO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NFE_ID').AsString:= Self.NfeId;
      FDQuery.Params.ParamByName('TPAG').AsString:= Self.Tpag;
      FDQuery.Params.ParamByName('VPAG').AsFMTBCD:= Self.Vpag;
      FDQuery.Params.ParamByName('TPINTEGRA').AsString:= Self.Tpintegra;
      if (Self.Cnpj <> EmptyStr) then
      FDQuery.Params.ParamByName('CNPJ').AsString:= Self.Cnpj;
      if (Self.Tband <> EmptyStr) then
      FDQuery.Params.ParamByName('TBAND').AsString:= Self.Tband;
      if (Self.Caut <> EmptyStr) then
      FDQuery.Params.ParamByName('CAUT').AsString:= Self.Caut;
      FDQuery.Params.ParamByName('VTROCO').AsFMTBCD:= Self.Vtroco;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: Exception do
      begin
        Result:= False;
        raise Exception.Create('PAGAMENTO. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfePag.update: Boolean;
const
  FSql: string =
  'UPDATE NFE_PAG                   ' +
  'SET TPAG = :TPAG,                ' +
  '    VPAG = :VPAG,                ' +
  '    TPINTEGRA = :TPINTEGRA,      ' +
  '    CNPJ = :CNPJ,                ' +
  '    TBAND = :TBAND,              ' +
  '    CAUT = :CAUT,                ' +
  '    VTROCO = :VTROCO,            ' +
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
      FDQuery.Params.ParamByName('TPAG').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('VPAG').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('TPINTEGRA').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CNPJ').DataType:= ftWideString;
      FDQuery.Params.ParamByName('TBAND').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CAUT').DataType:= ftWideString;
      FDQuery.Params.ParamByName('VTROCO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('TPAG').AsString:= Self.Tpag;
      FDQuery.Params.ParamByName('VPAG').AsFMTBCD:= Self.Vpag;
      FDQuery.Params.ParamByName('TPINTEGRA').AsString:= Self.Tpintegra;
      if (Self.Cnpj <> EmptyStr) then
      FDQuery.Params.ParamByName('CNPJ').AsString:= Self.Cnpj;
      if (Self.Tband <> EmptyStr) then
      FDQuery.Params.ParamByName('TBAND').AsString:= Self.Tband;
      if (Self.Caut <> EmptyStr) then
      FDQuery.Params.ParamByName('CAUT').AsString:= Self.Caut;
      FDQuery.Params.ParamByName('VTROCO').AsFMTBCD:= Self.Vtroco;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('PAGAMENTO. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
