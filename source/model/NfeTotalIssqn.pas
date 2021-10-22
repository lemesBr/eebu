unit NfeTotalIssqn;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TNfeTotalIssqn = class(TModel)
  private
    FEMPRESA_ID: String;
    FNFE_ID: String;
    FVSERV: Extended;
    FVBC: Extended;
    FVISS: Extended;
    FVPIS: Extended;
    FVCOFINS: Extended;
    FDCOMPET: TDateTime;
    FVDEDUCAO: Extended;
    FVOUTRO: Extended;
    FVDESCINCOND: Extended;
    FVDESCCOND: Extended;
    FVISSRET: Extended;
    FCREGTRIB: String;
    
  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function findByNfeId(NfeId: string): TNfeTotalIssqn;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeId: String  read FNFE_ID write FNFE_ID;
    property Vserv: Extended  read FVSERV write FVSERV;
    property Vbc: Extended  read FVBC write FVBC;
    property Viss: Extended  read FVISS write FVISS;
    property Vpis: Extended  read FVPIS write FVPIS;
    property Vcofins: Extended  read FVCOFINS write FVCOFINS;
    property Dcompet: TDateTime  read FDCOMPET write FDCOMPET;
    property Vdeducao: Extended  read FVDEDUCAO write FVDEDUCAO;
    property Voutro: Extended  read FVOUTRO write FVOUTRO;
    property Vdescincond: Extended  read FVDESCINCOND write FVDESCINCOND;
    property Vdesccond: Extended  read FVDESCCOND write FVDESCCOND;
    property Vissret: Extended  read FVISSRET write FVISSRET;
    property Cregtrib: String  read FCREGTRIB write FCREGTRIB;

  end;

implementation

uses
  AuthService;


{ TNfeTotalIssqn }

constructor TNfeTotalIssqn.Create;
begin
  Self.Table:= 'NFE_TOTAL_ISSQN';
end;

class function TNfeTotalIssqn.findByNfeId(NfeId: string): TNfeTotalIssqn;
const
  FSql: string =
  'SELECT * FROM NFE_TOTAL_ISSQN WHERE (NFE_ID = :NFE_ID)' +
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
        Result:= TNfeTotalIssqn.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.NfeId:= FDQuery.FieldByName('NFE_ID').AsString;
        Result.Vserv:= FDQuery.FieldByName('VSERV').AsExtended;
        Result.Vbc:= FDQuery.FieldByName('VBC').AsExtended;
        Result.Viss:= FDQuery.FieldByName('VISS').AsExtended;
        Result.Vpis:= FDQuery.FieldByName('VPIS').AsExtended;
        Result.Vcofins:= FDQuery.FieldByName('VCOFINS').AsExtended;
        Result.Dcompet:= FDQuery.FieldByName('DCOMPET').AsDateTime;
        Result.Vdeducao:= FDQuery.FieldByName('VDEDUCAO').AsExtended;
        Result.Voutro:= FDQuery.FieldByName('VOUTRO').AsExtended;
        Result.Vdescincond:= FDQuery.FieldByName('VDESCINCOND').AsExtended;
        Result.Vdesccond:= FDQuery.FieldByName('VDESCCOND').AsExtended;
        Result.Vissret:= FDQuery.FieldByName('VISSRET').AsExtended;
        Result.Cregtrib:= FDQuery.FieldByName('CREGTRIB').AsString;
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

function TNfeTotalIssqn.save: Boolean;
begin
  Result:= inherited;
end;

function TNfeTotalIssqn.store: Boolean;
const
  FSql: string =
  'INSERT INTO NFE_TOTAL_ISSQN (' +
  '  ID,                        ' +
  '  EMPRESA_ID,                ' +
  '  NFE_ID,                    ' +
  '  VSERV,                     ' +
  '  VBC,                       ' +
  '  VISS,                      ' +
  '  VPIS,                      ' +
  '  VCOFINS,                   ' +
  '  DCOMPET,                   ' +
  '  VDEDUCAO,                  ' +
  '  VOUTRO,                    ' +
  '  VDESCINCOND,               ' +
  '  VDESCCOND,                 ' +
  '  VISSRET,                   ' +
  '  CREGTRIB,                  ' +
  '  CREATED_AT,                ' +
  '  UPDATED_AT)                ' +
  'VALUES (                     ' +
  '  :ID,                       ' +
  '  :EMPRESA_ID,               ' +
  '  :NFE_ID,                   ' +
  '  :VSERV,                    ' +
  '  :VBC,                      ' +
  '  :VISS,                     ' +
  '  :VPIS,                     ' +
  '  :VCOFINS,                  ' +
  '  :DCOMPET,                  ' +
  '  :VDEDUCAO,                 ' +
  '  :VOUTRO,                   ' +
  '  :VDESCINCOND,              ' +
  '  :VDESCCOND,                ' +
  '  :VISSRET,                  ' +
  '  :CREGTRIB,                 ' +
  '  :CREATED_AT,               ' +
  '  :UPDATED_AT)               ';
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
      FDQuery.Params.ParamByName('VSERV').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBC').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VISS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VPIS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VCOFINS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('DCOMPET').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VDEDUCAO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VOUTRO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VDESCINCOND').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VDESCCOND').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VISSRET').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CREGTRIB').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NFE_ID').AsString:= Self.NfeId;
      FDQuery.Params.ParamByName('VSERV').AsFMTBCD:= Self.Vserv;
      FDQuery.Params.ParamByName('VBC').AsFMTBCD:= Self.Vbc;
      FDQuery.Params.ParamByName('VISS').AsFMTBCD:= Self.Viss;
      FDQuery.Params.ParamByName('VPIS').AsFMTBCD:= Self.Vpis;
      FDQuery.Params.ParamByName('VCOFINS').AsFMTBCD:= Self.Vcofins;
      FDQuery.Params.ParamByName('DCOMPET').AsFMTBCD:= Self.Dcompet;
      FDQuery.Params.ParamByName('VDEDUCAO').AsFMTBCD:= Self.Vdeducao;
      FDQuery.Params.ParamByName('VOUTRO').AsFMTBCD:= Self.Voutro;
      FDQuery.Params.ParamByName('VDESCINCOND').AsFMTBCD:= Self.Vdescincond;
      FDQuery.Params.ParamByName('VDESCCOND').AsFMTBCD:= Self.Vdesccond;
      FDQuery.Params.ParamByName('VISSRET').AsFMTBCD:= Self.Vissret;
      FDQuery.Params.ParamByName('CREGTRIB').AsFMTBCD:= Self.Cregtrib;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('TOTAL ISSQN erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeTotalIssqn.update: Boolean;
const
  FSql: string =
  'UPDATE NFE_TOTAL_ISSQN           ' +
  'SET VSERV = :VSERV,              ' +
  '    VBC = :VBC,                  ' +
  '    VISS = :VISS,                ' +
  '    VPIS = :VPIS,                ' +
  '    VCOFINS = :VCOFINS,          ' +
  '    DCOMPET = :DCOMPET,          ' +
  '    VDEDUCAO = :VDEDUCAO,        ' +
  '    VOUTRO = :VOUTRO,            ' +
  '    VDESCINCOND = :VDESCINCOND,  ' +
  '    VDESCCOND = :VDESCCOND,      ' +
  '    VISSRET = :VISSRET,          ' +
  '    CREGTRIB = :CREGTRIB,        ' +
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
      FDQuery.Params.ParamByName('VSERV').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBC').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VISS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VPIS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VCOFINS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('DCOMPET').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VDEDUCAO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VOUTRO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VDESCINCOND').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VDESCCOND').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VISSRET').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CREGTRIB').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('VSERV').AsFMTBCD:= Self.Vserv;
      FDQuery.Params.ParamByName('VBC').AsFMTBCD:= Self.Vbc;
      FDQuery.Params.ParamByName('VISS').AsFMTBCD:= Self.Viss;
      FDQuery.Params.ParamByName('VPIS').AsFMTBCD:= Self.Vpis;
      FDQuery.Params.ParamByName('VCOFINS').AsFMTBCD:= Self.Vcofins;
      FDQuery.Params.ParamByName('DCOMPET').AsFMTBCD:= Self.Dcompet;
      FDQuery.Params.ParamByName('VDEDUCAO').AsFMTBCD:= Self.Vdeducao;
      FDQuery.Params.ParamByName('VOUTRO').AsFMTBCD:= Self.Voutro;
      FDQuery.Params.ParamByName('VDESCINCOND').AsFMTBCD:= Self.Vdescincond;
      FDQuery.Params.ParamByName('VDESCCOND').AsFMTBCD:= Self.Vdesccond;
      FDQuery.Params.ParamByName('VISSRET').AsFMTBCD:= Self.Vissret;
      FDQuery.Params.ParamByName('CREGTRIB').AsFMTBCD:= Self.Cregtrib;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('TOTAL ISSQN erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
