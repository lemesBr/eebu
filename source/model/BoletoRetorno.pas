unit BoletoRetorno;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TBoletoRetorno = class(TModel)
  private
    FEMPRESA_ID: String;
    FDATA: TDateTime;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    class function find(id: string): TBoletoRetorno;
    class function list(search: string): TObjectList<TBoletoRetorno>; overload;
    class procedure list(search: string; DataSet: TFDMemTable); overload;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property Data: TDateTime  read FDATA write FDATA;

  end;

implementation

uses
  AuthService;

{ TBoletoRetorno }

constructor TBoletoRetorno.Create;
begin
  Self.Table:= 'BOLETO_RETORNOS';
end;

destructor TBoletoRetorno.Destroy;
begin

  inherited;
end;

class function TBoletoRetorno.find(id: string): TBoletoRetorno;
begin

end;

class function TBoletoRetorno.list(search: string): TObjectList<TBoletoRetorno>;
begin

end;

class procedure TBoletoRetorno.list(search: string; DataSet: TFDMemTable);
begin

end;

function TBoletoRetorno.save: Boolean;
begin
  Result:= inherited;
end;

function TBoletoRetorno.store: Boolean;
const
  FSql: string =
  'INSERT INTO BOLETO_RETORNOS (' +
  '  ID,                        ' +
  '  EMPRESA_ID,                ' +
  '  DATA,                      ' +
  '  CREATED_AT,                ' +
  '  UPDATED_AT)                ' +
  'VALUES (                     ' +
  '  :ID,                       ' +
  '  :EMPRESA_ID,               ' +
  '  :DATA,                     ' +
  '  :CREATED_AT,               ' +
  '  :UPDATED_AT)               ';
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
      FDQuery.Params.ParamByName('DATA').DataType:= ftDate;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('DATA').AsDate:= Self.Data;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('falha ao inserir o retorno. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TBoletoRetorno.update: Boolean;
const
  FSql: string =
  'UPDATE BOLETO_RETORNOS            ' +
  'SET DATA = :DATA,                 ' +
  '    UPDATED_AT = :UPDATED_AT,     ' +
  '    SYNCHRONIZED = :SYNCHRONIZED  ' +
  'WHERE (ID = :ID);                 ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('DATA').DataType:= ftDate;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('DATA').AsDate:= Self.Data;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('falha ao atualizar o retorno. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
