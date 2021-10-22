unit Sped;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  ACBrSpedFiscal, Vcl.Forms, Empresa, ACBrEFDBlocos, System.StrUtils;

type
  TSped = class(TModel)
  private
    FEMPRESA_ID: String;
    FCOD_VER: Integer;
    FCOD_FIN: Integer;
    FDT_INI: TDateTime;
    FDT_FIN: TDateTime;
    FIND_PERFIL: String;
    FIND_ATIV: Integer;
    FSPED_STATUS: Integer;
    FEMPRESA: TEmpresa;

    function getEmpresa: TEmpresa;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    function delete(): Boolean;

    class function find(id: string): TSped;
    class function list(): TObjectList<TSped>; overload;
    class procedure list(DataSet: TFDMemTable); overload;
    class procedure gerar(id: string);
    class procedure importarEFD(id, vPath: string);
    class procedure exportarEFD(id, vPath: string);

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property CodVer: Integer  read FCOD_VER write FCOD_VER;
    property CodFin: Integer  read FCOD_FIN write FCOD_FIN;
    property DtIni: TDateTime  read FDT_INI write FDT_INI;
    property DtFin: TDateTime  read FDT_FIN write FDT_FIN;
    property IndPerfil: String  read FIND_PERFIL write FIND_PERFIL;
    property IndAtiv: Integer  read FIND_ATIV write FIND_ATIV;
    property SpedStatus: Integer  read FSPED_STATUS write FSPED_STATUS;

    property Empresa: TEmpresa read getEmpresa;
  end;

implementation

uses
  AuthService, ViewSped0150, ViewSped0190, ViewSped0200, ViewSpedC100,
  ViewSpedC190, Helper;

{ TSped }

constructor TSped.Create;
begin
  Self.Table:= 'SPED';
end;

function TSped.delete: Boolean;
begin

end;

destructor TSped.Destroy;
begin
  if Assigned(FEMPRESA) then FreeAndNil(FEMPRESA);

  inherited;
end;

class procedure TSped.exportarEFD(id, vPath: string);
const
  FSql: string = 'SELECT S.SPED FROM SPED S WHERE (ID = :ID)';
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
      TBlobField(FDQuery.FieldByName('SPED')).SaveToFile(vPath);
    except on e: Exception do
      raise Exception.Create('Falha ao exportar sped. Erro: ' + e.Message);
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TSped.find(id: string): TSped;
const
  FSql: string = 'SELECT * FROM SPED WHERE (ID = :ID)';
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
        Result:= TSped.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.CodVer:= FDQuery.FieldByName('COD_VER').AsInteger;
        Result.CodFin:= FDQuery.FieldByName('COD_FIN').AsInteger;
        Result.DtIni:= FDQuery.FieldByName('DT_INI').AsDateTime;
        Result.DtFin:= FDQuery.FieldByName('DT_FIN').AsDateTime;
        Result.IndPerfil:= FDQuery.FieldByName('IND_PERFIL').AsString;
        Result.IndAtiv:= FDQuery.FieldByName('IND_ATIV').AsInteger;
        Result.SpedStatus:= FDQuery.FieldByName('SPED_STATUS').AsInteger;
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

class procedure TSped.gerar(id: string);
var
  vEFD: TACBrSPEDFiscal;
  vSPED: TSped;
  vDiretorio: string;
  vReferente: string;
  vParticipantes: TObjectList<TViewSped0150>;
  I,J: Integer;
  vContribuinte: string;
  vUnidades: TObjectList<TViewSped0190>;
  vItens: TObjectList<TViewSped0200>;
  vNfes: TObjectList<TViewSpedC100>;
  vC190L: TObjectList<TViewSpedC190>;
begin
  try
    vEFD:= TACBrSPEDFiscal.Create(nil);
    try
      vSPED:= TSped.find(id);
      if not Assigned(vSPED) then
        raise Exception.Create('Falha ao consultar dados de SPED.');

      vDiretorio:= ExtractFileDir(Application.ExeName) + '\efd';

      if not DirectoryExists(vDiretorio) then
        ForceDirectories(vDiretorio);

      vReferente:= FormatDateTime('yyyymm',vSPED.DtIni);
      vContribuinte:= IfThen(vSPED.Empresa.TipoPessoa = 'J', vSPED.Empresa.RazaoSocial, vSPED.Empresa.Nome);

      vDiretorio:= vDiretorio + '\EFD-' +
        UpperCase(vReferente + '-' +
          StringReplace(vContribuinte,' ','',[rfReplaceAll])) + '.txt';

      vEFD.Arquivo:= vDiretorio;
      vEFD.DT_INI:= vSPED.DtIni;
      vEFD.DT_FIN:= vSPED.DtFin;
      vEFD.LinhasBuffer:= 2000;
      vEFD.IniciaGeracao;

      with vEFD.Bloco_0 do
      begin
        //-- registro 0000: abertura e entidade
        with Registro0000New do
        begin
          COD_VER:= TACBrCodVer(vSPED.CodVer);
          COD_FIN:= TACBrCodFinalidade(vSPED.CodFin);
          DT_INI:= vSPED.DtIni;
          DT_FIN:= vSPED.DtFin;
          IND_PERFIL:= StrToIndPerfil(vSPED.IndPerfil);

          if (vSPED.Empresa.TipoPessoa = 'J') then
          begin
            NOME:= vSPED.Empresa.RazaoSocial;
            CNPJ:= vSPED.Empresa.Documento;
          end
          else
          begin
            NOME:= vSPED.Empresa.Nome;
            CPF:= vSPED.Empresa.Documento;
          end;
          UF:= vSPED.Empresa.Uf;
          IE:= vSPED.Empresa.Ie;
          COD_MUN:= StrToIntDef(vSPED.Empresa.CodigoMunicipio,0);
          IM:= vSPED.Empresa.Im;
          SUFRAMA:= '';
          IND_ATIV:= TACBrIndAtiv(vSPED.IndAtiv);
        end;

        with Registro0001New do
        begin
          IND_MOV:= imComDados;

          //-- registro 0005: entidade, dados complementares
          with Registro0005New do
          begin
            if (vSPED.Empresa.TipoPessoa = 'J') then
              FANTASIA:= vSPED.Empresa.Nome
            else
              FANTASIA:= '';
            CEP:= vSPED.Empresa.Cep;
            ENDERECO:= vSPED.Empresa.Logradouro;
            NUM:= vSPED.Empresa.Numero;
            COMPL:= vSPED.Empresa.Complemento;
            BAIRRO:= vSPED.Empresa.Bairro;
            FONE:= vSPED.Empresa.Fone;
            FAX:= '';
            EMAIL:= vSPED.Empresa.Email;
          end;

          //-- registro 0100: contabilista
          with Registro0100New do
          begin
            NOME:= vSPED.Empresa.Contabilista.Nome;
            CPF:= vSPED.Empresa.Contabilista.Cpf;
            CRC:= vSPED.Empresa.Contabilista.Crc;
            CNPJ:= vSPED.Empresa.Contabilista.Cnpj;
            CEP:= vSPED.Empresa.Contabilista.Cep;
            ENDERECO:= vSPED.Empresa.Contabilista.Logradouro;
            NUM:= vSPED.Empresa.Contabilista.Numero;
            COMPL:= vSPED.Empresa.Contabilista.Complemento;
            BAIRRO:= vSPED.Empresa.Contabilista.Bairro;
            FONE:= vSPED.Empresa.Contabilista.Fone;
            FAX:= vSPED.Empresa.Contabilista.Fax;
            EMAIL:= vSPED.Empresa.Contabilista.Email;
            COD_MUN:= StrToIntDef(vSPED.Empresa.Contabilista.CodigoMunicipio,0);
          end;

          //-- registro 0150: participantes
          vParticipantes:= TViewSped0150.list(vSPED.EmpresaId, vReferente);
          if Assigned(vParticipantes) then
          begin
            for I:= 0 to Pred(vParticipantes.Count) do
            begin
              with Registro0150New do
              begin
                COD_PART:= vParticipantes.Items[I].Pessoa.Referencia.ToString();
                if vParticipantes.Items[I].Pessoa.TipoPessoa = 'J' then
                begin
                  NOME:= vParticipantes.Items[I].Pessoa.RazaoSocial;
                  CNPJ:= vParticipantes.Items[I].Pessoa.Documento;
                  CPF:= '';
                end
                else
                begin
                  NOME:= vParticipantes.Items[I].Pessoa.Nome;
                  CNPJ:= '';
                  CPF:= vParticipantes.Items[I].Pessoa.Documento;
                end;
                COD_PAIS:= '1058';
                IE        := vParticipantes.Items[I].Pessoa.Ie;
                COD_MUN   := StrToIntDef(vParticipantes.Items[I].Pessoa.CodigoMunicipio,0);
                SUFRAMA   := '';
                ENDERECO  := vParticipantes.Items[I].Pessoa.Logradouro;
                NUM       := vParticipantes.Items[I].Pessoa.Numero;
                COMPL     := vParticipantes.Items[I].Pessoa.Complemento;
                BAIRRO    := vParticipantes.Items[I].Pessoa.Bairro;
              end;
            end;
            FreeAndNil(vParticipantes);
          end;

          //-- registro 0190: unidades
          vUnidades:= TViewSped0190.list(vSPED.EmpresaId, vReferente);
          if Assigned(vUnidades) then
          begin
            for I:= 0 to Pred(vUnidades.Count) do
            begin
              with Registro0190New do
              begin
                UNID:= vUnidades.Items[I].Unidade.Unidade;
                DESCR:= vUnidades.Items[I].Unidade.Nome;
              end;
            end;
            FreeAndNil(vUnidades);
          end;

          //-- registro 0200: itens
          vItens:= TViewSped0200.list(vSPED.EmpresaId, vReferente);
          if Assigned(vItens) then
          begin
            for I:= 0 to Pred(vItens.Count) do
            begin
              with Registro0200New do
              begin
                COD_ITEM:= vItens.Items[I].Item.Referencia.ToString();
                DESCR_ITEM:= vItens.Items[I].Item.Nome;
                COD_BARRA:= vItens.Items[I].Item.Ean;
                COD_ANT_ITEM:= '';
                UNID_INV:= vItens.Items[I].Item.Unidade.Unidade;
                TIPO_ITEM:= StrToTipoItem(vItens.Items[I].Item.TipoItem);
                COD_NCM:= vItens.Items[I].Item.Ncm;
                EX_IPI:= vItens.Items[I].Item.Extipi;
                COD_GEN:= vItens.Items[I].Item.CodigoGenero;
                COD_LST:= vItens.Items[I].Item.CodigoServico;
                ALIQ_ICMS:= vItens.Items[I].Item.AliquotaIcms;
              end;
            end;
            FreeAndNil(vItens);
          end;
        end;
      end;

      with vEFD.Bloco_C do
      begin
        vNfes:= TViewSpedC100.list(vSPED.EmpresaId, vReferente);
        if Assigned(vNfes) then
        begin
          with RegistroC001New do IND_MOV:= imComDados;
          for I:= 0 to Pred(vNfes.Count) do
          begin
            with RegistroC100New do
            begin
              case vNfes.Items[I].Nfe.Cstat of
                0,100,150: begin
                  IND_OPER:= StrToIndOper(vNfes.Items[I].Nfe.TpnfWt.ToString());
                  IND_EMIT:= StrToIndEmit(IfThen(vNfes.Items[I].Nfe.TpnfWt = 1,'0','1'));

                  if (AnsiIndexStr(vNfes.Items[I].Nfe.Modelo, ['01','1B','04','55', '65']) in[2,3]) then
                    COD_PART:= vNfes.Items[I].Nfe.Participante.Referencia.ToString()
                  else
                    COD_PART:= '';

                  COD_MOD:= vNfes.Items[I].Nfe.Modelo;
                  COD_SIT:= sdRegular;
                  SER:= vNfes.Items[I].Nfe.Serie.ToString();
                  NUM_DOC:= vNfes.Items[I].Nfe.Nnf.ToString();
                  CHV_NFE:= vNfes.Items[I].Nfe.Chnfe;
                  DT_DOC:= vNfes.Items[I].Nfe.Demi;
                  DT_E_S:= vNfes.Items[I].Nfe.Dsaient;
                  VL_DOC:= vNfes.Items[I].Nfe.ICMSTot.Vnf;
                  IND_PGTO:= StrToIndPgto(vNfes.Items[I].Nfe.Indpag);
                  VL_DESC:= vNfes.Items[I].Nfe.ICMSTot.Vdesc;
                  VL_ABAT_NT:= 0;
                  VL_MERC:= vNfes.Items[I].Nfe.ICMSTot.Vprod;
                  IND_FRT:= StrToIndFrt(vNfes.Items[I].Nfe.Transp.Modfrete);
                  VL_FRT:= vNfes.Items[I].Nfe.ICMSTot.Vfrete;
                  VL_SEG:= vNfes.Items[I].Nfe.ICMSTot.Vseg;
                  VL_OUT_DA:= vNfes.Items[I].Nfe.ICMSTot.Voutro;
                  VL_BC_ICMS:= vNfes.Items[I].Nfe.ICMSTot.Vbc;
                  VL_ICMS:= vNfes.Items[I].Nfe.ICMSTot.Vicms;
                  if not (vNfes.Items[I].Nfe.Modelo = '65') then
                  begin
                    VL_BC_ICMS_ST:= vNfes.Items[I].Nfe.ICMSTot.Vbcst;
                    VL_ICMS_ST:= vNfes.Items[I].Nfe.ICMSTot.Vst;
                    VL_IPI:= vNfes.Items[I].Nfe.ICMSTot.Vipi;
                    VL_PIS:= vNfes.Items[I].Nfe.ICMSTot.Vpis;
                    VL_COFINS:= vNfes.Items[I].Nfe.ICMSTot.Vcofins;
                    VL_PIS_ST:= 0;
                    VL_COFINS_ST:= 0;
                  end;
                end;
                101,151: begin
                  IND_OPER:= StrToIndOper('1');
                  IND_EMIT:= StrToIndEmit('0');
                  COD_MOD:= vNfes.Items[I].Nfe.Modelo;
                  COD_SIT:= sdCancelado;
                  SER:= vNfes.Items[I].Nfe.Serie.ToString();
                  NUM_DOC:= vNfes.Items[I].Nfe.Nnf.ToString();
                  CHV_NFE:= vNfes.Items[I].Nfe.Chnfe;
                end;
                102: begin
                  IND_OPER:= StrToIndOper('1');
                  IND_EMIT:= StrToIndEmit('0');
                  COD_MOD:= vNfes.Items[I].Nfe.Modelo;
                  COD_SIT:= sdDoctoNumInutilizada;
                  SER:= vNfes.Items[I].Nfe.Serie.ToString();
                  NUM_DOC:= vNfes.Items[I].Nfe.Nnf.ToString();
                end;
              end;
            end;

            if (vNfes.Items[I].Nfe.TpnfWt = 0) or (vNfes.Items[I].Nfe.Modelo = '04')  then
            begin
              for J:= 0 to Pred(vNfes.Items[I].Nfe.Det.Count) do
              begin
                with RegistroC170New do
                begin
                  NUM_ITEM:= vNfes.Items[I].Nfe.Det.Items[J].Nitem.ToString();
                  COD_ITEM:= vNfes.Items[I].Nfe.Det.Items[J].ITEM.Referencia.ToString();
                  DESCR_COMPL:= vNfes.Items[I].Nfe.Det.Items[J].Xprod;
                  QTD:= vNfes.Items[I].Nfe.Det.Items[J].Qcom;
                  UNID:= vNfes.Items[I].Nfe.Det.Items[J].ITEM.Unidade.Unidade;
                  VL_ITEM:= vNfes.Items[I].Nfe.Det.Items[J].Vprod;
                  VL_DESC:= vNfes.Items[I].Nfe.Det.Items[J].Vdesc;
                  IND_MOV:= StrToIndMovFisica('0');
                  if (vNfes.Items[I].Nfe.Det.Items[J].ICMS.Cst <> 'SN') then
                    CST_ICMS:= vNfes.Items[I].Nfe.Det.Items[J].ICMS.Cst;
                  if (vNfes.Items[I].Nfe.Det.Items[J].ICMS.Csosn <> '0') then
                    CST_ICMS:= vNfes.Items[I].Nfe.Det.Items[J].ICMS.Csosn;
                  CFOP:= vNfes.Items[I].Nfe.Det.Items[J].Cfop;
                  COD_NAT:= '';
                  VL_BC_ICMS:= vNfes.Items[I].Nfe.Det.Items[J].ICMS.Vbc;
                  ALIQ_ICMS:= vNfes.Items[I].Nfe.Det.Items[J].ICMS.Picms;
                  VL_ICMS:= vNfes.Items[I].Nfe.Det.Items[J].ICMS.Vicms;
                  VL_BC_ICMS_ST:= vNfes.Items[I].Nfe.Det.Items[J].ICMS.Vbcst;
                  ALIQ_ST:= vNfes.Items[I].Nfe.Det.Items[J].ICMS.Picmsst;
                  VL_ICMS_ST:= vNfes.Items[I].Nfe.Det.Items[J].ICMS.Vicmsst;
                  IND_APUR:= TACBrApuracaoIPI('0');
                  CST_IPI:= vNfes.Items[I].Nfe.Det.Items[J].IPI.Cst;
                  COD_ENQ:= ''; //--vNfes.Items[I].Nfe.Det.Items[J].IPI.Cenq;
                  VL_BC_IPI:= vNfes.Items[I].Nfe.Det.Items[J].IPI.Vbc;
                  ALIQ_IPI:= vNfes.Items[I].Nfe.Det.Items[J].IPI.Pipi;
                  VL_IPI:= vNfes.Items[I].Nfe.Det.Items[J].IPI.Vipi;
                  CST_PIS:= vNfes.Items[I].Nfe.Det.Items[J].PIS.Cst;
                  VL_BC_PIS:= vNfes.Items[I].Nfe.Det.Items[J].PIS.Vbc;
                  ALIQ_PIS_PERC:= vNfes.Items[I].Nfe.Det.Items[J].PIS.Ppis;
                  QUANT_BC_PIS:= vNfes.Items[I].Nfe.Det.Items[J].PIS.Qbcprod;
                  ALIQ_PIS_R:= vNfes.Items[I].Nfe.Det.Items[J].PIS.Valiqprod;
                  VL_PIS:= vNfes.Items[I].Nfe.Det.Items[J].PIS.Vpis;
                  CST_COFINS:= vNfes.Items[I].Nfe.Det.Items[J].COFINS.Cst;
                  VL_BC_COFINS:= vNfes.Items[I].Nfe.Det.Items[J].COFINS.Vbc;
                  ALIQ_COFINS_PERC:= vNfes.Items[I].Nfe.Det.Items[J].COFINS.Pcofins;
                  QUANT_BC_COFINS:= vNfes.Items[I].Nfe.Det.Items[J].COFINS.Qbcprod;
                  ALIQ_COFINS_R:= vNfes.Items[I].Nfe.Det.Items[J].COFINS.Valiqprod;
                  VL_COFINS:= vNfes.Items[I].Nfe.Det.Items[J].COFINS.Vcofins;
                  COD_CTA:= '';
                end;
              end;
            end;

            vC190L:= TViewSpedC190.list(vSPED.EmpresaId, vNfes.Items[I].Nfe.Id);
            if Assigned(vC190L) then
            begin
              for J:= 0 to Pred(vC190L.Count) do
              begin
                with RegistroC190New do
                begin
                  if vSPED.Empresa.Crt = '1' then
                    CST_ICMS:= vC190L.Items[J].Csosn
                  else
                    CST_ICMS:= vC190L.Items[J].Cst;

                  CFOP:= vC190L.Items[J].Cfop;
                  ALIQ_ICMS:= vC190L.Items[J].Picms;
                  VL_OPR:= vC190L.Items[J].VlOpr;
                  VL_BC_ICMS:= vC190L.Items[J].VlBcIcms;
                  VL_ICMS:= vC190L.Items[J].VlIcms;
                  VL_BC_ICMS_ST:= vC190L.Items[J].VlBcIcmsSt;
                  VL_ICMS_ST:= vC190L.Items[J].VlIcmsSt;
                  VL_RED_BC:= 0;
                  VL_IPI:= vC190L.Items[J].VlIpi;
                  COD_OBS:= '';
                end;
              end;
              FreeAndNil(vC190L);
            end;
          end;
          FreeAndNil(vNfes);
        end
        else
        begin
          with RegistroC001New do IND_MOV:= imSemDados;
        end;
      end;

      with vEFD.Bloco_E do
      begin
        //-- registro E001: abertura do bloco E
        with RegistroE001New do
        begin
          IND_MOV:= imComDados;

          //-- registro E100: período da apuração do icms.
          with RegistroE100New do
          begin
            DT_INI:= vSPED.DtIni;
            DT_FIN:= vSPED.DtFin;
          end;
        end;

        //-- registro E110: apuração do icms – operações próprias.
        with RegistroE110New do
        begin
          VL_TOT_DEBITOS            := 0;
          VL_AJ_DEBITOS             := 0;
          VL_TOT_AJ_DEBITOS         := 0;
          VL_ESTORNOS_CRED          := 0;
          VL_TOT_CREDITOS           := 0;
          VL_AJ_CREDITOS            := 0;
          VL_TOT_AJ_CREDITOS        := 0;
          VL_ESTORNOS_DEB           := 0;
          VL_SLD_CREDOR_ANT         := 0;
          VL_SLD_APURADO            := 0;
          VL_TOT_DED                := 0;
          VL_ICMS_RECOLHER          := 0;
          VL_SLD_CREDOR_TRANSPORTAR := 0;
          DEB_ESP                   := 0;
        end;
      end;

      with vEFD.Bloco_1 do
      begin
        //-- registro 1001: abertura do bloco 1
        with Registro1001New do
        begin
          IND_MOV:= imComDados;

          //-- registro 1010: obrigatoriedade de registros do bloco 1
          with Registro1010New do
          begin
            IND_EXP   := 'N'; //1100
            IND_CCRF  := 'N'; //1200
            IND_COMB  := 'N'; //1300
            IND_USINA := 'N'; //1390
            IND_VA    := 'N'; //1400
            IND_EE    := 'N'; //1500
            IND_CART  := 'N'; //IfThen(FSPED1600LST.Count > 0,'S','N'); //1600
            IND_FORM  := 'N'; //1700
            IND_AER   := 'N'; //1800
          end;

          //-- REGISTRO 1600: TOTAL DAS OPERAÇÕES COM CARTÃO DE CRÉDITO E/OU DÉBITO
          {for I := 0 to Pred(FSPED1600LST.Count) do
          begin
            with Registro1600New do
            begin
              COD_PART    := FSPED1600LST.Items[I].Codparticipante.ToString();
              TOT_CREDITO := FSPED1600LST.Items[I].Credito;
              TOT_DEBITO  := FSPED1600LST.Items[I].Debito;
            end;
          end;}
        end;
      end;

      vEFD.SaveFileTXT();
      TSped.importarEFD(id,vDiretorio);
      vSPED.SpedStatus:= 1;
      vSPED.save();
      THelper.Mensagem('Arquivo gerado com sucesso.');
    except on e: exception do
      raise Exception.Create('Falha ao tentar gerar sped. Erro: ' + e.Message);
    end;
  finally
    FreeAndNil(vSPED);
    FreeAndNil(vEFD);
  end;
end;

function TSped.getEmpresa: TEmpresa;
begin
  if not Assigned(Self.FEMPRESA) then
    Self.FEMPRESA:= TEmpresa.find(Self.EmpresaId);

  Result:= Self.FEMPRESA;
end;

class procedure TSped.importarEFD(id, vPath: string);
const
  FSql: string = 'UPDATE SPED SET SPED = :SPED WHERE ID = :ID';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('SPED').DataType:= ftBlob;
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('SPED').LoadFromFile(vPath,ftBlob);
      FDQuery.Params.ParamByName('ID').AsString:= id;
      FDQuery.ExecSQL();
    except on e: Exception do
      raise Exception.Create('Falha ao importar sped. Erro: ' + e.Message);
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TSped.list: TObjectList<TSped>;
const
  FSql: string =
  'SELECT FIRST 12 S.ID FROM SPED S ' +
  'WHERE (S.EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (S.DELETED_AT IS NULL) ORDER BY DT_INI DESC';
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
        Result:= TObjectList<TSped>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TSped.find(FDQuery.FieldByName('ID').AsString));
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

class procedure TSped.list(DataSet: TFDMemTable);
var
  vList: TObjectList<TSped>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls();
  DataSet.EmptyDataSet();
  vList:= TSped.list();
  if Assigned(vList) then
  begin
    for I:= 0 to Pred(vList.Count) do
    begin
      DataSet.Append();
      DataSet.FieldByName('ID').AsString:= vList.Items[I].Id;
      DataSet.FieldByName('DT_INI').AsDateTime:= vList.Items[I].DtIni;
      DataSet.FieldByName('SPED_STATUS').AsInteger:= vList.Items[I].SpedStatus;
      DataSet.Post();
    end;
    FreeAndNil(vList);
  end;
  DataSet.First();
  DataSet.EnableControls();
end;

function TSped.save: Boolean;
begin
  Result:= inherited;
end;

function TSped.store: Boolean;
const
  FSql: string =
  'INSERT INTO SPED ( ' +
  '  ID,              ' +
  '  EMPRESA_ID,      ' +
  '  COD_VER,         ' +
  '  COD_FIN,         ' +
  '  DT_INI,          ' +
  '  DT_FIN,          ' +
  '  IND_PERFIL,      ' +
  '  IND_ATIV,        ' +
  '  SPED_STATUS,     ' +
  '  CREATED_AT,      ' +
  '  UPDATED_AT)      ' +
  'VALUES (           ' +
  '  :ID,             ' +
  '  :EMPRESA_ID,     ' +
  '  :COD_VER,        ' +
  '  :COD_FIN,        ' +
  '  :DT_INI,         ' +
  '  :DT_FIN,         ' +
  '  :IND_PERFIL,     ' +
  '  :IND_ATIV,       ' +
  '  :SPED_STATUS,    ' +
  '  :CREATED_AT,     ' +
  '  :UPDATED_AT)     ';
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
      FDQuery.Params.ParamByName('COD_VER').DataType:= ftInteger;
      FDQuery.Params.ParamByName('COD_FIN').DataType:= ftInteger;
      FDQuery.Params.ParamByName('DT_INI').DataType:= ftDate;
      FDQuery.Params.ParamByName('DT_FIN').DataType:= ftDate;
      FDQuery.Params.ParamByName('IND_PERFIL').DataType:= ftString;
      FDQuery.Params.ParamByName('IND_ATIV').DataType:= ftInteger;
      FDQuery.Params.ParamByName('SPED_STATUS').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('COD_VER').AsInteger:= Self.CodVer;
      FDQuery.Params.ParamByName('COD_FIN').AsInteger:= Self.CodFin;
      FDQuery.Params.ParamByName('DT_INI').AsDate:= Self.DtIni;
      FDQuery.Params.ParamByName('DT_FIN').AsDate:= Self.DtFin;
      FDQuery.Params.ParamByName('IND_PERFIL').AsString:= Self.IndPerfil;
      FDQuery.Params.ParamByName('IND_ATIV').AsInteger:= Self.IndAtiv;
      FDQuery.Params.ParamByName('SPED_STATUS').AsInteger:= Self.SpedStatus;
      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao inserir a sped. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TSped.update: Boolean;
const
  FSql: string =
  'UPDATE SPED                      ' +
  'SET COD_VER = :COD_VER,          ' +
  '    COD_FIN = :COD_FIN,          ' +
  '    DT_INI = :DT_INI,            ' +
  '    DT_FIN = :DT_FIN,            ' +
  '    IND_PERFIL = :IND_PERFIL,    ' +
  '    IND_ATIV = :IND_ATIV,        ' +
  '    SPED_STATUS = :SPED_STATUS,  ' +
  '    UPDATED_AT = :UPDATED_AT,    ' +
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
      FDQuery.Params.ParamByName('COD_VER').DataType:= ftInteger;
      FDQuery.Params.ParamByName('COD_FIN').DataType:= ftInteger;
      FDQuery.Params.ParamByName('DT_INI').DataType:= ftDate;
      FDQuery.Params.ParamByName('DT_FIN').DataType:= ftDate;
      FDQuery.Params.ParamByName('IND_PERFIL').DataType:= ftString;
      FDQuery.Params.ParamByName('IND_ATIV').DataType:= ftInteger;
      FDQuery.Params.ParamByName('SPED_STATUS').DataType:= ftInteger;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftString;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('COD_VER').AsInteger:= Self.CodVer;
      FDQuery.Params.ParamByName('COD_FIN').AsInteger:= Self.CodFin;
      FDQuery.Params.ParamByName('DT_INI').AsDate:= Self.DtIni;
      FDQuery.Params.ParamByName('DT_FIN').AsDate:= Self.DtFin;
      FDQuery.Params.ParamByName('IND_PERFIL').AsString:= Self.IndPerfil;
      FDQuery.Params.ParamByName('IND_ATIV').AsInteger:= Self.IndAtiv;
      FDQuery.Params.ParamByName('SPED_STATUS').AsInteger:= Self.SpedStatus;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao atualizar a sped. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
