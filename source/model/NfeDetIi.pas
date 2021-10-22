unit NfeDetIi;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TNfeDetIi = class(TModel)
  private
    FEMPRESA_ID: String;
    FNFE_DET_ID: String;
    FVBC: Extended;
    FVDESPADU: Extended;
    FVII: Extended;
    FVIOF: Extended;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function findByNfeDetId(NfeDetId: string): TNfeDetIi;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeDetId: String  read FNFE_DET_ID write FNFE_DET_ID;
    property Vbc: Extended  read FVBC write FVBC;
    property Vdespadu: Extended  read FVDESPADU write FVDESPADU;
    property Vii: Extended  read FVII write FVII;
    property Viof: Extended  read FVIOF write FVIOF;

  end;

implementation

uses
  AuthService;

{ TNfeDetIi }

constructor TNfeDetIi.Create;
begin
  Self.Table:= 'NFE_DET_II';
end;

class function TNfeDetIi.findByNfeDetId(NfeDetId: string): TNfeDetIi;
const
  FSql: string =
  'SELECT * FROM NFE_DET_II WHERE (NFE_DET_ID = :NFE_DET_ID)' +
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
        Result:= TNfeDetIi.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.NfeDetId:= FDQuery.FieldByName('NFE_DET_ID').AsString;
        Result.Vbc:= FDQuery.FieldByName('VBC').AsExtended;
        Result.Vdespadu:= FDQuery.FieldByName('VDESPADU').AsExtended;
        Result.Vii:= FDQuery.FieldByName('VII').AsExtended;
        Result.Viof:= FDQuery.FieldByName('VIOF').AsExtended;
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

function TNfeDetIi.save: Boolean;
begin
  Result:= inherited;
end;

function TNfeDetIi.store: Boolean;
const
  FSql: string =
  'INSERT INTO NFE_DET_II (' +
  '  ID,                   ' +
  '  EMPRESA_ID,           ' +
  '  NFE_DET_ID,           ' +
  '  VBC,                  ' +
  '  VDESPADU,             ' +
  '  VII,                  ' +
  '  VIOF,                 ' +
  '  CREATED_AT,           ' +
  '  UPDATED_AT)           ' +
  'VALUES (                ' +
  '  :ID,                  ' +
  '  :EMPRESA_ID,          ' +
  '  :NFE_DET_ID,          ' +
  '  :VBC,                 ' +
  '  :VDESPADU,            ' +
  '  :VII,                 ' +
  '  :VIOF,                ' +
  '  :CREATED_AT,          ' +
  '  :UPDATED_AT)          ';
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
      FDQuery.Params.ParamByName('NFE_DET_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('VBC').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VDESPADU').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VII').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VIOF').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NFE_DET_ID').AsString:= Self.NfeDetId;
      FDQuery.Params.ParamByName('VBC').AsFMTBCD:= Self.Vbc;
      FDQuery.Params.ParamByName('VDESPADU').AsFMTBCD:= Self.Vdespadu;
      FDQuery.Params.ParamByName('VII').AsFMTBCD:= Self.Vii;
      FDQuery.Params.ParamByName('VIOF').AsFMTBCD:= Self.Viof;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('II erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeDetIi.update: Boolean;
const
  FSql: string =
  'UPDATE NFE_DET_II                ' +
  'SET VBC = :VBC,                  ' +
  '    VDESPADU = :VDESPADU,        ' +
  '    VII = :VII,                  ' +
  '    VIOF = :VIOF,                ' +
  '    UPDATED_AT = :UPDATED_AT,    ' +
  '    SYNCHRONIZED = :SYNCHRONIZED ' +
  'WHERE (ID = :ID);                ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('VBC').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VDESPADU').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VII').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VIOF').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('VBC').AsFMTBCD:= Self.Vbc;
      FDQuery.Params.ParamByName('VDESPADU').AsFMTBCD:= Self.Vdespadu;
      FDQuery.Params.ParamByName('VII').AsFMTBCD:= Self.Vii;
      FDQuery.Params.ParamByName('VIOF').AsFMTBCD:= Self.Viof;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('II erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
