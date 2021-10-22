unit VendaRecebimento;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TVendaRecebimento = class(TModel)
  private
    FEMPRESA_ID: String;
    FVENDA_ID: String;
    FTPAG: String;
    FRECEBIDO: Extended;
    FTROCO: Extended;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function  save(): Boolean;

    class function find(Id: string): TVendaRecebimento;
    class function findByVenda(VendaId: string): TObjectList<TVendaRecebimento>;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property VendaId: String  read FVENDA_ID write FVENDA_ID;
    property Tpag: String  read FTPAG write FTPAG;
    property Recebido: Extended  read FRECEBIDO write FRECEBIDO;
    property Troco: Extended  read FTROCO write FTROCO;

  end;

implementation

uses
  AuthService;

{ TVendaRecebimento }

constructor TVendaRecebimento.Create;
begin
  Self.Table:= 'VENDA_RECEBIMENTOS';
end;

destructor TVendaRecebimento.Destroy;
begin

  inherited;
end;

class function TVendaRecebimento.find(Id: string): TVendaRecebimento;
const
  FSql: string = 'SELECT * FROM VENDA_RECEBIMENTOS WHERE (ID = :ID)';
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
        Result:= TVendaRecebimento.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.VendaId:= FDQuery.FieldByName('VENDA_ID').AsString;
        Result.Tpag:= FDQuery.FieldByName('TPAG').AsString;
        Result.Recebido:= FDQuery.FieldByName('RECEBIDO').AsExtended;
        Result.Troco:= FDQuery.FieldByName('TROCO').AsExtended;
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

class function TVendaRecebimento.findByVenda(
  VendaId: string): TObjectList<TVendaRecebimento>;
const
  FSql: string =
  'SELECT ID FROM VENDA_RECEBIMENTOS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (VENDA_ID = :VENDA_ID) ' +
  'AND (DELETED_AT IS NULL)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('VENDA_ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Params.ParamByName('VENDA_ID').AsString:= VendaId;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TObjectList<TVendaRecebimento>.Create;
        FDQuery.First();
        while not FDQuery.Eof do
        begin
          Result.Add(TVendaRecebimento.find(FDQuery.FieldByName('ID').AsString));
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

function TVendaRecebimento.save: Boolean;
begin
  Result:= inherited;
end;

function TVendaRecebimento.store: Boolean;
const
  FSql: string =
  'INSERT INTO VENDA_RECEBIMENTOS (' +
  '  ID,                           ' +
  '  EMPRESA_ID,                   ' +
  '  VENDA_ID,                     ' +
  '  TPAG,                         ' +
  '  RECEBIDO,                     ' +
  '  TROCO,                        ' +
  '  CREATED_AT,                   ' +
  '  UPDATED_AT)                   ' +
  'VALUES (                        ' +
  '  :ID,                          ' +
  '  :EMPRESA_ID,                  ' +
  '  :VENDA_ID,                    ' +
  '  :TPAG,                        ' +
  '  :RECEBIDO,                    ' +
  '  :TROCO,                       ' +
  '  :CREATED_AT,                  ' +
  '  :UPDATED_AT)                  ';
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
      FDQuery.Params.ParamByName('VENDA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('TPAG').DataType:= ftString;
      FDQuery.Params.ParamByName('RECEBIDO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('TROCO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare();

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.Terminal.EmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('VENDA_ID').AsString:= Self.VendaId;
      FDQuery.Params.ParamByName('TPAG').AsString:= Self.Tpag;
      FDQuery.Params.ParamByName('RECEBIDO').AsExtended:= Self.Recebido;
      FDQuery.Params.ParamByName('TROCO').AsExtended:= Self.Troco;
      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('Falha ao gravar dados do recebimento. Erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TVendaRecebimento.update: Boolean;
begin
  Result:= True;
end;

end.
