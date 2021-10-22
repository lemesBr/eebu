unit uformUnidadeCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Unidade, System.Actions, Vcl.ActnList;

type
  TformUnidadeCreateEdit = class(TformBase)
    pnl_body: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_1: TButton;
    Button1: TButton;
    pnl_main: TPanel;
    lbe_nome: TLabeledEdit;
    lbe_unidade: TLabeledEdit;
    acl_unidade: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
  private
    { Private declarations }
    Unidade: TUnidade;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();
  public
    { Public declarations }
  end;

var
  formUnidadeCreateEdit: TformUnidadeCreateEdit;

implementation

uses
  AuthService, udmRepository, Helper;

{$R *.dfm}

{ TformUnidadeCreateEdit }

procedure TformUnidadeCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.UnidadeId:= EmptyStr;
  Close;
end;

procedure TformUnidadeCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformUnidadeCreateEdit.EdtToObj;
begin
  Unidade.Nome:= lbe_nome.Text;
  Unidade.Unidade:= lbe_unidade.Text;
end;

procedure TformUnidadeCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  if TAuthService.UnidadeId = EmptyStr then Unidade:= TUnidade.Create
  else Unidade:= TUnidade.find(TAuthService.UnidadeId);
  ObjToEdt;
end;

procedure TformUnidadeCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Unidade);
end;

procedure TformUnidadeCreateEdit.ObjToEdt;
begin
  if (Unidade.Id = EmptyStr) then
  begin
    pnl_header.Caption:= 'NOVA UNIDADE';
    Exit();
  end
  else
    pnl_header.Caption:= 'EDITAR UNIDADE';

  lbe_nome.Text:= Unidade.Nome;
  lbe_unidade.Text:= Unidade.Unidade;
end;

procedure TformUnidadeCreateEdit.save;
begin
  EdtToObj;
  try
    if THelper.ValidaCamposObrigatorios(pnl_main) then
    begin
      if Unidade.save then
      begin
        TAuthService.UnidadeId:= Unidade.Id;
        Close;
      end;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

end.
