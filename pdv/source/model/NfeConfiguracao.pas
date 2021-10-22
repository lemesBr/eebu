unit NfeConfiguracao;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TNfeConfiguracao = class(TModel)
  private
    FEMPRESA_ID: String;
    FVERSAO_DF: String;
    FATUALIZAR_XML_CANCELADO: String;
    FID_CSC: String;
    FCSC: String;
    FINCLUIR_QRCODE_XML_NFCE: String;
    FFORMA_EMISSAO_CODIGO: String;
    FGERAL_SALVAR: String;
    FEXIBIR_ERRO_SCHEMA: String;
    FRETIRAR_ACENTOS: String;
    FRETIRAR_ESPACOS: String;
    FIDENTAR_XML: String;
    FVALIDAR_DIGEST: String;
    FEMISSAO_PATH_NFE: String;
    FSALVAR_EVENTO: String;
    FSALVAR_APENAS_NFE_PROCESSADAS: String;
    FPATH_NFE: String;
    FPATH_INU: String;
    FPATH_EVENTO: String;
    FPATH_SALVAR: String;
    FPATH_SCHEMAS: String;
    FARQUIVOS_SALVAR: String;
    FADICIONAR_LITERAL: String;
    FSEPARAR_POR_CNPJ: String;
    FSEPARAR_POR_MODELO: String;
    FSEPARAR_POR_MES: String;
    FUF: String;
    FVISUALIZAR: String;
    FAMBIENTE_CODIGO: String;
    FARQUIVO_PFX: String;
    FNUMERO_SERIE: String;
    FSENHA: String;
    FVERIFICAR_VALIDADE: String;
    FPATH_PDF: String;
    FLOGO: String;
    FSERIE_NFE: Integer;
    FSERIE_NFCE: Integer;
    FSSLLIB: String;
    FAGUARDAR_CONSULTA_RET: Integer;
    FINTERVALO_TENTATIVAS: Integer;
    FTENTATIVAS: Integer;
    FAJUSTA_AGUARDA_CONSULTA_RET: String;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    function validate: Boolean;
    class function find(id: string): TNfeConfiguracao;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property VersaoDf: String  read FVERSAO_DF write FVERSAO_DF;
    property AtualizarXmlCancelado: String  read FATUALIZAR_XML_CANCELADO write FATUALIZAR_XML_CANCELADO;
    property IdCsc: String  read FID_CSC write FID_CSC;
    property Csc: String  read FCSC write FCSC;
    property IncluirQrcodeXmlNfce: String  read FINCLUIR_QRCODE_XML_NFCE write FINCLUIR_QRCODE_XML_NFCE;
    property FormaEmissaoCodigo: String  read FFORMA_EMISSAO_CODIGO write FFORMA_EMISSAO_CODIGO;
    property GeralSalvar: String  read FGERAL_SALVAR write FGERAL_SALVAR;
    property ExibirErroSchema: String  read FEXIBIR_ERRO_SCHEMA write FEXIBIR_ERRO_SCHEMA;
    property RetirarAcentos: String  read FRETIRAR_ACENTOS write FRETIRAR_ACENTOS;
    property RetirarEspacos: String  read FRETIRAR_ESPACOS write FRETIRAR_ESPACOS;
    property IdentarXml: String  read FIDENTAR_XML write FIDENTAR_XML;
    property ValidarDigest: String  read FVALIDAR_DIGEST write FVALIDAR_DIGEST;
    property EmissaoPathNfe: String  read FEMISSAO_PATH_NFE write FEMISSAO_PATH_NFE;
    property SalvarEvento: String  read FSALVAR_EVENTO write FSALVAR_EVENTO;
    property SalvarApenasNfeProcessadas: String  read FSALVAR_APENAS_NFE_PROCESSADAS write FSALVAR_APENAS_NFE_PROCESSADAS;
    property PathNfe: String  read FPATH_NFE write FPATH_NFE;
    property PathInu: String  read FPATH_INU write FPATH_INU;
    property PathEvento: String  read FPATH_EVENTO write FPATH_EVENTO;
    property PathSalvar: String  read FPATH_SALVAR write FPATH_SALVAR;
    property PathSchemas: String  read FPATH_SCHEMAS write FPATH_SCHEMAS;
    property ArquivosSalvar: String  read FARQUIVOS_SALVAR write FARQUIVOS_SALVAR;
    property AdicionarLiteral: String  read FADICIONAR_LITERAL write FADICIONAR_LITERAL;
    property SepararPorCnpj: String  read FSEPARAR_POR_CNPJ write FSEPARAR_POR_CNPJ;
    property SepararPorModelo: String  read FSEPARAR_POR_MODELO write FSEPARAR_POR_MODELO;
    property SepararPorMes: String  read FSEPARAR_POR_MES write FSEPARAR_POR_MES;
    property Uf: String  read FUF write FUF;
    property Visualizar: String  read FVISUALIZAR write FVISUALIZAR;
    property AmbienteCodigo: String  read FAMBIENTE_CODIGO write FAMBIENTE_CODIGO;
    property ArquivoPfx: String  read FARQUIVO_PFX write FARQUIVO_PFX;
    property NumeroSerie: String  read FNUMERO_SERIE write FNUMERO_SERIE;
    property Senha: String  read FSENHA write FSENHA;
    property VerificarValidade: String  read FVERIFICAR_VALIDADE write FVERIFICAR_VALIDADE;
    property PathPdf: String  read FPATH_PDF write FPATH_PDF;
    property Logo: String  read FLOGO write FLOGO;
    property SerieNfe: Integer  read FSERIE_NFE write FSERIE_NFE;
    property SerieNfce: Integer  read FSERIE_NFCE write FSERIE_NFCE;
    property Ssllib: String  read FSSLLIB write FSSLLIB;
    property AguardarConsultaRet: Integer  read FAGUARDAR_CONSULTA_RET write FAGUARDAR_CONSULTA_RET;
    property IntervaloTentativas: Integer  read FINTERVALO_TENTATIVAS write FINTERVALO_TENTATIVAS;
    property Tentativas: Integer  read FTENTATIVAS write FTENTATIVAS;
    property AjustaAguardaConsultaRet: String  read FAJUSTA_AGUARDA_CONSULTA_RET write FAJUSTA_AGUARDA_CONSULTA_RET;

  end;

implementation

uses
  AuthService, Helper;

{ TNfeConfiguracao }

constructor TNfeConfiguracao.Create;
begin
  Self.Table:= 'NFE_CONFIGURACOES';
end;

class function TNfeConfiguracao.find(id: string): TNfeConfiguracao;
const
  FSql: string = 'SELECT * FROM NFE_CONFIGURACOES WHERE (ID = :ID)';
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
        Result:= TNfeConfiguracao.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.VersaoDf:= FDQuery.FieldByName('VERSAO_DF').AsString;
        Result.AtualizarXmlCancelado:= FDQuery.FieldByName('ATUALIZAR_XML_CANCELADO').AsString;
        Result.IdCsc:= FDQuery.FieldByName('ID_CSC').AsString;
        Result.Csc:= FDQuery.FieldByName('CSC').AsString;
        Result.IncluirQrcodeXmlNfce:= FDQuery.FieldByName('INCLUIR_QRCODE_XML_NFCE').AsString;
        Result.FormaEmissaoCodigo:= FDQuery.FieldByName('FORMA_EMISSAO_CODIGO').AsString;
        Result.GeralSalvar:= FDQuery.FieldByName('GERAL_SALVAR').AsString;
        Result.ExibirErroSchema:= FDQuery.FieldByName('EXIBIR_ERRO_SCHEMA').AsString;
        Result.RetirarAcentos:= FDQuery.FieldByName('RETIRAR_ACENTOS').AsString;
        Result.RetirarEspacos:= FDQuery.FieldByName('RETIRAR_ESPACOS').AsString;
        Result.IdentarXml:= FDQuery.FieldByName('IDENTAR_XML').AsString;
        Result.ValidarDigest:= FDQuery.FieldByName('VALIDAR_DIGEST').AsString;
        Result.EmissaoPathNfe:= FDQuery.FieldByName('EMISSAO_PATH_NFE').AsString;
        Result.SalvarEvento:= FDQuery.FieldByName('SALVAR_EVENTO').AsString;
        Result.SalvarApenasNfeProcessadas:= FDQuery.FieldByName('SALVAR_APENAS_NFE_PROCESSADAS').AsString;
        Result.PathNfe:= FDQuery.FieldByName('PATH_NFE').AsString;
        Result.PathInu:= FDQuery.FieldByName('PATH_INU').AsString;
        Result.PathEvento:= FDQuery.FieldByName('PATH_EVENTO').AsString;
        Result.PathSalvar:= FDQuery.FieldByName('PATH_SALVAR').AsString;
        Result.PathSchemas:= FDQuery.FieldByName('PATH_SCHEMAS').AsString;
        Result.ArquivosSalvar:= FDQuery.FieldByName('ARQUIVOS_SALVAR').AsString;
        Result.AdicionarLiteral:= FDQuery.FieldByName('ADICIONAR_LITERAL').AsString;
        Result.SepararPorCnpj:= FDQuery.FieldByName('SEPARAR_POR_CNPJ').AsString;
        Result.SepararPorModelo:= FDQuery.FieldByName('SEPARAR_POR_MODELO').AsString;
        Result.SepararPorMes:= FDQuery.FieldByName('SEPARAR_POR_MES').AsString;
        Result.Uf:= FDQuery.FieldByName('UF').AsString;
        Result.Visualizar:= FDQuery.FieldByName('VISUALIZAR').AsString;
        Result.AmbienteCodigo:= FDQuery.FieldByName('AMBIENTE_CODIGO').AsString;
        Result.ArquivoPfx:= FDQuery.FieldByName('ARQUIVO_PFX').AsString;
        Result.NumeroSerie:= FDQuery.FieldByName('NUMERO_SERIE').AsString;
        Result.Senha:= FDQuery.FieldByName('SENHA').AsString;
        Result.VerificarValidade:= FDQuery.FieldByName('VERIFICAR_VALIDADE').AsString;
        Result.PathPdf:= FDQuery.FieldByName('PATH_PDF').AsString;
        Result.Logo:= FDQuery.FieldByName('LOGO').AsString;
        Result.SerieNfe:= FDQuery.FieldByName('SERIE_NFE').AsInteger;
        Result.SerieNfce:= FDQuery.FieldByName('SERIE_NFCE').AsInteger;
        Result.Ssllib:= FDQuery.FieldByName('SSLLIB').AsString;
        Result.AguardarConsultaRet:= FDQuery.FieldByName('AGUARDAR_CONSULTA_RET').AsInteger;
        Result.IntervaloTentativas:= FDQuery.FieldByName('INTERVALO_TENTATIVAS').AsInteger;
        Result.Tentativas:= FDQuery.FieldByName('TENTATIVAS').AsInteger;
        Result.AjustaAguardaConsultaRet:= FDQuery.FieldByName('AJUSTA_AGUARDA_CONSULTA_RET').AsString;
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

function TNfeConfiguracao.save: Boolean;
begin
  Result:= inherited;
end;

function TNfeConfiguracao.store: Boolean;
const
  FSql: string =
  'INSERT INTO NFE_CONFIGURACOES (  ' +
  '  ID,                            ' +
  '  EMPRESA_ID,                    ' +
  '  VERSAO_DF,                     ' +
  '  ATUALIZAR_XML_CANCELADO,       ' +
  '  ID_CSC,                        ' +
  '  CSC,                           ' +
  '  INCLUIR_QRCODE_XML_NFCE,       ' +
  '  FORMA_EMISSAO_CODIGO,          ' +
  '  GERAL_SALVAR,                  ' +
  '  EXIBIR_ERRO_SCHEMA,            ' +
  '  RETIRAR_ACENTOS,               ' +
  '  RETIRAR_ESPACOS,               ' +
  '  IDENTAR_XML,                   ' +
  '  VALIDAR_DIGEST,                ' +
  '  EMISSAO_PATH_NFE,              ' +
  '  SALVAR_EVENTO,                 ' +
  '  SALVAR_APENAS_NFE_PROCESSADAS, ' +
  '  PATH_NFE,                      ' +
  '  PATH_INU,                      ' +
  '  PATH_EVENTO,                   ' +
  '  PATH_SALVAR,                   ' +
  '  PATH_SCHEMAS,                  ' +
  '  ARQUIVOS_SALVAR,               ' +
  '  ADICIONAR_LITERAL,             ' +
  '  SEPARAR_POR_CNPJ,              ' +
  '  SEPARAR_POR_MODELO,            ' +
  '  SEPARAR_POR_MES,               ' +
  '  UF,                            ' +
  '  VISUALIZAR,                    ' +
  '  AMBIENTE_CODIGO,               ' +
  '  ARQUIVO_PFX,                   ' +
  '  NUMERO_SERIE,                  ' +
  '  SENHA,                         ' +
  '  VERIFICAR_VALIDADE,            ' +
  '  PATH_PDF,                      ' +
  '  LOGO,                          ' +
  '  SERIE_NFE,                     ' +
  '  SERIE_NFCE,                    ' +
  '  SSLLIB,                        ' +
  '  AGUARDAR_CONSULTA_RET,         ' +
  '  INTERVALO_TENTATIVAS,          ' +
  '  TENTATIVAS,                    ' +
  '  AJUSTA_AGUARDA_CONSULTA_RET,   ' +
  '  CREATED_AT,                    ' +
  '  UPDATED_AT)                    ' +
  'VALUES (                         ' +
  '  :ID,                           ' +
  '  :EMPRESA_ID,                   ' +
  '  :VERSAO_DF,                    ' +
  '  :ATUALIZAR_XML_CANCELADO,      ' +
  '  :ID_CSC,                       ' +
  '  :CSC,                          ' +
  '  :INCLUIR_QRCODE_XML_NFCE,      ' +
  '  :FORMA_EMISSAO_CODIGO,         ' +
  '  :GERAL_SALVAR,                 ' +
  '  :EXIBIR_ERRO_SCHEMA,           ' +
  '  :RETIRAR_ACENTOS,              ' +
  '  :RETIRAR_ESPACOS,              ' +
  '  :IDENTAR_XML,                  ' +
  '  :VALIDAR_DIGEST,               ' +
  '  :EMISSAO_PATH_NFE,             ' +
  '  :SALVAR_EVENTO,                ' +
  '  :SALVAR_APENAS_NFE_PROCESSADAS,' +
  '  :PATH_NFE,                     ' +
  '  :PATH_INU,                     ' +
  '  :PATH_EVENTO,                  ' +
  '  :PATH_SALVAR,                  ' +
  '  :PATH_SCHEMAS,                 ' +
  '  :ARQUIVOS_SALVAR,              ' +
  '  :ADICIONAR_LITERAL,            ' +
  '  :SEPARAR_POR_CNPJ,             ' +
  '  :SEPARAR_POR_MODELO,           ' +
  '  :SEPARAR_POR_MES,              ' +
  '  :UF,                           ' +
  '  :VISUALIZAR,                   ' +
  '  :AMBIENTE_CODIGO,              ' +
  '  :ARQUIVO_PFX,                  ' +
  '  :NUMERO_SERIE,                 ' +
  '  :SENHA,                        ' +
  '  :VERIFICAR_VALIDADE,           ' +
  '  :PATH_PDF,                     ' +
  '  :LOGO,                         ' +
  '  :SERIE_NFE,                    ' +
  '  :SERIE_NFCE,                   ' +
  '  :SSLLIB,                       ' +
  '  :AGUARDAR_CONSULTA_RET,        ' +
  '  :INTERVALO_TENTATIVAS,         ' +
  '  :TENTATIVAS,                   ' +
  '  :AJUSTA_AGUARDA_CONSULTA_RET,  ' +
  '  :CREATED_AT,                   ' +
  '  :UPDATED_AT)                   ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= TModel.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('VERSAO_DF').DataType:= ftString;
      FDQuery.Params.ParamByName('ATUALIZAR_XML_CANCELADO').DataType:= ftString;
      FDQuery.Params.ParamByName('ID_CSC').DataType:= ftString;
      FDQuery.Params.ParamByName('CSC').DataType:= ftString;
      FDQuery.Params.ParamByName('INCLUIR_QRCODE_XML_NFCE').DataType:= ftString;
      FDQuery.Params.ParamByName('FORMA_EMISSAO_CODIGO').DataType:= ftString;
      FDQuery.Params.ParamByName('GERAL_SALVAR').DataType:= ftString;
      FDQuery.Params.ParamByName('EXIBIR_ERRO_SCHEMA').DataType:= ftString;
      FDQuery.Params.ParamByName('RETIRAR_ACENTOS').DataType:= ftString;
      FDQuery.Params.ParamByName('RETIRAR_ESPACOS').DataType:= ftString;
      FDQuery.Params.ParamByName('IDENTAR_XML').DataType:= ftString;
      FDQuery.Params.ParamByName('VALIDAR_DIGEST').DataType:= ftString;
      FDQuery.Params.ParamByName('EMISSAO_PATH_NFE').DataType:= ftString;
      FDQuery.Params.ParamByName('SALVAR_EVENTO').DataType:= ftString;
      FDQuery.Params.ParamByName('SALVAR_APENAS_NFE_PROCESSADAS').DataType:= ftString;
      FDQuery.Params.ParamByName('PATH_NFE').DataType:= ftString;
      FDQuery.Params.ParamByName('PATH_INU').DataType:= ftString;
      FDQuery.Params.ParamByName('PATH_EVENTO').DataType:= ftString;
      FDQuery.Params.ParamByName('PATH_SALVAR').DataType:= ftString;
      FDQuery.Params.ParamByName('PATH_SCHEMAS').DataType:= ftString;
      FDQuery.Params.ParamByName('ARQUIVOS_SALVAR').DataType:= ftString;
      FDQuery.Params.ParamByName('ADICIONAR_LITERAL').DataType:= ftString;
      FDQuery.Params.ParamByName('SEPARAR_POR_CNPJ').DataType:= ftString;
      FDQuery.Params.ParamByName('SEPARAR_POR_MODELO').DataType:= ftString;
      FDQuery.Params.ParamByName('SEPARAR_POR_MES').DataType:= ftString;
      FDQuery.Params.ParamByName('UF').DataType:= ftString;
      FDQuery.Params.ParamByName('VISUALIZAR').DataType:= ftString;
      FDQuery.Params.ParamByName('AMBIENTE_CODIGO').DataType:= ftString;
      FDQuery.Params.ParamByName('ARQUIVO_PFX').DataType:= ftString;
      FDQuery.Params.ParamByName('NUMERO_SERIE').DataType:= ftString;
      FDQuery.Params.ParamByName('SENHA').DataType:= ftString;
      FDQuery.Params.ParamByName('VERIFICAR_VALIDADE').DataType:= ftString;
      FDQuery.Params.ParamByName('PATH_PDF').DataType:= ftString;
      FDQuery.Params.ParamByName('LOGO').DataType:= ftString;
      FDQuery.Params.ParamByName('SERIE_NFE').DataType:= ftInteger;
      FDQuery.Params.ParamByName('SERIE_NFCE').DataType:= ftInteger;
      FDQuery.Params.ParamByName('SSLLIB').DataType:= ftString;
      FDQuery.Params.ParamByName('AGUARDAR_CONSULTA_RET').DataType:= ftInteger;
      FDQuery.Params.ParamByName('INTERVALO_TENTATIVAS').DataType:= ftInteger;
      FDQuery.Params.ParamByName('TENTATIVAS').DataType:= ftInteger;
      FDQuery.Params.ParamByName('AJUSTA_AGUARDA_CONSULTA_RET').DataType:= ftString;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.Terminal.EmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('VERSAO_DF').AsString:= Self.VersaoDf;
      FDQuery.Params.ParamByName('ATUALIZAR_XML_CANCELADO').AsString:= Self.AtualizarXmlCancelado;
      if (Self.IdCsc <> EmptyStr) then
        FDQuery.Params.ParamByName('ID_CSC').AsString:= Self.IdCsc;
      if (Self.Csc <> EmptyStr) then
        FDQuery.Params.ParamByName('CSC').AsString:= Self.Csc;
      FDQuery.Params.ParamByName('INCLUIR_QRCODE_XML_NFCE').AsString:= Self.IncluirQrcodeXmlNfce;
      FDQuery.Params.ParamByName('FORMA_EMISSAO_CODIGO').AsString:= Self.FormaEmissaoCodigo;
      FDQuery.Params.ParamByName('GERAL_SALVAR').AsString:= Self.GeralSalvar;
      FDQuery.Params.ParamByName('EXIBIR_ERRO_SCHEMA').AsString:= Self.ExibirErroSchema;
      FDQuery.Params.ParamByName('RETIRAR_ACENTOS').AsString:= Self.RetirarAcentos;
      FDQuery.Params.ParamByName('RETIRAR_ESPACOS').AsString:= Self.RetirarEspacos;
      FDQuery.Params.ParamByName('IDENTAR_XML').AsString:= Self.IdentarXml;
      FDQuery.Params.ParamByName('VALIDAR_DIGEST').AsString:= Self.ValidarDigest;
      FDQuery.Params.ParamByName('EMISSAO_PATH_NFE').AsString:= Self.EmissaoPathNfe;
      FDQuery.Params.ParamByName('SALVAR_EVENTO').AsString:= Self.SalvarEvento;
      FDQuery.Params.ParamByName('SALVAR_APENAS_NFE_PROCESSADAS').AsString:= Self.SalvarApenasNfeProcessadas;
      if (Self.PathNfe <> EmptyStr) then
        FDQuery.Params.ParamByName('PATH_NFE').AsString:= Self.PathNfe;
      if (Self.PathInu <> EmptyStr) then
        FDQuery.Params.ParamByName('PATH_INU').AsString:= Self.PathInu;
      if (Self.PathEvento <> EmptyStr) then
        FDQuery.Params.ParamByName('PATH_EVENTO').AsString:= Self.PathEvento;
      if (Self.PathSalvar <> EmptyStr) then
        FDQuery.Params.ParamByName('PATH_SALVAR').AsString:= Self.PathSalvar;
      if (Self.PathSchemas <> EmptyStr) then
      FDQuery.Params.ParamByName('PATH_SCHEMAS').AsString:= Self.PathSchemas;
      FDQuery.Params.ParamByName('ARQUIVOS_SALVAR').AsString:= Self.ArquivosSalvar;
      FDQuery.Params.ParamByName('ADICIONAR_LITERAL').AsString:= Self.AdicionarLiteral;
      FDQuery.Params.ParamByName('SEPARAR_POR_CNPJ').AsString:= Self.SepararPorCnpj;
      FDQuery.Params.ParamByName('SEPARAR_POR_MODELO').AsString:= Self.SepararPorModelo;
      FDQuery.Params.ParamByName('SEPARAR_POR_MES').AsString:= Self.SepararPorMes;
      if (Self.Uf <> EmptyStr) then
        FDQuery.Params.ParamByName('UF').AsString:= Self.Uf;
      FDQuery.Params.ParamByName('VISUALIZAR').AsString:= Self.Visualizar;
      FDQuery.Params.ParamByName('AMBIENTE_CODIGO').AsString:= Self.AmbienteCodigo;
      if (Self.ArquivoPfx <> EmptyStr) then
        FDQuery.Params.ParamByName('ARQUIVO_PFX').AsString:= Self.ArquivoPfx;
      if (Self.NumeroSerie <> EmptyStr) then
        FDQuery.Params.ParamByName('NUMERO_SERIE').AsString:= Self.NumeroSerie;
      if (Self.Senha <> EmptyStr) then
        FDQuery.Params.ParamByName('SENHA').AsString:= Self.Senha;
      FDQuery.Params.ParamByName('VERIFICAR_VALIDADE').AsString:= Self.VerificarValidade;
      if (Self.PathPdf <> EmptyStr) then
        FDQuery.Params.ParamByName('PATH_PDF').AsString:= Self.PathPdf;
      if (Self.Logo <> EmptyStr) then
        FDQuery.Params.ParamByName('LOGO').AsString:= Self.Logo;
      if (Self.SerieNfe >= 1) then
        FDQuery.Params.ParamByName('SERIE_NFE').AsInteger:= Self.SerieNfe;
      if (Self.SerieNfce >= 1) then
        FDQuery.Params.ParamByName('SERIE_NFCE').AsInteger:= Self.SerieNfce;
      FDQuery.Params.ParamByName('SSLLIB').AsString:= Self.Ssllib;
      FDQuery.Params.ParamByName('AGUARDAR_CONSULTA_RET').AsInteger:= Self.AguardarConsultaRet;
      FDQuery.Params.ParamByName('INTERVALO_TENTATIVAS').AsInteger:= Self.IntervaloTentativas;
      FDQuery.Params.ParamByName('TENTATIVAS').AsInteger:= Self.Tentativas;
      FDQuery.Params.ParamByName('AJUSTA_AGUARDA_CONSULTA_RET').AsString:= Self.AjustaAguardaConsultaRet;
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

function TNfeConfiguracao.update: Boolean;
const
  FSql: string =
  'UPDATE NFE_CONFIGURACOES                                           ' +
  'SET VERSAO_DF = :VERSAO_DF,                                        ' +
  '    ATUALIZAR_XML_CANCELADO = :ATUALIZAR_XML_CANCELADO,            ' +
  '    ID_CSC = :ID_CSC,                                              ' +
  '    CSC = :CSC,                                                    ' +
  '    INCLUIR_QRCODE_XML_NFCE = :INCLUIR_QRCODE_XML_NFCE,            ' +
  '    FORMA_EMISSAO_CODIGO = :FORMA_EMISSAO_CODIGO,                  ' +
  '    GERAL_SALVAR = :GERAL_SALVAR,                                  ' +
  '    EXIBIR_ERRO_SCHEMA = :EXIBIR_ERRO_SCHEMA,                      ' +
  '    RETIRAR_ACENTOS = :RETIRAR_ACENTOS,                            ' +
  '    RETIRAR_ESPACOS = :RETIRAR_ESPACOS,                            ' +
  '    IDENTAR_XML = :IDENTAR_XML,                                    ' +
  '    VALIDAR_DIGEST = :VALIDAR_DIGEST,                              ' +
  '    EMISSAO_PATH_NFE = :EMISSAO_PATH_NFE,                          ' +
  '    SALVAR_EVENTO = :SALVAR_EVENTO,                                ' +
  '    SALVAR_APENAS_NFE_PROCESSADAS = :SALVAR_APENAS_NFE_PROCESSADAS,' +
  '    PATH_NFE = :PATH_NFE,                                          ' +
  '    PATH_INU = :PATH_INU,                                          ' +
  '    PATH_EVENTO = :PATH_EVENTO,                                    ' +
  '    PATH_SALVAR = :PATH_SALVAR,                                    ' +
  '    PATH_SCHEMAS = :PATH_SCHEMAS,                                  ' +
  '    ARQUIVOS_SALVAR = :ARQUIVOS_SALVAR,                            ' +
  '    ADICIONAR_LITERAL = :ADICIONAR_LITERAL,                        ' +
  '    SEPARAR_POR_CNPJ = :SEPARAR_POR_CNPJ,                          ' +
  '    SEPARAR_POR_MODELO = :SEPARAR_POR_MODELO,                      ' +
  '    SEPARAR_POR_MES = :SEPARAR_POR_MES,                            ' +
  '    UF = :UF,                                                      ' +
  '    VISUALIZAR = :VISUALIZAR,                                      ' +
  '    AMBIENTE_CODIGO = :AMBIENTE_CODIGO,                            ' +
  '    ARQUIVO_PFX = :ARQUIVO_PFX,                                    ' +
  '    NUMERO_SERIE = :NUMERO_SERIE,                                  ' +
  '    SENHA = :SENHA,                                                ' +
  '    VERIFICAR_VALIDADE = :VERIFICAR_VALIDADE,                      ' +
  '    PATH_PDF = :PATH_PDF,                                          ' +
  '    LOGO = :LOGO,                                                  ' +
  '    SERIE_NFE = :SERIE_NFE,                                        ' +
  '    SERIE_NFCE = :SERIE_NFCE,                                      ' +
  '    SSLLIB = :SSLLIB,                                              ' +
  '    AGUARDAR_CONSULTA_RET = :AGUARDAR_CONSULTA_RET,                ' +
  '    INTERVALO_TENTATIVAS = :INTERVALO_TENTATIVAS,                  ' +
  '    TENTATIVAS = :TENTATIVAS,                                      ' +
  '    AJUSTA_AGUARDA_CONSULTA_RET = :AJUSTA_AGUARDA_CONSULTA_RET,    ' +
  '    UPDATED_AT = :UPDATED_AT,                                      ' +
  '    SYNCHRONIZED = :SYNCHRONIZED                                   ' +
  'WHERE (ID = :ID)                                                   ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= TModel.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('VERSAO_DF').DataType:= ftString;
      FDQuery.Params.ParamByName('ATUALIZAR_XML_CANCELADO').DataType:= ftString;
      FDQuery.Params.ParamByName('ID_CSC').DataType:= ftString;
      FDQuery.Params.ParamByName('CSC').DataType:= ftString;
      FDQuery.Params.ParamByName('INCLUIR_QRCODE_XML_NFCE').DataType:= ftString;
      FDQuery.Params.ParamByName('FORMA_EMISSAO_CODIGO').DataType:= ftString;
      FDQuery.Params.ParamByName('GERAL_SALVAR').DataType:= ftString;
      FDQuery.Params.ParamByName('EXIBIR_ERRO_SCHEMA').DataType:= ftString;
      FDQuery.Params.ParamByName('RETIRAR_ACENTOS').DataType:= ftString;
      FDQuery.Params.ParamByName('RETIRAR_ESPACOS').DataType:= ftString;
      FDQuery.Params.ParamByName('IDENTAR_XML').DataType:= ftString;
      FDQuery.Params.ParamByName('VALIDAR_DIGEST').DataType:= ftString;
      FDQuery.Params.ParamByName('EMISSAO_PATH_NFE').DataType:= ftString;
      FDQuery.Params.ParamByName('SALVAR_EVENTO').DataType:= ftString;
      FDQuery.Params.ParamByName('SALVAR_APENAS_NFE_PROCESSADAS').DataType:= ftString;
      FDQuery.Params.ParamByName('PATH_NFE').DataType:= ftString;
      FDQuery.Params.ParamByName('PATH_INU').DataType:= ftString;
      FDQuery.Params.ParamByName('PATH_EVENTO').DataType:= ftString;
      FDQuery.Params.ParamByName('PATH_SALVAR').DataType:= ftString;
      FDQuery.Params.ParamByName('PATH_SCHEMAS').DataType:= ftString;
      FDQuery.Params.ParamByName('ARQUIVOS_SALVAR').DataType:= ftString;
      FDQuery.Params.ParamByName('ADICIONAR_LITERAL').DataType:= ftString;
      FDQuery.Params.ParamByName('SEPARAR_POR_CNPJ').DataType:= ftString;
      FDQuery.Params.ParamByName('SEPARAR_POR_MODELO').DataType:= ftString;
      FDQuery.Params.ParamByName('SEPARAR_POR_MES').DataType:= ftString;
      FDQuery.Params.ParamByName('UF').DataType:= ftString;
      FDQuery.Params.ParamByName('VISUALIZAR').DataType:= ftString;
      FDQuery.Params.ParamByName('AMBIENTE_CODIGO').DataType:= ftString;
      FDQuery.Params.ParamByName('ARQUIVO_PFX').DataType:= ftString;
      FDQuery.Params.ParamByName('NUMERO_SERIE').DataType:= ftString;
      FDQuery.Params.ParamByName('SENHA').DataType:= ftString;
      FDQuery.Params.ParamByName('VERIFICAR_VALIDADE').DataType:= ftString;
      FDQuery.Params.ParamByName('PATH_PDF').DataType:= ftString;
      FDQuery.Params.ParamByName('LOGO').DataType:= ftString;
      FDQuery.Params.ParamByName('SERIE_NFE').DataType:= ftInteger;
      FDQuery.Params.ParamByName('SERIE_NFCE').DataType:= ftInteger;
      FDQuery.Params.ParamByName('SSLLIB').DataType:= ftString;
      FDQuery.Params.ParamByName('AGUARDAR_CONSULTA_RET').DataType:= ftInteger;
      FDQuery.Params.ParamByName('INTERVALO_TENTATIVAS').DataType:= ftInteger;
      FDQuery.Params.ParamByName('TENTATIVAS').DataType:= ftInteger;
      FDQuery.Params.ParamByName('AJUSTA_AGUARDA_CONSULTA_RET').DataType:= ftString;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftString;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('VERSAO_DF').AsString:= Self.VersaoDf;
      FDQuery.Params.ParamByName('ATUALIZAR_XML_CANCELADO').AsString:= Self.AtualizarXmlCancelado;
      if (Self.IdCsc <> EmptyStr) then
        FDQuery.Params.ParamByName('ID_CSC').AsString:= Self.IdCsc;
      if (Self.Csc <> EmptyStr) then
        FDQuery.Params.ParamByName('CSC').AsString:= Self.Csc;
      FDQuery.Params.ParamByName('INCLUIR_QRCODE_XML_NFCE').AsString:= Self.IncluirQrcodeXmlNfce;
      FDQuery.Params.ParamByName('FORMA_EMISSAO_CODIGO').AsString:= Self.FormaEmissaoCodigo;
      FDQuery.Params.ParamByName('GERAL_SALVAR').AsString:= Self.GeralSalvar;
      FDQuery.Params.ParamByName('EXIBIR_ERRO_SCHEMA').AsString:= Self.ExibirErroSchema;
      FDQuery.Params.ParamByName('RETIRAR_ACENTOS').AsString:= Self.RetirarAcentos;
      FDQuery.Params.ParamByName('RETIRAR_ESPACOS').AsString:= Self.RetirarEspacos;
      FDQuery.Params.ParamByName('IDENTAR_XML').AsString:= Self.IdentarXml;
      FDQuery.Params.ParamByName('VALIDAR_DIGEST').AsString:= Self.ValidarDigest;
      FDQuery.Params.ParamByName('EMISSAO_PATH_NFE').AsString:= Self.EmissaoPathNfe;
      FDQuery.Params.ParamByName('SALVAR_EVENTO').AsString:= Self.SalvarEvento;
      FDQuery.Params.ParamByName('SALVAR_APENAS_NFE_PROCESSADAS').AsString:= Self.SalvarApenasNfeProcessadas;
      if (Self.PathNfe <> EmptyStr) then
        FDQuery.Params.ParamByName('PATH_NFE').AsString:= Self.PathNfe;
      if (Self.PathInu <> EmptyStr) then
        FDQuery.Params.ParamByName('PATH_INU').AsString:= Self.PathInu;
      if (Self.PathEvento <> EmptyStr) then
        FDQuery.Params.ParamByName('PATH_EVENTO').AsString:= Self.PathEvento;
      if (Self.PathSalvar <> EmptyStr) then
        FDQuery.Params.ParamByName('PATH_SALVAR').AsString:= Self.PathSalvar;
      if (Self.PathSchemas <> EmptyStr) then
      FDQuery.Params.ParamByName('PATH_SCHEMAS').AsString:= Self.PathSchemas;
      FDQuery.Params.ParamByName('ARQUIVOS_SALVAR').AsString:= Self.ArquivosSalvar;
      FDQuery.Params.ParamByName('ADICIONAR_LITERAL').AsString:= Self.AdicionarLiteral;
      FDQuery.Params.ParamByName('SEPARAR_POR_CNPJ').AsString:= Self.SepararPorCnpj;
      FDQuery.Params.ParamByName('SEPARAR_POR_MODELO').AsString:= Self.SepararPorModelo;
      FDQuery.Params.ParamByName('SEPARAR_POR_MES').AsString:= Self.SepararPorMes;
      if (Self.Uf <> EmptyStr) then
        FDQuery.Params.ParamByName('UF').AsString:= Self.Uf;
      FDQuery.Params.ParamByName('VISUALIZAR').AsString:= Self.Visualizar;
      FDQuery.Params.ParamByName('AMBIENTE_CODIGO').AsString:= Self.AmbienteCodigo;
      if (Self.ArquivoPfx <> EmptyStr) then
        FDQuery.Params.ParamByName('ARQUIVO_PFX').AsString:= Self.ArquivoPfx;
      if (Self.NumeroSerie <> EmptyStr) then
        FDQuery.Params.ParamByName('NUMERO_SERIE').AsString:= Self.NumeroSerie;
      if (Self.Senha <> EmptyStr) then
        FDQuery.Params.ParamByName('SENHA').AsString:= Self.Senha;
      FDQuery.Params.ParamByName('VERIFICAR_VALIDADE').AsString:= Self.VerificarValidade;
      if (Self.PathPdf <> EmptyStr) then
        FDQuery.Params.ParamByName('PATH_PDF').AsString:= Self.PathPdf;
      if (Self.Logo <> EmptyStr) then
        FDQuery.Params.ParamByName('LOGO').AsString:= Self.Logo;
      if (Self.SerieNfe >= 1) then
        FDQuery.Params.ParamByName('SERIE_NFE').AsInteger:= Self.SerieNfe;
      if (Self.SerieNfce >= 1) then
        FDQuery.Params.ParamByName('SERIE_NFCE').AsInteger:= Self.SerieNfce;
      FDQuery.Params.ParamByName('SSLLIB').AsString:= Self.Ssllib;
      FDQuery.Params.ParamByName('AGUARDAR_CONSULTA_RET').AsInteger:= Self.AguardarConsultaRet;
      FDQuery.Params.ParamByName('INTERVALO_TENTATIVAS').AsInteger:= Self.IntervaloTentativas;
      FDQuery.Params.ParamByName('TENTATIVAS').AsInteger:= Self.Tentativas;
      FDQuery.Params.ParamByName('AJUSTA_AGUARDA_CONSULTA_RET').AsString:= Self.AjustaAguardaConsultaRet;
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

function TNfeConfiguracao.validate: Boolean;
begin
  Result:= True;
end;

end.
