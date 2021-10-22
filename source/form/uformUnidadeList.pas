unit uformUnidadeList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Vcl.Grids, Vcl.DBGrids, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Actions, Vcl.ActnList;

type
  TformUnidadeList = class(TformBase)
    acl_unidades: TActionList;
    act_rollback: TAction;
    act_unidade_store: TAction;
    act_unidade_update: TAction;
    act_unidade_export: TAction;
    fdmt_unidades: TFDMemTable;
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_unidades_head: TPanel;
    pnl_unidades_foooter: TPanel;
    btn_unidade_export: TButton;
    btn_unidade_store: TButton;
    btn_unidade_update: TButton;
    btn_rollback: TButton;
    pnl_unidades_body: TPanel;
    bvl_3: TBevel;
    pnl_unidades_search: TPanel;
    lbe_unidades_search: TLabeledEdit;
    dbg_unidades: TDBGrid;
    tmr_focus: TTimer;
    ds_unidades: TDataSource;
    fdmt_unidadesID: TStringField;
    fdmt_unidadesNOME: TStringField;
    fdmt_unidadesUNIDADE: TStringField;
    btn_unidade_destroy: TButton;
    act_unidade_destroy: TAction;
    procedure acl_unidadesUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure tmr_focusTimer(Sender: TObject);
    procedure lbe_unidades_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbg_unidadesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure act_unidade_exportExecute(Sender: TObject);
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_unidade_storeExecute(Sender: TObject);
    procedure act_unidade_updateExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure act_unidade_destroyExecute(Sender: TObject);
  private
    { Private declarations }
    procedure list(search: string);
  public
    { Public declarations }
  end;

var
  formUnidadeList: TformUnidadeList;

implementation

uses
  Unidade, AuthService, uformUnidadeCreateEdit, udmRepository;

{$R *.dfm}

{ TformUnidadeList }

procedure TformUnidadeList.acl_unidadesUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_unidade_store.Enabled:= False;
  act_unidade_update.Enabled:= False;
  act_unidade_destroy.Enabled:= False;
  act_unidade_export.Visible:= (Self.Tag = 1);
  act_unidade_export.Enabled:= (fdmt_unidades.RecordCount >= 1);
  tmr_focus.Enabled:= (not lbe_unidades_search.Focused);
end;

procedure TformUnidadeList.act_rollbackExecute(Sender: TObject);
begin
  TAuthService.UnidadeId:= EmptyStr;
  Close;
end;

procedure TformUnidadeList.act_unidade_destroyExecute(Sender: TObject);
begin
  if TUnidade.remove(fdmt_unidadesID.AsString) then
    fdmt_unidades.Delete;
end;

procedure TformUnidadeList.act_unidade_exportExecute(Sender: TObject);
begin
  TAuthService.UnidadeId:= fdmt_unidadesID.AsString;
  Close;
end;

procedure TformUnidadeList.act_unidade_storeExecute(Sender: TObject);
var
  v_form: TformUnidadeCreateEdit;
begin
  TAuthService.UnidadeId:= EmptyStr;
  try
    v_form:= TformUnidadeCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.UnidadeId <> EmptyStr) then
    list(Trim(lbe_unidades_search.Text));
end;

procedure TformUnidadeList.act_unidade_updateExecute(Sender: TObject);
var
  v_form: TformUnidadeCreateEdit;
begin
  TAuthService.UnidadeId:= fdmt_unidadesID.AsString;
  try
    v_form:= TformUnidadeCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.UnidadeId <> EmptyStr) then
    list(Trim(lbe_unidades_search.Text));
end;

procedure TformUnidadeList.dbg_unidadesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  If (gdSelected in state) then
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);
end;

procedure TformUnidadeList.FormCreate(Sender: TObject);
begin
  inherited;
  act_unidade_store.Visible:= False;
  act_unidade_update.Visible:= False;
  act_unidade_destroy.Visible:= False;
  list('');
end;

procedure TformUnidadeList.lbe_unidades_searchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN: begin
      if (Trim(TCustomEdit(Sender).Text) <> EmptyStr) then
        list(Trim(TCustomEdit(Sender).Text));
    end;
    38: begin
      fdmt_unidades.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_unidades.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformUnidadeList.list(search: string);
begin
  TUnidade.list(search,fdmt_unidades);
end;

procedure TformUnidadeList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_unidades_search.Focused then lbe_unidades_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
