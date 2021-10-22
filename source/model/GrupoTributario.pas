unit GrupoTributario;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TGrupoTributario = class(TModel)
  private
    FEMPRESA_ID: String;
    FNOME: String;
    FORIG: String;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    function delete(): Boolean;
    function validate: Boolean;
    class function find(id: string): TGrupoTributario;
    class function list(search: string): TObjectList<TGrupoTributario>; overload;
    class procedure list(search: string; DataSet: TFDMemTable); overload;
    class function remove(id: string): Boolean;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property Nome: String  read FNOME write FNOME;
    property Orig: String  read FORIG write FORIG;

  end;

implementation

uses
  Helper, AuthService;

{ TGrupoTributario }

constructor TGrupoTributario.Create;
begin
  Self.Table:= 'GRUPOS_TRIBUTARIOS';
end;

function TGrupoTributario.delete: Boolean;
const
  FSql: string =
  'UPDATE GRUPOS_TRIBUTARIOS        ' +
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
        raise Exception.Create('falha ao remover o grupo tributario. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TGrupoTributario.find(id: string): TGrupoTributario;
const
  FSql: string = 'SELECT * FROM GRUPOS_TRIBUTARIOS WHERE (ID = :ID)';
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
        Result:= TGrupoTributario.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.Nome:= FDQuery.FieldByName('NOME').AsString;
        Result.Orig:= FDQuery.FieldByName('ORIG').AsString;
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

class function TGrupoTributario.list(
  search: string): TObjectList<TGrupoTributario>;
const
  FSql: string =
  'SELECT G.ID FROM GRUPOS_TRIBUTARIOS G ' +
  'WHERE (G.EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (G.DELETED_AT IS NULL) ' +
  'AND (G.NOME LIKE :SEARCH) ORDER BY G.NOME';
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
        Result:= TObjectList<TGrupoTributario>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TGrupoTributario.find(FDQuery.FieldByName('ID').AsString));
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

class procedure TGrupoTributario.list(search: string; DataSet: TFDMemTable);
var
  v_list: TObjectList<TGrupoTributario>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  v_list:= TGrupoTributario.list(search);
  if Assigned(v_list) then
  begin
    for I := 0 to Pred(v_list.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= v_list.Items[I].Id;
      DataSet.FieldByName('NOME').AsString:= v_list.Items[I].Nome;
      DataSet.Post;
    end;
    FreeAndNil(v_list);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TGrupoTributario.remove(id: string): Boolean;
var
  GrupoTributario: TGrupoTributario;
begin
  Result:= False;
  GrupoTributario:= TGrupoTributario.find(id);
  if not Assigned(GrupoTributario) then
  begin
    THelper.Mensagem('Grupo tributario não encontrado. O grupo tributario pode ter sido previamente excluído por outro usuário!');
    Exit();
  end;

  try
    if not THelper.Mensagem('Confirmar a exclusão deste grupo tributario?', 1) then
      Exit();

    Result:= GrupoTributario.delete();
  finally
    FreeAndNil(GrupoTributario);
  end;
end;

function TGrupoTributario.save: Boolean;
begin
  Result:= inherited;
end;

function TGrupoTributario.store: Boolean;
const
  FSql: string =
  'INSERT INTO GRUPOS_TRIBUTARIOS (' +
  '  ID,                           ' +
  '  EMPRESA_ID,                   ' +
  '  NOME,                         ' +
  '  ORIG,                         ' +
  '  CREATED_AT,                   ' +
  '  UPDATED_AT)                   ' +
  'VALUES (                        ' +
  '  :ID,                          ' +
  '  :EMPRESA_ID,                  ' +
  '  :NOME,                        ' +
  '  :ORIG,                        ' +
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
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NOME').DataType:= ftWideString;
      FDQuery.Params.ParamByName('ORIG').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      FDQuery.Params.ParamByName('ORIG').AsString:= Self.Orig;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('falha ao inserir grupo tributario. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TGrupoTributario.update: Boolean;
const
  FSql: string =
  'UPDATE GRUPOS_TRIBUTARIOS        ' +
  'SET NOME = :NOME,                ' +
  '    ORIG = :ORIG,                ' +
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
      FDQuery.Params.ParamByName('NOME').DataType:= ftWideString;
      FDQuery.Params.ParamByName('ORIG').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      FDQuery.Params.ParamByName('ORIG').AsString:= Self.Orig;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('falha ao atualizar grupo tributario. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TGrupoTributario.validate: Boolean;
var
  Validacao: string;
begin
  Result:= True;

  if Self.Nome = '' then
    Validacao:= 'Nome não foi preenchido.' + #13;

  if Validacao <> '' then
  begin
    THelper.Mensagem('Existem algumas pendencias!' + #13 + Validacao);
    Result:= False;
  end;
end;

end.
