unit ViewSped0190;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, Unidade, FireDAC.Comp.Client,
  Data.DB;

type
  TViewSped0190 = class(TModel)
  private
    FUNIDADE_ID: String;
    FUNIDADE: TUnidade;

    function getUnidade: TUnidade;
  public
    destructor Destroy; override;
    class function list(EmpresaId, vReferente: string): TObjectList<TViewSped0190>;

    property UnidadeId: String  read FUNIDADE_ID write FUNIDADE_ID;
    property Unidade: TUnidade read getUnidade;
  end;

implementation

{ TViewSped0190 }

destructor TViewSped0190.Destroy;
begin
  if Assigned(Self.FUNIDADE) then FreeAndNil(Self.FUNIDADE);

  inherited;
end;

function TViewSped0190.getUnidade: TUnidade;
begin
  if not Assigned(Self.FUNIDADE) then
    Self.FUNIDADE:= TUnidade.find(Self.UnidadeId);

  Result:= Self.FUNIDADE;
end;

class function TViewSped0190.list(EmpresaId,
  vReferente: string): TObjectList<TViewSped0190>;
const
  FSql: string =
  'SELECT W.UNIDADE_ID FROM VIEW_SPED_0190 W ' +
  'WHERE (W.EMPRESA_ID = :EMPRESA_ID) AND (W.REFERENTE = :REFERENTE) ';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('REFERENTE').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= EmpresaId;
      FDQuery.Params.ParamByName('REFERENTE').AsString:= vReferente;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TViewSped0190>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TViewSped0190.Create);
          Result.Last.UnidadeId:= FDQuery.FieldByName('UNIDADE_ID').AsString;
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
