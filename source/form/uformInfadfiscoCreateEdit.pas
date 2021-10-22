unit uformInfadfiscoCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, NfeInfadfisco;

type
  TformInfadfiscoCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    lbe_nome: TLabeledEdit;
    gpb_infadfisco: TGroupBox;
    mm_infadfisco: TMemo;
    btn_cancelar: TButton;
    btn_confirmar: TButton;
    acl_infadfisco: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    Infadfisco: TNfeInfadfisco;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();
  public
    { Public declarations }
  end;

var
  formInfadfiscoCreateEdit: TformInfadfiscoCreateEdit;

implementation

{$R *.dfm}

uses udmRepository, AuthService, Helper;

procedure TformInfadfiscoCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.NfeInfadfiscoId:= EmptyStr;
  Close;
end;

procedure TformInfadfiscoCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformInfadfiscoCreateEdit.EdtToObj;
begin
  Infadfisco.Nome:= lbe_nome.Text;
  Infadfisco.Infadfisco:= mm_infadfisco.Text;
end;

procedure TformInfadfiscoCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  if TAuthService.NfeInfadfiscoId = EmptyStr then Infadfisco:= TNfeInfadfisco.Create
  else Infadfisco:= TNfeInfadfisco.find(TAuthService.NfeInfadfiscoId);
  ObjToEdt;
end;

procedure TformInfadfiscoCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Infadfisco);
end;

procedure TformInfadfiscoCreateEdit.ObjToEdt;
begin
  if (Infadfisco.Id = EmptyStr) then Exit();

  lbe_nome.Text:= Infadfisco.Nome;
  mm_infadfisco.Text:= Infadfisco.Infadfisco;
end;

procedure TformInfadfiscoCreateEdit.save;
begin
  EdtToObj();
  try
    if Infadfisco.save then
    begin
      TAuthService.NfeInfadfiscoId:= Infadfisco.Id;
      Close;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

end.
