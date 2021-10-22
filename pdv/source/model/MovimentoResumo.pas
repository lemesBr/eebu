
unit MovimentoResumo;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TMovimentoResumo = class(TModel)
  private
    FEMPRESA_ID: String;
    FMOVIMENTO_ID: String;
    FTPAG: String;
    FCALCULADO: Extended;
    FDECLARADO: Extended;

  public
    class function findByMovimento(MovimentoId: string): TObjectList<TMovimentoResumo>;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property MovimentoId: String  read FMOVIMENTO_ID write FMOVIMENTO_ID;
    property Tpag: String  read FTPAG write FTPAG;
    property Calculado: Extended  read FCALCULADO write FCALCULADO;
    property Declarado: Extended  read FDECLARADO write FDECLARADO;

  end;

implementation

uses
  AuthService;

{ TMovimentoResumo }

class function TMovimentoResumo.findByMovimento(
  MovimentoId: string): TObjectList<TMovimentoResumo>;
const
  FSql: string =
  'SELECT * FROM VIEW_MOVIMENTO_RESUMOS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (MOVIMENTO_ID = :MOVIMENTO_ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('MOVIMENTO_ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Params.ParamByName('MOVIMENTO_ID').AsString:= MovimentoId;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TObjectList<TMovimentoResumo>.Create;
        FDQuery.First();
        while not FDQuery.Eof do
        begin
          Result.Add(TMovimentoResumo.Create);
          Result.Last.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
          Result.Last.MovimentoId:= FDQuery.FieldByName('MOVIMENTO_ID').AsString;
          Result.Last.Tpag:= FDQuery.FieldByName('TPAG').AsString;
          Result.Last.Calculado:= FDQuery.FieldByName('CALCULADO').AsExtended;
          Result.Last.Declarado:= FDQuery.FieldByName('DECLARADO').AsExtended;
          FDQuery.Next();
        end;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
