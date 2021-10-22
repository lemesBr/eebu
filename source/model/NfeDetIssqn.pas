unit NfeDetIssqn;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TNfeDetIssqn = class(TModel)
  private
    FEMPRESA_ID: String;
    FNFE_DET_ID: String;
    FVBC: Extended;
    FVALIQ: Extended;
    FVISSQN: Extended;
    FCMUNFG: String;
    FCLISTSERV: String;
    FCSITTRIB: String;
    FVDEDUCAO: Extended;
    FVOUTRO: Extended;
    FVDESCINCOND: Extended;
    FVDESCCOND: Extended;
    FINDISSRET: String;
    FVISSRET: Extended;
    FINDISS: String;
    FCSERVICO: String;
    FCMUN: String;
    FCPAIS: String;
    FNPROCESSO: String;
    FINDINCENTIVO: String;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function findByNfeDetId(NfeDetId: string): TNfeDetIssqn;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeDetId: String  read FNFE_DET_ID write FNFE_DET_ID;
    property Vbc: Extended  read FVBC write FVBC;
    property Valiq: Extended  read FVALIQ write FVALIQ;
    property Vissqn: Extended  read FVISSQN write FVISSQN;
    property Cmunfg: String  read FCMUNFG write FCMUNFG;
    property Clistserv: String  read FCLISTSERV write FCLISTSERV;
    property Csittrib: String  read FCSITTRIB write FCSITTRIB;
    property Vdeducao: Extended  read FVDEDUCAO write FVDEDUCAO;
    property Voutro: Extended  read FVOUTRO write FVOUTRO;
    property Vdescincond: Extended  read FVDESCINCOND write FVDESCINCOND;
    property Vdesccond: Extended  read FVDESCCOND write FVDESCCOND;
    property Indissret: String  read FINDISSRET write FINDISSRET;
    property Vissret: Extended  read FVISSRET write FVISSRET;
    property Indiss: String  read FINDISS write FINDISS;
    property Cservico: String  read FCSERVICO write FCSERVICO;
    property Cmun: String  read FCMUN write FCMUN;
    property Cpais: String  read FCPAIS write FCPAIS;
    property Nprocesso: String  read FNPROCESSO write FNPROCESSO;
    property Indincentivo: String  read FINDINCENTIVO write FINDINCENTIVO;

  end;

implementation

{ TNfeDetIssqn }

constructor TNfeDetIssqn.Create;
begin
  Self.Table:= 'NFE_DET_ISSQN';
end;

class function TNfeDetIssqn.findByNfeDetId(NfeDetId: string): TNfeDetIssqn;
const
  FSql: string =
  'SELECT * FROM NFE_DET_ISSQN WHERE (NFE_DET_ID = :NFE_DET_ID)' +
  ' AND (DELETED_AT IS NULL)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('NFE_DET_ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('NFE_DET_ID').AsString:= NfeDetId;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TNfeDetIssqn.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.NfeDetId:= FDQuery.FieldByName('NFE_DET_ID').AsString;
        Result.Vbc:= FDQuery.FieldByName('VBC').AsExtended;
        Result.Valiq:= FDQuery.FieldByName('VALIQ').AsExtended;
        Result.Vissqn:= FDQuery.FieldByName('VISSQN').AsExtended;
        Result.Cmunfg:= FDQuery.FieldByName('CMUNFG').AsString;
        Result.Clistserv:= FDQuery.FieldByName('CLISTSERV').AsString;
        Result.Csittrib:= FDQuery.FieldByName('CSITTRIB').AsString;
        Result.Vdeducao:= FDQuery.FieldByName('VDEDUCAO').AsExtended;
        Result.Voutro:= FDQuery.FieldByName('VOUTRO').AsExtended;
        Result.Vdescincond:= FDQuery.FieldByName('VDESCINCOND').AsExtended;
        Result.Vdesccond:= FDQuery.FieldByName('VDESCCOND').AsExtended;
        Result.Indissret:= FDQuery.FieldByName('INDISSRET').AsString;
        Result.Vissret:= FDQuery.FieldByName('VISSRET').AsExtended;
        Result.Indiss:= FDQuery.FieldByName('INDISS').AsString;
        Result.Cservico:= FDQuery.FieldByName('CSERVICO').AsString;
        Result.Cmun:= FDQuery.FieldByName('CMUN').AsString;
        Result.Cpais:= FDQuery.FieldByName('CPAIS').AsString;
        Result.Nprocesso:= FDQuery.FieldByName('NPROCESSO').AsString;
        Result.Indincentivo:= FDQuery.FieldByName('INDINCENTIVO').AsString;
        Result.CreatedAt:= FDQuery.FieldByName('CREATED_AT').AsDateTime;
        Result.UpdatedAt:= FDQuery.FieldByName('UPDATED_AT').AsDateTime;
        Result.Synchronized:= FDQuery.FieldByName('SYNCHRONIZED').AsString;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeDetIssqn.save: Boolean;
begin
  Result:= inherited;
end;

function TNfeDetIssqn.store: Boolean;
begin

end;

function TNfeDetIssqn.update: Boolean;
begin

end;

end.
