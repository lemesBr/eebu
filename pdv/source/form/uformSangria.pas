unit uformSangria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls;

type
  TformSangria = class(TformBase)
    lbe_valor: TLabeledEdit;
    acl_sangria: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    lbe_motivo: TLabeledEdit;
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    btn_cancelar: TButton;
    btn_confirmar: TButton;
    procedure act_cancelarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure lbe_valorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure acl_sangriaUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formSangria: TformSangria;

implementation

{$R *.dfm}

uses CustomEditHelper, Sangria, Helper, udmRepository;

procedure TformSangria.acl_sangriaUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_confirmar.Enabled:= (THelper.StringToExtended(lbe_valor.Text) > 0) and
    (Trim(lbe_motivo.Text).Length >= 5);
end;

procedure TformSangria.act_cancelarExecute(Sender: TObject);
begin
  Close();
end;

procedure TformSangria.act_confirmarExecute(Sender: TObject);
var
  vSangria: TSangria;
  vValor: Extended;
begin
  if not act_confirmar.Enabled then Exit();
  vValor:= THelper.StringToExtended(lbe_valor.Text);
  if not THelper.Mensagem('Confirma uma sangria de ' + THelper.ExtendedToString(vValor) + '?', 1) then Exit();

  try
    vSangria:= TSangria.Create;
    try
      vSangria.Valor:= vValor;
      vSangria.Motivo:= Trim(lbe_motivo.Text);
      vSangria.save();

      if THelper.Mensagem('Deseja imprimir o comprovante?', 1) then
        TSangria.imprimir(vSangria.Id);

      Close();
    except on e: Exception do
      THelper.Mensagem(e.Message);
    end;
  finally
    FreeAndNil(vSangria);
  end;
end;

procedure TformSangria.FormCreate(Sender: TObject);
begin
  inherited;
  TCustomEdit(lbe_valor).EditFloat();
end;

procedure TformSangria.lbe_valorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (key = 13) then
  begin
    case TWinControl(Sender).TabOrder of
      0: lbe_motivo.SetFocus();
      1: act_confirmarExecute(Sender);
    end;
  end;
end;

end.
