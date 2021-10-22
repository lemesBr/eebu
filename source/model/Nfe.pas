unit Nfe;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  Pessoa, NfeDet, NfeTotalIcms, NfeTotalIssqn, NfeTotalRettrib, Empresa,
  OperacaoFiscal, ACBrBase, ACBrDFe, ACBrNFe, ACBrNFeDANFEClass,
  ACBrNFeDANFeRLClass, ACBrDANFCeFortesFr, pcnConversao, pcnConversaoNFe,
  System.StrUtils, SHDocVw, Vcl.Forms, ACBrUtil, NfeTransp, NfeCobrFat,
  NfeCobrDup, NfePag, NfeRefCte, NfeRefEcf, NfeRefNf, NfeRefNfe, NfeRefNfp,
  NfeInfcpl, NfeInfadfisco, ACBrDFeSSL, System.Math, System.DateUtils,
  Vcl.Dialogs, Vcl.FileCtrl, ACBrMail, ACBrValidador;

type
  TNfe = class(TModel)
  private
    FEMPRESA_ID: String;
    FPARTICIPANTE_ID: String;
    FOPERACAO_FISCAL_ID: String;
    FNFE_INFCPL_ID: String;
    FNFE_INFADFISCO_ID: String;
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
    FOPERACAOFISCAL: TOperacaoFiscal;
    FINFCPL: TNfeInfcpl;
    FINFADFISCO: TNfeInfadfisco;
    FDET: TObjectList<TNfeDet>;
    FICMSTOT: TNfeTotalIcms;
    FISSQNTOT: TNfeTotalIssqn;
    FRETTRIB: TNfeTotalRettrib;
    FTRANSP: TNfeTransp;
    FFAT: TNfeCobrFat;
    FDUP: TObjectList<TNfeCobrDup>;
    FPAG: TObjectList<TNfePag>;
    FREFCTE: TObjectList<TNfeRefCte>;
    FREFECF: TObjectList<TNfeRefEcf>;
    FREFNF: TObjectList<TNfeRefNf>;
    FREFNFE: TObjectList<TNfeRefNfe>;
    FREFNFP: TObjectList<TNfeRefNfp>;

    function getEmpresa: TEmpresa;
    function getParticipante: TPessoa;
    function getOperacaoFiscal: TOperacaoFiscal;
    function getInfcpl: TNfeInfcpl;
    function getInfadfisco: TNfeInfadfisco;
    function getDet: TObjectList<TNfeDet>;
    function getICMSTot: TNfeTotalIcms;
    function getISSQNtot: TNfeTotalIssqn;
    function getRetTrib: TNfeTotalRettrib;
    function getTransp: TNfeTransp;
    function getFat: TNfeCobrFat;
    function getDup: TObjectList<TNfeCobrDup>;
    function getPag: TObjectList<TNfePag>;
    function getRefCte: TObjectList<TNfeRefCte>;
    function getRefEcf: TObjectList<TNfeRefEcf>;
    function getRefNf: TObjectList<TNfeRefNf>;
    function getRefNfe: TObjectList<TNfeRefNfe>;
    function getRefNfp: TObjectList<TNfeRefNfp>;

    function getNfeNumero(Modelo, Serie: Integer): Integer;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    procedure processaCalculos();
    procedure enviar();
    class function find(id: string): TNfe;
    class function findByChnfe(Chnfe: string): TNfe;
    class function list(startDate,endDate: TDate; search: string): TObjectList<TNfe>; overload;
    class procedure list(startDate,endDate: TDate; search: string; DataSet: TFDMemTable); overload;
    class function listRecebidas(startDate,endDate: TDate; search: string): TObjectList<TNfe>; overload;
    class procedure listRecebidas(startDate,endDate: TDate; search: string; DataSet: TFDMemTable); overload;
    class function listNfeEmpresa(startDate,endDate: TDate): TObjectList<TNfe>; overload;
    class procedure listNfeEmpresa(startDate,endDate: TDate; DataSet: TFDMemTable); overload;
    class procedure gravarXML(NfeId, XML: string);
    class procedure imprimir(NfeId: string; vtype: Integer = 1);
    class procedure cancelar(NfeId: string);
    class procedure inutilizar(NfeId: string);
    class procedure corrigir(NfeId: string);
    class procedure atualizar(NfeId: string);
    class procedure configurar(Nfe: TACBrNFe);
    class function vendaToNfe(VendaId,OperacaoFiscalId: string): string;
    class function lvendasToNfe(VendaId, lVendas, OperacaoFiscalId: string): string;
    class procedure loadxml(RetWS: String; MyWebBrowser: TWebBrowser);
    class procedure consultaNfeRecebidas();
    class procedure manifestarCiencia(NfeId: string);
    class procedure importarXML(XML: string; vtype: Integer = 0);
    class function consultaXML(NfeId: string): string;
    class procedure exportarXML(NfeId, Path: string);
    class procedure enviarEmail(NfeId: string);
    class function itensAjustados(NfeId: string): Boolean;
    class procedure nfeToEfd(NfeId, OFId: string);
    class function compraToNfe(CompraId, OperacaoFiscalId: string): string;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property ParticipanteId: String  read FPARTICIPANTE_ID write FPARTICIPANTE_ID;
    property OperacaoFiscalId: String  read FOPERACAO_FISCAL_ID write FOPERACAO_FISCAL_ID;
    property NfeInfcplId: String read FNFE_INFCPL_ID write FNFE_INFCPL_ID;
    property NfeInfadfiscoId: String read FNFE_INFADFISCO_ID write FNFE_INFADFISCO_ID;
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
    property OperacaoFiscal: TOperacaoFiscal read getOperacaoFiscal;
    property Infcpl: TNfeInfcpl read getInfcpl;
    property Infadfisco: TNfeInfadfisco read getInfadfisco;
    property Det: TObjectList<TNfeDet> read getDet;
    property ICMSTot: TNfeTotalIcms read getICMSTot;
    property ISSQNtot: TNfeTotalIssqn read getISSQNtot;
    property RetTrib: TNfeTotalRettrib read getRetTrib;
    property Transp: TNfeTransp read getTransp;
    property Fat: TNfeCobrFat read getFat;
    property Dup: TObjectList<TNfeCobrDup> read getDup;
    property Pag: TObjectList<TNfePag> read getPag;
    property RefCte: TObjectList<TNfeRefCte> read getRefCte;
    property RefEcf: TObjectList<TNfeRefEcf> read getRefEcf;
    property RefNf: TObjectList<TNfeRefNf> read getRefNf;
    property RefNfe: TObjectList<TNfeRefNfe> read getRefNfe;
    property RefNfp: TObjectList<TNfeRefNfp> read getRefNfp;
  end;

implementation

uses
  AuthService, Venda, ViewCfIcms, Helper, ViewCfIpi, ViewCfPis, ViewCfCofins,
  Ncm, uformPessoaCreateEdit, VendaItem, VendaRecebimento, Compra;

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

class function TNfe.compraToNfe(CompraId, OperacaoFiscalId: string): string;
var
  vCompra: TCompra;
  vNfe: TNfe;
  vIcmsUf: string;
  vIcmsCf: TViewCfIcms;
  vIpiCf: TViewCfIpi;
  vPisCf: TViewCfPis;
  vCofinsCf: TViewCfCofins;
  I: Integer;
begin
  Result:= EmptyStr;
  try
    try
      vNfe:= nil;
      vCompra:= TCompra.find(CompraId);
      if not Assigned(vCompra) then
        raise Exception.Create('Compra não encontrada.');

      vNfe:= TNfe.Create;
      vNfe.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;
      vNfe.ParticipanteId:= vCompra.PessoaId;
      vNfe.Cuf:= vNfe.Empresa.Uf;
      vNfe.OperacaoFiscalId:= OperacaoFiscalId;
      vNfe.Natop:= vNfe.OperacaoFiscal.Natop;
      vNfe.Indpag:= '0';
      vNfe.Modelo:= vNfe.OperacaoFiscal.Modelo;
      case AnsiIndexStr(vNfe.Modelo, ['01','1B','04','55','65']) of
        3: vNfe.Serie:= vNfe.Empresa.NfeConfiguracao.SerieNfe;
        4: vNfe.Serie:= vNfe.Empresa.NfeConfiguracao.SerieNfce;
      end;

      if (AnsiIndexStr(vNfe.Modelo, ['01','1B','04','55']) >= 0) and (vCompra.Pessoa.Documento = '00000000000') then
        raise Exception.Create('Nfe para consumidor indisponível. Procedimento foi cancelado!')
      else if (AnsiIndexStr(vNfe.Modelo, ['01','1B','04','55']) >= 0) then
        if not vCompra.Pessoa.validate(1) then
          raise Exception.Create('Procedimento foi cancelado!');

      vNfe.Demi:= Now;
      vNfe.Dsaient:= Now;
      vNfe.Tpnf:= vNfe.OperacaoFiscal.Tpnf;
      vNfe.TpnfWt:= 1;
      vNfe.Iddest:= vNfe.OperacaoFiscal.Iddest;
      vNfe.Cmunfg:= vNfe.Empresa.CodigoMunicipio;
      vNfe.Tpimp:= vNfe.OperacaoFiscal.Tpimp;
      vNfe.Tpemis:= '1';
      vNfe.Tpamb:= vNfe.Empresa.NfeConfiguracao.AmbienteCodigo;
      vNfe.Finnfe:= vNfe.OperacaoFiscal.Finnfe;
      vNfe.Indfinal:= vNfe.OperacaoFiscal.Indfinal;
      vNfe.Indpres:= vNfe.OperacaoFiscal.Indpres;
      vNfe.Procemi:= '0';
      vNfe.AutoCalculo:= 'S';

      for I:= 0 to Pred(vCompra.Itens.Count) do
      begin
        if not vCompra.Itens.Items[I].Item.validade(1) then
          raise Exception.Create('Procedimento foi cancelado!');

        vNfe.Det.Add(TNfeDet.Create);
        vNfe.Det.Last.ItemId:= vCompra.Itens.Items[I].ItemId;
        vNfe.Det.Last.Cprod:= vNfe.Det.Last.ITEM.Referencia.ToString();
        vNfe.Det.Last.Nitem:= (I + 1);
        vNfe.Det.Last.Cean:= vNfe.Det.Last.ITEM.Ean;
        vNfe.Det.Last.Xprod:= vNfe.Det.Last.ITEM.Nome;
        vNfe.Det.Last.Ncm:= vNfe.Det.Last.ITEM.Ncm;
        vNfe.Det.Last.Extipi:= vNfe.Det.Last.ITEM.Extipi;
        vNfe.Det.Last.Ucom:= vNfe.Det.Last.ITEM.Unidade.Unidade;
        vNfe.Det.Last.Qcom:= vCompra.Itens.Items[I].Qtde;
        vNfe.Det.Last.Vuncom:= vCompra.Itens.Items[I].Unitario;
        vNfe.Det.Last.Vprod:= vCompra.Itens.Items[I].Subtotal;
        vNfe.Det.Last.Ceantrib:= vNfe.Det.Last.ITEM.EanTributavel;
        vNfe.Det.Last.Utrib:= vNfe.Det.Last.ITEM.UnidadeTributave.Unidade;
        vNfe.Det.Last.Qtrib:= vCompra.Itens.Items[I].Qtde;
        vNfe.Det.Last.Vuntrib:= vCompra.Itens.Items[I].Unitario;
        vNfe.Det.Last.Vfrete:= 0;
        vNfe.Det.Last.Vseg:= 0;
        vNfe.Det.Last.Vdesc:= vCompra.Itens.Items[I].Desconto;
        vNfe.Det.Last.Voutro:= vCompra.Itens.Items[I].Acrescimo;
        vNfe.Det.Last.Indtot:= '1';
        vNfe.Det.Last.Cest:= vNfe.Det.Last.ITEM.Cest;
        vNfe.Det.Last.Vtottrib:= 0;
        vNfe.Det.Last.Pdevol:= 0;
        vNfe.Det.Last.Vipidevol:= 0;

        if Assigned(vNfe.Participante) and (Trim(vNfe.Participante.Uf) <> EmptyStr) then
          vIcmsUf:= vNfe.Participante.Uf
        else
          vIcmsUf:= vNfe.Empresa.Uf;

        vIcmsCf:= TViewCfIcms.find(
          vNfe.OperacaoFiscalId,
          vNfe.Det.Last.ITEM.GrupoTributarioId,
          vIcmsUf);

        if not Assigned(vIcmsCf) then
          raise Exception.Create('ICMS sem dados configurados para o item: ' +
            vNfe.Det.Last.ITEM.Nome + ', nas notas fiscais emitidas para a uf: ' +
            vIcmsUf + ' com natop: ' + vNfe.Natop + ' e grupo: ' +
            vNfe.Det.Last.ITEM.GrupoTributario.Nome + '. Procedimento foi cancelado!');

        vNfe.Det.Last.ICMSCreate;
        vNfe.Det.Last.Cfop:= vIcmsCf.Cfop;
        vNfe.Det.Last.ICMS.Orig:= vIcmsCf.Orig;
        vNfe.Det.Last.ICMS.Cst:= vIcmsCf.Cst;
        vNfe.Det.Last.ICMS.Csosn:= vIcmsCf.Csosn;
        vNfe.Det.Last.ICMS.Modbc:= vIcmsCf.Modbc;
        vNfe.Det.Last.ICMS.Predbc:= vIcmsCf.Predbc;
        vNfe.Det.Last.ICMS.Picms:= vIcmsCf.Picms;
        vNfe.Det.Last.ICMS.Modbcst:= vIcmsCf.Modbcst;
        vNfe.Det.Last.ICMS.Pmvast:= vIcmsCf.Pmvast;
        vNfe.Det.Last.ICMS.Predbcst:= vIcmsCf.Predbcst;
        vNfe.Det.Last.ICMS.Picmsst:= vIcmsCf.Picmsst;
        vNfe.Det.Last.ICMS.Motdesicms:= vIcmsCf.Motdesicms;
        vNfe.Det.Last.ICMS.Pcredsn:= vIcmsCf.Pcredsn;
        vNfe.Det.Last.ICMS.Pdif:= vIcmsCf.Pdif;
        vNfe.Det.Last.ICMS.Pfcp:= vIcmsCf.Pfcp;
        vNfe.Det.Last.ICMS.Pfcpst:= vIcmsCf.Pfcpst;
        vNfe.Det.Last.ICMS.Pfcpstret:= vIcmsCf.Pfcpstret;
        vNfe.Det.Last.ICMSUFDestCreate;
        vNfe.Det.Last.ICMSUFDest.Pfcpufdest:= vIcmsCf.Pfcpufdest;
        vNfe.Det.Last.ICMSUFDest.Picmsufdest:= vIcmsCf.Picmsufdest;
        vNfe.Det.Last.ICMSUFDest.Picmsinter:= vIcmsCf.Picmsinter;
        vNfe.Det.Last.ICMSUFDest.Picmsinterpart:= vIcmsCf.Picmsinterpart;
        FreeAndNil(vIcmsCf);

        vIpiCf:= TViewCfIpi.find(
          vNfe.OperacaoFiscalId,
          vNfe.Det.Last.ITEM.GrupoTributarioId);

        if not Assigned(vIpiCf) then
          raise Exception.Create('IPI sem dados configurados para o item: ' +
            vNfe.Det.Last.ITEM.Nome + ', com natop: ' + vNfe.Natop + ' e grupo: ' +
            vNfe.Det.Last.ITEM.GrupoTributario.Nome + '. Procedimento foi cancelado!');

        vNfe.Det.Last.IPICreate;
        vNfe.Det.Last.IPI.Clenq:= vIpiCf.Clenq;
        vNfe.Det.Last.IPI.Cnpjprod:= vIpiCf.Cnpjprod;
        vNfe.Det.Last.IPI.Cselo:= vIpiCf.Cselo;
        if (vIpiCf.Qselo > 0) then
          vNfe.Det.Last.IPI.Qselo:= vIpiCf.Qselo;
        vNfe.Det.Last.IPI.Cenq:= vIpiCf.Cenq;
        vNfe.Det.Last.IPI.Cst:= vIpiCf.Cst;
        vNfe.Det.Last.IPI.Pipi:= vIpiCf.Pipi;
        vNfe.Det.Last.IPI.Vunid:= vIpiCf.Vunid;
        FreeAndNil(vIpiCf);

        vNfe.Det.Last.IICreate;

        vPisCf:= TViewCfPis.find(
          vNfe.OperacaoFiscalId,
          vNfe.Det.Last.ITEM.GrupoTributarioId);

        if not Assigned(vPisCf) then
          raise Exception.Create('PIS sem dados configurados para o item: ' +
            vNfe.Det.Last.ITEM.Nome + ', com natop: ' + vNfe.Natop + ' e grupo: ' +
            vNfe.Det.Last.ITEM.GrupoTributario.Nome + '. Procedimento foi cancelado!');

        vNfe.Det.Last.PISCreate;
        vNfe.Det.Last.PIS.Cst:= vPisCf.Cst;
        vNfe.Det.Last.PIS.Ppis:= vPisCf.Ppis;
        vNfe.Det.Last.PIS.Valiqprod:= vPisCf.Valiqprod;
        vNfe.Det.Last.PIS.Ppis:= vPisCf.Ppisst;
        vNfe.Det.Last.PIS.Valiqprod:= vPisCf.Valiqprodst;
        FreeAndNil(vPisCf);

        vCofinsCf:= TViewCfCofins.find(
          vNfe.OperacaoFiscalId,
          vNfe.Det.Last.ITEM.GrupoTributarioId);

        if not Assigned(vCofinsCf) then
          raise Exception.Create('COFINS sem dados configurados para o item: ' +
            vNfe.Det.Last.ITEM.Nome + ', com natop: ' + vNfe.Natop + ' e grupo: ' +
            vNfe.Det.Last.ITEM.GrupoTributario.Nome + '. Procedimento foi cancelado!');

        vNfe.Det.Last.COFINSCreate;
        vNfe.Det.Last.COFINS.Cst:= vCofinsCf.Cst;
        vNfe.Det.Last.COFINS.Pcofins:= vCofinsCf.Pcofins;
        vNfe.Det.Last.COFINS.Valiqprod:= vCofinsCf.Valiqprod;
        vNfe.Det.Last.COFINS.Pcofins:= vCofinsCf.Pcofinsst;
        vNfe.Det.Last.COFINS.Valiqprod:= vCofinsCf.Valiqprodst;
        FreeAndNil(vCofinsCf);
      end;

      vNfe.processaCalculos();
      TAuthService.CompraId:= CompraId;
      if vNfe.save() then Result:= vNfe.Id;
    except on e: Exception do
      THelper.Mensagem(e.Message);
    end;
  finally
    if Assigned(vCompra) then FreeAndNil(vCompra);
    if Assigned(vNfe) then FreeAndNil(vNfe);
  end;
end;

class procedure TNfe.configurar(Nfe: TACBrNFe);
var
  v_empresa: TEmpresa;
  Ok: Boolean;
begin
  try
    v_empresa:= TEmpresa.find(TAuthService.getAuthenticatedEmpresaId);
    if not Assigned(v_empresa) then
      raise Exception.Create('Falha ao carregar dados da empresa.');

    with Nfe.Configuracoes do
    begin
      Geral.VersaoDF:= StrToVersaoDF(Ok, v_empresa.NfeConfiguracao.VersaoDf);
      Geral.AtualizarXMLCancelado:= v_empresa.NfeConfiguracao.AtualizarXmlCancelado = 'S';
      Geral.IdCSC:= v_empresa.NfeConfiguracao.IdCsc;
      Geral.CSC:= v_empresa.NfeConfiguracao.Csc;
      //Geral.IncluirQRCodeXMLNFCe:= v_empresa.NfeConfiguracao.IncluirQrcodeXmlNfce = 'S';
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

class procedure TNfe.consultaNfeRecebidas;
var
  vEmpresa: TEmpresa;
  vNota: TACBrNFe;
  vNfe: TNfe;
  vPessoa: TPessoa;
  I: Integer;
begin
  try
    try
      vNota:= nil;
      vNfe:= nil;
      vPessoa:= nil;

      vEmpresa:= TEmpresa.find(TAuthService.getAuthenticatedEmpresaId);
      if not Assigned(vEmpresa) then
        raise Exception.Create('Falha ao consultar dados da empresa.');

      if (vEmpresa.UltimaConsulta > IncHour(Now, -2)) then
        raise Exception.Create(
          'Última consulta: ' + DateTimeToStr(vEmpresa.UltimaConsulta) +
          '. Volte a consultar: ' + DateTimeToStr(IncHour(vEmpresa.UltimaConsulta, 2))
        );

      vNota:= TACBrNFe.Create(nil);
      Self.configurar(vNota);

      repeat
        vNota.DistribuicaoDFePorUltNSU(
          UFtoCUF(vEmpresa.Uf),
          vEmpresa.Documento,
          vEmpresa.UltimoNsu.ToString()
        );

        case vNota.WebServices.DistribuicaoDFe.retDistDFeInt.cStat of
          137: THelper.Mensagem(vNota.WebServices.DistribuicaoDFe.retDistDFeInt.xMotivo);
          138: begin
            with vNota.WebServices.DistribuicaoDFe.retDistDFeInt do
            begin
              for I:= 0 to Pred(docZip.Count) do
              begin
                if (Trim(docZip.Items[i].resDFe.chDFe) <> EmptyStr) and
                  (docZip.Items[i].resDFe.tpNF = tnSaida) and
                  (docZip.Items[i].resDFe.cSitDFe = snAutorizado) and
                  (docZip.Items[i].resDFe.dhEmi >= vEmpresa.ControleConsulta) then
                begin
                  vNfe:= TNfe.findByChnfe(Trim(docZip.Items[i].resDFe.chDFe));
                  if Assigned(vNfe) then
                  begin
                    FreeAndNil(vNfe);
                    Continue;
                  end;

                  vPessoa:= TPessoa.findByDocumento(Trim(docZip.Items[i].resDFe.CNPJCPF));
                  if not Assigned(vPessoa) then
                  begin
                    vPessoa:= TPessoa.Create;
                    vPessoa.TipoPessoa:= IfThen(Trim(docZip.Items[i].resDFe.CNPJCPF).Length = 11, 'F', 'J');
                    vPessoa.Nome:= Trim(docZip.Items[i].resDFe.xNome);
                    vPessoa.Documento:= Trim(docZip.Items[i].resDFe.CNPJCPF);
                    vPessoa.Simples:= 'N';
                    vPessoa.save();
                  end;

                  vNfe:= TNfe.Create;
                  vNfe.ParticipanteId:= vPessoa.Id;
                  vNfe.Modelo:= '55';
                  vNfe.Chnfe:= docZip.Items[i].resDFe.chDFe;
                  vNfe.Serie:= StrToInt(Copy(vNfe.Chnfe, 23, 3));
                  vNfe.Nnf:= StrToInt(Copy(vNfe.Chnfe, 26, 9));
                  vNfe.Demi:= docZip.Items[i].resDFe.dhEmi;
                  vNfe.TpnfWt:= 0;
                  vNfe.ICMSTot.Vnf:= docZip.Items[i].resDFe.vNF;
                  vNfe.Nsu:= StrToIntDef(docZip.Items[i].NSU,0);
                  vNfe.Nferecebida:= 0;
                  vNfe.AutoCalculo:= 'N';

                  vNfe.save();
                  FreeAndNil(vNfe);
                  FreeAndNil(vPessoa);
                end;
              end;
            end;
          end;
          else
            THelper.Mensagem(vNota.WebServices.DistribuicaoDFe.retDistDFeInt.xMotivo);
        end;

        vEmpresa.UltimaConsulta:= Now;
        vEmpresa.UltimoNsu:= StrToInt(vNota.WebServices.DistribuicaoDFe.retDistDFeInt.ultNSU);
        vEmpresa.save();
      until (vNota.WebServices.DistribuicaoDFe.retDistDFeInt.cStat = 137);
    except on e: Exception do
      THelper.Mensagem(e.Message);
    end;
  finally
    if Assigned(vEmpresa) then FreeAndNil(vEmpresa);
    if Assigned(vNota) then FreeAndNil(vNota);
    if Assigned(vNfe) then FreeAndNil(vNfe);
    if Assigned(vPessoa) then FreeAndNil(vPessoa);
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
  if Assigned(Self.FOPERACAOFISCAL) then FreeAndNil(Self.FOPERACAOFISCAL);
  if Assigned(Self.FINFCPL) then FreeAndNil(Self.FINFCPL);
  if Assigned(Self.FINFADFISCO) then FreeAndNil(Self.FINFADFISCO);
  if Assigned(Self.FDET) then FreeAndNil(Self.FDET);
  if Assigned(Self.FICMSTOT) then FreeAndNil(Self.FICMSTOT);
  if Assigned(Self.FISSQNTOT) then FreeAndNil(Self.FISSQNTOT);
  if Assigned(Self.FRETTRIB) then FreeAndNil(Self.FRETTRIB);
  if Assigned(Self.FTRANSP) then FreeAndNil(Self.FTRANSP);
  if Assigned(Self.FFAT) then FreeAndNil(Self.FFAT);
  if Assigned(Self.FDUP) then FreeAndNil(Self.FDUP);
  if Assigned(Self.FPAG) then FreeAndNil(Self.FPAG);
  if Assigned(Self.FREFCTE) then FreeAndNil(Self.FREFCTE);
  if Assigned(Self.FREFECF) then FreeAndNil(Self.FREFECF);
  if Assigned(Self.FREFNF) then FreeAndNil(Self.FREFNF);
  if Assigned(Self.FREFNFE) then FreeAndNil(Self.FREFNFE);
  if Assigned(Self.FREFNFP) then FreeAndNil(Self.FREFNFP);

  inherited;
end;

procedure TNfe.enviar;
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
begin
  try
    try
      vACBrNF:= TACBrNFe.Create(nil);
      TNfe.configurar(vACBrNF);

      if (Self.Cstat in[0,99]) and (Self.Chnfe <> EmptyStr) then
      begin
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
                  if THelper.Mensagem('Nota fiscal autorizada. Deseja imprimir?', 1) then
                    Self.imprimir(Self.Id, 0);
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
      end;

      if (Self.Cstat = 99) then
      begin
        try
          vXML:= TNfe.consultaXML(Self.Id);
          vACBrNF.NotasFiscais.Clear();
          vACBrNF.NotasFiscais.LoadFromString(vXML);

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
                  if THelper.Mensagem('Nota fiscal autorizada. Deseja imprimir?', 1) then
                    Self.imprimir(Self.Id, 0);
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
            THelper.Mensagem(e.Message);
            if (vACBrNF.WebServices.Enviar.cStat > 0) then
            begin
              if THelper.Mensagem('Deseja poder editar os dados da nota?', 1) then
              begin
                Self.Chnfe:= '';
                Self.Cstat:= 0;
                Self.save();
              end;
            end;
            Exit();
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

        if (Self.Modelo = '55') then
          Ide.dSaiEnt:= StrToDateTimeDef(DateToStr(Self.Dsaient) + ' ' + TimeToStr(Now), Now);

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

        if Assigned(Self.RefCte) then
        begin
          for I:= 0 to Pred(Self.RefCte.Count) do
          begin
            with Ide.NFref.Add() do
            begin
              refCTe:= Self.RefCte.Items[I].Chnfe;
            end;
          end;
        end;

        if Assigned(Self.RefEcf) then
        begin
          for I:= 0 to Pred(Self.RefEcf.Count) do
          begin
            with Ide.NFref.Add() do
            begin
              RefECF.modelo:= StrToECFModRef(Ok, Self.RefEcf.Items[I].Modelo);
              RefECF.nECF:= Self.RefEcf.Items[I].Necf;
              RefECF.nCOO:= Self.RefEcf.Items[I].Ncoo;
            end;
          end;
        end;

        if Assigned(Self.RefNf) then
        begin
          for I:= 0 to Pred(Self.RefNf.Count) do
          begin
            with Ide.NFref.Add() do
            begin
              RefNF.cUF:= Self.RefNf.Items[I].Cuf;
              RefNF.AAMM:= Self.RefNf.Items[I].Aamm;
              RefNF.CNPJ:= Self.RefNf.Items[I].Cnpj;
              RefNF.modelo:= Self.RefNf.Items[I].Modelo;
              RefNF.serie:= Self.RefNf.Items[I].Serie;
              RefNF.nNF:= Self.RefNf.Items[I].Nnf;
            end;
          end;
        end;

        if Assigned(Self.RefNfe) then
        begin
          for I:= 0 to Pred(Self.RefNfe.Count) do
          begin
            with Ide.NFref.Add() do
            begin
              RefNfe:= Self.RefNfe.Items[I].Chnfe;
            end;
          end;
        end;

        if Assigned(Self.RefNfp) then
        begin
          for I:= 0 to Pred(Self.RefNfp.Count) do
          begin
            with Ide.NFref.Add() do
            begin
              RefNfp.cUF:= Self.RefNfp.Items[I].Cuf;
              RefNfp.AAMM:= Self.RefNfp.Items[I].Aamm;
              RefNfp.CNPJCPF:= Self.RefNfp.Items[I].Cnpjcpf;
              RefNfp.IE:= Self.RefNfp.Items[I].Ie;
              RefNfp.modelo:= Self.RefNfp.Items[I].Modelo;
              RefNfp.serie:= Self.RefNfp.Items[I].Serie;
              RefNfp.nNF:= Self.RefNfp.Items[I].Nnf;
            end;
          end;
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
        if (Self.Modelo = '55') then
        begin
          Dest.CNPJCPF:= Self.Participante.Documento;
          Dest.idEstrangeiro:= Self.Participante.Idestrangeiro;
          Dest.xNome:= Self.Participante.Nome;
          Dest.indIEDest:= StrToindIEDest(Ok, Self.Participante.Indiedest);
          Dest.IE:= Self.Participante.Ie;
          Dest.ISUF:= Self.Participante.Isuf;
          Dest.IM:= Self.Participante.Im;
          Dest.EnderDest.xLgr:= Self.Participante.Logradouro;
          Dest.EnderDest.nro:= Self.Participante.Numero;
          Dest.EnderDest.xCpl:= Self.Participante.Complemento;
          Dest.EnderDest.xBairro:= Self.Participante.Bairro;
          Dest.EnderDest.cMun:= StrToIntDef(Self.Participante.CodigoMunicipio, 0);
          Dest.EnderDest.xMun:= Self.Participante.NomeMunicipio;
          Dest.EnderDest.UF:= Self.Participante.Uf;
          Dest.EnderDest.CEP:= StrToIntDef(Self.Participante.Cep, 0);
          Dest.EnderDest.cPais:= 1058;
          Dest.EnderDest.xPais:= 'Brasil';
          Dest.EnderDest.fone:= Self.Participante.Fone;
          Dest.Email:= Self.Participante.Email;
        end
        else if (Self.Modelo = '65') and (Self.Participante.Documento <> '00000000000') then
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

          if Assigned(Self.Det.Items[I].II) then
          begin
            II.vBc:= Self.Det.Items[I].II.Vbc;
            II.vDespAdu:= Self.Det.Items[I].II.Vdespadu;
            II.vII:= Self.Det.Items[I].II.Vii;
            II.vIOF:= Self.Det.Items[I].II.Viof;
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

          if Assigned(Self.Det.Items[I].PISST) and Assigned(Self.Det.Items[I].PIS) and (StrToIntDef(Self.Det.Items[I].PIS.Cst, 0) >= 1) then
          begin
            PISST.vBC:= Self.Det.Items[I].PISST.Vbc;
            PISST.pPIS:= Self.Det.Items[I].PISST.Ppis;
            PISST.vPIS:= Self.Det.Items[I].PISST.Vpis;
            PISST.qBCProd:= Self.Det.Items[I].PISST.Qbcprod;
            PISST.vAliqProd:= Self.Det.Items[I].PISST.Valiqprod;
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

          if Assigned(Self.Det.Items[I].COFINSST) and Assigned(Self.Det.Items[I].COFINS) and (StrToIntDef(Self.Det.Items[I].COFINS.Cst, 0) >= 1) then
          begin
            COFINSST.vBC:= Self.Det.Items[I].COFINSST.Vbc;
            COFINSST.pCOFINS:= Self.Det.Items[I].COFINSST.Pcofins;
            COFINSST.qBCProd:= Self.Det.Items[I].COFINSST.Qbcprod;
            COFINSST.vAliqProd:= Self.Det.Items[I].COFINSST.Valiqprod;
            COFINSST.vCOFINS:= Self.Det.Items[I].COFINSST.Vcofins;
          end;

          if (Self.Modelo = '55') and (Self.Empresa.Uf <> Self.Participante.Uf) and (Self.Participante.Indiedest = '1') then
          begin
            ICMSUFDest.vBCUFDest:= Self.Det.Items[I].ICMSUFDest.Vbcufdest;
            ICMSUFDest.pICMSUFDest:= Self.Det.Items[I].ICMSUFDest.Picmsufdest;
            ICMSUFDest.pICMSInter:= Self.Det.Items[I].ICMSUFDest.Picmsinter;
            ICMSUFDest.pICMSInterPart:= Self.Det.Items[I].ICMSUFDest.Picmsinterpart;
            ICMSUFDest.vICMSUFDest:= Self.Det.Items[I].ICMSUFDest.Vicmsufdest;
            ICMSUFDest.vICMSUFRemet:= Self.Det.Items[I].ICMSUFDest.Vicmsufremet;

            ICMSUFDest.vBCFCPUFDest:= Self.Det.Items[I].ICMSUFDest.Vbcfcpufdest;
            ICMSUFDest.pFCPUFDest:= Self.Det.Items[I].ICMSUFDest.Pfcpufdest;
            ICMSUFDest.vFCPUFDest:= Self.Det.Items[I].ICMSUFDest.Vfcpufdest;
          end;
        end;
      end;

      with vACBrNF.NotasFiscais.Items[0].NFe do
      begin
        Transp.modFrete:= StrTomodFrete(Ok, Self.Transp.Modfrete);
        Transp.Transporta.CNPJCPF:= Self.Transp.Cnpjcpf;
        Transp.Transporta.xNome:= Self.Transp.Xnome;
        Transp.Transporta.IE:= Self.Transp.Ie;
        Transp.Transporta.xEnder:= Self.Transp.Xender;
        Transp.Transporta.xMun:= Self.Transp.Xmun;
        Transp.Transporta.UF:= Self.Transp.Uf;
        Transp.vagao:= Self.Transp.Vagao;
        Transp.balsa:= Self.Transp.Balsa;
      end;

      with vACBrNF.NotasFiscais.Items[0].NFe.Cobr do
      begin
        Fat.nFat:= Self.Fat.Nfat;
        Fat.vOrig:= Self.Fat.vOrig;
        Fat.vDesc:= Self.Fat.vDesc;
        Fat.vLiq:= Self.Fat.vLiq;

        for I:= 0 to Pred(Self.Dup.Count) do
        begin
          Dup.Add();
          Dup.Items[I].nDup:= Self.Dup.Items[I].Ndup;
          Dup.Items[I].dVenc:= Self.Dup.Items[I].Dvenc;
          Dup.Items[I].vDup:= Self.Dup.Items[I].Vdup;
        end;
      end;

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

      if (Self.Modelo = '65') or (vACBrNF.Configuracoes.Geral.VersaoDF = ve400) then
      begin
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
      end;

      if Assigned(Self.Infcpl) then
        vACBrNF.NotasFiscais.Items[0].NFe.InfAdic.infCpl:= Self.Infcpl.Infcpl;
      if Assigned(Self.Infadfisco) then
        vACBrNF.NotasFiscais.Items[0].NFe.InfAdic.infAdFisco:= Self.Infadfisco.Infadfisco;

      vACBrNF.NotasFiscais.Assinar;
      vACBrNF.NotasFiscais.Validar;

      if not vACBrNF.NotasFiscais.ValidarRegrasdeNegocios(vRegras) then
        raise Exception.Create(vRegras);

      vACBrNF.NotasFiscais.GerarNFe;
      Self.Nunlote:= FormatDateTime('yyyymmddhhmmss', Now);
      Self.gravarXML(Self.Id, vACBrNF.NotasFiscais.Items[0].XML);
      Self.Chnfe:= Copy(vACBrNF.NotasFiscais.Items[0].NFe.infNFe.ID, 4);
      Self.Cstat:= IfThen((StrToIntDef(Self.Tpemis, 1) in[2,9]), 99, 0);
      Self.save();

      if (Self.Cstat = 99) then
      begin
        if THelper.Mensagem('Nota fiscal emitida em contingência. Deseja imprimir?', 1) then
          Self.imprimir(Self.Id, 0);

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
              if THelper.Mensagem('Nota fiscal autorizada. Deseja imprimir?', 1) then
                Self.imprimir(Self.Id, 0);
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
      raise Exception.Create(e.Message);
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

function TNfe.getDet: TObjectList<TNfeDet>;
begin
  if not Assigned(Self.FDET) and (Self.Id <> EmptyStr) then
    Self.FDET:= TNfeDet.findByNfeId(Self.Id);

  if not Assigned(Self.FDET) then
    Self.FDET:= TObjectList<TNfeDet>.Create();

  Result:= Self.FDET;
end;

function TNfe.getDup: TObjectList<TNfeCobrDup>;
begin
  if not Assigned(Self.FDUP) and (Self.Id <> EmptyStr) then
    Self.FDUP:= TNfeCobrDup.findByNfeId(Self.Id);

  if not Assigned(Self.FDUP) then
    Self.FDUP:= TObjectList<TNfeCobrDup>.Create();

  Result:= Self.FDUP;
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

function TNfe.getFat: TNfeCobrFat;
begin
  if not Assigned(Self.FFAT) and (Self.Id <> EmptyStr) then
    Self.FFAT:= TNfeCobrFat.findByNfeId(Self.Id);

  if not Assigned(Self.FFAT) then
    Self.FFAT:= TNfeCobrFat.Create;

  Result:= Self.FFAT;
end;

function TNfe.getICMSTot: TNfeTotalIcms;
begin
  if not Assigned(Self.FICMSTOT) and (Self.Id <> EmptyStr) then
    Self.FICMSTOT:= TNfeTotalIcms.findByNfeId(Self.Id);

  if not Assigned(Self.FICMSTOT) then
    Self.FICMSTOT:= TNfeTotalIcms.Create;

  Result:= Self.FICMSTOT;
end;

function TNfe.getInfadfisco: TNfeInfadfisco;
begin
  if not Assigned(Self.FINFADFISCO) then
    Self.FINFADFISCO:= TNfeInfadfisco.find(Self.FNFE_INFADFISCO_ID)
  else if Self.FINFADFISCO.Id <> Self.FNFE_INFADFISCO_ID then
  begin
    FreeAndNil(FINFADFISCO);
    Self.FINFADFISCO:= TNfeInfadfisco.find(Self.FNFE_INFADFISCO_ID);
  end;
  Result:= Self.FINFADFISCO;
end;

function TNfe.getInfcpl: TNfeInfcpl;
begin
  if not Assigned(Self.FINFCPL) then
    Self.FINFCPL:= TNfeInfcpl.find(Self.FNFE_INFCPL_ID)
  else if Self.FINFCPL.Id <> Self.FNFE_INFCPL_ID then
  begin
    FreeAndNil(FINFCPL);
    Self.FINFCPL:= TNfeInfcpl.find(Self.FNFE_INFCPL_ID);
  end;
  Result:= Self.FINFCPL;
end;

function TNfe.getISSQNtot: TNfeTotalIssqn;
begin
  if not Assigned(Self.FISSQNTOT) and (Self.Id <> EmptyStr) then
    Self.FISSQNTOT:= TNfeTotalIssqn.findByNfeId(Self.Id);

  Result:= Self.FISSQNTOT;
end;

function TNfe.getNfeNumero(Modelo, Serie: Integer): Integer;
const
  FSql: string =
  'SELECT N.* FROM NFE_NUMERO N ' +
  'WHERE (N.EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (N.MODELO = :MODELO) ' +
  'AND (N.SERIE = :SERIE) ' +
  'AND (N.DELETED_AT IS NULL)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('MODELO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('SERIE').DataType:= ftInteger;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('MODELO').AsInteger:= Modelo;
      FDQuery.Params.ParamByName('SERIE').AsInteger:= Serie;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then
      begin
        Result:= 1;
        FDQuery.Append;
        FDQuery.FieldByName('ID').AsString:= Self.generateId;
        FDQuery.FieldByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
        FDQuery.FieldByName('MODELO').AsInteger:= Modelo;
        FDQuery.FieldByName('SERIE').AsInteger:= Serie;
        FDQuery.FieldByName('NUMERO').AsInteger:= Result;
        FDQuery.FieldByName('CREATED_AT').Value:= Now;
        FDQuery.FieldByName('UPDATED_AT').Value:= Now;
        FDQuery.FieldByName('SYNCHRONIZED').AsString:= 'N';
        FDQuery.Post;
      end
      else
      begin
        Result:= FDQuery.FieldByName('NUMERO').AsInteger + 1;
        FDQuery.Edit;
        FDQuery.FieldByName('NUMERO').AsInteger:= Result;
        FDQuery.FieldByName('UPDATED_AT').Value:= Now;
        FDQuery.FieldByName('SYNCHRONIZED').AsString:= 'N';
        FDQuery.Post;
      end;
    except on e: Exception do
    begin
      Result:= 0;
      raise Exception.Create('NFE_NUMERO erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfe.getOperacaoFiscal: TOperacaoFiscal;
begin
  if not Assigned(Self.FOPERACAOFISCAL) then
    Self.FOPERACAOFISCAL:= TOperacaoFiscal.find(Self.FOPERACAO_FISCAL_ID)
  else if Self.FOPERACAOFISCAL.Id <> Self.FOPERACAO_FISCAL_ID then
  begin
    FreeAndNil(FOPERACAOFISCAL);
    Self.FOPERACAOFISCAL:= TOperacaoFiscal.find(Self.FOPERACAO_FISCAL_ID);
  end;
  Result:= Self.FOPERACAOFISCAL;
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

function TNfe.getRefCte: TObjectList<TNfeRefCte>;
begin
  if not Assigned(Self.FREFCTE) and (Self.Id <> EmptyStr) then
    Self.FREFCTE:= TNfeRefCte.findByNfeId(Self.Id);

  Result:= Self.FREFCTE;
end;

function TNfe.getRefEcf: TObjectList<TNfeRefEcf>;
begin
  if not Assigned(Self.FREFECF) and (Self.Id <> EmptyStr) then
    Self.FREFECF:= TNfeRefEcf.findByNfeId(Self.Id);

  Result:= Self.FREFECF;
end;

function TNfe.getRefNf: TObjectList<TNfeRefNf>;
begin
  if not Assigned(Self.FREFNF) and (Self.Id <> EmptyStr) then
    Self.FREFNF:= TNfeRefNf.findByNfeId(Self.Id);

  Result:= Self.FREFNF;
end;

function TNfe.getRefNfe: TObjectList<TNfeRefNfe>;
begin
  if not Assigned(Self.FREFNFE) and (Self.Id <> EmptyStr) then
    Self.FREFNFE:= TNfeRefNfe.findByNfeId(Self.Id);

  Result:= Self.FREFNFE;
end;

function TNfe.getRefNfp: TObjectList<TNfeRefNfp>;
begin
  if not Assigned(Self.FREFNFP) and (Self.Id <> EmptyStr) then
    Self.FREFNFP:= TNfeRefNfp.findByNfeId(Self.Id);

  Result:= Self.FREFNFP;
end;

function TNfe.getRetTrib: TNfeTotalRettrib;
begin
  if not Assigned(Self.FRETTRIB) and (Self.Id <> EmptyStr) then
    Self.FRETTRIB:= TNfeTotalRettrib.findByNfeId(Self.Id);

  Result:= Self.FRETTRIB;
end;

function TNfe.getTransp: TNfeTransp;
begin
  if not Assigned(Self.FTRANSP) and (Self.Id <> EmptyStr) then
    Self.FTRANSP:= TNfeTransp.findByNfeId(Self.Id);

  if not Assigned(Self.FTRANSP) then
    Self.FTRANSP:= TNfeTransp.Create;

  Result:= Self.FTRANSP;
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
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
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

class procedure TNfe.importarXML(XML: string; vtype: Integer);
var
  vNota: TACBrNFe;
  vNfe: TNfe;
  vPessoa: TPessoa;
  vEmpresa: TEmpresa;
  I: Integer;
begin
  try
    vEmpresa:= nil;
    vPessoa:= nil;
    vNfe:= nil;
    vNota:= TACBrNFe.Create(nil);
    try
      case vtype of
        0: vNota.NotasFiscais.LoadFromString(XML);
        1: vNota.NotasFiscais.LoadFromFile(XML);
      end;

      with vNota.NotasFiscais.Items[0].NFe do
      begin
        if (Trim(procNFe.chNFe) = EmptyStr) then
          raise Exception.Create('O XML importado é invalido.');

        vEmpresa:= TEmpresa.find(TAuthService.getAuthenticatedEmpresaId);
        if not Assigned(vEmpresa) then
          raise Exception.Create('Falha ao consultar dados da empresa.');

        if not (Trim(Dest.CNPJCPF) = vEmpresa.Documento) then
          raise Exception.Create('O XML importado é destinado a um CPF/CNPJ diferente do cadastrado no sistema.');

        vNfe:= TNfe.findByChnfe(Trim(procNFe.chNFe));
        if not Assigned(vNfe) then
        begin
          vPessoa:= TPessoa.findByDocumento(Trim(Emit.CNPJCPF));
          if not Assigned(vPessoa) then
          begin
            vPessoa:= TPessoa.Create;
            vPessoa.TipoPessoa:= IfThen(Trim(Emit.CNPJCPF).Length = 11, 'F', 'J');
            vPessoa.Nome:= Trim(Emit.xNome);
            vPessoa.Documento:= Trim(Emit.CNPJCPF);
            vPessoa.Simples:= 'N';
            vPessoa.save();
          end;

          vNfe:= TNfe.Create;
          vNfe.ParticipanteId:= vPessoa.Id;
        end;

        if (vNfe.Nferecebida > 0) then
          raise Exception.Create('XML importado anteriormente.');

        vNfe.Cuf:= CUFtoUF(Ide.cUF);
        vNfe.Cnf:= Ide.cNF.ToString();
        vNfe.Natop:= Ide.natOp;
        vNfe.Indpag:= IndpagToStr(Ide.indPag);
        vNfe.Modelo:= Ide.modelo.ToString();
        vNfe.Serie:= Ide.serie;
        vNfe.Nnf:= Ide.nNF;
        vNfe.Demi:= Ide.dEmi;
        vNfe.Dsaient:= 0;
        vNfe.Tpnf:= tpNFToStr(Ide.tpNF);
        vNfe.TpnfWt:= 0;
        vNfe.Iddest:= DestinoOperacaoToStr(Ide.idDest);
        vNfe.Cmunfg:= Ide.cMunFG.ToString();
        vNfe.Tpimp:= TpImpToStr(Ide.tpImp);
        vNfe.Tpemis:= TpEmisToStr(Ide.tpEmis);
        vNfe.Cdv:= Ide.cDV;
        vNfe.Tpamb:= TpAmbToStr(Ide.tpAmb);
        vNfe.Finnfe:= FinNFeToStr(Ide.finNFe);
        vNfe.Indfinal:= ConsumidorFinalToStr(Ide.indFinal);
        vNfe.Indpres:= PresencaCompradorToStr(Ide.indPres);
        vNfe.Procemi:= procEmiToStr(Ide.procEmi);
        vNfe.Chnfe:= procNFe.chNFe;
        vNfe.Nprot:= procNFe.nProt;
        vNfe.Cstat:= procNFe.cStat;
        vNfe.Nferecebida:= 2;
        vNfe.AutoCalculo:= 'N';

        vNfe.Participante.Nome:= Trim(Emit.xFant);

        if (vNfe.Participante.Nome = EmptyStr) then
          vNfe.Participante.Nome:= Emit.xNome;

        vNfe.Participante.RazaoSocial:= Emit.xNome;
        vNfe.Participante.Documento:= Emit.CNPJCPF;
        vNfe.Participante.Im:= Emit.IM;
        vNfe.Participante.Ie:= Emit.IE;
        vNfe.Participante.Simples:= IfThen(Emit.CRT = crtSimplesNacional, 'S', 'N');
        vNfe.Participante.Cep:= Emit.EnderEmit.CEP.ToString();
        vNfe.Participante.Logradouro:= Emit.EnderEmit.xLgr;
        vNfe.Participante.Numero:= Emit.EnderEmit.nro;
        vNfe.Participante.Complemento:= Emit.EnderEmit.xCpl;
        vNfe.Participante.Bairro:= Emit.EnderEmit.xBairro;
        vNfe.Participante.CodigoMunicipio:= Emit.EnderEmit.cMun.ToString();
        vNfe.Participante.NomeMunicipio:= Emit.EnderEmit.xMun;
        vNfe.Participante.Uf:= Emit.EnderEmit.UF;
        vNfe.Participante.Fone:= Emit.EnderEmit.fone;
        vNfe.Participante.save();

        for I:= 0 to Pred(Det.Count) do
        begin
          vNfe.Det.Add(TNfeDet.Create);
          vNfe.Det.Last.Cprod:= Det.Items[I].Prod.cProd;
          vNfe.Det.Last.Nitem:= Det.Items[I].Prod.nItem;
          vNfe.Det.Last.Cean:= Det.Items[I].Prod.cEAN;
          vNfe.Det.Last.Xprod:= Det.Items[I].Prod.xProd;
          vNfe.Det.Last.Ncm:= Det.Items[I].Prod.NCM;
          vNfe.Det.Last.Extipi:= Det.Items[I].Prod.EXTIPI;
          vNfe.Det.Last.Cfop:= Det.Items[I].Prod.CFOP;
          vNfe.Det.Last.Ucom:= Det.Items[I].Prod.uCom;
          vNfe.Det.Last.Qcom:= Det.Items[I].Prod.qCom;
          vNfe.Det.Last.Vuncom:= Det.Items[I].Prod.vUnCom;
          vNfe.Det.Last.Vprod:= Det.Items[I].Prod.vProd;
          vNfe.Det.Last.Ceantrib:= Det.Items[I].Prod.cEANTrib;
          vNfe.Det.Last.Utrib:= Det.Items[I].Prod.uTrib;
          vNfe.Det.Last.Qtrib:= Det.Items[I].Prod.qTrib;
          vNfe.Det.Last.Vuntrib:= Det.Items[I].Prod.vUnTrib;
          vNfe.Det.Last.Vfrete:= Det.Items[I].Prod.vFrete;
          vNfe.Det.Last.Vseg:= Det.Items[I].Prod.vSeg;
          vNfe.Det.Last.Vdesc:= Det.Items[I].Prod.vDesc;
          vNfe.Det.Last.Voutro:= Det.Items[I].Prod.vOutro;
          vNfe.Det.Last.Indtot:= indTotToStr(Det.Items[I].Prod.IndTot);
          vNfe.Det.Last.Xped:= Det.Items[I].Prod.xPed;
          vNfe.Det.Last.Nitemped:= Det.Items[I].Prod.nItemPed;
          vNfe.Det.Last.Nrecopi:= Det.Items[I].Prod.nRECOPI;
          vNfe.Det.Last.Nfci:= Det.Items[I].Prod.nFCI;
          vNfe.Det.Last.Cest:= Det.Items[I].Prod.CEST;
          vNfe.Det.Last.Vtottrib:= Det.Items[I].Imposto.vTotTrib;
          vNfe.Det.Last.Pdevol:= Det.Items[I].pDevol;
          vNfe.Det.Last.Vipidevol:= Det.Items[I].vIPIDevol;
          vNfe.Det.Last.Infadprod:= Det.Items[I].infAdProd;

          with Det.Items[I].Imposto do
          begin
            vNfe.Det.Last.ICMSCreate;
            vNfe.Det.Last.ICMS.Orig:= OrigToStr(ICMS.orig);
            vNfe.Det.Last.ICMS.Cst:= CSTICMSToStr(ICMS.CST);
            vNfe.Det.Last.ICMS.Csosn:= CSOSNIcmsToStr(ICMS.CSOSN);
            vNfe.Det.Last.ICMS.Modbc:= modBCToStr(ICMS.modBC);
            vNfe.Det.Last.ICMS.Predbc:= ICMS.pRedBC;
            vNfe.Det.Last.ICMS.Vbc:= ICMS.vBC;
            vNfe.Det.Last.ICMS.Picms:= ICMS.pICMS;
            vNfe.Det.Last.ICMS.Vicms:= ICMS.vICMS;
            vNfe.Det.Last.ICMS.Modbcst:= modBCSTToStr(ICMS.modBCST);
            vNfe.Det.Last.ICMS.Pmvast:= ICMS.pMVAST;
            vNfe.Det.Last.ICMS.Predbcst:= ICMS.pRedBCST;
            vNfe.Det.Last.ICMS.Vbcst:= ICMS.vBCST;
            vNfe.Det.Last.ICMS.Picmsst:= ICMS.pICMSST;
            vNfe.Det.Last.ICMS.Vicmsst:= ICMS.vICMSST;
            vNfe.Det.Last.ICMS.Ufst:= ICMS.UFST;
            vNfe.Det.Last.ICMS.Pbcop:= ICMS.pBCOp;
            vNfe.Det.Last.ICMS.Vbcstret:= ICMS.vBCSTRet;
            vNfe.Det.Last.ICMS.Vicmsstret:= ICMS.vICMSSTRet;
            vNfe.Det.Last.ICMS.Motdesicms:= motDesICMSToStr(ICMS.motDesICMS);
            vNfe.Det.Last.ICMS.Pcredsn:= ICMS.pCredSN;
            vNfe.Det.Last.ICMS.Vcredicmssn:= ICMS.vCredICMSSN;
            vNfe.Det.Last.ICMS.Vbcstdest:= ICMS.vBCSTDest;
            vNfe.Det.Last.ICMS.Vicmsstdest:= ICMS.vICMSSTDest;
            vNfe.Det.Last.ICMS.Vicmsdeson:= ICMS.vICMSDeson;
            vNfe.Det.Last.ICMS.Vicmsop:= ICMS.vICMSOp;
            vNfe.Det.Last.ICMS.Pdif:= ICMS.pDif;
            vNfe.Det.Last.ICMS.Vicmsdif:= ICMS.vICMSDif;
            vNfe.Det.Last.ICMS.Vbcfcp:= ICMS.vBCFCP;
            vNfe.Det.Last.ICMS.Pfcp:= ICMS.pFCP;
            vNfe.Det.Last.ICMS.Vfcp:= ICMS.vFCP;
            vNfe.Det.Last.ICMS.Vbcfcpst:= ICMS.vBCFCPST;
            vNfe.Det.Last.ICMS.Pfcpst:= ICMS.pFCPST;
            vNfe.Det.Last.ICMS.Vfcpst:= ICMS.vFCPST;
            vNfe.Det.Last.ICMS.Vbcfcpstret:= ICMS.vBCFCPSTRet;
            vNfe.Det.Last.ICMS.Pfcpstret:= ICMS.pFCPSTRet;
            vNfe.Det.Last.ICMS.Vfcpstret:= ICMS.vFCPSTRet;
            vNfe.Det.Last.ICMS.Pst:= ICMS.pST;

            vNfe.Det.Last.IPICreate;
            vNfe.Det.Last.IPI.Clenq:= IPI.clEnq;
            vNfe.Det.Last.IPI.Cnpjprod:= IPI.CNPJProd;
            vNfe.Det.Last.IPI.Cselo:= IPI.cSelo;
            vNfe.Det.Last.IPI.Qselo:= IPI.qSelo;
            vNfe.Det.Last.IPI.Cenq:= IPI.cEnq;
            vNfe.Det.Last.IPI.Cst:= CSTIPIToStr(IPI.CST);
            vNfe.Det.Last.IPI.Vbc:= IPI.vBC;
            vNfe.Det.Last.IPI.Qunid:= IPI.qUnid;
            vNfe.Det.Last.IPI.Vunid:= IPI.vUnid;
            vNfe.Det.Last.IPI.Pipi:= IPI.pIPI;
            vNfe.Det.Last.IPI.Vipi:= IPI.vIPI;

            vNfe.Det.Last.IICreate;
            vNfe.Det.Last.II.Vbc:= II.vBc;
            vNfe.Det.Last.II.Vdespadu:= II.vDespAdu;
            vNfe.Det.Last.II.Vii:= II.vII;
            vNfe.Det.Last.II.Viof:= II.vIOF;

            vNfe.Det.Last.PISCreate;
            vNfe.Det.Last.PIS.Cst:= CSTPISToStr(PIS.CST);
            vNfe.Det.Last.PIS.Vbc:= PIS.vBC;
            vNfe.Det.Last.PIS.Ppis:= PIS.pPIS;
            vNfe.Det.Last.PIS.Qbcprod:= PIS.qBCProd;
            vNfe.Det.Last.PIS.Valiqprod:= PIS.vAliqProd;
            vNfe.Det.Last.PIS.Vpis:= PIS.vPIS;

            vNfe.Det.Last.PISSTCreate;
            vNfe.Det.Last.PISST.Vbc:= PISST.vBc;
            vNfe.Det.Last.PISST.Ppis:= PISST.pPis;
            vNfe.Det.Last.PISST.Qbcprod:= PISST.qBCProd;
            vNfe.Det.Last.PISST.Valiqprod:= PISST.vAliqProd;
            vNfe.Det.Last.PISST.Vpis:= PISST.vPIS;

            vNfe.Det.Last.COFINSCreate;
            vNfe.Det.Last.COFINS.Cst:= CSTCOFINSToStr(COFINS.CST);
            vNfe.Det.Last.COFINS.Vbc:= COFINS.vBC;
            vNfe.Det.Last.COFINS.Pcofins:= COFINS.pCOFINS;
            vNfe.Det.Last.COFINS.Qbcprod:= COFINS.qBCProd;
            vNfe.Det.Last.COFINS.Vbcprod:= COFINS.vBCProd;
            vNfe.Det.Last.COFINS.Valiqprod:= COFINS.vAliqProd;
            vNfe.Det.Last.COFINS.Vcofins:= COFINS.vCOFINS;

            vNfe.Det.Last.COFINSSTCreate;
            vNfe.Det.Last.COFINSST.Vbc:= COFINSST.vBC;
            vNfe.Det.Last.COFINSST.Pcofins:= COFINSST.pCOFINS;
            vNfe.Det.Last.COFINSST.Qbcprod:= COFINSST.qBCProd;
            vNfe.Det.Last.COFINSST.Valiqprod:= COFINSST.vAliqProd;
            vNfe.Det.Last.COFINSST.Vcofins:= COFINSST.vCOFINS;

            vNfe.Det.Last.ICMSUFDestCreate;
            vNfe.Det.Last.ICMSUFDest.Vbcufdest:= ICMSUFDest.vBCUFDest;
            vNfe.Det.Last.ICMSUFDest.Vbcfcpufdest:= ICMSUFDest.vBCFCPUFDest;
            vNfe.Det.Last.ICMSUFDest.Pfcpufdest:= ICMSUFDest.pFCPUFDest;
            vNfe.Det.Last.ICMSUFDest.Picmsufdest:= ICMSUFDest.pICMSUFDest;
            vNfe.Det.Last.ICMSUFDest.Picmsinter:= ICMSUFDest.pICMSInter;
            vNfe.Det.Last.ICMSUFDest.Picmsinterpart:= ICMSUFDest.pICMSInterPart;
            vNfe.Det.Last.ICMSUFDest.Vicmsufdest:= ICMSUFDest.vICMSUFDest;
            vNfe.Det.Last.ICMSUFDest.Vfcpufdest:= ICMSUFDest.vFCPUFDest;
            vNfe.Det.Last.ICMSUFDest.Vicmsufremet:= ICMSUFDest.vICMSUFRemet;
          end;
        end;

        vNfe.ICMSTot.Vbc:= Total.ICMSTot.vBC;
        vNfe.ICMSTot.Vicms:= Total.ICMSTot.vICMS;
        vNfe.ICMSTot.Vicmsdeson:= Total.ICMSTot.vICMSDeson;
        vNfe.ICMSTot.Vfcpufdest:= Total.ICMSTot.vFCPUFDest;
        vNfe.ICMSTot.Vicmsufdest:= Total.ICMSTot.vICMSUFDest;
        vNfe.ICMSTot.Vicmsufremet:= Total.ICMSTot.vICMSUFRemet;
        vNfe.ICMSTot.Vfcp:= Total.ICMSTot.vFCP;
        vNfe.ICMSTot.Vbcst:= Total.ICMSTot.vBCST;
        vNfe.ICMSTot.Vst:= Total.ICMSTot.vST;
        vNfe.ICMSTot.Vfcpst:= Total.ICMSTot.vFCPST;
        vNfe.ICMSTot.Vfcpstret:= Total.ICMSTot.vFCPSTRet;
        vNfe.ICMSTot.Vprod:= Total.ICMSTot.vProd;
        vNfe.ICMSTot.Vfrete:= Total.ICMSTot.vFrete;
        vNfe.ICMSTot.Vseg:= Total.ICMSTot.vSeg;
        vNfe.ICMSTot.Vdesc:= Total.ICMSTot.vDesc;
        vNfe.ICMSTot.Vii:= Total.ICMSTot.vII;
        vNfe.ICMSTot.Vipi:= Total.ICMSTot.vIPI;
        vNfe.ICMSTot.Vipidevol:= Total.ICMSTot.vIPIDevol;
        vNfe.ICMSTot.Vpis:= Total.ICMSTot.vPIS;
        vNfe.ICMSTot.Vcofins:= Total.ICMSTot.vCOFINS;
        vNfe.ICMSTot.Voutro:= Total.ICMSTot.vOutro;
        vNfe.ICMSTot.Vnf:= Total.ICMSTot.vNF;
        vNfe.ICMSTot.Vtottrib:= Total.ICMSTot.vTotTrib;

        if not (THelper.ExtendedToString(Cobr.Fat.vLiq) = '0,00') then
        begin
          vNfe.Fat.Nfat:= Cobr.Fat.nFat;
          vNfe.Fat.Vorig:= Cobr.Fat.vOrig;
          vNfe.Fat.Vdesc:= Cobr.Fat.vDesc;
          vNfe.Fat.Vliq:= Cobr.Fat.vLiq;
        end;

        for I:= 0 to Pred(Cobr.Dup.Count) do
        begin
          vNfe.Dup.Add(TNfeCobrDup.Create);
          vNfe.Dup.Last.Ndup:= Cobr.Dup.Items[I].nDup;
          vNfe.Dup.Last.Dvenc:= Cobr.Dup.Items[I].dVenc;
          vNfe.Dup.Last.Vdup:= Cobr.Dup.Items[I].vDup;
        end;

        vNfe.save();

        if (vtype = 1) then
          TNfe.gravarXML(vNfe.Id, vNota.NotasFiscais.Items[0].XML);
      end;
    except on e: Exception do
      raise Exception.Create('Falha ao importar. Erro: ' + e.Message);
    end;
  finally
    if Assigned(vNota) then FreeAndNil(vNota);
    if Assigned(vNfe) then FreeAndNil(vNfe);
    if Assigned(vPessoa) then FreeAndNil(vPessoa);
    if Assigned(vEmpresa) then FreeAndNil(vEmpresa);
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
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ID').AsString:= NfeId;
      FDQuery.Open;
      if (FDQuery.RecordCount = 0) then Exit()
      else
      begin
        Self.configurar(vACBrNF);
        with vACBrNF do
        begin
          if (vtype = 0) and (FDQuery.FieldByName('MODELO').AsInteger = 65) then
            DANFE:= TACBrNFeDANFCeFortes.Create(nil)
          else
            DANFE:= TACBrNFeDANFeRL.Create(nil);

          DANFE.MostraPreview:= True;

          case vtype of
            0: begin
              NotasFiscais.LoadFromString(FDQuery.FieldByName('XML').AsString);
              NotasFiscais.Items[0].Imprimir();
            end;
            1: begin
              EventoNFe.LerXMLFromString(FDQuery.FieldByName('XML_CORRECAO').AsString);
              ImprimirEvento;
            end;
          end;

          DANFE.Free;
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

class function TNfe.itensAjustados(NfeId: string): Boolean;
const
  FSql: string =
  'SELECT N.ID FROM NFE_DET N WHERE (N.EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (N.NFE_ID = :NFE_ID) ' +
  'AND ((N.ITEM_ID IS NULL) OR (N.UNIDADE_CONVERSAO_ID IS NULL))';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('NFE_ID').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('NFE_ID').AsString:= NfeId;
      FDQuery.Open();

      Result:= (FDQuery.RecordCount = 0);
    except
      Result:= False;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TNfe.list(startDate,endDate: TDate; search: string): TObjectList<TNfe>;
const
  FSql: string =
  'SELECT N.ID FROM NFES N ' +
  'LEFT JOIN PESSOAS P ON(P.ID = N.PARTICIPANTE_ID) ' +
  'WHERE (N.EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (N.DELETED_AT IS NULL) ' +
  'AND (N.TPNF_WT = 1) ' +
  'AND (N.DEMI BETWEEN :STARDATE AND :ENDDATE) ' +
  'AND ((P.NOME LIKE :SEARCH) OR (P.NOME IS NULL)) ' +
  'ORDER BY N.CREATED_AT DESC';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('STARDATE').DataType:= ftDate;
      FDQuery.Params.ParamByName('ENDDATE').DataType:= ftDate;
      FDQuery.Params.ParamByName('SEARCH').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('STARDATE').AsDate:= startDate;
      FDQuery.Params.ParamByName('ENDDATE').AsDate:= endDate;
      FDQuery.Params.ParamByName('SEARCH').AsString:= '%' + search + '%';
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TNfe>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TNfe.find(FDQuery.FieldByName('ID').AsString));
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

class procedure TNfe.list(startDate,endDate: TDate; search: string; DataSet: TFDMemTable);
var
  vList: TObjectList<TNfe>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  vList:= TNfe.list(startDate, endDate, search);
  if Assigned(vList) then
  begin
    for I:= 0 to Pred(vList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= vList.Items[I].Id;
      DataSet.FieldByName('MODELO').AsString:= vList.Items[I].Modelo;
      DataSet.FieldByName('SERIE').AsInteger:= vList.Items[I].Serie;
      DataSet.FieldByName('NNF').AsInteger:= vList.Items[I].Nnf;
      DataSet.FieldByName('DEMI').AsDateTime:= vList.Items[I].Demi;
      if Assigned(vList.Items[I].Participante) then
        DataSet.FieldByName('PARTICIPANTE').AsString:= vList.Items[I].Participante.Nome;
      DataSet.FieldByName('VNF').AsExtended:= vList.Items[I].ICMSTot.Vnf;
      DataSet.FieldByName('CSTAT').AsInteger:= vList.Items[I].Cstat;
      DataSet.FieldByName('NSEQEVENTO').AsInteger:= vList.Items[I].Nseqevento;
      case vList.Items[I].Cstat of
        0: DataSet.FieldByName('SITUACAO').AsString:= 'CRIADA';
        99: DataSet.FieldByName('SITUACAO').AsString:= 'CONTINGENCIA';
        100,150: DataSet.FieldByName('SITUACAO').AsString:= 'ENVIADA';
        102: DataSet.FieldByName('SITUACAO').AsString:= 'INUTILIZADA';
        101,151: DataSet.FieldByName('SITUACAO').AsString:= 'CANCELADA';
      end;
      DataSet.Post;
    end;
    FreeAndNil(vList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class procedure TNfe.listNfeEmpresa(startDate, endDate: TDate;
  DataSet: TFDMemTable);
var
  vList: TObjectList<TNfe>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  vList:= TNfe.listNfeEmpresa(startDate,endDate);
  if Assigned(vList) then
  begin
    for I:= 0 to Pred(vList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= vList.Items[I].Id;
      DataSet.FieldByName('TPNF').AsInteger:= vList.Items[I].TpnfWt;
      DataSet.FieldByName('MODELO').AsString:= vList.Items[I].Modelo;
      DataSet.FieldByName('SERIE').AsInteger:= vList.Items[I].Serie;
      DataSet.FieldByName('NNF').AsInteger:= vList.Items[I].Nnf;
      DataSet.FieldByName('DEMI').AsDateTime:= vList.Items[I].Demi;
      case DataSet.FieldByName('MODELO').AsInteger of
        55: DataSet.FieldByName('DSAIENT').AsDateTime:= vList.Items[I].Dsaient;
        65: DataSet.FieldByName('DSAIENT').AsDateTime:= vList.Items[I].Demi;
      end;
      DataSet.FieldByName('CHNFE').AsString:= IfThen(vList.Items[I].Cstat <> 102,vList.Items[I].Chnfe,'');
      DataSet.FieldByName('VNF').AsExtended:= IfThen(vList.Items[I].Cstat <> 102,vList.Items[I].ICMSTot.Vnf,0);
      DataSet.FieldByName('CSTAT').AsInteger:= vList.Items[I].Cstat;
      DataSet.Post;
    end;
    FreeAndNil(vList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TNfe.listNfeEmpresa(startDate, endDate: TDate): TObjectList<TNfe>;
const
  FSql: string =
  'SELECT N.ID FROM NFES N ' +
  'WHERE (N.EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (N.DELETED_AT IS NULL) ' +
  'AND (N.CSTAT IN(100,101,102,150,151))' +
  'AND (((MODELO = 55) AND (N.DSAIENT BETWEEN :STARDATE AND :ENDDATE)) ' +
  'OR ((MODELO = 65) AND (N.DEMI BETWEEN :STARDATE AND :ENDDATE)))' +
  'ORDER BY N.CREATED_AT DESC';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('STARDATE').DataType:= ftDate;
      FDQuery.Params.ParamByName('ENDDATE').DataType:= ftDate;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('STARDATE').AsDate:= startDate;
      FDQuery.Params.ParamByName('ENDDATE').AsDate:= endDate;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TNfe>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TNfe.find(FDQuery.FieldByName('ID').AsString));
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

class function TNfe.listRecebidas(startDate, endDate: TDate;
  search: string): TObjectList<TNfe>;
const
  FSql: string =
  'SELECT N.ID FROM NFES N ' +
  'JOIN PESSOAS P ON(P.ID = N.PARTICIPANTE_ID) ' +
  'WHERE (N.EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (N.DELETED_AT IS NULL) ' +
  'AND (N.TPNF_WT = 0) ' +
  'AND (N.DEMI BETWEEN :STARDATE AND :ENDDATE) ' +
  'AND ((N.NNF LIKE :SEARCH) OR (N.CHNFE LIKE :SEARCH) OR (P.NOME LIKE :SEARCH)) ' +
  'ORDER BY N.DEMI DESC';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('STARDATE').DataType:= ftDate;
      FDQuery.Params.ParamByName('ENDDATE').DataType:= ftDate;
      FDQuery.Params.ParamByName('SEARCH').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('STARDATE').AsDate:= startDate;
      FDQuery.Params.ParamByName('ENDDATE').AsDate:= endDate;
      FDQuery.Params.ParamByName('SEARCH').AsString:= '%' + search + '%';
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TNfe>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TNfe.find(FDQuery.FieldByName('ID').AsString));
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

class procedure TNfe.listRecebidas(startDate, endDate: TDate; search: string;
  DataSet: TFDMemTable);
var
  vList: TObjectList<TNfe>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  vList:= TNfe.listRecebidas(startDate, endDate, search);
  if Assigned(vList) then
  begin
    for I:= 0 to Pred(vList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= vList.Items[I].Id;
      DataSet.FieldByName('MODELO').AsString:= vList.Items[I].Modelo;
      DataSet.FieldByName('SERIE').AsInteger:= vList.Items[I].Serie;
      DataSet.FieldByName('NNF').AsInteger:= vList.Items[I].Nnf;
      DataSet.FieldByName('DEMI').AsDateTime:= vList.Items[I].Demi;
      if Assigned(vList.Items[I].Participante) then
        DataSet.FieldByName('PARTICIPANTE').AsString:= vList.Items[I].Participante.Nome;
      DataSet.FieldByName('VNF').AsExtended:= vList.Items[I].ICMSTot.Vnf;
      DataSet.FieldByName('CHNFE').AsString:= vList.Items[I].Chnfe;
      DataSet.FieldByName('NFERECEBIDA').AsInteger:= vList.Items[I].Nferecebida;
      DataSet.Post;
    end;
    FreeAndNil(vList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class procedure TNfe.loadxml(RetWS: String; MyWebBrowser: TWebBrowser);
begin
  ACBrUtil.WriteToTXT(PathWithDelim(ExtractFileDir(Application.ExeName)) + 'wtsystem.xml',
                        ACBrUtil.ConverteXMLtoUTF8(RetWS), False, False);
  MyWebBrowser.Navigate(PathWithDelim(ExtractFileDir(Application.ExeName)) + 'wtsystem.xml');
end;

class function TNfe.lvendasToNfe(VendaId, lVendas,
  OperacaoFiscalId: string): string;
var
  venda: TVenda;
  v_itens: TObjectList<TVendaItem>;
  v_recebimentos: TObjectList<TVendaRecebimento>;
  nfe: TNfe;
  icms_uf: string;
  icms_cf: TViewCfIcms;
  ipi_cf: TViewCfIpi;
  pis_cf: TViewCfPis;
  cofins_cf: TViewCfCofins;
  I: Integer;
begin
  Result:= EmptyStr;
  try
    try
      v_itens:= nil;
      v_recebimentos:= nil;
      nfe:= nil;
      venda:= TVenda.find(VendaId);
      if not Assigned(venda) then
        raise Exception.Create('Venda não encontrada.');

      v_itens:= TVendaItem.findBylVendaId(lVendas);
      if not Assigned(v_itens) then
        raise Exception.Create('Itens não encontrados.');

      v_recebimentos:= TVendaRecebimento.findBylVendaId(lVendas);
      if not Assigned(v_recebimentos) then
        raise Exception.Create('Recebimentos não encontrados.');

      nfe:= TNfe.Create;
      nfe.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;
      nfe.ParticipanteId:= venda.PessoaId;
      nfe.Cuf:= nfe.Empresa.Uf;
      nfe.OperacaoFiscalId:= OperacaoFiscalId;
      nfe.Natop:= nfe.OperacaoFiscal.Natop;
      nfe.Indpag:= '0';
      nfe.Modelo:= nfe.OperacaoFiscal.Modelo;
      case AnsiIndexStr(nfe.Modelo, ['01','1B','04','55','65']) of
        3: nfe.Serie:= nfe.Empresa.NfeConfiguracao.SerieNfe;
        4: nfe.Serie:= nfe.Empresa.NfeConfiguracao.SerieNfce;
      end;

      if (nfe.Modelo = '55') and (venda.Pessoa.Documento = '00000000000') then
        raise Exception.Create('Nfe para consumidor indisponível. Procedimento foi cancelado!')
      else if (nfe.Modelo = '55') then
        if not venda.Pessoa.validate(1) then
          raise Exception.Create('Procedimento foi cancelado!');

      nfe.Demi:= Now;
      nfe.Dsaient:= Now;
      nfe.Tpnf:= nfe.OperacaoFiscal.Tpnf;
      nfe.TpnfWt:= 1;
      nfe.Iddest:= nfe.OperacaoFiscal.Iddest;
      nfe.Cmunfg:= nfe.Empresa.CodigoMunicipio;
      nfe.Tpimp:= nfe.OperacaoFiscal.Tpimp;
      case AnsiIndexStr(nfe.Empresa.NfeConfiguracao.FormaEmissaoCodigo,['1', '2']) of
        1: begin
          if (nfe.Modelo = '55') then nfe.Tpemis:= '2'
          else if (nfe.Modelo = '65') then nfe.Tpemis:= '9';
          nfe.Dhcont:= Now;
          nfe.Xjust:= 'SEM ACESSO A INTERNET.';
        end;
        else nfe.Tpemis:= '1';
      end;
      nfe.Tpamb:= nfe.Empresa.NfeConfiguracao.AmbienteCodigo;
      nfe.Finnfe:= nfe.OperacaoFiscal.Finnfe;
      nfe.Indfinal:= nfe.OperacaoFiscal.Indfinal;
      nfe.Indpres:= nfe.OperacaoFiscal.Indpres;
      nfe.Procemi:= '0';
      nfe.AutoCalculo:= 'S';

      for I:= 0 to Pred(v_itens.Count) do
      begin
        if not v_itens.Items[I].Item.validade(1) then
          raise Exception.Create('Procedimento foi cancelado!');

        nfe.Det.Add(TNfeDet.Create);
        nfe.Det.Last.ItemId:= v_itens.Items[I].ItemId;
        nfe.Det.Last.Cprod:= nfe.Det.Last.ITEM.Referencia.ToString();
        nfe.Det.Last.Nitem:= (I + 1);
        nfe.Det.Last.Cean:= nfe.Det.Last.ITEM.Ean;
        nfe.Det.Last.Xprod:= nfe.Det.Last.ITEM.Nome;
        nfe.Det.Last.Ncm:= nfe.Det.Last.ITEM.Ncm;
        nfe.Det.Last.Extipi:= nfe.Det.Last.ITEM.Extipi;
        nfe.Det.Last.Ucom:= nfe.Det.Last.ITEM.Unidade.Unidade;
        nfe.Det.Last.Qcom:= v_itens.Items[I].Qtde;
        nfe.Det.Last.Vuncom:= v_itens.Items[I].Unitario;
        nfe.Det.Last.Vprod:= v_itens.Items[I].Subtotal;
        nfe.Det.Last.Ceantrib:= nfe.Det.Last.ITEM.EanTributavel;
        nfe.Det.Last.Utrib:= nfe.Det.Last.ITEM.UnidadeTributave.Unidade;
        nfe.Det.Last.Qtrib:= v_itens.Items[I].Qtde;
        nfe.Det.Last.Vuntrib:= v_itens.Items[I].Unitario;
        nfe.Det.Last.Vfrete:= 0;
        nfe.Det.Last.Vseg:= 0;
        nfe.Det.Last.Vdesc:= v_itens.Items[I].Desconto;
        nfe.Det.Last.Voutro:= v_itens.Items[I].Acrescimo;
        nfe.Det.Last.Indtot:= '1';
        nfe.Det.Last.Cest:= nfe.Det.Last.ITEM.Cest;
        nfe.Det.Last.Vtottrib:= 0;
        nfe.Det.Last.Pdevol:= 0;
        nfe.Det.Last.Vipidevol:= 0;

        if Assigned(nfe.Participante) and (Trim(nfe.Participante.Uf) <> EmptyStr) then
          icms_uf:= nfe.Participante.Uf
        else
          icms_uf:= nfe.Empresa.Uf;

        icms_cf:= TViewCfIcms.find(
          nfe.OperacaoFiscalId,
          nfe.Det.Last.ITEM.GrupoTributarioId,
          icms_uf);

        if not Assigned(icms_cf) then
          raise Exception.Create('ICMS sem dados configurados para o item: ' +
            nfe.Det.Last.ITEM.Nome + ', nas notas fiscais emitidas para a uf: ' +
            icms_uf + ' com natop: ' + nfe.Natop + ' e grupo: ' +
            nfe.Det.Last.ITEM.GrupoTributario.Nome + '. Procedimento foi cancelado!');

        nfe.Det.Last.ICMSCreate;
        nfe.Det.Last.Cfop:= icms_cf.Cfop;
        nfe.Det.Last.ICMS.Orig:= icms_cf.Orig;
        nfe.Det.Last.ICMS.Cst:= icms_cf.Cst;
        nfe.Det.Last.ICMS.Csosn:= icms_cf.Csosn;
        nfe.Det.Last.ICMS.Modbc:= icms_cf.Modbc;
        nfe.Det.Last.ICMS.Predbc:= icms_cf.Predbc;
        nfe.Det.Last.ICMS.Picms:= icms_cf.Picms;
        nfe.Det.Last.ICMS.Modbcst:= icms_cf.Modbcst;
        nfe.Det.Last.ICMS.Pmvast:= icms_cf.Pmvast;
        nfe.Det.Last.ICMS.Predbcst:= icms_cf.Predbcst;
        nfe.Det.Last.ICMS.Picmsst:= icms_cf.Picmsst;
        nfe.Det.Last.ICMS.Motdesicms:= icms_cf.Motdesicms;
        nfe.Det.Last.ICMS.Pcredsn:= icms_cf.Pcredsn;
        nfe.Det.Last.ICMS.Pdif:= icms_cf.Pdif;
        nfe.Det.Last.ICMS.Pfcp:= icms_cf.Pfcp;
        nfe.Det.Last.ICMS.Pfcpst:= icms_cf.Pfcpst;
        nfe.Det.Last.ICMS.Pfcpstret:= icms_cf.Pfcpstret;
        nfe.Det.Last.ICMSUFDestCreate;
        nfe.Det.Last.ICMSUFDest.Pfcpufdest:= icms_cf.Pfcpufdest;
        nfe.Det.Last.ICMSUFDest.Picmsufdest:= icms_cf.Picmsufdest;
        nfe.Det.Last.ICMSUFDest.Picmsinter:= icms_cf.Picmsinter;
        nfe.Det.Last.ICMSUFDest.Picmsinterpart:= icms_cf.Picmsinterpart;
        FreeAndNil(icms_cf);

        ipi_cf:= TViewCfIpi.find(
          nfe.OperacaoFiscalId,
          Nfe.Det.Last.ITEM.GrupoTributarioId);

        if not Assigned(ipi_cf) then
          raise Exception.Create('IPI sem dados configurados para o item: ' +
            nfe.Det.Last.ITEM.Nome + ', com natop: ' + nfe.Natop + ' e grupo: ' +
            nfe.Det.Last.ITEM.GrupoTributario.Nome + '. Procedimento foi cancelado!');

        nfe.Det.Last.IPICreate;
        nfe.Det.Last.IPI.Clenq:= ipi_cf.Clenq;
        nfe.Det.Last.IPI.Cnpjprod:= ipi_cf.Cnpjprod;
        nfe.Det.Last.IPI.Cselo:= ipi_cf.Cselo;
        if (ipi_cf.Qselo > 0) then
          nfe.Det.Last.IPI.Qselo:= ipi_cf.Qselo;
        nfe.Det.Last.IPI.Cenq:= ipi_cf.Cenq;
        nfe.Det.Last.IPI.Cst:= ipi_cf.Cst;
        nfe.Det.Last.IPI.Pipi:= ipi_cf.Pipi;
        nfe.Det.Last.IPI.Vunid:= ipi_cf.Vunid;
        FreeAndNil(ipi_cf);

        nfe.Det.Last.IICreate;

        pis_cf:= TViewCfPis.find(
          nfe.OperacaoFiscalId,
          nfe.Det.Last.ITEM.GrupoTributarioId);

        if not Assigned(pis_cf) then
          raise Exception.Create('PIS sem dados configurados para o item: ' +
            nfe.Det.Last.ITEM.Nome + ', com natop: ' + nfe.Natop + ' e grupo: ' +
            nfe.Det.Last.ITEM.GrupoTributario.Nome + '. Procedimento foi cancelado!');

        nfe.Det.Last.PISCreate;
        nfe.Det.Last.PIS.Cst:= pis_cf.Cst;
        nfe.Det.Last.PIS.Ppis:= pis_cf.Ppis;
        nfe.Det.Last.PIS.Valiqprod:= pis_cf.Valiqprod;
        nfe.Det.Last.PIS.Ppis:= pis_cf.Ppisst;
        nfe.Det.Last.PIS.Valiqprod:= pis_cf.Valiqprodst;
        FreeAndNil(pis_cf);

        cofins_cf:= TViewCfCofins.find(
          Nfe.OperacaoFiscalId,
          nfe.Det.Last.ITEM.GrupoTributarioId);

        if not Assigned(cofins_cf) then
          raise Exception.Create('COFINS sem dados configurados para o item: ' +
            nfe.Det.Last.ITEM.Nome + ', com natop: ' + nfe.Natop + ' e grupo: ' +
            nfe.Det.Last.ITEM.GrupoTributario.Nome + '. Procedimento foi cancelado!');

        nfe.Det.Last.COFINSCreate;
        nfe.Det.Last.COFINS.Cst:= cofins_cf.Cst;
        nfe.Det.Last.COFINS.Pcofins:= cofins_cf.Pcofins;
        nfe.Det.Last.COFINS.Valiqprod:= cofins_cf.Valiqprod;
        nfe.Det.Last.COFINS.Pcofins:= cofins_cf.Pcofinsst;
        nfe.Det.Last.COFINS.Valiqprod:= cofins_cf.Valiqprodst;
        FreeAndNil(cofins_cf);
      end;

      for I:= 0 to Pred(v_recebimentos.Count) do
      begin
        nfe.Pag.Add(TNfePag.Create);
        nfe.Pag.Last.Tpag:= v_recebimentos.Items[I].Tpag;
        nfe.Pag.Last.Vpag:= v_recebimentos.Items[I].Recebido;
        nfe.Pag.Last.Tpintegra:= '2';
        nfe.Pag.Last.Cnpj:= '';
        nfe.Pag.Last.Tband:= '';
        nfe.Pag.Last.Caut:= '';
        nfe.Pag.Last.Vtroco:= v_recebimentos.Items[I].Troco;
      end;

      nfe.processaCalculos();
      lVendas:= StringReplace(lVendas, Chr(39), '', [rfReplaceAll]);
      TAuthService.lVendas:= StringReplace(lVendas,',','|',[rfReplaceAll])+ '|';
      if nfe.save then Result:= nfe.Id;
    except on e: Exception do
      THelper.Mensagem(e.Message);
    end;
  finally
    if Assigned(venda) then FreeAndNil(venda);
    if Assigned(v_itens) then FreeAndNil(v_itens);
    if Assigned(v_recebimentos) then FreeAndNil(v_recebimentos);
    if Assigned(nfe) then FreeAndNil(nfe);
  end;
end;

class procedure TNfe.manifestarCiencia(NfeId: string);
var
  vEmpresa: TEmpresa;
  vNfe: TNfe;
  vNota: TACBrNFe;
  vLoteId: Integer;
begin
  try
    vEmpresa:= nil;
    vNfe:= nil;
    vNota:= nil;
    try
      vEmpresa:= TEmpresa.find(TAuthService.getAuthenticatedEmpresaId);
      if not Assigned(vEmpresa) then
        raise Exception.Create('Falha ao consultar dados da empresa.');

      vNfe:= TNfe.find(NfeId);
      if not Assigned(vNfe) then
        raise Exception.Create('Falha ao consultar dados da nota fiscal.');

      vNota:= TACBrNFe.Create(nil);
      Self.configurar(vNota);

      with vNota.EventoNFe.Evento.Add() do
      begin
        infEvento.cOrgao:= 91;
        infEvento.chNFe:= vNfe.Chnfe;
        infEvento.CNPJ:= vEmpresa.Documento;
        infEvento.dhEvento:= Now;
        infEvento.tpEvento:= teManifDestCiencia;
      end;

      vLoteId:= StrToIntDef(FormatDateTime('yymmddhhmm', NOW), 1);

      if vNota.EnviarEvento(vLoteId) then
      begin
        with vNota.WebServices do
        begin
          case EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat of
            135,573:begin
              DistribuicaoDFe.retDistDFeInt.docZip.Clear;

              vNota.DistribuicaoDFePorChaveNFe(
                UFtoCUF(vEmpresa.Uf),
                vEmpresa.Documento,
                vNfe.Chnfe
              );

              Self.GravarXML(NfeId,DistribuicaoDFe.retDistDFeInt.docZip.Items[0].XML);
              Self.importarXML(DistribuicaoDFe.retDistDFeInt.docZip.Items[0].XML);
            end;
            else
            begin
              raise Exception.CreateFmt(
                'Ocorreu o seguinte erro ao manifestar ciência da nota fiscal: ' +
                ' Código: %d' +
                ' Motivo: %s', [
                  EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat,
                  EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo
              ]);
            end
          end;
        end;
      end
      else
      begin
        with vNota.WebServices.EnvEvento do
        begin
          raise Exception.Create(
            'Ocorreram erros ao tentar manifestar ciência: ' +
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
    if Assigned(vEmpresa) then FreeAndNil(vEmpresa);
    if Assigned(vNota) then FreeAndNil(vNota);
    if Assigned(vNfe) then FreeAndNil(vNfe);
  end;
end;

class procedure TNfe.nfeToEfd(NfeId, OFId: string);
var
  vNfe: TNfe;
  I: Integer;
  vIcmsCf: TViewCfIcms;
  vIpiCf: TViewCfIpi;
  vPisCf: TViewCfPis;
  vCofinsCf: TViewCfCofins;
begin
  try
    vIcmsCf:= nil;
    vIpiCf:= nil;
    vPisCf:= nil;
    vCofinsCf:= nil;
    try
      vNfe:= TNfe.find(NfeId);
      if not Assigned(vNfe) then
        raise Exception.Create('Falha ao consultar dados da nota fiscal.');

      vNfe.OperacaoFiscalId:= OFId;
      vNfe.Natop:= vNfe.OperacaoFiscal.Natop;
      vNfe.Tpnf:= vNfe.OperacaoFiscal.Tpnf;

      for I:= 0 to Pred(vNfe.Det.Count) do
      begin
        vIcmsCf:= TViewCfIcms.find(
          vNfe.OperacaoFiscalId,
          vNfe.Det.Items[I].ITEM.GrupoTributarioId,
          vNfe.Participante.Uf);

        if not Assigned(vIcmsCf) then
          raise Exception.Create('ICMS sem dados configurados para o item: ' +
            vNfe.Det.Items[I].ITEM.Nome + ', nas notas fiscais emitidas para a uf: ' +
              vNfe.Participante.Uf + ' com natop: ' + vNfe.Natop + ' e grupo: ' +
                vNfe.Det.Items[I].ITEM.GrupoTributario.Nome + '. Procedimento foi cancelado!');

        vIpiCf:= TViewCfIpi.find(
          vNfe.OperacaoFiscalId,
          vNfe.Det.Items[I].ITEM.GrupoTributarioId);

        if not Assigned(vIpiCf) then
          raise Exception.Create('IPI sem dados configurados para o item: ' +
            vNfe.Det.Items[I].ITEM.Nome + ', com natop: ' + vNfe.Natop + ' e grupo: ' +
            vNfe.Det.Items[I].ITEM.GrupoTributario.Nome + '. Procedimento foi cancelado!');

        vPisCf:= TViewCfPis.find(
          vNfe.OperacaoFiscalId,
          vNfe.Det.Items[I].ITEM.GrupoTributarioId);

        if not Assigned(vPisCf) then
          raise Exception.Create('PIS sem dados configurados para o item: ' +
            vNfe.Det.Items[I].ITEM.Nome + ', com natop: ' + vNfe.Natop + ' e grupo: ' +
            vNfe.Det.Items[I].ITEM.GrupoTributario.Nome + '. Procedimento foi cancelado!');

        vCofinsCf:= TViewCfCofins.find(
          vNfe.OperacaoFiscalId,
          vNfe.Det.Items[I].ITEM.GrupoTributarioId);

        if not Assigned(vCofinsCf) then
          raise Exception.Create('COFINS sem dados configurados para o item: ' +
            vNfe.Det.Items[I].ITEM.Nome + ', com natop: ' + vNfe.Natop + ' e grupo: ' +
            vNfe.Det.Items[I].ITEM.GrupoTributario.Nome + '. Procedimento foi cancelado!');

        vNfe.Det.Items[I].Cfop:= vIcmsCf.Cfop;
        vNfe.Det.Items[I].ICMS.Cst:= IfThen(vIcmsCf.Cst = '', 'SN', vIcmsCf.Cst);
        vNfe.Det.Items[I].ICMS.Csosn:= IfThen(vIcmsCf.Csosn = '', '0', vIcmsCf.Csosn);
        vNfe.Det.Items[I].IPI.Cst:= vIpiCf.Cst;
        vNfe.Det.Items[I].PIS.Cst:= vPisCf.Cst;
        vNfe.Det.Items[I].COFINS.Cst:= vCofinsCf.Cst;

        FreeAndNil(vIcmsCf);
        FreeAndNil(vIpiCf);
        FreeAndNil(vPisCf);
        FreeAndNil(vCofinsCf);
      end;

      vNfe.Nferecebida:= 4;
      vNfe.save();
    except on e: Exception do
      raise Exception.Create(e.Message);
    end;
  finally
    FreeAndNil(vIcmsCf);
    FreeAndNil(vIpiCf);
    FreeAndNil(vPisCf);
    FreeAndNil(vCofinsCf);
    FreeAndNil(vNfe);
  end;
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
    Self.ICMSTot.Vfcpufdest:= (Self.ICMSTot.Vfcpufdest + Self.Det.Items[I].ICMSUFDest.Vfcpufdest);
    Self.ICMSTot.Vicmsufdest:= (Self.ICMSTot.Vicmsufdest + Self.Det.Items[I].ICMSUFDest.Vicmsufdest);
    Self.ICMSTot.Vicmsufremet:= (Self.ICMSTot.Vicmsufremet + Self.Det.Items[I].ICMSUFDest.Vicmsufremet);
    Self.ICMSTot.Vfcp:= (Self.ICMSTot.Vfcp + Self.Det.Items[I].ICMS.Vfcp);
    Self.ICMSTot.Vbcst:= (Self.ICMSTot.Vbcst + Self.Det.Items[I].ICMS.Vbcst);
    Self.ICMSTot.Vst:= (Self.ICMSTot.Vst + Self.Det.Items[I].ICMS.Vicmsst);
    Self.ICMSTot.Vfcpst:= (Self.ICMSTot.Vfcpst + Self.Det.Items[I].ICMS.Vfcpst);
    Self.ICMSTot.Vfcpstret:= (Self.ICMSTot.Vfcpstret + Self.Det.Items[I].ICMS.Vfcpstret);
    Self.ICMSTot.Vprod:= (Self.ICMSTot.Vprod + Self.Det.Items[I].Vprod);
    Self.ICMSTot.Vfrete:= (Self.ICMSTot.Vfrete + Self.Det.Items[I].Vfrete);
    Self.ICMSTot.Vseg:= (Self.ICMSTot.Vseg + Self.Det.Items[I].Vseg);
    Self.ICMSTot.Vdesc:= (Self.ICMSTot.Vdesc + Self.Det.Items[I].Vdesc);
    Self.ICMSTot.Vii:= (Self.ICMSTot.Vii + Self.Det.Items[I].II.Vii);
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
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      if (Self.Nnf = 0) and (StrToIntDef(Self.Modelo, 0) in[55,65]) then
      begin
        Self.Nnf:= Self.getNfeNumero(StrToIntDef(Self.Modelo, 0), Self.Serie);
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
        Self.Det.Items[I].save;
      end;

      if Assigned(Self.ICMSTot) then
      begin
        Self.ICMSTot.NfeId:= Self.Id;
        Self.ICMSTot.save;
      end;

      if Assigned(Self.ISSQNtot) then
      begin
        Self.ISSQNtot.NfeId:= Self.Id;
        Self.ISSQNtot.save;
      end;

      if Assigned(Self.RetTrib) then
      begin
        Self.RetTrib.NfeId:= Self.Id;
        Self.RetTrib.save;
      end;

      if Assigned(Self.Transp) then
      begin
        Self.Transp.NfeId:= Self.Id;
        Self.Transp.save;
      end;

      if Assigned(Self.Fat) then
      begin
        Self.Fat.NfeId:= Self.Id;
        Self.Fat.save;
      end;

      for I:= 0 to Pred(Self.Dup.Count) do
      begin
        Self.Dup.Items[I].NfeId:= Self.Id;
        Self.Dup.Items[I].save;
      end;

      for I:= 0 to Pred(Self.Pag.Count) do
      begin
        Self.Pag.Items[I].NfeId:= Self.Id;
        Self.Pag.Items[I].save;
      end;

      if (TAuthService.lVendas <> EmptyStr) then
      begin
        FDQuery.SQL.Clear;
        FDQuery.SQL.Add('INSERT INTO NFE_VENDAS (NFE_ID, VENDA_ID) VALUES (:NFE_ID, :VENDA_ID)');
        FDQuery.Params.ParamByName('NFE_ID').DataType:= ftFixedWideChar;
        FDQuery.Params.ParamByName('VENDA_ID').DataType:= ftFixedWideChar;
        FDQuery.Prepare;
        FDQuery.Params.ParamByName('NFE_ID').AsString:= Self.Id;
        while not (TAuthService.lVendas = EmptyStr) do
        begin
          FDQuery.Params.ParamByName('VENDA_ID').AsString:=
            THelper.DevolveConteudoDelimitado('|', TAuthService.lVendas);
          FDQuery.ExecSQL;
        end;
      end
      else if (TAuthService.CompraId <> EmptyStr) then
      begin
        FDQuery.SQL.Clear();
        FDQuery.SQL.Add('UPDATE COMPRAS SET NFE_ID = :NFE_ID WHERE (ID = :COMPRA_ID)');
        FDQuery.Params.ParamByName('NFE_ID').DataType:= ftString;
        FDQuery.Params.ParamByName('COMPRA_ID').DataType:= ftString;
        FDQuery.Prepare();
        FDQuery.Params.ParamByName('NFE_ID').AsString:= Self.Id;
        FDQuery.Params.ParamByName('COMPRA_ID').AsString:= TAuthService.CompraId;
        FDQuery.ExecSQL();
      end;

      Self.Commit;
    except on e: Exception do
    begin
      Self.Rollback;
      Result:= False;
      raise Exception.Create('falha ao inserir a nfe. erro: ' + e.Message);
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
        Self.Det.Items[I].save;
      end;

      if Assigned(Self.ICMSTot) then
      begin
        Self.ICMSTot.NfeId:= Self.Id;
        Self.ICMSTot.save;
      end;

      if Assigned(Self.ISSQNtot) then
      begin
        Self.ISSQNtot.NfeId:= Self.Id;
        Self.ISSQNtot.save;
      end;

      if Assigned(Self.RetTrib) then
      begin
        Self.RetTrib.NfeId:= Self.Id;
        Self.RetTrib.save;
      end;

      if Assigned(Self.Transp) then
      begin
        Self.Transp.NfeId:= Self.Id;
        Self.Transp.save;
      end;

      if Assigned(Self.Fat) then
      begin
        Self.Fat.NfeId:= Self.Id;
        Self.Fat.save;
      end;

      if (Self.Dup.Count >= 1) then
        if (Self.Dup.First.Id = EmptyStr) then
        begin
          TNfeCobrDup.removeByNfeId(Self.Id);
          for I:= 0 to Pred(Self.Dup.Count) do
          begin
            Self.Dup.Items[I].NfeId:= Self.Id;
            Self.Dup.Items[I].save;
          end;
        end;

      if (Self.Pag.Count >= 1) then
        if (Self.Pag.First.Id = EmptyStr) then
        begin
          TNfePag.removeByNfeId(Self.Id);

          for I:= 0 to Pred(Self.Pag.Count) do
          begin
            Self.Pag.Items[I].NfeId:= Self.Id;
            Self.Pag.Items[I].save;
          end;
        end;

      Self.Commit;
    except on e: Exception do
    begin
      Self.Rollback;
      Result:= False;
      raise Exception.Create('falha ao atualizar a nfe. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TNfe.vendaToNfe(VendaId, OperacaoFiscalId: string): string;
var
  venda: TVenda;
  nfe: TNfe;
  icms_uf: string;
  icms_cf: TViewCfIcms;
  ipi_cf: TViewCfIpi;
  pis_cf: TViewCfPis;
  cofins_cf: TViewCfCofins;
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
      nfe.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;
      nfe.ParticipanteId:= venda.PessoaId;
      nfe.Cuf:= nfe.Empresa.Uf;
      nfe.OperacaoFiscalId:= OperacaoFiscalId;
      nfe.Natop:= nfe.OperacaoFiscal.Natop;
      nfe.Indpag:= '0';
      nfe.Modelo:= nfe.OperacaoFiscal.Modelo;
      case AnsiIndexStr(nfe.Modelo, ['01','1B','04','55','65']) of
        3: nfe.Serie:= nfe.Empresa.NfeConfiguracao.SerieNfe;
        4: nfe.Serie:= nfe.Empresa.NfeConfiguracao.SerieNfce;
      end;

      if (nfe.Modelo = '55') and (venda.Pessoa.Documento = '00000000000') then
        raise Exception.Create('Nfe para consumidor indisponível. Procedimento foi cancelado!')
      else if (nfe.Modelo = '55') then
        if not venda.Pessoa.validate(1) then
          raise Exception.Create('Procedimento foi cancelado!');

      nfe.Demi:= Now;
      nfe.Dsaient:= Now;
      nfe.Tpnf:= nfe.OperacaoFiscal.Tpnf;
      nfe.TpnfWt:= 1;
      nfe.Iddest:= nfe.OperacaoFiscal.Iddest;
      nfe.Cmunfg:= nfe.Empresa.CodigoMunicipio;
      nfe.Tpimp:= nfe.OperacaoFiscal.Tpimp;
      case AnsiIndexStr(nfe.Empresa.NfeConfiguracao.FormaEmissaoCodigo,['1', '2']) of
        1: begin
          if (nfe.Modelo = '55') then nfe.Tpemis:= '2'
          else if (nfe.Modelo = '65') then nfe.Tpemis:= '9';
          nfe.Dhcont:= Now;
          nfe.Xjust:= 'SEM ACESSO A INTERNET.';
        end;
        else nfe.Tpemis:= '1';
      end;
      nfe.Tpamb:= nfe.Empresa.NfeConfiguracao.AmbienteCodigo;
      nfe.Finnfe:= nfe.OperacaoFiscal.Finnfe;
      nfe.Indfinal:= nfe.OperacaoFiscal.Indfinal;
      nfe.Indpres:= nfe.OperacaoFiscal.Indpres;
      nfe.Procemi:= '0';
      nfe.AutoCalculo:= 'S';

      for I:= 0 to Pred(venda.Itens.Count) do
      begin
        if not venda.Itens.Items[I].Item.validade(1) then
          raise Exception.Create('Procedimento foi cancelado!');

        nfe.Det.Add(TNfeDet.Create);
        nfe.Det.Last.ItemId:= venda.Itens.Items[I].ItemId;
        nfe.Det.Last.Cprod:= nfe.Det.Last.ITEM.Referencia.ToString();
        nfe.Det.Last.Nitem:= (I + 1);
        nfe.Det.Last.Cean:= nfe.Det.Last.ITEM.Ean;
        nfe.Det.Last.Xprod:= nfe.Det.Last.ITEM.Nome;
        nfe.Det.Last.Ncm:= nfe.Det.Last.ITEM.Ncm;
        nfe.Det.Last.Extipi:= nfe.Det.Last.ITEM.Extipi;
        nfe.Det.Last.Ucom:= nfe.Det.Last.ITEM.Unidade.Unidade;
        nfe.Det.Last.Qcom:= venda.Itens.Items[I].Qtde;
        nfe.Det.Last.Vuncom:= venda.Itens.Items[I].Unitario;
        nfe.Det.Last.Vprod:= venda.Itens.Items[I].Subtotal;
        nfe.Det.Last.Ceantrib:= nfe.Det.Last.ITEM.EanTributavel;
        nfe.Det.Last.Utrib:= nfe.Det.Last.ITEM.UnidadeTributave.Unidade;
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

        if (nfe.Modelo = '65') then
          icms_uf:= nfe.Empresa.Uf
        else if Assigned(nfe.Participante) and (Trim(nfe.Participante.Uf) <> EmptyStr) then
          icms_uf:= nfe.Participante.Uf
        else
          icms_uf:= nfe.Empresa.Uf;

        icms_cf:= TViewCfIcms.find(
          nfe.OperacaoFiscalId,
          nfe.Det.Last.ITEM.GrupoTributarioId,
          icms_uf);

        if not Assigned(icms_cf) then
          raise Exception.Create('ICMS sem dados configurados para o item: ' +
            nfe.Det.Last.ITEM.Nome + ', nas notas fiscais emitidas para a uf: ' +
            icms_uf + ' com natop: ' + nfe.Natop + ' e grupo: ' +
            nfe.Det.Last.ITEM.GrupoTributario.Nome + '. Procedimento foi cancelado!');

        nfe.Det.Last.ICMSCreate;
        nfe.Det.Last.Cfop:= icms_cf.Cfop;
        nfe.Det.Last.ICMS.Orig:= icms_cf.Orig;
        nfe.Det.Last.ICMS.Cst:= icms_cf.Cst;
        nfe.Det.Last.ICMS.Csosn:= icms_cf.Csosn;
        nfe.Det.Last.ICMS.Modbc:= icms_cf.Modbc;
        nfe.Det.Last.ICMS.Predbc:= icms_cf.Predbc;
        nfe.Det.Last.ICMS.Picms:= icms_cf.Picms;
        nfe.Det.Last.ICMS.Modbcst:= icms_cf.Modbcst;
        nfe.Det.Last.ICMS.Pmvast:= icms_cf.Pmvast;
        nfe.Det.Last.ICMS.Predbcst:= icms_cf.Predbcst;
        nfe.Det.Last.ICMS.Picmsst:= icms_cf.Picmsst;
        nfe.Det.Last.ICMS.Motdesicms:= icms_cf.Motdesicms;
        nfe.Det.Last.ICMS.Pcredsn:= icms_cf.Pcredsn;
        nfe.Det.Last.ICMS.Pdif:= icms_cf.Pdif;
        nfe.Det.Last.ICMS.Pfcp:= icms_cf.Pfcp;
        nfe.Det.Last.ICMS.Pfcpst:= icms_cf.Pfcpst;
        nfe.Det.Last.ICMS.Pfcpstret:= icms_cf.Pfcpstret;
        nfe.Det.Last.ICMSUFDestCreate;
        nfe.Det.Last.ICMSUFDest.Pfcpufdest:= icms_cf.Pfcpufdest;
        nfe.Det.Last.ICMSUFDest.Picmsufdest:= icms_cf.Picmsufdest;
        nfe.Det.Last.ICMSUFDest.Picmsinter:= icms_cf.Picmsinter;
        nfe.Det.Last.ICMSUFDest.Picmsinterpart:= icms_cf.Picmsinterpart;
        FreeAndNil(icms_cf);

        ipi_cf:= TViewCfIpi.find(
          nfe.OperacaoFiscalId,
          Nfe.Det.Last.ITEM.GrupoTributarioId);

        if not Assigned(ipi_cf) then
          raise Exception.Create('IPI sem dados configurados para o item: ' +
            nfe.Det.Last.ITEM.Nome + ', com natop: ' + nfe.Natop + ' e grupo: ' +
            nfe.Det.Last.ITEM.GrupoTributario.Nome + '. Procedimento foi cancelado!');

        nfe.Det.Last.IPICreate;
        nfe.Det.Last.IPI.Clenq:= ipi_cf.Clenq;
        nfe.Det.Last.IPI.Cnpjprod:= ipi_cf.Cnpjprod;
        nfe.Det.Last.IPI.Cselo:= ipi_cf.Cselo;
        if (ipi_cf.Qselo > 0) then
          nfe.Det.Last.IPI.Qselo:= ipi_cf.Qselo;
        nfe.Det.Last.IPI.Cenq:= ipi_cf.Cenq;
        nfe.Det.Last.IPI.Cst:= ipi_cf.Cst;
        nfe.Det.Last.IPI.Pipi:= ipi_cf.Pipi;
        nfe.Det.Last.IPI.Vunid:= ipi_cf.Vunid;
        FreeAndNil(ipi_cf);

        nfe.Det.Last.IICreate;

        pis_cf:= TViewCfPis.find(
          nfe.OperacaoFiscalId,
          nfe.Det.Last.ITEM.GrupoTributarioId);

        if not Assigned(pis_cf) then
          raise Exception.Create('PIS sem dados configurados para o item: ' +
            nfe.Det.Last.ITEM.Nome + ', com natop: ' + nfe.Natop + ' e grupo: ' +
            nfe.Det.Last.ITEM.GrupoTributario.Nome + '. Procedimento foi cancelado!');

        nfe.Det.Last.PISCreate;
        nfe.Det.Last.PIS.Cst:= pis_cf.Cst;
        nfe.Det.Last.PIS.Ppis:= pis_cf.Ppis;
        nfe.Det.Last.PIS.Valiqprod:= pis_cf.Valiqprod;
        nfe.Det.Last.PIS.Ppis:= pis_cf.Ppisst;
        nfe.Det.Last.PIS.Valiqprod:= pis_cf.Valiqprodst;
        FreeAndNil(pis_cf);

        cofins_cf:= TViewCfCofins.find(
          Nfe.OperacaoFiscalId,
          nfe.Det.Last.ITEM.GrupoTributarioId);

        if not Assigned(cofins_cf) then
          raise Exception.Create('COFINS sem dados configurados para o item: ' +
            nfe.Det.Last.ITEM.Nome + ', com natop: ' + nfe.Natop + ' e grupo: ' +
            nfe.Det.Last.ITEM.GrupoTributario.Nome + '. Procedimento foi cancelado!');

        nfe.Det.Last.COFINSCreate;
        nfe.Det.Last.COFINS.Cst:= cofins_cf.Cst;
        nfe.Det.Last.COFINS.Pcofins:= cofins_cf.Pcofins;
        nfe.Det.Last.COFINS.Valiqprod:= cofins_cf.Valiqprod;
        nfe.Det.Last.COFINS.Pcofins:= cofins_cf.Pcofinsst;
        nfe.Det.Last.COFINS.Valiqprod:= cofins_cf.Valiqprodst;
        FreeAndNil(cofins_cf);
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
      if nfe.save then Result:= nfe.Id;
    except on e: Exception do
      THelper.Mensagem(e.Message);
    end;
  finally
    if Assigned(venda) then FreeAndNil(venda);
    if Assigned(nfe) then FreeAndNil(nfe);
  end;
end;

end.
