unit ViewSped0150;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, Pessoa, FireDAC.Comp.Client,
  Data.DB;

type
  TViewSped0150 = class(TModel)
  private
    FPESSOA_ID: String;
    FPESSOA: TPessoa;

    function getPessoa: TPessoa;
  public
    destructor Destroy; override;
    class function list(EmpresaId, vReferente: string): TObjectList<TViewSped0150>;

    property PessoaId: String  read FPESSOA_ID write FPESSOA_ID;
    property Pessoa: TPessoa read getPessoa;
  end;

implementation

{ TViewSped0150 }

destructor TViewSped0150.Destroy;
begin
  if Assigned(Self.FPESSOA) then FreeAndNil(Self.FPESSOA);

  inherited;
end;

function TViewSped0150.getPessoa: TPessoa;
begin
  if not Assigned(Self.FPESSOA) then
    Self.FPESSOA:= TPessoa.find(Self.PessoaId);

  Result:= Self.FPESSOA;
end;

class function TViewSped0150.list(EmpresaId,
  vReferente: string): TObjectList<TViewSped0150>;
const
  FSql: string =
  'SELECT W.PESSOA_ID FROM VIEW_SPED_0150 W ' +
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
        Result:= TObjectList<TViewSped0150>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TViewSped0150.Create);
          Result.Last.PessoaId:= FDQuery.FieldByName('PESSOA_ID').AsString;
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
