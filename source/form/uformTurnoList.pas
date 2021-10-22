unit uformTurnoList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Actions,
  Vcl.ActnList, Vcl.Grids, Vcl.DBGrids;

type
  TformTurnoList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    acl_turnos: TActionList;
    act_rollback: TAction;
    act_store: TAction;
    act_update: TAction;
    act_destroy: TAction;
    ds_turnos: TDataSource;
    tmr_focus: TTimer;
    fdmt_turnos: TFDMemTable;
    fdmt_turnosID: TStringField;
    fdmt_turnosNOME: TStringField;
    btn_rollback: TButton;
    btn_store: TButton;
    btn_update: TButton;
    btn_destroy: TButton;
    bvl_3: TBevel;
    pnl_search: TPanel;
    lbe_search: TLabeledEdit;
    dbg_terminais: TDBGrid;
    fdmt_turnosINICIO: TStringField;
    fdmt_turnosFIM: TStringField;
    procedure acl_turnosUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure dbg_terminaisDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure lbe_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmr_focusTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_storeExecute(Sender: TObject);
    procedure act_updateExecute(Sender: TObject);
    procedure act_destroyExecute(Sender: TObject);
  private
    { Private declarations }
    procedure list(pSearch: string);
  public
    { Public declarations }
  end;

var
  formTurnoList: TformTurnoList;

implementation

{$R *.dfm}

uses udmRepository, Turno, AuthService, uformTurnoCreateEdit;

procedure TformTurnoList.acl_turnosUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_update.Enabled:= (fdmt_turnos.RecordCount >= 1);
  act_destroy.Enabled:= (fdmt_turnos.RecordCount >= 1);
  tmr_focus.Enabled:= (not lbe_search.Focused);
end;

procedure TformTurnoList.act_destroyExecute(Sender: TObject);
begin
  if TTurno.remove(fdmt_turnosID.AsString) then
    fdmt_turnos.Delete();
end;

procedure TformTurnoList.act_rollbackExecute(Sender: TObject);
begin
  TAuthService.TurnoId:= EmptyStr;
  Close();
end;

procedure TformTurnoList.act_storeExecute(Sender: TObject);
var
  vF: TformTurnoCreateEdit;
begin
  TAuthService.TurnoId:= EmptyStr;
  try
    vF:= TformTurnoCreateEdit.Create(nil);
    vF.ShowModal();
  finally
    FreeAndNil(vF);
  end;

  if (TAuthService.TurnoId <> EmptyStr) then
    list(Trim(lbe_search.Text));
end;

procedure TformTurnoList.act_updateExecute(Sender: TObject);
var
  vF: TformTurnoCreateEdit;
begin
  TAuthService.TurnoId:= fdmt_turnosID.AsString;
  try
    vF:= TformTurnoCreateEdit.Create(nil);
    vF.ShowModal();
  finally
    FreeAndNil(vF);
  end;

  if (TAuthService.TurnoId <> EmptyStr) then
    list(Trim(lbe_search.Text));
end;

procedure TformTurnoList.dbg_terminaisDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  if (gdSelected in State) then
  begin
    TDBGrid(Sender).Canvas.Font.Style:= [fsBold];
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;
  end;

  if not Odd(TDBGrid(Sender).DataSource.DataSet.RecNo) then
  begin
    if not (gdSelected in State) then
    begin
      TDBGrid(Sender).Canvas.Brush.Color:= $00E2E2E2;
      TDBGrid(Sender).Canvas.FillRect(Rect);
      TDBGrid(Sender).DefaultDrawDataCell(Rect,Column.Field,State);
    end;
  end;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);
end;

procedure TformTurnoList.FormCreate(Sender: TObject);
begin
  inherited;
  list('');
end;

procedure TformTurnoList.lbe_searchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    13: list(Trim(lbe_search.Text));
    38: begin
      fdmt_turnos.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_turnos.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformTurnoList.list(pSearch: string);
begin
  TTurno.list(pSearch, fdmt_turnos);
end;

procedure TformTurnoList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_search.Focused then lbe_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
