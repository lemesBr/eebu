unit FormaRecebimento;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type

  TFormaRecebimento = class(TModel)
  private
    FEMPRESA_ID: String;
    FTPAG: String;
    FNOME: String;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function find(id: string): TFormaRecebimento;
    class function list(search: string): TObjectList<TFormaRecebimento>; overload;
    class procedure list(search: string; DataSet: TFDMemTable); overload;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property Tpag: String  read FTPAG write FTPAG;
    property Nome: String  read FNOME write FNOME;

  end;

implementation

uses
  AuthService;



{ TFormaRecebimento }

constructor TFormaRecebimento.Create;
begin
  Self.Table:= 'FORMAS_RECEBIMENTOS';
end;

class function TFormaRecebimento.find(id: string): TFormaRecebimento;
const
  FSql: string = 'SELECT * FROM FORMAS_RECEBIMENTOS WHERE (ID = :ID)';
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
        Result:= TFormaRecebimento.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.Tpag:= FDQuery.FieldByName('TPAG').AsString;
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

class function TFormaRecebimento.list(
  search: string): TObjectList<TFormaRecebimento>;
const
  FSql: string =
  'SELECT * FROM FORMAS_RECEBIMENTOS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) AND (DELETED_AT IS NULL) ' +
  'AND (NOME LIKE :SEARCH) ORDER BY TPAG';
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
        Result:= TObjectList<TFormaRecebimento>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TFormaRecebimento.Create);
          Result.Last.Id:= FDQuery.FieldByName('ID').AsString;
          Result.Last.Tpag:= FDQuery.FieldByName('TPAG').AsString;
          Result.Last.Nome:= FDQuery.FieldByName('NOME').AsString;
          Result.Last.CreatedAt:= FDQuery.FieldByName('CREATED_AT').AsDateTime;
          Result.Last.UpdatedAt:= FDQuery.FieldByName('UPDATED_AT').AsDateTime;
          Result.Last.Synchronized:= FDQuery.FieldByName('SYNCHRONIZED').AsString;
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

class procedure TFormaRecebimento.list(search: string; DataSet: TFDMemTable);
var
  vList: TObjectList<TFormaRecebimento>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  vList:= TFormaRecebimento.list(search);
  if Assigned(vList) then
  begin
    for I := 0 to Pred(vList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= vList.Items[I].Id;
      DataSet.FieldByName('TPAG').AsString:= vList.Items[I].Tpag;
      DataSet.FieldByName('NOME').AsString:= vList.Items[I].Nome;
      DataSet.Post;
    end;
    FreeAndNil(vList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

function TFormaRecebimento.save: Boolean;
begin
  Result:= inherited;
end;

function TFormaRecebimento.store: Boolean;
const
  FSql: string =
  'INSERT INTO FORMAS_RECEBIMENTOS (' +
  '  ID,                            ' +
  '  EMPRESA_ID,                    ' +
  '  TPAG,                          ' +
  '  NOME,                          ' +
  '  CREATED_AT,                    ' +
  '  UPDATED_AT)                    ' +
  'VALUES (                         ' +
  '  :ID,                           ' +
  '  :EMPRESA_ID,                   ' +
  '  :TPAG,                         ' +
  '  :NOME,                         ' +
  '  :CREATED_AT,                   ' +
  '  :UPDATED_AT)                   ';
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
      FDQuery.Params.ParamByName('TPAG').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NOME').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      if (Self.Tpag <> EmptyStr) then
      FDQuery.Params.ParamByName('TPAG').AsString:= Self.Tpag;
      if (Self.Nome <> EmptyStr) then
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: Exception do
      begin
        Result:= False;
        raise Exception.Create('falha ao inserir a forma de recebimento. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TFormaRecebimento.update: Boolean;
const
  FSql: string =
  'UPDATE FORMAS_RECEBIMENTOS       ' +
  'SET TPAG = :TPAG,                ' +
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
      FDQuery.Params.ParamByName('TPAG').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NOME').DataType:= ftWideString;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.Tpag <> EmptyStr) then
      FDQuery.Params.ParamByName('TPAG').AsString:= Self.Tpag;
      if (Self.Nome <> EmptyStr) then
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: Exception do
      begin
        Result:= False;
        raise Exception.Create('falha ao atualizar a forma de recebimento. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
