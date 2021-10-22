unit ViewSped0200;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, Item, FireDAC.Comp.Client,
  Data.DB;

type
  TViewSped0200 = class(TModel)
  private
    FITEM_ID: String;
    FITEM: TItem;

    function getItem: TItem;
  public
    destructor Destroy; override;
    class function list(EmpresaId, vReferente: string): TObjectList<TViewSped0200>;

    property ItemId: String  read FITEM_ID write FITEM_ID;
    property Item: TItem read getItem;
  end;

implementation

{ TViewSped0200 }

destructor TViewSped0200.Destroy;
begin
  if Assigned(Self.FITEM) then FreeAndNil(Self.FITEM);

  inherited;
end;

function TViewSped0200.getItem: TItem;
begin
  if not Assigned(Self.FITEM) then
    Self.FITEM:= TItem.find(Self.ItemId);

  Result:= Self.FITEM;
end;

class function TViewSped0200.list(EmpresaId,
  vReferente: string): TObjectList<TViewSped0200>;
const
  FSql: string =
  'SELECT W.ITEM_ID FROM VIEW_SPED_0200 W ' +
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
        Result:= TObjectList<TViewSped0200>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TViewSped0200.Create);
          Result.Last.ItemId:= FDQuery.FieldByName('ITEM_ID').AsString;
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
