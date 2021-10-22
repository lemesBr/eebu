unit uformStartConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Data.DB, ACBrUtil;

type
  TformStartConfig = class(TformBase)
    Panel1: TPanel;
    lbe_authentication: TLabeledEdit;
    lbe_server_address: TLabeledEdit;
    lbe_server_database: TLabeledEdit;
    lbe_server_user_name: TLabeledEdit;
    lbe_server_user_password: TLabeledEdit;
    Button1: TButton;
    DBGrid1: TDBGrid;
    ds_terminais: TDataSource;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    server,
    database,
    user_name,
    password: string;
  public
    { Public declarations }
  end;

var
  formStartConfig: TformStartConfig;

implementation

{$R *.dfm}

uses udmServidor, Empresa, Conexao, Terminal;

procedure TformStartConfig.Button1Click(Sender: TObject);
begin
  server:= Trim(lbe_server_address.Text);
  database:= Trim(lbe_server_database.Text);
  user_name:= Trim(lbe_server_user_name.Text);
  password:= Trim(lbe_server_user_password.Text);

  with dmServidor do
  begin
    try
      fdc_server.Close();
      fdc_server.Params.Clear();
      fdc_server.Params.Append('protocol=TCPIP');
      fdc_server.Params.Append('server=' + server);
      fdc_server.Params.Append('database=' + database);
      fdc_server.Params.Append('user_name=' + user_name);
      fdc_server.Params.Append('password=' + password);
      fdc_server.Params.Append('characterset=UTF8');
      fdc_server.Params.Append('driverid=FB');
      fdc_server.Open();
      fdq_terminais.Open();

      Button1.Enabled:= not fdc_server.Connected;
    except on e: Exception do
      raise Exception.Create('Falha ao se conectar com servidor. Erro: ' + e.Message);
    end;
  end;
end;

procedure TformStartConfig.Button2Click(Sender: TObject);
var
  vEmpresa: TEmpresa;
  vTerminal: TTerminal;
begin
  try
    vEmpresa:= nil;
    vTerminal:= nil;
    try
      with dmServidor do
      begin
        TConexao.GetInstance.StartTransaction();
        fdc_server.StartTransaction();

        fdq_empresas.Params.ParamByName('ID').DataType:= ftString;
        fdq_empresas.Prepare();
        fdq_empresas.Params.ParamByName('ID').AsString:=
          fdq_terminais.FieldByName('EMPRESA_ID').AsString;
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

        vTerminal:= TTerminal.Create;
        vTerminal.Id:= fdq_terminais.FieldByName('ID').AsString;
        vTerminal.EmpresaId:= fdq_terminais.FieldByName('EMPRESA_ID').AsString;
        vTerminal.Authentication:= lbe_authentication.Text;
        vTerminal.Referencia:= fdq_terminais.FieldByName('REFERENCIA').AsInteger;
        vTerminal.Nome:= 'TERMINAL-' + PadLeft(fdq_terminais.FieldByName('REFERENCIA').AsString, 2, '0');
        vTerminal.ContaId:= fdq_terminais.FieldByName('CONTA_ID').AsString;
        vTerminal.CategoriaId:= fdq_terminais.FieldByName('CATEGORIA_ID').AsString;
        vTerminal.PessoaId:= fdq_terminais.FieldByName('PESSOA_ID').AsString;
        vTerminal.Parcelamento:= fdq_terminais.FieldByName('PARCELAMENTO').AsInteger;
        vTerminal.PrintPath:= fdq_terminais.FieldByName('PRINT_PATH').AsString;

        vTerminal.NfceOperacaoFiscalId:= fdq_terminais.FieldByName('NFCE_OPERACAO_FISCAL_ID').AsString;
        vTerminal.NfceNatop:= fdq_terminais.FieldByName('NFCE_NATOP').AsString;
        vTerminal.NfceSerie:= fdq_terminais.FieldByName('NFCE_SERIE').AsInteger;
        vTerminal.NfceNumero:= fdq_terminais.FieldByName('NFCE_NUMERO').AsInteger;
        vTerminal.NfcePrintPath:= fdq_terminais.FieldByName('NFCE_PRINT_PATH').AsString;
        vTerminal.NfcePrinterModel:= fdq_terminais.FieldByName('NFCE_PRINTER_MODEL').AsInteger;

        vTerminal.MovimentoReferencia:= fdq_terminais.FieldByName('MOVIMENTO_REFERENCIA').AsInteger;
        vTerminal.VendaReferencia:= fdq_terminais.FieldByName('VENDA_REFERENCIA').AsInteger;
        vTerminal.RecebimentoReferencia:= fdq_terminais.FieldByName('RECEBIMENTO_REFERENCIA').AsInteger;
        vTerminal.ServerAddress:= server;
        vTerminal.ServerDatabase:= database;
        vTerminal.ServerUserName:= user_name;
        vTerminal.ServerUserPassword:= password;
        vTerminal.Carregado:= 'N';
        vTerminal.save();

        fdq_terminais.Edit();
        fdq_terminais.FieldByName('AUTHENTICATION').AsString:= vTerminal.Authentication;
        fdq_terminais.Post();

        TConexao.GetInstance.Commit();
        fdc_server.Commit();
      end;
    except on e: Exception do
      begin
        TConexao.GetInstance.Rollback();
        dmServidor.fdc_server.Rollback();
        ShowMessage(e.Message);
      end;
    end;
  finally
    if Assigned(vEmpresa) then FreeAndNil(vEmpresa);
    if Assigned(vTerminal) then FreeAndNil(vTerminal);
  end;
end;

procedure TformStartConfig.FormCreate(Sender: TObject);
begin
  inherited;
  {$IFDEF DEBUG}
    lbe_server_address.Text:= '127.0.0.1';
    lbe_server_database.Text:= 'C:\itec\git\wt-sistemas\db\WT-SISTEMAS.FDB';
    lbe_server_user_name.Text:= 'sysdba';
    lbe_server_user_password.Text:= 'masterkey';
  {$ENDIF}
end;

end.
