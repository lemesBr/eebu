unit MovimentoFechamento;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TMovimentoFechamento = class(TModel)
  private
    FEMPRESA_ID: String;
    FMOVIMENTO_ID: String;
    FTPAG: String;
    FDECLARADO: Extended;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function  save(): Boolean;
    class function find(Id: string): TMovimentoFechamento;
    class function findByMovimento(MovimentoId: string): TObjectList<TMovimentoFechamento>;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property MovimentoId: String  read FMOVIMENTO_ID write FMOVIMENTO_ID;
    property Tpag: String  read FTPAG write FTPAG;
    property Declarado: Extended  read FDECLARADO write FDECLARADO;
    
  end;

implementation

uses
  AuthService;

{ TMovimentoFechamento }

constructor TMovimentoFechamento.Create;
begin
  Self.Table:= 'MOVIMENTO_FECHAMENTOS';
end;

destructor TMovimentoFechamento.Destroy;
begin

  inherited;
end;

class function TMovimentoFechamento.find(Id: string): TMovimentoFechamento;
const
  FSql: string = 'SELECT * FROM MOVIMENTO_FECHAMENTOS WHERE (ID = :ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('ID').AsString:= Id;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TMovimentoFechamento.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.MovimentoId:= FDQuery.FieldByName('MOVIMENTO_ID').AsString;
        Result.Tpag:= FDQuery.FieldByName('TPAG').AsString;
        Result.Declarado:= FDQuery.FieldByName('DECLARADO').AsExtended;
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

class function TMovimentoFechamento.findByMovimento(
  MovimentoId: string): TObjectList<TMovimentoFechamento>;
const
  FSql: string =
  'SELECT ID FROM MOVIMENTO_FECHAMENTOS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (MOVIMENTO_ID = :MOVIMENTO_ID) ' +
  'AND (DELETED_AT IS NULL)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('MOVIMENTO_ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Params.ParamByName('MOVIMENTO_ID').AsString:= MovimentoId;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TObjectList<TMovimentoFechamento>.Create;
        FDQuery.First();
        while not FDQuery.Eof do
        begin
          Result.Add(TMovimentoFechamento.find(FDQuery.FieldByName('ID').AsString));
          FDQuery.Next();
        end;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TMovimentoFechamento.save: Boolean;
begin
  Result:= inherited;
end;

function TMovimentoFechamento.store: Boolean;
const
  FSql: string =
  'INSERT INTO MOVIMENTO_FECHAMENTOS ( ' +
  '  ID,                               ' +
  '  EMPRESA_ID,                       ' +
  '  MOVIMENTO_ID,                     ' +
  '  TPAG,                             ' +
  '  DECLARADO,                        ' +
  '  CREATED_AT,                       ' +
  '  UPDATED_AT)                       ' +
  'VALUES (                            ' +
  '  :ID,                              ' +
  '  :EMPRESA_ID,                      ' +
  '  :MOVIMENTO_ID,                    ' +
  '  :TPAG,                            ' +
  '  :DECLARADO,                       ' +
  '  :CREATED_AT,                      ' +
  '  :UPDATED_AT)                      ';
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
      FDQuery.Params.ParamByName('MOVIMENTO_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('TPAG').DataType:= ftString;
      FDQuery.Params.ParamByName('DECLARADO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare();

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.Terminal.EmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('MOVIMENTO_ID').AsString:= Self.MovimentoId;
      FDQuery.Params.ParamByName('TPAG').AsString:= Self.Tpag;
      FDQuery.Params.ParamByName('DECLARADO').AsExtended:= Self.Declarado;
      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.ExecSQL();
    except on e: exception do
    begin
      Result:= False;
      raise Exception.Create('Falha ao gravar dados do fechamento. Erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TMovimentoFechamento.update: Boolean;
begin
  Result:= True;
end;

end.
