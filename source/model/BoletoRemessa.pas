unit BoletoRemessa;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  Boleto;

type
  TBoletoRemessa = class(TModel)
  private
    FEMPRESA_ID: String;
    FDATA: TDateTime;
    FNUMERO: Integer;
    FBOLETOS: TObjectList<TBoleto>;

    function getBoletos: TObjectList<TBoleto>;
  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    class function find(id: string): TBoletoRemessa;
    class function list(search: string): TObjectList<TBoletoRemessa>; overload;
    class procedure list(search: string; DataSet: TFDMemTable); overload;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property Data: TDateTime  read FDATA write FDATA;
    property Numero: Integer  read FNUMERO write FNUMERO;

    property Boletos: TObjectList<TBoleto> read getBoletos;

  end;

implementation

uses
  AuthService;

{ TBoletoRemessa }

constructor TBoletoRemessa.Create;
begin
  Self.Table:= 'BOLETO_REMESSAS';
end;

destructor TBoletoRemessa.Destroy;
begin
  if Assigned(FBOLETOS) then FreeAndNil(FBOLETOS);

  inherited;
end;

class function TBoletoRemessa.find(id: string): TBoletoRemessa;
begin

end;

function TBoletoRemessa.getBoletos: TObjectList<TBoleto>;
begin
  if not Assigned(FBOLETOS) then
    FBOLETOS:= TBoleto.listByRemessaId(Self.Id);

  Result:= FBOLETOS;
end;

class function TBoletoRemessa.list(search: string): TObjectList<TBoletoRemessa>;
begin

end;

class procedure TBoletoRemessa.list(search: string; DataSet: TFDMemTable);
begin

end;

function TBoletoRemessa.save: Boolean;
begin
  Result:= inherited;
end;

function TBoletoRemessa.store: Boolean;
const
  FSql: string =
  'INSERT INTO BOLETO_REMESSAS (' +
  '  ID,                        ' +
  '  EMPRESA_ID,                ' +
  '  DATA,                      ' +
  '  NUMERO,                    ' +
  '  CREATED_AT,                ' +
  '  UPDATED_AT)                ' +
  'VALUES (                     ' +
  '  :ID,                       ' +
  '  :EMPRESA_ID,               ' +
  '  :DATA,                     ' +
  '  :NUMERO,                   ' +
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
      FDQuery.Params.ParamByName('NUMERO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('DATA').AsDate:= Self.Data;
      FDQuery.Params.ParamByName('NUMERO').AsInteger:= Self.Numero;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('falha ao inserir a remessa. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TBoletoRemessa.update: Boolean;
const
  FSql: string =
  'UPDATE BOLETO_REMESSAS            ' +
  'SET DATA = :DATA,                 ' +
  '    NUMERO = :NUMERO,             ' +
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
      FDQuery.Params.ParamByName('NUMERO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('DATA').AsDate:= Self.Data;
      FDQuery.Params.ParamByName('NUMERO').AsInteger:= Self.Numero;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('falha ao atualizar a remessa. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
