unit Categoria;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TCategoria = class(TModel)
  private
    FEMPRESA_ID: String;
    FCATEGORIA_ID: String;
    FTIPO: String;
    FNOME: String;
    FCATEGORIA: TCategoria;

    function getCategoria: TCategoria;
    function getNome: String;
    procedure setNome(const Value: String);
  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    function delete(): Boolean;
    class function find(id: string): TCategoria;
    class function list(search: string): TObjectList<TCategoria>; overload;
    class function remove(id: string): Boolean;
    class procedure list(search: string; DataSet: TFDMemTable); overload;
    class function listByCategoriaId(CategoriaId, search: string): TObjectList<TCategoria>;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property CategoriaId: String  read FCATEGORIA_ID write FCATEGORIA_ID;
    property Tipo: String  read FTIPO write FTIPO;
    property Nome: String  read getNome write setNome;

    property Categoria: TCategoria read getCategoria;
  end;

implementation

uses
  AuthService, Helper;

{ TCategoria }

constructor TCategoria.Create;
begin
  Self.Table:= 'CATEGORIAS';
end;

function TCategoria.delete: Boolean;
const
  FSql: string =
  'UPDATE CATEGORIAS                   ' +
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
        raise Exception.Create('falha ao remover a categoria. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

destructor TCategoria.Destroy;
begin
  if Assigned(FCATEGORIA) then FreeAndNil(FCATEGORIA);

  inherited;
end;

class function TCategoria.find(id: string): TCategoria;
const
  FSql: string = 'SELECT * FROM CATEGORIAS WHERE (ID = :ID)';
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
        Result:= TCategoria.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.CategoriaId:= FDQuery.FieldByName('CATEGORIA_ID').AsString;
        Result.Tipo:= FDQuery.FieldByName('TIPO').AsString;
        Result.Nome:= FDQuery.FieldByName('NOME').AsString;
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

function TCategoria.getCategoria: TCategoria;
begin
  if not Assigned(Self.FCATEGORIA) then
    Self.FCATEGORIA:= TCategoria.find(Self.FCATEGORIA_ID)
  else if Self.FCATEGORIA.Id <> Self.FCATEGORIA_ID then
  begin
    FreeAndNil(FCATEGORIA);
    Self.FCATEGORIA:= TCategoria.find(Self.FCATEGORIA_ID);
  end;
  Result:= Self.FCATEGORIA;
end;

function TCategoria.getNome: String;
begin
  Result:= THelper.RemoveAcentos(FNOME);
end;

class procedure TCategoria.list(search: string; DataSet: TFDMemTable);
var
  vList,
  vListSub: TObjectList<TCategoria>;
  I,J: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  vList:= TCategoria.list(search);
  if Assigned(vList) then
  begin
    for I:= 0 to Pred(vList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= vList.Items[I].Id;
      DataSet.FieldByName('CATEGORIA_ID').AsString:= vList.Items[I].CategoriaId;
      DataSet.FieldByName('TIPO').AsString:= vList.Items[I].Tipo;
      DataSet.FieldByName('NOME').AsString:= vList.Items[I].Nome;
      DataSet.Post;

      vListSub:= TCategoria.listByCategoriaId(vList.Items[I].Id, search);
      if Assigned(vListSub) then
      begin
        for J:= 0 to Pred(vListSub.Count) do
        begin
          DataSet.Append;
          DataSet.FieldByName('ID').AsString:= vListSub.Items[J].Id;
          DataSet.FieldByName('CATEGORIA_ID').AsString:= vListSub.Items[J].CategoriaId;
          DataSet.FieldByName('TIPO').AsString:= vListSub.Items[J].Tipo;
          DataSet.FieldByName('NOME').AsString:= '  ' + vListSub.Items[J].Nome;
          DataSet.Post;
        end;
        FreeAndNil(vListSub);
      end;
    end;
    FreeAndNil(vList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TCategoria.listByCategoriaId(
  CategoriaId, search: string): TObjectList<TCategoria>;
const
  FSql: string =
  'SELECT C.ID FROM CATEGORIAS C ' +
  'WHERE (C.EMPRESA_ID = :EMPRESA_ID) AND (C.DELETED_AT IS NULL) ' +
  'AND (C.CATEGORIA_ID = :CATEGORIA_ID) ' +
  'AND (C.DELETED_AT IS NULL) ' +
  'AND (C.NOME LIKE :SEARCH) ORDER BY C.NOME';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CATEGORIA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('SEARCH').DataType:= ftWideString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('CATEGORIA_ID').AsString:= CategoriaId;
      FDQuery.Params.ParamByName('SEARCH').AsString:= '%' + search + '%';
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TCategoria>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TCategoria.find(FDQuery.FieldByName('ID').AsString));
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

class function TCategoria.remove(id: string): Boolean;
var
  Categoria: TCategoria;
begin
  Result:= False;
  Categoria:= TCategoria.find(id);
  if not Assigned(Categoria) then
  begin
    THelper.Mensagem('Categoria não encontrado. A categoria pode ter sido previamente excluído por outro usuário!');
    Exit();
  end;

  try
    if not THelper.Mensagem('Confirmar a exclusão desta categoria?', 1) then
      Exit();

    Result:= Categoria.delete();
  finally
    FreeAndNil(Categoria);
  end;
end;

class function TCategoria.list(search: string): TObjectList<TCategoria>;
const
  FSql: string =
  'SELECT C.ID FROM CATEGORIAS C ' +
  'WHERE ((C.EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (C.DELETED_AT IS NULL) ' +
  'AND (C.CATEGORIA_ID IS NULL) ' +
  'AND (C.NOME LIKE :SEARCH)) OR ' +
  '(C.ID IN(SELECT C.CATEGORIA_ID FROM CATEGORIAS C ' +
  'WHERE (C.EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (C.DELETED_AT IS NULL) ' +
  'AND (C.CATEGORIA_ID IS NOT NULL) ' +
  'AND (C.NOME LIKE :SEARCH)))' +
  'ORDER BY C.TIPO DESC, C.NOME';
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
        Result:= TObjectList<TCategoria>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TCategoria.find(FDQuery.FieldByName('ID').AsString));
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

function TCategoria.save: Boolean;
begin
  Result:= inherited;
end;

procedure TCategoria.setNome(const Value: String);
begin
  FNOME:= THelper.RemoveAcentos(Value);
end;

function TCategoria.store: Boolean;
const
  FSql: string =
  'INSERT INTO CATEGORIAS (' +
  '  ID,                   ' +
  '  EMPRESA_ID,           ' +
  '  CATEGORIA_ID,         ' +
  '  TIPO,                 ' +
  '  NOME,                 ' +
  '  CREATED_AT,           ' +
  '  UPDATED_AT)           ' +
  'VALUES (                ' +
  '  :ID,                  ' +
  '  :EMPRESA_ID,          ' +
  '  :CATEGORIA_ID,        ' +
  '  :TIPO,                ' +
  '  :NOME,                ' +
  '  :CREATED_AT,          ' +
  '  :UPDATED_AT)          ';
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
      FDQuery.Params.ParamByName('CATEGORIA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('TIPO').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NOME').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      if (Self.EmpresaId = EmptyStr) then
        Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      if (Self.CategoriaId <> EmptyStr) then
        FDQuery.Params.ParamByName('CATEGORIA_ID').AsString:= Self.CategoriaId;
      FDQuery.Params.ParamByName('TIPO').AsString:= Self.Tipo;
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao inserir a categoria. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TCategoria.update: Boolean;
const
  FSql: string =
  'UPDATE CATEGORIAS                ' +
  'SET CATEGORIA_ID = :CATEGORIA_ID,' +
  '    TIPO = :TIPO,                ' +
  '    NOME = :NOME,                ' +
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
      FDQuery.Params.ParamByName('CATEGORIA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('TIPO').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NOME').DataType:= ftWideString;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.CategoriaId <> EmptyStr) then
        FDQuery.Params.ParamByName('CATEGORIA_ID').AsString:= Self.CategoriaId;
      FDQuery.Params.ParamByName('TIPO').AsString:= Self.Tipo;
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao atualizar a categoria. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
