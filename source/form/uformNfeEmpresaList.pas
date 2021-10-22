unit uformNfeEmpresaList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.DateUtils, System.Actions, Vcl.ActnList, ACBrNFe, System.StrUtils,
  Vcl.FileCtrl, ACBrMail;

type
  TformNfeEmpresaList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    dbg_nfes: TDBGrid;
    pnl_search: TPanel;
    dtp_start: TDateTimePicker;
    dtp_end: TDateTimePicker;
    bvl_3: TBevel;
    fdmt_nfes: TFDMemTable;
    fdmt_nfesID: TStringField;
    fdmt_nfesSERIE: TIntegerField;
    fdmt_nfesNNF: TIntegerField;
    fdmt_nfesDEMI: TDateField;
    fdmt_nfesVNF: TCurrencyField;
    fdmt_nfesCHNFE: TStringField;
    fdmt_nfesDSAIENT: TDateField;
    fdmt_nfesCSTAT: TIntegerField;
    fdmt_nfesTPNF: TIntegerField;
    ds_nfes: TDataSource;
    btn_rollback: TButton;
    btn_enviar_email: TButton;
    btn_exportar: TButton;
    acl_empresa: TActionList;
    act_rollback: TAction;
    act_exportar: TAction;
    act_enviar_email: TAction;
    lb_start: TLabel;
    lb_end: TLabel;
    btn_consultar: TButton;
    act_consultar: TAction;
    pnl_totais: TPanel;
    bvl_4: TBevel;
    bvl_5: TBevel;
    pnl_totais_left: TPanel;
    Panel1: TPanel;
    lbl_total_recebidas: TLabel;
    lbl_total_enviadas: TLabel;
    Panel2: TPanel;
    lbl_recebidas: TLabel;
    lbl_enviadas: TLabel;
    pnl_totais_right: TPanel;
    Panel3: TPanel;
    lbl_numero_canceladas: TLabel;
    lbl_numero_inutilizadas: TLabel;
    Panel4: TPanel;
    lbl_canceladas: TLabel;
    lbl_inutilizadas: TLabel;
    fdmt_nfesMODELO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure dbg_nfesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_exportarExecute(Sender: TObject);
    procedure act_enviar_emailExecute(Sender: TObject);
    procedure acl_empresaUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure act_consultarExecute(Sender: TObject);
  private
    { Private declarations }
    procedure list(startDate, endDate: TDate);
    function exportarArquivos(vDir: string): Boolean;
  public
    { Public declarations }
  end;

var
  formNfeEmpresaList: TformNfeEmpresaList;

implementation

uses
  Nfe, Helper, Empresa, AuthService, udmRepository;

{$R *.dfm}

procedure TformNfeEmpresaList.acl_empresaUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_exportar.Enabled:= (fdmt_nfes.RecordCount >= 1);
  act_enviar_email.Enabled:= (fdmt_nfes.RecordCount >= 1);
end;

procedure TformNfeEmpresaList.act_consultarExecute(Sender: TObject);
begin
  dbg_nfes.SetFocus();
  list(dtp_start.Date, dtp_end.Date);
end;

procedure TformNfeEmpresaList.act_enviar_emailExecute(Sender: TObject);
var
  vDir: string;
  vACBrMail: TACBrMail;
  vEmpresa: TEmpresa;
begin
  dbg_nfes.SetFocus();

  if not THelper.Mensagem('Deseja enviar arquivos para o contador?',1) then
    Exit();

  vACBrMail:= nil;
  vEmpresa:= nil;
  vDir:= ExtractFileDir(Application.ExeName);
  try
    try
      vEmpresa:= TEmpresa.find(TAuthService.getAuthenticatedEmpresaId);
      if not Assigned(vEmpresa) then
        raise Exception.Create('Falha ao consultar dados da empresa.');

      if not Assigned(vEmpresa.Contabilista) then
        raise Exception.Create('Falha ao consultar dados do contador.');

      if Trim(vEmpresa.Contabilista.Email) = '' then
        raise Exception.Create('Email do contador inválido.');

      if FileExists(vDir + '\email\arquivos.zip') then
        DeleteFile(vDir + '\email\arquivos.zip');

      if DirectoryExists(vDir + '\email\arquivos') then
        THelper.removeDir(Application.Handle,vDir + '\email\arquivos');

      if exportarArquivos(vDir + '\email') then
      begin
        vDir:= vDir + '\email\arquivos';
        if THelper.criarZipDirectory(vDir) then
        begin
          vACBrMail:= TACBrMail.Create(nil);
          vACBrMail.Host:= 'mail.wtsystem.com.br';
          vACBrMail.Port:= '465';
          vACBrMail.Username:= 'arquivos@wtsystem.com.br';
          vACBrMail.Password:= 'wtarquivos115816';
          vACBrMail.SetSSL:= True;
          vACBrMail.SetTLS:= True;
          vACBrMail.ReadingConfirmation:= False;
          vACBrMail.UseThread:= False;
          vACBrMail.From:= 'arquivos@wtsystem.com.br';
          vACBrMail.FromName:= 'WT-SYSTEM / ' + vEmpresa.Nome;
          vACBrMail.Subject:= 'Arquivos XML';
          vACBrMail.AltBody.Add(vEmpresa.Nome + ': Segue anexo os arquivos XML.');
          vACBrMail.AltBody.Add('');
          vACBrMail.AltBody.Add('Atenciosamente WT-SYSTEM');
          vACBrMail.AddAddress(vEmpresa.Contabilista.Email,vEmpresa.Contabilista.Nome);
          vACBrMail.AddAttachment(vDir + '.zip');
          vACBrMail.Send(False);
          THelper.Mensagem('Arquivos enviados com sucesso.');
        end;
      end;
    except on e: exception do
      THelper.Mensagem('Falha ao tentar enviar arquivos. Erro: ' + e.Message);
    end;
  finally
    FreeAndNil(vEmpresa);
    FreeAndNil(vACBrMail);
  end;
end;

procedure TformNfeEmpresaList.act_exportarExecute(Sender: TObject);
var
  vDir: string;
begin
  dbg_nfes.SetFocus();
  vDir:= '';
  if not SelectDirectory(vDir, [sdAllowCreate, sdPerformCreate, sdPrompt],1000) then
    Exit();

  try
    if exportarArquivos(vDir) then
      THelper.Mensagem('Arquivos exportados com sucesso.');
  except on e: exception do
    THelper.Mensagem('Falha ao tentar exportar arquivos. Erro: ' + e.Message);
  end;
end;

procedure TformNfeEmpresaList.act_rollbackExecute(Sender: TObject);
begin
  Close();
end;

procedure TformNfeEmpresaList.dbg_nfesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  if (gdSelected in State) then
  begin
    TDBGrid(Sender).Canvas.Font.Style:= [fsBold];
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;
  end;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);

  if (fdmt_nfes.RecordCount >= 1) then
  begin
    if Column.FieldName = 'TPNF' then
    begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      case fdmt_nfesTPNF.AsInteger of
        0: dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 6, Rect.Top + 1, 13);
        1: dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 6, Rect.Top + 1, 14);
      end;
    end
    else if Column.FieldName = 'CSTAT' then
    begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      case fdmt_nfesCSTAT.AsInteger of
        100,150: dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 6, Rect.Top + 1, 17);
        101,151: dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 6, Rect.Top + 1, 18);
        102: dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 6, Rect.Top + 1, 19);
      end;
    end;
  end;
end;

function TformNfeEmpresaList.exportarArquivos(vDir: string): Boolean;
var
  vDirXml,
  vXML: string;
  vACBrNF: TACBrNFe;
  vList: TStringList;
begin
  if (Trim(vDir) = '') then
  begin
    Result:= False;
    Exit();
  end;

  Result:= True;
  try
    vACBrNF:= TACBrNFe.Create(nil);
    vList:= TStringList.Create;

    fdmt_nfes.DisableControls;
    fdmt_nfes.First;
    try
      while not fdmt_nfes.Eof do
      begin
        case fdmt_nfesTPNF.AsInteger of
          0: begin
            vDirXml:= vDir + '\arquivos\' + FormatDateTime('yyyymm', fdmt_nfesDEMI.AsDateTime) + '\recebidas';
            if not DirectoryExists(vDirXml) then
              ForceDirectories(vDirXml);

            case fdmt_nfesCSTAT.AsInteger of
              100,150: begin
                vDirXml:= vDirXml + IfThen(fdmt_nfesMODELO.AsString = '55', '\NF-e', '\NFC-e');
                if not DirectoryExists(vDirXml) then
                  ForceDirectories(vDirXml);

                vXML:= TNfe.consultaXML(fdmt_nfesID.AsString);
                vACBrNF.NotasFiscais.Clear();
                vACBrNF.NotasFiscais.LoadFromString(vXML);
                vACBrNF.NotasFiscais.Items[0].GravarXML(
                  fdmt_nfesCHNFE.AsString + '-nfe.xml',
                  vDirXml
                );
              end;
            end;
          end;
          1: begin
            vDirXml:= vDir + '\arquivos\' + FormatDateTime('yyyymm', fdmt_nfesDEMI.AsDateTime) + '\emitidas';
            if not DirectoryExists(vDirXml) then
              ForceDirectories(vDirXml);

            case fdmt_nfesCSTAT.AsInteger of
              100,150: begin
                vDirXml:= vDirXml + IfThen(fdmt_nfesMODELO.AsString = '55', '\NF-e', '\NFC-e');
                if not DirectoryExists(vDirXml) then
                  ForceDirectories(vDirXml);

                vXML:= TNfe.consultaXML(fdmt_nfesID.AsString);
                vACBrNF.NotasFiscais.Clear();
                vACBrNF.NotasFiscais.LoadFromString(vXML);
                vACBrNF.NotasFiscais.Items[0].GravarXML(
                  fdmt_nfesCHNFE.AsString + '-nfe.xml',
                  vDirXml
                );
              end;
              101,151: begin
                vDirXml:= vDirXml + IfThen(fdmt_nfesMODELO.AsString = '55', '\NF-e', '\NFC-e');
                vDirXml:= vDirXml + '\canceladas';
                if not DirectoryExists(vDirXml) then
                  ForceDirectories(vDirXml);

                vXML:= TNfe.consultaXML(fdmt_nfesID.AsString);
                vACBrNF.NotasFiscais.Clear();
                vACBrNF.NotasFiscais.LoadFromString(vXML);
                vACBrNF.NotasFiscais.Items[0].GravarXML(
                  fdmt_nfesCHNFE.AsString + '-can.xml',
                  vDirXml
                );
              end;
              102: begin
                vDirXml:= vDirXml + IfThen(fdmt_nfesMODELO.AsString = '55', '\NF-e', '\NFC-e');
                if not DirectoryExists(vDirXml) then
                  ForceDirectories(vDirXml);

                vDirXml:= vDirXml + '\inutilizadas.txt';
                vList.Clear;
                if FileExists(vDirXml) then
                  vList.LoadFromFile(vDirXml);

                vList.Add(
                  'MODELO: ' + fdmt_nfesMODELO.AsString +
                  ' SERIE: ' + fdmt_nfesSERIE.AsString +
                  ' NUMERO: ' + fdmt_nfesNNF.AsString
                );

                vList.SaveToFile(vDirXml);
              end;
            end;
          end;
        end;
        fdmt_nfes.Next;
      end;
    except on e: Exception do
      begin
        Result:= False;
        raise Exception.Create(e.Message);
      end;
    end;
  finally
    FreeAndNil(vList);
    FreeAndNil(vACBrNF);

    fdmt_nfes.First;
    fdmt_nfes.EnableControls;
  end;
end;

procedure TformNfeEmpresaList.FormCreate(Sender: TObject);
begin
  inherited;
  dtp_start.Date:= StartOfTheMonth(Now);
  dtp_end.Date:= EndOfTheMonth(Now);
  list(dtp_start.Date, dtp_end.Date);
end;

procedure TformNfeEmpresaList.list(startDate, endDate: TDate);
var
  vTotalRecebidas,
  vTotalEnviadas: Extended;
  vCanceladas,
  vInutilizadas: Integer;
begin
  TNfe.listNfeEmpresa(startDate, endDate, fdmt_nfes);

  vTotalRecebidas:= 0;
  vTotalEnviadas:= 0;
  vCanceladas:= 0;
  vInutilizadas:= 0;

  fdmt_nfes.DisableControls;
  fdmt_nfes.First();
  while not fdmt_nfes.Eof do
  begin
    case fdmt_nfesTPNF.AsInteger of
      0: vTotalRecebidas:= vTotalRecebidas + fdmt_nfesVNF.AsExtended;
      1: begin
        case fdmt_nfesCSTAT.AsInteger of
          100,150: vTotalEnviadas:= vTotalEnviadas + fdmt_nfesVNF.AsExtended;
          101,151: Inc(vCanceladas);
          102: Inc(vInutilizadas);
        end;
      end;
    end;
    fdmt_nfes.Next();
  end;
  fdmt_nfes.First();
  fdmt_nfes.EnableControls;

  lbl_total_recebidas.Caption:= THelper.ExtendedToString(vTotalRecebidas);
  lbl_total_enviadas.Caption:= THelper.ExtendedToString(vTotalEnviadas);
  lbl_numero_canceladas.Caption:= vCanceladas.ToString();
  lbl_numero_inutilizadas.Caption:= vInutilizadas.ToString();
end;

end.
