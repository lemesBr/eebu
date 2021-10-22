unit NfeTotalRettrib;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TNfeTotalRettrib = class(TModel)
  private
    FEMPRESA_ID: String;
    FNFE_ID: String;
    FVRETPIS: Extended;
    FVRETCOFINS: Extended;
    FVRETCSLL: Extended;
    FVBCIRRF: Extended;
    FVIRRF: Extended;
    FVBCRETPREV: Extended;
    FVRETPREV: Extended;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function findByNfeId(NfeId: string): TNfeTotalRettrib;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeId: String  read FNFE_ID write FNFE_ID;
    property Vretpis: Extended  read FVRETPIS write FVRETPIS;
    property Vretcofins: Extended  read FVRETCOFINS write FVRETCOFINS;
    property Vretcsll: Extended  read FVRETCSLL write FVRETCSLL;
    property Vbcirrf: Extended  read FVBCIRRF write FVBCIRRF;
    property Virrf: Extended  read FVIRRF write FVIRRF;
    property Vbcretprev: Extended  read FVBCRETPREV write FVBCRETPREV;
    property Vretprev: Extended  read FVRETPREV write FVRETPREV;

  end;

implementation

uses
  AuthService;



{ TNfeTotalRettrib }

constructor TNfeTotalRettrib.Create;
begin
  Self.Table:= 'NFE_TOTAL_RETTRIB';
end;

class function TNfeTotalRettrib.findByNfeId(NfeId: string): TNfeTotalRettrib;
const
  FSql: string =
  'SELECT * FROM NFE_TOTAL_RETTRIB WHERE (NFE_ID = :NFE_ID)' +
  ' AND (DELETED_AT IS NULL)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('NFE_ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('NFE_ID').AsString:= NfeId;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TNfeTotalRettrib.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.NfeId:= FDQuery.FieldByName('NFE_ID').AsString;
        Result.Vretpis:= FDQuery.FieldByName('VRETPIS').AsExtended;
        Result.Vretcofins:= FDQuery.FieldByName('VRETCOFINS').AsExtended;
        Result.Vretcsll:= FDQuery.FieldByName('VRETCSLL').AsExtended;
        Result.Vbcirrf:= FDQuery.FieldByName('VBCIRRF').AsExtended;
        Result.Virrf:= FDQuery.FieldByName('VIRRF').AsExtended;
        Result.Vbcretprev:= FDQuery.FieldByName('VBCRETPREV').AsExtended;
        Result.Vretprev:= FDQuery.FieldByName('VRETPREV').AsExtended;
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

function TNfeTotalRettrib.save: Boolean;
begin
  Result:= inherited;
end;

function TNfeTotalRettrib.store: Boolean;
const
  FSql: string =
  'INSERT INTO NFE_TOTAL_RETTRIB (' +
  '  ID,                          ' +
  '  EMPRESA_ID,                  ' +
  '  NFE_ID,                      ' +
  '  VRETPIS,                     ' +
  '  VRETCOFINS,                  ' +
  '  VRETCSLL,                    ' +
  '  VBCIRRF,                     ' +
  '  VIRRF,                       ' +
  '  VBCRETPREV,                  ' +
  '  VRETPREV,                    ' +
  '  CREATED_AT,                  ' +
  '  UPDATED_AT)                  ' +
  'VALUES (                       ' +
  '  :ID,                         ' +
  '  :EMPRESA_ID,                 ' +
  '  :NFE_ID,                     ' +
  '  :VRETPIS,                    ' +
  '  :VRETCOFINS,                 ' +
  '  :VRETCSLL,                   ' +
  '  :VBCIRRF,                    ' +
  '  :VIRRF,                      ' +
  '  :VBCRETPREV,                 ' +
  '  :VRETPREV,                   ' +
  '  :CREATED_AT,                 ' +
  '  :UPDATED_AT)                 ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NFE_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('VRETPIS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VRETCOFINS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VRETCSLL').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBCIRRF').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VIRRF').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBCRETPREV').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VRETPREV').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NFE_ID').AsString:= Self.NfeId;
      FDQuery.Params.ParamByName('VRETPIS').AsFMTBCD:= Self.Vretpis;
      FDQuery.Params.ParamByName('VRETCOFINS').AsFMTBCD:= Self.Vretcofins;
      FDQuery.Params.ParamByName('VRETCSLL').AsFMTBCD:= Self.Vretcsll;
      FDQuery.Params.ParamByName('VBCIRRF').AsFMTBCD:= Self.Vbcirrf;
      FDQuery.Params.ParamByName('VIRRF').AsFMTBCD:= Self.Virrf;
      FDQuery.Params.ParamByName('VBCRETPREV').AsFMTBCD:= Self.Vbcretprev;
      FDQuery.Params.ParamByName('VRETPREV').AsFMTBCD:= Self.Vretprev;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('TOTAL RETTRIB erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeTotalRettrib.update: Boolean;
const
  FSql: string =
  'UPDATE NFE_TOTAL_RETTRIB         ' +
  'SET VRETPIS = :VRETPIS,          ' +
  '    VRETCOFINS = :VRETCOFINS,    ' +
  '    VRETCSLL = :VRETCSLL,        ' +
  '    VBCIRRF = :VBCIRRF,          ' +
  '    VIRRF = :VIRRF,              ' +
  '    VBCRETPREV = :VBCRETPREV,    ' +
  '    VRETPREV = :VRETPREV,        ' +
  '    UPDATED_AT = :UPDATED_AT,    ' +
  '    SYNCHRONIZED = :SYNCHRONIZED ' +
  'WHERE (ID = :ID)                 ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('VRETPIS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VRETCOFINS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VRETCSLL').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBCIRRF').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VIRRF').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBCRETPREV').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VRETPREV').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('VRETPIS').AsFMTBCD:= Self.Vretpis;
      FDQuery.Params.ParamByName('VRETCOFINS').AsFMTBCD:= Self.Vretcofins;
      FDQuery.Params.ParamByName('VRETCSLL').AsFMTBCD:= Self.Vretcsll;
      FDQuery.Params.ParamByName('VBCIRRF').AsFMTBCD:= Self.Vbcirrf;
      FDQuery.Params.ParamByName('VIRRF').AsFMTBCD:= Self.Virrf;
      FDQuery.Params.ParamByName('VBCRETPREV').AsFMTBCD:= Self.Vbcretprev;
      FDQuery.Params.ParamByName('VRETPREV').AsFMTBCD:= Self.Vretprev;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('TOTAL RETTRIB erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
