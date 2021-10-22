unit ufrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ComCtrls, System.ZIP, Winapi.ActiveX,
  Winapi.ShlObj, System.Win.ComObj, System.Win.Registry;

type
  TfrmPrincipal = class(TForm)
    pnlBemVindo: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Bevel1: TBevel;
    Panel2: TPanel;
    Label3: TLabel;
    Bevel2: TBevel;
    Button1: TButton;
    Button2: TButton;
    Label4: TLabel;
    Label5: TLabel;
    pnlTermos: TPanel;
    Label6: TLabel;
    Panel4: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Image2: TImage;
    Bevel3: TBevel;
    Panel5: TPanel;
    Label10: TLabel;
    Bevel4: TBevel;
    btnInstalar: TButton;
    Button4: TButton;
    mmAcordo: TMemo;
    cbxAceitar: TCheckBox;
    Label7: TLabel;
    Button5: TButton;
    pnlInstalando: TPanel;
    Label11: TLabel;
    Panel6: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Image3: TImage;
    Bevel5: TBevel;
    Panel7: TPanel;
    Label15: TLabel;
    Bevel6: TBevel;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    mmInstalacao: TMemo;
    pgbStatus: TProgressBar;
    procedure Button2Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure btnInstalarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbxAceitarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function extrair(vP,vR,vA: string): Boolean;
    function ZipFileDecompress(FZipfile, APath: string): integer;
    function ExecAndWait(const FileName, Params: string; const WindowState: Word): boolean;
    procedure CreateShortcut(FileName, Parameters, InitialDir, ShortcutName, ShortcutFolder : String);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

const
  cPath: string = 'C:\wtsystem\bin';

{$R *.dfm}

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  pnlTermos.BringToFront;
end;

procedure TfrmPrincipal.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.btnInstalarClick(Sender: TObject);

begin
  pnlInstalando.BringToFront;
  if not DirectoryExists(cPath) then
    ForceDirectories(cPath);

  extrair(cPath,'FILES','files.zip');
  pgbStatus.Position:= 40;
  Application.ProcessMessages;
  Sleep(1000);

  ZipFileDecompress(cPath + '\files.zip', cPath);
  DeleteFile(cPath + '\files.zip');
  pgbStatus.Position:= 60;
  Application.ProcessMessages;
  Sleep(1000);

  ExecAndWait(cPath + '\wtsystem.bat', '', SW_SHOW);
  pgbStatus.Position:= 70;
  Application.ProcessMessages;
  Sleep(1000);

  ExecAndWait(cPath + '\firebird.exe', '', SW_SHOW);
  pgbStatus.Position:= 80;
  Application.ProcessMessages;
  Sleep(1000);

  ExecAndWait(cPath + '\suporte.exe', '', SW_SHOW);
  pgbStatus.Position:= 90;
  Application.ProcessMessages;
  Sleep(1000);

  CreateShortCut(
    cPath + '\wtsystem.exe',
    '',
    cPath,
    'WT - SYSTEM',
    '');

  pgbStatus.Position:= 100;
  Application.ProcessMessages;
  Sleep(1000);

  Close;
end;

procedure TfrmPrincipal.Button5Click(Sender: TObject);
begin
  pnlBemVindo.BringToFront;
end;

procedure TfrmPrincipal.Button8Click(Sender: TObject);
begin
  pnlTermos.BringToFront;
end;

procedure TfrmPrincipal.cbxAceitarClick(Sender: TObject);
begin
  if cbxAceitar.Checked then
    btnInstalar.Enabled:= True
  else
    btnInstalar.Enabled:= False;
end;

procedure TfrmPrincipal.CreateShortcut(FileName, Parameters, InitialDir,
  ShortcutName, ShortcutFolder: String);
var
  MyObject: IUnknown;
  MySLink: IShellLink;
  MyPFile: IPersistFile;
  Directory: String;
  WFileName: WideString;
  MyReg: TRegIniFile;
begin
  MyObject:= CreateComObject(CLSID_ShellLink);
  MySLink:= MyObject as IShellLink;
  MyPFile:= MyObject as IPersistFile;

  with MySLink do
  begin
    SetArguments(PWideChar(Parameters));
    SetPath(PChar(FileName));
    SetWorkingDirectory(PChar(InitialDir));
  end;

  MyReg:= TRegIniFile.Create('Software\\MicroSoft\\Windows\\CurrentVersion\\Explorer');
  Directory:= MyReg.ReadString('Shell Folders','Desktop','');
  WFileName:= Directory + '\\' + ShortcutName + '.lnk';
  MyPFile.Save(PWChar(WFileName), False);
  MyReg.Free;
end;

function TfrmPrincipal.ExecAndWait(const FileName, Params: string;
  const WindowState: Word): boolean;
var
  SUInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CmdLine: string;
begin
  CmdLine:= FileName + Params;
  FillChar(SUInfo, SizeOf(SUInfo), #0);

  with SUInfo do begin
    cb:= SizeOf(SUInfo);
    dwFlags:= STARTF_USESHOWWINDOW;
    wShowWindow:= WindowState;
  end;

  Result := CreateProcess(nil, PChar(CmdLine), nil, nil, false,
  CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
  PChar(ExtractFilePath(Filename)), SUInfo, ProcInfo);

  if Result then begin
    WaitForSingleObject(ProcInfo.hProcess, INFINITE);

  CloseHandle(ProcInfo.hProcess);
  CloseHandle(ProcInfo.hThread);
end;
end;

function TfrmPrincipal.extrair(vP,vR,vA: string): Boolean;
var
  fs: TFileStream;
  rs: TResourceStream;
  s : string;
begin
  Result:= True;
  try
    rs := TResourceStream.Create(HInstance, vR, RT_RCDATA);
    s  := vP + '\' + vA;
    fs := TFileStream.Create(s,fmCreate);
    rs.SaveToStream(fs);
    fs.Free;
  except
    Result:= False;
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  pnlBemVindo.BringToFront;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  if DirectoryExists(cPath) then
  begin
    ShowMessage('O Sistema já esta instalado nesta maquina.');
    Close;
  end;
end;

function TfrmPrincipal.ZipFileDecompress(FZipfile, APath: string): integer;
var
  vZ: TZipFile;
begin
  Result:= 0;
  vZ:= TZipFile.Create;
  try
    if FileExists(FZipfile) then
      vZ.Open(FZipfile, zmReadWrite)
    else
      raise Exception.Create('Não encontrei: ' + FZipfile);

    vZ.ExtractAll(APath);
    vZ.Close;
    Result:= 1;
  finally
    vZ.Free;
  end;
end;

end.
