unit ConfiguracaoFiscalIpi;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TConfiguracaoFiscalIpi = class(TModel)
  private
    FEMPRESA_ID: String;
    FCONFIGURACAO_FISCAL_ID: String;
    FCLENQ: String;
    FCNPJPROD: String;
    FCSELO: String;
    FQSELO: Integer;
    FCENQ: String;
    FCST: String;
    FPIPI: Extended;
    FVUNID: Extended;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    function delete(): Boolean;
    class function find(id: string): TConfiguracaoFiscalIpi;
    class function findByConfiguracaoFiscalId(ConfiguracaoFiscalId: string): TConfiguracaoFiscalIpi;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property ConfiguracaoFiscalId: String  read FCONFIGURACAO_FISCAL_ID write FCONFIGURACAO_FISCAL_ID;
    property Clenq: String  read FCLENQ write FCLENQ;
    property Cnpjprod: String  read FCNPJPROD write FCNPJPROD;
    property Cselo: String  read FCSELO write FCSELO;
    property Qselo: Integer  read FQSELO write FQSELO;
    property Cenq: String  read FCENQ write FCENQ;
    property Cst: String  read FCST write FCST;
    property Pipi: Extended  read FPIPI write FPIPI;
    property Vunid: Extended  read FVUNID write FVUNID;

  end;

implementation

uses
  AuthService;

{ TConfiguracaoFiscalIpi }

constructor TConfiguracaoFiscalIpi.Create;
begin
  Self.Table:= 'CONFIGURACAO_FISCAL_IPI';
end;

function TConfiguracaoFiscalIpi.delete: Boolean;
const
  FSql: string =
  'UPDATE CONFIGURACAO_FISCAL_IPI   ' +
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
        raise Exception.Create('falha ao remover configuração fiscal ipi. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TConfiguracaoFiscalIpi.find(id: string): TConfiguracaoFiscalIpi;
const
  FSql: string = 'SELECT * FROM CONFIGURACAO_FISCAL_IPI WHERE (ID = :ID)';
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
        Result:= TConfiguracaoFiscalIpi.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.ConfiguracaoFiscalId:= FDQuery.FieldByName('CONFIGURACAO_FISCAL_ID').AsString;
        Result.Clenq:= FDQuery.FieldByName('CLENQ').AsString;
        Result.Cnpjprod:= FDQuery.FieldByName('CNPJPROD').AsString;
        Result.Cselo:= FDQuery.FieldByName('CSELO').AsString;
        Result.Qselo:= FDQuery.FieldByName('QSELO').AsInteger;
        Result.Cenq:= FDQuery.FieldByName('CENQ').AsString;
        Result.Cst:= FDQuery.FieldByName('CST').AsString;
        Result.Pipi:= FDQuery.FieldByName('PIPI').AsExtended;
        Result.Vunid:= FDQuery.FieldByName('VUNID').AsExtended;
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

class function TConfiguracaoFiscalIpi.findByConfiguracaoFiscalId(
  ConfiguracaoFiscalId: string): TConfiguracaoFiscalIpi;
const
  FSql: string =
  'SELECT ID FROM CONFIGURACAO_FISCAL_IPI ' +
  'WHERE (EMPRESA_ID =:EMPRESA_ID) ' +
  'AND (DELETED_AT IS NULL) ' +
  'AND (CONFIGURACAO_FISCAL_ID =:CONFIGURACAO_FISCAL_ID)';
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
        Result:= TConfiguracaoFiscalIpi.find(FDQuery.FieldByName('ID').AsString);
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TConfiguracaoFiscalIpi.save: Boolean;
begin
  Result:= inherited;
end;

function TConfiguracaoFiscalIpi.store: Boolean;
const
  FSql: string =
  'INSERT INTO CONFIGURACAO_FISCAL_IPI ( ' +
  '  ID,                                 ' +
  '  EMPRESA_ID,                         ' +
  '  CONFIGURACAO_FISCAL_ID,             ' +
  '  CLENQ,                              ' +
  '  CNPJPROD,                           ' +
  '  CSELO,                              ' +
  '  QSELO,                              ' +
  '  CENQ,                               ' +
  '  CST,                                ' +
  '  PIPI,                               ' +
  '  VUNID,                              ' +
  '  CREATED_AT,                         ' +
  '  UPDATED_AT)                         ' +
  'VALUES (                              ' +
  '  :ID,                                ' +
  '  :EMPRESA_ID,                        ' +
  '  :CONFIGURACAO_FISCAL_ID,            ' +
  '  :CLENQ,                             ' +
  '  :CNPJPROD,                          ' +
  '  :CSELO,                             ' +
  '  :QSELO,                             ' +
  '  :CENQ,                              ' +
  '  :CST,                               ' +
  '  :PIPI,                              ' +
  '  :VUNID,                             ' +
  '  :CREATED_AT,                        ' +
  '  :UPDATED_AT)                        ';
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
      FDQuery.Params.ParamByName('CLENQ').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CNPJPROD').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CSELO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('QSELO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CENQ').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PIPI').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VUNID').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('CONFIGURACAO_FISCAL_ID').AsString:= Self.ConfiguracaoFiscalId;
      if (Self.Clenq <> EmptyStr) then
        FDQuery.Params.ParamByName('CLENQ').AsString:= Self.Clenq;
      if (Self.Cnpjprod <> EmptyStr) then
        FDQuery.Params.ParamByName('CNPJPROD').AsString:= Self.Cnpjprod;
      if (Self.Cselo <> EmptyStr) then
        FDQuery.Params.ParamByName('CSELO').AsString:= Self.Cselo;
      if (Self.Qselo > 0) then
        FDQuery.Params.ParamByName('QSELO').AsInteger:= Self.Qselo;
      if (Self.Cenq <> EmptyStr) then
        FDQuery.Params.ParamByName('CENQ').AsString:= Self.Cenq;
      FDQuery.Params.ParamByName('CST').AsString:= Self.Cst;
      FDQuery.Params.ParamByName('PIPI').AsFMTBCD:= Self.Pipi;
      FDQuery.Params.ParamByName('VUNID').AsFMTBCD:= Self.Vunid;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
    begin
      Result:= False;
      raise Exception.Create('falha ao inserir configuração fiscal ipi. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TConfiguracaoFiscalIpi.update: Boolean;
const
  FSql: string =
  'UPDATE CONFIGURACAO_FISCAL_IPI   ' +
  'SET CLENQ = :CLENQ,              ' +
  '    CNPJPROD = :CNPJPROD,        ' +
  '    CSELO = :CSELO,              ' +
  '    QSELO = :QSELO,              ' +
  '    CENQ = :CENQ,                ' +
  '    CST = :CST,                  ' +
  '    PIPI = :PIPI,                ' +
  '    VUNID = :VUNID,              ' +
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
      FDQuery.Params.ParamByName('CLENQ').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CNPJPROD').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CSELO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('QSELO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CENQ').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PIPI').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VUNID').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.Clenq <> EmptyStr) then
        FDQuery.Params.ParamByName('CLENQ').AsString:= Self.Clenq;
      if (Self.Cnpjprod <> EmptyStr) then
        FDQuery.Params.ParamByName('CNPJPROD').AsString:= Self.Cnpjprod;
      if (Self.Cselo <> EmptyStr) then
        FDQuery.Params.ParamByName('CSELO').AsString:= Self.Cselo;
      if (Self.Qselo > 0) then
        FDQuery.Params.ParamByName('QSELO').AsInteger:= Self.Qselo;
      if (Self.Cenq <> EmptyStr) then
        FDQuery.Params.ParamByName('CENQ').AsString:= Self.Cenq;
      if (Self.Cst <> EmptyStr) then
      FDQuery.Params.ParamByName('CST').AsString:= Self.Cst;
      FDQuery.Params.ParamByName('PIPI').AsFMTBCD:= Self.Pipi;
      FDQuery.Params.ParamByName('VUNID').AsFMTBCD:= Self.Vunid;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
    begin
      Result:= False;
      raise Exception.Create('falha ao atualizar configuração fiscal ipi. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
