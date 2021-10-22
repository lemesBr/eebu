unit NfeTotalIcms;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TNfeTotalIcms = class(TModel)
  private
    FEMPRESA_ID: String;
    FNFE_ID: String;
    FVBC: Extended;
    FVICMS: Extended;
    FVICMSDESON: Extended;
    FVFCPUFDEST: Extended;
    FVICMSUFDEST: Extended;
    FVICMSUFREMET: Extended;
    FVFCP: Extended;
    FVBCST: Extended;
    FVST: Extended;
    FVFCPST: Extended;
    FVFCPSTRET: Extended;
    FVPROD: Extended;
    FVFRETE: Extended;
    FVSEG: Extended;
    FVDESC: Extended;
    FVII: Extended;
    FVIPI: Extended;
    FVIPIDEVOL: Extended;
    FVPIS: Extended;
    FVCOFINS: Extended;
    FVOUTRO: Extended;
    FVNF: Extended;
    FVTOTTRIB: Extended;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function findByNfeId(NfeId: string): TNfeTotalIcms;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeId: String  read FNFE_ID write FNFE_ID;
    property Vbc: Extended  read FVBC write FVBC;
    property Vicms: Extended  read FVICMS write FVICMS;
    property Vicmsdeson: Extended  read FVICMSDESON write FVICMSDESON;
    property Vfcpufdest: Extended  read FVFCPUFDEST write FVFCPUFDEST;
    property Vicmsufdest: Extended  read FVICMSUFDEST write FVICMSUFDEST;
    property Vicmsufremet: Extended  read FVICMSUFREMET write FVICMSUFREMET;
    property Vfcp: Extended  read FVFCP write FVFCP;
    property Vbcst: Extended  read FVBCST write FVBCST;
    property Vst: Extended  read FVST write FVST;
    property Vfcpst: Extended  read FVFCPST write FVFCPST;
    property Vfcpstret: Extended  read FVFCPSTRET write FVFCPSTRET;
    property Vprod: Extended  read FVPROD write FVPROD;
    property Vfrete: Extended  read FVFRETE write FVFRETE;
    property Vseg: Extended  read FVSEG write FVSEG;
    property Vdesc: Extended  read FVDESC write FVDESC;
    property Vii: Extended  read FVII write FVII;
    property Vipi: Extended  read FVIPI write FVIPI;
    property Vipidevol: Extended  read FVIPIDEVOL write FVIPIDEVOL;
    property Vpis: Extended  read FVPIS write FVPIS;
    property Vcofins: Extended  read FVCOFINS write FVCOFINS;
    property Voutro: Extended  read FVOUTRO write FVOUTRO;
    property Vnf: Extended  read FVNF write FVNF;
    property Vtottrib: Extended  read FVTOTTRIB write FVTOTTRIB;

  end;

implementation

uses
  AuthService;

{ TNfeTotalIcms }

constructor TNfeTotalIcms.Create;
begin
  Self.Table:= 'NFE_TOTAL_ICMS';
end;

class function TNfeTotalIcms.findByNfeId(NfeId: string): TNfeTotalIcms;
const
  FSql: string =
  'SELECT * FROM NFE_TOTAL_ICMS WHERE (NFE_ID = :NFE_ID)' +
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
        Result:= TNfeTotalIcms.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.NfeId:= FDQuery.FieldByName('NFE_ID').AsString;
        Result.Vbc:= FDQuery.FieldByName('VBC').AsExtended;
        Result.Vicms:= FDQuery.FieldByName('VICMS').AsExtended;
        Result.Vicmsdeson:= FDQuery.FieldByName('VICMSDESON').AsExtended;
        Result.Vfcpufdest:= FDQuery.FieldByName('VFCPUFDEST').AsExtended;
        Result.Vicmsufdest:= FDQuery.FieldByName('VICMSUFDEST').AsExtended;
        Result.Vicmsufremet:= FDQuery.FieldByName('VICMSUFREMET').AsExtended;
        Result.Vfcp:= FDQuery.FieldByName('VFCP').AsExtended;
        Result.Vbcst:= FDQuery.FieldByName('VBCST').AsExtended;
        Result.Vst:= FDQuery.FieldByName('VST').AsExtended;
        Result.Vfcpst:= FDQuery.FieldByName('VFCPST').AsExtended;
        Result.Vfcpstret:= FDQuery.FieldByName('VFCPSTRET').AsExtended;
        Result.Vprod:= FDQuery.FieldByName('VPROD').AsExtended;
        Result.Vfrete:= FDQuery.FieldByName('VFRETE').AsExtended;
        Result.Vseg:= FDQuery.FieldByName('VSEG').AsExtended;
        Result.Vdesc:= FDQuery.FieldByName('VDESC').AsExtended;
        Result.Vii:= FDQuery.FieldByName('VII').AsExtended;
        Result.Vipi:= FDQuery.FieldByName('VIPI').AsExtended;
        Result.Vipidevol:= FDQuery.FieldByName('VIPIDEVOL').AsExtended;
        Result.Vpis:= FDQuery.FieldByName('VPIS').AsExtended;
        Result.Vcofins:= FDQuery.FieldByName('VCOFINS').AsExtended;
        Result.Voutro:= FDQuery.FieldByName('VOUTRO').AsExtended;
        Result.Vnf:= FDQuery.FieldByName('VNF').AsExtended;
        Result.Vtottrib:= FDQuery.FieldByName('VTOTTRIB').AsExtended;
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

function TNfeTotalIcms.save: Boolean;
begin
  Result:= inherited;
end;

function TNfeTotalIcms.store: Boolean;
const
  FSql: string =
  'INSERT INTO NFE_TOTAL_ICMS (' +
  '  ID,                       ' +
  '  EMPRESA_ID,               ' +
  '  NFE_ID,                   ' +
  '  VBC,                      ' +
  '  VICMS,                    ' +
  '  VICMSDESON,               ' +
  '  VFCPUFDEST,               ' +
  '  VICMSUFDEST,              ' +
  '  VICMSUFREMET,             ' +
  '  VFCP,                     ' +
  '  VBCST,                    ' +
  '  VST,                      ' +
  '  VFCPST,                   ' +
  '  VFCPSTRET,                ' +
  '  VPROD,                    ' +
  '  VFRETE,                   ' +
  '  VSEG,                     ' +
  '  VDESC,                    ' +
  '  VII,                      ' +
  '  VIPI,                     ' +
  '  VIPIDEVOL,                ' +
  '  VPIS,                     ' +
  '  VCOFINS,                  ' +
  '  VOUTRO,                   ' +
  '  VNF,                      ' +
  '  VTOTTRIB,                 ' +
  '  CREATED_AT,               ' +
  '  UPDATED_AT)               ' +
  'VALUES (                    ' +
  '  :ID,                      ' +
  '  :EMPRESA_ID,              ' +
  '  :NFE_ID,                  ' +
  '  :VBC,                     ' +
  '  :VICMS,                   ' +
  '  :VICMSDESON,              ' +
  '  :VFCPUFDEST,              ' +
  '  :VICMSUFDEST,             ' +
  '  :VICMSUFREMET,            ' +
  '  :VFCP,                    ' +
  '  :VBCST,                   ' +
  '  :VST,                     ' +
  '  :VFCPST,                  ' +
  '  :VFCPSTRET,               ' +
  '  :VPROD,                   ' +
  '  :VFRETE,                  ' +
  '  :VSEG,                    ' +
  '  :VDESC,                   ' +
  '  :VII,                     ' +
  '  :VIPI,                    ' +
  '  :VIPIDEVOL,               ' +
  '  :VPIS,                    ' +
  '  :VCOFINS,                 ' +
  '  :VOUTRO,                  ' +
  '  :VNF,                     ' +
  '  :VTOTTRIB,                ' +
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
      FDQuery.Params.ParamByName('NFE_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('VBC').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMSDESON').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VFCPUFDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMSUFDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMSUFREMET').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VFCP').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBCST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VFCPST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VFCPSTRET').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VPROD').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VFRETE').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VSEG').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VDESC').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VII').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VIPI').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VIPIDEVOL').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VPIS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VCOFINS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VOUTRO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VNF').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VTOTTRIB').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NFE_ID').AsString:= Self.NfeId;
      FDQuery.Params.ParamByName('VBC').AsFMTBCD:= Self.Vbc;
      FDQuery.Params.ParamByName('VICMS').AsFMTBCD:= Self.Vicms;
      FDQuery.Params.ParamByName('VICMSDESON').AsFMTBCD:= Self.Vicmsdeson;
      FDQuery.Params.ParamByName('VFCPUFDEST').AsFMTBCD:= Self.Vfcpufdest;
      FDQuery.Params.ParamByName('VICMSUFDEST').AsFMTBCD:= Self.Vicmsufdest;
      FDQuery.Params.ParamByName('VICMSUFREMET').AsFMTBCD:= Self.Vicmsufremet;
      FDQuery.Params.ParamByName('VFCP').AsFMTBCD:= Self.Vfcp;
      FDQuery.Params.ParamByName('VBCST').AsFMTBCD:= Self.Vbcst;
      FDQuery.Params.ParamByName('VST').AsFMTBCD:= Self.Vst;
      FDQuery.Params.ParamByName('VFCPST').AsFMTBCD:= Self.Vfcpst;
      FDQuery.Params.ParamByName('VFCPSTRET').AsFMTBCD:= Self.Vfcpstret;
      FDQuery.Params.ParamByName('VPROD').AsFMTBCD:= Self.Vprod;
      FDQuery.Params.ParamByName('VFRETE').AsFMTBCD:= Self.Vfrete;
      FDQuery.Params.ParamByName('VSEG').AsFMTBCD:= Self.Vseg;
      FDQuery.Params.ParamByName('VDESC').AsFMTBCD:= Self.Vdesc;
      FDQuery.Params.ParamByName('VII').AsFMTBCD:= Self.Vii;
      FDQuery.Params.ParamByName('VIPI').AsFMTBCD:= Self.Vipi;
      FDQuery.Params.ParamByName('VIPIDEVOL').AsFMTBCD:= Self.Vipidevol;
      FDQuery.Params.ParamByName('VPIS').AsFMTBCD:= Self.Vpis;
      FDQuery.Params.ParamByName('VCOFINS').AsFMTBCD:= Self.Vcofins;
      FDQuery.Params.ParamByName('VOUTRO').AsFMTBCD:= Self.Voutro;
      FDQuery.Params.ParamByName('VNF').AsFMTBCD:= Self.Vnf;
      FDQuery.Params.ParamByName('VTOTTRIB').AsFMTBCD:= Self.Vtottrib;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('TOTAL ICMS erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeTotalIcms.update: Boolean;
const
  FSql: string =
  'UPDATE NFE_TOTAL_ICMS            ' +
  'SET VBC = :VBC,                  ' +
  '    VICMS = :VICMS,              ' +
  '    VICMSDESON = :VICMSDESON,    ' +
  '    VFCPUFDEST = :VFCPUFDEST,    ' +
  '    VICMSUFDEST = :VICMSUFDEST,  ' +
  '    VICMSUFREMET = :VICMSUFREMET,' +
  '    VFCP = :VFCP,                ' +
  '    VBCST = :VBCST,              ' +
  '    VST = :VST,                  ' +
  '    VFCPST = :VFCPST,            ' +
  '    VFCPSTRET = :VFCPSTRET,      ' +
  '    VPROD = :VPROD,              ' +
  '    VFRETE = :VFRETE,            ' +
  '    VSEG = :VSEG,                ' +
  '    VDESC = :VDESC,              ' +
  '    VII = :VII,                  ' +
  '    VIPI = :VIPI,                ' +
  '    VIPIDEVOL = :VIPIDEVOL,      ' +
  '    VPIS = :VPIS,                ' +
  '    VCOFINS = :VCOFINS,          ' +
  '    VOUTRO = :VOUTRO,            ' +
  '    VNF = :VNF,                  ' +
  '    VTOTTRIB = :VTOTTRIB,        ' +
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
      FDQuery.Params.ParamByName('VBC').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMSDESON').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VFCPUFDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMSUFDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMSUFREMET').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VFCP').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBCST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VFCPST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VFCPSTRET').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VPROD').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VFRETE').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VSEG').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VDESC').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VII').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VIPI').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VIPIDEVOL').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VPIS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VCOFINS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VOUTRO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VNF').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VTOTTRIB').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('VBC').AsFMTBCD:= Self.Vbc;
      FDQuery.Params.ParamByName('VICMS').AsFMTBCD:= Self.Vicms;
      FDQuery.Params.ParamByName('VICMSDESON').AsFMTBCD:= Self.Vicmsdeson;
      FDQuery.Params.ParamByName('VFCPUFDEST').AsFMTBCD:= Self.Vfcpufdest;
      FDQuery.Params.ParamByName('VICMSUFDEST').AsFMTBCD:= Self.Vicmsufdest;
      FDQuery.Params.ParamByName('VICMSUFREMET').AsFMTBCD:= Self.Vicmsufremet;
      FDQuery.Params.ParamByName('VFCP').AsFMTBCD:= Self.Vfcp;
      FDQuery.Params.ParamByName('VBCST').AsFMTBCD:= Self.Vbcst;
      FDQuery.Params.ParamByName('VST').AsFMTBCD:= Self.Vst;
      FDQuery.Params.ParamByName('VFCPST').AsFMTBCD:= Self.Vfcpst;
      FDQuery.Params.ParamByName('VFCPSTRET').AsFMTBCD:= Self.Vfcpstret;
      FDQuery.Params.ParamByName('VPROD').AsFMTBCD:= Self.Vprod;
      FDQuery.Params.ParamByName('VFRETE').AsFMTBCD:= Self.Vfrete;
      FDQuery.Params.ParamByName('VSEG').AsFMTBCD:= Self.Vseg;
      FDQuery.Params.ParamByName('VDESC').AsFMTBCD:= Self.Vdesc;
      FDQuery.Params.ParamByName('VII').AsFMTBCD:= Self.Vii;
      FDQuery.Params.ParamByName('VIPI').AsFMTBCD:= Self.Vipi;
      FDQuery.Params.ParamByName('VIPIDEVOL').AsFMTBCD:= Self.Vipidevol;
      FDQuery.Params.ParamByName('VPIS').AsFMTBCD:= Self.Vpis;
      FDQuery.Params.ParamByName('VCOFINS').AsFMTBCD:= Self.Vcofins;
      FDQuery.Params.ParamByName('VOUTRO').AsFMTBCD:= Self.Voutro;
      FDQuery.Params.ParamByName('VNF').AsFMTBCD:= Self.Vnf;
      FDQuery.Params.ParamByName('VTOTTRIB').AsFMTBCD:= Self.Vtottrib;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('TOTAL ICMS erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
