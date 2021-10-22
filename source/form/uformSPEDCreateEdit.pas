unit uformSPEDCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Sped, Vcl.ComCtrls, System.StrUtils,
  System.DateUtils;

type
  TformSPEDCreateEdit = class(TformBase)
    pnl_body: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_main: TPanel;
    btn_cancelar: TButton;
    btn_confirmar: TButton;
    acl_sped: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    cbx_cod_ver: TComboBox;
    cbx_cod_fin: TComboBox;
    dtp_dt_ini: TDateTimePicker;
    dtp_dt_fin: TDateTimePicker;
    cbx_ind_perfil: TComboBox;
    cbx_ind_ativ: TComboBox;
    lb_cod_ver: TLabel;
    lb_cod_fin: TLabel;
    lb_dt_ini: TLabel;
    lb_dt_fin: TLabel;
    lb_ind_perfil: TLabel;
    lb_ind_ativ: TLabel;
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    SPED: TSped;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();
  public
    { Public declarations }
  end;

var
  formSPEDCreateEdit: TformSPEDCreateEdit;

implementation

uses
  AuthService, Helper;

{$R *.dfm}

procedure TformSPEDCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.SPEDId:= EmptyStr;
  Close();
end;

procedure TformSPEDCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformSPEDCreateEdit.EdtToObj;
begin
  case cbx_cod_ver.ItemIndex of
    0: SPED.CodVer:= 11;
  end;
  SPED.CodFin:= cbx_cod_fin.ItemIndex;
  SPED.DtIni:= dtp_dt_ini.Date;
  SPED.DtFin:= dtp_dt_fin.Date;
  case cbx_ind_perfil.ItemIndex of
    0: SPED.IndPerfil:= 'A';
    1: SPED.IndPerfil:= 'B';
    2: SPED.IndPerfil:= 'C';
  end;
  SPED.IndAtiv:= cbx_ind_ativ.ItemIndex;
end;

procedure TformSPEDCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  if (TAuthService.SPEDId = EmptyStr) then SPED:= TSped.Create
  else SPED:= TSped.find(TAuthService.SPEDId);
  ObjToEdt;
end;

procedure TformSPEDCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(SPED);
end;

procedure TformSPEDCreateEdit.ObjToEdt;
begin
  if (SPED.Id = EmptyStr) then
  begin
    SPED.SpedStatus:= 0;
    cbx_cod_ver.ItemIndex:= 0;
    cbx_cod_fin.ItemIndex:= 0;
    dtp_dt_ini.Date:= StartOfTheMonth(IncMonth(Now,-1));
    dtp_dt_fin.Date:= EndOfTheMonth(IncMonth(Now,-1));
    cbx_ind_perfil.ItemIndex:= 0;
    cbx_ind_ativ.ItemIndex:= 1;
    Exit();
  end;

  case SPED.CodVer of
    11: cbx_cod_ver.ItemIndex:= 0;
  end;
  cbx_cod_fin.ItemIndex:= SPED.CodFin;
  dtp_dt_ini.Date:= SPED.DtIni;
  dtp_dt_fin.Date:= SPED.DtFin;
  cbx_ind_perfil.ItemIndex:= AnsiIndexStr(SPED.IndPerfil, ['A', 'B','C']);
  cbx_ind_ativ.ItemIndex:= SPED.IndAtiv;
end;

procedure TformSPEDCreateEdit.save;
begin
  EdtToObj;
  try
    if SPED.save() then
    begin
      TAuthService.SPEDId:= SPED.Id;
      Close;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

end.
