unit uformBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Conexao;

type
  TformBase = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formBase: TformBase;

implementation

uses
  AuthService;

{$R *.dfm}

procedure TformBase.FormCreate(Sender: TObject);
begin
  if TAuthService.Screen then
  begin
    Self.Width:= TAuthService.Width;
    Self.Height:= TAuthService.Height;
    Self.WindowState:= wsNormal;
    Self.Position:= poScreenCenter;
  end;

  if Self.AlphaBlend then Self.AlphaBlendValue:= 250;
end;

initialization
  TConexao.GetInstance();

end.
