unit Model;

interface

uses
  Conexao, Helper, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.DateUtils,
  System.SysUtils, System.StrUtils, ACBrUtil;

type
  TModel = class
  private
    FID: String;
    FDELETED_AT: TDateTime;
    FUPDATED_AT: TDateTime;
    FCREATED_AT: TDateTime;
    FSYNCHRONIZED: String;
    function validReferencia(Referencia: Integer): Boolean;
    function getReferencia(): Integer;
  protected
    Table: string;
    function generateId(): string;
    function store(): Boolean; virtual; abstract;
    function update(): Boolean; virtual; abstract;
    function save(): Boolean;
    function unicValueInTable(VField, VFieldValue: String): Boolean;
    class function createQuery(): TFDQuery;
    class procedure StartTransaction;
    class procedure Commit;
    class procedure Rollback;
  public
    function nextReferencia(Referencia: Integer = 0): Integer;

    property Id: String  read FID write FID;
    property CreatedAt: TDateTime  read FCREATED_AT write FCREATED_AT;
    property UpdatedAt: TDateTime  read FUPDATED_AT write FUPDATED_AT;
    property DeletedAt: TDateTime  read FDELETED_AT write FDELETED_AT;
    property Synchronized: String  read FSYNCHRONIZED write FSYNCHRONIZED;
  end;

implementation

uses
  AuthService;

{ TModel }

class procedure TModel.Commit;
begin
  TConexao.GetInstance.Commit;
end;

class function TModel.createQuery: TFDQuery;
begin
  Result:= TFDQuery.Create(nil);
  Result.Connection:= TConexao.GetInstance();
end;

function TModel.generateId: string;
var
  vKey: string;
begin
  Sleep(2);

  vKey:=
    FormatDateTime('yyyymmddhhmmss', Now) + '-' +
    Self.Table + '-' +
    MilliSecondOfTheYear(Now).ToString() + '-' +
    THelper.SerialDrive('C');

  Result:= UpperCase(THelper.MD5String(vKey));
end;

function TModel.getReferencia: Integer;
var
  FSql: string;
  FDQuery: TFDQuery;
begin
  try
    FSql:= 'SELECT MAX(REFERENCIA) AS REFERENCIA  FROM ' + Table +
    ' WHERE (EMPRESA_ID = :EMPRESA_ID)';
    FDQuery:= createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Open();
      Result:= (FDQuery.FieldByName('REFERENCIA').AsInteger + 1);
      if (Result = 1) then
      begin
        case AnsiIndexStr(UpperCase(Table), ['MOVIMENTOS', 'VENDAS','RECEBIMENTOS']) of
          0: Result:= (TAuthService.Terminal.MovimentoReferencia + 1);
          1: Result:= (TAuthService.Terminal.VendaReferencia + 1);
          2: Result:= (TAuthService.Terminal.RecebimentoReferencia + 1);
        end;

        if (Result = 1) then
          Result:= StrToInt(TAuthService.Terminal.Referencia.ToString() +
            PadLeft(Result.ToString(),  8, '0'));
      end;
    except
      Result:= 0;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TModel.nextReferencia(Referencia: Integer): Integer;
begin
  if (Referencia <= 0) or (not validReferencia(Referencia)) then
    Result:= getReferencia
  else
    Result:= Referencia;
end;

class procedure TModel.Rollback;
begin
  TConexao.GetInstance.Rollback;
end;

function TModel.save: Boolean;
begin
  if (self.FID = EmptyStr) or (Self.Synchronized = EmptyStr) then
    Result:= Self.store
  else Result:= Self.update;
end;

class procedure TModel.StartTransaction;
begin
  TConexao.GetInstance.StartTransaction;
end;

function TModel.unicValueInTable(VField, VFieldValue: String): Boolean;
var
  FSql: string;
  FDQuery: TFDQuery;
begin
  try
    FSql:= 'SELECT * FROM ' + Table + ' WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
    'AND ('+ VField +' = :FIELD) AND (ID <> :ID)';
    FDQuery:= createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('FIELD').DataType:= ftWideString;
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('FIELD').AsString:= VFieldValue;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= ''; //TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Open();
      Result:= (FDQuery.RecordCount = 0);
    except
      Result:= False;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TModel.validReferencia(Referencia: Integer): Boolean;
var
  FSql: string;
  FDQuery: TFDQuery;
begin
  try
    FSql:= 'SELECT * FROM ' + Table + ' WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
    'AND (REFERENCIA = :REFERENCIA)';
    FDQuery:= createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= Referencia;
      FDQuery.Open();
      Result:= (FDQuery.RecordCount = 0);
    except
      Result:= False;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
