unit Wt;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  System.DateUtils;

type
  TWt = class(TModel)
  private
    FEMPRESA_ID: String;
    FLIBERACAO: TDateTime;
    FWT_KEY: String;
    FVERIFICACAO: TDateTime;
    FEXPIRACAO: TDateTime;
    FWT_KEY_VERIFICADA: String;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function find(): TWt; overload;
    class function find(key: string): TWt; overload;
    class function setKey(key: string): Boolean;
    class function verificarKey(): Boolean;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property Liberacao: TDateTime  read FLIBERACAO write FLIBERACAO;
    property WtKey: String  read FWT_KEY write FWT_KEY;
    property Verificacao: TDateTime  read FVERIFICACAO write FVERIFICACAO;
    property Expiracao: TDateTime  read FEXPIRACAO write FEXPIRACAO;
    property WtKeyVerificada: String  read FWT_KEY_VERIFICADA write FWT_KEY_VERIFICADA;

  end;

implementation

uses
  AuthService, Empresa, Helper;


{ TWt }

constructor TWt.Create;
begin
  Self.Table:= 'WT';
end;

class function TWt.find: TWt;
const
  FSql: string =
  'SELECT FIRST 1 * FROM WT ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'ORDER BY EXPIRACAO DESC';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TWt.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.Liberacao:= FDQuery.FieldByName('LIBERACAO').AsDateTime;
        Result.WtKey:= FDQuery.FieldByName('WT_KEY').AsString;
        Result.Verificacao:= FDQuery.FieldByName('VERIFICACAO').AsDateTime;
        Result.Expiracao:= FDQuery.FieldByName('EXPIRACAO').AsDateTime;
        Result.WtKeyVerificada:= FDQuery.FieldByName('WT_KEY_VERIFICADA').AsString;
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

class function TWt.find(key: string): TWt;
const
  FSql: string =
  'SELECT * FROM WT ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND WT_KEY = :KEY ';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('KEY').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('KEY').AsString:= key;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TWt.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.Liberacao:= FDQuery.FieldByName('LIBERACAO').AsDateTime;
        Result.WtKey:= FDQuery.FieldByName('WT_KEY').AsString;
        Result.Verificacao:= FDQuery.FieldByName('VERIFICACAO').AsDateTime;
        Result.Expiracao:= FDQuery.FieldByName('EXPIRACAO').AsDateTime;
        Result.WtKeyVerificada:= FDQuery.FieldByName('WT_KEY_VERIFICADA').AsString;
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

function TWt.save: Boolean;
begin
  Result:= inherited;
end;

class function TWt.setKey(key: string): Boolean;
var
  vEmpresa: TEmpresa;
  vWt: TWt;
  vKey: string;
  I: Integer;
  vExpiracao: TDate;
begin
  Result:= False;
  try
    try
      vWt:= nil;
      vEmpresa:= TEmpresa.find(TAuthService.getAuthenticatedEmpresaId);
      if not Assigned(vEmpresa) then
        raise Exception.Create('Falha ao consultar dados da empresa.');

      for I:= 0 to 370 do
      begin
        vExpiracao:= IncDay(Now,I);
        vKey:=
          FormatDateTime('yyyy-mm-dd', vExpiracao) +
          vEmpresa.Documento +
          '05041988-16011997';
        vKey:= UpperCase(THelper.MD5String(vKey));
        if (vKey = key) then
        begin
          Result:= True;
          Break;
        end;
      end;

      if (not Result) then
        raise Exception.Create('Chave informada é invalida.');

      vWt:= TWt.find(key);
      if Assigned(vWt) then
        raise Exception.Create('Duplicidade de chave.');

      vWt:= TWt.Create;
      vWt.Liberacao:= Now;
      vWt.WtKey:= key;
      vWt.Verificacao:= Now;
      vWt.Expiracao:= StrToDateTimeDef(DateToStr(vExpiracao) + ' 23:59:59', Now);

      vKey:=
        vEmpresa.Id +
        vEmpresa.Documento +
        FormatDateTime('yyyymmddhhmmss', vWt.Liberacao) +
        vWt.WtKey +
        FormatDateTime('yyyymmddhhmmss', vWt.Verificacao) +
        FormatDateTime('yyyymmddhhmmss', vWt.Expiracao);

      vWt.WtKeyVerificada:= UpperCase(THelper.MD5String(vKey));

      Result:= vWt.save();
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create(e.Message);
      end;
    end;
  finally
    if Assigned(vEmpresa) then FreeAndNil(vEmpresa);
    if Assigned(vWt) then FreeAndNil(vWt);
  end;
end;

function TWt.store: Boolean;
const
  FSql: string =
  'INSERT INTO WT (      ' +
  '  ID,                 ' +
  '  EMPRESA_ID,         ' +
  '  LIBERACAO,          ' +
  '  WT_KEY,             ' +
  '  VERIFICACAO,        ' +
  '  EXPIRACAO,          ' +
  '  WT_KEY_VERIFICADA,  ' +
  '  CREATED_AT,         ' +
  '  UPDATED_AT)         ' +
  'VALUES (              ' +
  '  :ID,                ' +
  '  :EMPRESA_ID,        ' +
  '  :LIBERACAO,         ' +
  '  :WT_KEY,            ' +
  '  :VERIFICACAO,       ' +
  '  :EXPIRACAO,         ' +
  '  :WT_KEY_VERIFICADA, ' +
  '  :CREATED_AT,        ' +
  '  :UPDATED_AT)        ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('LIBERACAO').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('WT_KEY').DataType:= ftString;
      FDQuery.Params.ParamByName('VERIFICACAO').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('EXPIRACAO').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('WT_KEY_VERIFICADA').DataType:= ftString;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('LIBERACAO').AsDateTime:= Self.Liberacao;
      FDQuery.Params.ParamByName('WT_KEY').AsString:= Self.WtKey;
      FDQuery.Params.ParamByName('VERIFICACAO').AsDateTime:= Self.Verificacao;
      FDQuery.Params.ParamByName('EXPIRACAO').AsDateTime:= Self.Expiracao;
      FDQuery.Params.ParamByName('WT_KEY_VERIFICADA').AsString:= Self.WtKeyVerificada;
      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('FALHA AO INSERIR A KEY. ERRO: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TWt.update: Boolean;
const
  FSql: string =
  'UPDATE WT                                  ' +
  'SET LIBERACAO = :LIBERACAO,                ' +
  '    WT_KEY = :WT_KEY,                      ' +
  '    VERIFICACAO = :VERIFICACAO,            ' +
  '    EXPIRACAO = :EXPIRACAO,                ' +
  '    WT_KEY_VERIFICADA = :WT_KEY_VERIFICADA,' +
  '    UPDATED_AT = :UPDATED_AT,              ' +
  '    SYNCHRONIZED = :SYNCHRONIZED           ' +
  'WHERE (ID = :ID)                           ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('LIBERACAO').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('WT_KEY').DataType:= ftString;
      FDQuery.Params.ParamByName('VERIFICACAO').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('EXPIRACAO').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('WT_KEY_VERIFICADA').DataType:= ftString;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftString;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('LIBERACAO').AsDateTime:= Self.Liberacao;
      FDQuery.Params.ParamByName('WT_KEY').AsString:= Self.WtKey;
      FDQuery.Params.ParamByName('VERIFICACAO').AsDateTime:= Self.Verificacao;
      FDQuery.Params.ParamByName('EXPIRACAO').AsDateTime:= Self.Expiracao;
      FDQuery.Params.ParamByName('WT_KEY_VERIFICADA').AsString:= Self.WtKeyVerificada;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('FALHA AO ATUALIZAR A KEY. ERRO: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TWt.verificarKey: Boolean;
var
  vEmpresa: TEmpresa;
  vWt: TWt;
  vKey: string;
begin
  try
    Result:= True;
    try
      vEmpresa:= TEmpresa.find(TAuthService.getAuthenticatedEmpresaId);
      if not Assigned(vEmpresa) then
      begin
        Result:= False;
        vWt:= nil;
        Exit();
      end;

      vWt:= TWt.find();
      if not Assigned(vWt) then
      begin
        Result:= False;
        Exit();
      end;

      vKey:=
        vEmpresa.Id +
        vEmpresa.Documento +
        FormatDateTime('yyyymmddhhmmss', vWt.Liberacao) +
        vWt.WtKey +
        FormatDateTime('yyyymmddhhmmss', vWt.Verificacao) +
        FormatDateTime('yyyymmddhhmmss', vWt.Expiracao);

      vKey:= UpperCase(THelper.MD5String(vKey));

      if (vWt.WtKeyVerificada <> vKey) then
      begin
        Result:= False;
        Exit();
      end;

      if FormatDateTime('yyyymmddhhmmss', vWt.Expiracao) <= FormatDateTime('yyyymmddhhmmss', Now) then
      begin
        Result:= False;
        Exit();
      end;

      if FormatDateTime('yyyymmddhhmm', vWt.Verificacao) >= FormatDateTime('yyyymmddhhmm', Now) then
      begin
        Result:= False;
        Exit();
      end;

      vWt.Verificacao:= Now;

      vKey:=
        vEmpresa.Id +
        vEmpresa.Documento +
        FormatDateTime('yyyymmddhhmmss', vWt.Liberacao) +
        vWt.WtKey +
        FormatDateTime('yyyymmddhhmmss', vWt.Verificacao) +
        FormatDateTime('yyyymmddhhmmss', vWt.Expiracao);

      vWt.WtKeyVerificada:= UpperCase(THelper.MD5String(vKey));

      Result:= vWt.save();
    except
      Result:= False;
    end;
  finally
    if (Result = True) then
    begin
      FreeAndNil(TAuthService.License);
      TAuthService.License:= vWt;
    end
    else
    begin
      FreeAndNil(TAuthService.License);
      FreeAndNil(vWt);
    end;

    FreeAndNil(vEmpresa);
  end;
end;

end.
