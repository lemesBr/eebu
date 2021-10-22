unit Boleto;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  ACBrBoleto, ACBrBase, ACBrBoletoFCFortesFr, System.Math, Recebimento,
  System.StrUtils, Vcl.Forms, ACBrMail, Empresa;

type
  TBoleto = class(TModel)
  private
    FEMPRESA_ID: String;
    FRECEBIMENTO_ID: String;
    FREMESSA_ID: String;
    FRETORNO_ID: String;
    FVENCIMENTO: TDateTime;
    FDATA_DOCUMENTO: TDateTime;
    FNUMERO_DOCUMENTO: String;
    FESPECIE_DOC: String;
    FACEITE: Integer;
    FDATA_PROCESSAMENTO: TDateTime;
    FNOSSO_NUMERO: String;
    FUSO_BANCO: String;
    FCARTEIRA: String;
    FCARTEIRA_ENVIO: Integer;
    FESPECIE_MOD: String;
    FVALOR_DOCUMENTO: Extended;
    FMENSAGEM: String;
    FINFORMATIVO: String;
    FPRIMEIRA_INSTRUCAO: String;
    FSEGUNDA_INSTRUCAO: String;
    FTERCEIRA_INSTRUCAO: String;
    FPARCELA: Integer;
    FTOTAL_PARCELAS: Integer;
    FCODIGO_LIQUIDACAO: String;
    FCODIGO_LIQUIDACAO_DESCRICAO: String;
    FMOTIVO_REJEICAO_COMANDO: String;
    FDATA_OCORRENCIA: TDateTime;
    FDATA_CREDITO: TDateTime;
    FDATA_ABATIMENTO: TDateTime;
    FDATA_DESCONTO: TDateTime;
    FDATA_MORAJUROS: TDateTime;
    FDATA_PROTESTO: TDateTime;
    FDATA_BAIXA: TDateTime;
    FDATA_LIMITE_PAGTO: TDateTime;
    FVALOR_DESPESA_COBRANCA: Extended;
    FVALOR_ABATIMENTO: Extended;
    FVALOR_DESCONTO: Extended;
    FVALOR_MORAJUROS: Extended;
    FVALOR_IOF: Extended;
    FVALOR_OUTRAS_DESPESAS: Extended;
    FVALOR_OUTROS_CREDITOS: Extended;
    FVALOR_PAGO: Extended;
    FVALOR_RECEBIDO: Extended;
    FREFERENCIA: String;
    FVERSAO: String;
    FSEU_NUMERO: String;
    FPERCENTUAL_MULTA: Extended;
    FMULTA_VALOR_FIXO: String;
    FVALOR_DESCONTO_ANT_DIA: Extended;
    FTEXTO_LIVRE: String;
    FCODIGO_MORA: String;
    FTIPO_DIAS_PROTESTO: Integer;
    FTIPO_IMPRESSAO: Integer;
    FLINHA_DIGITADA: String;
    FCODIGO_GERACAO: String;
    FCARACTITULO: Integer;
    FEMPRESA: TEmpresa;
    FRECEBIMENTO: TRecebimento;

    function getEmpresa: TEmpresa;
    function getRecebimento: TRecebimento;

    function getNossoNumero(): string;
  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    function delete(): Boolean;
    class function find(id: string): TBoleto;
    class function findByRecebimentoId(RecebimentoId: string): TBoleto;
    class function findByNumeroDocumento(NumeroDocumento: string): TBoleto;
    class function listByRemessaId(RemessaId: string): TObjectList<TBoleto>;
    class function listByContaIdRemessaIsNull(ContaId: string): TObjectList<TBoleto>; overload;
    class procedure listByContaIdRemessaIsNull(ContaId: string; DataSet: TFDMemTable); overload;
    class function list(search: string): TObjectList<TBoleto>; overload;
    class procedure list(search: string; DataSet: TFDMemTable); overload;
    class procedure recebimentoToBoleto(RecebimentoId: string);
    class procedure imprimirBoleto(id: string);
    class function gerarArquivoRemessa(ContaId: string): boolean;
    class function confirmarRetorno(fdmt: TFDMemTable): Boolean;
    class function removeByRecebimentoId(RecebimentoId: string): Boolean;
    class procedure enviarEmail(RecebimentoId: string);

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property RecebimentoId: String  read FRECEBIMENTO_ID write FRECEBIMENTO_ID;
    property RemessaId: String  read FREMESSA_ID write FREMESSA_ID;
    property RetornoId: String  read FRETORNO_ID write FRETORNO_ID;
    property Vencimento: TDateTime  read FVENCIMENTO write FVENCIMENTO;
    property DataDocumento: TDateTime  read FDATA_DOCUMENTO write FDATA_DOCUMENTO;
    property NumeroDocumento: String  read FNUMERO_DOCUMENTO write FNUMERO_DOCUMENTO;
    property EspecieDoc: String  read FESPECIE_DOC write FESPECIE_DOC;
    property Aceite: Integer  read FACEITE write FACEITE;
    property DataProcessamento: TDateTime  read FDATA_PROCESSAMENTO write FDATA_PROCESSAMENTO;
    property NossoNumero: String  read FNOSSO_NUMERO write FNOSSO_NUMERO;
    property UsoBanco: String  read FUSO_BANCO write FUSO_BANCO;
    property Carteira: String  read FCARTEIRA write FCARTEIRA;
    property CarteiraEnvio: Integer  read FCARTEIRA_ENVIO write FCARTEIRA_ENVIO;
    property EspecieMod: String  read FESPECIE_MOD write FESPECIE_MOD;
    property ValorDocumento: Extended  read FVALOR_DOCUMENTO write FVALOR_DOCUMENTO;
    property Mensagem: String  read FMENSAGEM write FMENSAGEM;
    property Informativo: String  read FINFORMATIVO write FINFORMATIVO;
    property PrimeiraInstrucao: String  read FPRIMEIRA_INSTRUCAO write FPRIMEIRA_INSTRUCAO;
    property SegundaInstrucao: String  read FSEGUNDA_INSTRUCAO write FSEGUNDA_INSTRUCAO;
    property TerceiraInstrucao: String  read FTERCEIRA_INSTRUCAO write FTERCEIRA_INSTRUCAO;
    property Parcela: Integer  read FPARCELA write FPARCELA;
    property TotalParcelas: Integer  read FTOTAL_PARCELAS write FTOTAL_PARCELAS;
    property CodigoLiquidacao: String  read FCODIGO_LIQUIDACAO write FCODIGO_LIQUIDACAO;
    property CodigoLiquidacaoDescricao: String  read FCODIGO_LIQUIDACAO_DESCRICAO write FCODIGO_LIQUIDACAO_DESCRICAO;
    property MotivoRejeicaoComando: String  read FMOTIVO_REJEICAO_COMANDO write FMOTIVO_REJEICAO_COMANDO;
    property DataOcorrencia: TDateTime  read FDATA_OCORRENCIA write FDATA_OCORRENCIA;
    property DataCredito: TDateTime  read FDATA_CREDITO write FDATA_CREDITO;
    property DataAbatimento: TDateTime  read FDATA_ABATIMENTO write FDATA_ABATIMENTO;
    property DataDesconto: TDateTime  read FDATA_DESCONTO write FDATA_DESCONTO;
    property DataMorajuros: TDateTime  read FDATA_MORAJUROS write FDATA_MORAJUROS;
    property DataProtesto: TDateTime  read FDATA_PROTESTO write FDATA_PROTESTO;
    property DataBaixa: TDateTime  read FDATA_BAIXA write FDATA_BAIXA;
    property DataLimitePagto: TDateTime  read FDATA_LIMITE_PAGTO write FDATA_LIMITE_PAGTO;
    property ValorDespesaCobranca: Extended  read FVALOR_DESPESA_COBRANCA write FVALOR_DESPESA_COBRANCA;
    property ValorAbatimento: Extended  read FVALOR_ABATIMENTO write FVALOR_ABATIMENTO;
    property ValorDesconto: Extended  read FVALOR_DESCONTO write FVALOR_DESCONTO;
    property ValorMorajuros: Extended  read FVALOR_MORAJUROS write FVALOR_MORAJUROS;
    property ValorIof: Extended  read FVALOR_IOF write FVALOR_IOF;
    property ValorOutrasDespesas: Extended  read FVALOR_OUTRAS_DESPESAS write FVALOR_OUTRAS_DESPESAS;
    property ValorOutrosCreditos: Extended  read FVALOR_OUTROS_CREDITOS write FVALOR_OUTROS_CREDITOS;
    property ValorPago: Extended  read FVALOR_PAGO write FVALOR_PAGO;
    property ValorRecebido: Extended  read FVALOR_RECEBIDO write FVALOR_RECEBIDO;
    property Referencia: String  read FREFERENCIA write FREFERENCIA;
    property Versao: String  read FVERSAO write FVERSAO;
    property SeuNumero: String  read FSEU_NUMERO write FSEU_NUMERO;
    property PercentualMulta: Extended  read FPERCENTUAL_MULTA write FPERCENTUAL_MULTA;
    property MultaValorFixo: String  read FMULTA_VALOR_FIXO write FMULTA_VALOR_FIXO;
    property ValorDescontoAntDia: Extended  read FVALOR_DESCONTO_ANT_DIA write FVALOR_DESCONTO_ANT_DIA;
    property TextoLivre: String  read FTEXTO_LIVRE write FTEXTO_LIVRE;
    property CodigoMora: String  read FCODIGO_MORA write FCODIGO_MORA;
    property TipoDiasProtesto: Integer  read FTIPO_DIAS_PROTESTO write FTIPO_DIAS_PROTESTO;
    property TipoImpressao: Integer  read FTIPO_IMPRESSAO write FTIPO_IMPRESSAO;
    property LinhaDigitada: String  read FLINHA_DIGITADA write FLINHA_DIGITADA;
    property CodigoGeracao: String  read FCODIGO_GERACAO write FCODIGO_GERACAO;
    property CaracTitulo: Integer  read FCARACTITULO write FCARACTITULO;

    property Empresa: TEmpresa read getEmpresa;
    property Recebimento: TRecebimento read getRecebimento;

  end;

implementation

uses
  AuthService, BoletoRemessa, BoletoRetorno, Helper, uformCedenteCreateEdit,
  uformBoletoCreateEdit;

{ TBoleto }

class function TBoleto.confirmarRetorno(fdmt: TFDMemTable): Boolean;
var
  Retorno: TBoletoRetorno;
  Boleto: TBoleto;
begin
  Result:= True;
  try
    try
      Self.StartTransaction;
      Retorno:= TBoletoRetorno.Create;
      Retorno.Data:= Now();
      Retorno.save();

      fdmt.DisableControls;
      fdmt.First;
      while not fdmt.Eof do
      begin
        Boleto:= TBoleto.find(fdmt.FieldByName('ID').AsString);
        Boleto.ValorRecebido:= fdmt.FieldByName('VALOR_RECEBIDO').AsExtended;
        Boleto.DataCredito:= fdmt.FieldByName('DATA_CREDITO').AsDateTime;
        Boleto.RetornoId:= Retorno.Id;
        Boleto.save();
        
        Boleto.Recebimento.DescontosTaxas:= 0;
        Boleto.Recebimento.JurosMulta:= 0;
        
        if Boleto.ValorRecebido < Boleto.Recebimento.Valor then
          Boleto.Recebimento.DescontosTaxas:= (Boleto.Recebimento.Valor - Boleto.ValorRecebido)
        else if Boleto.ValorRecebido > Boleto.Recebimento.Valor then
          Boleto.Recebimento.JurosMulta:= (Boleto.ValorRecebido - Boleto.Recebimento.Valor);     
        
        Boleto.Recebimento.Recebimento:= Boleto.DataCredito;
        Boleto.Recebimento.Situacao:= 'F';
        Boleto.Recebimento.save();
        FreeAndNil(Boleto);
        
        fdmt.Next;
      end;
      Self.Commit;
      THelper.Mensagem('Boletos conciliados com sucesso.');
    except on e: exception do
      begin
        Self.Rollback;
        Result:= False;
        raise Exception.Create('Falha ao conciliar boletos. Erro: ' + e.Message);
      end;
    end;
  finally
    if Assigned(Retorno) then FreeAndNil(Retorno);
    fdmt.EnableControls;
  end;
end;

constructor TBoleto.Create;
begin
  Self.Table:= 'BOLETOS';
end;

function TBoleto.delete: Boolean;
const
  FSql: string =
  'DELETE FROM BOLETOS ' +
  'WHERE (ID = :ID)';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('falha ao remover o boleto. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

destructor TBoleto.Destroy;
begin
  if Assigned(FEMPRESA) then FreeAndNil(FEMPRESA);
  if Assigned(FRECEBIMENTO) then FreeAndNil(FRECEBIMENTO);
  
  inherited;
end;

class procedure TBoleto.enviarEmail(RecebimentoId: string);
var
  ACBrBoleto: TACBrBoleto;
  Boleto: TBoleto;
  vMensagem: TStringList;
  vDir: string;
begin
  try
    ACBrBoleto:= TACBrBoleto.Create(nil);
    ACBrBoleto.ACBrBoletoFC:= TACBrBoletoFCFortes.Create(nil);
    ACBrBoleto.MAIL:= TACBrMail.Create(nil);
    vMensagem:= nil;
    vDir:= '';

    ACBrBoleto.MAIL.Host:= 'mail.wtsystem.com.br';
    ACBrBoleto.MAIL.Port:= '465';
    ACBrBoleto.MAIL.Username:= 'cobranca@wtsystem.com.br';
    ACBrBoleto.MAIL.Password:= 'wtcobranca115816';
    ACBrBoleto.MAIL.From:= 'cobranca@wtsystem.com.br';
    ACBrBoleto.MAIL.SetSSL:= True;
    ACBrBoleto.MAIL.SetTLS:= True;
    ACBrBoleto.MAIL.ReadingConfirmation:= False;
    ACBrBoleto.MAIL.UseThread:= False;

    Boleto:= TBoleto.findByRecebimentoId(RecebimentoId);
    if not Assigned(Boleto) then
      raise Exception.Create('Falha ao consultar dados do boleto.');

    if (Trim(Boleto.Recebimento.Pessoa.Email) = EmptyStr) then
      raise Exception.Create('Destinatário sem email cadastrado.');

    ACBrBoleto.MAIL.FromName:= 'WT-SYSTEM / ' + Boleto.Empresa.Nome;
    vMensagem:= TStringList.Create;
    vMensagem.Add(Boleto.Empresa.Nome + ': Segue anexo o boleto emitido.');
    vMensagem.Add('Referente: ' + Boleto.Recebimento.Descricao);
    vMensagem.Add('');
    vMensagem.Add('Atenciosamente WT-SYSTEM');

    try
      if not Assigned(Boleto.Recebimento.Conta.BoletoConfiguracao) then
        raise Exception.Create('Conta sem dados do banco.');

      if not Assigned(Boleto.Recebimento.Conta.Cedente) then
        raise Exception.Create('Conta sem dados do cedente.');

      ACBrBoleto.Banco.TipoCobranca:= TACBrTipoCobranca(Boleto.Recebimento.Conta.BoletoConfiguracao.TipoCobranca);
      ACBrBoleto.Cedente.Nome:= Boleto.Recebimento.Conta.Cedente.Nome;
      ACBrBoleto.Cedente.CodigoCedente:= Boleto.Recebimento.Conta.Cedente.CodigoCedente;
      ACBrBoleto.Cedente.CodigoTransmissao:= Boleto.Recebimento.Conta.Cedente.CodigoTransmissao;
      ACBrBoleto.Cedente.Agencia:= Boleto.Recebimento.Conta.Cedente.Agencia;
      ACBrBoleto.Cedente.AgenciaDigito:= Boleto.Recebimento.Conta.Cedente.AgenciaDigito;
      ACBrBoleto.Cedente.Conta:= Boleto.Recebimento.Conta.Cedente.Conta;
      ACBrBoleto.Cedente.ContaDigito:= Boleto.Recebimento.Conta.Cedente.ContaDigito;
      ACBrBoleto.Cedente.Modalidade:= Boleto.Recebimento.Conta.Cedente.Modalidade;
      ACBrBoleto.Cedente.Convenio:= Boleto.Recebimento.Conta.Cedente.Convenio;
      //ACBrBoleto.Cedente.TipoDocumento:= Boleto.Recebimento.Conta.Cedente.TipoDocumento;
      //ACBrBoleto.Cedente.TipoCarteira:= Boleto.Recebimento.Conta.Cedente.TipoCarteira;
      //ACBrBoleto.Cedente.ResponEmissao:= Boleto.Recebimento.Conta.Cedente.ResponEmissao;
      //ACBrBoleto.Cedente.CaracTitulo:= Boleto.Recebimento.Conta.Cedente.CaracTitulo;
      //ACBrBoleto.Cedente.TipoInscricao:= IfThen(Boleto.Recebimento.Conta.Cedente.TipoInscricao = 'F', 0, 1);
      ACBrBoleto.Cedente.CNPJCPF:= Boleto.Recebimento.Conta.Cedente.Cnpjcpf;
      ACBrBoleto.Cedente.Logradouro:= Boleto.Recebimento.Conta.Cedente.Logradouro;
      ACBrBoleto.Cedente.NumeroRes:= Boleto.Recebimento.Conta.Cedente.NumeroRes;
      ACBrBoleto.Cedente.Complemento:= Boleto.Recebimento.Conta.Cedente.Complemento;
      ACBrBoleto.Cedente.Bairro:= Boleto.Recebimento.Conta.Cedente.Bairro;
      ACBrBoleto.Cedente.Cidade:= Boleto.Recebimento.Conta.Cedente.Cidade;
      ACBrBoleto.Cedente.UF:= Boleto.Recebimento.Conta.Cedente.Uf;
      ACBrBoleto.Cedente.CEP:= Boleto.Recebimento.Conta.Cedente.Cep;
      ACBrBoleto.Cedente.Telefone:= Boleto.Recebimento.Conta.Cedente.Telefone;

      with ACBrBoleto.CriarTituloNaLista do
      begin
        LocalPagamento:= Boleto.Recebimento.Conta.BoletoConfiguracao.LocalPagamento;
        Vencimento:= Boleto.Vencimento;
        DataDocumento:= Boleto.DataDocumento;
        NumeroDocumento:= Boleto.NumeroDocumento;
        EspecieDoc:= Boleto.EspecieDoc;
        //Aceite:= Boleto.Aceite;
        DataProcessamento:= Boleto.DataProcessamento;
        Carteira:= Boleto.Carteira;
        NossoNumero:= Boleto.NossoNumero;
        ValorDocumento:= Boleto.ValorDocumento;
        CodigoMora:= Boleto.CodigoMora;
        ValorMoraJuros:= Boleto.ValorMorajuros;
        PercentualMulta:= Boleto.PercentualMulta;
        MultaValorFixo:= Boleto.MultaValorFixo = 'N';
        Mensagem.Add(Boleto.Mensagem);
        Mensagem.Add(Boleto.Recebimento.Descricao);

        Sacado.NomeSacado:= Boleto.Recebimento.Pessoa.Nome;
        Sacado.CNPJCPF:= Boleto.Recebimento.Pessoa.Documento;
        Sacado.Logradouro:= Boleto.Recebimento.Pessoa.Logradouro;
        Sacado.Numero:= Boleto.Recebimento.Pessoa.Numero;
        Sacado.Bairro:= Boleto.Recebimento.Pessoa.Bairro;
        Sacado.Cidade:= Boleto.Recebimento.Pessoa.NomeMunicipio;
        Sacado.UF:= Boleto.Recebimento.Pessoa.Uf;
        Sacado.CEP:= Boleto.Recebimento.Pessoa.Cep;
        Sacado.Email:= Boleto.Recebimento.Pessoa.Email;
        Sacado.Fone:= Boleto.Recebimento.Pessoa.Fone;

        OcorrenciaOriginal.Tipo:= toRemessaRegistrar;
      end;

      vDir:= ExtractFileDir(Application.ExeName) + '\boleto';

      ACBrBoleto.ACBrBoletoFC.DirLogo:= vDir + '\colorido';
      ACBrBoleto.ACBrBoletoFC.NomeArquivo:=
        vDir +
        '\' + Boleto.Recebimento.Pessoa.Nome +
        '_' + FormatDateTime('dd-mm-yyyy', Boleto.Vencimento) +
        '_' + Boleto.Recebimento.Boleto + '.pdf';

//      ACBrBoleto.EnviarEmail(
//        Boleto.Recebimento.Pessoa.Email,
//        'Boleto',
//        vMensagem);

      Boleto.Recebimento.Email:= 'S';
      Boleto.Recebimento.save();

      THelper.Mensagem('Email enviado com sucesso.');
    except on e: exception do
      raise Exception.Create(e.Message);
    end;
  finally
    FreeAndNil(vMensagem);
    ACBrBoleto.MAIL.Free;
    ACBrBoleto.ACBrBoletoFC.Free;
    FreeAndNil(ACBrBoleto);
    FreeAndNil(Boleto);
  end;
end;

class function TBoleto.find(id: string): TBoleto;
const
  FSql: string = 'SELECT * FROM BOLETOS WHERE (ID = :ID)';
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
        Result:= TBoleto.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.RecebimentoId:= FDQuery.FieldByName('RECEBIMENTO_ID').AsString;
        Result.RemessaId:= FDQuery.FieldByName('REMESSA_ID').AsString;
        Result.RetornoId:= FDQuery.FieldByName('RETORNO_ID').AsString;
        Result.Vencimento:= FDQuery.FieldByName('VENCIMENTO').AsDateTime;
        Result.DataDocumento:= FDQuery.FieldByName('DATA_DOCUMENTO').AsDateTime;
        Result.NumeroDocumento:= FDQuery.FieldByName('NUMERO_DOCUMENTO').AsString;
        Result.EspecieDoc:= FDQuery.FieldByName('ESPECIE_DOC').AsString;
        Result.Aceite:= FDQuery.FieldByName('ACEITE').AsInteger;
        Result.DataProcessamento:= FDQuery.FieldByName('DATA_PROCESSAMENTO').AsDateTime;
        Result.NossoNumero:= FDQuery.FieldByName('NOSSO_NUMERO').AsString;
        Result.UsoBanco:= FDQuery.FieldByName('USO_BANCO').AsString;
        Result.Carteira:= FDQuery.FieldByName('CARTEIRA').AsString;
        Result.CarteiraEnvio:= FDQuery.FieldByName('CARTEIRA_ENVIO').AsInteger;
        Result.EspecieMod:= FDQuery.FieldByName('ESPECIE_MOD').AsString;
        Result.ValorDocumento:= FDQuery.FieldByName('VALOR_DOCUMENTO').AsExtended;
        Result.Mensagem:= FDQuery.FieldByName('MENSAGEM').AsString;
        Result.Informativo:= FDQuery.FieldByName('INFORMATIVO').AsString;
        Result.PrimeiraInstrucao:= FDQuery.FieldByName('PRIMEIRA_INSTRUCAO').AsString;
        Result.SegundaInstrucao:= FDQuery.FieldByName('SEGUNDA_INSTRUCAO').AsString;
        Result.TerceiraInstrucao:= FDQuery.FieldByName('TERCEIRA_INSTRUCAO').AsString;
        Result.Parcela:= FDQuery.FieldByName('PARCELA').AsInteger;
        Result.TotalParcelas:= FDQuery.FieldByName('TOTAL_PARCELAS').AsInteger;
        Result.CodigoLiquidacao:= FDQuery.FieldByName('CODIGO_LIQUIDACAO').AsString;
        Result.CodigoLiquidacaoDescricao:= FDQuery.FieldByName('CODIGO_LIQUIDACAO_DESCRICAO').AsString;
        Result.MotivoRejeicaoComando:= FDQuery.FieldByName('MOTIVO_REJEICAO_COMANDO').AsString;
        Result.DataOcorrencia:= FDQuery.FieldByName('DATA_OCORRENCIA').AsDateTime;
        Result.DataCredito:= FDQuery.FieldByName('DATA_CREDITO').AsDateTime;
        Result.DataAbatimento:= FDQuery.FieldByName('DATA_ABATIMENTO').AsDateTime;
        Result.DataDesconto:= FDQuery.FieldByName('DATA_DESCONTO').AsDateTime;
        Result.DataMorajuros:= FDQuery.FieldByName('DATA_MORAJUROS').AsDateTime;
        Result.DataProtesto:= FDQuery.FieldByName('DATA_PROTESTO').AsDateTime;
        Result.DataBaixa:= FDQuery.FieldByName('DATA_BAIXA').AsDateTime;
        Result.DataLimitePagto:= FDQuery.FieldByName('DATA_LIMITE_PAGTO').AsDateTime;
        Result.ValorDespesaCobranca:= FDQuery.FieldByName('VALOR_DESPESA_COBRANCA').AsExtended;
        Result.ValorAbatimento:= FDQuery.FieldByName('VALOR_ABATIMENTO').AsExtended;
        Result.ValorDesconto:= FDQuery.FieldByName('VALOR_DESCONTO').AsExtended;
        Result.ValorMorajuros:= FDQuery.FieldByName('VALOR_MORAJUROS').AsExtended;
        Result.ValorIof:= FDQuery.FieldByName('VALOR_IOF').AsExtended;
        Result.ValorOutrasDespesas:= FDQuery.FieldByName('VALOR_OUTRAS_DESPESAS').AsExtended;
        Result.ValorOutrosCreditos:= FDQuery.FieldByName('VALOR_OUTROS_CREDITOS').AsExtended;
        Result.ValorPago:= FDQuery.FieldByName('VALOR_PAGO').AsExtended;
        Result.ValorRecebido:= FDQuery.FieldByName('VALOR_RECEBIDO').AsExtended;
        Result.Referencia:= FDQuery.FieldByName('REFERENCIA').AsString;
        Result.Versao:= FDQuery.FieldByName('VERSAO').AsString;
        Result.SeuNumero:= FDQuery.FieldByName('SEU_NUMERO').AsString;
        Result.PercentualMulta:= FDQuery.FieldByName('PERCENTUAL_MULTA').AsExtended;
        Result.MultaValorFixo:= FDQuery.FieldByName('MULTA_VALOR_FIXO').AsString;
        Result.ValorDescontoAntDia:= FDQuery.FieldByName('VALOR_DESCONTO_ANT_DIA').AsExtended;
        Result.TextoLivre:= FDQuery.FieldByName('TEXTO_LIVRE').AsString;
        Result.CodigoMora:= FDQuery.FieldByName('CODIGO_MORA').AsString;
        Result.TipoDiasProtesto:= FDQuery.FieldByName('TIPO_DIAS_PROTESTO').AsInteger;
        Result.TipoImpressao:= FDQuery.FieldByName('TIPO_IMPRESSAO').AsInteger;
        Result.LinhaDigitada:= FDQuery.FieldByName('LINHA_DIGITADA').AsString;
        Result.CodigoGeracao:= FDQuery.FieldByName('CODIGO_GERACAO').AsString;
        Result.Caractitulo:= FDQuery.FieldByName('CARAC_TITULO').AsInteger;
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

class function TBoleto.findByNumeroDocumento(NumeroDocumento: string): TBoleto;
const
  FSql: string =
  'SELECT ID FROM BOLETOS WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (RETORNO_ID IS NULL) AND (NUMERO_DOCUMENTO = :NUMERO_DOCUMENTO)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('NUMERO_DOCUMENTO').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('NUMERO_DOCUMENTO').AsString:= Trim(NumeroDocumento);
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
        Result:= TBoleto.find(FDQuery.FieldByName('ID').AsString);
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TBoleto.findByRecebimentoId(RecebimentoId: string): TBoleto;
const
  FSql: string = 'SELECT ID FROM BOLETOS WHERE (RECEBIMENTO_ID = :RECEBIMENTO_ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('RECEBIMENTO_ID').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('RECEBIMENTO_ID').AsString:= RecebimentoId;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
        Result:= TBoleto.find(FDQuery.FieldByName('ID').AsString);
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TBoleto.gerarArquivoRemessa(ContaId: string): boolean;
var
  Boletos: TObjectList<TBoleto>;
  ACBrBoleto: TACBrBoleto;
  Remessa: TBoletoRemessa;
  I: Integer;
begin
  Result:= True;
  try
    Self.StartTransaction;
    try
      ACBrBoleto:= nil;
      Remessa:= nil;
      Boletos:= TBoleto.listByContaIdRemessaIsNull(ContaId);
      if not Assigned(Boletos) then
        raise Exception.Create('Falha ao consultar dados de boletos.');

      if not Assigned(Boletos.First.Recebimento.Conta.BoletoConfiguracao) then
        raise Exception.Create('Conta sem dados do banco.');

      if not Assigned(Boletos.First.Recebimento.Conta.Cedente) then
        raise Exception.Create('Conta sem dados do cedente.');

      ACBrBoleto:= TACBrBoleto.Create(nil);
      ACBrBoleto.Banco.TipoCobranca:= TACBrTipoCobranca(Boletos.First.Recebimento.Conta.BoletoConfiguracao.TipoCobranca);
      ACBrBoleto.LayoutRemessa:= TACBrLayoutRemessa(Boletos.First.Recebimento.Conta.BoletoConfiguracao.LayoutRemessa);
      ACBrBoleto.Cedente.Nome:= Boletos.First.Recebimento.Conta.Cedente.Nome;
      ACBrBoleto.Cedente.CodigoCedente:= Boletos.First.Recebimento.Conta.Cedente.CodigoCedente;
      ACBrBoleto.Cedente.CodigoTransmissao:= Boletos.First.Recebimento.Conta.Cedente.CodigoTransmissao;
      ACBrBoleto.Cedente.Agencia:= Boletos.First.Recebimento.Conta.Cedente.Agencia;
      ACBrBoleto.Cedente.AgenciaDigito:= Boletos.First.Recebimento.Conta.Cedente.AgenciaDigito;
      ACBrBoleto.Cedente.Conta:= Boletos.First.Recebimento.Conta.Cedente.Conta;
      ACBrBoleto.Cedente.ContaDigito:= Boletos.First.Recebimento.Conta.Cedente.ContaDigito;
      ACBrBoleto.Cedente.Modalidade:= Boletos.First.Recebimento.Conta.Cedente.Modalidade;
      ACBrBoleto.Cedente.Convenio:= Boletos.First.Recebimento.Conta.Cedente.Convenio;
      //ACBrBoleto.Cedente.TipoDocumento:= TACBrTipoDocumento(Boletos.First.Recebimento.Conta.Cedente.TipoDocumento);
      //ACBrBoleto.Cedente.TipoCarteira:= TACBrTipoCarteira(Boletos.First.Recebimento.Conta.Cedente.TipoCarteira);
      //ACBrBoleto.Cedente.ResponEmissao:= TACBrResponEmissao(Boletos.First.Recebimento.Conta.Cedente.ResponEmissao);
      //ACBrBoleto.Cedente.CaracTitulo:= TACBrCaracTitulo(Boletos.First.Recebimento.Conta.Cedente.CaracTitulo);
      ACBrBoleto.Cedente.CNPJCPF:= Boletos.First.Recebimento.Conta.Cedente.Cnpjcpf;
      //ACBrBoleto.Cedente.TipoInscricao:= TACBrPessoaCedente(IfThen(Boletos.First.Recebimento.Conta.Cedente.TipoInscricao = 'F', 0, 1));
      ACBrBoleto.Cedente.Logradouro:= Boletos.First.Recebimento.Conta.Cedente.Logradouro;
      ACBrBoleto.Cedente.NumeroRes:= Boletos.First.Recebimento.Conta.Cedente.NumeroRes;
      ACBrBoleto.Cedente.Complemento:= Boletos.First.Recebimento.Conta.Cedente.Complemento;
      ACBrBoleto.Cedente.Bairro:= Boletos.First.Recebimento.Conta.Cedente.Bairro;
      ACBrBoleto.Cedente.Cidade:= Boletos.First.Recebimento.Conta.Cedente.Cidade;
      ACBrBoleto.Cedente.UF:= Boletos.First.Recebimento.Conta.Cedente.Uf;
      ACBrBoleto.Cedente.CEP:= Boletos.First.Recebimento.Conta.Cedente.Cep;
      ACBrBoleto.Cedente.Telefone:= Boletos.First.Recebimento.Conta.Cedente.Telefone;

      for I:= 0 to Pred(Boletos.Count) do
      begin
        with ACBrBoleto.CriarTituloNaLista do
        begin
          LocalPagamento:= Boletos.Items[I].Recebimento.Conta.BoletoConfiguracao.LocalPagamento;
          Vencimento := Boletos.Items[I].Vencimento;
          DataDocumento:= Boletos.Items[I].DataDocumento;
          NumeroDocumento:= Boletos.Items[I].NumeroDocumento;
          EspecieDoc:= Boletos.Items[I].EspecieDoc;
          //Aceite:= TACBrAceiteTitulo(Boletos.Items[I].Aceite);
          DataProcessamento:= Boletos.Items[I].DataProcessamento;
          Carteira:= Boletos.Items[I].Carteira;
          NossoNumero:= Boletos.Items[I].NossoNumero;
          ValorDocumento:= Boletos.Items[I].ValorDocumento;
          CodigoMora:= Boletos.Items[I].CodigoMora;
          ValorMoraJuros:= Boletos.Items[I].ValorMorajuros;
          PercentualMulta:= Boletos.Items[I].PercentualMulta;
          MultaValorFixo:= Boletos.Items[I].MultaValorFixo = 'N';
          Mensagem.Add(Boletos.Items[I].Mensagem);
          Mensagem.Add(Boletos.Items[I].Recebimento.Descricao);

          Sacado.NomeSacado:= Boletos.Items[I].Recebimento.Pessoa.Nome;
          Sacado.CNPJCPF:= Boletos.Items[I].Recebimento.Pessoa.Documento;
          Sacado.Logradouro:= Boletos.Items[I].Recebimento.Pessoa.Logradouro;
          Sacado.Numero:= Boletos.Items[I].Recebimento.Pessoa.Numero;
          Sacado.Bairro:= Boletos.Items[I].Recebimento.Pessoa.Bairro;
          Sacado.Cidade:= Boletos.Items[I].Recebimento.Pessoa.NomeMunicipio;
          Sacado.UF:= Boletos.Items[I].Recebimento.Pessoa.Uf;
          Sacado.CEP:= Boletos.Items[I].Recebimento.Pessoa.Cep;
          Sacado.Email:= Boletos.Items[I].Recebimento.Pessoa.Email;
          Sacado.Fone:= Boletos.Items[I].Recebimento.Pessoa.Fone;

          OcorrenciaOriginal.Tipo:= toRemessaRegistrar;
        end;
      end;
      ACBrBoleto.DirArqRemessa:= Boletos.First.Recebimento.Conta.BoletoConfiguracao.DirArqRemessa;
      ACBrBoleto.DirArqRemessa:= IfThen(ACBrBoleto.DirArqRemessa <> EmptyStr, ACBrBoleto.DirArqRemessa, ExtractFileDir(Application.ExeName) + '\boleto');
      if not DirectoryExists(ACBrBoleto.DirArqRemessa) then
        ForceDirectories(ACBrBoleto.DirArqRemessa);

      Boletos.First.Recebimento.Conta.BoletoConfiguracao.NumeroRemessa:= Boletos.First.Recebimento.Conta.BoletoConfiguracao.NumeroRemessa + 1;
      Boletos.First.Recebimento.Conta.BoletoConfiguracao.save();

      ACBrBoleto.GerarRemessa(Boletos.First.Recebimento.Conta.BoletoConfiguracao.NumeroRemessa);
      Remessa:= TBoletoRemessa.Create;
      Remessa.Data:= Now();
      Remessa.Numero:= Boletos.First.Recebimento.Conta.BoletoConfiguracao.NumeroRemessa;
      Remessa.save();

      for I:= 0 to Pred(Boletos.Count) do
      begin
        Boletos.Items[I].RemessaId:= Remessa.Id;
        Boletos.Items[I].save();
      end;

      Self.Commit;
      THelper.Mensagem('Remessa gerada com sucesso.');
    except on e: exception do
      begin
        Self.Rollback;
        Result:= False;
        raise Exception.Create('Falha ao gerar remessa. Erro: ' + e.Message);
      end;
    end;
  finally
    if Assigned(Boletos) then FreeAndNil(Boletos);
    if Assigned(ACBrBoleto) then FreeAndNil(ACBrBoleto);
    if Assigned(Remessa) then FreeAndNil(Remessa);
  end;
end;

class function TBoleto.listByRemessaId(RemessaId: string): TObjectList<TBoleto>;
const
  FSql: string = 'SELECT ID FROM BOLETOS WHERE (REMESSA_ID = :REMESSA_ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('REMESSA_ID').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('REMESSA_ID').AsString:= RemessaId;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TBoleto>.Create;
        while not FDQuery.Eof do
        begin
          Result.Add(TBoleto.find(FDQuery.FieldByName('ID').AsString));
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

class procedure TBoleto.listByContaIdRemessaIsNull(ContaId: string;
  DataSet: TFDMemTable);
var
  vList: TObjectList<TBoleto>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  vList:= TBoleto.listByContaIdRemessaIsNull(ContaId);
  if Assigned(vList) then
  begin
    for I := 0 to Pred(vList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= vList.Items[I].Id;
      DataSet.FieldByName('PROCESSAMENTO').AsDateTime:= vList.Items[I].DataProcessamento;
      DataSet.FieldByName('BOLETO').AsString:= vList.Items[I].Recebimento.Boleto;
      DataSet.FieldByName('PESSOA').AsString:= vList.Items[I].Recebimento.Pessoa.Nome;
      DataSet.FieldByName('REFERENTE').AsString:= vList.Items[I].Recebimento.Descricao;
      DataSet.FieldByName('VENCIMENTO').AsDateTime:= vList.Items[I].Vencimento;
      DataSet.FieldByName('VALOR').AsExtended:= vList.Items[I].ValorDocumento;
      DataSet.Post;
    end;
    FreeAndNil(vList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TBoleto.listByContaIdRemessaIsNull(ContaId: string): TObjectList<TBoleto>;
const
  FSql: string =
  'SELECT B.ID FROM BOLETOS B ' +
  'JOIN RECEBIMENTOS R ON(R.ID = B.RECEBIMENTO_ID) ' +
  'WHERE (B.EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (R.CONTA_ID = :CONTA_ID) ' +
  'AND (B.REMESSA_ID IS NULL)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('CONTA_ID').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('CONTA_ID').AsString:= ContaId;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TBoleto>.Create;
        while not FDQuery.Eof do
        begin
          Result.Add(TBoleto.find(FDQuery.FieldByName('ID').AsString));
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

function TBoleto.getEmpresa: TEmpresa;
begin
  if not Assigned(Self.FEMPRESA) then
    Self.FEMPRESA:= TEmpresa.find(Self.EmpresaId);

  Result:= Self.FEMPRESA;
end;

function TBoleto.getNossoNumero: string;
var
  vNumero: Integer;
begin
  vNumero:= StrToIntDef(Self.Recebimento.Conta.BoletoConfiguracao.NossoNumero, 0) + 1;
  Self.Recebimento.Conta.BoletoConfiguracao.NossoNumero:= vNumero.ToString();
  Self.Recebimento.Conta.BoletoConfiguracao.save();
  Result:= vNumero.ToString();
end;

function TBoleto.getRecebimento: TRecebimento;
begin
  if not Assigned(Self.FRECEBIMENTO) then
    Self.FRECEBIMENTO:= TRecebimento.find(Self.RecebimentoId);
  
  Result:= Self.FRECEBIMENTO;
end;

class procedure TBoleto.imprimirBoleto(id: string);
var
  Boleto: TBoleto;
  ACBrBoleto: TACBrBoleto;
  ACBrBoletoFC: TACBrBoletoFCFortes;
  vDir: string;
begin
  try
    try
      vDir:= '';
      ACBrBoletoFC:= nil;
      ACBrBoleto:= nil;
      Boleto:= TBoleto.find(id);
      if not Assigned(Boleto) then
        raise Exception.Create('Falha ao consultar dados do boleto.');

      if not Assigned(Boleto.Recebimento.Conta.BoletoConfiguracao) then
        raise Exception.Create('Conta sem dados do banco.');

      if not Assigned(Boleto.Recebimento.Conta.Cedente) then
        raise Exception.Create('Conta sem dados do cedente.');

      ACBrBoleto:= TACBrBoleto.Create(nil);
      ACBrBoleto.Banco.TipoCobranca:= TACBrTipoCobranca(Boleto.Recebimento.Conta.BoletoConfiguracao.TipoCobranca);
      ACBrBoleto.Cedente.Nome:= Boleto.Recebimento.Conta.Cedente.Nome;
      ACBrBoleto.Cedente.CodigoCedente:= Boleto.Recebimento.Conta.Cedente.CodigoCedente;
      ACBrBoleto.Cedente.CodigoTransmissao:= Boleto.Recebimento.Conta.Cedente.CodigoTransmissao;
      ACBrBoleto.Cedente.Agencia:= Boleto.Recebimento.Conta.Cedente.Agencia;
      ACBrBoleto.Cedente.AgenciaDigito:= Boleto.Recebimento.Conta.Cedente.AgenciaDigito;
      ACBrBoleto.Cedente.Conta:= Boleto.Recebimento.Conta.Cedente.Conta;
      ACBrBoleto.Cedente.ContaDigito:= Boleto.Recebimento.Conta.Cedente.ContaDigito;
      ACBrBoleto.Cedente.Modalidade:= Boleto.Recebimento.Conta.Cedente.Modalidade;
      ACBrBoleto.Cedente.Convenio:= Boleto.Recebimento.Conta.Cedente.Convenio;
      //ACBrBoleto.Cedente.TipoDocumento:= TACBrTipoDocumento(Boleto.Recebimento.Conta.Cedente.TipoDocumento);
      //ACBrBoleto.Cedente.TipoCarteira:= TACBrTipoCarteira(Boleto.Recebimento.Conta.Cedente.TipoCarteira);
      //ACBrBoleto.Cedente.ResponEmissao:= TACBrResponEmissao(Boleto.Recebimento.Conta.Cedente.ResponEmissao);
      //ACBrBoleto.Cedente.CaracTitulo:= TACBrCaracTitulo(Boleto.Recebimento.Conta.Cedente.CaracTitulo);
      //ACBrBoleto.Cedente.TipoInscricao:= TACBrPessoaCedente(IfThen(Boleto.Recebimento.Conta.Cedente.TipoInscricao = 'F', 0, 1));
      ACBrBoleto.Cedente.CNPJCPF:= Boleto.Recebimento.Conta.Cedente.Cnpjcpf;
      ACBrBoleto.Cedente.Logradouro:= Boleto.Recebimento.Conta.Cedente.Logradouro;
      ACBrBoleto.Cedente.NumeroRes:= Boleto.Recebimento.Conta.Cedente.NumeroRes;
      ACBrBoleto.Cedente.Complemento:= Boleto.Recebimento.Conta.Cedente.Complemento;
      ACBrBoleto.Cedente.Bairro:= Boleto.Recebimento.Conta.Cedente.Bairro;
      ACBrBoleto.Cedente.Cidade:= Boleto.Recebimento.Conta.Cedente.Cidade;
      ACBrBoleto.Cedente.UF:= Boleto.Recebimento.Conta.Cedente.Uf;
      ACBrBoleto.Cedente.CEP:= Boleto.Recebimento.Conta.Cedente.Cep;
      ACBrBoleto.Cedente.Telefone:= Boleto.Recebimento.Conta.Cedente.Telefone;

      with ACBrBoleto.CriarTituloNaLista do
      begin
        LocalPagamento:= Boleto.Recebimento.Conta.BoletoConfiguracao.LocalPagamento;
        Vencimento:= Boleto.Vencimento;
        DataDocumento:= Boleto.DataDocumento;
        NumeroDocumento:= Boleto.NumeroDocumento;
        EspecieDoc:= Boleto.EspecieDoc;
        //Aceite:= TACBrAceiteTitulo(Boleto.Aceite);
        DataProcessamento:= Boleto.DataProcessamento;
        Carteira:= Boleto.Carteira;
        NossoNumero:= Boleto.NossoNumero;
        ValorDocumento:= Boleto.ValorDocumento;
        CodigoMora:= Boleto.CodigoMora;
        ValorMoraJuros:= Boleto.ValorMorajuros;
        PercentualMulta:= Boleto.PercentualMulta;
        MultaValorFixo:= Boleto.MultaValorFixo = 'N';
        Mensagem.Add(Boleto.Mensagem);
        Mensagem.Add(Boleto.Recebimento.Descricao);

        Sacado.NomeSacado:= Boleto.Recebimento.Pessoa.Nome;
        Sacado.CNPJCPF:= Boleto.Recebimento.Pessoa.Documento;
        Sacado.Logradouro:= Boleto.Recebimento.Pessoa.Logradouro;
        Sacado.Numero:= Boleto.Recebimento.Pessoa.Numero;
        Sacado.Bairro:= Boleto.Recebimento.Pessoa.Bairro;
        Sacado.Cidade:= Boleto.Recebimento.Pessoa.NomeMunicipio;
        Sacado.UF:= Boleto.Recebimento.Pessoa.Uf;
        Sacado.CEP:= Boleto.Recebimento.Pessoa.Cep;
        Sacado.Email:= Boleto.Recebimento.Pessoa.Email;
        Sacado.Fone:= Boleto.Recebimento.Pessoa.Fone;

        OcorrenciaOriginal.Tipo:= toRemessaRegistrar;
      end;

      Boleto.Recebimento.Boleto:=
        THelper.ReturnsInteger(ACBrBoleto.Banco.MontarCampoNossoNumero(ACBrBoleto.ListadeBoletos.Objects[0]));
      Boleto.Recebimento.save();

      vDir:= ExtractFileDir(Application.ExeName) + '\boleto';

      ACBrBoletoFC:= TACBrBoletoFCFortes.Create(nil);
      ACBrBoletoFC.DirLogo:= vDir + '\colorido';
      ACBrBoletoFC.NomeArquivo:=
        vDir +
        '\' + Boleto.Recebimento.Pessoa.Nome +
        '_' + FormatDateTime('dd-mm-yyyy', Boleto.Vencimento) +
        '_' + Boleto.Recebimento.Boleto + '.pdf';
      ACBrBoleto.ACBrBoletoFC:= ACBrBoletoFC;
      ACBrBoleto.GerarPDF;
      ACBrBoleto.Imprimir;
    except on e: exception do
      raise Exception.Create(e.Message);
    end;
  finally
    if Assigned(ACBrBoletoFC) then FreeAndNil(ACBrBoletoFC);
    if Assigned(ACBrBoleto) then FreeAndNil(ACBrBoleto);
    if Assigned(Boleto) then FreeAndNil(Boleto);
  end;
end;

class function TBoleto.list(search: string): TObjectList<TBoleto>;
const
  FSql: string =
  'SELECT B.ID FROM BOLETOS B ' +
  'WHERE (B.EMPRESA_ID = :EMPRESA_ID) AND (B.DELETED_AT IS NULL) ';
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
        Result:= TObjectList<TBoleto>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TBoleto.find(FDQuery.FieldByName('ID').AsString));
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

class procedure TBoleto.list(search: string; DataSet: TFDMemTable);
var
  vList: TObjectList<TBoleto>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  vList:= TBoleto.list(search);
  if Assigned(vList) then
  begin
    for I := 0 to Pred(vList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= vList.Items[I].Id;
      DataSet.FieldByName('DATA_PROCESSAMENTO').AsDateTime:= vList.Items[I].DataProcessamento;
      DataSet.FieldByName('NOSSO_NUMERO').AsString:= vList.Items[I].NossoNumero;
      DataSet.FieldByName('VALOR_DOCUMENTO').AsExtended:= vList.Items[I].ValorDocumento;
      DataSet.FieldByName('VENCIMENTO').AsDateTime:= vList.Items[I].Vencimento;
      DataSet.Post;
    end;
    FreeAndNil(vList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class procedure TBoleto.recebimentoToBoleto(RecebimentoId: string);
var
  Recebimento: TRecebimento;
  Boleto: TBoleto;
begin
  Recebimento:= nil;
  try
    try
      Boleto:= TBoleto.findByRecebimentoId(RecebimentoId);
      if Assigned(Boleto) then
      begin
        Self.imprimirBoleto(Boleto.Id);
        Exit();
      end;
      
      Recebimento:= TRecebimento.find(RecebimentoId);
      if not Assigned(Recebimento) then
        raise Exception.Create('Falha ao consultar dados do recebimento.');

      if not Assigned(Recebimento.Conta.BoletoConfiguracao) then
      begin
        TAuthService.ContaId:= Recebimento.Conta.Id;
        try
          formBoletoCreateEdit:= TformBoletoCreateEdit.Create(nil);
          formBoletoCreateEdit.ShowModal;
        finally
          FreeAndNil(formBoletoCreateEdit);
        end;

        if (TAuthService.BoletoConfiguracaoId = EmptyStr) then
          raise Exception.Create('Conta sem dados do banco. Procedimento foi cancelado!');
      end;

      if not Assigned(Recebimento.Conta.Cedente) then
      begin
        TAuthService.ContaId:= Recebimento.Conta.Id;
        try
          formCedenteCreateEdit:= TformCedenteCreateEdit.Create(nil);
          formCedenteCreateEdit.ShowModal;
        finally
          FreeAndNil(formCedenteCreateEdit);
        end;

        if (TAuthService.CedenteId = EmptyStr) then
          raise Exception.Create('Conta sem dados do cedente. Procedimento foi cancelado!');
      end;

      Boleto:= TBoleto.Create;
      Boleto.RecebimentoId:= RecebimentoId;
      Boleto.Vencimento:= Recebimento.Vencimento;
      Boleto.DataDocumento:= Recebimento.Competencia;
      Boleto.NumeroDocumento:= Recebimento.Referencia.ToString();
      Boleto.EspecieDoc:= 'DM';
      Boleto.Aceite:= 1;
      Boleto.DataProcessamento:= Now;
      Boleto.Carteira:= Recebimento.Conta.BoletoConfiguracao.Carteira;
      Boleto.ValorDocumento:= (Recebimento.Valor + Recebimento.Conta.BoletoConfiguracao.TarifaCobranca);
      if (Recebimento.Conta.BoletoConfiguracao.Juros > 0) then
      begin
        case Recebimento.Conta.BoletoConfiguracao.TipoCobranca of
          4: Boleto.CodigoMora:= IfThen(Recebimento.Conta.BoletoConfiguracao.JurosPercentual = 'N', '1', '2');
          8: Boleto.CodigoMora:= IfThen(Recebimento.Conta.BoletoConfiguracao.JurosPercentual = 'N', 'A', 'B');
          else
            Boleto.CodigoMora:= '';
        end;

        Boleto.ValorMorajuros:= Recebimento.Conta.BoletoConfiguracao.Juros;
      end;
      Boleto.PercentualMulta:= Recebimento.Conta.BoletoConfiguracao.Multa;
      Boleto.MultaValorFixo:= Recebimento.Conta.BoletoConfiguracao.MultaPercentual;
      Boleto.Mensagem:= Recebimento.Conta.BoletoConfiguracao.Mensagem;
      if Boleto.save() then;
      begin
        Recebimento.Boleto:= Boleto.NossoNumero;
        Recebimento.save();
        Self.imprimirBoleto(Boleto.Id);
      end;
    except on e: exception do
      raise Exception.Create('Falha ao tentar imprimir o boleto. Erro: ' + e.Message);
    end;
  finally
    if Assigned(Recebimento) then FreeAndNil(Recebimento);
    if Assigned(Boleto) then FreeAndNil(Boleto);
  end;
end;

class function TBoleto.removeByRecebimentoId(RecebimentoId: string): Boolean;
var
  Boleto: TBoleto;
begin
  Result:= False;
  Boleto:= TBoleto.findByRecebimentoId(RecebimentoId);
  if not Assigned(Boleto) then
  begin
    THelper.Mensagem('Boleto não encontrado. O boleto pode ter sido previamente excluído por outro usuário!');
    Exit();
  end;

  try
    if not THelper.Mensagem('Deseja realmente remover o boleto?', 1) then
      Exit();

    Result:= Boleto.delete();
    if Result then
    begin
      Boleto.Recebimento.Boleto:= EmptyStr;
      Boleto.Recebimento.Email:= 'N';
      Boleto.Recebimento.save();
    end;
  finally
    FreeAndNil(Boleto);
  end;
end;

function TBoleto.save: Boolean;
begin
  Result:= inherited;
end;

function TBoleto.store: Boolean;
const
  FSql: string =
  'INSERT INTO BOLETOS (          ' +
  '  ID,                          ' +
  '  EMPRESA_ID,                  ' +
  '  RECEBIMENTO_ID,              ' +
  '  VENCIMENTO,                  ' +
  '  DATA_DOCUMENTO,              ' +
  '  NUMERO_DOCUMENTO,            ' +
  '  ESPECIE_DOC,                 ' +
  '  ACEITE,                      ' +
  '  DATA_PROCESSAMENTO,          ' +
  '  NOSSO_NUMERO,                ' +
  '  USO_BANCO,                   ' +
  '  CARTEIRA,                    ' +
  '  CARTEIRA_ENVIO,              ' +
  '  ESPECIE_MOD,                 ' +
  '  VALOR_DOCUMENTO,             ' +
  '  MENSAGEM,                    ' +
  '  INFORMATIVO,                 ' +
  '  PRIMEIRA_INSTRUCAO,          ' +
  '  SEGUNDA_INSTRUCAO,           ' +
  '  TERCEIRA_INSTRUCAO,          ' +
  '  PARCELA,                     ' +
  '  TOTAL_PARCELAS,              ' +
  '  CODIGO_LIQUIDACAO,           ' +
  '  CODIGO_LIQUIDACAO_DESCRICAO, ' +
  '  MOTIVO_REJEICAO_COMANDO,     ' +
  '  DATA_OCORRENCIA,             ' +
  '  DATA_CREDITO,                ' +
  '  DATA_ABATIMENTO,             ' +
  '  DATA_DESCONTO,               ' +
  '  DATA_MORAJUROS,              ' +
  '  DATA_PROTESTO,               ' +
  '  DATA_BAIXA,                  ' +
  '  DATA_LIMITE_PAGTO,           ' +
  '  VALOR_DESPESA_COBRANCA,      ' +
  '  VALOR_ABATIMENTO,            ' +
  '  VALOR_DESCONTO,              ' +
  '  VALOR_MORAJUROS,             ' +
  '  VALOR_IOF,                   ' +
  '  VALOR_OUTRAS_DESPESAS,       ' +
  '  VALOR_OUTROS_CREDITOS,       ' +
  '  VALOR_PAGO,                  ' +
  '  VALOR_RECEBIDO,              ' +
  '  REFERENCIA,                  ' +
  '  VERSAO,                      ' +
  '  SEU_NUMERO,                  ' +
  '  PERCENTUAL_MULTA,            ' +
  '  MULTA_VALOR_FIXO,            ' +
  '  VALOR_DESCONTO_ANT_DIA,      ' +
  '  TEXTO_LIVRE,                 ' +
  '  CODIGO_MORA,                 ' +
  '  TIPO_DIAS_PROTESTO,          ' +
  '  TIPO_IMPRESSAO,              ' +
  '  LINHA_DIGITADA,              ' +
  '  CODIGO_GERACAO,              ' +
  '  CARAC_TITULO,                ' +
  '  CREATED_AT,                  ' +
  '  UPDATED_AT)                  ' +
  'VALUES (                       ' +
  '  :ID,                         ' +
  '  :EMPRESA_ID,                 ' +
  '  :RECEBIMENTO_ID,             ' +
  '  :VENCIMENTO,                 ' +
  '  :DATA_DOCUMENTO,             ' +
  '  :NUMERO_DOCUMENTO,           ' +
  '  :ESPECIE_DOC,                ' +
  '  :ACEITE,                     ' +
  '  :DATA_PROCESSAMENTO,         ' +
  '  :NOSSO_NUMERO,               ' +
  '  :USO_BANCO,                  ' +
  '  :CARTEIRA,                   ' +
  '  :CARTEIRA_ENVIO,             ' +
  '  :ESPECIE_MOD,                ' +
  '  :VALOR_DOCUMENTO,            ' +
  '  :MENSAGEM,                   ' +
  '  :INFORMATIVO,                ' +
  '  :PRIMEIRA_INSTRUCAO,         ' +
  '  :SEGUNDA_INSTRUCAO,          ' +
  '  :TERCEIRA_INSTRUCAO,         ' +
  '  :PARCELA,                    ' +
  '  :TOTAL_PARCELAS,             ' +
  '  :CODIGO_LIQUIDACAO,          ' +
  '  :CODIGO_LIQUIDACAO_DESCRICAO,' +
  '  :MOTIVO_REJEICAO_COMANDO,    ' +
  '  :DATA_OCORRENCIA,            ' +
  '  :DATA_CREDITO,               ' +
  '  :DATA_ABATIMENTO,            ' +
  '  :DATA_DESCONTO,              ' +
  '  :DATA_MORAJUROS,             ' +
  '  :DATA_PROTESTO,              ' +
  '  :DATA_BAIXA,                 ' +
  '  :DATA_LIMITE_PAGTO,          ' +
  '  :VALOR_DESPESA_COBRANCA,     ' +
  '  :VALOR_ABATIMENTO,           ' +
  '  :VALOR_DESCONTO,             ' +
  '  :VALOR_MORAJUROS,            ' +
  '  :VALOR_IOF,                  ' +
  '  :VALOR_OUTRAS_DESPESAS,      ' +
  '  :VALOR_OUTROS_CREDITOS,      ' +
  '  :VALOR_PAGO,                 ' +
  '  :VALOR_RECEBIDO,             ' +
  '  :REFERENCIA,                 ' +
  '  :VERSAO,                     ' +
  '  :SEU_NUMERO,                 ' +
  '  :PERCENTUAL_MULTA,           ' +
  '  :MULTA_VALOR_FIXO,           ' +
  '  :VALOR_DESCONTO_ANT_DIA,     ' +
  '  :TEXTO_LIVRE,                ' +
  '  :CODIGO_MORA,                ' +
  '  :TIPO_DIAS_PROTESTO,         ' +
  '  :TIPO_IMPRESSAO,             ' +
  '  :LINHA_DIGITADA,             ' +
  '  :CODIGO_GERACAO,             ' +
  '  :CARAC_TITULO,               ' +
  '  :CREATED_AT,                 ' +
  '  :UPDATED_AT)                 ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    Self.StartTransaction;
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('RECEBIMENTO_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('VENCIMENTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('DATA_DOCUMENTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('NUMERO_DOCUMENTO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('ESPECIE_DOC').DataType:= ftWideString;
      FDQuery.Params.ParamByName('ACEITE').DataType:= ftInteger;
      FDQuery.Params.ParamByName('DATA_PROCESSAMENTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('NOSSO_NUMERO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('USO_BANCO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CARTEIRA').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CARTEIRA_ENVIO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('ESPECIE_MOD').DataType:= ftWideString;
      FDQuery.Params.ParamByName('VALOR_DOCUMENTO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('MENSAGEM').DataType:= ftWideString;
      FDQuery.Params.ParamByName('INFORMATIVO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('PRIMEIRA_INSTRUCAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('SEGUNDA_INSTRUCAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('TERCEIRA_INSTRUCAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('PARCELA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('TOTAL_PARCELAS').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CODIGO_LIQUIDACAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CODIGO_LIQUIDACAO_DESCRICAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('MOTIVO_REJEICAO_COMANDO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('DATA_OCORRENCIA').DataType:= ftDate;
      FDQuery.Params.ParamByName('DATA_CREDITO').DataType:= ftDate;
      FDQuery.Params.ParamByName('DATA_ABATIMENTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('DATA_DESCONTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('DATA_MORAJUROS').DataType:= ftDate;
      FDQuery.Params.ParamByName('DATA_PROTESTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('DATA_BAIXA').DataType:= ftDate;
      FDQuery.Params.ParamByName('DATA_LIMITE_PAGTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('VALOR_DESPESA_COBRANCA').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALOR_ABATIMENTO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALOR_DESCONTO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALOR_MORAJUROS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALOR_IOF').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALOR_OUTRAS_DESPESAS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALOR_OUTROS_CREDITOS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALOR_PAGO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALOR_RECEBIDO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftWideString;
      FDQuery.Params.ParamByName('VERSAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('SEU_NUMERO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('PERCENTUAL_MULTA').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('MULTA_VALOR_FIXO').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('VALOR_DESCONTO_ANT_DIA').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('TEXTO_LIVRE').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CODIGO_MORA').DataType:= ftWideString;
      FDQuery.Params.ParamByName('TIPO_DIAS_PROTESTO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('TIPO_IMPRESSAO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('LINHA_DIGITADA').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CODIGO_GERACAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CARAC_TITULO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;
      Self.NossoNumero:= getNossoNumero; 

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('RECEBIMENTO_ID').AsString:= Self.RecebimentoId;
      if (Self.Vencimento > 0) then
      FDQuery.Params.ParamByName('VENCIMENTO').AsDate:= Self.Vencimento;
      if (Self.DataDocumento > 0) then
      FDQuery.Params.ParamByName('DATA_DOCUMENTO').AsDate:= Self.DataDocumento;
      if (Self.NumeroDocumento <> EmptyStr) then
      FDQuery.Params.ParamByName('NUMERO_DOCUMENTO').AsString:= Self.NumeroDocumento;
      if (Self.EspecieDoc <> EmptyStr) then
      FDQuery.Params.ParamByName('ESPECIE_DOC').AsString:= Self.EspecieDoc;
      FDQuery.Params.ParamByName('ACEITE').AsInteger:= Self.Aceite;
      if (Self.DataProcessamento > 0) then
      FDQuery.Params.ParamByName('DATA_PROCESSAMENTO').AsDate:= Self.DataProcessamento;
      if (Self.NossoNumero <> EmptyStr) then
      FDQuery.Params.ParamByName('NOSSO_NUMERO').AsString:= Self.NossoNumero;
      if (Self.UsoBanco <> EmptyStr) then
      FDQuery.Params.ParamByName('USO_BANCO').AsString:= Self.UsoBanco;
      if (Self.Carteira <> EmptyStr) then
      FDQuery.Params.ParamByName('CARTEIRA').AsString:= Self.Carteira;
      FDQuery.Params.ParamByName('CARTEIRA_ENVIO').AsInteger:= Self.CarteiraEnvio;
      if (Self.EspecieMod <> EmptyStr) then
      FDQuery.Params.ParamByName('ESPECIE_MOD').AsString:= Self.EspecieMod;
      if (Self.ValorDocumento >= 0) then
      FDQuery.Params.ParamByName('VALOR_DOCUMENTO').AsFMTBCD:= Self.ValorDocumento;
      if (Self.Mensagem <> EmptyStr) then
      FDQuery.Params.ParamByName('MENSAGEM').AsString:= Self.Mensagem;
      if (Self.Informativo <> EmptyStr) then
      FDQuery.Params.ParamByName('INFORMATIVO').AsString:= Self.Informativo;
      if (Self.PrimeiraInstrucao <> EmptyStr) then
      FDQuery.Params.ParamByName('PRIMEIRA_INSTRUCAO').AsString:= Self.PrimeiraInstrucao;
      if (Self.SegundaInstrucao <> EmptyStr) then
      FDQuery.Params.ParamByName('SEGUNDA_INSTRUCAO').AsString:= Self.SegundaInstrucao;
      if (Self.TerceiraInstrucao <> EmptyStr) then
      FDQuery.Params.ParamByName('TERCEIRA_INSTRUCAO').AsString:= Self.TerceiraInstrucao;
      if (Self.Parcela >= 1) then
      FDQuery.Params.ParamByName('PARCELA').AsInteger:= Self.Parcela;
      if (Self.TotalParcelas >= 1) then
      FDQuery.Params.ParamByName('TOTAL_PARCELAS').AsInteger:= Self.TotalParcelas;
      if (Self.CodigoLiquidacao <> EmptyStr) then
      FDQuery.Params.ParamByName('CODIGO_LIQUIDACAO').AsString:= Self.CodigoLiquidacao;
      if (Self.CodigoLiquidacaoDescricao <> EmptyStr) then
      FDQuery.Params.ParamByName('CODIGO_LIQUIDACAO_DESCRICAO').AsString:= Self.CodigoLiquidacaoDescricao;
      if (Self.MotivoRejeicaoComando <> EmptyStr) then
      FDQuery.Params.ParamByName('MOTIVO_REJEICAO_COMANDO').AsString:= Self.MotivoRejeicaoComando;
      if (Self.DataOcorrencia > 0) then
      FDQuery.Params.ParamByName('DATA_OCORRENCIA').AsDate:= Self.DataOcorrencia;
      if (Self.DataCredito > 0) then
      FDQuery.Params.ParamByName('DATA_CREDITO').AsDate:= Self.DataCredito;
      if (Self.DataAbatimento > 0) then
      FDQuery.Params.ParamByName('DATA_ABATIMENTO').AsDate:= Self.DataAbatimento;
      if (Self.DataDesconto > 0) then
      FDQuery.Params.ParamByName('DATA_DESCONTO').AsDate:= Self.DataDesconto;
      if (Self.DataMorajuros > 0) then
      FDQuery.Params.ParamByName('DATA_MORAJUROS').AsDate:= Self.DataMorajuros;
      if (Self.DataProtesto > 0) then
      FDQuery.Params.ParamByName('DATA_PROTESTO').AsDate:= Self.DataProtesto;
      if (Self.DataBaixa > 0) then
      FDQuery.Params.ParamByName('DATA_BAIXA').AsDate:= Self.DataBaixa;
      if (Self.DataLimitePagto > 0) then
      FDQuery.Params.ParamByName('DATA_LIMITE_PAGTO').AsDate:= Self.DataLimitePagto;
      if (Self.ValorDespesaCobranca >= 0) then
      FDQuery.Params.ParamByName('VALOR_DESPESA_COBRANCA').AsFMTBCD:= Self.ValorDespesaCobranca;
      if (Self.ValorAbatimento >= 0) then
      FDQuery.Params.ParamByName('VALOR_ABATIMENTO').AsFMTBCD:= Self.ValorAbatimento;
      if (Self.ValorDesconto >= 0) then
      FDQuery.Params.ParamByName('VALOR_DESCONTO').AsFMTBCD:= Self.ValorDesconto;
      if (Self.ValorMorajuros >= 0) then
      FDQuery.Params.ParamByName('VALOR_MORAJUROS').AsFMTBCD:= Self.ValorMorajuros;
      if (Self.ValorIof >= 0) then
      FDQuery.Params.ParamByName('VALOR_IOF').AsFMTBCD:= Self.ValorIof;
      if (Self.ValorOutrasDespesas >= 0) then
      FDQuery.Params.ParamByName('VALOR_OUTRAS_DESPESAS').AsFMTBCD:= Self.ValorOutrasDespesas;
      if (Self.ValorOutrosCreditos >= 0) then
      FDQuery.Params.ParamByName('VALOR_OUTROS_CREDITOS').AsFMTBCD:= Self.ValorOutrosCreditos;
      if (Self.ValorPago >= 0) then
      FDQuery.Params.ParamByName('VALOR_PAGO').AsFMTBCD:= Self.ValorPago;
      if (Self.ValorRecebido >= 0) then
      FDQuery.Params.ParamByName('VALOR_RECEBIDO').AsFMTBCD:= Self.ValorRecebido;
      if (Self.Referencia <> EmptyStr) then
      FDQuery.Params.ParamByName('REFERENCIA').AsString:= Self.Referencia;
      if (Self.Versao <> EmptyStr) then
      FDQuery.Params.ParamByName('VERSAO').AsString:= Self.Versao;
      if (Self.SeuNumero <> EmptyStr) then
      FDQuery.Params.ParamByName('SEU_NUMERO').AsString:= Self.SeuNumero;
      if (Self.ValorRecebido >= 0) then
      FDQuery.Params.ParamByName('PERCENTUAL_MULTA').AsFMTBCD:= Self.PercentualMulta;
      FDQuery.Params.ParamByName('MULTA_VALOR_FIXO').AsString:= Self.MultaValorFixo;
      if (Self.ValorDescontoAntDia >= 0) then
      FDQuery.Params.ParamByName('VALOR_DESCONTO_ANT_DIA').AsFMTBCD:= Self.ValorDescontoAntDia;
      if (Self.TextoLivre <> EmptyStr) then
      FDQuery.Params.ParamByName('TEXTO_LIVRE').AsString:= Self.TextoLivre;
      if (Self.CodigoMora <> EmptyStr) then
      FDQuery.Params.ParamByName('CODIGO_MORA').AsString:= Self.CodigoMora;
      FDQuery.Params.ParamByName('TIPO_DIAS_PROTESTO').AsInteger:= Self.TipoDiasProtesto;
      FDQuery.Params.ParamByName('TIPO_IMPRESSAO').AsInteger:= Self.TipoImpressao;
      if (Self.LinhaDigitada <> EmptyStr) then
      FDQuery.Params.ParamByName('LINHA_DIGITADA').AsString:= Self.LinhaDigitada;
      if (Self.CodigoGeracao <> EmptyStr) then
      FDQuery.Params.ParamByName('CODIGO_GERACAO').AsString:= Self.CodigoGeracao;
      FDQuery.Params.ParamByName('CARAC_TITULO').AsInteger:= Self.CaracTitulo;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
      
      Self.Commit;
    except on e: exception do
      begin
        Self.Rollback;
        Result:= False;
        raise Exception.Create('falha ao inserir o boleto. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TBoleto.update: Boolean;
const
  FSql: string =
  'UPDATE BOLETOS                                                 ' +
  'SET REMESSA_ID = :REMESSA_ID,                                  ' +
  '    RETORNO_ID = :RETORNO_ID,                                  ' +
  '    VENCIMENTO = :VENCIMENTO,                                  ' +
  '    DATA_DOCUMENTO = :DATA_DOCUMENTO,                          ' +
  '    NUMERO_DOCUMENTO = :NUMERO_DOCUMENTO,                      ' +
  '    ESPECIE_DOC = :ESPECIE_DOC,                                ' +
  '    ACEITE = :ACEITE,                                          ' +
  '    DATA_PROCESSAMENTO = :DATA_PROCESSAMENTO,                  ' +
  '    NOSSO_NUMERO = :NOSSO_NUMERO,                              ' +
  '    USO_BANCO = :USO_BANCO,                                    ' +
  '    CARTEIRA = :CARTEIRA,                                      ' +
  '    CARTEIRA_ENVIO = :CARTEIRA_ENVIO,                          ' +
  '    ESPECIE_MOD = :ESPECIE_MOD,                                ' +
  '    VALOR_DOCUMENTO = :VALOR_DOCUMENTO,                        ' +
  '    MENSAGEM = :MENSAGEM,                                      ' +
  '    INFORMATIVO = :INFORMATIVO,                                ' +
  '    PRIMEIRA_INSTRUCAO = :PRIMEIRA_INSTRUCAO,                  ' +
  '    SEGUNDA_INSTRUCAO = :SEGUNDA_INSTRUCAO,                    ' +
  '    TERCEIRA_INSTRUCAO = :TERCEIRA_INSTRUCAO,                  ' +
  '    PARCELA = :PARCELA,                                        ' +
  '    TOTAL_PARCELAS = :TOTAL_PARCELAS,                          ' +
  '    CODIGO_LIQUIDACAO = :CODIGO_LIQUIDACAO,                    ' +
  '    CODIGO_LIQUIDACAO_DESCRICAO = :CODIGO_LIQUIDACAO_DESCRICAO,' +
  '    MOTIVO_REJEICAO_COMANDO = :MOTIVO_REJEICAO_COMANDO,        ' +
  '    DATA_OCORRENCIA = :DATA_OCORRENCIA,                        ' +
  '    DATA_CREDITO = :DATA_CREDITO,                              ' +
  '    DATA_ABATIMENTO = :DATA_ABATIMENTO,                        ' +
  '    DATA_DESCONTO = :DATA_DESCONTO,                            ' +
  '    DATA_MORAJUROS = :DATA_MORAJUROS,                          ' +
  '    DATA_PROTESTO = :DATA_PROTESTO,                            ' +
  '    DATA_BAIXA = :DATA_BAIXA,                                  ' +
  '    DATA_LIMITE_PAGTO = :DATA_LIMITE_PAGTO,                    ' +
  '    VALOR_DESPESA_COBRANCA = :VALOR_DESPESA_COBRANCA,          ' +
  '    VALOR_ABATIMENTO = :VALOR_ABATIMENTO,                      ' +
  '    VALOR_DESCONTO = :VALOR_DESCONTO,                          ' +
  '    VALOR_MORAJUROS = :VALOR_MORAJUROS,                        ' +
  '    VALOR_IOF = :VALOR_IOF,                                    ' +
  '    VALOR_OUTRAS_DESPESAS = :VALOR_OUTRAS_DESPESAS,            ' +
  '    VALOR_OUTROS_CREDITOS = :VALOR_OUTROS_CREDITOS,            ' +
  '    VALOR_PAGO = :VALOR_PAGO,                                  ' +
  '    VALOR_RECEBIDO = :VALOR_RECEBIDO,                          ' +
  '    REFERENCIA = :REFERENCIA,                                  ' +
  '    VERSAO = :VERSAO,                                          ' +
  '    SEU_NUMERO = :SEU_NUMERO,                                  ' +
  '    PERCENTUAL_MULTA = :PERCENTUAL_MULTA,                      ' +
  '    MULTA_VALOR_FIXO = :MULTA_VALOR_FIXO,                      ' +
  '    VALOR_DESCONTO_ANT_DIA = :VALOR_DESCONTO_ANT_DIA,          ' +
  '    TEXTO_LIVRE = :TEXTO_LIVRE,                                ' +
  '    CODIGO_MORA = :CODIGO_MORA,                                ' +
  '    TIPO_DIAS_PROTESTO = :TIPO_DIAS_PROTESTO,                  ' +
  '    TIPO_IMPRESSAO = :TIPO_IMPRESSAO,                          ' +
  '    LINHA_DIGITADA = :LINHA_DIGITADA,                          ' +
  '    CODIGO_GERACAO = :CODIGO_GERACAO,                          ' +
  '    CARAC_TITULO = :CARAC_TITULO,                              ' +
  '    UPDATED_AT = :UPDATED_AT,                                  ' +
  '    SYNCHRONIZED = :SYNCHRONIZED                               ' +
  'WHERE (ID = :ID)                                               ';
var                                                               
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('REMESSA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('RETORNO_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('VENCIMENTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('DATA_DOCUMENTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('NUMERO_DOCUMENTO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('ESPECIE_DOC').DataType:= ftWideString;
      FDQuery.Params.ParamByName('ACEITE').DataType:= ftInteger;
      FDQuery.Params.ParamByName('DATA_PROCESSAMENTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('NOSSO_NUMERO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('USO_BANCO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CARTEIRA').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CARTEIRA_ENVIO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('ESPECIE_MOD').DataType:= ftWideString;
      FDQuery.Params.ParamByName('VALOR_DOCUMENTO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('MENSAGEM').DataType:= ftWideString;
      FDQuery.Params.ParamByName('INFORMATIVO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('PRIMEIRA_INSTRUCAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('SEGUNDA_INSTRUCAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('TERCEIRA_INSTRUCAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('PARCELA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('TOTAL_PARCELAS').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CODIGO_LIQUIDACAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CODIGO_LIQUIDACAO_DESCRICAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('MOTIVO_REJEICAO_COMANDO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('DATA_OCORRENCIA').DataType:= ftDate;
      FDQuery.Params.ParamByName('DATA_CREDITO').DataType:= ftDate;
      FDQuery.Params.ParamByName('DATA_ABATIMENTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('DATA_DESCONTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('DATA_MORAJUROS').DataType:= ftDate;
      FDQuery.Params.ParamByName('DATA_PROTESTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('DATA_BAIXA').DataType:= ftDate;
      FDQuery.Params.ParamByName('DATA_LIMITE_PAGTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('VALOR_DESPESA_COBRANCA').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALOR_ABATIMENTO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALOR_DESCONTO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALOR_MORAJUROS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALOR_IOF').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALOR_OUTRAS_DESPESAS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALOR_OUTROS_CREDITOS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALOR_PAGO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALOR_RECEBIDO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftWideString;
      FDQuery.Params.ParamByName('VERSAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('SEU_NUMERO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('PERCENTUAL_MULTA').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('MULTA_VALOR_FIXO').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('VALOR_DESCONTO_ANT_DIA').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('TEXTO_LIVRE').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CODIGO_MORA').DataType:= ftWideString;
      FDQuery.Params.ParamByName('TIPO_DIAS_PROTESTO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('TIPO_IMPRESSAO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('LINHA_DIGITADA').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CODIGO_GERACAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CARAC_TITULO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      
      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.RemessaId <> EmptyStr) then
      FDQuery.Params.ParamByName('REMESSA_ID').AsString:= Self.RemessaId;
      if (Self.RetornoId <> EmptyStr) then
      FDQuery.Params.ParamByName('RETORNO_ID').AsString:= Self.RetornoId;
      if (Self.Vencimento > 0) then
      FDQuery.Params.ParamByName('VENCIMENTO').AsDate:= Self.Vencimento;
      if (Self.DataDocumento > 0) then
      FDQuery.Params.ParamByName('DATA_DOCUMENTO').AsDate:= Self.DataDocumento;
      if (Self.NumeroDocumento <> EmptyStr) then
      FDQuery.Params.ParamByName('NUMERO_DOCUMENTO').AsString:= Self.NumeroDocumento;
      if (Self.EspecieDoc <> EmptyStr) then
      FDQuery.Params.ParamByName('ESPECIE_DOC').AsString:= Self.EspecieDoc;
      FDQuery.Params.ParamByName('ACEITE').AsInteger:= Self.Aceite;
      if (Self.DataProcessamento > 0) then
      FDQuery.Params.ParamByName('DATA_PROCESSAMENTO').AsDate:= Self.DataProcessamento;
      if (Self.NossoNumero <> EmptyStr) then
      FDQuery.Params.ParamByName('NOSSO_NUMERO').AsString:= Self.NossoNumero;
      if (Self.UsoBanco <> EmptyStr) then
      FDQuery.Params.ParamByName('USO_BANCO').AsString:= Self.UsoBanco;
      if (Self.Carteira <> EmptyStr) then
      FDQuery.Params.ParamByName('CARTEIRA').AsString:= Self.Carteira;
      FDQuery.Params.ParamByName('CARTEIRA_ENVIO').AsInteger:= Self.CarteiraEnvio;
      if (Self.EspecieMod <> EmptyStr) then
      FDQuery.Params.ParamByName('ESPECIE_MOD').AsString:= Self.EspecieMod;
      if (Self.ValorDocumento >= 0) then
      FDQuery.Params.ParamByName('VALOR_DOCUMENTO').AsFMTBCD:= Self.ValorDocumento;
      if (Self.Mensagem <> EmptyStr) then
      FDQuery.Params.ParamByName('MENSAGEM').AsString:= Self.Mensagem;
      if (Self.Informativo <> EmptyStr) then
      FDQuery.Params.ParamByName('INFORMATIVO').AsString:= Self.Informativo;
      if (Self.PrimeiraInstrucao <> EmptyStr) then
      FDQuery.Params.ParamByName('PRIMEIRA_INSTRUCAO').AsString:= Self.PrimeiraInstrucao;
      if (Self.SegundaInstrucao <> EmptyStr) then
      FDQuery.Params.ParamByName('SEGUNDA_INSTRUCAO').AsString:= Self.SegundaInstrucao;
      if (Self.TerceiraInstrucao <> EmptyStr) then
      FDQuery.Params.ParamByName('TERCEIRA_INSTRUCAO').AsString:= Self.TerceiraInstrucao;
      if (Self.Parcela >= 1) then
      FDQuery.Params.ParamByName('PARCELA').AsInteger:= Self.Parcela;
      if (Self.TotalParcelas >= 1) then
      FDQuery.Params.ParamByName('TOTAL_PARCELAS').AsInteger:= Self.TotalParcelas;
      if (Self.CodigoLiquidacao <> EmptyStr) then
      FDQuery.Params.ParamByName('CODIGO_LIQUIDACAO').AsString:= Self.CodigoLiquidacao;
      if (Self.CodigoLiquidacaoDescricao <> EmptyStr) then
      FDQuery.Params.ParamByName('CODIGO_LIQUIDACAO_DESCRICAO').AsString:= Self.CodigoLiquidacaoDescricao;
      if (Self.MotivoRejeicaoComando <> EmptyStr) then
      FDQuery.Params.ParamByName('MOTIVO_REJEICAO_COMANDO').AsString:= Self.MotivoRejeicaoComando;
      if (Self.DataOcorrencia > 0) then
      FDQuery.Params.ParamByName('DATA_OCORRENCIA').AsDate:= Self.DataOcorrencia;
      if (Self.DataCredito > 0) then
      FDQuery.Params.ParamByName('DATA_CREDITO').AsDate:= Self.DataCredito;
      if (Self.DataAbatimento > 0) then
      FDQuery.Params.ParamByName('DATA_ABATIMENTO').AsDate:= Self.DataAbatimento;
      if (Self.DataDesconto > 0) then
      FDQuery.Params.ParamByName('DATA_DESCONTO').AsDate:= Self.DataDesconto;
      if (Self.DataMorajuros > 0) then
      FDQuery.Params.ParamByName('DATA_MORAJUROS').AsDate:= Self.DataMorajuros;
      if (Self.DataProtesto > 0) then
      FDQuery.Params.ParamByName('DATA_PROTESTO').AsDate:= Self.DataProtesto;
      if (Self.DataBaixa > 0) then
      FDQuery.Params.ParamByName('DATA_BAIXA').AsDate:= Self.DataBaixa;
      if (Self.DataLimitePagto > 0) then
      FDQuery.Params.ParamByName('DATA_LIMITE_PAGTO').AsDate:= Self.DataLimitePagto;
      if (Self.ValorDespesaCobranca >= 0) then
      FDQuery.Params.ParamByName('VALOR_DESPESA_COBRANCA').AsFMTBCD:= Self.ValorDespesaCobranca;
      if (Self.ValorAbatimento >= 0) then
      FDQuery.Params.ParamByName('VALOR_ABATIMENTO').AsFMTBCD:= Self.ValorAbatimento;
      if (Self.ValorDesconto >= 0) then
      FDQuery.Params.ParamByName('VALOR_DESCONTO').AsFMTBCD:= Self.ValorDesconto;
      if (Self.ValorMorajuros >= 0) then
      FDQuery.Params.ParamByName('VALOR_MORAJUROS').AsFMTBCD:= Self.ValorMorajuros;
      if (Self.ValorIof >= 0) then
      FDQuery.Params.ParamByName('VALOR_IOF').AsFMTBCD:= Self.ValorIof;
      if (Self.ValorOutrasDespesas >= 0) then
      FDQuery.Params.ParamByName('VALOR_OUTRAS_DESPESAS').AsFMTBCD:= Self.ValorOutrasDespesas;
      if (Self.ValorOutrosCreditos >= 0) then
      FDQuery.Params.ParamByName('VALOR_OUTROS_CREDITOS').AsFMTBCD:= Self.ValorOutrosCreditos;
      if (Self.ValorPago >= 0) then
      FDQuery.Params.ParamByName('VALOR_PAGO').AsFMTBCD:= Self.ValorPago;
      if (Self.ValorRecebido >= 0) then
      FDQuery.Params.ParamByName('VALOR_RECEBIDO').AsFMTBCD:= Self.ValorRecebido;
      if (Self.Referencia <> EmptyStr) then
      FDQuery.Params.ParamByName('REFERENCIA').AsString:= Self.Referencia;
      if (Self.Versao <> EmptyStr) then
      FDQuery.Params.ParamByName('VERSAO').AsString:= Self.Versao;
      if (Self.SeuNumero <> EmptyStr) then
      FDQuery.Params.ParamByName('SEU_NUMERO').AsString:= Self.SeuNumero;
      if (Self.ValorRecebido >= 0) then
      FDQuery.Params.ParamByName('PERCENTUAL_MULTA').AsFMTBCD:= Self.PercentualMulta;
      FDQuery.Params.ParamByName('MULTA_VALOR_FIXO').AsString:= Self.MultaValorFixo;
      if (Self.ValorDescontoAntDia >= 0) then
      FDQuery.Params.ParamByName('VALOR_DESCONTO_ANT_DIA').AsFMTBCD:= Self.ValorDescontoAntDia;
      if (Self.TextoLivre <> EmptyStr) then
      FDQuery.Params.ParamByName('TEXTO_LIVRE').AsString:= Self.TextoLivre;
      if (Self.CodigoMora <> EmptyStr) then
      FDQuery.Params.ParamByName('CODIGO_MORA').AsString:= Self.CodigoMora;
      FDQuery.Params.ParamByName('TIPO_DIAS_PROTESTO').AsInteger:= Self.TipoDiasProtesto;
      FDQuery.Params.ParamByName('TIPO_IMPRESSAO').AsInteger:= Self.TipoImpressao;
      if (Self.LinhaDigitada <> EmptyStr) then
      FDQuery.Params.ParamByName('LINHA_DIGITADA').AsString:= Self.LinhaDigitada;
      if (Self.CodigoGeracao <> EmptyStr) then
      FDQuery.Params.ParamByName('CODIGO_GERACAO').AsString:= Self.CodigoGeracao;
      FDQuery.Params.ParamByName('CARAC_TITULO').AsInteger:= Self.CaracTitulo;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('falha ao atualizar o boleto. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
