unit ConfiguracaoFiscal;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  OperacaoFiscal, GrupoTributario, ConfiguracaoFiscalIpi;

type
  TConfiguracaoFiscal = class(TModel)
  private
    FEMPRESA_ID: String;
    FOPERACAO_FISCAL_ID: String;
    FGRUPO_TRIBUTARIO_ID: String;

    FOPERACAOFISCAL: TOperacaoFiscal;
    FGRUPOTRIBUTARIO: TGrupoTributario;

    function getOperacaoFiscal: TOperacaoFiscal;
    function getGrupoTributario: TGrupoTributario;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    function delete(): Boolean;
    function validate: Boolean;
    class function find(id: string): TConfiguracaoFiscal;
    class function list(search: string): TObjectList<TConfiguracaoFiscal>; overload;
    class procedure list(search: string; DataSet: TFDMemTable); overload;
    class function remove(id: string): Boolean;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property OperacaoFiscalId: String  read FOPERACAO_FISCAL_ID write FOPERACAO_FISCAL_ID;
    property GrupoTributarioId: String  read FGRUPO_TRIBUTARIO_ID write FGRUPO_TRIBUTARIO_ID;
    
    property OperacaoFiscal: TOperacaoFiscal read getOperacaoFiscal;
    property GrupoTributario: TGrupoTributario read getGrupoTributario;

  end;

implementation

uses
  AuthService, Helper;

{ TConfiguracaoFiscal }

constructor TConfiguracaoFiscal.Create;
begin
  Self.Table:= 'CONFIGURACOES_FISCAIS';
end;

function TConfiguracaoFiscal.delete: Boolean;
const
  FSql: string =
  'UPDATE CONFIGURACOES_FISCAIS     ' +
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
        raise Exception.Create('falha ao remover a configuração fiscal. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

destructor TConfiguracaoFiscal.Destroy;
begin
  if Assigned(Self.FOPERACAOFISCAL) then FreeAndNil(Self.FOPERACAOFISCAL);
  if Assigned(Self.FGRUPOTRIBUTARIO) then FreeAndNil(Self.FGRUPOTRIBUTARIO);
  inherited;
end;

class function TConfiguracaoFiscal.find(id: string): TConfiguracaoFiscal;
const
  FSql: string = 'SELECT * FROM CONFIGURACOES_FISCAIS WHERE (ID = :ID)';
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
        Result:= TConfiguracaoFiscal.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.OperacaoFiscalId:= FDQuery.FieldByName('OPERACAO_FISCAL_ID').AsString;
        Result.GrupoTributarioId:= FDQuery.FieldByName('GRUPO_TRIBUTARIO_ID').AsString;
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

function TConfiguracaoFiscal.getGrupoTributario: TGrupoTributario;
begin
  if not Assigned(Self.FGRUPOTRIBUTARIO) then
    Self.FGRUPOTRIBUTARIO:= TGrupoTributario.find(Self.FGRUPO_TRIBUTARIO_ID)
  else if Self.FGRUPOTRIBUTARIO.Id <> Self.FGRUPO_TRIBUTARIO_ID then
  begin
    FreeAndNil(FGRUPOTRIBUTARIO);
    Self.FGRUPOTRIBUTARIO:= TGrupoTributario.find(Self.FGRUPO_TRIBUTARIO_ID);
  end;
  Result:= Self.FGRUPOTRIBUTARIO;
end;

function TConfiguracaoFiscal.getOperacaoFiscal: TOperacaoFiscal;
begin
  if not Assigned(Self.FOPERACAOFISCAL) then
    Self.FOPERACAOFISCAL:= TOperacaoFiscal.find(Self.FOPERACAO_FISCAL_ID)
  else if Self.FOPERACAOFISCAL.Id <> Self.FOPERACAO_FISCAL_ID then
  begin
    FreeAndNil(FOPERACAOFISCAL);
    Self.FOPERACAOFISCAL:= TOperacaoFiscal.find(Self.FOPERACAO_FISCAL_ID);
  end;
  Result:= Self.FOPERACAOFISCAL;
end;

class function TConfiguracaoFiscal.list(
  search: string): TObjectList<TConfiguracaoFiscal>;
const
  FSql: string =
  'SELECT C.ID FROM CONFIGURACOES_FISCAIS C ' +
  'JOIN OPERACOES_FISCAIS O ON(O.ID = C.OPERACAO_FISCAL_ID) ' +
  'JOIN GRUPOS_TRIBUTARIOS G ON(G.ID = C.GRUPO_TRIBUTARIO_ID) ' +
  'WHERE (C.EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (C.DELETED_AT IS NULL) ' +
  'AND ((O.NOME LIKE :SEARCH) OR (G.NOME LIKE :SEARCH)) ORDER BY O.NOME';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('SEARCH').DataType:= ftWideString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('SEARCH').AsString:= '%' + search + '%';
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TConfiguracaoFiscal>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TConfiguracaoFiscal.find(FDQuery.FieldByName('ID').AsString));
          FDQuery.Next;
        end;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class procedure TConfiguracaoFiscal.list(search: string; DataSet: TFDMemTable);
var
  v_list: TObjectList<TConfiguracaoFiscal>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  v_list:= TConfiguracaoFiscal.list(search);
  if Assigned(v_list) then
  begin
    for I := 0 to Pred(v_list.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= v_list.Items[I].Id;
      DataSet.FieldByName('OPERACAO_FISCAL').AsString:= v_list.Items[I].OperacaoFiscal.Nome;
      DataSet.FieldByName('GRUPO_TRIBUTARIO').AsString:= v_list.Items[I].GrupoTributario.Nome;
      DataSet.Post;
    end;
    FreeAndNil(v_list);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TConfiguracaoFiscal.remove(id: string): Boolean;
var
  ConfiguracaoFiscal: TConfiguracaoFiscal;
begin
  Result:= False;
  ConfiguracaoFiscal:= TConfiguracaoFiscal.find(id);
  if not Assigned(ConfiguracaoFiscal) then
  begin
    THelper.Mensagem('Configuração fiscal não encontrada. A configuração fiscal pode ter sido previamente excluída por outro usuário!');
    Exit();
  end;

  try
    if not THelper.Mensagem('Confirmar a exclusão desta configuração fiscal?', 1) then
      Exit();

    Result:= ConfiguracaoFiscal.delete();
  finally
    FreeAndNil(ConfiguracaoFiscal);
  end;
end;

function TConfiguracaoFiscal.save: Boolean;
begin
  Result:= inherited;
end;

function TConfiguracaoFiscal.store: Boolean;
const
  FSql: string =
  'INSERT INTO CONFIGURACOES_FISCAIS ( ' +
  '  ID,                               ' +
  '  EMPRESA_ID,                       ' +
  '  OPERACAO_FISCAL_ID,               ' +
  '  GRUPO_TRIBUTARIO_ID,              ' +
  '  CREATED_AT,                       ' +
  '  UPDATED_AT)                       ' +
  'VALUES (                            ' +
  '  :ID,                              ' +
  '  :EMPRESA_ID,                      ' +
  '  :OPERACAO_FISCAL_ID,              ' +
  '  :GRUPO_TRIBUTARIO_ID,             ' +
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
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('OPERACAO_FISCAL_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('GRUPO_TRIBUTARIO_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('OPERACAO_FISCAL_ID').AsString:= Self.OperacaoFiscalId;
      FDQuery.Params.ParamByName('GRUPO_TRIBUTARIO_ID').AsString:= Self.GrupoTributarioId;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('falha ao inserir a configuração fiscal. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TConfiguracaoFiscal.update: Boolean;
const
  FSql: string =
  'UPDATE CONFIGURACOES_FISCAIS                    ' +
  'SET OPERACAO_FISCAL_ID = :OPERACAO_FISCAL_ID,   ' +
  '    GRUPO_TRIBUTARIO_ID = :GRUPO_TRIBUTARIO_ID, ' +
  '    UPDATED_AT = :UPDATED_AT,                   ' +
  '    SYNCHRONIZED = :SYNCHRONIZED                ' +
  'WHERE (ID = :ID)                                ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('OPERACAO_FISCAL_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('GRUPO_TRIBUTARIO_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('OPERACAO_FISCAL_ID').AsString:= Self.OperacaoFiscalId;
      FDQuery.Params.ParamByName('GRUPO_TRIBUTARIO_ID').AsString:= Self.GrupoTributarioId;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('falha ao atualizar a configuração fiscal. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TConfiguracaoFiscal.validate: Boolean;
var
  Validacao: string;
begin
  Result:= True;
  if Self.OperacaoFiscalId = '' then
    Validacao:= 'Operação Fiacal não foi preenchido.' + #13;

  if Self.GrupoTributarioId = '' then
    Validacao:= Validacao + 'Grupo Tributario não foi preenchido.' + #13;

  if Validacao <> '' then
  begin
    THelper.Mensagem('Existem algumas pendencias!' + #13 + Validacao);
    Result:= False;
  end;
end;

end.
