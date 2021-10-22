unit Unidade;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TUnidade = class(TModel)
  private
    FEMPRESA_ID: String;
    FNOME: String;
    FUNIDADE: String;
    procedure getNome(const Value: String);
    procedure getUnidade(const Value: String);
    function setNome: String;
    function setUnidade: String;
    
  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    function delete(): Boolean;
    class function find(id: string): TUnidade;
    class function list(search: string): TObjectList<TUnidade>; overload;
    class procedure list(search: string; DataSet: TFDMemTable); overload;
    class function remove(id: string): Boolean;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property Nome: String  read setNome write getNome;
    property Unidade: String  read setUnidade write getUnidade;

  end;

implementation

uses
  AuthService, Helper;

{ TUnidade }

constructor TUnidade.Create;
begin
  Self.Table:= 'UNIDADES';
end;

function TUnidade.delete: Boolean;
const
  FSql: string =
  'UPDATE UNIDADES                  ' +
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
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('DELETED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftString;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('DELETED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao remover a unidade. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TUnidade.find(id: string): TUnidade;
const
  FSql: string = 'SELECT * FROM UNIDADES WHERE (ID = :ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ID').AsString:= id;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TUnidade.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.Nome:= FDQuery.FieldByName('NOME').AsString;
        Result.Unidade:= FDQuery.FieldByName('UNIDADE').AsString;
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

procedure TUnidade.getNome(const Value: String);
begin
  FNOME:= THelper.RemoveAcentos(Value);
end;

procedure TUnidade.getUnidade(const Value: String);
begin
  FUNIDADE:= THelper.RemoveAcentos(Value);
end;

class function TUnidade.list(search: string): TObjectList<TUnidade>;
const
  FSql: string =
  'SELECT U.ID FROM UNIDADES U ' +
  'WHERE (U.EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (U.DELETED_AT IS NULL) ' +
  'AND ((U.NOME LIKE :SEARCH) OR (U.UNIDADE LIKE :SEARCH))';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('SEARCH').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('SEARCH').AsString:= '%' + search + '%';
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TUnidade>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TUnidade.find(FDQuery.FieldByName('ID').AsString));
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

class procedure TUnidade.list(search: string; DataSet: TFDMemTable);
var
  vList: TObjectList<TUnidade>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  vList:= TUnidade.list(search);
  if Assigned(vList) then
  begin
    for I := 0 to Pred(vList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= vList.Items[I].Id;
      DataSet.FieldByName('NOME').AsString:= vList.Items[I].Nome;
      DataSet.FieldByName('UNIDADE').AsString:= vList.Items[I].Unidade;
      DataSet.Post;
    end;
    FreeAndNil(vList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TUnidade.remove(id: string): Boolean;
var
  Unidade: TUnidade;
begin
  Result:= False;
  Unidade:= TUnidade.find(id);
  if not Assigned(Unidade) then
  begin
    THelper.Mensagem('Unidade não encontrada. A unidade pode ter sido previamente removida por outro usuário!');
    Exit();
  end;

  try
    if not THelper.Mensagem('Deseja realmente remover?', 1) then
      Exit();

    Result:= Unidade.delete();
  finally
    FreeAndNil(Unidade);
  end;
end;

function TUnidade.save: Boolean;
begin
  Result:= inherited;
end;

function TUnidade.setNome: String;
begin
  Result:= THelper.RemoveAcentos(FNOME);
end;

function TUnidade.setUnidade: String;
begin
  Result:= THelper.RemoveAcentos(FUNIDADE);
end;

function TUnidade.store: Boolean;
const
  FSql: string =
  'INSERT INTO UNIDADES (' +
  '  ID,                 ' +
  '  EMPRESA_ID,         ' +
  '  NOME,               ' +
  '  UNIDADE,            ' +
  '  CREATED_AT,         ' +
  '  UPDATED_AT)         ' +
  'VALUES (              ' +
  '  :ID,                ' +
  '  :EMPRESA_ID,        ' +
  '  :NOME,              ' +
  '  :UNIDADE,           ' +
  '  :CREATED_AT,        ' +
  '  :UPDATED_AT)        ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= TModel.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('NOME').DataType:= ftString;
      FDQuery.Params.ParamByName('UNIDADE').DataType:= ftString;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      if (Self.EmpresaId = EmptyStr) then
        Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      FDQuery.Params.ParamByName('UNIDADE').AsString:= Self.Unidade;
      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao inserir a unidade. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TUnidade.update: Boolean;
const
  FSql: string =
  'UPDATE UNIDADES                  ' +
  'SET NOME = :NOME,                ' +
  '    UNIDADE = :UNIDADE,          ' +
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
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('NOME').DataType:= ftString;
      FDQuery.Params.ParamByName('UNIDADE').DataType:= ftString;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftString;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      FDQuery.Params.ParamByName('UNIDADE').AsString:= Self.Unidade;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao atualizar a unidade. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
