unit uformTerminalList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, System.Actions, Vcl.ActnList, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TformTerminalList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    pnl_search: TPanel;
    lbe_search: TLabeledEdit;
    bvl_3: TBevel;
    dbg_terminais: TDBGrid;
    btn_rollback: TButton;
    btn_store: TButton;
    btn_update: TButton;
    btn_destroy: TButton;
    fdmt_terminais: TFDMemTable;
    fdmt_terminaisID: TStringField;
    ds_terminais: TDataSource;
    tmr_focus: TTimer;
    acl_terminais: TActionList;
    act_rollback: TAction;
    act_store: TAction;
    act_update: TAction;
    act_destroy: TAction;
    fdmt_terminaisAUTHENTICATION: TStringField;
    fdmt_terminaisNOME: TStringField;
    procedure dbg_terminaisDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure acl_terminaisUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_storeExecute(Sender: TObject);
    procedure act_updateExecute(Sender: TObject);
    procedure act_destroyExecute(Sender: TObject);
    procedure lbe_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmr_focusTimer(Sender: TObject);
  private
    { Private declarations }
    procedure list(search: string);
  public
    { Public declarations }
  end;

var
  formTerminalList: TformTerminalList;

implementation

{$R *.dfm}

uses udmRepository, Terminal, uformTerminalCreateEdit, AuthService;

procedure TformTerminalList.acl_terminaisUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_update.Enabled:= (fdmt_terminais.RecordCount >= 1);
  act_destroy.Enabled:= (fdmt_terminais.RecordCount >= 1);
  tmr_focus.Enabled:= (not lbe_search.Focused);
end;

procedure TformTerminalList.act_destroyExecute(Sender: TObject);
begin
  if TTerminal.remove(fdmt_terminaisID.AsString) then
    fdmt_terminais.Delete();
end;

procedure TformTerminalList.act_rollbackExecute(Sender: TObject);
begin
  Close();
end;

procedure TformTerminalList.act_storeExecute(Sender: TObject);
var
  vF: TformTerminalCreateEdit;
begin
  TAuthService.TerminalId:= EmptyStr;
  try
    vF:= TformTerminalCreateEdit.Create(nil);
    vF.ShowModal();
  finally
    FreeAndNil(vF);
  end;

  if (TAuthService.TerminalId <> EmptyStr) then
    list(Trim(lbe_search.Text));
end;

procedure TformTerminalList.act_updateExecute(Sender: TObject);
var
  vF: TformTerminalCreateEdit;
begin
  TAuthService.TerminalId:= fdmt_terminaisID.AsString;
  try
    vF:= TformTerminalCreateEdit.Create(nil);
    vF.ShowModal();
  finally
    FreeAndNil(vF);
  end;

  if (TAuthService.TerminalId <> EmptyStr) then
    list(Trim(lbe_search.Text));
end;

procedure TformTerminalList.dbg_terminaisDrawColumnCell(Sender: TObject;
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

procedure TformTerminalList.FormCreate(Sender: TObject);
begin
  inherited;
  list('');
end;

procedure TformTerminalList.lbe_searchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    13: list(Trim(lbe_search.Text));
    38: begin
      fdmt_terminais.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_terminais.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformTerminalList.list(search: string);
var
  vReferencia: Integer;
begin
  vReferencia:= StrToIntDef(search, 0);
  TTerminal.list(vReferencia, fdmt_terminais);
end;

procedure TformTerminalList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_search.Focused then lbe_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
