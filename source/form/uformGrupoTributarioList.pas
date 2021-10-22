unit uformGrupoTributarioList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, System.Actions, Vcl.ActnList, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TformGrupoTributarioList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_grupos_tributarios_header: TPanel;
    pnl_grupos_tributarios_footer: TPanel;
    pnl_grupos_tributarios_body: TPanel;
    bvl_3: TBevel;
    dbg_grupos_tributarios: TDBGrid;
    pnl_grupos_tributarios_search: TPanel;
    lbe_grupos_tributarios_search: TLabeledEdit;
    btn_rollback: TButton;
    btn_grupo_tributario_store: TButton;
    btn_grupo_tributario_update: TButton;
    btn_grupo_tributario_export: TButton;
    fdmt_grupos_tributarios: TFDMemTable;
    fdmt_grupos_tributariosID: TStringField;
    ds_grupos_tributarios: TDataSource;
    tmr_focus: TTimer;
    acl_grupos_tributarios: TActionList;
    act_rollback: TAction;
    act_grupo_tributario_store: TAction;
    act_grupo_tributario_update: TAction;
    act_grupo_tributario_export: TAction;
    fdmt_grupos_tributariosNOME: TStringField;
    act_grupo_tributario_destroy: TAction;
    btn_grupo_tributario_destroy: TButton;
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_grupo_tributario_storeExecute(Sender: TObject);
    procedure act_grupo_tributario_updateExecute(Sender: TObject);
    procedure act_grupo_tributario_exportExecute(Sender: TObject);
    procedure acl_grupos_tributariosUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure tmr_focusTimer(Sender: TObject);
    procedure lbe_grupos_tributarios_searchKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure dbg_grupos_tributariosDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure act_grupo_tributario_destroyExecute(Sender: TObject);
  private
    { Private declarations }
    procedure list(search: string);
  public
    { Public declarations }
  end;

var
  formGrupoTributarioList: TformGrupoTributarioList;

implementation

uses
  AuthService, GrupoTributario, uformGrupoTributarioCreateEdit, udmRepository;

{$R *.dfm}

procedure TformGrupoTributarioList.acl_grupos_tributariosUpdate(
  Action: TBasicAction; var Handled: Boolean);
begin
  act_grupo_tributario_update.Enabled:= (fdmt_grupos_tributarios.RecordCount >= 1);
  act_grupo_tributario_destroy.Enabled:= (fdmt_grupos_tributarios.RecordCount >= 1);
  act_grupo_tributario_export.Visible:= (Self.Tag = 1);
  act_grupo_tributario_export.Enabled:= (Self.Tag = 1) and (fdmt_grupos_tributarios.RecordCount >= 1);
  tmr_focus.Enabled:= (not lbe_grupos_tributarios_search.Focused);
end;

procedure TformGrupoTributarioList.act_grupo_tributario_destroyExecute(
  Sender: TObject);
begin
  if TGrupoTributario.remove(fdmt_grupos_tributariosID.AsString) then
    fdmt_grupos_tributarios.Delete;
end;

procedure TformGrupoTributarioList.act_grupo_tributario_exportExecute(
  Sender: TObject);
begin
  if not (Self.Tag = 1) then Exit();

  TAuthService.GrupoTributarioId:= fdmt_grupos_tributariosID.AsString;
  Close;
end;

procedure TformGrupoTributarioList.act_grupo_tributario_storeExecute(
  Sender: TObject);
var
  v_form: TformGrupoTributarioCreateEdit;
begin
  TAuthService.GrupoTributarioId:= EmptyStr;
  try
    v_form:= TformGrupoTributarioCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.GrupoTributarioId <> EmptyStr) then
    list(Trim(lbe_grupos_tributarios_search.Text));
end;

procedure TformGrupoTributarioList.act_grupo_tributario_updateExecute(
  Sender: TObject);
var
  v_form: TformGrupoTributarioCreateEdit;
begin
  TAuthService.GrupoTributarioId:= fdmt_grupos_tributariosID.AsString;
  try
    v_form:= TformGrupoTributarioCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.GrupoTributarioId <> EmptyStr) then
    list(Trim(lbe_grupos_tributarios_search.Text));
end;

procedure TformGrupoTributarioList.act_rollbackExecute(Sender: TObject);
begin
  TAuthService.GrupoTributarioId:= EmptyStr;
  Close;
end;

procedure TformGrupoTributarioList.dbg_grupos_tributariosDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  If (gdSelected in state) then
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);
end;

procedure TformGrupoTributarioList.FormCreate(Sender: TObject);
begin
  inherited;
  dbg_grupos_tributarios.OnDblClick:= act_grupo_tributario_exportExecute;
  list('');
end;

procedure TformGrupoTributarioList.lbe_grupos_tributarios_searchKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN: begin
      if (Trim(TCustomEdit(Sender).Text) <> EmptyStr) then
        list(Trim(TCustomEdit(Sender).Text));
    end;
    38: begin
      fdmt_grupos_tributarios.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_grupos_tributarios.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformGrupoTributarioList.list(search: string);
begin
  TGrupoTributario.list(search, fdmt_grupos_tributarios);
end;

procedure TformGrupoTributarioList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_grupos_tributarios_search.Focused then lbe_grupos_tributarios_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
