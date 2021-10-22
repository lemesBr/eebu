unit NfeDetIcms;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TNfeDetIcms = class(TModel)
  private
    FEMPRESA_ID: String;
    FNFE_DET_ID: String;
    FORIG: String;
    FCST: String;
    FCSOSN: String;
    FMODBC: String;
    FPREDBC: Extended;
    FVBC: Extended;
    FPICMS: Extended;
    FVICMS: Extended;
    FMODBCST: String;
    FPMVAST: Extended;
    FPREDBCST: Extended;
    FVBCST: Extended;
    FPICMSST: Extended;
    FVICMSST: Extended;
    FUFST: String;
    FPBCOP: Extended;
    FVBCSTRET: Extended;
    FVICMSSTRET: Extended;
    FMOTDESICMS: String;
    FPCREDSN: Extended;
    FVCREDICMSSN: Extended;
    FVBCSTDEST: Extended;
    FVICMSSTDEST: Extended;
    FVICMSDESON: Extended;
    FVICMSOP: Extended;
    FPDIF: Extended;
    FVICMSDIF: Extended;
    FVBCFCP: Extended;
    FPFCP: Extended;
    FVFCP: Extended;
    FVBCFCPST: Extended;
    FPFCPST: Extended;
    FVFCPST: Extended;
    FVBCFCPSTRET: Extended;
    FPFCPSTRET: Extended;
    FVFCPSTRET: Extended;
    FPST: Extended;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function findByNfeDetId(NfeDetId: string): TNfeDetIcms;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeDetId: String  read FNFE_DET_ID write FNFE_DET_ID;
    property Orig: String  read FORIG write FORIG;
    property Cst: String  read FCST write FCST;
    property Csosn: String  read FCSOSN write FCSOSN;
    property Modbc: String  read FMODBC write FMODBC;
    property Predbc: Extended  read FPREDBC write FPREDBC;
    property Vbc: Extended  read FVBC write FVBC;
    property Picms: Extended  read FPICMS write FPICMS;
    property Vicms: Extended  read FVICMS write FVICMS;
    property Modbcst: String  read FMODBCST write FMODBCST;
    property Pmvast: Extended  read FPMVAST write FPMVAST;
    property Predbcst: Extended  read FPREDBCST write FPREDBCST;
    property Vbcst: Extended  read FVBCST write FVBCST;
    property Picmsst: Extended  read FPICMSST write FPICMSST;
    property Vicmsst: Extended  read FVICMSST write FVICMSST;
    property Ufst: String  read FUFST write FUFST;
    property Pbcop: Extended  read FPBCOP write FPBCOP;
    property Vbcstret: Extended  read FVBCSTRET write FVBCSTRET;
    property Vicmsstret: Extended  read FVICMSSTRET write FVICMSSTRET;
    property Motdesicms: String  read FMOTDESICMS write FMOTDESICMS;
    property Pcredsn: Extended  read FPCREDSN write FPCREDSN;
    property Vcredicmssn: Extended  read FVCREDICMSSN write FVCREDICMSSN;
    property Vbcstdest: Extended  read FVBCSTDEST write FVBCSTDEST;
    property Vicmsstdest: Extended  read FVICMSSTDEST write FVICMSSTDEST;
    property Vicmsdeson: Extended  read FVICMSDESON write FVICMSDESON;
    property Vicmsop: Extended  read FVICMSOP write FVICMSOP;
    property Pdif: Extended  read FPDIF write FPDIF;
    property Vicmsdif: Extended  read FVICMSDIF write FVICMSDIF;
    property Vbcfcp: Extended  read FVBCFCP write FVBCFCP;
    property Pfcp: Extended  read FPFCP write FPFCP;
    property Vfcp: Extended  read FVFCP write FVFCP;
    property Vbcfcpst: Extended  read FVBCFCPST write FVBCFCPST;
    property Pfcpst: Extended  read FPFCPST write FPFCPST;
    property Vfcpst: Extended  read FVFCPST write FVFCPST;
    property Vbcfcpstret: Extended  read FVBCFCPSTRET write FVBCFCPSTRET;
    property Pfcpstret: Extended  read FPFCPSTRET write FPFCPSTRET;
    property Vfcpstret: Extended  read FVFCPSTRET write FVFCPSTRET;
    property Pst: Extended  read FPST write FPST;

  end;

implementation

uses
  AuthService;

{ TNfeDetIcms }

constructor TNfeDetIcms.Create;
begin
  Self.Table:= 'NFE_DET_ICMS';
end;

class function TNfeDetIcms.findByNfeDetId(NfeDetId: string): TNfeDetIcms;
const
  FSql: string =
  'SELECT * FROM NFE_DET_ICMS WHERE (NFE_DET_ID = :NFE_DET_ID)' +
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
        Result:= TNfeDetIcms.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.NfeDetId:= FDQuery.FieldByName('NFE_DET_ID').AsString;
        Result.Orig:= FDQuery.FieldByName('ORIG').AsString;
        Result.Cst:= FDQuery.FieldByName('CST').AsString;
        Result.Csosn:= FDQuery.FieldByName('CSOSN').AsString;
        Result.Modbc:= FDQuery.FieldByName('MODBC').AsString;
        Result.Predbc:= FDQuery.FieldByName('PREDBC').AsExtended;
        Result.Vbc:= FDQuery.FieldByName('VBC').AsExtended;
        Result.Picms:= FDQuery.FieldByName('PICMS').AsExtended;
        Result.Vicms:= FDQuery.FieldByName('VICMS').AsExtended;
        Result.Modbcst:= FDQuery.FieldByName('MODBCST').AsString;
        Result.Pmvast:= FDQuery.FieldByName('PMVAST').AsExtended;
        Result.Predbcst:= FDQuery.FieldByName('PREDBCST').AsExtended;
        Result.Vbcst:= FDQuery.FieldByName('VBCST').AsExtended;
        Result.Picmsst:= FDQuery.FieldByName('PICMSST').AsExtended;
        Result.Vicmsst:= FDQuery.FieldByName('VICMSST').AsExtended;
        Result.Ufst:= FDQuery.FieldByName('UFST').AsString;
        Result.Pbcop:= FDQuery.FieldByName('PBCOP').AsExtended;
        Result.Vbcstret:= FDQuery.FieldByName('VBCSTRET').AsExtended;
        Result.Vicmsstret:= FDQuery.FieldByName('VICMSSTRET').AsExtended;
        Result.Motdesicms:= FDQuery.FieldByName('MOTDESICMS').AsString;
        Result.Pcredsn:= FDQuery.FieldByName('PCREDSN').AsExtended;
        Result.Vcredicmssn:= FDQuery.FieldByName('VCREDICMSSN').AsExtended;
        Result.Vbcstdest:= FDQuery.FieldByName('VBCSTDEST').AsExtended;
        Result.Vicmsstdest:= FDQuery.FieldByName('VICMSSTDEST').AsExtended;
        Result.Vicmsdeson:= FDQuery.FieldByName('VICMSDESON').AsExtended;
        Result.Vicmsop:= FDQuery.FieldByName('VICMSOP').AsExtended;
        Result.Pdif:= FDQuery.FieldByName('PDIF').AsExtended;
        Result.Vicmsdif:= FDQuery.FieldByName('VICMSDIF').AsExtended;
        Result.Vbcfcp:= FDQuery.FieldByName('VBCFCP').AsExtended;
        Result.Pfcp:= FDQuery.FieldByName('PFCP').AsExtended;
        Result.Vfcp:= FDQuery.FieldByName('VFCP').AsExtended;
        Result.Vbcfcpst:= FDQuery.FieldByName('VBCFCPST').AsExtended;
        Result.Pfcpst:= FDQuery.FieldByName('PFCPST').AsExtended;
        Result.Vfcpst:= FDQuery.FieldByName('VFCPST').AsExtended;
        Result.Vbcfcpstret:= FDQuery.FieldByName('VBCFCPSTRET').AsExtended;
        Result.Pfcpstret:= FDQuery.FieldByName('PFCPSTRET').AsExtended;
        Result.Vfcpstret:= FDQuery.FieldByName('VFCPSTRET').AsExtended;
        Result.Pst:= FDQuery.FieldByName('PST').AsExtended;
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

function TNfeDetIcms.save: Boolean;
begin
  Result:= inherited;
end;

function TNfeDetIcms.store: Boolean;
const
  FSql: string =
  'INSERT INTO NFE_DET_ICMS (' +
  '  ID,                     ' +
  '  EMPRESA_ID,             ' +
  '  NFE_DET_ID,             ' +
  '  ORIG,                   ' +
  '  CST,                    ' +
  '  CSOSN,                  ' +
  '  MODBC,                  ' +
  '  PREDBC,                 ' +
  '  VBC,                    ' +
  '  PICMS,                  ' +
  '  VICMS,                  ' +
  '  MODBCST,                ' +
  '  PMVAST,                 ' +
  '  PREDBCST,               ' +
  '  VBCST,                  ' +
  '  PICMSST,                ' +
  '  VICMSST,                ' +
  '  UFST,                   ' +
  '  PBCOP,                  ' +
  '  VBCSTRET,               ' +
  '  VICMSSTRET,             ' +
  '  MOTDESICMS,             ' +
  '  PCREDSN,                ' +
  '  VCREDICMSSN,            ' +
  '  VBCSTDEST,              ' +
  '  VICMSSTDEST,            ' +
  '  VICMSDESON,             ' +
  '  VICMSOP,                ' +
  '  PDIF,                   ' +
  '  VICMSDIF,               ' +
  '  VBCFCP,                 ' +
  '  PFCP,                   ' +
  '  VFCP,                   ' +
  '  VBCFCPST,               ' +
  '  PFCPST,                 ' +
  '  VFCPST,                 ' +
  '  VBCFCPSTRET,            ' +
  '  PFCPSTRET,              ' +
  '  VFCPSTRET,              ' +
  '  PST,                    ' +
  '  CREATED_AT,             ' +
  '  UPDATED_AT)             ' +
  'VALUES (                  ' +
  '  :ID,                    ' +
  '  :EMPRESA_ID,            ' +
  '  :NFE_DET_ID,            ' +
  '  :ORIG,                  ' +
  '  :CST,                   ' +
  '  :CSOSN,                 ' +
  '  :MODBC,                 ' +
  '  :PREDBC,                ' +
  '  :VBC,                   ' +
  '  :PICMS,                 ' +
  '  :VICMS,                 ' +
  '  :MODBCST,               ' +
  '  :PMVAST,                ' +
  '  :PREDBCST,              ' +
  '  :VBCST,                 ' +
  '  :PICMSST,               ' +
  '  :VICMSST,               ' +
  '  :UFST,                  ' +
  '  :PBCOP,                 ' +
  '  :VBCSTRET,              ' +
  '  :VICMSSTRET,            ' +
  '  :MOTDESICMS,            ' +
  '  :PCREDSN,               ' +
  '  :VCREDICMSSN,           ' +
  '  :VBCSTDEST,             ' +
  '  :VICMSSTDEST,           ' +
  '  :VICMSDESON,            ' +
  '  :VICMSOP,               ' +
  '  :PDIF,                  ' +
  '  :VICMSDIF,              ' +
  '  :VBCFCP,                ' +
  '  :PFCP,                  ' +
  '  :VFCP,                  ' +
  '  :VBCFCPST,              ' +
  '  :PFCPST,                ' +
  '  :VFCPST,                ' +
  '  :VBCFCPSTRET,           ' +
  '  :PFCPSTRET,             ' +
  '  :VFCPSTRET,             ' +
  '  :PST,                   ' +
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
      FDQuery.Params.ParamByName('NFE_DET_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('ORIG').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CSOSN').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('MODBC').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PREDBC').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBC').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PICMS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('MODBCST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PMVAST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PREDBCST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBCST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PICMSST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMSST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('UFST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PBCOP').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBCSTRET').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMSSTRET').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('MOTDESICMS').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PCREDSN').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VCREDICMSSN').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBCSTDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMSSTDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMSDESON').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMSOP').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PDIF').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMSDIF').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBCFCP').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PFCP').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VFCP').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBCFCPST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PFCPST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VFCPST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBCFCPSTRET').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PFCPSTRET').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VFCPSTRET').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.Terminal.EmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NFE_DET_ID').AsString:= Self.NfeDetId;
      if (Self.Orig <> EmptyStr) then
        FDQuery.Params.ParamByName('ORIG').AsString:= Self.Orig;
      if (Self.Cst <> EmptyStr) then
        FDQuery.Params.ParamByName('CST').AsString:= Self.Cst;
      if (Self.Csosn <> EmptyStr) then
        FDQuery.Params.ParamByName('CSOSN').AsString:= Self.Csosn;
      if (Self.Modbc <> EmptyStr) then
        FDQuery.Params.ParamByName('MODBC').AsString:= Self.Modbc;
      FDQuery.Params.ParamByName('PREDBC').AsFMTBCD:= Self.Predbc;
      FDQuery.Params.ParamByName('VBC').AsFMTBCD:= Self.Vbc;
      FDQuery.Params.ParamByName('PICMS').AsFMTBCD:= Self.Picms;
      FDQuery.Params.ParamByName('VICMS').AsFMTBCD:= Self.Vicms;
      if (Self.Modbcst <> EmptyStr) then
        FDQuery.Params.ParamByName('MODBCST').AsString:= Self.Modbcst;
      FDQuery.Params.ParamByName('PMVAST').AsFMTBCD:= Self.Pmvast;
      FDQuery.Params.ParamByName('PREDBCST').AsFMTBCD:= Self.Predbcst;
      FDQuery.Params.ParamByName('VBCST').AsFMTBCD:= Self.Vbcst;
      FDQuery.Params.ParamByName('PICMSST').AsFMTBCD:= Self.Picmsst;
      FDQuery.Params.ParamByName('VICMSST').AsFMTBCD:= Self.Vicmsst;
      if (Self.Ufst <> EmptyStr) then
        FDQuery.Params.ParamByName('UFST').AsString:= Self.Ufst;
      FDQuery.Params.ParamByName('PBCOP').AsFMTBCD:= Self.Pbcop;
      FDQuery.Params.ParamByName('VBCSTRET').AsFMTBCD:= Self.Vbcstret;
      FDQuery.Params.ParamByName('VICMSSTRET').AsFMTBCD:= Self.Vicmsstret;
      if (Self.Motdesicms <> EmptyStr) then
        FDQuery.Params.ParamByName('MOTDESICMS').AsString:= Self.Motdesicms;
      FDQuery.Params.ParamByName('PCREDSN').AsFMTBCD:= Self.Pcredsn;
      FDQuery.Params.ParamByName('VCREDICMSSN').AsFMTBCD:= Self.Vcredicmssn;
      FDQuery.Params.ParamByName('VBCSTDEST').AsFMTBCD:= Self.Vbcstdest;
      FDQuery.Params.ParamByName('VICMSSTDEST').AsFMTBCD:= Self.Vicmsstdest;
      FDQuery.Params.ParamByName('VICMSDESON').AsFMTBCD:= Self.Vicmsdeson;
      FDQuery.Params.ParamByName('VICMSOP').AsFMTBCD:= Self.Vicmsop;
      FDQuery.Params.ParamByName('PDIF').AsFMTBCD:= Self.Pdif;
      FDQuery.Params.ParamByName('VICMSDIF').AsFMTBCD:= Self.Vicmsdif;
      FDQuery.Params.ParamByName('VBCFCP').AsFMTBCD:= Self.Vbcfcp;
      FDQuery.Params.ParamByName('PFCP').AsFMTBCD:= Self.Pfcp;
      FDQuery.Params.ParamByName('VFCP').AsFMTBCD:= Self.Vfcp;
      FDQuery.Params.ParamByName('VBCFCPST').AsFMTBCD:= Self.Vbcfcpst;
      FDQuery.Params.ParamByName('PFCPST').AsFMTBCD:= Self.Pfcpst;
      FDQuery.Params.ParamByName('VFCPST').AsFMTBCD:= Self.Vfcpst;
      FDQuery.Params.ParamByName('VBCFCPSTRET').AsFMTBCD:= Self.Vbcfcpstret;
      FDQuery.Params.ParamByName('PFCPSTRET').AsFMTBCD:= Self.Pfcpstret;
      FDQuery.Params.ParamByName('VFCPSTRET').AsFMTBCD:= Self.Vfcpstret;
      FDQuery.Params.ParamByName('PST').AsFMTBCD:= Self.Pst;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('ICMS erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeDetIcms.update: Boolean;
const
  FSql: string =
  'UPDATE NFE_DET_ICMS              ' +
  'SET ORIG = :ORIG,                ' +
  '    CST = :CST,                  ' +
  '    CSOSN = :CSOSN,              ' +
  '    MODBC = :MODBC,              ' +
  '    PREDBC = :PREDBC,            ' +
  '    VBC = :VBC,                  ' +
  '    PICMS = :PICMS,              ' +
  '    VICMS = :VICMS,              ' +
  '    MODBCST = :MODBCST,          ' +
  '    PMVAST = :PMVAST,            ' +
  '    PREDBCST = :PREDBCST,        ' +
  '    VBCST = :VBCST,              ' +
  '    PICMSST = :PICMSST,          ' +
  '    VICMSST = :VICMSST,          ' +
  '    UFST = :UFST,                ' +
  '    PBCOP = :PBCOP,              ' +
  '    VBCSTRET = :VBCSTRET,        ' +
  '    VICMSSTRET = :VICMSSTRET,    ' +
  '    MOTDESICMS = :MOTDESICMS,    ' +
  '    PCREDSN = :PCREDSN,          ' +
  '    VCREDICMSSN = :VCREDICMSSN,  ' +
  '    VBCSTDEST = :VBCSTDEST,      ' +
  '    VICMSSTDEST = :VICMSSTDEST,  ' +
  '    VICMSDESON = :VICMSDESON,    ' +
  '    VICMSOP = :VICMSOP,          ' +
  '    PDIF = :PDIF,                ' +
  '    VICMSDIF = :VICMSDIF,        ' +
  '    VBCFCP = :VBCFCP,            ' +
  '    PFCP = :PFCP,                ' +
  '    VFCP = :VFCP,                ' +
  '    VBCFCPST = :VBCFCPST,        ' +
  '    PFCPST = :PFCPST,            ' +
  '    VFCPST = :VFCPST,            ' +
  '    VBCFCPSTRET = :VBCFCPSTRET,  ' +
  '    PFCPSTRET = :PFCPSTRET,      ' +
  '    VFCPSTRET = :VFCPSTRET,      ' +
  '    PST = :PST,                  ' +
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
      FDQuery.Params.ParamByName('ORIG').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CSOSN').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('MODBC').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PREDBC').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBC').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PICMS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('MODBCST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PMVAST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PREDBCST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBCST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PICMSST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMSST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('UFST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PBCOP').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBCSTRET').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMSSTRET').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('MOTDESICMS').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PCREDSN').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VCREDICMSSN').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBCSTDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMSSTDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMSDESON').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMSOP').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PDIF').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMSDIF').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBCFCP').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PFCP').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VFCP').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBCFCPST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PFCPST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VFCPST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBCFCPSTRET').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PFCPSTRET').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VFCPSTRET').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.Orig <> EmptyStr) then
        FDQuery.Params.ParamByName('ORIG').AsString:= Self.Orig;
      if (Self.Cst <> EmptyStr) then
        FDQuery.Params.ParamByName('CST').AsString:= Self.Cst;
      if (Self.Csosn <> EmptyStr) then
        FDQuery.Params.ParamByName('CSOSN').AsString:= Self.Csosn;
      if (Self.Modbc <> EmptyStr) then
        FDQuery.Params.ParamByName('MODBC').AsString:= Self.Modbc;
      FDQuery.Params.ParamByName('PREDBC').AsFMTBCD:= Self.Predbc;
      FDQuery.Params.ParamByName('VBC').AsFMTBCD:= Self.Vbc;
      FDQuery.Params.ParamByName('PICMS').AsFMTBCD:= Self.Picms;
      FDQuery.Params.ParamByName('VICMS').AsFMTBCD:= Self.Vicms;
      if (Self.Modbcst <> EmptyStr) then
        FDQuery.Params.ParamByName('MODBCST').AsString:= Self.Modbcst;
      FDQuery.Params.ParamByName('PMVAST').AsFMTBCD:= Self.Pmvast;
      FDQuery.Params.ParamByName('PREDBCST').AsFMTBCD:= Self.Predbcst;
      FDQuery.Params.ParamByName('VBCST').AsFMTBCD:= Self.Vbcst;
      FDQuery.Params.ParamByName('PICMSST').AsFMTBCD:= Self.Picmsst;
      FDQuery.Params.ParamByName('VICMSST').AsFMTBCD:= Self.Vicmsst;
      if (Self.Ufst <> EmptyStr) then
        FDQuery.Params.ParamByName('UFST').AsString:= Self.Ufst;
      FDQuery.Params.ParamByName('PBCOP').AsFMTBCD:= Self.Pbcop;
      FDQuery.Params.ParamByName('VBCSTRET').AsFMTBCD:= Self.Vbcstret;
      FDQuery.Params.ParamByName('VICMSSTRET').AsFMTBCD:= Self.Vicmsstret;
      if (Self.Motdesicms <> EmptyStr) then
        FDQuery.Params.ParamByName('MOTDESICMS').AsString:= Self.Motdesicms;
      FDQuery.Params.ParamByName('PCREDSN').AsFMTBCD:= Self.Pcredsn;
      FDQuery.Params.ParamByName('VCREDICMSSN').AsFMTBCD:= Self.Vcredicmssn;
      FDQuery.Params.ParamByName('VBCSTDEST').AsFMTBCD:= Self.Vbcstdest;
      FDQuery.Params.ParamByName('VICMSSTDEST').AsFMTBCD:= Self.Vicmsstdest;
      FDQuery.Params.ParamByName('VICMSDESON').AsFMTBCD:= Self.Vicmsdeson;
      FDQuery.Params.ParamByName('VICMSOP').AsFMTBCD:= Self.Vicmsop;
      FDQuery.Params.ParamByName('PDIF').AsFMTBCD:= Self.Pdif;
      FDQuery.Params.ParamByName('VICMSDIF').AsFMTBCD:= Self.Vicmsdif;
      FDQuery.Params.ParamByName('VBCFCP').AsFMTBCD:= Self.Vbcfcp;
      FDQuery.Params.ParamByName('PFCP').AsFMTBCD:= Self.Pfcp;
      FDQuery.Params.ParamByName('VFCP').AsFMTBCD:= Self.Vfcp;
      FDQuery.Params.ParamByName('VBCFCPST').AsFMTBCD:= Self.Vbcfcpst;
      FDQuery.Params.ParamByName('PFCPST').AsFMTBCD:= Self.Pfcpst;
      FDQuery.Params.ParamByName('VFCPST').AsFMTBCD:= Self.Vfcpst;
      FDQuery.Params.ParamByName('VBCFCPSTRET').AsFMTBCD:= Self.Vbcfcpstret;
      FDQuery.Params.ParamByName('PFCPSTRET').AsFMTBCD:= Self.Pfcpstret;
      FDQuery.Params.ParamByName('VFCPSTRET').AsFMTBCD:= Self.Vfcpstret;
      FDQuery.Params.ParamByName('PST').AsFMTBCD:= Self.Pst;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('ICMS erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
