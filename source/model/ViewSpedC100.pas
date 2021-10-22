unit ViewSpedC100;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, Nfe, FireDAC.Comp.Client,
  Data.DB;

type
  TViewSpedC100 = class(TModel)
  private
    FNFE_ID: String;
    FNFE: TNfe;

    function getNfe: TNfe;
  public
    destructor Destroy; override;
    class function list(EmpresaId, vReferente: string): TObjectList<TViewSpedC100>;

    property NfeId: String  read FNFE_ID write FNFE_ID;
    property Nfe: TNfe read getNfe;
  end;

implementation

{ TViewSpedC100 }

destructor TViewSpedC100.Destroy;
begin
  if Assigned(Self.FNFE) then FreeAndNil(Self.FNFE);

  inherited;
end;

function TViewSpedC100.getNfe: TNfe;
begin
  if not Assigned(Self.FNFE) then
    Self.FNFE:= TNfe.find(Self.NfeId);

  Result:= Self.FNFE;
end;

class function TViewSpedC100.list(EmpresaId,
  vReferente: string): TObjectList<TViewSpedC100>;
const
  FSql: string =
  'SELECT W.NFE_ID FROM VIEW_SPED_C100 W ' +
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
        Result:= TObjectList<TViewSpedC100>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TViewSpedC100.Create);
          Result.Last.NfeId:= FDQuery.FieldByName('NFE_ID').AsString;
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
