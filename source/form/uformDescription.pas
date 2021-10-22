unit uformDescription;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList;

type
  TformDescription = class(TformBase)
    pnl_principal: TPanel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    GroupBox1: TGroupBox;
    mm_descricao: TMemo;
    btn_cancelar: TButton;
    btn_confirmar: TButton;
    act_description: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure act_descriptionUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formDescription: TformDescription;

implementation

{$R *.dfm}

uses udmRepository, AuthService, Helper;

procedure TformDescription.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.Description:= EmptyStr;
  Close;
end;

procedure TformDescription.act_confirmarExecute(Sender: TObject);
begin
  TAuthService.Description:= UpperCase(THelper.RemoveAcentos(Trim(mm_descricao.Text)));
  Close;
end;

procedure TformDescription.act_descriptionUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_confirmar.Enabled:= (Trim(mm_descricao.Text).Length >= 16);
end;

procedure TformDescription.FormShow(Sender: TObject);
begin
  pnl_header.Caption:= TAuthService.Description;
end;

end.
