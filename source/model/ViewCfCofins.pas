unit ViewCfCofins;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TViewCfCofins = class(TModel)
  private
    FCST: String;
    FPCOFINS: Extended;
    FVALIQPROD: Extended;
    FPCOFINSST: Extended;
    FVALIQPRODST: Extended;

  public
    class function find(OperacaoFiscalId, GrupoTributarioId: string): TViewCfCofins;

    property Cst: String  read FCST write FCST;
    property Pcofins: Extended  read FPCOFINS write FPCOFINS;
    property Valiqprod: Extended  read FVALIQPROD write FVALIQPROD;
    property Pcofinsst: Extended  read FPCOFINSST write FPCOFINSST;
    property Valiqprodst: Extended  read FVALIQPRODST write FVALIQPRODST;

  end;

implementation

uses
  AuthService;

{ TViewCfCofins }

class function TViewCfCofins.find(OperacaoFiscalId,
  GrupoTributarioId: string): TViewCfCofins;
const
  FSql: string =
  'SELECT * FROM VIEW_CF_COFINS ' +
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
        Result:= TViewCfCofins.Create;
        Result.Cst:= FDQuery.FieldByName('CST').AsString;
        Result.Pcofins:= FDQuery.FieldByName('PCOFINS').AsExtended;
        Result.Valiqprod:= FDQuery.FieldByName('VALIQPROD').AsExtended;
        Result.Pcofinsst:= FDQuery.FieldByName('PCOFINSST').AsExtended;
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
