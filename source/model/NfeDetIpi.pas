unit NfeDetIpi;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TNfeDetIpi = class(TModel)
  private
    FEMPRESA_ID: String;
    FNFE_DET_ID: String;
    FCLENQ: String;
    FCNPJPROD: String;
    FCSELO: String;
    FQSELO: Integer;
    FCENQ: String;
    FCST: String;
    FVBC: Extended;
    FQUNID: Extended;
    FVUNID: Extended;
    FPIPI: Extended;
    FVIPI: Extended;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function findByNfeDetId(NfeDetId: string): TNfeDetIpi;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeDetId: String  read FNFE_DET_ID write FNFE_DET_ID;
    property Clenq: String  read FCLENQ write FCLENQ;
    property Cnpjprod: String  read FCNPJPROD write FCNPJPROD;
    property Cselo: String  read FCSELO write FCSELO;
    property Qselo: Integer  read FQSELO write FQSELO;
    property Cenq: String  read FCENQ write FCENQ;
    property Cst: String  read FCST write FCST;
    property Vbc: Extended  read FVBC write FVBC;
    property Qunid: Extended  read FQUNID write FQUNID;
    property Vunid: Extended  read FVUNID write FVUNID;
    property Pipi: Extended  read FPIPI write FPIPI;
    property Vipi: Extended  read FVIPI write FVIPI;

  end;

implementation

uses
  AuthService;

{ TNfeDetIpi }

constructor TNfeDetIpi.Create;
begin
  Self.Table:= 'NFE_DET_IPI';
end;

class function TNfeDetIpi.findByNfeDetId(NfeDetId: string): TNfeDetIpi;
const
  FSql: string =
  'SELECT * FROM NFE_DET_IPI WHERE (NFE_DET_ID = :NFE_DET_ID)' +
  ' AND (DELETED_AT IS NULL)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('NFE_DET_ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('NFE_DET_ID').AsString:= NfeDetId;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TNfeDetIpi.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.NfeDetId:= FDQuery.FieldByName('NFE_DET_ID').AsString;
        Result.Clenq:= FDQuery.FieldByName('CLENQ').AsString;
        Result.Cnpjprod:= FDQuery.FieldByName('CNPJPROD').AsString;
        Result.Cselo:= FDQuery.FieldByName('CSELO').AsString;
        Result.Qselo:= FDQuery.FieldByName('QSELO').AsInteger;
        Result.Cenq:= FDQuery.FieldByName('CENQ').AsString;
        Result.Cst:= FDQuery.FieldByName('CST').AsString;
        Result.Vbc:= FDQuery.FieldByName('VBC').AsExtended;
        Result.Qunid:= FDQuery.FieldByName('QUNID').AsExtended;
        Result.Vunid:= FDQuery.FieldByName('VUNID').AsExtended;
        Result.Pipi:= FDQuery.FieldByName('PIPI').AsExtended;
        Result.Vipi:= FDQuery.FieldByName('VIPI').AsExtended;
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

function TNfeDetIpi.save: Boolean;
begin
  Result:= inherited;
end;

function TNfeDetIpi.store: Boolean;
const
  FSql: string =
  'INSERT INTO NFE_DET_IPI (' +
  '  ID,                    ' +
  '  EMPRESA_ID,            ' +
  '  NFE_DET_ID,            ' +
  '  CLENQ,                 ' +
  '  CNPJPROD,              ' +
  '  CSELO,                 ' +
  '  QSELO,                 ' +
  '  CENQ,                  ' +
  '  CST,                   ' +
  '  VBC,                   ' +
  '  QUNID,                 ' +
  '  VUNID,                 ' +
  '  PIPI,                  ' +
  '  VIPI,                  ' +
  '  CREATED_AT,            ' +
  '  UPDATED_AT)            ' +
  'VALUES (                 ' +
  '  :ID,                   ' +
  '  :EMPRESA_ID,           ' +
  '  :NFE_DET_ID,           ' +
  '  :CLENQ,                ' +
  '  :CNPJPROD,             ' +
  '  :CSELO,                ' +
  '  :QSELO,                ' +
  '  :CENQ,                 ' +
  '  :CST,                  ' +
  '  :VBC,                  ' +
  '  :QUNID,                ' +
  '  :VUNID,                ' +
  '  :PIPI,                 ' +
  '  :VIPI,                 ' +
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
      FDQuery.Params.ParamByName('NFE_DET_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CLENQ').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CNPJPROD').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CSELO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('QSELO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CENQ').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('VBC').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('QUNID').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VUNID').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PIPI').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VIPI').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NFE_DET_ID').AsString:= Self.NfeDetId;
      if (Self.Clenq <> EmptyStr) then
      FDQuery.Params.ParamByName('CLENQ').AsString:= Self.Clenq;
      if (Self.Cnpjprod <> EmptyStr) then
      FDQuery.Params.ParamByName('CNPJPROD').AsString:= Self.Cnpjprod;
      if (Self.Cselo <> EmptyStr) then
      FDQuery.Params.ParamByName('CSELO').AsString:= Self.Cselo;
      if (Self.Qselo > 0) then
      FDQuery.Params.ParamByName('QSELO').AsInteger:= Self.Qselo;
      if (Self.Cenq <> EmptyStr) then
      FDQuery.Params.ParamByName('CENQ').AsString:= Self.Cenq;
      if (Self.Cst <> EmptyStr) then
      FDQuery.Params.ParamByName('CST').AsString:= Self.Cst;
      FDQuery.Params.ParamByName('VBC').AsFMTBCD:= Self.Vbc;
      FDQuery.Params.ParamByName('QUNID').AsFMTBCD:= Self.Qunid;
      FDQuery.Params.ParamByName('VUNID').AsFMTBCD:= Self.Vunid;
      FDQuery.Params.ParamByName('PIPI').AsFMTBCD:= Self.Pipi;
      FDQuery.Params.ParamByName('VIPI').AsFMTBCD:= Self.Vipi;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('IPI erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeDetIpi.update: Boolean;
const
  FSql: string =
  'UPDATE NFE_DET_IPI               ' +
  'SET CLENQ = :CLENQ,              ' +
  '    CNPJPROD = :CNPJPROD,        ' +
  '    CSELO = :CSELO,              ' +
  '    QSELO = :QSELO,              ' +
  '    CENQ = :CENQ,                ' +
  '    CST = :CST,                  ' +
  '    VBC = :VBC,                  ' +
  '    QUNID = :QUNID,              ' +
  '    VUNID = :VUNID,              ' +
  '    PIPI = :PIPI,                ' +
  '    VIPI = :VIPI,                ' +
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
      FDQuery.Params.ParamByName('CLENQ').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CNPJPROD').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CSELO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('QSELO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CENQ').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('VBC').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('QUNID').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VUNID').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PIPI').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VIPI').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.Clenq <> EmptyStr) then
      FDQuery.Params.ParamByName('CLENQ').AsString:= Self.Clenq;
      if (Self.Cnpjprod <> EmptyStr) then
      FDQuery.Params.ParamByName('CNPJPROD').AsString:= Self.Cnpjprod;
      if (Self.Cselo <> EmptyStr) then
      FDQuery.Params.ParamByName('CSELO').AsString:= Self.Cselo;
      if (Self.Qselo > 0) then
      FDQuery.Params.ParamByName('QSELO').AsInteger:= Self.Qselo;
      if (Self.Cenq <> EmptyStr) then
      FDQuery.Params.ParamByName('CENQ').AsString:= Self.Cenq;
      if (Self.Cst <> EmptyStr) then
      FDQuery.Params.ParamByName('CST').AsString:= Self.Cst;
      FDQuery.Params.ParamByName('VBC').AsFMTBCD:= Self.Vbc;
      FDQuery.Params.ParamByName('QUNID').AsFMTBCD:= Self.Qunid;
      FDQuery.Params.ParamByName('VUNID').AsFMTBCD:= Self.Vunid;
      FDQuery.Params.ParamByName('PIPI').AsFMTBCD:= Self.Pipi;
      FDQuery.Params.ParamByName('VIPI').AsFMTBCD:= Self.Vipi;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('IPI erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
