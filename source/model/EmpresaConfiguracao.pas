unit EmpresaConfiguracao;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  Conta, Categoria, OperacaoFiscal, Pessoa;

type
  TEmpresaConfiguracao = class(TModel)
  private
    FEMPRESA_ID: String;
    FVENDA_CONTA_ID: String;
    FVENDA_CATEGORIA_ID: String;
    FVENDA_PESSOA_DEFAULT: String;
    FNFCE_OPERACAO_FISCAL_ID: String;
    FNFE_OPERACAO_FISCAL_ID: String;
    FPARCELAMENTO: Integer;
    FPRINT_PATH: String;
    FPRINT_MODE: Integer;
    FCONTA: TConta;
    FCATEGORIA: TCategoria;
    FPESSOA: TPessoa;
    FNFCE: TOperacaoFiscal;
    FNFE: TOperacaoFiscal;

    function getConta: TConta;
    function getCategoria: TCategoria;
    function getPessoa: TPessoa;
    function getNfce: TOperacaoFiscal;
    function getNfe: TOperacaoFiscal;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    function validate: Boolean;
    class function findByEmpresaId(): TEmpresaConfiguracao;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property VendaContaId: String  read FVENDA_CONTA_ID write FVENDA_CONTA_ID;
    property VendaCategoriaId: String  read FVENDA_CATEGORIA_ID write FVENDA_CATEGORIA_ID;
    property VendaPessoaDefault: String  read FVENDA_PESSOA_DEFAULT write FVENDA_PESSOA_DEFAULT;
    property NfceOperacaoFiscalId: String  read FNFCE_OPERACAO_FISCAL_ID write FNFCE_OPERACAO_FISCAL_ID;
    property NfeOperacaoFiscalId: String  read FNFE_OPERACAO_FISCAL_ID write FNFE_OPERACAO_FISCAL_ID;
    property Parcelamento: Integer  read FPARCELAMENTO write FPARCELAMENTO;
    property PrintPath: String  read FPRINT_PATH write FPRINT_PATH;
    property PrintMode: Integer  read FPRINT_MODE write FPRINT_MODE;

    property Conta: TConta read getConta;
    property Categoria: TCategoria read getCategoria;
    property Pessoa: TPessoa read getPessoa;
    property Nfce: TOperacaoFiscal read getNfce;
    property Nfe: TOperacaoFiscal read getNfe;

  end;

implementation

uses
  AuthService, Helper;

{ TEmpresaConfiguracao }

constructor TEmpresaConfiguracao.Create;
begin
  Self.Table:= 'EMPRESA_CONFIGURACOES';
end;

destructor TEmpresaConfiguracao.Destroy;
begin
  if Assigned(Self.FCONTA) then FreeAndNil(Self.FCONTA);
  if Assigned(Self.FCATEGORIA) then FreeAndNil(Self.FCATEGORIA);
  if Assigned(Self.FPESSOA) then FreeAndNil(Self.FPESSOA);
  if Assigned(Self.FNFCE) then FreeAndNil(Self.FNFCE);
  if Assigned(Self.FNFE) then FreeAndNil(Self.FNFE);

  inherited;
end;

class function TEmpresaConfiguracao.findByEmpresaId: TEmpresaConfiguracao;
const
  FSql: string =
  'SELECT * FROM EMPRESA_CONFIGURACOES ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TEmpresaConfiguracao.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.VendaContaId:= FDQuery.FieldByName('VENDA_CONTA_ID').AsString;
        Result.VendaCategoriaId:= FDQuery.FieldByName('VENDA_CATEGORIA_ID').AsString;
        Result.VendaPessoaDefault:= FDQuery.FieldByName('VENDA_PESSOA_DEFAULT').AsString;
        Result.NfceOperacaoFiscalId:= FDQuery.FieldByName('NFCE_OPERACAO_FISCAL_ID').AsString;
        Result.NfeOperacaoFiscalId:= FDQuery.FieldByName('NFE_OPERACAO_FISCAL_ID').AsString;
        Result.Parcelamento:= FDQuery.FieldByName('PARCELAMENTO').AsInteger;
        Result.PrintPath:= FDQuery.FieldByName('PRINT_PATH').AsString;
        Result.PrintMode:= FDQuery.FieldByName('PRINT_MODE').AsInteger;
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

function TEmpresaConfiguracao.getCategoria: TCategoria;
begin
  if not Assigned(Self.FCATEGORIA) then
    Self.FCATEGORIA:= TCategoria.find(Self.VendaCategoriaId)
  else if Self.FCATEGORIA.Id <> Self.VendaCategoriaId then
  begin
    FreeAndNil(FCATEGORIA);
    Self.FCATEGORIA:= TCategoria.find(Self.VendaCategoriaId);
  end;
  Result:= Self.FCATEGORIA;
end;

function TEmpresaConfiguracao.getConta: TConta;
begin
  if not Assigned(Self.FCONTA) then
    Self.FCONTA:= TConta.find(Self.VendaContaId)
  else if Self.FCONTA.Id <> Self.VendaContaId then
  begin
    FreeAndNil(FCONTA);
    Self.FCONTA:= TConta.find(Self.VendaContaId);
  end;
  Result:= Self.FCONTA;
end;

function TEmpresaConfiguracao.getNfce: TOperacaoFiscal;
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

function TEmpresaConfiguracao.getNfe: TOperacaoFiscal;
begin
  if not Assigned(Self.FNFE) then
    Self.FNFE:= TOperacaoFiscal.find(Self.NfeOperacaoFiscalId)
  else if Self.FNFE.Id <> Self.NfeOperacaoFiscalId then
  begin
    FreeAndNil(FNFE);
    Self.FNFE:= TOperacaoFiscal.find(Self.NfeOperacaoFiscalId);
  end;
  Result:= Self.FNFE;
end;

function TEmpresaConfiguracao.getPessoa: TPessoa;
begin
  if not Assigned(Self.FPESSOA) then
    Self.FPESSOA:= TPessoa.find(Self.VendaPessoaDefault)
  else if Self.FPESSOA.Id <> Self.VendaPessoaDefault then
  begin
    FreeAndNil(FPESSOA);
    Self.FPESSOA:= TPessoa.find(Self.VendaPessoaDefault);
  end;
  Result:= Self.FPESSOA;
end;

function TEmpresaConfiguracao.save: Boolean;
begin
  Result:= inherited;
end;

function TEmpresaConfiguracao.store: Boolean;
const
  FSql: string =
  'INSERT INTO EMPRESA_CONFIGURACOES (' +
  '  ID,                              ' +
  '  EMPRESA_ID,                      ' +
  '  VENDA_CONTA_ID,                  ' +
  '  VENDA_CATEGORIA_ID,              ' +
  '  VENDA_PESSOA_DEFAULT,            ' +
  '  NFCE_OPERACAO_FISCAL_ID,         ' +
  '  NFE_OPERACAO_FISCAL_ID,          ' +
  '  PARCELAMENTO,                    ' +
  '  PRINT_PATH,                      ' +
  '  PRINT_MODE,                      ' +
  '  CREATED_AT,                      ' +
  '  UPDATED_AT)                      ' +
  'VALUES (                           ' +
  '  :ID,                             ' +
  '  :EMPRESA_ID,                     ' +
  '  :VENDA_CONTA_ID,                 ' +
  '  :VENDA_CATEGORIA_ID,             ' +
  '  :VENDA_PESSOA_DEFAULT,           ' +
  '  :NFCE_OPERACAO_FISCAL_ID,        ' +
  '  :NFE_OPERACAO_FISCAL_ID,         ' +
  '  :PARCELAMENTO,                   ' +
  '  :PRINT_PATH,                     ' +
  '  :PRINT_MODE,                     ' +
  '  :CREATED_AT,                     ' +
  '  :UPDATED_AT)                     ';
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
      FDQuery.Params.ParamByName('VENDA_CONTA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('VENDA_CATEGORIA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('VENDA_PESSOA_DEFAULT').DataType:= ftString;
      FDQuery.Params.ParamByName('NFCE_OPERACAO_FISCAL_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('NFE_OPERACAO_FISCAL_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('PARCELAMENTO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('PRINT_PATH').DataType:= ftString;
      FDQuery.Params.ParamByName('PRINT_MODE').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      if (Self.VendaContaId <> EmptyStr) then
      FDQuery.Params.ParamByName('VENDA_CONTA_ID').AsString:= Self.VendaContaId;
      if (Self.VendaCategoriaId <> EmptyStr) then
      FDQuery.Params.ParamByName('VENDA_CATEGORIA_ID').AsString:= Self.VendaCategoriaId;
      if (Self.VendaPessoaDefault <> EmptyStr) then
      FDQuery.Params.ParamByName('VENDA_PESSOA_DEFAULT').AsString:= Self.VendaPessoaDefault;
      if (Self.NfceOperacaoFiscalId <> EmptyStr) then
      FDQuery.Params.ParamByName('NFCE_OPERACAO_FISCAL_ID').AsString:= Self.NfceOperacaoFiscalId;
      if (Self.NfeOperacaoFiscalId <> EmptyStr) then
      FDQuery.Params.ParamByName('NFE_OPERACAO_FISCAL_ID').AsString:= Self.NfeOperacaoFiscalId;
      if (Self.Parcelamento >= 0) then
      FDQuery.Params.ParamByName('PARCELAMENTO').AsInteger:= Self.Parcelamento;
      if (Self.PrintPath <> EmptyStr) then
      FDQuery.Params.ParamByName('PRINT_PATH').AsString:= Self.PrintPath;
      if (Self.PrintMode >= 0) then
      FDQuery.Params.ParamByName('PRINT_MODE').AsInteger:= Self.PrintMode;
      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now();
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now();
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

function TEmpresaConfiguracao.update: Boolean;
const
  FSql: string =
  'UPDATE EMPRESA_CONFIGURACOES                           ' +
  'SET VENDA_CONTA_ID = :VENDA_CONTA_ID,                  ' +
  '    VENDA_CATEGORIA_ID = :VENDA_CATEGORIA_ID,          ' +
  '    VENDA_PESSOA_DEFAULT = :VENDA_PESSOA_DEFAULT,      ' +
  '    NFCE_OPERACAO_FISCAL_ID = :NFCE_OPERACAO_FISCAL_ID,' +
  '    NFE_OPERACAO_FISCAL_ID = :NFE_OPERACAO_FISCAL_ID,  ' +
  '    PARCELAMENTO = :PARCELAMENTO,                      ' +
  '    PRINT_PATH = :PRINT_PATH,                          ' +
  '    PRINT_MODE = :PRINT_MODE,                          ' +
  '    UPDATED_AT = :UPDATED_AT,                          ' +
  '    SYNCHRONIZED = :SYNCHRONIZED                       ' +
  'WHERE (ID = :ID)                                       ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('VENDA_CONTA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('VENDA_CATEGORIA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('VENDA_PESSOA_DEFAULT').DataType:= ftString;
      FDQuery.Params.ParamByName('NFCE_OPERACAO_FISCAL_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('NFE_OPERACAO_FISCAL_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('PARCELAMENTO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('PRINT_PATH').DataType:= ftString;
      FDQuery.Params.ParamByName('PRINT_MODE').DataType:= ftInteger;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftString;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.VendaContaId <> EmptyStr) then
      FDQuery.Params.ParamByName('VENDA_CONTA_ID').AsString:= Self.VendaContaId;
      if (Self.VendaCategoriaId <> EmptyStr) then
      FDQuery.Params.ParamByName('VENDA_CATEGORIA_ID').AsString:= Self.VendaCategoriaId;
      if (Self.VendaPessoaDefault <> EmptyStr) then
      FDQuery.Params.ParamByName('VENDA_PESSOA_DEFAULT').AsString:= Self.VendaPessoaDefault;
      if (Self.NfceOperacaoFiscalId <> EmptyStr) then
      FDQuery.Params.ParamByName('NFCE_OPERACAO_FISCAL_ID').AsString:= Self.NfceOperacaoFiscalId;
      if (Self.NfeOperacaoFiscalId <> EmptyStr) then
      FDQuery.Params.ParamByName('NFE_OPERACAO_FISCAL_ID').AsString:= Self.NfeOperacaoFiscalId;
      if (Self.Parcelamento >= 0) then
      FDQuery.Params.ParamByName('PARCELAMENTO').AsInteger:= Self.Parcelamento;
      if (Self.PrintPath <> EmptyStr) then
      FDQuery.Params.ParamByName('PRINT_PATH').AsString:= Self.PrintPath;
      if (Self.PrintMode >= 0) then
      FDQuery.Params.ParamByName('PRINT_MODE').AsInteger:= Self.PrintMode;
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

function TEmpresaConfiguracao.validate: Boolean;
var
  Validacao: string;
begin
  Result:= True;

  if Self.VendaContaId = '' then
    Validacao:= 'Conta de Recebimento não foi preenchido!' + #13;

  if Self.VendaCategoriaId = '' then
    Validacao:= Validacao + 'Categoria de Recebimento não foi preenchido!' + #13;

  if Validacao <> '' then
  begin
    THelper.Mensagem('Existem algumas pendencias!' + #13 + Validacao);
    Result:= False;
  end;
end;

end.
