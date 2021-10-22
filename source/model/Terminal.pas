unit Terminal;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  ACBrUtil, Conta, Categoria, Pessoa, OperacaoFiscal;

type
  TTerminal = class(TModel)
  private

    FEMPRESA_ID: String;
    FAUTHENTICATION: String;
    FREFERENCIA: Integer;
    FCONTA_ID: String;
    FCATEGORIA_ID: String;
    FPESSOA_ID: String;
    FPARCELAMENTO: Integer;
    FPRINT_PATH: String;
    FNFCE_OPERACAO_FISCAL_ID: String;
    FNFCE_NATOP: String;
    FNFCE_SERIE: Integer;
    FNFCE_NUMERO: Integer;
    FNFCE_PRINT_PATH: String;
    FNFCE_PRINTER_MODEL: Integer;

    FCONTA: TConta;
    FCATEGORIA: TCategoria;
    FPESSOA: TPessoa;
    FNFCE: TOperacaoFiscal;

    function getConta: TConta;
    function getCategoria: TCategoria;
    function getPessoa: TPessoa;
    function getNfce: TOperacaoFiscal;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    function delete(): Boolean;
    class function find(id: string): TTerminal;
    class function list(pReferencia: Integer): TObjectList<TTerminal>; overload;
    class procedure list(pReferencia: Integer; pDt: TFDMemTable); overload;
    class function remove(id: string): Boolean;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property Authentication: String  read FAUTHENTICATION write FAUTHENTICATION;
    property Referencia: Integer  read FREFERENCIA write FREFERENCIA;
    property ContaId: String  read FCONTA_ID write FCONTA_ID;
    property CategoriaId: String  read FCATEGORIA_ID write FCATEGORIA_ID;
    property PessoaId: String  read FPESSOA_ID write FPESSOA_ID;
    property Parcelamento: Integer  read FPARCELAMENTO write FPARCELAMENTO;
    property PrintPath: String  read FPRINT_PATH write FPRINT_PATH;
    property NfceOperacaoFiscalId: String  read FNFCE_OPERACAO_FISCAL_ID write FNFCE_OPERACAO_FISCAL_ID;
    property NfceNatop: String  read FNFCE_NATOP write FNFCE_NATOP;
    property NfceSerie: Integer  read FNFCE_SERIE write FNFCE_SERIE;
    property NfceNumero: Integer  read FNFCE_NUMERO write FNFCE_NUMERO;
    property NfcePrintPath: String  read FNFCE_PRINT_PATH write FNFCE_PRINT_PATH;
    property NfcePrinterModel: Integer  read FNFCE_PRINTER_MODEL write FNFCE_PRINTER_MODEL;

    property Conta: TConta read getConta;
    property Categoria: TCategoria read getCategoria;
    property Pessoa: TPessoa read getPessoa;
    property Nfce: TOperacaoFiscal read getNfce;
  end;

implementation

uses
  AuthService, Helper;

{ TTerminal }

constructor TTerminal.Create;
begin
  Self.Table:= 'TERMINAIS';
end;

function TTerminal.delete: Boolean;
const
  FSql: string =
  'UPDATE TERMINAIS                 ' +
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
        raise Exception.Create('Falha ao remover o terminal. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

destructor TTerminal.Destroy;
begin
  if Assigned(Self.FCONTA) then FreeAndNil(Self.FCONTA);
  if Assigned(Self.FCATEGORIA) then FreeAndNil(Self.FCATEGORIA);
  if Assigned(Self.FPESSOA) then FreeAndNil(Self.FPESSOA);
  if Assigned(Self.FNFCE) then FreeAndNil(Self.FNFCE);

  inherited;
end;

class function TTerminal.find(id: string): TTerminal;
const
  FSql: string = 'SELECT * FROM TERMINAIS WHERE (ID = :ID)';
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
        Result:= TTerminal.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.Authentication:= FDQuery.FieldByName('AUTHENTICATION').AsString;
        Result.Referencia:= FDQuery.FieldByName('REFERENCIA').AsInteger;
        Result.ContaId:= FDQuery.FieldByName('CONTA_ID').AsString;
        Result.CategoriaId:= FDQuery.FieldByName('CATEGORIA_ID').AsString;
        Result.PessoaId:= FDQuery.FieldByName('PESSOA_ID').AsString;
        Result.Parcelamento:= FDQuery.FieldByName('PARCELAMENTO').AsInteger;
        Result.PrintPath:= FDQuery.FieldByName('PRINT_PATH').AsString;

        Result.NfceOperacaoFiscalId:= FDQuery.FieldByName('NFCE_OPERACAO_FISCAL_ID').AsString;
        Result.NfceNatop:= FDQuery.FieldByName('NFCE_NATOP').AsString;
        Result.NfceSerie:= FDQuery.FieldByName('NFCE_SERIE').AsInteger;
        Result.NfceNumero:= FDQuery.FieldByName('NFCE_NUMERO').AsInteger;
        Result.NfcePrintPath:= FDQuery.FieldByName('NFCE_PRINT_PATH').AsString;
        Result.NfcePrinterModel:= FDQuery.FieldByName('NFCE_PRINTER_MODEL').AsInteger;

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

function TTerminal.getCategoria: TCategoria;
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

function TTerminal.getConta: TConta;
begin
  if not Assigned(Self.FCONTA) then
    Self.FCONTA:= TConta.find(Self.FCONTA_ID)
  else if Self.FCONTA.Id <> Self.FCONTA_ID then
  begin
    FreeAndNil(FCONTA);
    Self.FCONTA:= TConta.find(Self.FCONTA_ID);
  end;
  Result:= Self.FCONTA;
end;

function TTerminal.getNfce: TOperacaoFiscal;
begin
  if not Assigned(Self.FNFCE) then
    Self.FNFCE:= TOperacaoFiscal.find(Self.NfceOperacaoFiscalId)
  else if Self.FNFCE.Id <> Self.NfceOperacaoFiscalId then
  begin
    FreeAndNil(FNFCE);
    Self.FNFCE:= TOperacaoFiscal.find(Self.NfceOperacaoFiscalId);
  end;
  Result:= Self.FNFCE;
end;

function TTerminal.getPessoa: TPessoa;
begin
  if not Assigned(Self.FPESSOA) then
    Self.FPESSOA:= TPessoa.find(Self.FPESSOA_ID)
  else if Self.FPESSOA.Id <> Self.FPESSOA_ID then
  begin
    FreeAndNil(FPESSOA);
    Self.FPESSOA:= TPessoa.find(Self.FPESSOA_ID);
  end;
  Result:= Self.FPESSOA;
end;

class procedure TTerminal.list(pReferencia: Integer; pDt: TFDMemTable);
var
  vList: TObjectList<TTerminal>;
  I: Integer;
begin
  pDt.Open();
  pDt.DisableControls();
  pDt.EmptyDataSet();
  vList:= TTerminal.list(pReferencia);
  if Assigned(vList) then
  begin
    for I:= 0 to Pred(vList.Count) do
    begin
      pDt.Append();
      pDt.FieldByName('ID').AsString:= vList.Items[I].Id;
      pDt.FieldByName('AUTHENTICATION').AsString:= vList.Items[I].Authentication;
      pDt.FieldByName('NOME').AsString:= 'TERMINAL-' + PadLeft(vList.Items[I].Referencia.ToString(),2,'0');
      pDt.Post();
    end;
    FreeAndNil(vList);
  end;
  pDt.First();
  pDt.EnableControls();
end;

class function TTerminal.remove(id: string): Boolean;
var
  vTerminal: TTerminal;
begin
  Result:= False;
  vTerminal:= TTerminal.find(id);
  if not Assigned(vTerminal) then
  begin
    THelper.Mensagem('Terminal inexistente. O terminal pode ter sido previamente removido por outro usuário!');
    Exit();
  end;

  try
    if not THelper.Mensagem('Deseja realmente remover?', 1) then
      Exit();

    Result:= vTerminal.delete();
  finally
    FreeAndNil(vTerminal);
  end;
end;

class function TTerminal.list(pReferencia: Integer): TObjectList<TTerminal>;
var
  FSql: string;
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FSql:=
      'SELECT ID FROM TERMINAIS ' +
      'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
      'AND (DELETED_AT IS NULL) ';
      if (pReferencia >= 1) then
        FSql:= FSql + 'AND (REFERENCIA = :REFERENCIA)';

      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      if (pReferencia >= 1) then
        FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      if (pReferencia >= 1) then
        FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= pReferencia;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TTerminal>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TTerminal.find(FDQuery.FieldByName('ID').AsString));
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

function TTerminal.save: Boolean;
begin
  Result:= inherited;
end;

function TTerminal.store: Boolean;
const
  FSql: string =
  'INSERT INTO TERMINAIS (    ' +
  '  ID,                      ' +
  '  EMPRESA_ID,              ' +
  '  AUTHENTICATION,          ' +
  '  REFERENCIA,              ' +
  '  CONTA_ID,                ' +
  '  CATEGORIA_ID,            ' +
  '  PESSOA_ID,               ' +
  '  PARCELAMENTO,            ' +
  '  PRINT_PATH,              ' +
  '  NFCE_OPERACAO_FISCAL_ID, ' +
  '  NFCE_NATOP,              ' +
  '  NFCE_SERIE,              ' +
  '  NFCE_NUMERO,             ' +
  '  NFCE_PRINT_PATH,         ' +
  '  NFCE_PRINTER_MODEL,      ' +
  '  CREATED_AT,              ' +
  '  UPDATED_AT)              ' +
  'VALUES (                   ' +
  '  :ID,                     ' +
  '  :EMPRESA_ID,             ' +
  '  :AUTHENTICATION,         ' +
  '  :REFERENCIA,             ' +
  '  :CONTA_ID,               ' +
  '  :CATEGORIA_ID,           ' +
  '  :PESSOA_ID,              ' +
  '  :PARCELAMENTO,           ' +
  '  :PRINT_PATH,             ' +
  '  :NFCE_OPERACAO_FISCAL_ID,' +
  '  :NFCE_NATOP,             ' +
  '  :NFCE_SERIE,             ' +
  '  :NFCE_NUMERO,            ' +
  '  :NFCE_PRINT_PATH,        ' +
  '  :NFCE_PRINTER_MODEL,     ' +
  '  :CREATED_AT,             ' +
  '  :UPDATED_AT)             ';
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
      FDQuery.Params.ParamByName('AUTHENTICATION').DataType:= ftString;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CONTA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('CATEGORIA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('PESSOA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('PARCELAMENTO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('PRINT_PATH').DataType:= ftString;

      FDQuery.Params.ParamByName('NFCE_OPERACAO_FISCAL_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('NFCE_NATOP').DataType:= ftString;
      FDQuery.Params.ParamByName('NFCE_SERIE').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NFCE_NUMERO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NFCE_PRINT_PATH').DataType:= ftString;
      FDQuery.Params.ParamByName('NFCE_PRINTER_MODEL').DataType:= ftInteger;

      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare();

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;
      Self.Referencia:= Self.nextReferencia(Self.Referencia);

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      if (Self.Authentication <> EmptyStr) then
      FDQuery.Params.ParamByName('AUTHENTICATION').AsString:= Self.Authentication;
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= Self.Referencia;
      if (Self.ContaId <> EmptyStr) then
      FDQuery.Params.ParamByName('CONTA_ID').AsString:= Self.ContaId;
      if (Self.CategoriaId <> EmptyStr) then
      FDQuery.Params.ParamByName('CATEGORIA_ID').AsString:= Self.CategoriaId;
      if (Self.PessoaId <> EmptyStr) then
      FDQuery.Params.ParamByName('PESSOA_ID').AsString:= Self.PessoaId;
      if (Self.Parcelamento > 0) then
      FDQuery.Params.ParamByName('PARCELAMENTO').AsInteger:= Self.Parcelamento;
      if (Self.PrintPath <> EmptyStr) then
      FDQuery.Params.ParamByName('PRINT_PATH').AsString:= Self.PrintPath;

      if (Self.NfceOperacaoFiscalId <> EmptyStr) then
      FDQuery.Params.ParamByName('NFCE_OPERACAO_FISCAL_ID').AsString:= Self.NfceOperacaoFiscalId;
      if (Self.NfceNatop <> EmptyStr) then
      FDQuery.Params.ParamByName('NFCE_NATOP').AsString:= Self.NfceNatop;
      if (Self.NfceSerie >= 1) then
      FDQuery.Params.ParamByName('NFCE_SERIE').AsInteger:= Self.NfceSerie;
      if (Self.NfceNumero >= 0) then
      FDQuery.Params.ParamByName('NFCE_NUMERO').AsInteger:= Self.NfceNumero;
      if (Self.NfcePrintPath <> EmptyStr) then
      FDQuery.Params.ParamByName('NFCE_PRINT_PATH').AsString:= Self.NfcePrintPath;
      if (Self.NfcePrinterModel >= 1) then
      FDQuery.Params.ParamByName('NFCE_PRINTER_MODEL').AsInteger:= Self.NfcePrinterModel;

      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.ExecSQL();
    except on e: exception do
    begin
      Result:= False;
      raise Exception.Create('Falha ao inserir o terminal. Erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TTerminal.update: Boolean;
const
  FSql: string =
  'UPDATE TERMINAIS                                         ' +
  'SET CONTA_ID = :CONTA_ID,                                ' +
  '    CATEGORIA_ID = :CATEGORIA_ID,                        ' +
  '    PESSOA_ID = :PESSOA_ID,                              ' +
  '    PARCELAMENTO = :PARCELAMENTO,                        ' +
  '    PRINT_PATH = :PRINT_PATH,                            ' +
  '    NFCE_OPERACAO_FISCAL_ID = :NFCE_OPERACAO_FISCAL_ID,  ' +
  '    NFCE_NATOP = :NFCE_NATOP,                            ' +
  '    NFCE_SERIE = :NFCE_SERIE,                            ' +
  '    NFCE_NUMERO = :NFCE_NUMERO,                          ' +
  '    NFCE_PRINT_PATH = :NFCE_PRINT_PATH,                  ' +
  '    NFCE_PRINTER_MODEL = :NFCE_PRINTER_MODEL,            ' +
  '    UPDATED_AT = :UPDATED_AT,                            ' +
  '    SYNCHRONIZED = :SYNCHRONIZED                         ' +
  'WHERE (ID = :ID)                                         ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('CONTA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('CATEGORIA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('PESSOA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('PARCELAMENTO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('PRINT_PATH').DataType:= ftString;

      FDQuery.Params.ParamByName('NFCE_OPERACAO_FISCAL_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('NFCE_NATOP').DataType:= ftString;
      FDQuery.Params.ParamByName('NFCE_SERIE').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NFCE_NUMERO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NFCE_PRINT_PATH').DataType:= ftString;
      FDQuery.Params.ParamByName('NFCE_PRINTER_MODEL').DataType:= ftInteger;

      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftString;
      FDQuery.Prepare();

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.ContaId <> EmptyStr) then
      FDQuery.Params.ParamByName('CONTA_ID').AsString:= Self.ContaId;
      if (Self.CategoriaId <> EmptyStr) then
      FDQuery.Params.ParamByName('CATEGORIA_ID').AsString:= Self.CategoriaId;
      if (Self.PessoaId <> EmptyStr) then
      FDQuery.Params.ParamByName('PESSOA_ID').AsString:= Self.PessoaId;
      if (Self.Parcelamento > 0) then
      FDQuery.Params.ParamByName('PARCELAMENTO').AsInteger:= Self.Parcelamento;
      if (Self.PrintPath <> EmptyStr) then
      FDQuery.Params.ParamByName('PRINT_PATH').AsString:= Self.PrintPath;

      if (Self.NfceOperacaoFiscalId <> EmptyStr) then
      FDQuery.Params.ParamByName('NFCE_OPERACAO_FISCAL_ID').AsString:= Self.NfceOperacaoFiscalId;
      if (Self.NfceNatop <> EmptyStr) then
      FDQuery.Params.ParamByName('NFCE_NATOP').AsString:= Self.NfceNatop;
      if (Self.NfceSerie >= 1) then
      FDQuery.Params.ParamByName('NFCE_SERIE').AsInteger:= Self.NfceSerie;
      if (Self.NfceNumero >= 0) then
      FDQuery.Params.ParamByName('NFCE_NUMERO').AsInteger:= Self.NfceNumero;
      if (Self.NfcePrintPath <> EmptyStr) then
      FDQuery.Params.ParamByName('NFCE_PRINT_PATH').AsString:= Self.NfcePrintPath;
      if (Self.NfcePrinterModel >= 1) then
      FDQuery.Params.ParamByName('NFCE_PRINTER_MODEL').AsInteger:= Self.NfcePrinterModel;

      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL();
    except on e: exception do
    begin
      Result:= False;
      raise Exception.Create('Falha ao atualizar o terminal. Erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
