unit UnidadeConversaoCodigo;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TUnidadeConversaoCodigo = class(TModel)
  private
    FEMPRESA_ID: String;
    FUNIDADE_CONVERSAO_ID: String;
    FCODIGO: String;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function find(codigo: string): string;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property UnidadeConversaoId: String  read FUNIDADE_CONVERSAO_ID write FUNIDADE_CONVERSAO_ID;
    property Codigo: String  read FCODIGO write FCODIGO;

  end;

implementation

uses
  AuthService;

{ TUnidadeConversaoCodigo }

constructor TUnidadeConversaoCodigo.Create;
begin
  Self.Table:= 'UNIDADE_CONVERSAO_CODIGOS';
end;

class function TUnidadeConversaoCodigo.find(codigo: string): string;
const
  FSql: string =
  'SELECT UNIDADE_CONVERSAO_ID FROM UNIDADE_CONVERSAO_CODIGOS ' +
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
        Result:= FDQuery.FieldByName('UNIDADE_CONVERSAO_ID').AsString;
    except
      Result:= '';
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TUnidadeConversaoCodigo.save: Boolean;
begin
  Result:= inherited;
end;

function TUnidadeConversaoCodigo.store: Boolean;
const
  FSql: string =
  'INSERT INTO UNIDADE_CONVERSAO_CODIGOS (' +
  '  ID,                                  ' +
  '  EMPRESA_ID,                          ' +
  '  UNIDADE_CONVERSAO_ID,                ' +
  '  CODIGO,                              ' +
  '  CREATED_AT,                          ' +
  '  UPDATED_AT)                          ' +
  'VALUES (                               ' +
  '  :ID,                                 ' +
  '  :EMPRESA_ID,                         ' +
  '  :UNIDADE_CONVERSAO_ID,               ' +
  '  :CODIGO,                             ' +
  '  :CREATED_AT,                         ' +
  '  :UPDATED_AT)                         ';
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
      FDQuery.Params.ParamByName('UNIDADE_CONVERSAO_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('CODIGO').DataType:= ftString;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('UNIDADE_CONVERSAO_ID').AsString:= Self.UnidadeConversaoId;
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

function TUnidadeConversaoCodigo.update: Boolean;
begin
  Result:= True;
end;

end.
