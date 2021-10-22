unit NfeDetIcmsUfDest;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TNfeDetIcmsUfDest = class(TModel)
  private
    FEMPRESA_ID: String;
    FNFE_DET_ID: String;
    FVBCUFDEST: Extended;
    FVBCFCPUFDEST: Extended;
    FPFCPUFDEST: Extended;
    FPICMSUFDEST: Extended;
    FPICMSINTER: Extended;
    FPICMSINTERPART: Extended;
    FVFCPUFDEST: Extended;
    FVICMSUFDEST: Extended;
    FVICMSUFREMET: Extended;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function findByNfeDetId(NfeDetId: string): TNfeDetIcmsUfDest;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeDetId: String  read FNFE_DET_ID write FNFE_DET_ID;
    property Vbcufdest: Extended  read FVBCUFDEST write FVBCUFDEST;
    property Vbcfcpufdest: Extended  read FVBCFCPUFDEST write FVBCFCPUFDEST;
    property Pfcpufdest: Extended  read FPFCPUFDEST write FPFCPUFDEST;
    property Picmsufdest: Extended  read FPICMSUFDEST write FPICMSUFDEST;
    property Picmsinter: Extended  read FPICMSINTER write FPICMSINTER;
    property Picmsinterpart: Extended  read FPICMSINTERPART write FPICMSINTERPART;
    property Vfcpufdest: Extended  read FVFCPUFDEST write FVFCPUFDEST;
    property Vicmsufdest: Extended  read FVICMSUFDEST write FVICMSUFDEST;
    property Vicmsufremet: Extended  read FVICMSUFREMET write FVICMSUFREMET;

  end;

implementation

uses
  AuthService;

{ TNfeDetIcmsUfDest }

constructor TNfeDetIcmsUfDest.Create;
begin
  Self.Table:= 'NFE_DET_ICMS_UF_DEST';
end;

class function TNfeDetIcmsUfDest.findByNfeDetId(
  NfeDetId: string): TNfeDetIcmsUfDest;
const
  FSql: string =
  'SELECT * FROM NFE_DET_ICMS_UF_DEST WHERE (NFE_DET_ID = :NFE_DET_ID)' +
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
        Result:= TNfeDetIcmsUfDest.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.NfeDetId:= FDQuery.FieldByName('NFE_DET_ID').AsString;
        Result.Vbcufdest:= FDQuery.FieldByName('VBCUFDEST').AsExtended;
        Result.Vbcfcpufdest:= FDQuery.FieldByName('VBCFCPUFDEST').AsExtended;
        Result.Pfcpufdest:= FDQuery.FieldByName('PFCPUFDEST').AsExtended;
        Result.Picmsufdest:= FDQuery.FieldByName('PICMSUFDEST').AsExtended;
        Result.Picmsinter:= FDQuery.FieldByName('PICMSINTER').AsExtended;
        Result.Picmsinterpart:= FDQuery.FieldByName('PICMSINTERPART').AsExtended;
        Result.Vfcpufdest:= FDQuery.FieldByName('VFCPUFDEST').AsExtended;
        Result.Vicmsufdest:= FDQuery.FieldByName('VICMSUFDEST').AsExtended;
        Result.Vicmsufremet:= FDQuery.FieldByName('VICMSUFREMET').AsExtended;
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

function TNfeDetIcmsUfDest.save: Boolean;
begin
  Result:= inherited;
end;

function TNfeDetIcmsUfDest.store: Boolean;
const
  FSql: string =
  'INSERT INTO NFE_DET_ICMS_UF_DEST (' +
  '  ID,                             ' +
  '  EMPRESA_ID,                     ' +
  '  NFE_DET_ID,                     ' +
  '  VBCUFDEST,                      ' +
  '  VBCFCPUFDEST,                   ' +
  '  PFCPUFDEST,                     ' +
  '  PICMSUFDEST,                    ' +
  '  PICMSINTER,                     ' +
  '  PICMSINTERPART,                 ' +
  '  VICMSUFDEST,                    ' +
  '  VFCPUFDEST,                     ' +
  '  VICMSUFREMET,                   ' +
  '  CREATED_AT,                     ' +
  '  UPDATED_AT)                     ' +
  'VALUES (                          ' +
  '  :ID,                            ' +
  '  :EMPRESA_ID,                    ' +
  '  :NFE_DET_ID,                    ' +
  '  :VBCUFDEST,                     ' +
  '  :VBCFCPUFDEST,                  ' +
  '  :PFCPUFDEST,                    ' +
  '  :PICMSUFDEST,                   ' +
  '  :PICMSINTER,                    ' +
  '  :PICMSINTERPART,                ' +
  '  :VICMSUFDEST,                   ' +
  '  :VFCPUFDEST,                    ' +
  '  :VICMSUFREMET,                  ' +
  '  :CREATED_AT,                    ' +
  '  :UPDATED_AT)                    ';
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
      FDQuery.Params.ParamByName('VBCUFDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBCFCPUFDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PFCPUFDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PICMSUFDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PICMSINTER').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PICMSINTERPART').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VFCPUFDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMSUFDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMSUFREMET').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NFE_DET_ID').AsString:= Self.NfeDetId;
      FDQuery.Params.ParamByName('VBCUFDEST').AsFMTBCD:= Self.Vbcufdest;
      FDQuery.Params.ParamByName('VBCFCPUFDEST').AsFMTBCD:= Self.Vbcfcpufdest;
      FDQuery.Params.ParamByName('PFCPUFDEST').AsFMTBCD:= Self.Pfcpufdest;
      FDQuery.Params.ParamByName('PICMSUFDEST').AsFMTBCD:= Self.Picmsufdest;
      FDQuery.Params.ParamByName('PICMSINTER').AsFMTBCD:= Self.Picmsinter;
      FDQuery.Params.ParamByName('PICMSINTERPART').AsFMTBCD:= Self.Picmsinterpart;
      FDQuery.Params.ParamByName('VFCPUFDEST').AsFMTBCD:= Self.Vfcpufdest;
      FDQuery.Params.ParamByName('VICMSUFDEST').AsFMTBCD:= Self.Vicmsufdest;
      FDQuery.Params.ParamByName('VICMSUFREMET').AsFMTBCD:= Self.Vicmsufremet;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('ICMS UF DEST erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeDetIcmsUfDest.update: Boolean;
const
  FSql: string =
  'UPDATE NFE_DET_ICMS_UF_DEST          ' +
  'SET VBCUFDEST = :VBCUFDEST,          ' +
  '    VBCFCPUFDEST = :VBCFCPUFDEST,    ' +
  '    PFCPUFDEST = :PFCPUFDEST,        ' +
  '    PICMSUFDEST = :PICMSUFDEST,      ' +
  '    PICMSINTER = :PICMSINTER,        ' +
  '    PICMSINTERPART = :PICMSINTERPART,' +
  '    VICMSUFDEST = :VICMSUFDEST,      ' +
  '    VFCPUFDEST = :VFCPUFDEST,        ' +
  '    VICMSUFREMET = :VICMSUFREMET,    ' +
  '    UPDATED_AT = :UPDATED_AT,        ' +
  '    SYNCHRONIZED = :SYNCHRONIZED     ' +
  'WHERE (ID = :ID)                     ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('VBCUFDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VBCFCPUFDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PFCPUFDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PICMSUFDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PICMSINTER').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PICMSINTERPART').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VFCPUFDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMSUFDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VICMSUFREMET').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('VBCUFDEST').AsFMTBCD:= Self.Vbcufdest;
      FDQuery.Params.ParamByName('VBCFCPUFDEST').AsFMTBCD:= Self.Vbcfcpufdest;
      FDQuery.Params.ParamByName('PFCPUFDEST').AsFMTBCD:= Self.Pfcpufdest;
      FDQuery.Params.ParamByName('PICMSUFDEST').AsFMTBCD:= Self.Picmsufdest;
      FDQuery.Params.ParamByName('PICMSINTER').AsFMTBCD:= Self.Picmsinter;
      FDQuery.Params.ParamByName('PICMSINTERPART').AsFMTBCD:= Self.Picmsinterpart;
      FDQuery.Params.ParamByName('VFCPUFDEST').AsFMTBCD:= Self.Vfcpufdest;
      FDQuery.Params.ParamByName('VICMSUFDEST').AsFMTBCD:= Self.Vicmsufdest;
      FDQuery.Params.ParamByName('VICMSUFREMET').AsFMTBCD:= Self.Vicmsufremet;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('ICMS UF DEST erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
