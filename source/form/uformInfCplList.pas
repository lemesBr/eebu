unit uformInfCplList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, System.Actions, Vcl.ActnList, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TformInfCplList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_infcpl_export: TButton;
    pnl_body: TPanel;
    btn_infcpl_destroy: TButton;
    bvl_3: TBevel;
    pnl_infcpl_search: TPanel;
    lbe_infcpl_search: TLabeledEdit;
    dbg_infcpl: TDBGrid;
    tmr_focus: TTimer;
    ds_infcpl: TDataSource;
    fdmt_infcpl: TFDMemTable;
    acl_infcpl: TActionList;
    act_rollback: TAction;
    act_infcpl_store: TAction;
    act_infcpl_update: TAction;
    act_infcpl_destroy: TAction;
    act_infcpl_export: TAction;
    btn_rollback: TButton;
    btn_infcpl_store: TButton;
    btn_infcpl_update: TButton;
    fdmt_infcplID: TStringField;
    fdmt_infcplNOME: TStringField;
    fdmt_infcplINFCPL: TBlobField;
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_infcpl_storeExecute(Sender: TObject);
    procedure act_infcpl_updateExecute(Sender: TObject);
    procedure act_infcpl_destroyExecute(Sender: TObject);
    procedure act_infcpl_exportExecute(Sender: TObject);
    procedure tmr_focusTimer(Sender: TObject);
    procedure lbe_infcpl_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure dbg_infcplDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure acl_infcplUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
    procedure list(search: string);
  public
    { Public declarations }
  end;

var
  formInfCplList: TformInfCplList;

implementation

{$R *.dfm}

uses udmRepository, NfeInfcpl, AuthService, uformInfCplCreateEdit;

procedure TformInfCplList.acl_infcplUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_infcpl_update.Enabled:= (fdmt_infcpl.RecordCount >= 1);
  act_infcpl_destroy.Enabled:= (fdmt_infcpl.RecordCount >= 1);
  act_infcpl_export.Visible:= (Self.Tag = 1);
  act_infcpl_export.Enabled:= (fdmt_infcpl.RecordCount >= 1);
  tmr_focus.Enabled:= (not lbe_infcpl_search.Focused);
end;

procedure TformInfCplList.act_infcpl_destroyExecute(Sender: TObject);
begin
  if TNfeInfcpl.remove(fdmt_infcplID.AsString) then
    fdmt_infcpl.Delete;
end;

procedure TformInfCplList.act_infcpl_exportExecute(Sender: TObject);
begin
  TAuthService.NfeInfcplId:= fdmt_infcplID.AsString;
  Close;
end;

procedure TformInfCplList.act_infcpl_storeExecute(Sender: TObject);
var
  v_form: TformInfCplCreateEdit;
begin
  TAuthService.NfeInfcplId:= EmptyStr;
  try
    v_form:= TformInfCplCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.NfeInfcplId <> EmptyStr) then
    list(Trim(lbe_infcpl_search.Text));
end;

procedure TformInfCplList.act_infcpl_updateExecute(Sender: TObject);
var
  v_form: TformInfCplCreateEdit;
begin
  TAuthService.NfeInfcplId:= fdmt_infcplID.AsString;
  try
    v_form:= TformInfCplCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.NfeInfcplId <> EmptyStr) then
    list(Trim(lbe_infcpl_search.Text));
end;

procedure TformInfCplList.act_rollbackExecute(Sender: TObject);
begin
  TAuthService.NfeInfcplId:= EmptyStr;
  Close;
end;

procedure TformInfCplList.dbg_infcplDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  If (gdSelected in state) then
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);
end;

procedure TformInfCplList.FormCreate(Sender: TObject);
begin
  inherited;
  list('');
end;

procedure TformInfCplList.lbe_infcpl_searchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN: begin
      if (Trim(TCustomEdit(Sender).Text) <> EmptyStr) then
        list(Trim(TCustomEdit(Sender).Text));
    end;
    38: begin
      fdmt_infcpl.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_infcpl.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformInfCplList.list(search: string);
begin
  TNfeInfcpl.list(search, fdmt_infcpl);
end;

procedure TformInfCplList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_infcpl_search.Focused then lbe_infcpl_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
