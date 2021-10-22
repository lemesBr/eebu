unit uformSuprimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls;

type
  TformSuprimento = class(TformBase)
    acl_suprimento: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    lbe_valor: TLabeledEdit;
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    btn_cancelar: TButton;
    btn_confirmar: TButton;
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbe_valorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure acl_suprimentoUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formSuprimento: TformSuprimento;

implementation

uses
  Suprimento, Helper, CustomEditHelper, udmRepository;

{$R *.dfm}

procedure TformSuprimento.acl_suprimentoUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_confirmar.Enabled:= (THelper.StringToExtended(lbe_valor.Text) > 0);
end;

procedure TformSuprimento.act_cancelarExecute(Sender: TObject);
begin
  Close();
end;

procedure TformSuprimento.act_confirmarExecute(Sender: TObject);
var
  vSuprimento: TSuprimento;
  vValor: Extended;
begin
  if not act_confirmar.Enabled then Exit();
  vValor:= THelper.StringToExtended(lbe_valor.Text);
  if not THelper.Mensagem('Confirma um suprimento de ' + THelper.ExtendedToString(vValor) + '?', 1) then Exit();

  try
    vSuprimento:= TSuprimento.Create;
    try
      vSuprimento.Valor:= vValor;
      vSuprimento.save();

      if THelper.Mensagem('Deseja imprimir o comprovante?', 1) then
        TSuprimento.imprimir(vSuprimento.Id);

      Close();
    except on e: Exception do
      THelper.Mensagem(e.Message);
    end;
  finally
    FreeAndNil(vSuprimento);
  end;
end;

procedure TformSuprimento.FormCreate(Sender: TObject);
begin
  inherited;
  TCustomEdit(lbe_valor).EditFloat();
end;

procedure TformSuprimento.lbe_valorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = 13) then
    act_confirmarExecute(Sender);
end;

end.
