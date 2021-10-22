unit uformNfeNumeroList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, System.Actions, Vcl.ActnList, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TformNfeNumeroList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    pnl_search: TPanel;
    lbe_search: TLabeledEdit;
    dbg_nfe_numero: TDBGrid;
    bvl_3: TBevel;
    btn_rollback: TButton;
    btn_store: TButton;
    btn_update: TButton;
    acl_nfe_numero: TActionList;
    act_rollback: TAction;
    act_store: TAction;
    act_update: TAction;
    fdmt_nfe_numero: TFDMemTable;
    fdmt_nfe_numeroID: TStringField;
    ds_nfe_numero: TDataSource;
    fdmt_nfe_numeroMODELO: TIntegerField;
    fdmt_nfe_numeroSERIE: TIntegerField;
    fdmt_nfe_numeroNUMERO: TIntegerField;
    tmr_focus: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_storeExecute(Sender: TObject);
    procedure act_updateExecute(Sender: TObject);
    procedure lbe_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmr_focusTimer(Sender: TObject);
    procedure acl_nfe_numeroUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure dbg_nfe_numeroDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    procedure list(pSearch: string);
  public
    { Public declarations }
  end;

var
  formNfeNumeroList: TformNfeNumeroList;

implementation

{$R *.dfm}

uses udmRepository, NfeNumero, uformNfeNumeroCreateEdit, AuthService;

{ TformNfeNumeroList }

procedure TformNfeNumeroList.acl_nfe_numeroUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_update.Enabled:= (fdmt_nfe_numero.RecordCount >= 1);
  tmr_focus.Enabled:= (not lbe_search.Focused);
end;

procedure TformNfeNumeroList.act_rollbackExecute(Sender: TObject);
begin
  Close();
end;

procedure TformNfeNumeroList.act_storeExecute(Sender: TObject);
var
  v_form: TformNfeNumeroCreateEdit;
begin
  TAuthService.NfeNumeroId:= EmptyStr;
  try
    v_form:= TformNfeNumeroCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.NfeNumeroId <> EmptyStr) then
    list(Trim(lbe_search.Text));
end;

procedure TformNfeNumeroList.act_updateExecute(Sender: TObject);
var
  v_form: TformNfeNumeroCreateEdit;
begin
  TAuthService.NfeNumeroId:= fdmt_nfe_numeroID.AsString;
  try
    v_form:= TformNfeNumeroCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.NfeNumeroId <> EmptyStr) then
    list(Trim(lbe_search.Text));
end;

procedure TformNfeNumeroList.dbg_nfe_numeroDrawColumnCell(Sender: TObject;
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

procedure TformNfeNumeroList.FormCreate(Sender: TObject);
begin
  inherited;
  list('0');
end;

procedure TformNfeNumeroList.lbe_searchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    13: list(Trim(TCustomEdit(Sender).Text));
    38: begin
      fdmt_nfe_numero.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_nfe_numero.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformNfeNumeroList.list(pSearch: string);
begin
  TNfeNumero.list(StrToIntDef(pSearch, 0), fdmt_nfe_numero);
end;

procedure TformNfeNumeroList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_search.Focused then lbe_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
