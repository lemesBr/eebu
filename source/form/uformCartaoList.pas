unit uformCartaoList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Actions,
  Vcl.ActnList, Vcl.Grids, Vcl.DBGrids;

type
  TformCartaoList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    pnl_search: TPanel;
    lbe_search: TLabeledEdit;
    bvl_3: TBevel;
    dbg_cartoes: TDBGrid;
    btn_rollback: TButton;
    btn_store: TButton;
    btn_update: TButton;
    btn_destroy: TButton;
    btn_export: TButton;
    acl_cartoes: TActionList;
    act_rollback: TAction;
    act_store: TAction;
    act_update: TAction;
    act_destroy: TAction;
    act_export: TAction;
    fdmt_cartoes: TFDMemTable;
    ds_cartoes: TDataSource;
    tmr_focus: TTimer;
    fdmt_cartoesID: TStringField;
    fdmt_cartoesNOME: TStringField;
    fdmt_cartoesCOMPENSA_CREDITO: TIntegerField;
    fdmt_cartoesTAXA_CREDITO: TFloatField;
    fdmt_cartoesCOMPENSA_DEBITO: TIntegerField;
    fdmt_cartoesTAXA_DEBITO: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_storeExecute(Sender: TObject);
    procedure act_updateExecute(Sender: TObject);
    procedure act_destroyExecute(Sender: TObject);
    procedure act_exportExecute(Sender: TObject);
    procedure tmr_focusTimer(Sender: TObject);
    procedure lbe_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure acl_cartoesUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure dbg_cartoesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    procedure list(search: string);
  public
    { Public declarations }
  end;

var
  formCartaoList: TformCartaoList;

implementation

uses
  Cartao, AuthService, udmRepository, uformCartaoCreateEdit;

{$R *.dfm}

{ TformCartaoList }

procedure TformCartaoList.acl_cartoesUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_update.Enabled:= (fdmt_cartoes.RecordCount >= 1);
  act_destroy.Enabled:= (fdmt_cartoes.RecordCount >= 1);
  act_export.Visible:= (Self.Tag = 1);
  act_export.Enabled:= (fdmt_cartoes.RecordCount >= 1) and (Self.Tag = 1);
  tmr_focus.Enabled:= (not lbe_search.Focused);
end;

procedure TformCartaoList.act_destroyExecute(Sender: TObject);
begin
  if TCartao.remove(fdmt_cartoesID.AsString) then
    fdmt_cartoes.Delete();
end;

procedure TformCartaoList.act_exportExecute(Sender: TObject);
begin
  if not (Self.Tag = 1) then Exit();

  TAuthService.CartaoId:= fdmt_cartoesID.AsString;
  Close;
end;

procedure TformCartaoList.act_rollbackExecute(Sender: TObject);
begin
  TAuthService.CartaoId:= EmptyStr;
  Close();
end;

procedure TformCartaoList.act_storeExecute(Sender: TObject);
var
  v_form: TformCartaoCreateEdit;
begin
  TAuthService.CartaoId:= EmptyStr;
  try
    v_form:= TformCartaoCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.CartaoId <> EmptyStr) then
    list(Trim(lbe_search.Text));
end;

procedure TformCartaoList.act_updateExecute(Sender: TObject);
var
  v_form: TformCartaoCreateEdit;
begin
  TAuthService.CartaoId:= fdmt_cartoesID.AsString;
  try
    v_form:= TformCartaoCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.CartaoId <> EmptyStr) then
    list(Trim(lbe_search.Text));
end;

procedure TformCartaoList.dbg_cartoesDrawColumnCell(Sender: TObject;
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

procedure TformCartaoList.FormCreate(Sender: TObject);
begin
  inherited;
  dbg_cartoes.OnDblClick:= act_exportExecute;
  list('');
end;

procedure TformCartaoList.lbe_searchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    13: list(Trim(TCustomEdit(Sender).Text));
    38: begin
      fdmt_cartoes.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_cartoes.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformCartaoList.list(search: string);
begin
  TCartao.list(search,fdmt_cartoes);
end;

procedure TformCartaoList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_search.Focused then lbe_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
