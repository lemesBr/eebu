unit Recebimento;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  Cartao;

type
  TRecebimento = class(TModel)
  private
    FEMPRESA_ID: String;
    FCONTA_ID: String;
    FPESSOA_ID: String;
    FCATEGORIA_ID: String;
    FVENDA_ID: String;
    FCARTAO_ID: String;
    FMODALIDADE: String;
    FPARCELA: Integer;
    FQTDE_PARCELAS: Integer;
    FREFERENCIA: Integer;
    FDESCRICAO: String;
    FCOMPETENCIA: TDateTime;
    FVALOR: Extended;
    FDESCONTOS_TAXAS: Extended;
    FJUROS_MULTA: Extended;
    FVALOR_RECEBIDO: Extended;
    FVENCIMENTO: TDateTime;
    FRECEBIMENTO: TDateTime;
    FSITUACAO: String;
    FCARTAO: TCartao;

    function getCartao: TCartao;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function  save(): Boolean;

    class function find(Id: string): TRecebimento;
    class function findByVenda(VendaId: string): TObjectList<TRecebimento>;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property ContaId: String  read FCONTA_ID write FCONTA_ID;
    property PessoaId: String  read FPESSOA_ID write FPESSOA_ID;
    property CategoriaId: String  read FCATEGORIA_ID write FCATEGORIA_ID;
    property VendaId: String  read FVENDA_ID write FVENDA_ID;
    property CartaoId: String  read FCARTAO_ID write FCARTAO_ID;
    property Modalidade: String  read FMODALIDADE write FMODALIDADE;
    property Parcela: Integer  read FPARCELA write FPARCELA;
    property QtdeParcelas: Integer  read FQTDE_PARCELAS write FQTDE_PARCELAS;
    property Referencia: Integer  read FREFERENCIA write FREFERENCIA;
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    property Competencia: TDateTime  read FCOMPETENCIA write FCOMPETENCIA;
    property Valor: Extended  read FVALOR write FVALOR;
    property DescontosTaxas: Extended  read FDESCONTOS_TAXAS write FDESCONTOS_TAXAS;
    property JurosMulta: Extended  read FJUROS_MULTA write FJUROS_MULTA;
    property ValorRecebido: Extended  read FVALOR_RECEBIDO write FVALOR_RECEBIDO;
    property Vencimento: TDateTime  read FVENCIMENTO write FVENCIMENTO;
    property Recebimento: TDateTime  read FRECEBIMENTO write FRECEBIMENTO;
    property Situacao: String  read FSITUACAO write FSITUACAO;

    property Cartao: TCartao read getCartao;
  end;

implementation

uses
  AuthService;

{ TRecebimento }

constructor TRecebimento.Create;
begin
  Self.Table:= 'RECEBIMENTOS';
end;

destructor TRecebimento.Destroy;
begin
  if Assigned(Self.FCARTAO) then FreeAndNil(Self.FCARTAO);

  inherited;
end;

class function TRecebimento.find(Id: string): TRecebimento;
const
  FSql: string = 'SELECT * FROM RECEBIMENTOS WHERE (ID = :ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('ID').AsString:= id;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TRecebimento.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.ContaId:= FDQuery.FieldByName('CONTA_ID').AsString;
        Result.PessoaId:= FDQuery.FieldByName('PESSOA_ID').AsString;
        Result.CategoriaId:= FDQuery.FieldByName('CATEGORIA_ID').AsString;
        Result.VendaId:= FDQuery.FieldByName('VENDA_ID').AsString;
        Result.CartaoId:= FDQuery.FieldByName('CARTAO_ID').AsString;
        Result.Modalidade:= FDQuery.FieldByName('MODALIDADE').AsString;
        Result.Parcela:= FDQuery.FieldByName('PARCELA').AsInteger;
        Result.QtdeParcelas:= FDQuery.FieldByName('QTDE_PARCELAS').AsInteger;
        Result.Referencia:= FDQuery.FieldByName('REFERENCIA').AsInteger;
        Result.Descricao:= FDQuery.FieldByName('DESCRICAO').AsString;
        Result.Competencia:= FDQuery.FieldByName('COMPETENCIA').AsDateTime;
        Result.Valor:= FDQuery.FieldByName('VALOR').AsExtended;
        Result.JurosMulta:= FDQuery.FieldByName('JUROS_MULTA').AsExtended;
        Result.DescontosTaxas:= FDQuery.FieldByName('DESCONTOS_TAXAS').AsExtended;
        Result.ValorRecebido:= FDQuery.FieldByName('VALOR_RECEBIDO').AsExtended;
        Result.Vencimento:= FDQuery.FieldByName('VENCIMENTO').AsDateTime;
        Result.Recebimento:= FDQuery.FieldByName('RECEBIMENTO').AsDateTime;
        Result.Situacao:= FDQuery.FieldByName('SITUACAO').AsString;
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

class function TRecebimento.findByVenda(
  VendaId: string): TObjectList<TRecebimento>;
const
  FSql: string =
  'SELECT ID FROM RECEBIMENTOS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (VENDA_ID = :VENDA_ID) ' +
  'AND (DELETED_AT IS NULL)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('VENDA_ID').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Params.ParamByName('VENDA_ID').AsString:= VendaId;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TObjectList<TRecebimento>.Create;
        FDQuery.First();
        while not FDQuery.Eof do
        begin
          Result.Add(TRecebimento.find(FDQuery.FieldByName('ID').AsString));
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

function TRecebimento.getCartao: TCartao;
begin
  if not Assigned(Self.FCARTAO) then
    Self.FCARTAO:= TCartao.find(Self.CartaoId);

  Result:= Self.FCARTAO;
end;

function TRecebimento.save: Boolean;
begin
  Result:= inherited;
end;

function TRecebimento.store: Boolean;
const
  FSql: string =
  'INSERT INTO RECEBIMENTOS (' +
  '  ID,                     ' +
  '  EMPRESA_ID,             ' +
  '  CONTA_ID,               ' +
  '  PESSOA_ID,              ' +
  '  CATEGORIA_ID,           ' +
  '  VENDA_ID,               ' +
  '  CARTAO_ID,              ' +
  '  MODALIDADE,             ' +
  '  PARCELA,                ' +
  '  QTDE_PARCELAS,          ' +
  '  REFERENCIA,             ' +
  '  DESCRICAO,              ' +
  '  COMPETENCIA,            ' +
  '  VALOR,                  ' +
  '  DESCONTOS_TAXAS,        ' +
  '  JUROS_MULTA,            ' +
  '  VALOR_RECEBIDO,         ' +
  '  VENCIMENTO,             ' +
  '  RECEBIMENTO,            ' +
  '  SITUACAO,               ' +
  '  CREATED_AT,             ' +
  '  UPDATED_AT)             ' +
  'VALUES (                  ' +
  '  :ID,                    ' +
  '  :EMPRESA_ID,            ' +
  '  :CONTA_ID,              ' +
  '  :PESSOA_ID,             ' +
  '  :CATEGORIA_ID,          ' +
  '  :VENDA_ID,              ' +
  '  :CARTAO_ID,             ' +
  '  :MODALIDADE,            ' +
  '  :PARCELA,               ' +
  '  :QTDE_PARCELAS,         ' +
  '  :REFERENCIA,            ' +
  '  :DESCRICAO,             ' +
  '  :COMPETENCIA,           ' +
  '  :VALOR,                 ' +
  '  :DESCONTOS_TAXAS,       ' +
  '  :JUROS_MULTA,           ' +
  '  :VALOR_RECEBIDO,        ' +
  '  :VENCIMENTO,            ' +
  '  :RECEBIMENTO,           ' +
  '  :SITUACAO,              ' +
  '  :CREATED_AT,            ' +
  '  :UPDATED_AT)            ';
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
      FDQuery.Params.ParamByName('CONTA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('PESSOA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('CATEGORIA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('VENDA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('CARTAO_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('MODALIDADE').DataType:= ftString;
      FDQuery.Params.ParamByName('PARCELA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('QTDE_PARCELAS').DataType:= ftInteger;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('DESCRICAO').DataType:= ftString;
      FDQuery.Params.ParamByName('COMPETENCIA').DataType:= ftDate;
      FDQuery.Params.ParamByName('VALOR').DataType:= ftExtended;
      FDQuery.Params.ParamByName('DESCONTOS_TAXAS').DataType:= ftExtended;
      FDQuery.Params.ParamByName('JUROS_MULTA').DataType:= ftExtended;
      FDQuery.Params.ParamByName('VALOR_RECEBIDO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('VENCIMENTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('RECEBIMENTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('SITUACAO').DataType:= ftString;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare();

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.Terminal.EmpresaId;
      Self.Referencia:= Self.nextReferencia(Self.Referencia);

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      if (Self.ContaId <> EmptyStr) then
      FDQuery.Params.ParamByName('CONTA_ID').AsString:= Self.ContaId;
      if (Self.PessoaId <> EmptyStr) then
      FDQuery.Params.ParamByName('PESSOA_ID').AsString:= Self.PessoaId;
      if (Self.CategoriaId <> EmptyStr) then
      FDQuery.Params.ParamByName('CATEGORIA_ID').AsString:= Self.CategoriaId;
      if (Self.VendaId <> EmptyStr) then
      FDQuery.Params.ParamByName('VENDA_ID').AsString:= Self.VendaId;
      if (Self.CartaoId <> EmptyStr) then
      FDQuery.Params.ParamByName('CARTAO_ID').AsString:= Self.CartaoId;
      if (Self.Modalidade <> EmptyStr) then
      FDQuery.Params.ParamByName('MODALIDADE').AsString:= Self.Modalidade;
      if (Self.Parcela >= 1) then
      FDQuery.Params.ParamByName('PARCELA').AsInteger:= Self.Parcela;
      if (Self.QtdeParcelas >= 1) then
      FDQuery.Params.ParamByName('QTDE_PARCELAS').AsInteger:= Self.QtdeParcelas;
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= Self.Referencia;
      if (Self.Descricao <> EmptyStr) then
      FDQuery.Params.ParamByName('DESCRICAO').AsString:= Self.Descricao;
      FDQuery.Params.ParamByName('COMPETENCIA').AsDate:= Self.Competencia;
      FDQuery.Params.ParamByName('VALOR').AsExtended:= Self.Valor;
      FDQuery.Params.ParamByName('VENCIMENTO').AsDate:= Self.Vencimento;
      FDQuery.Params.ParamByName('SITUACAO').AsString:= Self.Situacao;
      if (Self.Situacao = 'A') then
      begin
        FDQuery.Params.ParamByName('DESCONTOS_TAXAS').AsExtended:= 0;
        FDQuery.Params.ParamByName('JUROS_MULTA').AsExtended:= 0;
        FDQuery.Params.ParamByName('VALOR_RECEBIDO').AsExtended:= 0;
      end
      else
      begin
        FDQuery.Params.ParamByName('DESCONTOS_TAXAS').AsExtended:= Self.DescontosTaxas;
        FDQuery.Params.ParamByName('JUROS_MULTA').AsExtended:= Self.JurosMulta;
        FDQuery.Params.ParamByName('VALOR_RECEBIDO').AsExtended:=
          (Self.Valor - Self.DescontosTaxas + Self.JurosMulta);
        FDQuery.Params.ParamByName('RECEBIMENTO').AsDate:= Self.Recebimento;
      end;
      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.ExecSQL();
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao gravar dados do recebimento. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TRecebimento.update: Boolean;
begin
  Result:= False;
end;

end.
