unit BoletoConfiguracao;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TBoletoConfiguracao = class(TModel)
  private
    FEMPRESA_ID: String;
    FCONTA_ID: String;
    FTIPO_COBRANCA: Integer;
    FCARTEIRA: String;
    FTARIFA_COBRANCA: Extended;
    FMULTA: Extended;
    FMULTA_PERCENTUAL: String;
    FJUROS: Extended;
    FJUROS_PERCENTUAL: String;
    FLOCAL_PAGAMENTO: String;
    FMENSAGEM: String;
    FNOSSO_NUMERO: String;
    FNUMERO_REMESSA: Integer;
    FDIR_ARQ_REMESSA: String;
    FLAYOUT_REMESSA: Integer;

    function getLocalPagamento: String;
    procedure setLocalPagamento(const Value: String);
    function getMensagem: String;
    procedure setMensagem(const Value: String);

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    function validate(): Boolean;
    class function findByContaId(ContaId: string): TBoletoConfiguracao;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property ContaId: String  read FCONTA_ID write FCONTA_ID;
    property TipoCobranca: Integer  read FTIPO_COBRANCA write FTIPO_COBRANCA;
    property Carteira: String  read FCARTEIRA write FCARTEIRA;
    property TarifaCobranca: Extended  read FTARIFA_COBRANCA write FTARIFA_COBRANCA;
    property Multa: Extended  read FMULTA write FMULTA;
    property MultaPercentual: String  read FMULTA_PERCENTUAL write FMULTA_PERCENTUAL;
    property Juros: Extended  read FJUROS write FJUROS;
    property JurosPercentual: String  read FJUROS_PERCENTUAL write FJUROS_PERCENTUAL;
    property LocalPagamento: String  read getLocalPagamento write setLocalPagamento;
    property Mensagem: String  read getMensagem write setMensagem;
    property NossoNumero: String  read FNOSSO_NUMERO write FNOSSO_NUMERO;
    property DirArqRemessa: String  read FDIR_ARQ_REMESSA write FDIR_ARQ_REMESSA;
    property NumeroRemessa: Integer  read FNUMERO_REMESSA write FNUMERO_REMESSA;
    property LayoutRemessa: Integer  read FLAYOUT_REMESSA write FLAYOUT_REMESSA;

  end;

implementation

uses
  AuthService, Helper;

{ TBoletoConfiguracao }

constructor TBoletoConfiguracao.Create;
begin
  Self.Table:= 'BOLETO_CONFIGURACOES';
end;

class function TBoletoConfiguracao.findByContaId(
  ContaId: string): TBoletoConfiguracao;
const
  FSql: string = 'SELECT * FROM BOLETO_CONFIGURACOES WHERE (CONTA_ID = :CONTA_ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('CONTA_ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('CONTA_ID').AsString:= ContaId;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TBoletoConfiguracao.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.ContaId:= FDQuery.FieldByName('CONTA_ID').AsString;
        Result.TipoCobranca:= FDQuery.FieldByName('TIPO_COBRANCA').AsInteger;
        Result.Carteira:= FDQuery.FieldByName('CARTEIRA').AsString;
        Result.TarifaCobranca:= FDQuery.FieldByName('TARIFA_COBRANCA').AsExtended;
        Result.Multa:= FDQuery.FieldByName('MULTA').AsExtended;
        Result.MultaPercentual:= FDQuery.FieldByName('MULTA_PERCENTUAL').AsString;
        Result.Juros:= FDQuery.FieldByName('JUROS').AsExtended;
        Result.JurosPercentual:= FDQuery.FieldByName('JUROS_PERCENTUAL').AsString;
        Result.LocalPagamento:= FDQuery.FieldByName('LOCAL_PAGAMENTO').AsString;
        Result.Mensagem:= FDQuery.FieldByName('MENSAGEM').AsString;
        Result.NossoNumero:= FDQuery.FieldByName('NOSSO_NUMERO').AsString;
        Result.DirArqRemessa:= FDQuery.FieldByName('DIR_ARQ_REMESSA').AsString;
        Result.NumeroRemessa:= FDQuery.FieldByName('NUMERO_REMESSA').AsInteger;
        Result.LayoutRemessa:= FDQuery.FieldByName('LAYOUT_REMESSA').AsInteger;
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

function TBoletoConfiguracao.getLocalPagamento: String;
begin
  Result:= THelper.RemoveAcentos(FLOCAL_PAGAMENTO);
end;

function TBoletoConfiguracao.getMensagem: String;
begin
  Result:= THelper.RemoveAcentos(FMENSAGEM);
end;

function TBoletoConfiguracao.save: Boolean;
begin
  Result:= inherited;
end;

procedure TBoletoConfiguracao.setLocalPagamento(const Value: String);
begin
  FLOCAL_PAGAMENTO:= THelper.RemoveAcentos(Value);
end;

procedure TBoletoConfiguracao.setMensagem(const Value: String);
begin
  FMENSAGEM:= THelper.RemoveAcentos(Value);
end;

function TBoletoConfiguracao.store: Boolean;
const
  FSql: string =
  'INSERT INTO BOLETO_CONFIGURACOES (' +
  '  ID,                             ' +
  '  EMPRESA_ID,                     ' +
  '  CONTA_ID,                       ' +
  '  TIPO_COBRANCA,                  ' +
  '  CARTEIRA,                       ' +
  '  TARIFA_COBRANCA,                ' +
  '  MULTA,                          ' +
  '  MULTA_PERCENTUAL,               ' +
  '  JUROS,                          ' +
  '  JUROS_PERCENTUAL,               ' +
  '  LOCAL_PAGAMENTO,                ' +
  '  MENSAGEM,                       ' +
  '  NOSSO_NUMERO,                   ' +
  '  DIR_ARQ_REMESSA,                ' +
  '  NUMERO_REMESSA,                 ' +
  '  LAYOUT_REMESSA,                 ' +
  '  CREATED_AT,                     ' +
  '  UPDATED_AT)                     ' +
  'VALUES (                          ' +
  '  :ID,                            ' +
  '  :EMPRESA_ID,                    ' +
  '  :CONTA_ID,                      ' +
  '  :TIPO_COBRANCA,                 ' +
  '  :CARTEIRA,                      ' +
  '  :TARIFA_COBRANCA,               ' +
  '  :MULTA,                         ' +
  '  :MULTA_PERCENTUAL,              ' +
  '  :JUROS,                         ' +
  '  :JUROS_PERCENTUAL,              ' +
  '  :LOCAL_PAGAMENTO,               ' +
  '  :MENSAGEM,                      ' +
  '  :NOSSO_NUMERO,                  ' +
  '  :DIR_ARQ_REMESSA,               ' +
  '  :NUMERO_REMESSA,                ' +
  '  :LAYOUT_REMESSA,                ' +
  '  :CREATED_AT,                    ' +
  '  :UPDATED_AT)                    ';
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
      FDQuery.Params.ParamByName('TIPO_COBRANCA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CARTEIRA').DataType:= ftString;
      FDQuery.Params.ParamByName('TARIFA_COBRANCA').DataType:= ftExtended;
      FDQuery.Params.ParamByName('MULTA').DataType:= ftExtended;
      FDQuery.Params.ParamByName('MULTA_PERCENTUAL').DataType:= ftString;
      FDQuery.Params.ParamByName('JUROS').DataType:= ftExtended;
      FDQuery.Params.ParamByName('JUROS_PERCENTUAL').DataType:= ftString;
      FDQuery.Params.ParamByName('LOCAL_PAGAMENTO').DataType:= ftString;
      FDQuery.Params.ParamByName('MENSAGEM').DataType:= ftString;
      FDQuery.Params.ParamByName('NOSSO_NUMERO').DataType:= ftString;
      FDQuery.Params.ParamByName('DIR_ARQ_REMESSA').DataType:= ftString;
      FDQuery.Params.ParamByName('NUMERO_REMESSA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('LAYOUT_REMESSA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare();

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('CONTA_ID').AsString:= Self.ContaId;
      if (Self.TipoCobranca >= 0) then
      FDQuery.Params.ParamByName('TIPO_COBRANCA').AsInteger:= Self.TipoCobranca;
      if (Self.Carteira <> EmptyStr) then
      FDQuery.Params.ParamByName('CARTEIRA').AsString:= Self.Carteira;
      if (Self.TarifaCobranca >= 0) then
      FDQuery.Params.ParamByName('TARIFA_COBRANCA').AsExtended:= Self.TarifaCobranca;
      if (Self.Multa >= 0) then
      FDQuery.Params.ParamByName('MULTA').AsExtended:= Self.Multa;
      if (Self.MultaPercentual <> EmptyStr) then
      FDQuery.Params.ParamByName('MULTA_PERCENTUAL').AsString:= Self.MultaPercentual;
      if (Self.Juros >= 0) then
      FDQuery.Params.ParamByName('JUROS').AsExtended:= Self.Juros;
      if (Self.JurosPercentual <> EmptyStr) then
      FDQuery.Params.ParamByName('JUROS_PERCENTUAL').AsString:= Self.JurosPercentual;
      if (Self.LocalPagamento <> EmptyStr) then
      FDQuery.Params.ParamByName('LOCAL_PAGAMENTO').AsString:= Self.LocalPagamento;
      if (Self.Mensagem <> EmptyStr) then
      FDQuery.Params.ParamByName('MENSAGEM').AsString:= Self.Mensagem;
      if (Self.NossoNumero <> EmptyStr) then
      FDQuery.Params.ParamByName('NOSSO_NUMERO').AsString:= Self.NossoNumero;
      if (Self.DirArqRemessa <> EmptyStr) then
      FDQuery.Params.ParamByName('DIR_ARQ_REMESSA').AsString:= Self.DirArqRemessa;
      if (Self.NumeroRemessa > 0) then
      FDQuery.Params.ParamByName('NUMERO_REMESSA').AsInteger:= Self.NumeroRemessa;
      FDQuery.Params.ParamByName('LAYOUT_REMESSA').AsInteger:= Self.LayoutRemessa;
      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('BOLETO CONFIGURACAO. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TBoletoConfiguracao.update: Boolean;
const
  FSql: string =
  'UPDATE BOLETO_CONFIGURACOES              ' +
  'SET TIPO_COBRANCA = :TIPO_COBRANCA,      ' +
  '    CARTEIRA = :CARTEIRA,                ' +
  '    TARIFA_COBRANCA = :TARIFA_COBRANCA,  ' +
  '    MULTA = :MULTA,                      ' +
  '    MULTA_PERCENTUAL = :MULTA_PERCENTUAL,' +
  '    JUROS = :JUROS,                      ' +
  '    JUROS_PERCENTUAL = :JUROS_PERCENTUAL,' +
  '    LOCAL_PAGAMENTO = :LOCAL_PAGAMENTO,  ' +
  '    MENSAGEM = :MENSAGEM,                ' +
  '    NOSSO_NUMERO = :NOSSO_NUMERO,        ' +
  '    DIR_ARQ_REMESSA = :DIR_ARQ_REMESSA,  ' +
  '    NUMERO_REMESSA = :NUMERO_REMESSA,    ' +
  '    LAYOUT_REMESSA = :LAYOUT_REMESSA,    ' +
  '    UPDATED_AT = :UPDATED_AT,            ' +
  '    SYNCHRONIZED = :SYNCHRONIZED         ' +
  'WHERE (ID = :ID)                         ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('TIPO_COBRANCA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CARTEIRA').DataType:= ftString;
      FDQuery.Params.ParamByName('TARIFA_COBRANCA').DataType:= ftExtended;
      FDQuery.Params.ParamByName('MULTA').DataType:= ftExtended;
      FDQuery.Params.ParamByName('MULTA_PERCENTUAL').DataType:= ftString;
      FDQuery.Params.ParamByName('JUROS').DataType:= ftExtended;
      FDQuery.Params.ParamByName('JUROS_PERCENTUAL').DataType:= ftString;
      FDQuery.Params.ParamByName('LOCAL_PAGAMENTO').DataType:= ftString;
      FDQuery.Params.ParamByName('MENSAGEM').DataType:= ftString;
      FDQuery.Params.ParamByName('NOSSO_NUMERO').DataType:= ftString;
      FDQuery.Params.ParamByName('DIR_ARQ_REMESSA').DataType:= ftString;
      FDQuery.Params.ParamByName('NUMERO_REMESSA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('LAYOUT_REMESSA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.TipoCobranca >= 0) then
      FDQuery.Params.ParamByName('TIPO_COBRANCA').AsInteger:= Self.TipoCobranca;
      if (Self.Carteira <> EmptyStr) then
      FDQuery.Params.ParamByName('CARTEIRA').AsString:= Self.Carteira;
      if (Self.TarifaCobranca >= 0) then
      FDQuery.Params.ParamByName('TARIFA_COBRANCA').AsExtended:= Self.TarifaCobranca;
      if (Self.Multa >= 0) then
      FDQuery.Params.ParamByName('MULTA').AsExtended:= Self.Multa;
      if (Self.MultaPercentual <> EmptyStr) then
      FDQuery.Params.ParamByName('MULTA_PERCENTUAL').AsString:= Self.MultaPercentual;
      if (Self.Juros >= 0) then
      FDQuery.Params.ParamByName('JUROS').AsExtended:= Self.Juros;
      if (Self.JurosPercentual <> EmptyStr) then
      FDQuery.Params.ParamByName('JUROS_PERCENTUAL').AsString:= Self.JurosPercentual;
      if (Self.LocalPagamento <> EmptyStr) then
      FDQuery.Params.ParamByName('LOCAL_PAGAMENTO').AsString:= Self.LocalPagamento;
      if (Self.Mensagem <> EmptyStr) then
      FDQuery.Params.ParamByName('MENSAGEM').AsString:= Self.Mensagem;
      if (Self.NossoNumero <> EmptyStr) then
      FDQuery.Params.ParamByName('NOSSO_NUMERO').AsString:= Self.NossoNumero;
      if (Self.DirArqRemessa <> EmptyStr) then
      FDQuery.Params.ParamByName('DIR_ARQ_REMESSA').AsString:= Self.DirArqRemessa;
      if (Self.NumeroRemessa > 0) then
      FDQuery.Params.ParamByName('NUMERO_REMESSA').AsInteger:= Self.NumeroRemessa;
      FDQuery.Params.ParamByName('LAYOUT_REMESSA').AsInteger:= Self.LayoutRemessa;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('BOLETO CONFIGURACAO. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TBoletoConfiguracao.validate(): Boolean;
begin
  Result:= True;
end;

end.
