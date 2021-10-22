unit Turno;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TTurno = class(TModel)
  private
    FEMPRESA_ID: String;
    FREFERENCIA: Integer;
    FNOME: String;
    FINICIO: String;
    FFIM: String;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    function delete(): Boolean;
    class function find(id: string): TTurno;
    class function list(pSearch: string): TObjectList<TTurno>; overload;
    class procedure list(pSearch: string; pDt: TFDMemTable); overload;
    class function remove(id: string): Boolean;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property Referencia: Integer  read FREFERENCIA write FREFERENCIA;
    property Nome: String  read FNOME write FNOME;
    property Inicio: String  read FINICIO write FINICIO;
    property Fim: String  read FFIM write FFIM;

  end;

implementation

uses
  AuthService, Helper;

{ TTurno }

constructor TTurno.Create;
begin
  Self.Table:= 'TURNOS';
end;

function TTurno.delete: Boolean;
const
  FSql: string =
  'UPDATE TURNOS                    ' +
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
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('DELETED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL();
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao remover o turno. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TTurno.find(id: string): TTurno;
const
  FSql: string = 'SELECT * FROM TURNOS WHERE (ID = :ID)';
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
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TTurno.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.Referencia:= FDQuery.FieldByName('REFERENCIA').AsInteger;
        Result.Nome:= FDQuery.FieldByName('NOME').AsString;
        Result.Inicio:= FDQuery.FieldByName('INICIO').AsString;
        Result.Fim:= FDQuery.FieldByName('FIM').AsString;
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

class function TTurno.list(pSearch: string): TObjectList<TTurno>;
const
  FSql: string =
  'SELECT ID FROM TURNOS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (DELETED_AT IS NULL) ' +
  'AND (NOME LIKE :SEARCH)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('SEARCH').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('SEARCH').AsString:= '%' + pSearch + '%';
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TObjectList<TTurno>.Create;
        FDQuery.First();
        while not FDQuery.Eof do
        begin
          Result.Add(TTurno.find(FDQuery.FieldByName('ID').AsString));
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

class procedure TTurno.list(pSearch: string; pDt: TFDMemTable);
var
  vList: TObjectList<TTurno>;
  I: Integer;
begin
  pDt.Open();
  pDt.DisableControls();
  pDt.EmptyDataSet();
  vList:= TTurno.list(pSearch);
  if Assigned(vList) then
  begin
    for I:= 0 to Pred(vList.Count) do
    begin
      pDt.Append();
      pDt.FieldByName('ID').AsString:= vList.Items[I].Id;
      pDt.FieldByName('NOME').AsString:= vList.Items[I].Nome;
      pDt.FieldByName('INICIO').AsString:= vList.Items[I].Inicio;
      pDt.FieldByName('FIM').AsString:= vList.Items[I].Fim;
      pDt.Post();
    end;
    FreeAndNil(vList);
  end;
  pDt.First();
  pDt.EnableControls();
end;

class function TTurno.remove(id: string): Boolean;
var
  vTurno: TTurno;
begin
  Result:= False;
  vTurno:= TTurno.find(id);
  if not Assigned(vTurno) then
  begin
    THelper.Mensagem('Turno inexistente. O turno pode ter sido previamente removido por outro usuário!');
    Exit();
  end;

  try
    if not THelper.Mensagem('Deseja realmente remover?', 1) then
      Exit();

    Result:= vTurno.delete();
  finally
    FreeAndNil(vTurno);
  end;
end;

function TTurno.save: Boolean;
begin
  Result:= inherited;
end;

function TTurno.store: Boolean;
const
  FSql: string =
  'INSERT INTO TURNOS ( ' +
  '  ID,                ' +
  '  EMPRESA_ID,        ' +
  '  REFERENCIA,        ' +
  '  NOME,              ' +
  '  INICIO,            ' +
  '  FIM,               ' +
  '  CREATED_AT,        ' +
  '  UPDATED_AT)        ' +
  'VALUES (             ' +
  '  :ID,               ' +
  '  :EMPRESA_ID,       ' +
  '  :REFERENCIA,       ' +
  '  :NOME,             ' +
  '  :INICIO,           ' +
  '  :FIM,              ' +
  '  :CREATED_AT,       ' +
  '  :UPDATED_AT)       ';
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
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NOME').DataType:= ftString;
      FDQuery.Params.ParamByName('INICIO').DataType:= ftString;
      FDQuery.Params.ParamByName('FIM').DataType:= ftString;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare();

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;
      Self.Referencia:= Self.nextReferencia(Self.Referencia);

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= Self.Referencia;
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      FDQuery.Params.ParamByName('INICIO').AsString:= Self.Inicio;
      FDQuery.Params.ParamByName('FIM').AsString:= Self.Fim;
      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.ExecSQL();
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('Falha ao inserir o turno. Erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TTurno.update: Boolean;
const
  FSql: string =
  'UPDATE TURNOS                    ' +
  'SET REFERENCIA = :REFERENCIA,    ' +
  '    NOME = :NOME,                ' +
  '    INICIO = :INICIO,            ' +
  '    FIM = :FIM,                  ' +
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
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NOME').DataType:= ftString;
      FDQuery.Params.ParamByName('INICIO').DataType:= ftString;
      FDQuery.Params.ParamByName('FIM').DataType:= ftString;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= Self.Referencia;
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      FDQuery.Params.ParamByName('INICIO').AsString:= Self.Inicio;
      FDQuery.Params.ParamByName('FIM').AsString:= Self.Fim;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL();
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('Falha ao atualizar o turno. Erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
