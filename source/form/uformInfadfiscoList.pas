unit uformInfadfiscoList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TformInfadfiscoList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    btn_rollback: TButton;
    btn_infadfisco_store: TButton;
    btn_infadfisco_update: TButton;
    btn_infadfisco_destroy: TButton;
    btn_infadfisco_export: TButton;
    acl_infadfisco: TActionList;
    act_rollback: TAction;
    act_infadfisco_store: TAction;
    act_infadfisco_update: TAction;
    act_infadfisco_destroy: TAction;
    act_infadfisco_export: TAction;
    bvl_3: TBevel;
    pnl_infadfisco_search: TPanel;
    lbe_infadfisco_search: TLabeledEdit;
    dbg_infadfisco: TDBGrid;
    fdmt_infadfisco: TFDMemTable;
    fdmt_infadfiscoID: TStringField;
    fdmt_infadfiscoNOME: TStringField;
    ds_infadfisco: TDataSource;
    tmr_focus: TTimer;
    fdmt_infadfiscoINFADFISCO: TBlobField;
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_infadfisco_storeExecute(Sender: TObject);
    procedure act_infadfisco_updateExecute(Sender: TObject);
    procedure act_infadfisco_destroyExecute(Sender: TObject);
    procedure act_infadfisco_exportExecute(Sender: TObject);
    procedure tmr_focusTimer(Sender: TObject);
    procedure lbe_infadfisco_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure dbg_infadfiscoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure acl_infadfiscoUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
    procedure list(search: string);
  public
    { Public declarations }
  end;

var
  formInfadfiscoList: TformInfadfiscoList;

implementation

{$R *.dfm}

uses udmRepository, AuthService, NfeInfadfisco, uformInfadfiscoCreateEdit;

procedure TformInfadfiscoList.acl_infadfiscoUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_infadfisco_update.Enabled:= (fdmt_infadfisco.RecordCount >= 1);
  act_infadfisco_destroy.Enabled:= (fdmt_infadfisco.RecordCount >= 1);
  act_infadfisco_export.Visible:= (Self.Tag = 1);
  act_infadfisco_export.Enabled:= (fdmt_infadfisco.RecordCount >= 1);
  tmr_focus.Enabled:= (not lbe_infadfisco_search.Focused);
end;

procedure TformInfadfiscoList.act_infadfisco_destroyExecute(Sender: TObject);
begin
  if TNfeInfadfisco.remove(fdmt_infadfiscoID.AsString) then
    fdmt_infadfisco.Delete;
end;

procedure TformInfadfiscoList.act_infadfisco_exportExecute(Sender: TObject);
begin
  TAuthService.NfeInfadfiscoId:= fdmt_infadfiscoID.AsString;
  Close;
end;

procedure TformInfadfiscoList.act_infadfisco_storeExecute(Sender: TObject);
var
  v_form: TformInfadfiscoCreateEdit;
begin
  TAuthService.NfeInfadfiscoId:= EmptyStr;
  try
    v_form:= TformInfadfiscoCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.NfeInfadfiscoId <> EmptyStr) then
    list(Trim(lbe_infadfisco_search.Text));
end;

procedure TformInfadfiscoList.act_infadfisco_updateExecute(Sender: TObject);
var
  v_form: TformInfadfiscoCreateEdit;
begin
  TAuthService.NfeInfadfiscoId:= fdmt_infadfiscoID.AsString;
  try
    v_form:= TformInfadfiscoCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.NfeInfadfiscoId <> EmptyStr) then
    list(Trim(lbe_infadfisco_search.Text));
end;

procedure TformInfadfiscoList.act_rollbackExecute(Sender: TObject);
begin
  TAuthService.NfeInfcplId:= EmptyStr;
  Close;
end;

procedure TformInfadfiscoList.dbg_infadfiscoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  If (gdSelected in state) then
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);
end;

procedure TformInfadfiscoList.FormCreate(Sender: TObject);
begin
  inherited;
  list('');
end;

procedure TformInfadfiscoList.lbe_infadfisco_searchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN: begin
      if (Trim(TCustomEdit(Sender).Text) <> EmptyStr) then
        list(Trim(TCustomEdit(Sender).Text));
    end;
    38: begin
      fdmt_infadfisco.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_infadfisco.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformInfadfiscoList.list(search: string);
begin
  TNfeInfadfisco.list(search, fdmt_infadfisco);
end;

procedure TformInfadfiscoList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_infadfisco_search.Focused then lbe_infadfisco_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
