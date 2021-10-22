unit uformConfiguracaoFiscalCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  ConfiguracaoFiscal, System.Actions, Vcl.ActnList;

type
  TformConfiguracaoFiscalCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_1: TButton;
    pnl_body: TPanel;
    Button1: TButton;
    lbe_operacao_fiscal: TLabeledEdit;
    lbe_grupo_tributario: TLabeledEdit;
    acl_configfiscal: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbe_operacao_fiscalKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_grupo_tributarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
  private
    { Private declarations }
    ConfiguracaoFiscal: TConfiguracaoFiscal;
    procedure ObjToEdt;
    procedure save();
    procedure findOperacaoFiscal;
    procedure findGrupoTributario;
  public
    { Public declarations }
  end;

var
  formConfiguracaoFiscalCreateEdit: TformConfiguracaoFiscalCreateEdit;

implementation

uses
  AuthService, uformOperacaoFiscalList, uformGrupoTributarioList, udmRepository;

{$R *.dfm}

{ TformConfiguracaoFiscalCreateEdit }

procedure TformConfiguracaoFiscalCreateEdit.act_cancelarExecute(
  Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TformConfiguracaoFiscalCreateEdit.act_confirmarExecute(
  Sender: TObject);
begin
  inherited;
  save();
end;

procedure TformConfiguracaoFiscalCreateEdit.findGrupoTributario;
var
  v_form: TformGrupoTributarioList;
begin
  TAuthService.GrupoTributarioId:= EmptyStr;
  try
    v_form:= TformGrupoTributarioList.Create(nil);
    v_form.Tag:= 1;
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.GrupoTributarioId <> EmptyStr) then
  begin
    ConfiguracaoFiscal.GrupoTributarioId:= TAuthService.GrupoTributarioId;
    lbe_grupo_tributario.Text:= ConfiguracaoFiscal.GrupoTributario.Nome;
  end;
end;

procedure TformConfiguracaoFiscalCreateEdit.findOperacaoFiscal;
var
  v_form: TformOperacaoFiscalList;
begin
  TAuthService.OperacaoFiscalId:= EmptyStr;
  try
    v_form:= TformOperacaoFiscalList.Create(nil);
    v_form.Tag:= 1;
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.OperacaoFiscalId <> EmptyStr) then
  begin
    ConfiguracaoFiscal.OperacaoFiscalId:= TAuthService.OperacaoFiscalId;
    lbe_operacao_fiscal.Text:= ConfiguracaoFiscal.OperacaoFiscal.Nome;
  end;
end;

procedure TformConfiguracaoFiscalCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  if TAuthService.ConfiguracaoFiscalId = EmptyStr then ConfiguracaoFiscal:= TConfiguracaoFiscal.Create
  else ConfiguracaoFiscal:= TConfiguracaoFiscal.find(TAuthService.ConfiguracaoFiscalId);
  ObjToEdt;
end;

procedure TformConfiguracaoFiscalCreateEdit.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(ConfiguracaoFiscal);
end;

procedure TformConfiguracaoFiscalCreateEdit.lbe_grupo_tributarioKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    13: lbe_operacao_fiscal.SetFocus;
    112: findGrupoTributario;
  end;

  { TODO -oThiago Ribeiro -cCadastros : Não está aparecendo o botão de exportar quando busca o Grupo Tributario. }
end;

procedure TformConfiguracaoFiscalCreateEdit.lbe_operacao_fiscalKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    13: lbe_grupo_tributario.SetFocus;
    112: findOperacaoFiscal;
  end;

   { TODO -oThiago Ribeiro -cCadastros : Não está aparecendo o botão de exportar quando busca a Operação Fiscal. }
end;

procedure TformConfiguracaoFiscalCreateEdit.ObjToEdt;
begin
  if Assigned(ConfiguracaoFiscal.OperacaoFiscal) then
    lbe_operacao_fiscal.Text:= ConfiguracaoFiscal.OperacaoFiscal.Nome;
  if Assigned(ConfiguracaoFiscal.GrupoTributario) then
  lbe_grupo_tributario.Text:= ConfiguracaoFiscal.GrupoTributario.Nome;
end;

procedure TformConfiguracaoFiscalCreateEdit.save;
begin
  if ConfiguracaoFiscal.validate then
  begin
    if ConfiguracaoFiscal.save() then
      Close;
  end;
end;

end.
