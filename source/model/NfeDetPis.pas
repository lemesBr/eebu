unit NfeDetPis;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TNfeDetPis = class(TModel)
  private
    FEMPRESA_ID: String;
    FNFE_DET_ID: String;
    FCST: String;
    FVBC: Extended;
    FPPIS: Extended;
    FQBCPROD: Extended;
    FVALIQPROD: Extended;
    FVPIS: Extended;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function findByNfeDetId(NfeDetId: string): TNfeDetPis;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeDetId: String  read FNFE_DET_ID write FNFE_DET_ID;
    property Cst: String  read FCST write FCST;
    property Vbc: Extended  read FVBC write FVBC;
    property Ppis: Extended  read FPPIS write FPPIS;
    property Qbcprod: Extended  read FQBCPROD write FQBCPROD;
    property Valiqprod: Extended  read FVALIQPROD write FVALIQPROD;
    property Vpis: Extended  read FVPIS write FVPIS;

  end;

implementation

uses
  AuthService;

{ TNfeDetPis }

constructor TNfeDetPis.Create;
begin
  Self.Table:= 'NFE_DET_PIS';
end;

class function TNfeDetPis.findByNfeDetId(NfeDetId: string): TNfeDetPis;
const
  FSql: string =
  'SELECT * FROM NFE_DET_PIS WHERE (NFE_DET_ID = :NFE_DET_ID)' +
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
        Result:= TNfeDetPis.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.NfeDetId:= FDQuery.FieldByName('NFE_DET_ID').AsString;
        Result.Cst:= FDQuery.FieldByName('CST').AsString;
        Result.Vbc:= FDQuery.FieldByName('VBC').AsExtended;
        Result.Ppis:= FDQuery.FieldByName('PPIS').AsExtended;
        Result.Qbcprod:= FDQuery.FieldByName('QBCPROD').AsExtended;
        Result.Valiqprod:= FDQuery.FieldByName('VALIQPROD').AsExtended;
        Result.Vpis:= FDQuery.FieldByName('VPIS').AsExtended;
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

function TNfeDetPis.save: Boolean;
begin
  Result:= inherited;
end;

function TNfeDetPis.store: Boolean;
const
  FSql: string =
  'INSERT INTO NFE_DET_PIS (' +
  '  ID,                    ' +
  '  EMPRESA_ID,            ' +
  '  NFE_DET_ID,            ' +
  '  CST,                   ' +
  '  VBC,                   ' +
  '  PPIS,                  ' +
  '  QBCPROD,               ' +
  '  VALIQPROD,             ' +
  '  VPIS,                  ' +
  '  CREATED_AT,            ' +
  '  UPDATED_AT)            ' +
  'VALUES (                 ' +
  '  :ID,                   ' +
  '  :EMPRESA_ID,           ' +
  '  :NFE_DET_ID,           ' +
  '  :CST,                  ' +
  '  :VBC,                  ' +
  '  :PPIS,                 ' +
  '  :QBCPROD,              ' +
  '  :VALIQPROD,            ' +
  '  :VPIS,                 ' +
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
      FDQuery.Params.ParamByName('CST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('VBC').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PPIS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('QBCPROD').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALIQPROD').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VPIS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NFE_DET_ID').AsString:= Self.NfeDetId;
      if (Self.Cst <> EmptyStr) then
      FDQuery.Params.ParamByName('CST').AsString:= Self.Cst;
      FDQuery.Params.ParamByName('VBC').AsFMTBCD:= Self.Vbc;
      FDQuery.Params.ParamByName('PPIS').AsFMTBCD:= Self.Ppis;
      FDQuery.Params.ParamByName('QBCPROD').AsFMTBCD:= Self.Qbcprod;
      FDQuery.Params.ParamByName('VALIQPROD').AsFMTBCD:= Self.Valiqprod;
      FDQuery.Params.ParamByName('VPIS').AsFMTBCD:= Self.Vpis;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('PIS erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeDetPis.update: Boolean;
const
  FSql: string =
  'UPDATE NFE_DET_PIS               ' +
  'SET CST = :CST,                  ' +
  '    VBC = :VBC,                  ' +
  '    PPIS = :PPIS,                ' +
  '    QBCPROD = :QBCPROD,          ' +
  '    VALIQPROD = :VALIQPROD,      ' +
  '    VPIS = :VPIS,                ' +
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
      FDQuery.Params.ParamByName('CST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('VBC').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PPIS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('QBCPROD').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALIQPROD').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VPIS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.Cst <> EmptyStr) then
      FDQuery.Params.ParamByName('CST').AsString:= Self.Cst;
      FDQuery.Params.ParamByName('VBC').AsFMTBCD:= Self.Vbc;
      FDQuery.Params.ParamByName('PPIS').AsFMTBCD:= Self.Ppis;
      FDQuery.Params.ParamByName('QBCPROD').AsFMTBCD:= Self.Qbcprod;
      FDQuery.Params.ParamByName('VALIQPROD').AsFMTBCD:= Self.Valiqprod;
      FDQuery.Params.ParamByName('VPIS').AsFMTBCD:= Self.Vpis;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('PIS erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
