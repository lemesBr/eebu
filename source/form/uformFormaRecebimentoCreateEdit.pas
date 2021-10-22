unit uformFormaRecebimentoCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  FormaRecebimento;

type
  TformFormaRecebimentoCreateEdit = class(TformBase)
    pnl_body: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_main: TPanel;
    btn_forma_recebimento_save: TButton;
    btn_forma_recebimento_cancel: TButton;
    lbe_tpag: TLabeledEdit;
    lbe_nome: TLabeledEdit;
    procedure btn_forma_recebimento_cancelClick(Sender: TObject);
    procedure btn_forma_recebimento_saveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FormaRecebimento: TFormaRecebimento;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();
  public
    { Public declarations }
  end;

var
  formFormaRecebimentoCreateEdit: TformFormaRecebimentoCreateEdit;

implementation

uses
  AuthService;

{$R *.dfm}

procedure TformFormaRecebimentoCreateEdit.btn_forma_recebimento_cancelClick(
  Sender: TObject);
begin
  TAuthService.FormaRecebimentoId:= EmptyStr;
  Close;
end;

procedure TformFormaRecebimentoCreateEdit.btn_forma_recebimento_saveClick(
  Sender: TObject);
begin
  save();
end;

procedure TformFormaRecebimentoCreateEdit.EdtToObj;
begin
  FormaRecebimento.Tpag:= lbe_tpag.Text;
  FormaRecebimento.Nome:= lbe_nome.Text;
end;

procedure TformFormaRecebimentoCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  if TAuthService.FormaRecebimentoId = EmptyStr then FormaRecebimento:= TFormaRecebimento.Create
  else FormaRecebimento:= TFormaRecebimento.find(TAuthService.FormaRecebimentoId);
  ObjToEdt;
end;

procedure TformFormaRecebimentoCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FormaRecebimento);
end;

procedure TformFormaRecebimentoCreateEdit.ObjToEdt;
begin
  lbe_tpag.Text:= FormaRecebimento.Tpag;
  lbe_nome.Text:= FormaRecebimento.Nome;
end;

procedure TformFormaRecebimentoCreateEdit.save;
begin
  EdtToObj;
  if FormaRecebimento.save then
  begin
    TAuthService.FormaRecebimentoId:= FormaRecebimento.Id;
    Close;
  end;
end;

end.
