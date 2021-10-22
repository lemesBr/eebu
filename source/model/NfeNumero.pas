unit NfeNumero;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TNfeNumero = class(TModel)
  private
    FEMPRESA_ID: String;
    FMODELO: Integer;
    FSERIE: Integer;
    FNUMERO: Integer;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function find(id: string): TNfeNumero;
    class function list(pSearch: Integer): TObjectList<TNfeNumero>; overload;
    class procedure list(pSearch: Integer; pDt: TFDMemTable); overload;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property Modelo: Integer  read FMODELO write FMODELO;
    property Serie: Integer  read FSERIE write FSERIE;
    property Numero: Integer  read FNUMERO write FNUMERO;

  end;

implementation

uses
  AuthService;

{ TNfeNumero }

constructor TNfeNumero.Create;
begin
  Self.Table:= 'NFE_NUMERO';
end;

class function TNfeNumero.find(id: string): TNfeNumero;
const
  FSql: string = 'SELECT * FROM NFE_NUMERO WHERE (ID = :ID)';
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
        Result:= TNfeNumero.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.Modelo:= FDQuery.FieldByName('MODELO').AsInteger;
        Result.Serie:= FDQuery.FieldByName('SERIE').AsInteger;
        Result.Numero:= FDQuery.FieldByName('NUMERO').AsInteger;
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

class procedure TNfeNumero.list(pSearch: Integer; pDt: TFDMemTable);
var
  vList: TObjectList<TNfeNumero>;
  I: Integer;
begin
  pDt.Open();
  pDt.DisableControls;
  pDt.EmptyDataSet;
  vList:= TNfeNumero.list(pSearch);
  if Assigned(vList) then
  begin
    for I := 0 to Pred(vList.Count) do
    begin
      pDt.Append;
      pDt.FieldByName('ID').AsString:= vList.Items[I].Id;
      pDt.FieldByName('MODELO').AsInteger:= vList.Items[I].Modelo;
      pDt.FieldByName('SERIE').AsInteger:= vList.Items[I].Serie;
      pDt.FieldByName('NUMERO').AsInteger:= vList.Items[I].Numero;
      pDt.Post;
    end;
    FreeAndNil(vList);
  end;
  pDt.First;
  pDt.EnableControls;
end;

class function TNfeNumero.list(pSearch: Integer): TObjectList<TNfeNumero>;
var
  FSql: string;
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FSql:=
      'SELECT N.ID FROM NFE_NUMERO N ' +
      'WHERE (N.EMPRESA_ID = :EMPRESA_ID) ' +
      'AND (N.DELETED_AT IS NULL) ';

      if (pSearch >= 1) then
        FSql:= FSql + 'AND ((N.MODELO = :SEARCH) OR (N.SERIE = :SEARCH) OR (N.NUMERO = :SEARCH))';

      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;

      if (pSearch >= 1) then
        FDQuery.Params.ParamByName('SEARCH').DataType:= ftInteger;

      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;

      if (pSearch >= 1) then
        FDQuery.Params.ParamByName('SEARCH').AsInteger:= pSearch;

      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TObjectList<TNfeNumero>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TNfeNumero.find(FDQuery.FieldByName('ID').AsString));
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

function TNfeNumero.save: Boolean;
begin
  Result:= inherited;
end;

function TNfeNumero.store: Boolean;
const
  FSql: string =
  'INSERT INTO NFE_NUMERO ( ' +
  '  ID,                    ' +
  '  EMPRESA_ID,            ' +
  '  MODELO,                ' +
  '  SERIE,                 ' +
  '  NUMERO,                ' +
  '  CREATED_AT,            ' +
  '  UPDATED_AT)            ' +
  'VALUES (                 ' +
  '  :ID,                   ' +
  '  :EMPRESA_ID,           ' +
  '  :MODELO,               ' +
  '  :SERIE,                ' +
  '  :NUMERO,               ' +
  '  :CREATED_AT,           ' +
  '  :UPDATED_AT)           ';
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
      FDQuery.Params.ParamByName('MODELO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('SERIE').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NUMERO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('MODELO').AsInteger:= Self.Modelo;
      FDQuery.Params.ParamByName('SERIE').AsInteger:= Self.Serie;
      FDQuery.Params.ParamByName('NUMERO').AsInteger:= Self.Numero;
      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao inserir NFE NUMERO. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeNumero.update: Boolean;
const
  FSql: string =
  'UPDATE NFE_NUMERO                ' +
  'SET MODELO = :MODELO,            ' +
  '    SERIE = :SERIE,              ' +
  '    NUMERO = :NUMERO,            ' +
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
      FDQuery.Params.ParamByName('MODELO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('SERIE').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NUMERO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftString;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('MODELO').AsInteger:= Self.Modelo;
      FDQuery.Params.ParamByName('SERIE').AsInteger:= Self.Serie;
      FDQuery.Params.ParamByName('NUMERO').AsInteger:= Self.Numero;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao atualizar NFE NUMERO. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
