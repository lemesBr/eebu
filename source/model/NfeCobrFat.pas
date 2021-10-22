unit NfeCobrFat;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TNfeCobrFat = class(TModel)
  private
    FEMPRESA_ID: String;
    FNFE_ID: String;
    FNFAT: String;
    FVORIG: Extended;
    FVDESC: Extended;
    FVLIQ: Extended;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function findByNfeId(NfeId: string): TNfeCobrFat;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeId: String  read FNFE_ID write FNFE_ID;
    property Nfat: String  read FNFAT write FNFAT;
    property Vorig: Extended  read FVORIG write FVORIG;
    property Vdesc: Extended  read FVDESC write FVDESC;
    property Vliq: Extended  read FVLIQ write FVLIQ;

  end;

implementation

uses
  AuthService;

{ TNfeCobrFat }

constructor TNfeCobrFat.Create;
begin
  Self.Table:= 'NFE_COBR_FAT';
end;

class function TNfeCobrFat.findByNfeId(NfeId: string): TNfeCobrFat;
const
  FSql: string =
  'SELECT * FROM NFE_COBR_FAT WHERE (NFE_ID = :NFE_ID)' +
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
        Result:= TNfeCobrFat.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.NfeId:= FDQuery.FieldByName('NFE_ID').AsString;
        Result.Nfat:= FDQuery.FieldByName('NFAT').AsString;
        Result.Vorig:= FDQuery.FieldByName('VORIG').AsExtended;
        Result.Vdesc:= FDQuery.FieldByName('VDESC').AsExtended;
        Result.Vliq:= FDQuery.FieldByName('VLIQ').AsExtended;
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

function TNfeCobrFat.save: Boolean;
begin
  Result:= inherited;
end;

function TNfeCobrFat.store: Boolean;
const
  FSql: string =
  'INSERT INTO NFE_COBR_FAT (' +
  '  ID,                     ' +
  '  EMPRESA_ID,             ' +
  '  NFE_ID,                 ' +
  '  NFAT,                   ' +
  '  VORIG,                  ' +
  '  VDESC,                  ' +
  '  VLIQ,                   ' +
  '  CREATED_AT,             ' +
  '  UPDATED_AT)             ' +
  'VALUES (                  ' +
  '  :ID,                    ' +
  '  :EMPRESA_ID,            ' +
  '  :NFE_ID,                ' +
  '  :NFAT,                  ' +
  '  :VORIG,                 ' +
  '  :VDESC,                 ' +
  '  :VLIQ,                  ' +
  '  :CREATED_AT,            ' +
  '  :UPDATED_AT)            ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  if (Self.Vorig <= 0) then Exit();
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NFE_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NFAT').DataType:= ftWideString;
      FDQuery.Params.ParamByName('VORIG').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VDESC').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VLIQ').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NFE_ID').AsString:= Self.NfeId;
      FDQuery.Params.ParamByName('NFAT').AsString:= Self.Nfat;
      FDQuery.Params.ParamByName('VORIG').AsFMTBCD:= Self.Vorig;
      FDQuery.Params.ParamByName('VDESC').AsFMTBCD:= Self.Vdesc;
      FDQuery.Params.ParamByName('VLIQ').AsFMTBCD:= Self.Vliq;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: Exception do
      begin
        Result:= False;
        raise Exception.Create('FATURA. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeCobrFat.update: Boolean;
const
  FSql: string =
  'UPDATE NFE_COBR_FAT              ' +
  'SET NFAT = :NFAT,                ' +
  '    VORIG = :VORIG,              ' +
  '    VDESC = :VDESC,              ' +
  '    VLIQ = :VLIQ,                ' +
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
      FDQuery.Params.ParamByName('NFAT').DataType:= ftWideString;
      FDQuery.Params.ParamByName('VORIG').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VDESC').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VLIQ').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('NFAT').AsString:= Self.Nfat;
      FDQuery.Params.ParamByName('VORIG').AsFMTBCD:= Self.Vorig;
      FDQuery.Params.ParamByName('VDESC').AsFMTBCD:= Self.Vdesc;
      FDQuery.Params.ParamByName('VLIQ').AsFMTBCD:= Self.Vliq;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('FATURA. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
