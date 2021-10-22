unit Nfe;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  Pessoa, NfeDet, NfeTotalIcms, Empresa, ACBrBase, ACBrDFe, ACBrNFe,
  ACBrNFeDANFEClass, ACBrNFeDANFeRLClass, ACBrDANFCeFortesFr, pcnConversao,
  pcnConversaoNFe, System.StrUtils, SHDocVw, Vcl.Forms, ACBrUtil, NfePag,
  ACBrDFeSSL, System.Math, System.DateUtils,Vcl.Dialogs, Vcl.FileCtrl,
  ACBrMail, ACBrValidador, ACBrNFeDANFeESCPOS, ACBrPosPrinter;

type
  TNfe = class(TModel)
  private
    FEMPRESA_ID: String;
    FPARTICIPANTE_ID: String;
    FOPERACAO_FISCAL_ID: String;
    FNFE_INFCPL_ID: String;
    FNFE_INFADFISCO_ID: String;
    FMOVIMENTO_ID: String;
    FCUF: String;
    FCNF: String;
    FNATOP: String;
    FINDPAG: String;
    FMODELO: String;
    FSERIE: Integer;
    FNNF: Integer;
    FDEMI: TDateTime;
    FDSAIENT: TDateTime;
    FTPNF: String;
    FTPNF_WT: Integer;
    FIDDEST: String;
    FCMUNFG: String;
    FTPIMP: String;
    FTPEMIS: String;
    FCDV: Integer;
    FTPAMB: String;
    FFINNFE: String;
    FINDFINAL: String;
    FINDPRES: String;
    FPROCEMI: String;
    FDHCONT: TDateTime;
    FXJUST: String;
    FQRCODE: String;
    FCHNFE: String;
    FNPROT: String;
    FCSTAT: Integer;
    FNSEQEVENTO: Integer;
    FNSU: Integer;
    FNFERECEBIDA: Integer;
    FNUNLOTE: String;
    FAUTO_CALCULO: String;

    FEMPRESA: TEmpresa;
    FPARTICIPANTE: TPessoa;
    FDET: TObjectList<TNfeDet>;
    FICMSTOT: TNfeTotalIcms;
    FPAG: TObjectList<TNfePag>;

    function getEmpresa: TEmpresa;
    function getParticipante: TPessoa;
    function getDet: TObjectList<TNfeDet>;
    function getICMSTot: TNfeTotalIcms;
    function getPag: TObjectList<TNfePag>;

    function getNfeNumero(): Integer;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    procedure processaCalculos();
    procedure enviar(pPrint: Integer = 0);
    procedure atualizaNumeroDoLote();
    function vendaId(): string;
    class function find(id: string): TNfe;
    class function findByChnfe(Chnfe: string): TNfe;
    class function findByMovimento(MovimentoId: string): TObjectList<TNfe>;
    class function list(pSearch: string): TObjectList<TNfe>; overload;
    class procedure list(pSearch: string; pDt: TFDMemTable); overload;
    class procedure gravarXML(NfeId, XML: string);
    class procedure imprimir(NfeId: string; vtype: Integer = 1);
    class procedure cancelar(NfeId: string);
    class procedure inutilizar(NfeId: string);
    class procedure corrigir(NfeId: string);
    class procedure atualizar(NfeId: string);
    class procedure configurar(Nfe: TACBrNFe);
    class function vendaToNFCe(VendaId: string): string;
    class procedure loadxml(RetWS: String; MyWebBrowser: TWebBrowser);
    class function consultaXML(NfeId: string): string;
    class procedure exportarXML(NfeId, Path: string);
    class procedure enviarEmail(NfeId: string);

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property ParticipanteId: String  read FPARTICIPANTE_ID write FPARTICIPANTE_ID;
    property OperacaoFiscalId: String  read FOPERACAO_FISCAL_ID write FOPERACAO_FISCAL_ID;
    property NfeInfcplId: String read FNFE_INFCPL_ID write FNFE_INFCPL_ID;
    property NfeInfadfiscoId: String read FNFE_INFADFISCO_ID write FNFE_INFADFISCO_ID;
    property MovimentoId: String  read FMOVIMENTO_ID write FMOVIMENTO_ID;
    property Cuf: String  read FCUF write FCUF;
    property Cnf: String  read FCNF write FCNF;
    property Natop: String  read FNATOP write FNATOP;
    property Indpag: String  read FINDPAG write FINDPAG;
    property Modelo: String  read FMODELO write FMODELO;
    property Serie: Integer  read FSERIE write FSERIE;
    property Nnf: Integer  read FNNF write FNNF;
    property Demi: TDateTime  read FDEMI write FDEMI;
    property Dsaient: TDateTime  read FDSAIENT write FDSAIENT;
    property Tpnf: String  read FTPNF write FTPNF;
    property TpnfWt: Integer  read FTPNF_WT write FTPNF_WT;
    property Iddest: String  read FIDDEST write FIDDEST;
    property Cmunfg: String  read FCMUNFG write FCMUNFG;
    property Tpimp: String  read FTPIMP write FTPIMP;
    property Tpemis: String  read FTPEMIS write FTPEMIS;
    property Cdv: Integer  read FCDV write FCDV;
    property Tpamb: String  read FTPAMB write FTPAMB;
    property Finnfe: String  read FFINNFE write FFINNFE;
    property Indfinal: String  read FINDFINAL write FINDFINAL;
    property Indpres: String  read FINDPRES write FINDPRES;
    property Procemi: String  read FPROCEMI write FPROCEMI;
    property Dhcont: TDateTime  read FDHCONT write FDHCONT;
    property Xjust: String  read FXJUST write FXJUST;
    property Qrcode: String  read FQRCODE write FQRCODE;
    property Chnfe: String  read FCHNFE write FCHNFE;
    property Nprot: String  read FNPROT write FNPROT;
    property Cstat: Integer  read FCSTAT write FCSTAT;
    property Nseqevento: Integer read FNSEQEVENTO write FNSEQEVENTO;
    property Nsu: Integer read FNSU write FNSU;
    property Nferecebida: Integer  read FNFERECEBIDA write FNFERECEBIDA;
    property Nunlote: String read FNUNLOTE write FNUNLOTE;
    property AutoCalculo: String  read FAUTO_CALCULO write FAUTO_CALCULO;

    property Empresa: TEmpresa read getEmpresa;
    property Participante: TPessoa read getParticipante;
    property Det: TObjectList<TNfeDet> read getDet;
    property ICMSTot: TNfeTotalIcms read getICMSTot;
    property Pag: TObjectList<TNfePag> read getPag;

  end;

implementation

uses
  AuthService, Venda, Helper, Ncm, VendaItem, VendaRecebimento;

{ TNfe }

class procedure TNfe.cancelar(NfeId: string);
const
  FSql: string = 'SELECT XML FROM NFES WHERE ID = :ID';
  FUPDATESql: string =
  'UPDATE NFES SET            ' +
  'XML = :XML,                ' +
  'CSTAT = :CSTAT             ' +
  'WHERE ID = :ID             ';
var
  FDQuery: TFDQuery;
  vACBrNF: TACBrNFe;
  vNunlote: Integer;
  vCstatus: Integer;
begin
  try
    vACBrNF:= TACBrNfe.Create(nil);
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ID').AsString:= NfeId;
      FDQuery.Open;
      if (FDQuery.RecordCount = 0) then Exit()
      else
      begin
        TNfe.configurar(vACBrNF);

        vACBrNF.NotasFiscais.LoadFromString(FDQuery.FieldByName('XML').AsString);

        if vACBrNF.Consultar() then
        begin
          vCstatus:= vACBrNF.NotasFiscais.Items[0].NFe.procNFe.cStat;
          if THelper.ValueIn(vCstatus, [101, 151]) then
          begin
            FDQuery.Close;
            FDQuery.SQL.Clear;
            FDQuery.SQL.Add(FUPDATESql);
            FDQuery.Params.ParamByName('XML').DataType:= ftString;
            FDQuery.Params.ParamByName('CSTAT').DataType:= ftInteger;
            FDQuery.Params.ParamByName('ID').DataType:= ftString;
            FDQuery.Prepare;
            FDQuery.Params.ParamByName('XML').AsString:=
              vACBrNF.NotasFiscais.Items[0].XML;
            FDQuery.Params.ParamByName('CSTAT').AsInteger:= vCstatus;
            FDQuery.Params.ParamByName('ID').AsString:= NfeId;
            FDQuery.ExecSQL();

            FDQuery.SQL.Clear;
            FDQuery.SQL.Add('DELETE FROM NFE_VENDAS WHERE NFE_ID = :NFE_ID');
            FDQuery.Params.ParamByName('NFE_ID').DataType:= ftString;
            FDQuery.Prepare;
            FDQuery.Params.ParamByName('NFE_ID').AsString:= NfeId;
            FDQuery.ExecSQL();

            THelper.Mensagem('Cancelamento efetuado com sucesso.');
            Exit();
          end;
        end;

        vNunlote:= StrToIntDef(FormatDateTime('yymmddhhmm', NOW), 1);
        with vACBrNF.EventoNFe.Evento.Add() do
        begin
          infEvento.dhEvento:= Now;
          infEvento.tpEvento:= teCancelamento;
          infEvento.detEvento.xJust:= TAuthService.Description;
        end;

        if vACBrNF.EnviarEvento(vNunlote) then
        begin
          with vACBrNF.WebServices do
          begin
            if (EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat <> 135) then
            begin
              raise Exception.CreateFmt(
                'Ocorreu o seguinte erro ao cancelar a nota fiscal eletrônica: ' +
                ' Código: %d' +
                ' Motivo: %s', [
                  EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat,
                  EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo
              ]);
            end
            else
            begin
              if vACBrNF.Consultar() then
              begin
                vCstatus:= vACBrNF.NotasFiscais.Items[0].NFe.procNFe.cStat;
                if THelper.ValueIn(vCstatus, [101, 151]) then
                begin
                  FDQuery.Close;
                  FDQuery.SQL.Clear;
                  FDQuery.SQL.Add(FUPDATESql);
                  FDQuery.Params.ParamByName('XML').DataType:= ftString;
                  FDQuery.Params.ParamByName('CSTAT').DataType:= ftInteger;
                  FDQuery.Params.ParamByName('ID').DataType:= ftString;
                  FDQuery.Prepare;
                  FDQuery.Params.ParamByName('XML').AsString:=
                    vACBrNF.NotasFiscais.Items[0].XML;
                  FDQuery.Params.ParamByName('CSTAT').AsInteger:= vCstatus;
                  FDQuery.Params.ParamByName('ID').AsString:= NfeId;
                  FDQuery.ExecSQL();

                  FDQuery.SQL.Clear;
                  FDQuery.SQL.Add('DELETE FROM NFE_VENDAS WHERE NFE_ID = :NFE_ID');
                  FDQuery.Params.ParamByName('NFE_ID').DataType:= ftString;
                  FDQuery.Prepare;
                  FDQuery.Params.ParamByName('NFE_ID').AsString:= NfeId;
                  FDQuery.ExecSQL();

                  THelper.Mensagem('Cancelamento efetuado com sucesso.');
                end;
              end;
            end;
          end;
        end
        else
        begin
          with vACBrNF.WebServices.EnvEvento do
          begin
            raise Exception.Create(
              'Ocorreram erros ao tentar efetuar o cancelamento: ' +
              ' Lote: ' + IntToStr(EventoRetorno.idLote) +
              ' Ambiente: ' + TpAmbToStr(EventoRetorno.tpAmb) +
              ' Orgao: ' + IntToStr(EventoRetorno.cOrgao) +
              ' Status: ' + IntToStr(EventoRetorno.cStat) +
              ' Motivo: ' + EventoRetorno.xMotivo
            );
          end;
        end;
      end;
    except on e: Exception do
      raise Exception.Create(e.Message);
    end;
  finally
    FreeAndNil(vACBrNF);
    FreeAndNil(FDQuery);
  end;
end;

class procedure TNfe.corrigir(NfeId: string);
const
  FSql: string =
  'UPDATE NFES SET          ' +
  'XML_CORRECAO = :XML,     ' +
  'NSEQEVENTO = :NSEQEVENTO ' +
  'WHERE ID = :ID           ';
var
  FDQuery: TFDQuery;
  vNfe: TNfe;
  vACBrNFe: TACBrNFe;
  vNunlote: Integer;
begin
  try
    FDQuery:= Self.createQuery;
    vACBrNFe:= TACBrNFe.Create(nil);
    try
      vNfe:= TNfe.find(NfeId);
      if not Assigned(vNfe) then
        raise Exception.Create('Falha ao consultar os dados da nota fiscal.');

      Self.configurar(vACBrNFe);
      vNunlote:= StrToIntDef(FormatDateTime('yymmddhhmm', NOW), 1);

      with vACBrNFe.EventoNFe.Evento.Add() do
      begin
        infEvento.CNPJ:= vNfe.Empresa.Documento;
        infEvento.dhEvento:= Now;
        infEvento.tpEvento:= teCCe;
        infEvento.chNFe:= vNfe.Chnfe;
        infEvento.nSeqEvento:= (vNfe.Nseqevento + 1);
        infEvento.detEvento.xCorrecao:= TAuthService.Description;
      end;

      if vACBrNFe.EnviarEvento(vNunlote) then
      begin
        with vACBrNFe.WebServices do
        begin
          if (EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat <> 135) then
          begin
            raise Exception.CreateFmt(
              'Ocorreu o seguinte erro enviar a correção da nota fiscal eletrônica: ' +
              ' Código: %d' +
              ' Motivo: %s', [
                EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat,
                EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo
            ]);
          end
          else
          begin
            FDQuery.SQL.Add(FSql);
            FDQuery.Params.ParamByName('XML').DataType:= ftString;
            FDQuery.Params.ParamByName('NSEQEVENTO').DataType:= ftInteger;
            FDQuery.Params.ParamByName('ID').DataType:= ftString;
            FDQuery.Prepare;
            FDQuery.Params.ParamByName('XML').AsString:=
              EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.XML;
            FDQuery.Params.ParamByName('NSEQEVENTO').AsInteger:=
              EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nSeqEvento;
            FDQuery.Params.ParamByName('ID').AsString:= NfeId;
            FDQuery.ExecSQL();

            TNfe.imprimir(NfeId, 1);
          end;
        end;
      end
      else
      begin
        with vACBrNFe.WebServices.EnvEvento do
        begin
          raise Exception.Create(
            'Ocorreram erros ao tentar efetuar a Carta de Correção: ' +
            ' Lote: ' + IntToStr(EventoRetorno.idLote) +
            ' Ambiente: ' + TpAmbToStr(EventoRetorno.tpAmb) +
            ' Orgao: ' + IntToStr(EventoRetorno.cOrgao) +
            ' Status: ' + IntToStr(EventoRetorno.cStat) +
            ' Motivo: ' + EventoRetorno.xMotivo
          );
        end;
      end;
    except on e: Exception do
      raise Exception.Create(e.Message);
    end;
  finally
    FreeAndNil(FDQuery);
    FreeAndNil(vNfe);
    FreeAndNil(vACBrNFe);
  end;
end;

class procedure TNfe.configurar(Nfe: TACBrNFe);
var
  v_empresa: TEmpresa;
  Ok: Boolean;
begin
  try
    v_empresa:= TEmpresa.find(TAuthService.Terminal.EmpresaId);
    if not Assigned(v_empresa) then
      raise Exception.Create('Falha ao carregar dados da empresa.');

    with Nfe.Configuracoes do
    begin
      Geral.VersaoDF:= StrToVersaoDF(Ok, v_empresa.NfeConfiguracao.VersaoDf);
      Geral.AtualizarXMLCancelado:= v_empresa.NfeConfiguracao.AtualizarXmlCancelado = 'S';
      Geral.IdCSC:= v_empresa.NfeConfiguracao.IdCsc;
      Geral.CSC:= v_empresa.NfeConfiguracao.Csc;
      Geral.IncluirQRCodeXMLNFCe:= v_empresa.NfeConfiguracao.IncluirQrcodeXmlNfce = 'S';
      Geral.Salvar:= v_empresa.NfeConfiguracao.GeralSalvar = 'S';
      Geral.ExibirErroSchema:= v_empresa.NfeConfiguracao.ExibirErroSchema = 'S';
      Geral.RetirarAcentos:= v_empresa.NfeConfiguracao.RetirarAcentos = 'S';
      Geral.RetirarEspacos:= v_empresa.NfeConfiguracao.RetirarEspacos = 'S';
      Geral.IdentarXML:= v_empresa.NfeConfiguracao.IdentarXml = 'S';
      Geral.ValidarDigest:= v_empresa.NfeConfiguracao.ValidarDigest = 'S';

      Geral.SSLLib:= TSSLLib(v_empresa.NfeConfiguracao.Ssllib.ToInteger());

      Arquivos.EmissaoPathNFe:= v_empresa.NfeConfiguracao.EmissaoPathNfe = 'S';
      Arquivos.SalvarEvento:= v_empresa.NfeConfiguracao.SalvarEvento = 'S';
      Arquivos.SalvarApenasNFeProcessadas:= v_empresa.NfeConfiguracao.SalvarApenasNfeProcessadas = 'S';
      Arquivos.PathNFe:= v_empresa.NfeConfiguracao.PathNfe;
      Arquivos.PathInu:= v_empresa.NfeConfiguracao.PathInu;
      Arquivos.PathEvento:= v_empresa.NfeConfiguracao.PathEvento;
      Arquivos.PathSalvar:= v_empresa.NfeConfiguracao.PathSalvar;
      Arquivos.PathSchemas:= v_empresa.NfeConfiguracao.PathSchemas;
      Arquivos.Salvar:= v_empresa.NfeConfiguracao.ArquivosSalvar = 'S';
      Arquivos.AdicionarLiteral:= v_empresa.NfeConfiguracao.AdicionarLiteral = 'S';
      Arquivos.SepararPorCNPJ:= v_empresa.NfeConfiguracao.SepararPorCnpj = 'S';
      Arquivos.SepararPorModelo:= v_empresa.NfeConfiguracao.SepararPorModelo = 'S';
      Arquivos.SepararPorMes:= v_empresa.NfeConfiguracao.SepararPorMes = 'S';

      WebServices.UF:= v_empresa.NfeConfiguracao.Uf;
      WebServices.Visualizar:= v_empresa.NfeConfiguracao.Visualizar = 'S';
      WebServices.Ambiente:= StrToTpAmb(Ok, v_empresa.NfeConfiguracao.AmbienteCodigo);
      WebServices.AguardarConsultaRet:= v_empresa.NfeConfiguracao.AguardarConsultaRet;
      WebServices.IntervaloTentativas:= v_empresa.NfeConfiguracao.IntervaloTentativas;
      WebServices.Tentativas:= v_empresa.NfeConfiguracao.Tentativas;
      WebServices.AjustaAguardaConsultaRet:= v_empresa.NfeConfiguracao.AjustaAguardaConsultaRet = 'S';

      Certificados.ArquivoPFX:= v_empresa.NfeConfiguracao.ArquivoPfx;
      Certificados.NumeroSerie:= v_empresa.NfeConfiguracao.NumeroSerie;
      Certificados.Senha:= v_empresa.NfeConfiguracao.Senha;
      Certificados.VerificarValidade:= v_empresa.NfeConfiguracao.VerificarValidade = 'S';
    end;

    if Assigned(Nfe.DANFE) then
    begin
      Nfe.DANFE.PathPDF:= v_empresa.NfeConfiguracao.PathPdf;
      Nfe.DANFE.Logo:= '';
      if FilesExists(v_empresa.NfeConfiguracao.Logo) then
        Nfe.DANFE.Logo:= v_empresa.NfeConfiguracao.Logo;
    end;
  finally
    FreeAndNil(v_empresa);
  end;
end;

procedure TNfe.atualizaNumeroDoLote();
const
  FSql: string = 'UPDATE NFES SET NUNLOTE = :NUNLOTE WHERE ID = :ID';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('NUNLOTE').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;

      if (Self.Nunlote <> EmptyStr) then
        FDQuery.Params.ParamByName('NUNLOTE').AsString:= Self.Nunlote;

      FDQuery.ExecSQL();
    except
      //--
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class procedure TNfe.atualizar(NfeId: string);
var
  vACBrNF: TACBrNFe;
  vNfe: TNfe;
  vXML: string;
  vCstatus: Integer;
begin
  try
    vXML:= '';
    vNfe:= nil;
    vACBrNF:= TACBrNFe.Create(nil);
    try
      vNfe:= TNfe.find(NfeId);
      if not Assigned(vNfe) then
        raise Exception.Create('Falha ao consultar os dados da nota fiscal.');

      TNfe.configurar(vACBrNF);

      vXML:= TNfe.consultaXML(vNfe.Id);
      vACBrNF.NotasFiscais.LoadFromString(vXML);

      if vACBrNF.Consultar() then
      begin
        vCstatus:= vACBrNF.WebServices.Consulta.cStat;
        if THelper.ValueIn(vCstatus, [100,101,150,151,110,301,302]) then
        begin
          vNfe.Cdv:= vACBrNF.NotasFiscais.Items[0].NFe.Ide.cDV;
          vNfe.Demi:= vACBrNF.NotasFiscais.Items[0].NFe.Ide.dEmi;
          vNfe.Dsaient:= vACBrNF.NotasFiscais.Items[0].NFe.Ide.dSaiEnt;

          vNfe.Chnfe:= vACBrNF.NotasFiscais.Items[0].NFe.procNFe.chNFe;
          vNfe.Nprot:= vACBrNF.NotasFiscais.Items[0].NFe.procNFe.nProt;
          vNfe.Cstat:= vACBrNF.NotasFiscais.Items[0].NFe.procNFe.cStat;
          vNfe.save();

          TNfe.GravarXML(vNfe.Id, vACBrNF.NotasFiscais.Items[0].XML);
        end
        else
        begin
          raise Exception.Create(
            Format('Número: %9.9d    Série: %3.3d    Data: %s    ', [
               vACBrNF.NotasFiscais.Items[0].NFe.Ide.nNF,
               vACBrNF.NotasFiscais.Items[0].NFe.Ide.serie,
               FormatDateTime('dd/mm/yyyy', vACBrNF.NotasFiscais.Items[0].NFe.Ide.dEmi)
            ]) + String(vACBrNF.WebServices.Consulta.XMotivo));
        end;
      end;
    except on e: Exception do
      THelper.Mensagem('Falha ao atualizar. Erro: ' + e.Message);
    end;
  finally
    FreeAndNil(vNfe);
    FreeAndNil(vACBrNF);
  end;
end;

class function TNfe.consultaXML(NfeId: string): string;
const
  FSql: string =
  'SELECT XML FROM NFES WHERE ID = :ID';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ID').AsString:= NfeId;
      FDQuery.Open;
      if (FDQuery.RecordCount = 0) then Result:= ''
      else Result:= FDQuery.FieldByName('XML').AsString;
    except on e: Exception do
      Result:= '';
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

constructor TNfe.Create;
begin
  Self.Table:= 'NFES';
end;

destructor TNfe.Destroy;
begin
  if Assigned(Self.FEMPRESA) then FreeAndNil(Self.FEMPRESA);
  if Assigned(Self.FPARTICIPANTE) then FreeAndNil(Self.FPARTICIPANTE);
  if Assigned(Self.FDET) then FreeAndNil(Self.FDET);
  if Assigned(Self.FICMSTOT) then FreeAndNil(Self.FICMSTOT);
  if Assigned(Self.FPAG) then FreeAndNil(Self.FPAG);

  inherited;
end;

procedure TNfe.enviar(pPrint: Integer);
var
  vACBrNF: TACBrNFe;
  Ok: Boolean;
  I: Integer;
  vCstatus: Integer;
  vNfeMessageError: string;
  vNfeContinue: Boolean;
  vRegras: string;
  vMsgMotivoDenegacao: string;
  vXML: string;
  vSincrono: Boolean;
  vLoopConsulta: Integer;
begin
  try
    try
      vACBrNF:= TACBrNFe.Create(nil);
      TNfe.configurar(vACBrNF);

      if (Self.Cstat in[0,99]) and (Self.Nunlote <> EmptyStr) then
      begin
        vLoopConsulta:= 0;
        while (vLoopConsulta <= 4) do
        begin
          if (vLoopConsulta > 0) then Sleep(10000);
          try
            vXML:= TNfe.consultaXML(Self.Id);
            vACBrNF.NotasFiscais.LoadFromString(vXML);
            if vACBrNF.Consultar() then
            begin
              vCstatus:= vACBrNF.WebServices.Consulta.cStat;

              if THelper.ValueIn(vCstatus, [100, 150, 110, 301, 302]) then
              begin
                Self.Cdv:= vACBrNF.NotasFiscais.Items[0].NFe.Ide.cDV;
                Self.Demi:= vACBrNF.NotasFiscais.Items[0].NFe.Ide.dEmi;
                Self.Dsaient:= vACBrNF.NotasFiscais.Items[0].NFe.Ide.dSaiEnt;

                Self.Chnfe:= vACBrNF.NotasFiscais.Items[0].NFe.procNFe.chNFe;
                Self.Nprot:= vACBrNF.NotasFiscais.Items[0].NFe.procNFe.nProt;
                Self.Cstat:= vACBrNF.NotasFiscais.Items[0].NFe.procNFe.cStat;
                Self.save;

                Self.GravarXML(Self.Id, vACBrNF.NotasFiscais.Items[0].XML);

                case vCstatus of
                  100, 150: begin
                    case pPrint of
                      0: Self.imprimir(Self.Id);
                      1: begin
                        if THelper.Mensagem('Nota fiscal autorizada. Deseja imprimir?', 1) then
                          Self.imprimir(Self.Id);
                      end;
                    end;
                  end;
                  110, 301, 302: begin
                    case vCstatus of
                      110: vMsgMotivoDenegacao := '110 - Nota fiscal denegada.';
                      301: vMsgMotivoDenegacao := '301 - Irregularidade fiscal do emitente.';
                      302: vMsgMotivoDenegacao := '302 - Irregularidade fiscal do destinatário.';
                    end;

                    THelper.Mensagem(vMsgMotivoDenegacao);
                  end;
                end;

                Exit();
              end
              else if (vCstatus > 0) and (vCstatus <> 217) then
              begin
                raise Exception.Create(
                  Format('Número: %9.9d    Série: %3.3d    Data: %s    ', [
                     vACBrNF.NotasFiscais.Items[0].NFe.Ide.nNF,
                     vACBrNF.NotasFiscais.Items[0].NFe.Ide.serie,
                     FormatDateTime('dd/mm/yyyy', vACBrNF.NotasFiscais.Items[0].NFe.Ide.dEmi)
                  ]) + String(vACBrNF.WebServices.Consulta.XMotivo));
              end;
            end;
          except on e: exception do
            raise Exception.Create(e.Message);
          end;

          Inc(vLoopConsulta);
          if (vCstatus <> 217) then vLoopConsulta:= 5;
        end;
      end;

      if (Self.Cstat = 99) then
      begin
        try
          vXML:= TNfe.consultaXML(Self.Id);

          vACBrNF.NotasFiscais.Clear();
          vACBrNF.NotasFiscais.LoadFromString(vXML);

          Self.Nunlote:= FormatDateTime('yyyymmddhhmmss', Now);
          vSincrono:= (Self.Modelo = '65');
          if vACBrNF.Enviar(Self.Nunlote, False, vSincrono) then
          begin
            vCstatus:= vACBrNF.NotasFiscais.Items[0].NFe.procNFe.cStat;

            if THelper.ValueIn(vCstatus, [100, 150, 110, 301, 302]) then
            begin
              Self.Cdv:= vACBrNF.NotasFiscais.Items[0].NFe.Ide.cDV;
              Self.Demi:= vACBrNF.NotasFiscais.Items[0].NFe.Ide.dEmi;
              Self.Dsaient:= vACBrNF.NotasFiscais.Items[0].NFe.Ide.dSaiEnt;

              Self.Chnfe:= vACBrNF.NotasFiscais.Items[0].NFe.procNFe.chNFe;
              Self.Nprot:= vACBrNF.NotasFiscais.Items[0].NFe.procNFe.nProt;
              Self.Cstat:= vACBrNF.NotasFiscais.Items[0].NFe.procNFe.cStat;
              Self.save();

              Self.GravarXML(Self.Id, vACBrNF.NotasFiscais.Items[0].XML);

              case vCstatus of
                100, 150: begin
                  case pPrint of
                    0: Self.imprimir(Self.Id);
                    1: begin
                      if THelper.Mensagem('Nota fiscal autorizada. Deseja imprimir?', 1) then
                        Self.imprimir(Self.Id);
                    end;
                  end;
                end;
                110, 301, 302: begin
                  case vCstatus of
                    110: vMsgMotivoDenegacao := '110 - Nota fiscal denegada.';
                    301: vMsgMotivoDenegacao := '301 - Irregularidade fiscal do emitente.';
                    302: vMsgMotivoDenegacao := '302 - Irregularidade fiscal do destinatário.';
                  end;

                  THelper.Mensagem(vMsgMotivoDenegacao);
                end;
              end;

              Exit();
            end
            else
            begin
              raise Exception.Create(
                Format('Número: %9.9d    Série: %3.3d    Data: %s    ', [
                   vACBrNF.NotasFiscais.Items[0].NFe.Ide.nNF,
                   vACBrNF.NotasFiscais.Items[0].NFe.Ide.serie,
                   FormatDateTime('dd/mm/yyyy', vACBrNF.NotasFiscais.Items[0].NFe.Ide.dEmi)
                ]) + String(vACBrNF.NotasFiscais.Items[0].Msg));
            end;
          end;
        except on e: exception do
          begin
            if (vACBrNF.WebServices.Enviar.cStat = 0) then
              atualizaNumeroDoLote();

            raise Exception.Create(e.Message);
          end;
        end;
      end;

      vACBrNF.NotasFiscais.Clear();
      vACBrNF.NotasFiscais.Add();
      with vACBrNF.NotasFiscais.Items[0].NFe do
      begin
        Ide.cUF:= UFtoCUF(Self.Empresa.Uf);
        Ide.cNF:= StrToIntDef(Self.Cnf, 0);
        Ide.natOp:= Self.Natop;
        Ide.indPag:= StrToIndpag(Ok, Self.Indpag);
        Ide.modelo:= StrToIntDef(Self.Modelo, 0);
        Ide.serie:= Self.Serie;
        Ide.nNF:= Self.Nnf;
        Ide.dEmi:= StrToDateTimeDef(DateToStr(Self.Demi) + ' ' + TimeToStr(Now), Now);
        Ide.tpNF:= StrToTpNF(Ok, Self.Tpnf);
        Ide.idDest:= StrToDestinoOperacao(Ok, Self.Iddest);
        Ide.cMunFG:= StrToIntDef(Self.Cmunfg, 0);
        Ide.tpImp:= StrToTpImp(Ok, Self.Tpimp);
        Ide.tpEmis:= StrToTpEmis(Ok, Self.Tpemis);
        vACBrNF.Configuracoes.Geral.FormaEmissao:= Ide.tpEmis;
        Ide.cDV:= Self.Cdv;
        Ide.tpAmb:= StrToTpAmb(Ok, Self.Tpamb);
        Ide.finNFe:= StrToFinNFe(Ok, Self.Finnfe);
        Ide.indFinal:= StrToConsumidorFinal(Ok, Self.Indfinal);
        Ide.indPres:= StrToPresencaComprador(Ok, Self.Indpres);
        Ide.procEmi:= StrToprocEmi(Ok, Self.Procemi);

        if (StrToIntDef(Self.Tpemis, 1) >= 2) then
        begin
          Ide.dhCont:= StrToDateTimeDef(DateToStr(Self.Dhcont) + ' ' + TimeToStr(Now), Now);
          Ide.xJust:= Self.Xjust;
        end;
      end;

      with vACBrNF.NotasFiscais.Items[0].NFe do
      begin
        Emit.CNPJCPF:= Self.Empresa.Documento;
        Emit.xNome:= Self.Empresa.RazaoSocial;
        Emit.xFant:= Self.Empresa.Nome;
        Emit.IE:= Self.Empresa.Ie;
        Emit.IEST:= Self.Empresa.Iest;
        Emit.IM:= Self.Empresa.Im;
        Emit.CNAE:= Self.Empresa.Cnae;
        Emit.CRT:= StrToCRT(Ok, Self.Empresa.Crt);
        Emit.EnderEmit.xLgr:= Self.Empresa.Logradouro;
        Emit.EnderEmit.nro:= Self.Empresa.Numero;
        Emit.EnderEmit.xCpl:= Self.Empresa.Complemento;
        Emit.EnderEmit.xBairro:= Self.Empresa.Bairro;
        Emit.EnderEmit.cMun:= StrToIntDef(Self.Empresa.CodigoMunicipio, 0);
        Emit.EnderEmit.xMun:= Self.Empresa.NomeMunicipio;
        Emit.EnderEmit.UF:= Self.Empresa.Uf;
        Emit.EnderEmit.CEP:= StrToIntDef(Self.Empresa.Cep, 0);
        Emit.EnderEmit.cPais:= 1058;
        Emit.EnderEmit.xPais:= 'Brasil';
        Emit.EnderEmit.fone:= Self.Empresa.Fone;
      end;

      with vACBrNF.NotasFiscais.Items[0].NFe do
      begin
        if (Self.Participante.Documento <> '00000000000') then
        begin
          Dest.CNPJCPF:= Self.Participante.Documento;
          Dest.xNome:= Self.Participante.Nome;
          Dest.indIEDest:= StrToindIEDest(Ok, '9');
        end
        else
          Dest.indIEDest:= StrToindIEDest(Ok, '9');
      end;

      for I:= 0 to Pred(Self.Det.Count) do
      begin
        vACBrNF.NotasFiscais.Items[0].NFe.Det.Add();
        with vACBrNF.NotasFiscais.Items[0].NFe.Det.Items[I] do
        begin
          Prod.cProd:= Self.Det.Items[I].Cprod;
          Prod.nItem:= Self.Det.Items[I].Nitem;
          Prod.cEAN:= IfThen(EAN13Valido(Self.Det.Items[I].Cean), Self.Det.Items[I].Cean, '');
          Prod.xProd:= Self.Det.Items[I].Xprod;
          Prod.NCM:= Self.Det.Items[I].Ncm;
          Prod.EXTIPI:= Self.Det.Items[I].Extipi;
          Prod.CFOP:= Self.Det.Items[I].Cfop;
          Prod.uCom:= Self.Det.Items[I].Ucom;
          Prod.qCom:= Self.Det.Items[I].Qcom;
          Prod.vUnCom:= Self.Det.Items[I].Vuncom;
          Prod.vProd:= Self.Det.Items[I].Vprod;
          Prod.cEANTrib:= IfThen(EAN13Valido(Self.Det.Items[I].Ceantrib), Self.Det.Items[I].Ceantrib, '');
          Prod.uTrib:= Self.Det.Items[I].Utrib;
          Prod.qTrib:= Self.Det.Items[I].Qtrib;
          Prod.vUnTrib:= Self.Det.Items[I].Vuntrib;
          Prod.vFrete:= Self.Det.Items[I].Vfrete;
          Prod.vSeg:= Self.Det.Items[I].Vseg;
          Prod.vDesc:= Self.Det.Items[I].Vdesc;
          Prod.vOutro:= Self.Det.Items[I].Voutro;
          Prod.IndTot:= StrToindTot(Ok, Self.Det.Items[I].Indtot);
          Prod.xPed:= Self.Det.Items[I].Xped;
          Prod.nItemPed:= Self.Det.Items[I].Nitemped;
          Prod.nRECOPI:= Self.Det.Items[I].Nrecopi;
          Prod.nFCI:= Self.Det.Items[I].Nfci;
          Prod.CEST:= Self.Det.Items[I].Cest;
          pDevol:= Self.Det.Items[I].Pdevol;
          vIPIDevol:= Self.Det.Items[I].Vipidevol;
          infAdProd:= Self.Det.Items[I].Infadprod;
        end;

        with vACBrNF.NotasFiscais.Items[0].NFe.Det.Items[I].Imposto do
        begin
          vTotTrib:= Self.Det.Items[I].Vtottrib;
          case AnsiIndexStr(Self.Det.Items[I].ICMS.Cst,['00','10','20','30','40','41','50','51','60','70','80','81','90','91']) of
            0: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CST:= StrToCSTICMS(Ok, '00');

              ICMS.modBC:= StrTomodBC(Ok, Self.Det.Items[I].ICMS.Modbc);
              ICMS.vBC:= Self.Det.Items[I].ICMS.Vbc;
              ICMS.pICMS:= Self.Det.Items[I].ICMS.Picms;
              ICMS.vICMS:= Self.Det.Items[I].ICMS.Vicms;

              ICMS.pFCP:= Self.Det.Items[I].ICMS.Pfcp;
              ICMS.vFCP:= Self.Det.Items[I].ICMS.Vfcp;
            end;
            1: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CST:= StrToCSTICMS(Ok, '10');

              ICMS.modBC:= StrTomodBC(Ok, Self.Det.Items[I].ICMS.Modbc);
              ICMS.vBC:= Self.Det.Items[I].ICMS.Vbc;
              ICMS.pICMS:= Self.Det.Items[I].ICMS.Picms;
              ICMS.vICMS:= Self.Det.Items[I].ICMS.Vicms;

              ICMS.vBCFCP:= Self.Det.Items[I].ICMS.Vbcfcp;
              ICMS.pFCP:= Self.Det.Items[I].ICMS.Pfcp;
              ICMS.vFCP:= Self.Det.Items[I].ICMS.Vfcp;

              ICMS.pMVAST:= Self.Det.Items[I].ICMS.Pmvast;
              ICMS.pRedBCST:= Self.Det.Items[I].ICMS.Predbcst;
              ICMS.vBCST:= Self.Det.Items[I].ICMS.Vbcst;
              ICMS.pICMSST:= Self.Det.Items[I].ICMS.Picmsst;
              ICMS.vICMSST:= Self.Det.Items[I].ICMS.Vicmsst;

              ICMS.vBCFCPST:= Self.Det.Items[I].ICMS.Vbcfcpst;
              ICMS.pFCPST:= Self.Det.Items[I].ICMS.Pfcpst;
              ICMS.vFCPST:= Self.Det.Items[I].ICMS.Vfcpst;
            end;
            2: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CST:= StrToCSTICMS(Ok, '20');

              ICMS.modBC:= StrTomodBC(Ok, Self.Det.Items[I].ICMS.Modbc);
              ICMS.pRedBC:= Self.Det.Items[I].ICMS.Predbc;
              ICMS.vBC:= Self.Det.Items[I].ICMS.Vbc;
              ICMS.pICMS:= Self.Det.Items[I].ICMS.Picms;
              ICMS.vICMS:= Self.Det.Items[I].ICMS.Vicms;

              ICMS.vBCFCP:= Self.Det.Items[I].ICMS.Vbcfcp;
              ICMS.pFCP:= Self.Det.Items[I].ICMS.Pfcp;
              ICMS.vFCP:= Self.Det.Items[I].ICMS.Vfcp;

              ICMS.vICMSDeson:= Self.Det.Items[I].ICMS.Vicmsdeson;
              ICMS.motDesICMS:= StrTomotDesICMS(Ok, Self.Det.Items[I].ICMS.Motdesicms);
            end;
            3: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CST:= StrToCSTICMS(Ok, '30');

              ICMS.modBCST:= StrTomodBCST(Ok, Self.Det.Items[I].ICMS.Modbcst);
              ICMS.pMVAST:= Self.Det.Items[I].ICMS.Pmvast;
              ICMS.pRedBCST:= Self.Det.Items[I].ICMS.Predbcst;
              ICMS.vBCST:= Self.Det.Items[I].ICMS.Vbcst;
              ICMS.pICMSST:= Self.Det.Items[I].ICMS.Picmsst;
              ICMS.vICMSST:= Self.Det.Items[I].ICMS.Vicmsst;

              ICMS.vBCFCPST:= Self.Det.Items[I].ICMS.Vbcfcpst;
              ICMS.pFCPST:= Self.Det.Items[I].ICMS.Pfcpst;
              ICMS.vFCPST:= Self.Det.Items[I].ICMS.Vfcpst;

              ICMS.vICMSDeson:= Self.Det.Items[I].ICMS.Vicmsdeson;
              ICMS.motDesICMS:= StrTomotDesICMS(Ok, Self.Det.Items[I].ICMS.Motdesicms);
            end;
            4: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CST:= StrToCSTICMS(Ok, '40');

              ICMS.vICMSDeson:= Self.Det.Items[I].ICMS.Vicmsdeson;
              ICMS.motDesICMS:= StrTomotDesICMS(Ok, Self.Det.Items[I].ICMS.Motdesicms);
            end;
            5: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CST:= StrToCSTICMS(Ok, '41');

              ICMS.vICMSDeson:= Self.Det.Items[I].ICMS.Vicmsdeson;
              ICMS.motDesICMS:= StrTomotDesICMS(Ok, Self.Det.Items[I].ICMS.Motdesicms);
            end;
            6: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CST:= StrToCSTICMS(Ok, '50');

              ICMS.vICMSDeson:= Self.Det.Items[I].ICMS.Vicmsdeson;
              ICMS.motDesICMS:= StrTomotDesICMS(Ok, Self.Det.Items[I].ICMS.Motdesicms);
            end;
            7: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CST:= StrToCSTICMS(Ok, '51');

              ICMS.pRedBC:= Self.Det.Items[I].ICMS.Predbc;
              ICMS.vBC:= Self.Det.Items[I].ICMS.Vbc;
              ICMS.pICMS:= Self.Det.Items[I].ICMS.Picms;
              ICMS.vICMSOp:= Self.Det.Items[I].ICMS.Vicmsop;
              ICMS.pDif:= Self.Det.Items[I].ICMS.Pdif;
              ICMS.vICMSDif:= Self.Det.Items[I].ICMS.Vicmsdif;
              ICMS.vICMS:= Self.Det.Items[I].ICMS.Vicms;

              ICMS.vBCFCP:= Self.Det.Items[I].ICMS.Vbcfcp;
              ICMS.pFCP:= Self.Det.Items[I].ICMS.Pfcp;
              ICMS.vFCP:= Self.Det.Items[I].ICMS.Vfcp;
            end;
            8: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CST:= StrToCSTICMS(Ok, '60');

              ICMS.vBCSTRet:= Self.Det.Items[I].ICMS.Vbcstret;
              ICMS.pST:= Self.Det.Items[I].ICMS.Pst;
              ICMS.vICMSSTRet:= Self.Det.Items[I].ICMS.Vicmsstret;

              ICMS.vBCFCPSTRet:= Self.Det.Items[I].ICMS.Vbcfcpstret;
              ICMS.pFCPSTRet:= Self.Det.Items[I].ICMS.Pfcpstret;
              ICMS.vFCPSTRet:= Self.Det.Items[I].ICMS.Vfcpstret;
            end;
            9: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CST:= StrToCSTICMS(Ok, '70');

              ICMS.modBC:= StrTomodBC(Ok, Self.Det.Items[I].ICMS.Modbc);
              ICMS.pRedBC:= Self.Det.Items[I].ICMS.Predbc;
              ICMS.vBC:= Self.Det.Items[I].ICMS.Vbc;
              ICMS.pICMS:= Self.Det.Items[I].ICMS.Picms;
              ICMS.vICMS:= Self.Det.Items[I].ICMS.Vicms;

              ICMS.vBCFCP:= Self.Det.Items[I].ICMS.Vbcfcp;
              ICMS.pFCP:= Self.Det.Items[I].ICMS.Pfcp;
              ICMS.vFCP:= Self.Det.Items[I].ICMS.Vfcp;

              ICMS.modBCST:= StrTomodBCST(Ok, Self.Det.Items[I].ICMS.Modbcst);
              ICMS.pMVAST:= Self.Det.Items[I].ICMS.Pmvast;
              ICMS.pRedBCST:= Self.Det.Items[I].ICMS.Predbcst;
              ICMS.vBCST:= Self.Det.Items[I].ICMS.Vbcst;
              ICMS.pICMSST:= Self.Det.Items[I].ICMS.Picmsst;
              ICMS.vICMSST:= Self.Det.Items[I].ICMS.Vicmsst;

              ICMS.vBCFCPST:= Self.Det.Items[I].ICMS.Vbcfcpst;
              ICMS.pFCPST:= Self.Det.Items[I].ICMS.Pfcpst;
              ICMS.vFCPST:= Self.Det.Items[I].ICMS.Vfcpst;

              ICMS.vICMSDeson:= Self.Det.Items[I].ICMS.Vicmsdeson;
              ICMS.motDesICMS:= StrTomotDesICMS(Ok, Self.Det.Items[I].ICMS.Motdesicms);
            end;
            10: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CST:= StrToCSTICMS(Ok, '80');
            end;
            11: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CST:= StrToCSTICMS(Ok, '81');
            end;
            12: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CST:= StrToCSTICMS(Ok, '90');
            end;
            13: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CST:= StrToCSTICMS(Ok, '91');
            end;
          end;

          case AnsiIndexStr(Self.Det.Items[I].ICMS.Csosn,['101','102','103','201','202','203','300','400','500','900']) of
            0: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CSOSN:= StrToCSOSNIcms(Ok, '101');
              ICMS.pCredSN:= Self.Det.Items[I].ICMS.Pcredsn;
              ICMS.vCredICMSSN:= Self.Det.Items[I].ICMS.Vcredicmssn;
            end;
            1: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CSOSN:= StrToCSOSNIcms(Ok, '102');
            end;
            2: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CSOSN:= StrToCSOSNIcms(Ok, '103');
            end;
            3: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CSOSN:= StrToCSOSNIcms(Ok, '201');
              ICMS.modBCST:= StrTomodBCST(Ok, Self.Det.Items[I].ICMS.Modbcst);
              ICMS.pMVAST:= Self.Det.Items[I].ICMS.Pmvast;
              ICMS.pRedBCST:= Self.Det.Items[I].ICMS.Predbcst;
              ICMS.vBCST:= Self.Det.Items[I].ICMS.Vbcst;
              ICMS.pICMSST:= Self.Det.Items[I].ICMS.Picmsst;
              ICMS.vICMSST:= Self.Det.Items[I].ICMS.Vicmsst;
              ICMS.vBCFCPST:= Self.Det.Items[I].ICMS.Vbcfcpst;
              ICMS.pFCPST:= Self.Det.Items[I].ICMS.Pfcpst;
              ICMS.vFCPST:= Self.Det.Items[I].ICMS.Vfcpst;
            end;
            4: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CSOSN:= StrToCSOSNIcms(Ok, '202');
              ICMS.modBCST:= StrTomodBCST(Ok, Self.Det.Items[I].ICMS.Modbcst);
              ICMS.pMVAST:= Self.Det.Items[I].ICMS.Pmvast;
              ICMS.pRedBCST:= Self.Det.Items[I].ICMS.Predbcst;
              ICMS.vBCST:= Self.Det.Items[I].ICMS.Vbcst;
              ICMS.pICMSST:= Self.Det.Items[I].ICMS.Picmsst;
              ICMS.vICMSST:= Self.Det.Items[I].ICMS.Vicmsst;
              ICMS.vBCFCPST:= Self.Det.Items[I].ICMS.Vbcfcpst;
              ICMS.pFCPST:= Self.Det.Items[I].ICMS.Pfcpst;
              ICMS.vFCPST:= Self.Det.Items[I].ICMS.Vfcpst;
            end;
            5: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CSOSN:= StrToCSOSNIcms(Ok, '203');
              ICMS.modBCST:= StrTomodBCST(Ok, Self.Det.Items[I].ICMS.Modbcst);
              ICMS.pMVAST:= Self.Det.Items[I].ICMS.Pmvast;
              ICMS.pRedBCST:= Self.Det.Items[I].ICMS.Predbcst;
              ICMS.vBCST:= Self.Det.Items[I].ICMS.Vbcst;
              ICMS.pICMSST:= Self.Det.Items[I].ICMS.Picmsst;
              ICMS.vICMSST:= Self.Det.Items[I].ICMS.Vicmsst;
              ICMS.vBCFCPST:= Self.Det.Items[I].ICMS.Vbcfcpst;
              ICMS.pFCPST:= Self.Det.Items[I].ICMS.Pfcpst;
              ICMS.vFCPST:= Self.Det.Items[I].ICMS.Vfcpst;
            end;
            6: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CSOSN:= StrToCSOSNIcms(Ok, '300');
            end;
            7: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CSOSN:= StrToCSOSNIcms(Ok, '400');
            end;
            8: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CSOSN:= StrToCSOSNIcms(Ok, '500');
              ICMS.vBCSTRet:= Self.Det.Items[I].ICMS.Vbcstret;
              ICMS.vICMSSTRet:= Self.Det.Items[I].ICMS.Vicmsstret;
              ICMS.vBCFCPSTRet:= Self.Det.Items[I].ICMS.Vbcfcpstret;
              ICMS.pFCPSTRet:= Self.Det.Items[I].ICMS.Pfcpstret;
              ICMS.vFCPSTRet:= Self.Det.Items[I].ICMS.Vfcpstret;
              ICMS.pST:= Self.Det.Items[I].ICMS.Pst;
            end;
            9: begin
              ICMS.orig:= StrToOrig(Ok, Self.Det.Items[I].ICMS.Orig);
              ICMS.CSOSN:= StrToCSOSNIcms(Ok, '900');
              ICMS.modBC:= StrTomodBC(Ok, Self.Det.Items[I].ICMS.Modbc);
              ICMS.pRedBC:= Self.Det.Items[I].ICMS.Predbc;
              ICMS.vBC:= Self.Det.Items[I].ICMS.Vbc;
              ICMS.pICMS:= Self.Det.Items[I].ICMS.Picms;
              ICMS.vICMS:= Self.Det.Items[I].ICMS.Vicms;
              ICMS.modBCST:= StrTomodBCST(Ok, Self.Det.Items[I].ICMS.Modbcst);
              ICMS.pMVAST:= Self.Det.Items[I].ICMS.Pmvast;
              ICMS.pRedBCST:= Self.Det.Items[I].ICMS.Predbcst;
              ICMS.vBCST:= Self.Det.Items[I].ICMS.Vbcst;
              ICMS.pICMSST:= Self.Det.Items[I].ICMS.Picmsst;
              ICMS.vICMSST:= Self.Det.Items[I].ICMS.Vicmsst;
              ICMS.UFST:= Self.Det.Items[I].ICMS.Ufst;
              ICMS.pBCOp:= Self.Det.Items[I].ICMS.Pbcop;
              ICMS.vBCSTRet:= Self.Det.Items[I].ICMS.Vbcstret;
              ICMS.vICMSSTRet:= Self.Det.Items[I].ICMS.Vicmsstret;
              ICMS.motDesICMS:= StrTomotDesICMS(Ok, Self.Det.Items[I].ICMS.Motdesicms);
              ICMS.pCredSN:= Self.Det.Items[I].ICMS.Pcredsn;
              ICMS.vCredICMSSN:= Self.Det.Items[I].ICMS.Vcredicmssn;
              ICMS.vBCSTDest:= Self.Det.Items[I].ICMS.Vbcstdest;
              ICMS.vICMSSTDest:= Self.Det.Items[I].ICMS.Vicmsstdest;
              ICMS.vICMSDeson:= Self.Det.Items[I].ICMS.Vicmsdeson;
              ICMS.vICMSOp:= Self.Det.Items[I].ICMS.Vicmsop;
              ICMS.pDif:= Self.Det.Items[I].ICMS.Pdif;
              ICMS.vICMSDif:= Self.Det.Items[I].ICMS.Vicmsdif;
              ICMS.vBCFCP:= Self.Det.Items[I].ICMS.Vbcfcp;
              ICMS.pFCP:= Self.Det.Items[I].ICMS.Pfcp;
              ICMS.vFCP:= Self.Det.Items[I].ICMS.Vfcp;
              ICMS.vBCFCPST:= Self.Det.Items[I].ICMS.Vbcfcpst;
              ICMS.pFCPST:= Self.Det.Items[I].ICMS.Pfcpst;
              ICMS.vFCPST:= Self.Det.Items[I].ICMS.Vfcpst;
              ICMS.vBCFCPSTRet:= Self.Det.Items[I].ICMS.Vbcfcpstret;
              ICMS.pFCPSTRet:= Self.Det.Items[I].ICMS.Pfcpstret;
              ICMS.vFCPSTRet:= Self.Det.Items[I].ICMS.Vfcpstret;
              ICMS.pST:= Self.Det.Items[I].ICMS.Pst;
            end;
          end;

          if Assigned(Self.Det.Items[I].IPI) and (StrToIntDef(Self.Det.Items[I].IPI.Cst, -1) >= 0)  then
          begin
            IPI.clEnq:= Self.Det.Items[I].IPI.Clenq;
            IPI.CNPJProd:= Self.Det.Items[I].IPI.Cnpjprod;
            IPI.cSelo:= Self.Det.Items[I].IPI.Cselo;
            IPI.qSelo:= Self.Det.Items[I].IPI.Qselo;
            IPI.cEnq:= Self.Det.Items[I].IPI.Cenq;
            IPI.CST:= StrToCSTIPI(Ok, Self.Det.Items[I].IPI.Cst);
            IPI.vBC:= Self.Det.Items[I].IPI.Vbc;
            IPI.qUnid:= Self.Det.Items[I].IPI.Qunid;
            IPI.vUnid:= Self.Det.Items[I].IPI.Vunid;
            IPI.pIPI:= Self.Det.Items[I].IPI.Pipi;
            IPI.vIPI:= Self.Det.Items[I].IPI.Vipi;
          end;

          if Assigned(Self.Det.Items[I].PIS) and (StrToIntDef(Self.Det.Items[I].PIS.Cst, 0) >= 1) then
          begin
            PIS.CST:= StrToCSTPIS(Ok, Self.Det.Items[I].PIS.Cst);
            PIS.vBC:= Self.Det.Items[I].PIS.Vbc;
            PIS.pPIS:= Self.Det.Items[I].PIS.Ppis;
            PIS.vPIS:= Self.Det.Items[I].PIS.Vpis;
            PIS.qBCProd:= Self.Det.Items[I].PIS.Qbcprod;
            PIS.vAliqProd:= Self.Det.Items[I].PIS.Valiqprod;
          end;

          if Assigned(Self.Det.Items[I].COFINS) and (StrToIntDef(Self.Det.Items[I].COFINS.Cst, 0) >= 1) then
          begin
            COFINS.CST:= StrToCSTCOFINS(Ok, Self.Det.Items[I].COFINS.Cst);
            COFINS.vBC:= Self.Det.Items[I].COFINS.Vbc;
            COFINS.pCOFINS:= Self.Det.Items[I].COFINS.Pcofins;
            COFINS.vCOFINS:= Self.Det.Items[I].COFINS.Vcofins;
            COFINS.vBCProd:= Self.Det.Items[I].COFINS.Vbcprod;
            COFINS.vAliqProd:= Self.Det.Items[I].COFINS.Valiqprod;
            COFINS.qBCProd:= Self.Det.Items[I].COFINS.Qbcprod;
          end;
        end;
      end;

      vACBrNF.NotasFiscais.Items[0].NFe.Transp.modFrete:= StrTomodFrete(Ok, '9');

      with vACBrNF.NotasFiscais.Items[0].NFe do
      begin
        Total.ICMSTot.vBC:= Self.ICMSTot.Vbc;
        Total.ICMSTot.vICMS:= Self.ICMSTot.Vicms;
        Total.ICMSTot.vICMSDeson:= Self.ICMSTot.Vicmsdeson;
        Total.ICMSTot.vFCPUFDest:= Self.ICMSTot.Vfcpufdest;
        Total.ICMSTot.vICMSUFDest:= Self.ICMSTot.Vicmsufdest;
        Total.ICMSTot.vICMSUFRemet:= Self.ICMSTot.Vicmsufremet;
        Total.ICMSTot.vFCP:= Self.ICMSTot.Vfcp;
        Total.ICMSTot.vBCST:= Self.ICMSTot.Vbcst;
        Total.ICMSTot.vST:= Self.ICMSTot.Vst;
        Total.ICMSTot.vFCPST:= Self.ICMSTot.Vfcpst;
        Total.ICMSTot.vFCPSTRet:= Self.ICMSTot.Vfcpstret;
        Total.ICMSTot.vProd:= Self.ICMSTot.Vprod;
        Total.ICMSTot.vFrete:= Self.ICMSTot.Vfrete;
        Total.ICMSTot.vSeg:= Self.ICMSTot.Vseg;
        Total.ICMSTot.vDesc:= Self.ICMSTot.Vdesc;
        Total.ICMSTot.vII:= Self.ICMSTot.Vii;
        Total.ICMSTot.vIPI:= Self.ICMSTot.Vipi;
        Total.ICMSTot.vIPIDevol:= Self.ICMSTot.Vipidevol;
        Total.ICMSTot.vPIS:= Self.ICMSTot.Vpis;
        Total.ICMSTot.vCOFINS:= Self.ICMSTot.Vcofins;
        Total.ICMSTot.vOutro:= Self.ICMSTot.Voutro;
        Total.ICMSTot.vNF:= Self.ICMSTot.Vnf;
        Total.ICMSTot.vTotTrib:= Self.ICMSTot.Vtottrib;
      end;

      for I:= 0 to Pred(Self.Pag.Count) do
      begin
        with vACBrNF.NotasFiscais.Items[0].NFe.pag do
        begin
          with Add() do
          begin
            tPag:= StrToFormaPagamento(Ok,Self.Pag.Items[I].Tpag);
            case vACBrNF.Configuracoes.Geral.VersaoDF of
              ve400: vPag:= Self.Pag.Items[I].Vpag;
              else vPag:= (Self.Pag.Items[I].Vpag - Self.Pag.Items[I].Vtroco);
            end;
            tpIntegra:= StrTotpIntegra(Ok, Self.Pag.Items[I].Tpintegra);
            CNPJ:= Self.Pag.Items[I].Cnpj;
            tBand:= StrToBandeiraCartao(Ok, Self.Pag.Items[I].Tband);
            cAut:= Self.Pag.Items[I].Caut;
          end;
          vTroco:= (vTroco + Self.Pag.Items[I].Vtroco);
        end;
      end;

      vACBrNF.NotasFiscais.Assinar;
      vACBrNF.NotasFiscais.Validar;

      if not vACBrNF.NotasFiscais.ValidarRegrasdeNegocios(vRegras) then
        raise Exception.Create(vRegras);

      vACBrNF.NotasFiscais.GerarNFe;
      Self.Nunlote:= FormatDateTime('yyyymmddhhmmss', Now);
      Self.gravarXML(Self.Id, vACBrNF.NotasFiscais.Items[0].XML);
      Self.Chnfe:= Copy(vACBrNF.NotasFiscais.Items[0].NFe.infNFe.ID, 4);
      Self.Cstat:= IfThen((StrToIntDef(Self.Tpemis, 1) in[2,9]), 99, 0);
      Self.Nunlote:= IfThen(Self.Cstat = 0, Self.Nunlote, '');
      Self.save();

      if (Self.Cstat = 99) then
      begin
        case pPrint of
          0: Self.imprimir(Self.Id);
          1: begin
            if THelper.Mensagem('Nota fiscal emitida em contingência. Deseja imprimir?', 1) then
              Self.imprimir(Self.Id);
          end;
        end;

        Exit();
      end;

      vSincrono:= (Self.Modelo = '65');
      if vACBrNF.Enviar(Self.Nunlote, False, vSincrono) then
      begin
        vCstatus:= vACBrNF.NotasFiscais.Items[0].NFe.procNFe.cStat;

        if THelper.ValueIn(vCstatus, [100, 150, 110, 301, 302]) then
        begin
          Self.Cdv:= vACBrNF.NotasFiscais.Items[0].NFe.Ide.cDV;
          Self.Demi:= vACBrNF.NotasFiscais.Items[0].NFe.Ide.dEmi;
          Self.Dsaient:= vACBrNF.NotasFiscais.Items[0].NFe.Ide.dSaiEnt;

          Self.Chnfe:= vACBrNF.NotasFiscais.Items[0].NFe.procNFe.chNFe;
          Self.Nprot:= vACBrNF.NotasFiscais.Items[0].NFe.procNFe.nProt;
          Self.Cstat:= vACBrNF.NotasFiscais.Items[0].NFe.procNFe.cStat;
          Self.save();

          Self.GravarXML(Self.Id, vACBrNF.NotasFiscais.Items[0].XML);

          case vCstatus of
            100, 150: begin
              case pPrint of
                0: Self.imprimir(Self.Id);
                1: begin
                  if THelper.Mensagem('Nota fiscal autorizada. Deseja imprimir?', 1) then
                    Self.imprimir(Self.Id);
                end;
              end;
            end;
            110, 301, 302: begin
              case vCstatus of
                110: vMsgMotivoDenegacao := '110 - Nota fiscal denegada.';
                301: vMsgMotivoDenegacao := '301 - Irregularidade fiscal do emitente.';
                302: vMsgMotivoDenegacao := '302 - Irregularidade fiscal do destinatário.';
              end;

              THelper.Mensagem(vMsgMotivoDenegacao);
            end;
          end;
        end
        else
        begin
          raise Exception.Create(
            Format('Número: %9.9d    Série: %3.3d    Data: %s    ', [
               vACBrNF.NotasFiscais.Items[0].NFe.Ide.nNF,
               vACBrNF.NotasFiscais.Items[0].NFe.Ide.serie,
               FormatDateTime('dd/mm/yyyy', vACBrNF.NotasFiscais.Items[0].NFe.Ide.dEmi)
            ]) + String(vACBrNF.NotasFiscais.Items[0].Msg));
        end;
      end;
    except on e: exception do
      begin
        if (vACBrNF.WebServices.Enviar.cStat > 0) then
        begin
          Self.Nunlote:= '';
          atualizaNumeroDoLote();
        end;

        raise Exception.Create(e.Message);
      end;
    end;
  finally
    FreeAndNil(vACBrNF);
  end;
end;

class procedure TNfe.enviarEmail(NfeId: string);
var
  vNota: TACBrNFe;
  vNfe: TNfe;
  vMensagem: TStringList;
begin
  try
    vNota:= TACBrNFe.Create(nil);
    vNota.DANFE:= TACBrNFeDANFeRL.Create(nil);
    vNota.MAIL:= TACBrMail.Create(nil);
    TNfe.configurar(vNota);
    vMensagem:= nil;

    vNota.MAIL.Host:= 'mail.wtsystem.com.br';
    vNota.MAIL.Port:= '465';
    vNota.MAIL.Username:= 'nfe@wtsystem.com.br';
    vNota.MAIL.Password:= 'wtnfe115816';
    vNota.MAIL.From:= 'nfe@wtsystem.com.br';
    vNota.MAIL.SetSSL:= True;
    vNota.MAIL.SetTLS:= True;
    vNota.MAIL.ReadingConfirmation:= False;
    vNota.MAIL.UseThread:= False;

    vNfe:= TNfe.find(NfeId);
    if not Assigned(vNfe) then
      raise Exception.Create('Falha ao carregar os dados da nota fiscal.');

    if (Trim(vNfe.Participante.Email) = EmptyStr) then
      raise Exception.Create('Destinatário sem email cadastrado.');

    vNota.MAIL.FromName:= 'WT-SYSTEM / ' + vNfe.Empresa.Nome;
    vMensagem:= TStringList.Create;
    vMensagem.Add(vNfe.Empresa.Nome + ': Segue anexo nota fiscal emitida.');
    vMensagem.Add('');
    vMensagem.Add('Atenciosamente WT-SYSTEM');

    try
      vNota.NotasFiscais.LoadFromString(TNfe.consultaXML(NfeId));

      vNota.NotasFiscais.Items[0].EnviarEmail(
        vNfe.Participante.Email,
        'Nota fiscal',
        vMensagem);

      THelper.Mensagem('Email enviado com sucesso.');
    except on e: exception do
      raise Exception.Create(e.Message);
    end;
  finally
    FreeAndNil(vMensagem);
    vNota.MAIL.Free;
    vNota.DANFE.Free;
    FreeAndNil(vNota);
    FreeAndNil(vNfe);
  end;
end;

class procedure TNfe.exportarXML(NfeId, Path: string);
var
  vNota: TACBrNFe;
  vNfe: TNfe;
begin
  try
    try
      vNota:= TACBrNFe.Create(nil);
      vNfe:= TNfe.find(NfeId);
      if (Trim(Path) = EmptyStr) then
      begin
        Path:= '';
        if SelectDirectory(Path, [sdAllowCreate, sdPerformCreate, sdPrompt],1000) then
        begin
          vNota.NotasFiscais.LoadFromString(TNfe.consultaXML(NfeId));
          vNota.NotasFiscais.Items[0].GravarXML(vNfe.Chnfe + '-nfe.xml', Path);
          THelper.Mensagem('O XML foi exportado com sucesso. Local: ' + Path);
        end
        else Exit();
      end
      else
      begin
        vNota.NotasFiscais.LoadFromString(TNfe.consultaXML(NfeId));
        vNota.NotasFiscais.Items[0].GravarXML(vNfe.Chnfe + '-nfe.xml', Path);
      end;
    except on e: exception do
      raise Exception.Create(e.Message);
    end;
  finally
    if Assigned(vNota) then FreeAndNil(vNota);
    if Assigned(vNfe) then FreeAndNil(vNfe);
  end;
end;

class function TNfe.find(id: string): TNfe;
const
  FSql: string = 'SELECT * FROM NFES WHERE (ID = :ID)';
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
        Result:= TNfe.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.ParticipanteId:= FDQuery.FieldByName('PARTICIPANTE_ID').AsString;
        Result.OperacaoFiscalId:= FDQuery.FieldByName('OPERACAO_FISCAL_ID').AsString;
        Result.NfeInfcplId:= FDQuery.FieldByName('NFE_INFCPL_ID').AsString;
        Result.NfeInfadfiscoId:= FDQuery.FieldByName('NFE_INFADFISCO_ID').AsString;
        Result.Cuf:= FDQuery.FieldByName('CUF').AsString;
        Result.Cnf:= FDQuery.FieldByName('CNF').AsString;
        Result.Natop:= FDQuery.FieldByName('NATOP').AsString;
        Result.Indpag:= FDQuery.FieldByName('INDPAG').AsString;
        Result.Modelo:= FDQuery.FieldByName('MODELO').AsString;
        Result.Serie:= FDQuery.FieldByName('SERIE').AsInteger;
        Result.Nnf:= FDQuery.FieldByName('NNF').AsInteger;
        Result.Demi:= FDQuery.FieldByName('DEMI').AsDateTime;
        Result.Dsaient:= FDQuery.FieldByName('DSAIENT').AsDateTime;
        Result.Tpnf:= FDQuery.FieldByName('TPNF').AsString;
        Result.TpnfWt:= FDQuery.FieldByName('TPNF_WT').AsInteger;
        Result.Iddest:= FDQuery.FieldByName('IDDEST').AsString;
        Result.Cmunfg:= FDQuery.FieldByName('CMUNFG').AsString;
        Result.Tpimp:= FDQuery.FieldByName('TPIMP').AsString;
        Result.Tpemis:= FDQuery.FieldByName('TPEMIS').AsString;
        Result.Cdv:= FDQuery.FieldByName('CDV').AsInteger;
        Result.Tpamb:= FDQuery.FieldByName('TPAMB').AsString;
        Result.Finnfe:= FDQuery.FieldByName('FINNFE').AsString;
        Result.Indfinal:= FDQuery.FieldByName('INDFINAL').AsString;
        Result.Indpres:= FDQuery.FieldByName('INDPRES').AsString;
        Result.Procemi:= FDQuery.FieldByName('PROCEMI').AsString;
        Result.Dhcont:= FDQuery.FieldByName('DHCONT').AsDateTime;
        Result.Xjust:= FDQuery.FieldByName('XJUST').AsString;
        Result.Qrcode:= FDQuery.FieldByName('QRCODE').AsString;
        Result.Chnfe:= FDQuery.FieldByName('CHNFE').AsString;
        Result.Nprot:= FDQuery.FieldByName('NPROT').AsString;
        Result.Cstat:= FDQuery.FieldByName('CSTAT').AsInteger;
        Result.Nseqevento:= FDQuery.FieldByName('NSEQEVENTO').AsInteger;
        Result.Nsu:= FDQuery.FieldByName('NSU').AsInteger;
        Result.Nferecebida:= FDQuery.FieldByName('NFERECEBIDA').AsInteger;
        Result.Nunlote:= FDQuery.FieldByName('NUNLOTE').AsString;
        Result.AutoCalculo:= FDQuery.FieldByName('AUTO_CALCULO').AsString;
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

class function TNfe.findByChnfe(Chnfe: string): TNfe;
const
  FSql: string = 'SELECT ID FROM NFES WHERE (CHNFE = :CHNFE)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('CHNFE').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('CHNFE').AsString:= Chnfe;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
        Result:= TNfe.find(FDQuery.FieldByName('ID').AsString);
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TNfe.findByMovimento(MovimentoId: string): TObjectList<TNfe>;
const
  FSql: string =
  'SELECT ID FROM NFES ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (MOVIMENTO_ID = :MOVIMENTO_ID) ' +
  'AND (DELETED_AT IS NULL) ' +
  'ORDER BY NNF ASC';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('MOVIMENTO_ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Params.ParamByName('MOVIMENTO_ID').AsString:= MovimentoId;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TObjectList<TNfe>.Create;
        FDQuery.First();
        while not FDQuery.Eof do
        begin
          Result.Add(TNfe.find(FDQuery.FieldByName('ID').AsString));
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

function TNfe.getDet: TObjectList<TNfeDet>;
begin
  if not Assigned(Self.FDET) and (Self.Id <> EmptyStr) then
    Self.FDET:= TNfeDet.findByNfeId(Self.Id);

  if not Assigned(Self.FDET) then
    Self.FDET:= TObjectList<TNfeDet>.Create();

  Result:= Self.FDET;
end;

function TNfe.getEmpresa: TEmpresa;
begin
  if not Assigned(Self.FEMPRESA) then
    Self.FEMPRESA:= TEmpresa.find(Self.FEMPRESA_ID)
  else if Self.FEMPRESA.Id <> Self.FEMPRESA_ID then
  begin
    FreeAndNil(FEMPRESA);
    Self.FEMPRESA:= TEmpresa.find(Self.FEMPRESA_ID)
  end;
  Result:= Self.FEMPRESA;
end;

function TNfe.getICMSTot: TNfeTotalIcms;
begin
  if not Assigned(Self.FICMSTOT) and (Self.Id <> EmptyStr) then
    Self.FICMSTOT:= TNfeTotalIcms.findByNfeId(Self.Id);

  if not Assigned(Self.FICMSTOT) then
    Self.FICMSTOT:= TNfeTotalIcms.Create;

  Result:= Self.FICMSTOT;
end;

function TNfe.getNfeNumero(): Integer;
begin
  TAuthService.Terminal.NfceNumero:= (TAuthService.Terminal.NfceNumero + 1);
  TAuthService.Terminal.save();
  Result:= TAuthService.Terminal.NfceNumero;
end;

function TNfe.getPag: TObjectList<TNfePag>;
begin
  if not Assigned(Self.FPAG) and (Self.Id <> EmptyStr) then
    Self.FPAG:= TNfePag.findByNfeId(Self.Id);

  if not Assigned(Self.FPAG) then
    Self.FPAG:= TObjectList<TNfePag>.Create();

  Result:= Self.FPAG;
end;

function TNfe.getParticipante: TPessoa;
begin
  if not Assigned(Self.FPARTICIPANTE) then
    Self.FPARTICIPANTE:= TPessoa.find(Self.FPARTICIPANTE_ID)
  else if Self.FPARTICIPANTE.Id <> Self.FPARTICIPANTE_ID then
  begin
    FreeAndNil(FPARTICIPANTE);
    Self.FPARTICIPANTE:= TPessoa.find(Self.FPARTICIPANTE_ID);
  end;
  Result:= Self.FPARTICIPANTE;
end;

class procedure TNfe.gravarXML(NfeId, XML: string);
const
  FSql: string = 'UPDATE NFES SET XML = :XML WHERE ID = :ID';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('XML').DataType:= ftString;
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('XML').AsString:= XML;
      FDQuery.Params.ParamByName('ID').AsString:= NfeId;
      FDQuery.ExecSQL();
    except on e: Exception do
      raise Exception.Create('falha ao gravar a XML. erro: ' + e.Message);
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class procedure TNfe.imprimir(NfeId: string; vtype: Integer);
const
  FSql: string =
  'SELECT                   ' +
  ' MODELO,                 ' +
  ' XML,                    ' +
  ' XML_CORRECAO            ' +
  'FROM NFES WHERE ID = :ID ';
var
  FDQuery: TFDQuery;
  vACBrNF: TACBrNFe;
begin
  try
    FDQuery:= Self.createQuery;
    vACBrNF:= TACBrNFe.Create(nil);
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('ID').AsString:= NfeId;
      FDQuery.Open;
      if (FDQuery.RecordCount = 0) then Exit()
      else
      begin
        Self.configurar(vACBrNF);
        with vACBrNF do
        begin
          DANFE:= TACBrNFeDANFeESCPOS.Create(vACBrNF);
          TACBrNFeDANFeESCPOS(DANFE).PosPrinter:= TACBrPosPrinter.Create(DANFE);
          NotasFiscais.LoadFromString(FDQuery.FieldByName('XML').AsString);
          TACBrNFeDANFeESCPOS(DANFE).PosPrinter.ControlePorta:= True;
          case TAuthService.Terminal.NfcePrinterModel of
            0: TACBrNFeDANFeESCPOS(DANFE).PosPrinter.Modelo:= ppTexto;
            1: TACBrNFeDANFeESCPOS(DANFE).PosPrinter.Modelo:= ppEscPosEpson;
            2: TACBrNFeDANFeESCPOS(DANFE).PosPrinter.Modelo:= ppEscBematech;
            3: TACBrNFeDANFeESCPOS(DANFE).PosPrinter.Modelo:= ppEscDaruma;
            4: TACBrNFeDANFeESCPOS(DANFE).PosPrinter.Modelo:= ppEscVox;
            5: TACBrNFeDANFeESCPOS(DANFE).PosPrinter.Modelo:= ppEscDiebold;
          end;
          TACBrNFeDANFeESCPOS(DANFE).PosPrinter.Porta:= TAuthService.Terminal.NfcePrintPath;
          NotasFiscais.Items[0].Imprimir;
        end;
      end;
    except on e: Exception do
      raise Exception.Create('Falha ao imprimir. Erro: ' + e.Message);
    end;
  finally
    FreeAndNil(vACBrNF);
    FreeAndNil(FDQuery);
  end;
end;

class procedure TNfe.inutilizar(NfeId: string);
const
  FSql: string =
  'UPDATE NFES SET ' +
  'CSTAT = :CSTAT  ' +
  'WHERE ID = :ID  ';
var
  FDQuery: TFDQuery;
  vNfe: TNfe;
  vACBrNF: TACBrNFe;
  vJustificativa: string;
  vCstatus: Integer;
begin
  try
    FDQuery:= Self.createQuery;
    vACBrNF:= TACBrNFe.Create(nil);
    try
      vNfe:= TNfe.find(NfeId);
      if not Assigned(vNfe) then
        raise Exception.Create('Falha ao consultar os dados da nota fiscal.');

      Self.configurar(vACBrNF);

      if (TAuthService.Description = EmptyStr) then
        vJustificativa:= 'Nota fiscal preenchida de forma incorreta.'
      else
        vJustificativa:= TAuthService.Description;

      try
        vACBrNF.WebServices.Inutiliza(
          vNfe.Empresa.Documento,
          vJustificativa,
          StrToInt(FormatDateTime('yyyy', Now)),
          StrToIntDef(vNfe.Modelo, 0),
          vNfe.Serie,
          vNfe.Nnf,
          vNfe.Nnf
        );
      except on e: Exception do
        begin
          vCstatus:= vACBrNF.WebServices.Inutilizacao.cStat;
          if (vCstatus = 0) then
            raise Exception.Create(e.Message);
        end;
      end;

      vCstatus:= vACBrNF.WebServices.Inutilizacao.cStat;

      if THelper.ValueIn(vCstatus, [102,256,563]) then
      begin
        FDQuery.Close();
        FDQuery.SQL.Clear();
        FDQuery.SQL.Add(FSql);
        FDQuery.Params.ParamByName('CSTAT').DataType:= ftInteger;
        FDQuery.Params.ParamByName('ID').DataType:= ftString;
        FDQuery.Prepare();
        FDQuery.Params.ParamByName('CSTAT').AsInteger:= 102;
        FDQuery.Params.ParamByName('ID').AsString:= NfeId;
        FDQuery.ExecSQL();

        FDQuery.Close();
        FDQuery.SQL.Clear();
        FDQuery.SQL.Add('DELETE FROM NFE_VENDAS WHERE NFE_ID = :NFE_ID');
        FDQuery.Params.ParamByName('NFE_ID').DataType:= ftString;
        FDQuery.Prepare();
        FDQuery.Params.ParamByName('NFE_ID').AsString:= NfeId;
        FDQuery.ExecSQL();

        THelper.Mensagem('Nota fiscal inutilizada com sucesso.');
      end
      else
      begin
        raise Exception.CreateFmt(
          'Ocorreu o seguinte erro ao inutilizar: ' +
          ' Código: %d' +
          ' Motivo: %s', [
            vACBrNF.WebServices.Inutilizacao.cStat,
            vACBrNF.WebServices.Inutilizacao.xMotivo
        ]);
      end;
    except on e: Exception do
      raise Exception.Create(e.Message);
    end;
  finally
    FreeAndNil(FDQuery);
    FreeAndNil(vNfe);
    FreeAndNil(vACBrNF);
  end;
end;

class function TNfe.list(pSearch: string): TObjectList<TNfe>;
const
  FSql: string =
  'SELECT N.ID FROM NFES N ' +
  'JOIN PESSOAS P ON(P.ID = N.PARTICIPANTE_ID) ' +
  'WHERE (N.EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (N.MOVIMENTO_ID = :MOVIMENTO_ID) ' +
  'AND (N.DELETED_AT IS NULL) ' +
  'ORDER BY N.CREATED_AT DESC';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('MOVIMENTO_ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Params.ParamByName('MOVIMENTO_ID').AsString:= TAuthService.Terminal.Movimento.Id;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TObjectList<TNfe>.Create;
        FDQuery.First();
        while not FDQuery.Eof do
        begin
          Result.Add(TNfe.find(FDQuery.FieldByName('ID').AsString));
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

class procedure TNfe.list(pSearch: string; pDt: TFDMemTable);
var
  vList: TObjectList<TNfe>;
  I: Integer;
begin
  pDt.Open();
  pDt.DisableControls();
  pDt.EmptyDataSet();
  vList:= TNfe.list(pSearch);
  if Assigned(vList) then
  begin
    for I:= 0 to Pred(vList.Count) do
    begin
      pDt.Append();
      pDt.FieldByName('ID').AsString:= vList.Items[I].Id;
      pDt.FieldByName('NNF').AsInteger:= vList.Items[I].Nnf;
      pDt.FieldByName('CHNFE').AsString:= vList.Items[I].Chnfe;
      pDt.FieldByName('PESSOA').AsString:= vList.Items[I].Participante.Nome;
      pDt.FieldByName('TOTAL').AsExtended:= vList.Items[I].ICMSTot.Vnf;
      pDt.FieldByName('CSTAT').AsInteger:= vList.Items[I].Cstat;
      pDt.FieldByName('CHECK').AsInteger:= 0;
      pDt.Post();
    end;
    FreeAndNil(vList);
  end;
  pDt.First();
  pDt.EnableControls();
end;

class procedure TNfe.loadxml(RetWS: String; MyWebBrowser: TWebBrowser);
begin
  ACBrUtil.WriteToTXT(PathWithDelim(ExtractFileDir(Application.ExeName)) + 'wtsystem.xml',
                        ACBrUtil.ConverteXMLtoUTF8(RetWS), False, False);
  MyWebBrowser.Navigate(PathWithDelim(ExtractFileDir(Application.ExeName)) + 'wtsystem.xml');
end;

procedure TNfe.processaCalculos;
var
  I: Integer;
begin
  Self.ICMSTot.Vbc:= 0;
  Self.ICMSTot.Vicms:= 0;
  Self.ICMSTot.Vicmsdeson:= 0;
  Self.ICMSTot.Vfcpufdest:= 0;
  Self.ICMSTot.Vicmsufdest:= 0;
  Self.ICMSTot.Vicmsufremet:= 0;
  Self.ICMSTot.Vfcp:= 0;
  Self.ICMSTot.Vbcst:= 0;
  Self.ICMSTot.Vst:= 0;
  Self.ICMSTot.Vfcpst:= 0;
  Self.ICMSTot.Vfcpstret:= 0;
  Self.ICMSTot.Vprod:= 0;
  Self.ICMSTot.Vfrete:= 0;
  Self.ICMSTot.Vseg:= 0;
  Self.ICMSTot.Vdesc:= 0;
  Self.ICMSTot.Vii:= 0;
  Self.ICMSTot.Vipi:= 0;
  Self.ICMSTot.Vipidevol:= 0;
  Self.ICMSTot.Vpis:= 0;
  Self.ICMSTot.Vcofins:= 0;
  Self.ICMSTot.Voutro:= 0;
  Self.ICMSTot.Vnf:= 0;
  Self.ICMSTot.Vtottrib:= 0;

  for I:= 0 to Pred(Self.Det.Count) do
  begin
    Self.Det.Items[I].Vtottrib:=
      TNcm.ncmToVtottrib(Self.Det.Items[I].Ncm, Self.Det.Items[I].Vprod);

    if (Self.AutoCalculo = 'S') then
      Self.Det.Items[I].processaCalculos();

    Self.ICMSTot.Vbc:= (Self.ICMSTot.Vbc + Self.Det.Items[I].ICMS.Vbc);
    Self.ICMSTot.Vicms:= (Self.ICMSTot.Vicms + Self.Det.Items[I].ICMS.Vicms);
    Self.ICMSTot.Vicmsdeson:= (Self.ICMSTot.Vicmsdeson + Self.Det.Items[I].ICMS.Vicmsdeson);
    Self.ICMSTot.Vfcpufdest:= 0;
    Self.ICMSTot.Vicmsufdest:= 0;
    Self.ICMSTot.Vicmsufremet:= 0;
    Self.ICMSTot.Vfcp:= (Self.ICMSTot.Vfcp + Self.Det.Items[I].ICMS.Vfcp);
    Self.ICMSTot.Vbcst:= (Self.ICMSTot.Vbcst + Self.Det.Items[I].ICMS.Vbcst);
    Self.ICMSTot.Vst:= (Self.ICMSTot.Vst + Self.Det.Items[I].ICMS.Vicmsst);
    Self.ICMSTot.Vfcpst:= (Self.ICMSTot.Vfcpst + Self.Det.Items[I].ICMS.Vfcpst);
    Self.ICMSTot.Vfcpstret:= (Self.ICMSTot.Vfcpstret + Self.Det.Items[I].ICMS.Vfcpstret);
    Self.ICMSTot.Vprod:= (Self.ICMSTot.Vprod + Self.Det.Items[I].Vprod);
    Self.ICMSTot.Vfrete:= (Self.ICMSTot.Vfrete + Self.Det.Items[I].Vfrete);
    Self.ICMSTot.Vseg:= (Self.ICMSTot.Vseg + Self.Det.Items[I].Vseg);
    Self.ICMSTot.Vdesc:= (Self.ICMSTot.Vdesc + Self.Det.Items[I].Vdesc);
    Self.ICMSTot.Vii:= 0;
    Self.ICMSTot.Vipi:= (Self.ICMSTot.Vipi + Self.Det.Items[I].IPI.Vipi);
    Self.ICMSTot.Vipidevol:= (Self.ICMSTot.Vipidevol + Self.Det.Items[I].Vipidevol);
    Self.ICMSTot.Vpis:= (Self.ICMSTot.Vpis + Self.Det.Items[I].PIS.Vpis);
    Self.ICMSTot.Vcofins:= (Self.ICMSTot.Vcofins + Self.Det.Items[I].COFINS.Vcofins);
    Self.ICMSTot.Voutro:= (Self.ICMSTot.Voutro + Self.Det.Items[I].Voutro);
    Self.ICMSTot.Vtottrib:= (Self.ICMSTot.Vtottrib + Self.Det.Items[I].Vtottrib);
  end;

  Self.ICMSTot.Vnf:=
    Self.ICMSTot.Vprod
    - Self.ICMSTot.Vdesc
    - Self.ICMSTot.Vicmsdeson
    + Self.ICMSTot.Vst
    + Self.ICMSTot.Vfcpst
    + Self.ICMSTot.Vfrete
    + Self.ICMSTot.Vseg
    + Self.ICMSTot.Voutro
    + Self.ICMSTot.Vii
    + Self.ICMSTot.Vipi
    + Self.ICMSTot.Vipidevol;
end;

function TNfe.save: Boolean;
begin
  Result:= inherited;
end;

function TNfe.store: Boolean;
const
  FSql: string =
  'INSERT INTO NFES (    ' +
  '  ID,                 ' +
  '  EMPRESA_ID,         ' +
  '  PARTICIPANTE_ID,    ' +
  '  OPERACAO_FISCAL_ID, ' +
  '  NFE_INFCPL_ID,      ' +
  '  NFE_INFADFISCO_ID,  ' +
  '  MOVIMENTO_ID,       ' +
  '  CUF,                ' +
  '  CNF,                ' +
  '  NATOP,              ' +
  '  INDPAG,             ' +
  '  MODELO,             ' +
  '  SERIE,              ' +
  '  NNF,                ' +
  '  DEMI,               ' +
  '  DSAIENT,            ' +
  '  TPNF,               ' +
  '  TPNF_WT,            ' +
  '  IDDEST,             ' +
  '  CMUNFG,             ' +
  '  TPIMP,              ' +
  '  TPEMIS,             ' +
  '  CDV,                ' +
  '  TPAMB,              ' +
  '  FINNFE,             ' +
  '  INDFINAL,           ' +
  '  INDPRES,            ' +
  '  PROCEMI,            ' +
  '  DHCONT,             ' +
  '  XJUST,              ' +
  '  QRCODE,             ' +
  '  CHNFE,              ' +
  '  NPROT,              ' +
  '  CSTAT,              ' +
  '  NSEQEVENTO,         ' +
  '  NSU,                ' +
  '  NFERECEBIDA,        ' +
  '  NUNLOTE,            ' +
  '  AUTO_CALCULO,       ' +
  '  CREATED_AT,         ' +
  '  UPDATED_AT)         ' +
  'VALUES (              ' +
  '  :ID,                ' +
  '  :EMPRESA_ID,        ' +
  '  :PARTICIPANTE_ID,   ' +
  '  :OPERACAO_FISCAL_ID,' +
  '  :NFE_INFCPL_ID,     ' +
  '  :NFE_INFADFISCO_ID, ' +
  '  :MOVIMENTO_ID,      ' +
  '  :CUF,               ' +
  '  :CNF,               ' +
  '  :NATOP,             ' +
  '  :INDPAG,            ' +
  '  :MODELO,            ' +
  '  :SERIE,             ' +
  '  :NNF,               ' +
  '  :DEMI,              ' +
  '  :DSAIENT,           ' +
  '  :TPNF,              ' +
  '  :TPNF_WT,           ' +
  '  :IDDEST,            ' +
  '  :CMUNFG,            ' +
  '  :TPIMP,             ' +
  '  :TPEMIS,            ' +
  '  :CDV,               ' +
  '  :TPAMB,             ' +
  '  :FINNFE,            ' +
  '  :INDFINAL,          ' +
  '  :INDPRES,           ' +
  '  :PROCEMI,           ' +
  '  :DHCONT,            ' +
  '  :XJUST,             ' +
  '  :QRCODE,            ' +
  '  :CHNFE,             ' +
  '  :NPROT,             ' +
  '  :CSTAT,             ' +
  '  :NSEQEVENTO,        ' +
  '  :NSU,               ' +
  '  :NFERECEBIDA,       ' +
  '  :NUNLOTE,           ' +
  '  :AUTO_CALCULO,      ' +
  '  :CREATED_AT,        ' +
  '  :UPDATED_AT)        ';
var
  FDQuery: TFDQuery;
  I: Integer;
begin
  Result:= True;
  try
    Self.StartTransaction;
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PARTICIPANTE_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('OPERACAO_FISCAL_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NFE_INFCPL_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NFE_INFADFISCO_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('MOVIMENTO_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('CUF').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CNF').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NATOP').DataType:= ftWideString;
      FDQuery.Params.ParamByName('INDPAG').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('MODELO').DataType:= ftString;
      FDQuery.Params.ParamByName('SERIE').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NNF').DataType:= ftInteger;
      FDQuery.Params.ParamByName('DEMI').DataType:= ftDate;
      FDQuery.Params.ParamByName('DSAIENT').DataType:= ftDate;
      FDQuery.Params.ParamByName('TPNF').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('TPNF_WT').DataType:= ftInteger;
      FDQuery.Params.ParamByName('IDDEST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CMUNFG').DataType:= ftWideString;
      FDQuery.Params.ParamByName('TPIMP').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('TPEMIS').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CDV').DataType:= ftInteger;
      FDQuery.Params.ParamByName('TPAMB').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('FINNFE').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('INDFINAL').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('INDPRES').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PROCEMI').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('DHCONT').DataType:= ftDate;
      FDQuery.Params.ParamByName('XJUST').DataType:= ftWideString;
      FDQuery.Params.ParamByName('QRCODE').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CHNFE').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NPROT').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CSTAT').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NSEQEVENTO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NSU').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NFERECEBIDA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NUNLOTE').DataType:= ftString;
      FDQuery.Params.ParamByName('AUTO_CALCULO').DataType:= ftString;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.Terminal.EmpresaId;
      Self.MovimentoId:= TAuthService.Terminal.Movimento.Id;

      if (Self.Nnf = 0) then
      begin
        Self.Nnf:= Self.getNfeNumero();
        Self.Cnf:= Self.Nnf.ToString();
      end;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      if (Self.ParticipanteId <> EmptyStr) then
      FDQuery.Params.ParamByName('PARTICIPANTE_ID').AsString:= Self.ParticipanteId;
      if (Self.OperacaoFiscalId <> EmptyStr) then
      FDQuery.Params.ParamByName('OPERACAO_FISCAL_ID').AsString:= Self.OperacaoFiscalId;
      if (Self.NfeInfcplId <> EmptyStr) then
      FDQuery.Params.ParamByName('NFE_INFCPL_ID').AsString:= Self.NfeInfcplId;
      if (Self.NfeInfadfiscoId <> EmptyStr) then
      FDQuery.Params.ParamByName('NFE_INFADFISCO_ID').AsString:= Self.NfeInfadfiscoId;
      FDQuery.Params.ParamByName('MOVIMENTO_ID').AsString:= Self.MovimentoId;
      if (Self.Cuf <> EmptyStr) then
      FDQuery.Params.ParamByName('CUF').AsString:= Self.Cuf;
      if (Self.Cnf <> EmptyStr) then
      FDQuery.Params.ParamByName('CNF').AsString:= Self.Cnf;
      if (Self.Natop <> EmptyStr) then
      FDQuery.Params.ParamByName('NATOP').AsString:= Self.Natop;
      if (Self.Indpag <> EmptyStr) then
      FDQuery.Params.ParamByName('INDPAG').AsString:= Self.Indpag;
      if (Self.Modelo <> EmptyStr) then
      FDQuery.Params.ParamByName('MODELO').AsString:= Self.Modelo;
      if (Self.Serie >= 0) then
      FDQuery.Params.ParamByName('SERIE').AsInteger:= Self.Serie;
      if (Self.Nnf > 0) then
      FDQuery.Params.ParamByName('NNF').AsInteger:= Self.Nnf;
      if (Self.Demi > 0) then
      FDQuery.Params.ParamByName('DEMI').AsDate:= Self.Demi;
      if (Self.Dsaient > 0) then
      FDQuery.Params.ParamByName('DSAIENT').AsDate:= Self.Dsaient;
      if (Self.Tpnf <> EmptyStr) then
      FDQuery.Params.ParamByName('TPNF').AsString:= Self.Tpnf;
      if (Self.TpnfWt >= 0) then
      FDQuery.Params.ParamByName('TPNF_WT').AsInteger:= Self.TpnfWt;
      if (Self.Iddest <> EmptyStr) then
      FDQuery.Params.ParamByName('IDDEST').AsString:= Self.Iddest;
      if (Self.Cmunfg <> EmptyStr) then
      FDQuery.Params.ParamByName('CMUNFG').AsString:= Self.Cmunfg;
      if (Self.Tpimp <> EmptyStr) then
      FDQuery.Params.ParamByName('TPIMP').AsString:= Self.Tpimp;
      if (Self.Tpemis <> EmptyStr) then
      FDQuery.Params.ParamByName('TPEMIS').AsString:= Self.Tpemis;
      if (Self.Cdv > 0) then
      FDQuery.Params.ParamByName('CDV').AsInteger:= Self.Cdv;
      if (Self.Tpamb <> EmptyStr) then
      FDQuery.Params.ParamByName('TPAMB').AsString:= Self.Tpamb;
      if (Self.Finnfe <> EmptyStr) then
      FDQuery.Params.ParamByName('FINNFE').AsString:= Self.Finnfe;
      if (Self.Indfinal <> EmptyStr) then
      FDQuery.Params.ParamByName('INDFINAL').AsString:= Self.Indfinal;
      if (Self.Indpres <> EmptyStr) then
      FDQuery.Params.ParamByName('INDPRES').AsString:= Self.Indpres;
      if (Self.Procemi <> EmptyStr) then
      FDQuery.Params.ParamByName('PROCEMI').AsString:= Self.Procemi;
      if (Self.Dhcont > 0) then
      FDQuery.Params.ParamByName('DHCONT').AsDate:= Self.Dhcont;
      if (Self.Xjust <> EmptyStr) then
      FDQuery.Params.ParamByName('XJUST').AsString:= Self.Xjust;
      if (Self.Qrcode <> EmptyStr) then
      FDQuery.Params.ParamByName('QRCODE').AsString:= Self.Qrcode;
      if (Self.Chnfe <> EmptyStr) then
      FDQuery.Params.ParamByName('CHNFE').AsString:= Self.Chnfe;
      if (Self.Nprot <> EmptyStr) then
      FDQuery.Params.ParamByName('NPROT').AsString:= Self.Nprot;
      if (Self.Cstat > 0) then
      FDQuery.Params.ParamByName('CSTAT').AsInteger:= Self.Cstat;
      if (Self.Nseqevento > 0) then
      FDQuery.Params.ParamByName('NSEQEVENTO').AsInteger:= Self.Nseqevento;
      if (Self.Nsu > 0) then
      FDQuery.Params.ParamByName('NSU').AsInteger:= Self.Nsu;
      if (Self.Nferecebida >= 0) then
      FDQuery.Params.ParamByName('NFERECEBIDA').AsInteger:= Self.Nferecebida;
      if (Self.Nunlote <> EmptyStr) then
      FDQuery.Params.ParamByName('NUNLOTE').AsString:= Self.Nunlote;
      FDQuery.Params.ParamByName('AUTO_CALCULO').AsString:= Self.AutoCalculo;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;

      for I:= 0 to Pred(Self.Det.Count) do
      begin
        Self.Det.Items[I].NfeId:= Self.Id;
        Self.Det.Items[I].save();
      end;

      if Assigned(Self.ICMSTot) then
      begin
        Self.ICMSTot.NfeId:= Self.Id;
        Self.ICMSTot.save();
      end;

      for I:= 0 to Pred(Self.Pag.Count) do
      begin
        Self.Pag.Items[I].NfeId:= Self.Id;
        Self.Pag.Items[I].save();
      end;

      if (TAuthService.lVendas <> EmptyStr) then
      begin
        FDQuery.SQL.Clear();
        FDQuery.SQL.Add('INSERT INTO NFE_VENDAS (NFE_ID, VENDA_ID) VALUES (:NFE_ID, :VENDA_ID)');
        FDQuery.Params.ParamByName('NFE_ID').DataType:= ftString;
        FDQuery.Params.ParamByName('VENDA_ID').DataType:= ftString;
        FDQuery.Prepare();
        FDQuery.Params.ParamByName('NFE_ID').AsString:= Self.Id;
        while not (TAuthService.lVendas = EmptyStr) do
        begin
          FDQuery.Params.ParamByName('VENDA_ID').AsString:=
            THelper.DevolveConteudoDelimitado('|', TAuthService.lVendas);

          FDQuery.ExecSQL();
        end;
      end;

      Self.Commit;
    except on e: Exception do
    begin
      Self.Rollback;
      Result:= False;
      raise Exception.Create('Falha ao gravar dados do NFC-e. Erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfe.update: Boolean;
const
  FSql: string =
  'UPDATE NFES                                  ' +
  'SET PARTICIPANTE_ID = :PARTICIPANTE_ID,      ' +
  '    OPERACAO_FISCAL_ID = :OPERACAO_FISCAL_ID,' +
  '    NFE_INFCPL_ID = :NFE_INFCPL_ID,          ' +
  '    NFE_INFADFISCO_ID = :NFE_INFADFISCO_ID,  ' +
  '    CUF = :CUF,                              ' +
  '    CNF = :CNF,                              ' +
  '    NATOP = :NATOP,                          ' +
  '    INDPAG = :INDPAG,                        ' +
  '    MODELO = :MODELO,                        ' +
  '    SERIE = :SERIE,                          ' +
  '    NNF = :NNF,                              ' +
  '    DEMI = :DEMI,                            ' +
  '    DSAIENT = :DSAIENT,                      ' +
  '    TPNF = :TPNF,                            ' +
  '    TPNF_WT = :TPNF_WT,                      ' +
  '    IDDEST = :IDDEST,                        ' +
  '    CMUNFG = :CMUNFG,                        ' +
  '    TPIMP = :TPIMP,                          ' +
  '    TPEMIS = :TPEMIS,                        ' +
  '    CDV = :CDV,                              ' +
  '    TPAMB = :TPAMB,                          ' +
  '    FINNFE = :FINNFE,                        ' +
  '    INDFINAL = :INDFINAL,                    ' +
  '    INDPRES = :INDPRES,                      ' +
  '    PROCEMI = :PROCEMI,                      ' +
  '    DHCONT = :DHCONT,                        ' +
  '    XJUST = :XJUST,                          ' +
  '    QRCODE = :QRCODE,                        ' +
  '    CHNFE = :CHNFE,                          ' +
  '    NPROT = :NPROT,                          ' +
  '    CSTAT = :CSTAT,                          ' +
  '    NSEQEVENTO = :NSEQEVENTO,                ' +
  '    NSU = :NSU,                              ' +
  '    NFERECEBIDA = :NFERECEBIDA,              ' +
  '    NUNLOTE = :NUNLOTE,                      ' +
  '    AUTO_CALCULO = :AUTO_CALCULO,            ' +
  '    UPDATED_AT = :UPDATED_AT,                ' +
  '    SYNCHRONIZED = :SYNCHRONIZED             ' +
  'WHERE (ID = :ID)                             ';
var
  FDQuery: TFDQuery;
  I: Integer;
begin
  Result:= True;
  try
    Self.StartTransaction;
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PARTICIPANTE_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('OPERACAO_FISCAL_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NFE_INFCPL_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NFE_INFADFISCO_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CUF').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CNF').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NATOP').DataType:= ftWideString;
      FDQuery.Params.ParamByName('INDPAG').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('MODELO').DataType:= ftString;
      FDQuery.Params.ParamByName('SERIE').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NNF').DataType:= ftInteger;
      FDQuery.Params.ParamByName('DEMI').DataType:= ftDate;
      FDQuery.Params.ParamByName('DSAIENT').DataType:= ftDate;
      FDQuery.Params.ParamByName('TPNF').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('TPNF_WT').DataType:= ftInteger;
      FDQuery.Params.ParamByName('IDDEST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CMUNFG').DataType:= ftWideString;
      FDQuery.Params.ParamByName('TPIMP').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('TPEMIS').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CDV').DataType:= ftInteger;
      FDQuery.Params.ParamByName('TPAMB').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('FINNFE').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('INDFINAL').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('INDPRES').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PROCEMI').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('DHCONT').DataType:= ftDate;
      FDQuery.Params.ParamByName('XJUST').DataType:= ftWideString;
      FDQuery.Params.ParamByName('QRCODE').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CHNFE').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NPROT').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CSTAT').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NSEQEVENTO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NSU').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NFERECEBIDA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NUNLOTE').DataType:= ftString;
      FDQuery.Params.ParamByName('AUTO_CALCULO').DataType:= ftString;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.ParticipanteId <> EmptyStr) then
      FDQuery.Params.ParamByName('PARTICIPANTE_ID').AsString:= Self.ParticipanteId;
      if (Self.OperacaoFiscalId <> EmptyStr) then
      FDQuery.Params.ParamByName('OPERACAO_FISCAL_ID').AsString:= Self.OperacaoFiscalId;
      if (Self.NfeInfcplId <> EmptyStr) then
      FDQuery.Params.ParamByName('NFE_INFCPL_ID').AsString:= Self.NfeInfcplId;
      if (Self.NfeInfadfiscoId <> EmptyStr) then
      FDQuery.Params.ParamByName('NFE_INFADFISCO_ID').AsString:= Self.NfeInfadfiscoId;
      if (Self.Cuf <> EmptyStr) then
      FDQuery.Params.ParamByName('CUF').AsString:= Self.Cuf;
      if (Self.Cnf <> EmptyStr) then
      FDQuery.Params.ParamByName('CNF').AsString:= Self.Cnf;
      if (Self.Natop <> EmptyStr) then
      FDQuery.Params.ParamByName('NATOP').AsString:= Self.Natop;
      if (Self.Indpag <> EmptyStr) then
      FDQuery.Params.ParamByName('INDPAG').AsString:= Self.Indpag;
      if (Self.Modelo <> EmptyStr) then
      FDQuery.Params.ParamByName('MODELO').AsString:= Self.Modelo;
      if (Self.Serie >= 0) then
      FDQuery.Params.ParamByName('SERIE').AsInteger:= Self.Serie;
      if (Self.Nnf > 0) then
      FDQuery.Params.ParamByName('NNF').AsInteger:= Self.Nnf;
      if (Self.Demi > 0) then
      FDQuery.Params.ParamByName('DEMI').AsDate:= Self.Demi;
      if (Self.Dsaient > 0) then
      FDQuery.Params.ParamByName('DSAIENT').AsDate:= Self.Dsaient;
      if (Self.Tpnf <> EmptyStr) then
      FDQuery.Params.ParamByName('TPNF').AsString:= Self.Tpnf;
      if (Self.TpnfWt >= 0) then
      FDQuery.Params.ParamByName('TPNF_WT').AsInteger:= Self.TpnfWt;
      if (Self.Iddest <> EmptyStr) then
      FDQuery.Params.ParamByName('IDDEST').AsString:= Self.Iddest;
      if (Self.Cmunfg <> EmptyStr) then
      FDQuery.Params.ParamByName('CMUNFG').AsString:= Self.Cmunfg;
      if (Self.Tpimp <> EmptyStr) then
      FDQuery.Params.ParamByName('TPIMP').AsString:= Self.Tpimp;
      if (Self.Tpemis <> EmptyStr) then
      FDQuery.Params.ParamByName('TPEMIS').AsString:= Self.Tpemis;
      if (Self.Cdv >= 0) then
      FDQuery.Params.ParamByName('CDV').AsInteger:= Self.Cdv;
      if (Self.Tpamb <> EmptyStr) then
      FDQuery.Params.ParamByName('TPAMB').AsString:= Self.Tpamb;
      if (Self.Finnfe <> EmptyStr) then
      FDQuery.Params.ParamByName('FINNFE').AsString:= Self.Finnfe;
      if (Self.Indfinal <> EmptyStr) then
      FDQuery.Params.ParamByName('INDFINAL').AsString:= Self.Indfinal;
      if (Self.Indpres <> EmptyStr) then
      FDQuery.Params.ParamByName('INDPRES').AsString:= Self.Indpres;
      if (Self.Procemi <> EmptyStr) then
      FDQuery.Params.ParamByName('PROCEMI').AsString:= Self.Procemi;
      if (Self.Dhcont > 0) then
      FDQuery.Params.ParamByName('DHCONT').AsDate:= Self.Dhcont;
      if (Self.Xjust <> EmptyStr) then
      FDQuery.Params.ParamByName('XJUST').AsString:= Self.Xjust;
      if (Self.Qrcode <> EmptyStr) then
      FDQuery.Params.ParamByName('QRCODE').AsString:= Self.Qrcode;
      if (Self.Chnfe <> EmptyStr) then
      FDQuery.Params.ParamByName('CHNFE').AsString:= Self.Chnfe;
      if (Self.Nprot <> EmptyStr) then
      FDQuery.Params.ParamByName('NPROT').AsString:= Self.Nprot;
      if (Self.Cstat > 0) then
      FDQuery.Params.ParamByName('CSTAT').AsInteger:= Self.Cstat;
      if (Self.Nseqevento > 0) then
      FDQuery.Params.ParamByName('NSEQEVENTO').AsInteger:= Self.Nseqevento;
      if (Self.Nsu > 0) then
      FDQuery.Params.ParamByName('NSU').AsInteger:= Self.Nsu;
      if (Self.Nferecebida >= 0) then
      FDQuery.Params.ParamByName('NFERECEBIDA').AsInteger:= Self.Nferecebida;
      if (Self.Nunlote <> EmptyStr) then
      FDQuery.Params.ParamByName('NUNLOTE').AsString:= Self.Nunlote;
      FDQuery.Params.ParamByName('AUTO_CALCULO').AsString:= Self.AutoCalculo;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;

      for I:= 0 to Pred(Self.Det.Count) do
      begin
        Self.Det.Items[I].NfeId:= Self.Id;
        Self.Det.Items[I].save();
      end;

      if Assigned(Self.ICMSTot) then
      begin
        Self.ICMSTot.NfeId:= Self.Id;
        Self.ICMSTot.save();
      end;

      if (Self.Pag.Count >= 1) then
        if (Self.Pag.First.Id = EmptyStr) then
        begin
          TNfePag.removeByNfeId(Self.Id);

          for I:= 0 to Pred(Self.Pag.Count) do
          begin
            Self.Pag.Items[I].NfeId:= Self.Id;
            Self.Pag.Items[I].save();
          end;
        end;

      Self.Commit;
    except on e: Exception do
    begin
      Self.Rollback;
      Result:= False;
      raise Exception.Create('Falha ao gravar dados do NFC-e. Erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfe.vendaId: string;
const
  FSql: string = 'SELECT VENDA_ID FROM NFE_VENDAS WHERE (NFE_ID = :NFE_ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('NFE_ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('NFE_ID').AsString:= Self.Id;
      FDQuery.Open();

      Result:= FDQuery.FieldByName('VENDA_ID').AsString;
    except
      Result:= '';
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TNfe.vendaToNFCe(VendaId: string): string;
var
  venda: TVenda;
  nfe: TNfe;
  I: Integer;
begin
  Result:= EmptyStr;
  try
    try
      nfe:= nil;
      venda:= TVenda.find(VendaId);
      if not Assigned(venda) then
        raise Exception.Create('Venda não encontrada.');

      nfe:= TNfe.Create;
      nfe.EmpresaId:= TAuthService.Terminal.EmpresaId;
      nfe.ParticipanteId:= venda.PessoaId;
      nfe.Cuf:= nfe.Empresa.Uf;
      nfe.OperacaoFiscalId:= TAuthService.Terminal.NfceOperacaoFiscalId;
      nfe.Natop:= TAuthService.Terminal.NfceNatop;
      nfe.Indpag:= '0';
      nfe.Modelo:= '65';
      nfe.Serie:= TAuthService.Terminal.NfceSerie;
      nfe.Demi:= Now;
      nfe.Tpnf:= '1';
      nfe.TpnfWt:= 1;
      nfe.Iddest:= '1';
      nfe.Cmunfg:= nfe.Empresa.CodigoMunicipio;
      nfe.Tpimp:= '4';
      case AnsiIndexStr(nfe.Empresa.NfeConfiguracao.FormaEmissaoCodigo,['1', '2']) of
        1: begin
          nfe.Tpemis:= '9';
          nfe.Dhcont:= Now;
          nfe.Xjust:= 'SEM ACESSO A INTERNET.';
        end;
        else nfe.Tpemis:= '1';
      end;
      nfe.Tpamb:= nfe.Empresa.NfeConfiguracao.AmbienteCodigo;
      nfe.Finnfe:= '1';
      nfe.Indfinal:= '1';
      nfe.Indpres:= '1';
      nfe.Procemi:= '0';
      nfe.AutoCalculo:= 'S';

      for I:= 0 to Pred(venda.Itens.Count) do
      begin
        nfe.Det.Add(TNfeDet.Create);
        nfe.Det.Last.ItemId:= venda.Itens.Items[I].ItemId;
        nfe.Det.Last.Cprod:= nfe.Det.Last.ITEM.Referencia.ToString();
        nfe.Det.Last.Nitem:= (I + 1);
        nfe.Det.Last.Cean:= nfe.Det.Last.ITEM.Ean;
        nfe.Det.Last.Xprod:= nfe.Det.Last.ITEM.Nome;
        nfe.Det.Last.Ncm:= nfe.Det.Last.ITEM.Ncm;
        nfe.Det.Last.Extipi:= nfe.Det.Last.ITEM.Extipi;
        nfe.Det.Last.Ucom:= nfe.Det.Last.ITEM.Unidade;
        nfe.Det.Last.Qcom:= venda.Itens.Items[I].Qtde;
        nfe.Det.Last.Vuncom:= venda.Itens.Items[I].Unitario;
        nfe.Det.Last.Vprod:= venda.Itens.Items[I].Subtotal;
        nfe.Det.Last.Ceantrib:= nfe.Det.Last.ITEM.EanTributavel;
        nfe.Det.Last.Utrib:= nfe.Det.Last.ITEM.UnidadeTributavel;
        nfe.Det.Last.Qtrib:= venda.Itens.Items[I].Qtde;
        nfe.Det.Last.Vuntrib:= venda.Itens.Items[I].Unitario;
        nfe.Det.Last.Vfrete:= 0;
        nfe.Det.Last.Vseg:= 0;
        nfe.Det.Last.Vdesc:= venda.Itens.Items[I].Desconto;
        nfe.Det.Last.Voutro:= venda.Itens.Items[I].Acrescimo;
        nfe.Det.Last.Indtot:= '1';
        nfe.Det.Last.Cest:= nfe.Det.Last.ITEM.Cest;
        nfe.Det.Last.Vtottrib:= 0;
        nfe.Det.Last.Pdevol:= 0;
        nfe.Det.Last.Vipidevol:= 0;

        nfe.Det.Last.ICMSCreate;
        nfe.Det.Last.Cfop:= nfe.Det.Last.ITEM.Cfop;
        nfe.Det.Last.ICMS.Orig:= nfe.Det.Last.ITEM.IcmsOrig;
        nfe.Det.Last.ICMS.Cst:= nfe.Det.Last.ITEM.IcmsCst;
        nfe.Det.Last.ICMS.Csosn:= nfe.Det.Last.ITEM.IcmsCsosn;

        nfe.Det.Last.IPICreate;
        nfe.Det.Last.IPI.Cst:= nfe.Det.Last.ITEM.IpiCst;

        nfe.Det.Last.PISCreate;
        nfe.Det.Last.PIS.Cst:= nfe.Det.Last.ITEM.PisCst;

        nfe.Det.Last.COFINSCreate;
        nfe.Det.Last.COFINS.Cst:= nfe.Det.Last.ITEM.CofinsCst;
      end;

      for I:= 0 to Pred(venda.Recebimentos.Count) do
      begin
        nfe.Pag.Add(TNfePag.Create);
        nfe.Pag.Last.Tpag:= venda.Recebimentos.Items[I].Tpag;
        nfe.Pag.Last.Vpag:= venda.Recebimentos.Items[I].Recebido;
        nfe.Pag.Last.Tpintegra:= '2';
        nfe.Pag.Last.Cnpj:= '';
        nfe.Pag.Last.Tband:= '';
        nfe.Pag.Last.Caut:= '';
        nfe.Pag.Last.Vtroco:= venda.Recebimentos.Items[I].Troco;
      end;

      nfe.processaCalculos();
      TAuthService.lVendas:= venda.Id + '|';
      if nfe.save() then Result:= nfe.Id;
    except on e: Exception do
      THelper.Mensagem(e.Message);
    end;
  finally
    if Assigned(venda) then FreeAndNil(venda);
    if Assigned(nfe) then FreeAndNil(nfe);
  end;
end;

end.
