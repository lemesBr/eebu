unit ViewCfIpi;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TViewCfIpi = class(TModel)
  private
    FCLENQ: String;
    FCNPJPROD: String;
    FCSELO: String;
    FQSELO: Integer;
    FCENQ: String;
    FCST: String;
    FPIPI: Extended;
    FVUNID: Extended;

  public
    class function find(OperacaoFiscalId, GrupoTributarioId: string): TViewCfIpi;

    property Clenq: String  read FCLENQ write FCLENQ;
    property Cnpjprod: String  read FCNPJPROD write FCNPJPROD;
    property Cselo: String  read FCSELO write FCSELO;
    property Qselo: Integer  read FQSELO write FQSELO;
    property Cenq: String  read FCENQ write FCENQ;
    property Cst: String  read FCST write FCST;
    property Pipi: Extended  read FPIPI write FPIPI;
    property Vunid: Extended  read FVUNID write FVUNID;

  end;

implementation

uses
  AuthService;

{ TViewCfIpi }

class function TViewCfIpi.find(OperacaoFiscalId,
  GrupoTributarioId: string): TViewCfIpi;
const
  FSql: string =
  'SELECT * FROM VIEW_CF_IPI ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (OPERACAO_FISCAL_ID = :OPERACAO_FISCAL_ID) ' +
  'AND (GRUPO_TRIBUTARIO_ID = :GRUPO_TRIBUTARIO_ID)';
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
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('OPERACAO_FISCAL_ID').AsString:= OperacaoFiscalId;
      FDQuery.Params.ParamByName('GRUPO_TRIBUTARIO_ID').AsString:= GrupoTributarioId;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TViewCfIpi.Create;
        Result.Clenq:= FDQuery.FieldByName('CLENQ').AsString;
        Result.Cnpjprod:= FDQuery.FieldByName('CNPJPROD').AsString;
        Result.Cselo:= FDQuery.FieldByName('CSELO').AsString;
        Result.Qselo:= FDQuery.FieldByName('QSELO').AsInteger;
        Result.Cenq:= FDQuery.FieldByName('CENQ').AsString;
        Result.Cst:= FDQuery.FieldByName('CST').AsString;
        Result.Pipi:= FDQuery.FieldByName('PIPI').AsExtended;
        Result.Vunid:= FDQuery.FieldByName('VUNID').AsExtended;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
