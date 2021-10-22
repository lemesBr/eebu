unit Cartao;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  Pessoa;

type
  TCartao = class(TModel)
  private
    FEMPRESA_ID: String;
    FPESSOA_ID: String;
    FNOME: String;
    FMODALIDADE: String;
    FCOMPENSA_CREDITO: Integer;
    FTAXA_CREDITO: Extended;
    FCOMPENSA_DEBITO: Integer;
    FTAXA_DEBITO: Extended;
    FPESSOA: TPessoa;

    function getPessoa: TPessoa;
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
    class function find(id: string): TCartao;
    class function list(search: string): TObjectList<TCartao>; overload;
    class procedure list(search: string; DataSet: TFDMemTable); overload;
    class function listByModalidade(Modalidade: string): TObjectList<TCartao>; overload;
    class procedure listByModalidade(Modalidade: string; DataSet: TFDMemTable); overload;
    class function remove(id: string): Boolean;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property PessoaId: String  read FPESSOA_ID write FPESSOA_ID;
    property Nome: String  read getNome write setNome;
    property Modalidade: String  read FMODALIDADE write FMODALIDADE;
    property CompensaCredito: Integer  read FCOMPENSA_CREDITO write FCOMPENSA_CREDITO;
    property TaxaCredito: Extended  read FTAXA_CREDITO write FTAXA_CREDITO;
    property CompensaDebito: Integer  read FCOMPENSA_DEBITO write FCOMPENSA_DEBITO;
    property TaxaDebito: Extended  read FTAXA_DEBITO write FTAXA_DEBITO;

    property Pessoa: TPessoa read getPessoa;

  end;

implementation

uses
  AuthService, Helper;

{ TCartao }

constructor TCartao.Create;
begin
  Self.Table:= 'CARTOES';
end;

function TCartao.delete: Boolean;
const
  FSql: string =
  'UPDATE CARTOES                   ' +
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
        raise Exception.Create('Falha ao remover. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

destructor TCartao.Destroy;
begin
  if Assigned(FPESSOA) then FreeAndNil(FPESSOA);

  inherited;
end;

class function TCartao.find(id: string): TCartao;
const
  FSql: string = 'SELECT * FROM CARTOES WHERE (ID = :ID)';
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
        Result:= TCartao.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.PessoaId:= FDQuery.FieldByName('PESSOA_ID').AsString;
        Result.Nome:= FDQuery.FieldByName('NOME').AsString;
        Result.Modalidade:= FDQuery.FieldByName('MODALIDADE').AsString;
        Result.CompensaCredito:= FDQuery.FieldByName('COMPENSA_CREDITO').AsInteger;
        Result.TaxaCredito:= FDQuery.FieldByName('TAXA_CREDITO').AsExtended;
        Result.CompensaDebito:= FDQuery.FieldByName('COMPENSA_DEBITO').AsInteger;
        Result.TaxaDebito:= FDQuery.FieldByName('TAXA_DEBITO').AsExtended;
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

function TCartao.getNome: String;
begin
  Result:= THelper.RemoveAcentos(FNOME);
end;

function TCartao.getPessoa: TPessoa;
begin
  if not Assigned(Self.FPESSOA) then
    Self.FPESSOA:= TPessoa.find(Self.PessoaId)
  else if Self.FPESSOA.Id <> Self.PessoaId then
  begin
    FreeAndNil(FPESSOA);
    Self.FPESSOA:= TPessoa.find(Self.PessoaId);
  end;
  Result:= Self.FPESSOA;
end;

class function TCartao.list(search: string): TObjectList<TCartao>;
const
  FSql: string =
  'SELECT ID FROM CARTOES ' +
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
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('SEARCH').AsString:= '%' + search + '%';
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TCartao>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TCartao.find(FDQuery.FieldByName('ID').AsString));
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

class procedure TCartao.list(search: string; DataSet: TFDMemTable);
var
  vList: TObjectList<TCartao>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  vList:= TCartao.list(search);
  if Assigned(vList) then
  begin
    for I:= 0 to Pred(vList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= vList.Items[I].Id;
      DataSet.FieldByName('NOME').AsString:= vList.Items[I].Nome;
      DataSet.FieldByName('COMPENSA_CREDITO').AsInteger:= vList.Items[I].CompensaCredito;
      DataSet.FieldByName('TAXA_CREDITO').AsExtended:= vList.Items[I].TaxaCredito;
      DataSet.FieldByName('COMPENSA_DEBITO').AsInteger:= vList.Items[I].CompensaDebito;
      DataSet.FieldByName('TAXA_DEBITO').AsExtended:= vList.Items[I].TaxaDebito;
      DataSet.Post;
    end;
    FreeAndNil(vList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class procedure TCartao.listByModalidade(Modalidade: string;
  DataSet: TFDMemTable);
var
  vList: TObjectList<TCartao>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  vList:= TCartao.listByModalidade(Modalidade);
  if Assigned(vList) then
  begin
    for I:= 0 to Pred(vList.Count) do
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

class function TCartao.listByModalidade(
  Modalidade: string): TObjectList<TCartao>;
const
  FSql: string =
  'SELECT ID FROM CARTOES ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (DELETED_AT IS NULL) ' +
  'AND ((MODALIDADE = :MODALIDADE) OR ((MODALIDADE = ''X'') AND (:MODALIDADE IN(''C'',''D''))))';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('MODALIDADE').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('MODALIDADE').AsString:= Modalidade;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TCartao>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TCartao.find(FDQuery.FieldByName('ID').AsString));
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

class function TCartao.remove(id: string): Boolean;
var
  Cartao: TCartao;
begin
  Result:= False;
  Cartao:= TCartao.find(id);
  if not Assigned(Cartao) then
  begin
    THelper.Mensagem('Cartão não encontrado. O cartão pode ter sido previamente removido por outro usuário!');
    Exit();
  end;

  try
    if not THelper.Mensagem('Deseja realmente remover?', 1) then
      Exit();

    Result:= Cartao.delete();
  finally
    FreeAndNil(Cartao);
  end;
end;

function TCartao.save: Boolean;
begin
  Result:= inherited;
end;

procedure TCartao.setNome(const Value: String);
begin
  FNOME:= THelper.RemoveAcentos(Value);
end;

function TCartao.store: Boolean;
const
  FSql: string =
  'INSERT INTO CARTOES ( ' +
  '  ID,                 ' +
  '  EMPRESA_ID,         ' +
  '  PESSOA_ID,          ' +
  '  NOME,               ' +
  '  MODALIDADE,         ' +
  '  COMPENSA_CREDITO,   ' +
  '  TAXA_CREDITO,       ' +
  '  COMPENSA_DEBITO,    ' +
  '  TAXA_DEBITO,        ' +
  '  CREATED_AT,         ' +
  '  UPDATED_AT)         ' +
  'VALUES (              ' +
  '  :ID,                ' +
  '  :EMPRESA_ID,        ' +
  '  :PESSOA_ID,         ' +
  '  :NOME,              ' +
  '  :MODALIDADE,        ' +
  '  :COMPENSA_CREDITO,  ' +
  '  :TAXA_CREDITO,      ' +
  '  :COMPENSA_DEBITO,   ' +
  '  :TAXA_DEBITO,       ' +
  '  :CREATED_AT,        ' +
  '  :UPDATED_AT)        ';
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
      FDQuery.Params.ParamByName('PESSOA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('NOME').DataType:= ftString;
      FDQuery.Params.ParamByName('MODALIDADE').DataType:= ftString;
      FDQuery.Params.ParamByName('COMPENSA_CREDITO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('TAXA_CREDITO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('COMPENSA_DEBITO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('TAXA_DEBITO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('PESSOA_ID').AsString:= Self.PessoaId;
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      FDQuery.Params.ParamByName('MODALIDADE').AsString:= Self.Modalidade;
      FDQuery.Params.ParamByName('COMPENSA_CREDITO').AsInteger:= Self.CompensaCredito;
      FDQuery.Params.ParamByName('TAXA_CREDITO').AsExtended:= Self.TaxaCredito;
      FDQuery.Params.ParamByName('COMPENSA_DEBITO').AsInteger:= Self.CompensaDebito;
      FDQuery.Params.ParamByName('TAXA_DEBITO').AsExtended:= Self.TaxaDebito;
      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao inserir. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TCartao.update: Boolean;
const
  FSql: string =
  'UPDATE CARTOES                            ' +
  'SET PESSOA_ID = :PESSOA_ID,               ' +
  '    NOME = :NOME,                         ' +
  '    MODALIDADE = :MODALIDADE,             ' +
  '    COMPENSA_CREDITO = :COMPENSA_CREDITO, ' +
  '    TAXA_CREDITO = :TAXA_CREDITO,         ' +
  '    COMPENSA_DEBITO = :COMPENSA_DEBITO,   ' +
  '    TAXA_DEBITO = :TAXA_DEBITO,           ' +
  '    UPDATED_AT = :UPDATED_AT,             ' +
  '    SYNCHRONIZED = :SYNCHRONIZED          ' +
  'WHERE (ID = :ID)                          ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('PESSOA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('NOME').DataType:= ftString;
      FDQuery.Params.ParamByName('MODALIDADE').DataType:= ftString;
      FDQuery.Params.ParamByName('COMPENSA_CREDITO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('TAXA_CREDITO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('COMPENSA_DEBITO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('TAXA_DEBITO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftString;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('PESSOA_ID').AsString:= Self.PessoaId;
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      FDQuery.Params.ParamByName('MODALIDADE').AsString:= Self.Modalidade;
      FDQuery.Params.ParamByName('COMPENSA_CREDITO').AsInteger:= Self.CompensaCredito;
      FDQuery.Params.ParamByName('TAXA_CREDITO').AsExtended:= Self.TaxaCredito;
      FDQuery.Params.ParamByName('COMPENSA_DEBITO').AsInteger:= Self.CompensaDebito;
      FDQuery.Params.ParamByName('TAXA_DEBITO').AsExtended:= Self.TaxaDebito;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao atualizar. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
