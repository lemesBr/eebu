unit ViewCfIcms;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TViewCfIcms = class(TModel)
  private
    FUF_DESTINO: String;
    FCFOP: String;
    FORIG: String;
    FCST: String;
    FCSOSN: String;
    FMODBC: String;
    FPREDBC: Extended;
    FPICMS: Extended;
    FMODBCST: String;
    FPMVAST: Extended;
    FPREDBCST: Extended;
    FPICMSST: Extended;
    FMOTDESICMS: String;
    FPCREDSN: Extended;
    FPDIF: Extended;
    FPFCP: Extended;
    FPFCPST: Extended;
    FPFCPSTRET: Extended;
    FPFCPUFDEST: Extended;
    FPICMSUFDEST: Extended;
    FPICMSINTER: Extended;
    FPICMSINTERPART: Extended;

  public
    class function find(OperacaoFiscalId, GrupoTributarioId, Ufdestino: string): TViewCfIcms;

    property UfDestino: String  read FUF_DESTINO write FUF_DESTINO;
    property Cfop: String  read FCFOP write FCFOP;
    property Orig: String  read FORIG write FORIG;
    property Cst: String  read FCST write FCST;
    property Csosn: String  read FCSOSN write FCSOSN;
    property Modbc: String  read FMODBC write FMODBC;
    property Predbc: Extended  read FPREDBC write FPREDBC;
    property Picms: Extended  read FPICMS write FPICMS;
    property Modbcst: String  read FMODBCST write FMODBCST;
    property Pmvast: Extended  read FPMVAST write FPMVAST;
    property Predbcst: Extended  read FPREDBCST write FPREDBCST;
    property Picmsst: Extended  read FPICMSST write FPICMSST;
    property Motdesicms: String  read FMOTDESICMS write FMOTDESICMS;
    property Pcredsn: Extended  read FPCREDSN write FPCREDSN;
    property Pdif: Extended  read FPDIF write FPDIF;
    property Pfcp: Extended  read FPFCP write FPFCP;
    property Pfcpst: Extended  read FPFCPST write FPFCPST;
    property Pfcpstret: Extended  read FPFCPSTRET write FPFCPSTRET;
    property Pfcpufdest: Extended  read FPFCPUFDEST write FPFCPUFDEST;
    property Picmsufdest: Extended  read FPICMSUFDEST write FPICMSUFDEST;
    property Picmsinter: Extended  read FPICMSINTER write FPICMSINTER;
    property Picmsinterpart: Extended  read FPICMSINTERPART write FPICMSINTERPART;

  end;

implementation

uses
  AuthService;

{ TViewCfIcms }

class function TViewCfIcms.find(OperacaoFiscalId, GrupoTributarioId,
  Ufdestino: string): TViewCfIcms;
const
  FSql: string =
  'SELECT * FROM VIEW_CF_ICMS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (OPERACAO_FISCAL_ID = :OPERACAO_FISCAL_ID) ' +
  'AND (GRUPO_TRIBUTARIO_ID = :GRUPO_TRIBUTARIO_ID) ' +
  'AND (UF_DESTINO = :UF_DESTINO)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('OPERACAO_FISCAL_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('GRUPO_TRIBUTARIO_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('UF_DESTINO').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('OPERACAO_FISCAL_ID').AsString:= OperacaoFiscalId;
      FDQuery.Params.ParamByName('GRUPO_TRIBUTARIO_ID').AsString:= GrupoTributarioId;
      FDQuery.Params.ParamByName('UF_DESTINO').AsString:= Ufdestino;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TViewCfIcms.Create;
        Result.UfDestino:= FDQuery.FieldByName('UF_DESTINO').AsString;
        Result.Cfop:= FDQuery.FieldByName('CFOP').AsString;
        Result.Orig:= FDQuery.FieldByName('ORIG').AsString;
        Result.Cst:= FDQuery.FieldByName('CST').AsString;
        Result.Csosn:= FDQuery.FieldByName('CSOSN').AsString;
        Result.Modbc:= FDQuery.FieldByName('MODBC').AsString;
        Result.Predbc:= FDQuery.FieldByName('PREDBC').AsExtended;
        Result.Picms:= FDQuery.FieldByName('PICMS').AsExtended;
        Result.Modbcst:= FDQuery.FieldByName('MODBCST').AsString;
        Result.Pmvast:= FDQuery.FieldByName('PMVAST').AsExtended;
        Result.Predbcst:= FDQuery.FieldByName('PREDBCST').AsExtended;
        Result.Picmsst:= FDQuery.FieldByName('PICMSST').AsExtended;
        Result.Motdesicms:= FDQuery.FieldByName('MOTDESICMS').AsString;
        Result.Pcredsn:= FDQuery.FieldByName('PCREDSN').AsExtended;
        Result.Pdif:= FDQuery.FieldByName('PDIF').AsExtended;
        Result.Pfcp:= FDQuery.FieldByName('PFCP').AsExtended;
        Result.Pfcpst:= FDQuery.FieldByName('PFCPST').AsExtended;
        Result.Pfcpstret:= FDQuery.FieldByName('PFCPSTRET').AsExtended;
        Result.Pfcpufdest:= FDQuery.FieldByName('PFCPUFDEST').AsExtended;
        Result.Picmsufdest:= FDQuery.FieldByName('PICMSUFDEST').AsExtended;
        Result.Picmsinter:= FDQuery.FieldByName('PICMSINTER').AsExtended;
        Result.Picmsinterpart:= FDQuery.FieldByName('PICMSINTERPART').AsExtended;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
