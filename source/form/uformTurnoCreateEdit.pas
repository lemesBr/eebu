unit uformTurnoCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Vcl.Mask, Turno;

type
  TformTurnoCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    acl_turno: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    btn_cancelar: TButton;
    btn_confirmar: TButton;
    lbe_referencia: TLabeledEdit;
    lbe_nome: TLabeledEdit;
    med_inicio: TMaskEdit;
    med_fim: TMaskEdit;
    lb_inicio: TLabel;
    lb_fim: TLabel;
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    Turno: TTurno;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();

    procedure setRequired(Obj: TObject);
    procedure onEnter(Sender: TObject);
    function validaCamposObrigatorios(): Boolean;
  public
    { Public declarations }
  end;

var
  formTurnoCreateEdit: TformTurnoCreateEdit;

implementation

{$R *.dfm}

uses udmRepository, AuthService, Helper;

procedure TformTurnoCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.TurnoId:= EmptyStr;
  Close();
end;

procedure TformTurnoCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformTurnoCreateEdit.EdtToObj;
begin
  Turno.Nome:= lbe_nome.Text;
  Turno.Inicio:= med_inicio.Text;
  Turno.Fim:= med_fim.Text;
end;

procedure TformTurnoCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  if (TAuthService.TurnoId = EmptyStr) then Turno:= TTurno.Create
  else Turno:= TTurno.find(TAuthService.TurnoId);
  ObjToEdt;
end;

procedure TformTurnoCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Turno);
end;

procedure TformTurnoCreateEdit.ObjToEdt;
begin
  if (Turno.Id = EmptyStr) then
  begin
    pnl_header.Caption:= 'NOVO TURNO';
    med_inicio.Text:= '0000';
    med_fim.Text:= '0000';
    Exit();
  end;

  pnl_header.Caption:= 'EDITAR TURNO';
  lbe_referencia.Text:= Turno.Referencia.ToString();
  lbe_nome.Text:= Turno.Nome;
  med_inicio.Text:= Turno.Inicio;
  med_fim.Text:= Turno.Fim;
end;

procedure TformTurnoCreateEdit.onEnter(Sender: TObject);
begin
  if (Sender is TLabeledEdit) then
  begin
    TLabeledEdit(Sender).Color:= clWhite;
    TLabeledEdit(Sender).OnEnter:= nil;
  end
  else if (Sender is TMaskEdit) then
  begin
    TMaskEdit(Sender).Color:= clWhite;
    TMaskEdit(Sender).OnEnter:= nil;
  end;
end;

procedure TformTurnoCreateEdit.save;
begin
  EdtToObj();
  try
    if not validaCamposObrigatorios() then Exit();

    if Turno.save() then
    begin
      TAuthService.TurnoId:= Turno.Id;
      Close();
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformTurnoCreateEdit.setRequired(Obj: TObject);
begin
  if (Obj is TLabeledEdit) then
  begin
    TLabeledEdit(Obj).Color:= $00AAAAFF;
    TLabeledEdit(Obj).OnEnter:= onEnter;
  end
  else if (Obj is TMaskEdit) then
  begin
    TMaskEdit(Obj).Color:= $00AAAAFF;
    TMaskEdit(Obj).OnEnter:= onEnter;
  end;
end;

function TformTurnoCreateEdit.validaCamposObrigatorios: Boolean;
var
  vRequired: Integer;
begin
  vRequired:= 0;
  if (Trim(lbe_nome.Text) = '') or (Trim(lbe_nome.Text).Length < 3) then
  begin
    setRequired(lbe_nome);
    Inc(vRequired);
  end;

  if (Trim(med_inicio.Text) = '') or (Trim(med_inicio.Text).Length < 4) then
  begin
    setRequired(med_inicio);
    Inc(vRequired);
  end;

  if (Trim(med_fim.Text) = '') or (Trim(med_fim.Text).Length < 4) then
  begin
    setRequired(med_fim);
    Inc(vRequired);
  end;

  Result:= (vRequired = 0);
  if (not Result) then  THelper.Mensagem('Preencha os dados obrigatórios.');
end;

end.
