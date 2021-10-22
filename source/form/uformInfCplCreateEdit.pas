unit uformInfCplCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, NfeInfcpl;

type
  TformInfCplCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_main: TPanel;
    btn_confirmar: TButton;
    btn_cancelar: TButton;
    acl_infcpl: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    lbe_nome: TLabeledEdit;
    gpb_infcpl: TGroupBox;
    mm_infcpl: TMemo;
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    Infcpl: TNfeInfcpl;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();
  public
    { Public declarations }
  end;

var
  formInfCplCreateEdit: TformInfCplCreateEdit;

implementation

{$R *.dfm}

uses udmRepository, AuthService, Helper;

procedure TformInfCplCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.NfeInfcplId:= EmptyStr;
  Close;
end;

procedure TformInfCplCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformInfCplCreateEdit.EdtToObj;
begin
  Infcpl.Nome:= lbe_nome.Text;
  Infcpl.Infcpl:= mm_infcpl.Text;
end;

procedure TformInfCplCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  if TAuthService.NfeInfcplId = EmptyStr then Infcpl:= TNfeInfcpl.Create
  else Infcpl:= TNfeInfcpl.find(TAuthService.NfeInfcplId);
  ObjToEdt;
end;

procedure TformInfCplCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Infcpl);
end;

procedure TformInfCplCreateEdit.ObjToEdt;
begin
  if (Infcpl.Id = EmptyStr) then Exit();

  lbe_nome.Text:= Infcpl.Nome;
  mm_infcpl.Text:= Infcpl.Infcpl;
end;

procedure TformInfCplCreateEdit.save;
begin
  EdtToObj();
  try
    if Infcpl.save then
    begin
      TAuthService.NfeInfcplId:= Infcpl.Id;
      Close;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

end.
