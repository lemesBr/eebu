unit Ncm;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  System.Math;

type
  TNcm = class(TModel)
  private
    FNCM: String;
    FDESCRICAO: String;
    FNACIONAL: Extended;
    FIMPORTADO: Extended;
    FESTADUAL: Extended;
    FMUNICIPAL: Extended;

  protected
    function store(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    class function find(ncm: string): TNcm;
    class function list(search: string): TObjectList<TNcm>; overload;
    class procedure list(search: string; DataSet: TFDMemTable); overload;
    class function removeAll(): Boolean;
    class function ncmToVtottrib(ncm: string; Vprod: Extended): Extended;

    property Ncm: String  read FNCM write FNCM;
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    property Nacional: Extended  read FNACIONAL write FNACIONAL;
    property Importado: Extended  read FIMPORTADO write FIMPORTADO;
    property Estadual: Extended  read FESTADUAL write FESTADUAL;
    property Municipal: Extended  read FMUNICIPAL write FMUNICIPAL;

  end;

implementation

uses
  Helper;

{ TNcm }

constructor TNcm.Create;
begin
  Self.Table:= 'NCM';
end;

destructor TNcm.Destroy;
begin

  inherited;
end;

class function TNcm.find(ncm: string): TNcm;
const
  FSql: string = 'SELECT * FROM NCM WHERE (NCM = :NCM)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('NCM').DataType:= ftWideString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('NCM').AsString:= ncm;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TNcm.Create;
        Result.Ncm:= FDQuery.FieldByName('NCM').AsString;
        Result.Descricao:= FDQuery.FieldByName('DESCRICAO').AsString;
        Result.Nacional:= FDQuery.FieldByName('NACIONAL').AsExtended;
        Result.Importado:= FDQuery.FieldByName('IMPORTADO').AsExtended;
        Result.Estadual:= FDQuery.FieldByName('ESTADUAL').AsExtended;
        Result.Municipal:= FDQuery.FieldByName('MUNICIPAL').AsExtended;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TNcm.list(search: string): TObjectList<TNcm>;
const
  FSql: string =
  'SELECT N.* FROM NCM N ' +
  'WHERE ((N.NCM = :NCM) OR (N.DESCRICAO LIKE :SEARCH)) ' +
  'ORDER BY N.DESCRICAO';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('NCM').DataType:= ftString;
      FDQuery.Params.ParamByName('SEARCH').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('NCM').AsString:= search;
      FDQuery.Params.ParamByName('SEARCH').AsString:= '%' + search + '%';
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TNcm>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TNcm.Create);
          Result.Last.Ncm:= FDQuery.FieldByName('NCM').AsString;
          Result.Last.Descricao:= FDQuery.FieldByName('DESCRICAO').AsString;
          Result.Last.Nacional:= FDQuery.FieldByName('NACIONAL').AsExtended;
          Result.Last.Importado:= FDQuery.FieldByName('IMPORTADO').AsExtended;
          Result.Last.Estadual:= FDQuery.FieldByName('ESTADUAL').AsExtended;
          Result.Last.Municipal:= FDQuery.FieldByName('MUNICIPAL').AsExtended;
          FDQuery.Next;
        end;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class procedure TNcm.list(search: string; DataSet: TFDMemTable);
var
  VList: TObjectList<TNcm>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  VList:= TNcm.list(search);
  if Assigned(VList) then
  begin
    for I := 0 to Pred(VList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('NCM').AsString:= VList.Items[I].Ncm;
      DataSet.FieldByName('DESCRICAO').AsString:= VList.Items[I].Descricao;
      DataSet.FieldByName('NACIONAL').AsExtended:= VList.Items[I].Nacional;
      DataSet.FieldByName('IMPORTADO').AsExtended:= VList.Items[I].Importado;
      DataSet.FieldByName('ESTADUAL').AsExtended:= VList.Items[I].Estadual;
      DataSet.FieldByName('MUNICIPAL').AsExtended:= VList.Items[I].Municipal;
      DataSet.Post;
    end;
    FreeAndNil(VList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TNcm.ncmToVtottrib(ncm: string; Vprod: Extended): Extended;
var
  v_ncm: TNcm;
begin
  Result:= 0;
  try
    v_ncm:= TNcm.find(ncm);
    if Assigned(v_ncm) then
      Result:= THelper.TruncateValue(SimpleRoundTo((v_ncm.Nacional * Vprod) / 100, -6), 2);
  finally
    if Assigned(v_ncm) then FreeAndNil(v_ncm);
  end;
end;

class function TNcm.removeAll: Boolean;
const
  FSql: string = 'DELETE FROM NCM';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Prepare;
      FDQuery.ExecSQL;
    except
      Result:= False;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNcm.save: Boolean;
begin
  Result:= inherited;
end;

function TNcm.store: Boolean;
const
  FSql: string =
  'INSERT INTO NCM (' +
  '  NCM,           ' +
  '  DESCRICAO,     ' +
  '  NACIONAL,      ' +
  '  IMPORTADO,     ' +
  '  ESTADUAL,      ' +
  '  MUNICIPAL)     ' +
  'VALUES (         ' +
  '  :NCM,          ' +
  '  :DESCRICAO,    ' +
  '  :NACIONAL,     ' +
  '  :IMPORTADO,    ' +
  '  :ESTADUAL,     ' +
  '  :MUNICIPAL)    ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('NCM').DataType:= ftWideString;
      FDQuery.Params.ParamByName('DESCRICAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('NACIONAL').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('IMPORTADO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('ESTADUAL').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('MUNICIPAL').DataType:= ftFMTBcd;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('NCM').AsString:= Self.Ncm;
      FDQuery.Params.ParamByName('DESCRICAO').AsString:= Self.Descricao;
      FDQuery.Params.ParamByName('NACIONAL').AsFMTBCD:= Self.Nacional;
      FDQuery.Params.ParamByName('IMPORTADO').AsFMTBCD:= Self.Importado;
      FDQuery.Params.ParamByName('ESTADUAL').AsFMTBCD:= Self.Estadual;
      FDQuery.Params.ParamByName('MUNICIPAL').AsFMTBCD:= Self.Municipal;
      FDQuery.ExecSQL;
    except
      Result:= False;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
