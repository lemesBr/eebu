unit Terminal;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  Movimento, BalancaConfiguracao;

type

  TTerminal = class(TModel)
  private

    FEMPRESA_ID: String;
    FAUTHENTICATION: String;
    FREFERENCIA: Integer;
    FNOME: String;
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

    FMOVIMENTO_REFERENCIA: Integer;
    FVENDA_REFERENCIA: Integer;
    FRECEBIMENTO_REFERENCIA: Integer;
    FSERVER_ADDRESS: String;
    FSERVER_DATABASE: String;
    FSERVER_USER_NAME: String;
    FSERVER_USER_PASSWORD: String;
    FCARREGADO: String;

    FMOVIMENTO: TMovimento;
    FBALANCA: TBalancaConfiguracao;

    function getMovimento: TMovimento;
    function getBalanca: TBalancaConfiguracao;

  protected
    
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;

    class function findByAuthentication(Authentication: string): TTerminal;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property Authentication: String  read FAUTHENTICATION write FAUTHENTICATION;
    property Referencia: Integer  read FREFERENCIA write FREFERENCIA;
    property Nome: String  read FNOME write FNOME;
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

    property MovimentoReferencia: Integer  read FMOVIMENTO_REFERENCIA write FMOVIMENTO_REFERENCIA;
    property VendaReferencia: Integer  read FVENDA_REFERENCIA write FVENDA_REFERENCIA;
    property RecebimentoReferencia: Integer  read FRECEBIMENTO_REFERENCIA write FRECEBIMENTO_REFERENCIA;
    property ServerAddress: String  read FSERVER_ADDRESS write FSERVER_ADDRESS;
    property ServerDatabase: String  read FSERVER_DATABASE write FSERVER_DATABASE;
    property ServerUserName: String  read FSERVER_USER_NAME write FSERVER_USER_NAME;
    property ServerUserPassword: String  read FSERVER_USER_PASSWORD write FSERVER_USER_PASSWORD;
    property Carregado: String  read FCARREGADO write FCARREGADO;

    property Movimento: TMovimento read getMovimento;
    property Balanca: TBalancaConfiguracao read getBalanca;
  end;

implementation

{ TTerminal }

constructor TTerminal.Create;
begin
  Self.Table:= 'TERMINAIS';
end;

destructor TTerminal.Destroy;
begin
  if Assigned(self.FMOVIMENTO) then FreeAndNil(self.FMOVIMENTO);
  if Assigned(self.FBALANCA) then FreeAndNil(self.FBALANCA);

  inherited;
end;

class function TTerminal.findByAuthentication(
  Authentication: string): TTerminal;
const
  FSql: string = 'SELECT * FROM TERMINAIS WHERE (AUTHENTICATION = :ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ID').AsString:= Authentication;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TTerminal.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.Authentication:= FDQuery.FieldByName('AUTHENTICATION').AsString;
        Result.Referencia:= FDQuery.FieldByName('REFERENCIA').AsInteger;
        Result.Nome:= FDQuery.FieldByName('NOME').AsString;
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

        Result.MovimentoReferencia:= FDQuery.FieldByName('MOVIMENTO_REFERENCIA').AsInteger;
        Result.VendaReferencia:= FDQuery.FieldByName('VENDA_REFERENCIA').AsInteger;
        Result.RecebimentoReferencia:= FDQuery.FieldByName('RECEBIMENTO_REFERENCIA').AsInteger;
        Result.ServerAddress:= FDQuery.FieldByName('SERVER_ADDRESS').AsString;
        Result.ServerDatabase:= FDQuery.FieldByName('SERVER_DATABASE').AsString;
        Result.ServerUserName:= FDQuery.FieldByName('SERVER_USER_NAME').AsString;
        Result.ServerUserPassword:= FDQuery.FieldByName('SERVER_USER_PASSWORD').AsString;
        Result.Carregado:= FDQuery.FieldByName('CARREGADO').AsString;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TTerminal.getBalanca: TBalancaConfiguracao;
begin
  if not Assigned(Self.FBALANCA) then
    Self.FBALANCA:= TBalancaConfiguracao.find();

  Result:= Self.FBALANCA;
end;

function TTerminal.getMovimento: TMovimento;
begin
  if not Assigned(Self.FMOVIMENTO) then
    Self.FMOVIMENTO:= TMovimento.findByTerminal();

  Result:= Self.FMOVIMENTO;
end;

function TTerminal.save: Boolean;
const
  FSql: string =
  'UPDATE OR INSERT INTO TERMINAIS ( ' +
  '  ID,                             ' +
  '  EMPRESA_ID,                     ' +
  '  AUTHENTICATION,                 ' +
  '  REFERENCIA,                     ' +
  '  NOME,                           ' +
  '  CONTA_ID,                       ' +
  '  CATEGORIA_ID,                   ' +
  '  PESSOA_ID,                      ' +
  '  PARCELAMENTO,                   ' +
  '  PRINT_PATH,                     ' +
  '  NFCE_OPERACAO_FISCAL_ID,        ' +
  '  NFCE_NATOP,                     ' +
  '  NFCE_SERIE,                     ' +
  '  NFCE_NUMERO,                    ' +
  '  NFCE_PRINT_PATH,                ' +
  '  NFCE_PRINTER_MODEL,             ' +
  '  MOVIMENTO_REFERENCIA,           ' +
  '  VENDA_REFERENCIA,               ' +
  '  RECEBIMENTO_REFERENCIA,         ' +
  '  SERVER_ADDRESS,                 ' +
  '  SERVER_DATABASE,                ' +
  '  SERVER_USER_NAME,               ' +
  '  SERVER_USER_PASSWORD,           ' +
  '  CARREGADO)                      ' +
  'VALUES (                          ' +
  '  :ID,                            ' +
  '  :EMPRESA_ID,                    ' +
  '  :AUTHENTICATION,                ' +
  '  :REFERENCIA,                    ' +
  '  :NOME,                          ' +
  '  :CONTA_ID,                      ' +
  '  :CATEGORIA_ID,                  ' +
  '  :PESSOA_ID,                     ' +
  '  :PARCELAMENTO,                  ' +
  '  :PRINT_PATH,                    ' +
  '  :NFCE_OPERACAO_FISCAL_ID,       ' +
  '  :NFCE_NATOP,                    ' +
  '  :NFCE_SERIE,                    ' +
  '  :NFCE_NUMERO,                   ' +
  '  :NFCE_PRINT_PATH,               ' +
  '  :NFCE_PRINTER_MODEL,            ' +
  '  :MOVIMENTO_REFERENCIA,          ' +
  '  :VENDA_REFERENCIA,              ' +
  '  :RECEBIMENTO_REFERENCIA,        ' +
  '  :SERVER_ADDRESS,                ' +
  '  :SERVER_DATABASE,               ' +
  '  :SERVER_USER_NAME,              ' +
  '  :SERVER_USER_PASSWORD,          ' +
  '  :CARREGADO) MATCHING (ID)       ';
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
      FDQuery.Params.ParamByName('NOME').DataType:= ftString;
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

      FDQuery.Params.ParamByName('MOVIMENTO_REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('VENDA_REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('RECEBIMENTO_REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('SERVER_ADDRESS').DataType:= ftString;
      FDQuery.Params.ParamByName('SERVER_DATABASE').DataType:= ftString;
      FDQuery.Params.ParamByName('SERVER_USER_NAME').DataType:= ftString;
      FDQuery.Params.ParamByName('SERVER_USER_PASSWORD').DataType:= ftString;
      FDQuery.Params.ParamByName('CARREGADO').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('AUTHENTICATION').AsString:= Self.Authentication;
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= Self.Referencia;
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      FDQuery.Params.ParamByName('CONTA_ID').AsString:= Self.ContaId;
      FDQuery.Params.ParamByName('CATEGORIA_ID').AsString:= Self.CategoriaId;
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

      if (Self.MovimentoReferencia > 0) then
      FDQuery.Params.ParamByName('MOVIMENTO_REFERENCIA').AsInteger:= Self.MovimentoReferencia;
      if (Self.VendaReferencia > 0) then
      FDQuery.Params.ParamByName('VENDA_REFERENCIA').AsInteger:= Self.VendaReferencia;
      if (Self.RecebimentoReferencia > 0) then
      FDQuery.Params.ParamByName('RECEBIMENTO_REFERENCIA').AsInteger:= Self.RecebimentoReferencia;
      FDQuery.Params.ParamByName('SERVER_ADDRESS').AsString:= Self.ServerAddress;
      FDQuery.Params.ParamByName('SERVER_DATABASE').AsString:= Self.ServerDatabase;
      FDQuery.Params.ParamByName('SERVER_USER_NAME').AsString:= Self.ServerUserName;
      FDQuery.Params.ParamByName('SERVER_USER_PASSWORD').AsString:= Self.ServerUserPassword;
      FDQuery.Params.ParamByName('CARREGADO').AsString:= Self.Carregado;
      FDQuery.ExecSQL();
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao gravar dados do terminal. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
