unit uformGrupoTributarioCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  GrupoTributario, System.Actions, Vcl.ActnList;

type
  TformGrupoTributarioCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_confirmar: TButton;
    pnl_body: TPanel;
    btn_cancelar: TButton;
    lbe_nome: TLabeledEdit;
    acl_grupo_tributario: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    cbx_orig: TComboBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
  private
    { Private declarations }
    GrupoTributario: TGrupoTributario;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();
  public
    { Public declarations }
  end;

var
  formGrupoTributarioCreateEdit: TformGrupoTributarioCreateEdit;

implementation

uses
  AuthService, udmRepository, Helper;

{$R *.dfm}

{ TformGrupoTributarioCreateEdit }

procedure TformGrupoTributarioCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.GrupoTributarioId:= EmptyStr;
  Close;
end;

procedure TformGrupoTributarioCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformGrupoTributarioCreateEdit.EdtToObj;
begin
  GrupoTributario.Nome:= lbe_nome.Text;
  GrupoTributario.Orig:= cbx_orig.ItemIndex.ToString();
end;

procedure TformGrupoTributarioCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  if TAuthService.GrupoTributarioId = EmptyStr then GrupoTributario:= TGrupoTributario.Create
  else GrupoTributario:= TGrupoTributario.find(TAuthService.GrupoTributarioId);
  ObjToEdt;
end;

procedure TformGrupoTributarioCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(GrupoTributario);
end;

procedure TformGrupoTributarioCreateEdit.ObjToEdt;
begin
  if (GrupoTributario.Id = EmptyStr) then
    pnl_header.Caption:= 'NOVO GRUPO TRIBUTÁRIO'
  else
    pnl_header.Caption:= 'EDITAR GRUPO TRIBUTÁRIO';

  lbe_nome.Text:= GrupoTributario.Nome;
  cbx_orig.ItemIndex:= StrToIntDef(GrupoTributario.Orig, 0);
end;

procedure TformGrupoTributarioCreateEdit.save;
begin
  EdtToObj;
  try
    if GrupoTributario.validate then
    begin
      if GrupoTributario.save then
      begin
        TAuthService.GrupoTributarioId:= GrupoTributario.Id;
        Close;
      end;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

end.
