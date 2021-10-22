unit uformModelo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TformModelo = class(TformBase)
    pnl_body: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    bvl_4: TBevel;
    btn_1: TButton;
    pnl_main: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formModelo: TformModelo;

implementation

{$R *.dfm}

end.
