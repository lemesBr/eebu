unit ViewCfPis;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TViewCfPis = class(TModel)
  private
    FCST: String;
    FPPIS: Extended;
    FVALIQPROD: Extended;
    FPPISST: Extended;
    FVALIQPRODST: Extended;

  public
    class function find(OperacaoFiscalId, GrupoTributarioId: string): TViewCfPis;

    property Cst: String  read FCST write FCST;
    property Ppis: Extended  read FPPIS write FPPIS;
    property Valiqprod: Extended  read FVALIQPROD write FVALIQPROD;
    property Ppisst: Extended  read FPPISST write FPPISST;
    property Valiqprodst: Extended  read FVALIQPRODST write FVALIQPRODST;

  end;

implementation

uses
  AuthService;

{ TViewCfPis }

class function TViewCfPis.find(OperacaoFiscalId,
  GrupoTributarioId: string): TViewCfPis;
const
  FSql: string =
  'SELECT * FROM VIEW_CF_PIS ' +
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
        Result:= TViewCfPis.Create;
        Result.Cst:= FDQuery.FieldByName('CST').AsString;
        Result.Ppis:= FDQuery.FieldByName('PPIS').AsExtended;
        Result.Valiqprod:= FDQuery.FieldByName('VALIQPROD').AsExtended;
        Result.Ppisst:= FDQuery.FieldByName('PPISST').AsExtended;
        Result.Valiqprodst:= FDQuery.FieldByName('VALIQPRODST').AsExtended;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
