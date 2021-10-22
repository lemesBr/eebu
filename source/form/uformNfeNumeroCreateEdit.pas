unit uformNfeNumeroCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, NfeNumero;

type
  TformNfeNumeroCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    lbe_modelo: TLabeledEdit;
    lbe_serie: TLabeledEdit;
    lbe_numero: TLabeledEdit;
    btn_cancelar: TButton;
    btn_confirmar: TButton;
    acl_nfe_numero: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    NfeNumero: TNfeNumero;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();
  public
    { Public declarations }
  end;

var
  formNfeNumeroCreateEdit: TformNfeNumeroCreateEdit;

implementation

{$R *.dfm}

uses udmRepository, AuthService, Helper;

procedure TformNfeNumeroCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.NfeNumeroId:= EmptyStr;
  Close;
end;

procedure TformNfeNumeroCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformNfeNumeroCreateEdit.EdtToObj;
begin
  NfeNumero.Modelo:= StrToIntDef(lbe_modelo.Text, 0);
  NfeNumero.Serie:= StrToIntDef(lbe_serie.Text, 0);
  NfeNumero.Numero:= StrToIntDef(lbe_numero.Text, 0);
end;

procedure TformNfeNumeroCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  if (TAuthService.NfeNumeroId = EmptyStr) then NfeNumero:= TNfeNumero.Create
  else NfeNumero:= TNfeNumero.find(TAuthService.NfeNumeroId);
  ObjToEdt;
end;

procedure TformNfeNumeroCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(NfeNumero);
end;

procedure TformNfeNumeroCreateEdit.ObjToEdt;
begin
  if (NfeNumero.Id = EmptyStr) then
  begin
    pnl_header.Caption:= 'NOVO NFE NUMERO';
    lbe_modelo.Text:= EmptyStr;
    lbe_serie.Text:= EmptyStr;
    lbe_numero.Text:= EmptyStr;
    Exit();
  end;

  pnl_header.Caption:= 'EDITAR NFE NUMERO';
  lbe_modelo.Text:= NfeNumero.Modelo.ToString();
  lbe_serie.Text:= NfeNumero.Serie.ToString();
  lbe_numero.Text:= NfeNumero.Numero.ToString();
end;

procedure TformNfeNumeroCreateEdit.save;
begin
  EdtToObj;
  try
    if NfeNumero.save() then
    begin
      TAuthService.NfeNumeroId:= NfeNumero.Id;
      Close;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

end.
