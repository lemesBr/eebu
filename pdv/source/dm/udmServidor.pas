unit udmServidor;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, FireDAC.Comp.UI;

type
  TdmServidor = class(TDataModule)
    fdc_server: TFDConnection;
    fdq_terminais: TFDQuery;
    fdq_empresas: TFDQuery;
    fdq_pessoas: TFDQuery;
    fdq_itens: TFDQuery;
    fdq_cartoes: TFDQuery;
    fdq_users: TFDQuery;
    fdq_ncms: TFDQuery;
    fdq_turnos: TFDQuery;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    fdq_movimento_create: TFDQuery;
    fdq_suprimento_create: TFDQuery;
    fdq_sangria_create: TFDQuery;
    fdq_venda_create: TFDQuery;
    fdq_venda_item_create: TFDQuery;
    fdq_venda_recebimento_create: TFDQuery;
    fdq_recebimento_create: TFDQuery;
    fdq_movimento_fechamento_create: TFDQuery;
    fdq_nfe_create: TFDQuery;
    fdq_nfe_pag_create: TFDQuery;
    fdq_nfe_total_icms_create: TFDQuery;
    fdq_nfe_det_create: TFDQuery;
    fdq_nfe_det_icms_create: TFDQuery;
    fdq_nfe_det_ipi_create: TFDQuery;
    fdq_nfe_det_pis_create: TFDQuery;
    fdq_nfe_det_cofins: TFDQuery;
    fdq_nfe_venda_create: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure importData();
  end;

var
  dmServidor: TdmServidor;

implementation

uses
  AuthService, Terminal, Pessoa, Conexao, Helper, Item, Cartao, User, Ncm,
  Empresa, Turno;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmServidor }

procedure TdmServidor.importData;
var
  vServer,
  vDatabase,
  vUser,
  vPassword,
  vEmpresaId: string;

  vEmpresa: TEmpresa;
  vPessoa: TPessoa;
  vItem: TItem;
  vCartao: TCartao;
  vUsuario: TUser;
  vNcm: TNcm;
  vTurno: TTurno;
begin
  try
    TConexao.GetInstance.StartTransaction();
    vEmpresa:= nil;
    vPessoa:= nil;
    vItem:= nil;
    vCartao:= nil;
    vUsuario:= nil;
    vTurno:= nil;
    try
      vServer:= TAuthService.Terminal.ServerAddress;
      vDatabase:= TAuthService.Terminal.ServerDatabase;
      vUser:= TAuthService.Terminal.ServerUserName;
      vPassword:= TAuthService.Terminal.ServerUserPassword;
      vEmpresaId:= TAuthService.Terminal.EmpresaId;

      fdc_server.Close();
      if (fdc_server.Params.Count = 0) then
      begin
        fdc_server.Params.Append('protocol=TCPIP');
        fdc_server.Params.Append('server=' + vServer);
        fdc_server.Params.Append('database=' + vDatabase);
        fdc_server.Params.Append('user_name=' + vUser);
        fdc_server.Params.Append('password=' + vPassword);
        fdc_server.Params.Append('characterset=UTF8');
        fdc_server.Params.Append('driverid=FB');
      end;
      fdc_server.Open();

      fdq_empresas.Close();
      fdq_empresas.Params.ParamByName('ID').DataType:= ftString;
      fdq_empresas.Prepare();
      fdq_empresas.Params.ParamByName('ID').AsString:= vEmpresaId;
      fdq_empresas.Open();

      if (fdq_empresas.RecordCount = 0) then
        raise Exception.Create('Falha ao consultar dados da empresa.');

      vEmpresa:= TEmpresa.Create;
      vEmpresa.Id:= fdq_empresas.FieldByName('ID').AsString;
      vEmpresa.TipoPessoa:= fdq_empresas.FieldByName('TIPO_PESSOA').AsString;
      vEmpresa.Referencia:= fdq_empresas.FieldByName('REFERENCIA').AsInteger;
      vEmpresa.Nome:= fdq_empresas.FieldByName('NOME').AsString;
      vEmpresa.RazaoSocial:= fdq_empresas.FieldByName('RAZAO_SOCIAL').AsString;
      vEmpresa.Documento:= fdq_empresas.FieldByName('DOCUMENTO').AsString;
      vEmpresa.Ie:= fdq_empresas.FieldByName('IE').AsString;
      vEmpresa.Iest:= fdq_empresas.FieldByName('IEST').AsString;
      vEmpresa.Im:= fdq_empresas.FieldByName('IM').AsString;
      vEmpresa.Cnae:= fdq_empresas.FieldByName('CNAE').AsString;
      vEmpresa.Crt:= fdq_empresas.FieldByName('CRT').AsString;
      vEmpresa.Cep:= fdq_empresas.FieldByName('CEP').AsString;
      vEmpresa.Logradouro:= fdq_empresas.FieldByName('LOGRADOURO').AsString;
      vEmpresa.Numero:= fdq_empresas.FieldByName('NUMERO').AsString;
      vEmpresa.Complemento:= fdq_empresas.FieldByName('COMPLEMENTO').AsString;
      vEmpresa.Bairro:= fdq_empresas.FieldByName('BAIRRO').AsString;
      vEmpresa.CodigoMunicipio:= fdq_empresas.FieldByName('CODIGO_MUNICIPIO').AsString;
      vEmpresa.NomeMunicipio:= fdq_empresas.FieldByName('NOME_MUNICIPIO').AsString;
      vEmpresa.Uf:= fdq_empresas.FieldByName('UF').AsString;
      vEmpresa.Fone:= fdq_empresas.FieldByName('FONE').AsString;
      vEmpresa.Celular:= fdq_empresas.FieldByName('CELULAR').AsString;
      vEmpresa.Email:= fdq_empresas.FieldByName('EMAIL').AsString;
      vEmpresa.save();

      fdq_pessoas.Close();
      fdq_pessoas.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      fdq_pessoas.Prepare();
      fdq_pessoas.Params.ParamByName('EMPRESA_ID').AsString:= vEmpresaId;
      fdq_pessoas.Open();

      if (fdq_pessoas.RecordCount >= 1) then
      begin
        vPessoa:= TPessoa.Create;
        fdq_pessoas.First();
        while not fdq_pessoas.Eof do
        begin
          vPessoa.Id:= fdq_pessoas.FieldByName('ID').AsString;
          vPessoa.EmpresaId:= fdq_pessoas.FieldByName('EMPRESA_ID').AsString;
          vPessoa.TipoPessoa:= fdq_pessoas.FieldByName('TIPO_PESSOA').AsString;
          vPessoa.Referencia:= fdq_pessoas.FieldByName('REFERENCIA').AsInteger;
          vPessoa.Nome:= fdq_pessoas.FieldByName('NOME').AsString;
          vPessoa.RazaoSocial:= fdq_pessoas.FieldByName('RAZAO_SOCIAL').AsString;
          vPessoa.Documento:= fdq_pessoas.FieldByName('DOCUMENTO').AsString;
          vPessoa.Idestrangeiro:= fdq_pessoas.FieldByName('IDESTRANGEIRO').AsString;
          vPessoa.Im:= fdq_pessoas.FieldByName('IM').AsString;
          vPessoa.Isuf:= fdq_pessoas.FieldByName('ISUF').AsString;
          vPessoa.Simples:= fdq_pessoas.FieldByName('SIMPLES').AsString;
          vPessoa.Indiedest:= fdq_pessoas.FieldByName('INDIEDEST').AsString;
          vPessoa.Ie:= fdq_pessoas.FieldByName('IE').AsString;
          vPessoa.DataFundacaoNascimento:= fdq_pessoas.FieldByName('DATA_FUNDACAO_NASCIMENTO').AsDateTime;
          vPessoa.Cep:= fdq_pessoas.FieldByName('CEP').AsString;
          vPessoa.Logradouro:= fdq_pessoas.FieldByName('LOGRADOURO').AsString;
          vPessoa.Numero:= fdq_pessoas.FieldByName('NUMERO').AsString;
          vPessoa.Complemento:= fdq_pessoas.FieldByName('COMPLEMENTO').AsString;
          vPessoa.Bairro:= fdq_pessoas.FieldByName('BAIRRO').AsString;
          vPessoa.CodigoMunicipio:= fdq_pessoas.FieldByName('CODIGO_MUNICIPIO').AsString;
          vPessoa.NomeMunicipio:= fdq_pessoas.FieldByName('NOME_MUNICIPIO').AsString;
          vPessoa.Uf:= fdq_pessoas.FieldByName('UF').AsString;
          vPessoa.Fone:= fdq_pessoas.FieldByName('FONE').AsString;
          vPessoa.Celular:= fdq_pessoas.FieldByName('CELULAR').AsString;
          vPessoa.Email:= fdq_pessoas.FieldByName('EMAIL').AsString;
          vPessoa.save();

          fdq_pessoas.Next();
        end;
        FreeAndNil(vPessoa);
      end;

      fdq_itens.Close();
      fdq_itens.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      fdq_itens.Prepare();
      fdq_itens.Params.ParamByName('EMPRESA_ID').AsString:= vEmpresaId;
      fdq_itens.Open();

      if (fdq_itens.RecordCount >= 1) then
      begin
        vItem:= TItem.Create;
        fdq_itens.First();
        while not fdq_itens.Eof do
        begin
          vItem.Id:= fdq_itens.FieldByName('ID').AsString;
          vItem.EmpresaId:= fdq_itens.FieldByName('EMPRESA_ID').AsString;
          vItem.Referencia:= fdq_itens.FieldByName('REFERENCIA').AsInteger;
          vItem.Ean:= fdq_itens.FieldByName('EAN').AsString;
          vItem.Nome:= fdq_itens.FieldByName('NOME').AsString;
          vItem.Ncm:= fdq_itens.FieldByName('NCM').AsString;
          vItem.Extipi:= fdq_itens.FieldByName('EXTIPI').AsString;
          vItem.Unidade:= fdq_itens.FieldByName('UNIDADE').AsString;
          vItem.EanTributavel:= fdq_itens.FieldByName('EAN_TRIBUTAVEL').AsString;
          vItem.UnidadeTributavel:= fdq_itens.FieldByName('UNIDADE_TRIBUTAVEL').AsString;
          vItem.Cest:= fdq_itens.FieldByName('CEST').AsString;
          vItem.PrecoVenda:= fdq_itens.FieldByName('PRECO_VENDA').AsExtended;
          vItem.Cfop:= fdq_itens.FieldByName('CFOP').AsString;
          vItem.IcmsOrig:= fdq_itens.FieldByName('ICMS_ORIG').AsString;
          vItem.IcmsCst:= fdq_itens.FieldByName('ICMS_CST').AsString;
          vItem.IcmsCsosn:= fdq_itens.FieldByName('ICMS_CSOSN').AsString;
          vItem.IpiCst:= fdq_itens.FieldByName('IPI_CST').AsString;
          vItem.PisCst:= fdq_itens.FieldByName('PIS_CST').AsString;
          vItem.CofinsCst:= fdq_itens.FieldByName('COFINS_CST').AsString;
          vItem.save();

          fdq_itens.Next();
        end;
        FreeAndNil(vItem);
      end;

      fdq_cartoes.Close();
      fdq_cartoes.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      fdq_cartoes.Prepare();
      fdq_cartoes.Params.ParamByName('EMPRESA_ID').AsString:= vEmpresaId;
      fdq_cartoes.Open();

      if (fdq_cartoes.RecordCount >= 1) then
      begin
        vCartao:= TCartao.Create;
        fdq_cartoes.First();
        while not fdq_cartoes.Eof do
        begin
          vCartao.Id:= fdq_cartoes.FieldByName('ID').AsString;
          vCartao.EmpresaId:= fdq_cartoes.FieldByName('EMPRESA_ID').AsString;
          vCartao.Nome:= fdq_cartoes.FieldByName('NOME').AsString;
          vCartao.Modalidade:= fdq_cartoes.FieldByName('MODALIDADE').AsString;
          vCartao.CompensaCredito:= fdq_cartoes.FieldByName('COMPENSA_CREDITO').AsInteger;
          vCartao.TaxaCredito:= fdq_cartoes.FieldByName('TAXA_CREDITO').AsExtended;
          vCartao.CompensaDebito:= fdq_cartoes.FieldByName('COMPENSA_DEBITO').AsInteger;
          vCartao.TaxaDebito:= fdq_cartoes.FieldByName('TAXA_DEBITO').AsExtended;
          vCartao.save();

          fdq_cartoes.Next();
        end;
        FreeAndNil(vCartao);
      end;

      fdq_users.Close();
      fdq_users.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      fdq_users.Prepare();
      fdq_users.Params.ParamByName('EMPRESA_ID').AsString:= vEmpresaId;
      fdq_users.Open();

      if (fdq_users.RecordCount >= 1) then
      begin
        vUsuario:= TUser.Create;
        fdq_users.First();
        while not fdq_users.Eof do
        begin
          vUsuario.Id:= fdq_users.FieldByName('ID').AsString;
          vUsuario.EmpresaId:= fdq_users.FieldByName('EMPRESA_ID').AsString;
          vUsuario.Nome:= fdq_users.FieldByName('NOME').AsString;
          vUsuario.Sobrenome:= '';
          vUsuario.Email:= fdq_users.FieldByName('EMAIL').AsString;
          vUsuario.Senha:= fdq_users.FieldByName('SENHA').AsString;
          vUsuario.save();

          fdq_users.Next();
        end;
        FreeAndNil(vUsuario);
      end;

      fdq_ncms.Close();
      fdq_ncms.Prepare();
      fdq_ncms.Open();

      if (fdq_ncms.RecordCount >= 1) then
      begin
        vNcm:= TNcm.Create;
        fdq_ncms.First();
        while not fdq_ncms.Eof do
        begin
          vNcm.Ncm:= fdq_ncms.FieldByName('NCM').AsString;
          vNcm.Nacional:= fdq_ncms.FieldByName('NACIONAL').AsExtended;
          vNcm.Importado:= fdq_ncms.FieldByName('IMPORTADO').AsExtended;
          vNcm.Estadual:= fdq_ncms.FieldByName('ESTADUAL').AsExtended;
          vNcm.Municipal:= fdq_ncms.FieldByName('MUNICIPAL').AsExtended;
          vNcm.save();

          fdq_ncms.Next();
        end;
        FreeAndNil(vNcm);
      end;

      fdq_turnos.Close();
      fdq_turnos.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      fdq_turnos.Prepare();
      fdq_turnos.Params.ParamByName('EMPRESA_ID').AsString:= vEmpresaId;
      fdq_turnos.Open();

      if (fdq_turnos.RecordCount >= 1) then
      begin
        vTurno:= TTurno.Create;
        fdq_turnos.First();
        while not fdq_turnos.Eof do
        begin
          vTurno.Id:= fdq_turnos.FieldByName('ID').AsString;
          vTurno.EmpresaId:= fdq_turnos.FieldByName('EMPRESA_ID').AsString;
          vTurno.Referencia:= fdq_turnos.FieldByName('REFERENCIA').AsInteger;
          vTurno.Nome:= fdq_turnos.FieldByName('NOME').AsString;
          vTurno.Inicio:= fdq_turnos.FieldByName('INICIO').AsString;
          vTurno.Fim:= fdq_turnos.FieldByName('FIM').AsString;
          vTurno.save();

          fdq_turnos.Next();
        end;
        FreeAndNil(vTurno);
      end;

      TConexao.GetInstance.Commit();
      THelper.Mensagem('Dados atualizados com sucesso.');
    except on e: Exception do
      begin
        TConexao.GetInstance.Rollback();
        THelper.Mensagem(e.Message);
      end;
    end;
  finally
    if Assigned(vEmpresa) then FreeAndNil(vEmpresa);
    if Assigned(vPessoa) then FreeAndNil(vPessoa);
    if Assigned(vItem) then FreeAndNil(vItem);
    if Assigned(vCartao) then FreeAndNil(vCartao);
  end;
end;

end.
