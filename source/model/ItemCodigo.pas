unit ItemCodigo;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TItemCodigo = class(TModel)
  private
    FEMPRESA_ID: String;
    FITEM_ID: String;
    FCODIGO: String;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function find(codigo: string): string;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property ItemId: String  read FITEM_ID write FITEM_ID;
    property Codigo: String  read FCODIGO write FCODIGO;

  end;

implementation

uses
  AuthService;

{ TItemCodigo }

constructor TItemCodigo.Create;
begin
  Self.Table:= 'ITEM_CODIGOS';
end;

class function TItemCodigo.find(codigo: string): string;
const
  FSql: string =
  'SELECT ITEM_ID FROM ITEM_CODIGOS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (CODIGO = :CODIGO)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('CODIGO').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('CODIGO').AsString:= codigo;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= ''
      else
        Result:= FDQuery.FieldByName('ITEM_ID').AsString;
    except
      Result:= '';
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TItemCodigo.save: Boolean;
begin
  Result:= inherited;
end;

function TItemCodigo.store: Boolean;
const
  FSql: string =
  'INSERT INTO ITEM_CODIGOS (' +
  '  ID,                     ' +
  '  EMPRESA_ID,             ' +
  '  ITEM_ID,                ' +
  '  CODIGO,                 ' +
  '  CREATED_AT,             ' +
  '  UPDATED_AT)             ' +
  'VALUES (                  ' +
  '  :ID,                    ' +
  '  :EMPRESA_ID,            ' +
  '  :ITEM_ID,               ' +
  '  :CODIGO,                ' +
  '  :CREATED_AT,            ' +
  '  :UPDATED_AT)            ';
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
      FDQuery.Params.ParamByName('ITEM_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('CODIGO').DataType:= ftString;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('ITEM_ID').AsString:= Self.ItemId;
      FDQuery.Params.ParamByName('CODIGO').AsString:= Self.Codigo;
      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create(e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TItemCodigo.update: Boolean;
begin
  Result:= True;
end;

end.
