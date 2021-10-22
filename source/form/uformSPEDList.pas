unit uformSPEDList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, System.Actions, Vcl.ActnList, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Menus, ACBrMail;

type
  TformSPEDList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    dbg_sped: TDBGrid;
    btn_rollback: TButton;
    btn_store: TButton;
    btn_update: TButton;
    btn_destroy: TButton;
    acl_sped: TActionList;
    act_rollback: TAction;
    act_store: TAction;
    act_update: TAction;
    act_destroy: TAction;
    fdmt_sped: TFDMemTable;
    fdmt_spedID: TStringField;
    ds_sped: TDataSource;
    fdmt_spedDT_INI: TDateField;
    fdmt_spedSPED_STATUS: TIntegerField;
    btn_sped: TButton;
    ppm_sped: TPopupMenu;
    act_sped_gerar: TAction;
    act_sped_enviar: TAction;
    GERARSPED: TMenuItem;
    ENVIAREMAIL: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure dbg_spedDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_storeExecute(Sender: TObject);
    procedure act_updateExecute(Sender: TObject);
    procedure act_destroyExecute(Sender: TObject);
    procedure acl_spedUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure act_sped_enviarExecute(Sender: TObject);
    procedure act_sped_gerarExecute(Sender: TObject);
  private
    { Private declarations }
    procedure list();
  public
    { Public declarations }
  end;

var
  formSPEDList: TformSPEDList;

implementation

uses
  Sped, uformSPEDCreateEdit, AuthService, udmRepository, Helper, Empresa,
  System.StrUtils;

{$R *.dfm}

{ TformSpedList }

procedure TformSPEDList.acl_spedUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_update.Enabled:= (fdmt_sped.RecordCount >= 1);
  act_destroy.Enabled:= (fdmt_sped.RecordCount >= 1);
  act_sped_gerar.Enabled:= (fdmt_sped.RecordCount >= 1) and (fdmt_spedSPED_STATUS.AsInteger in[0,1,2]);
  act_sped_enviar.Enabled:= (fdmt_sped.RecordCount >= 1) and (fdmt_spedSPED_STATUS.AsInteger in[1,2]);
end;

procedure TformSPEDList.act_destroyExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TformSPEDList.act_rollbackExecute(Sender: TObject);
begin
  Close();
end;

procedure TformSPEDList.act_sped_enviarExecute(Sender: TObject);
var
  vACBrMail: TACBrMail;
  vSPED: TSped;
  vReferente: string;
  vContribuinte: string;
  vDiretorio: string;
begin
  dbg_sped.SetFocus();

  if not THelper.Mensagem('Deseja enviar arquivo para o contador?',1) then
    Exit();

  vACBrMail:= nil;
  vSPED:= nil;
  try
    try
      vSPED:= TSped.find(fdmt_spedID.AsString);
      if not Assigned(vSPED) then
        raise Exception.Create('Falha ao consultar dados do SPED.');

      if not Assigned(vSPED.Empresa.Contabilista) then
        raise Exception.Create('Falha ao consultar dados do contador.');

      if Trim(vSPED.Empresa.Contabilista.Email) = '' then
        raise Exception.Create('Email do contador inválido.');

      vDiretorio:= ExtractFileDir(Application.ExeName) + '\efd';

      if not DirectoryExists(vDiretorio) then
        ForceDirectories(vDiretorio);

      vReferente:= FormatDateTime('yyyymm',vSPED.DtIni);
      vContribuinte:= IfThen(vSPED.Empresa.TipoPessoa = 'J', vSPED.Empresa.RazaoSocial, vSPED.Empresa.Nome);

      vDiretorio:= vDiretorio + '\EFD-' +
        UpperCase(vReferente + '-' +
          StringReplace(vContribuinte,' ','',[rfReplaceAll])) + '.txt';

      if FileExists(vDiretorio) then
        DeleteFile(vDiretorio);

      TSped.exportarEFD(vSPED.Id,vDiretorio);

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
      vACBrMail.FromName:= 'WT-SYSTEM / ' + vSPED.Empresa.Nome;
      vACBrMail.Subject:= 'Arquivo EFD';
      vACBrMail.AltBody.Add(vSPED.Empresa.Nome + ': Segue anexo o arquivo EFD.');
      vACBrMail.AltBody.Add('');
      vACBrMail.AltBody.Add('Atenciosamente WT-SYSTEM');
      vACBrMail.AddAddress(vSPED.Empresa.Contabilista.Email,vSPED.Empresa.Contabilista.Nome);
      vACBrMail.AddAttachment(vDiretorio);
      vACBrMail.Send(False);
      vSPED.SpedStatus:= 2;
      vSPED.save();
      THelper.Mensagem('Arquivo enviado com sucesso.');
      list();
    except on e: exception do
      THelper.Mensagem('Falha ao tentar enviar arquivo. Erro: ' + e.Message);
    end;
  finally
    FreeAndNil(vSPED);
    FreeAndNil(vACBrMail);
  end;
end;

procedure TformSPEDList.act_sped_gerarExecute(Sender: TObject);
begin
  try
    TSped.gerar(fdmt_spedID.AsString);
    list();
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformSPEDList.act_storeExecute(Sender: TObject);
var
  v_form: TformSPEDCreateEdit;
begin
  TAuthService.SPEDId:= EmptyStr;
  try
    v_form:= TformSPEDCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.SPEDId <> EmptyStr) then
    list();
end;

procedure TformSPEDList.act_updateExecute(Sender: TObject);
var
  v_form: TformSPEDCreateEdit;
begin
  TAuthService.SPEDId:= fdmt_spedID.AsString;
  try
    v_form:= TformSPEDCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.SPEDId <> EmptyStr) then
    list();
end;

procedure TformSPEDList.dbg_spedDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  if (gdSelected in State) then
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;

  if not Odd(TDBGrid(Sender).DataSource.DataSet.RecNo) then
  begin
    if not (gdSelected in State) then
    begin
      TDBGrid(Sender).Canvas.Brush.Color:= $00E2E2E2;
      TDBGrid(Sender).Canvas.FillRect(Rect);
      TDBGrid(Sender).DefaultDrawDataCell(Rect,Column.Field,State);
    end;
  end;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);

  if (fdmt_sped.RecordCount >= 1) then
  begin
    if Column.FieldName = 'SPED_STATUS' then
    begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      case fdmt_spedSPED_STATUS.AsInteger of
        0: dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 6, Rect.Top + 1, -1);
        1: dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 6, Rect.Top + 1, 17);
        2: dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 6, Rect.Top + 1, 12);
      end;
    end;
  end;
end;

procedure TformSPEDList.FormCreate(Sender: TObject);
begin
  inherited;
  list();
end;

procedure TformSPEDList.list;
begin
  TSped.list(fdmt_sped);
end;

end.
