unit Ncm;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  System.Math;

type
  TNcm = class(TModel)
  private
    FNCM: String;
    FNACIONAL: Extended;
    FIMPORTADO: Extended;
    FESTADUAL: Extended;
    FMUNICIPAL: Extended;

  public
    constructor Create();
    function save(): Boolean;

    class function find(ncm: string): TNcm;
    class function ncmToVtottrib(ncm: string; Vprod: Extended): Extended;

    property Ncm: String  read FNCM write FNCM;
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
  Self.Table:= 'NCMS';
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

function TNcm.save: Boolean;
const
  FSql: string =
  'UPDATE OR INSERT INTO NCMS ( ' +
  '  NCM,                       ' +
  '  NACIONAL,                  ' +
  '  IMPORTADO,                 ' +
  '  ESTADUAL,                  ' +
  '  MUNICIPAL)                 ' +
  'VALUES (                     ' +
  '  :NCM,                      ' +
  '  :NACIONAL,                 ' +
  '  :IMPORTADO,                ' +
  '  :ESTADUAL,                 ' +
  '  :MUNICIPAL) MATCHING (NCM) ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('NCM').DataType:= ftString;
      FDQuery.Params.ParamByName('NACIONAL').DataType:= ftExtended;
      FDQuery.Params.ParamByName('IMPORTADO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('ESTADUAL').DataType:= ftExtended;
      FDQuery.Params.ParamByName('MUNICIPAL').DataType:= ftExtended;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('NCM').AsString:= Self.Ncm;
      FDQuery.Params.ParamByName('NACIONAL').AsExtended:= Self.Nacional;
      FDQuery.Params.ParamByName('IMPORTADO').AsExtended:= Self.Importado;
      FDQuery.Params.ParamByName('ESTADUAL').AsExtended:= Self.Estadual;
      FDQuery.Params.ParamByName('MUNICIPAL').AsExtended:= Self.Municipal;
      FDQuery.ExecSQL();
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao gravar dados do ncm. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
