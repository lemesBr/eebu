unit OperacaoFiscal;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TOperacaoFiscal = class(TModel)
  private
    FEMPRESA_ID: String;
    FNOME: String;
    FNATOP: String;
    FMODELO: String;
    FTPNF: String;
    FIDDEST: String;
    FTPIMP: String;
    FFINNFE: String;
    FINDFINAL: String;
    FINDPRES: String;


  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    function delete(): Boolean;
    function validate: Boolean;
    class function find(id: string): TOperacaoFiscal;
    class function list(search: string): TObjectList<TOperacaoFiscal>; overload;
    class procedure list(search: string; DataSet: TFDMemTable); overload;
    class function remove(id: string): Boolean;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property Nome: String  read FNOME write FNOME;
    property Natop: String  read FNATOP write FNATOP;
    property Modelo: String  read FMODELO write FMODELO;
    property Tpnf: String  read FTPNF write FTPNF;
    property Iddest: String  read FIDDEST write FIDDEST;
    property Tpimp: String  read FTPIMP write FTPIMP;
    property Finnfe: String  read FFINNFE write FFINNFE;
    property Indfinal: String  read FINDFINAL write FINDFINAL;
    property Indpres: String  read FINDPRES write FINDPRES;

  end;

implementation

uses
  AuthService, Helper;

{ TOperacaoFiscal }

constructor TOperacaoFiscal.Create;
begin
  Self.Table:= 'OPERACOES_FISCAIS';
end;

function TOperacaoFiscal.delete: Boolean;
const
  FSql: string =
  'UPDATE OPERACOES_FISCAIS         ' +
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
        raise Exception.Create('falha ao remover a operação fiscal. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TOperacaoFiscal.find(id: string): TOperacaoFiscal;
const
  FSql: string = 'SELECT * FROM OPERACOES_FISCAIS WHERE (ID = :ID)';
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
        Result:= TOperacaoFiscal.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.Nome:= FDQuery.FieldByName('NOME').AsString;
        Result.Natop:= FDQuery.FieldByName('NATOP').AsString;
        Result.Modelo:= FDQuery.FieldByName('MODELO').AsString;
        Result.Tpnf:= FDQuery.FieldByName('TPNF').AsString;
        Result.Iddest:= FDQuery.FieldByName('IDDEST').AsString;
        Result.Tpimp:= FDQuery.FieldByName('TPIMP').AsString;
        Result.Finnfe:= FDQuery.FieldByName('FINNFE').AsString;
        Result.Indfinal:= FDQuery.FieldByName('INDFINAL').AsString;
        Result.Indpres:= FDQuery.FieldByName('INDPRES').AsString;
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

class function TOperacaoFiscal.list(
  search: string): TObjectList<TOperacaoFiscal>;
const
  FSql: string =
  'SELECT O.ID FROM OPERACOES_FISCAIS O ' +
  'WHERE (O.EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (O.DELETED_AT IS NULL) ' +
  'AND (O.NOME LIKE :SEARCH) ORDER BY O.NOME';
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
        Result:= TObjectList<TOperacaoFiscal>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TOperacaoFiscal.find(FDQuery.FieldByName('ID').AsString));
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

class procedure TOperacaoFiscal.list(search: string; DataSet: TFDMemTable);
var
  vList: TObjectList<TOperacaoFiscal>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  vList:= TOperacaoFiscal.list(search);
  if Assigned(vList) then
  begin
    for I := 0 to Pred(vList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= vList.Items[I].Id;
      DataSet.FieldByName('NOME').AsString:= vList.Items[I].Nome;
      DataSet.Post;
    end;
    FreeAndNil(vList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TOperacaoFiscal.remove(id: string): Boolean;
var
  OperacaoFiscal: TOperacaoFiscal;
begin
  Result:= False;
  OperacaoFiscal:= TOperacaoFiscal.find(id);
  if not Assigned(OperacaoFiscal) then
  begin
    THelper.Mensagem('Operação fiscal não encontrada. A operação fiscal pode ter sido previamente excluída por outro usuário!');
    Exit();
  end;

  try
    if not THelper.Mensagem('Confirmar a exclusão desta operação fiscal?', 1) then
      Exit();

    Result:= OperacaoFiscal.delete();
  finally
    FreeAndNil(OperacaoFiscal);
  end;
end;

function TOperacaoFiscal.save: Boolean;
begin
  Result:= inherited;
end;

function TOperacaoFiscal.store: Boolean;
const
  FSql: string =
  'INSERT INTO OPERACOES_FISCAIS (' +
  '  ID,                          ' +
  '  EMPRESA_ID,                  ' +
  '  NOME,                        ' +
  '  NATOP,                       ' +
  '  MODELO,                      ' +
  '  TPNF,                        ' +
  '  IDDEST,                      ' +
  '  TPIMP,                       ' +
  '  FINNFE,                      ' +
  '  INDFINAL,                    ' +
  '  INDPRES,                     ' +
  '  CREATED_AT,                  ' +
  '  UPDATED_AT)                  ' +
  'VALUES (                       ' +
  '  :ID,                         ' +
  '  :EMPRESA_ID,                 ' +
  '  :NOME,                       ' +
  '  :NATOP,                      ' +
  '  :MODELO,                     ' +
  '  :TPNF,                       ' +
  '  :IDDEST,                     ' +
  '  :TPIMP,                      ' +
  '  :FINNFE,                     ' +
  '  :INDFINAL,                   ' +
  '  :INDPRES,                    ' +
  '  :CREATED_AT,                 ' +
  '  :UPDATED_AT)                 ';
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
      FDQuery.Params.ParamByName('NATOP').DataType:= ftWideString;
      FDQuery.Params.ParamByName('MODELO').DataType:= ftString;
      FDQuery.Params.ParamByName('TPNF').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('IDDEST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('TPIMP').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('FINNFE').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('INDFINAL').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('INDPRES').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      if (Self.Nome <> EmptyStr) then
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      if (Self.Natop <> EmptyStr) then
      FDQuery.Params.ParamByName('NATOP').AsString:= Self.Natop;
      if (Self.Modelo <> EmptyStr) then
      FDQuery.Params.ParamByName('MODELO').AsString:= Self.Modelo;
      if (Self.Tpnf <> EmptyStr) then
      FDQuery.Params.ParamByName('TPNF').AsString:= Self.Tpnf;
      if (Self.Iddest <> EmptyStr) then
      FDQuery.Params.ParamByName('IDDEST').AsString:= Self.Iddest;
      if (Self.Tpimp <> EmptyStr) then
      FDQuery.Params.ParamByName('TPIMP').AsString:= Self.Tpimp;
      if (Self.Finnfe <> EmptyStr) then
      FDQuery.Params.ParamByName('FINNFE').AsString:= Self.Finnfe;
      if (Self.Indfinal <> EmptyStr) then
      FDQuery.Params.ParamByName('INDFINAL').AsString:= Self.Indfinal;
      if (Self.Indpres <> EmptyStr) then
      FDQuery.Params.ParamByName('INDPRES').AsString:= Self.Indpres;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('falha ao inserir a operação fiscal. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TOperacaoFiscal.update: Boolean;
const
  FSql: string =
  'UPDATE OPERACOES_FISCAIS         ' +
  'SET NOME = :NOME,                ' +
  '    NATOP = :NATOP,              ' +
  '    MODELO = :MODELO,            ' +
  '    TPNF = :TPNF,                ' +
  '    IDDEST = :IDDEST,            ' +
  '    TPIMP = :TPIMP,              ' +
  '    FINNFE = :FINNFE,            ' +
  '    INDFINAL = :INDFINAL,        ' +
  '    INDPRES = :INDPRES,          ' +
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
      FDQuery.Params.ParamByName('NATOP').DataType:= ftWideString;
      FDQuery.Params.ParamByName('MODELO').DataType:= ftString;
      FDQuery.Params.ParamByName('TPNF').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('IDDEST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('TPIMP').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('FINNFE').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('INDFINAL').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('INDPRES').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.Nome <> EmptyStr) then
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      if (Self.Natop <> EmptyStr) then
      FDQuery.Params.ParamByName('NATOP').AsString:= Self.Natop;
      if (Self.Modelo <> EmptyStr) then
      FDQuery.Params.ParamByName('MODELO').AsString:= Self.Modelo;
      if (Self.Tpnf <> EmptyStr) then
      FDQuery.Params.ParamByName('TPNF').AsString:= Self.Tpnf;
      if (Self.Iddest <> EmptyStr) then
      FDQuery.Params.ParamByName('IDDEST').AsString:= Self.Iddest;
      if (Self.Tpimp <> EmptyStr) then
      FDQuery.Params.ParamByName('TPIMP').AsString:= Self.Tpimp;
      if (Self.Finnfe <> EmptyStr) then
      FDQuery.Params.ParamByName('FINNFE').AsString:= Self.Finnfe;
      if (Self.Indfinal <> EmptyStr) then
      FDQuery.Params.ParamByName('INDFINAL').AsString:= Self.Indfinal;
      if (Self.Indpres <> EmptyStr) then
      FDQuery.Params.ParamByName('INDPRES').AsString:= Self.Indpres;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('falha ao atualizar a operação fiscal. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TOperacaoFiscal.validate: Boolean;
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
