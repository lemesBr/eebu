unit ConfiguracaoFiscalCofins;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TConfiguracaoFiscalCofins = class(TModel)
  private
    FEMPRESA_ID: String;
    FCONFIGURACAO_FISCAL_ID: String;
    FCST: String;
    FPCOFINS: Extended;
    FVALIQPROD: Extended;
    FPCOFINSST: Extended;
    FVALIQPRODST: Extended;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    function delete(): Boolean;
    class function find(id: string): TConfiguracaoFiscalCofins;
    class function findByConfiguracaoFiscalId(ConfiguracaoFiscalId: string): TConfiguracaoFiscalCofins;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property ConfiguracaoFiscalId: String  read FCONFIGURACAO_FISCAL_ID write FCONFIGURACAO_FISCAL_ID;
    property Cst: String  read FCST write FCST;
    property Pcofins: Extended  read FPCOFINS write FPCOFINS;
    property Valiqprod: Extended  read FVALIQPROD write FVALIQPROD;
    property Pcofinsst: Extended  read FPCOFINSST write FPCOFINSST;
    property Valiqprodst: Extended  read FVALIQPRODST write FVALIQPRODST;

  end;

implementation

uses
  AuthService;

{ TConfiguracaoFiscalCofins }

constructor TConfiguracaoFiscalCofins.Create;
begin
  Self.Table:= 'CONFIGURACAO_FISCAL_COFINS';
end;

function TConfiguracaoFiscalCofins.delete: Boolean;
const
  FSql: string =
  'UPDATE CONFIGURACAO_FISCAL_COFINS   ' +
  'SET UPDATED_AT = :UPDATED_AT,    ' +
  '    DELETED_AT = :DELETED_AT,    ' +
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
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('DELETED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('DELETED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('falha ao remover configuração fiscal cofins. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TConfiguracaoFiscalCofins.find(
  id: string): TConfiguracaoFiscalCofins;
const
  FSql: string = 'SELECT * FROM CONFIGURACAO_FISCAL_COFINS WHERE (ID = :ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ID').AsString:= id;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TConfiguracaoFiscalCofins.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.ConfiguracaoFiscalId:= FDQuery.FieldByName('CONFIGURACAO_FISCAL_ID').AsString;
        Result.Cst:= FDQuery.FieldByName('CST').AsString;
        Result.Pcofins:= FDQuery.FieldByName('PCOFINS').AsExtended;
        Result.Valiqprod:= FDQuery.FieldByName('VALIQPROD').AsExtended;
        Result.Pcofinsst:= FDQuery.FieldByName('PCOFINSST').AsExtended;
        Result.Valiqprodst:= FDQuery.FieldByName('VALIQPRODST').AsExtended;
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

class function TConfiguracaoFiscalCofins.findByConfiguracaoFiscalId(
  ConfiguracaoFiscalId: string): TConfiguracaoFiscalCofins;
const
  FSql: string =
  'SELECT ID FROM CONFIGURACAO_FISCAL_COFINS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (DELETED_AT IS NULL) ' +
  'AND (CONFIGURACAO_FISCAL_ID = :CONFIGURACAO_FISCAL_ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CONFIGURACAO_FISCAL_ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('CONFIGURACAO_FISCAL_ID').AsString:= ConfiguracaoFiscalId;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
        Result:= TConfiguracaoFiscalCofins.find(FDQuery.FieldByName('ID').AsString);
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TConfiguracaoFiscalCofins.save: Boolean;
begin
  Result:= inherited;
end;

function TConfiguracaoFiscalCofins.store: Boolean;
const
  FSql: string =
  'INSERT INTO CONFIGURACAO_FISCAL_COFINS ( ' +
  '  ID,                                    ' +
  '  EMPRESA_ID,                            ' +
  '  CONFIGURACAO_FISCAL_ID,                ' +
  '  CST,                                   ' +
  '  PCOFINS,                               ' +
  '  VALIQPROD,                             ' +
  '  PCOFINSST,                             ' +
  '  VALIQPRODST,                           ' +
  '  CREATED_AT,                            ' +
  '  UPDATED_AT)                            ' +
  'VALUES (                                 ' +
  '  :ID,                                   ' +
  '  :EMPRESA_ID,                           ' +
  '  :CONFIGURACAO_FISCAL_ID,               ' +
  '  :CST,                                  ' +
  '  :PCOFINS,                              ' +
  '  :VALIQPROD,                            ' +
  '  :PCOFINSST,                            ' +
  '  :VALIQPRODST,                          ' +
  '  :CREATED_AT,                           ' +
  '  :UPDATED_AT)                           ';
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
      FDQuery.Params.ParamByName('CONFIGURACAO_FISCAL_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PCOFINS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALIQPROD').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PCOFINSST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALIQPRODST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('CONFIGURACAO_FISCAL_ID').AsString:= Self.ConfiguracaoFiscalId;
      if (Self.Cst <> EmptyStr) then
        FDQuery.Params.ParamByName('CST').AsString:= Self.Cst;
      FDQuery.Params.ParamByName('PCOFINS').AsFMTBCD:= Self.Pcofins;
      FDQuery.Params.ParamByName('VALIQPROD').AsFMTBCD:= Self.Valiqprod;
      FDQuery.Params.ParamByName('PCOFINSST').AsFMTBCD:= Self.Pcofinsst;
      FDQuery.Params.ParamByName('VALIQPRODST').AsFMTBCD:= Self.Valiqprodst;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
    begin
      Result:= False;
      raise Exception.Create('falha ao inserir configuração fiscal cofins. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TConfiguracaoFiscalCofins.update: Boolean;
const
  FSql: string =
  'UPDATE CONFIGURACAO_FISCAL_COFINS ' +
  'SET CST = :CST,                   ' +
  '    PCOFINS = :PCOFINS,           ' +
  '    VALIQPROD = :VALIQPROD,       ' +
  '    PCOFINSST = :PCOFINSST,       ' +
  '    VALIQPRODST = :VALIQPRODST,   ' +
  '    UPDATED_AT = :UPDATED_AT,     ' +
  '    SYNCHRONIZED = :SYNCHRONIZED  ' +
  'WHERE (ID = :ID)                  ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PCOFINS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALIQPROD').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PCOFINSST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALIQPRODST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.Cst <> EmptyStr) then
        FDQuery.Params.ParamByName('CST').AsString:= Self.Cst;
      FDQuery.Params.ParamByName('PCOFINS').AsFMTBCD:= Self.Pcofins;
      FDQuery.Params.ParamByName('VALIQPROD').AsFMTBCD:= Self.Valiqprod;
      FDQuery.Params.ParamByName('PCOFINSST').AsFMTBCD:= Self.Pcofinsst;
      FDQuery.Params.ParamByName('VALIQPRODST').AsFMTBCD:= Self.Valiqprodst;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
    begin
      Result:= False;
      raise Exception.Create('falha ao atualizar configuração fiscal cofins. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
