unit NfeDetCofins;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TNfeDetCofins = class(TModel)
  private
    FEMPRESA_ID: String;
    FNFE_DET_ID: String;
    FCST: String;
    FVBC: Extended;
    FPCOFINS: Extended;
    FQBCPROD: Extended;
    FVBCPROD: Extended;
    FVALIQPROD: Extended;
    FVCOFINS: Extended;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function findByNfeDetId(NfeDetId: string): TNfeDetCofins;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeDetId: String  read FNFE_DET_ID write FNFE_DET_ID;
    property Cst: String  read FCST write FCST;
    property Vbc: Extended  read FVBC write FVBC;
    property Pcofins: Extended  read FPCOFINS write FPCOFINS;
    property Qbcprod: Extended  read FQBCPROD write FQBCPROD;
    property Vbcprod: Extended  read FVBCPROD write FVBCPROD;
    property Valiqprod: Extended  read FVALIQPROD write FVALIQPROD;
    property Vcofins: Extended  read FVCOFINS write FVCOFINS;


  end;

implementation

uses
  AuthService;

{ TNfeDetCofins }

constructor TNfeDetCofins.Create;
begin
  Self.Table:= 'NFE_DET_COFINS';
end;

class function TNfeDetCofins.findByNfeDetId(NfeDetId: string): TNfeDetCofins;
const
  FSql: string = 'SELECT * FROM NFE_DET_COFINS WHERE (NFE_DET_ID = :NFE_DET_ID)' +
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
        Result:= TNfeDetCofins.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.NfeDetId:= FDQuery.FieldByName('NFE_DET_ID').AsString;
        Result.Cst:= FDQuery.FieldByName('CST').AsString;
        Result.Vbc:= FDQuery.FieldByName('VBC').AsExtended;
        Result.Pcofins:= FDQuery.FieldByName('PCOFINS').AsExtended;
        Result.Qbcprod:= FDQuery.FieldByName('QBCPROD').AsExtended;
        Result.Vbcprod:= FDQuery.FieldByName('VBCPROD').AsExtended;
        Result.Valiqprod:= FDQuery.FieldByName('VALIQPROD').AsExtended;
        Result.Vcofins:= FDQuery.FieldByName('VCOFINS').AsExtended;
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

function TNfeDetCofins.save: Boolean;
begin
  Result:= inherited;
end;

function TNfeDetCofins.store: Boolean;
const
  FSql: string =
  'INSERT INTO NFE_DET_COFINS (' +
  '  ID,                       ' +
  '  EMPRESA_ID,               ' +
  '  NFE_DET_ID,               ' +
  '  CST,                      ' +
  '  VBC,                      ' +
  '  PCOFINS,                  ' +
  '  QBCPROD,                  ' +
  '  VBCPROD,                  ' +
  '  VALIQPROD,                ' +
  '  VCOFINS,                  ' +
  '  CREATED_AT,               ' +
  '  UPDATED_AT)               ' +
  'VALUES (                    ' +
  '  :ID,                      ' +
  '  :EMPRESA_ID,              ' +
  '  :NFE_DET_ID,              ' +
  '  :CST,                     ' +
  '  :VBC,                     ' +
  '  :PCOFINS,                 ' +
  '  :QBCPROD,                 ' +
  '  :VBCPROD,                 ' +
  '  :VALIQPROD,               ' +
  '  :VCOFINS,                 ' +
  '  :CREATED_AT,              ' +
  '  :UPDATED_AT)              ';
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
      FDQuery.Params.ParamByName('PCOFINS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('QBCPROD').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBCPROD').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALIQPROD').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VCOFINS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.Terminal.EmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NFE_DET_ID').AsString:= Self.NfeDetId;
      if (Self.Cst <> EmptyStr) then
      FDQuery.Params.ParamByName('CST').AsString:= Self.Cst;
      FDQuery.Params.ParamByName('VBC').AsFMTBCD:= Self.Vbc;
      FDQuery.Params.ParamByName('PCOFINS').AsFMTBCD:= Self.Pcofins;
      FDQuery.Params.ParamByName('QBCPROD').AsFMTBCD:= Self.Qbcprod;
      FDQuery.Params.ParamByName('VBCPROD').AsFMTBCD:= Self.Vbcprod;
      FDQuery.Params.ParamByName('VALIQPROD').AsFMTBCD:= Self.Valiqprod;
      FDQuery.Params.ParamByName('VCOFINS').AsFMTBCD:= Self.Vcofins;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('COFINS erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeDetCofins.update: Boolean;
const
  FSql: string =
  'UPDATE NFE_DET_COFINS            ' +
  'SET CST = :CST,                  ' +
  '    VBC = :VBC,                  ' +
  '    PCOFINS = :PCOFINS,          ' +
  '    QBCPROD = :QBCPROD,          ' +
  '    VBCPROD = :VBCPROD,          ' +
  '    VALIQPROD = :VALIQPROD,      ' +
  '    VCOFINS = :VCOFINS,          ' +
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
      FDQuery.Params.ParamByName('PCOFINS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('QBCPROD').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBCPROD').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALIQPROD').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VCOFINS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.Cst <> EmptyStr) then
      FDQuery.Params.ParamByName('CST').AsString:= Self.Cst;
      FDQuery.Params.ParamByName('VBC').AsFMTBCD:= Self.Vbc;
      FDQuery.Params.ParamByName('PCOFINS').AsFMTBCD:= Self.Pcofins;
      FDQuery.Params.ParamByName('QBCPROD').AsFMTBCD:= Self.Qbcprod;
      FDQuery.Params.ParamByName('VBCPROD').AsFMTBCD:= Self.Vbcprod;
      FDQuery.Params.ParamByName('VALIQPROD').AsFMTBCD:= Self.Valiqprod;
      FDQuery.Params.ParamByName('VCOFINS').AsFMTBCD:= Self.Vcofins;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('COFINS erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
