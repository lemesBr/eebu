unit uformCategoriaList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Vcl.Grids, Vcl.DBGrids, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Actions, Vcl.ActnList, System.Classes;

type
  TformCategoriaList = class(TformBase)
    acl_categorias: TActionList;
    act_rollback: TAction;
    act_categoria_store_receira: TAction;
    act_categoria_update: TAction;
    act_categoria_export: TAction;
    fdmt_categorias: TFDMemTable;
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_categorias_head: TPanel;
    pnl_categorias_foooter: TPanel;
    btn_categoria_export: TButton;
    btn_categoria_store_despesa: TButton;
    btn_categoria_update: TButton;
    btn_rollback: TButton;
    pnl_categorias_body: TPanel;
    bvl_3: TBevel;
    pnl_categorias_search: TPanel;
    lbe_categorias_search: TLabeledEdit;
    dbg_categorias: TDBGrid;
    tmr_focus: TTimer;
    ds_categorias: TDataSource;
    btn_categoria_store_receita: TButton;
    act_categoria_store_despesa: TAction;
    fdmt_categoriasID: TStringField;
    fdmt_categoriasCATEGORIA_ID: TStringField;
    fdmt_categoriasNOME: TStringField;
    fdmt_categoriasTIPO: TStringField;
    btn_categoria_destroy: TButton;
    act_categoria_destroy: TAction;
    procedure FormCreate(Sender: TObject);
    procedure acl_categoriasUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure act_categoria_exportExecute(Sender: TObject);
    procedure act_rollbackExecute(Sender: TObject);
    procedure dbg_categoriasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure lbe_categorias_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmr_focusTimer(Sender: TObject);
    procedure act_categoria_store_receiraExecute(Sender: TObject);
    procedure act_categoria_updateExecute(Sender: TObject);
    procedure act_categoria_store_despesaExecute(Sender: TObject);
    procedure act_categoria_destroyExecute(Sender: TObject);
  private
    { Private declarations }
    procedure list(search: string);
  public
    { Public declarations }
  end;

var
  formCategoriaList: TformCategoriaList;

implementation

uses
  Categoria, AuthService, uformCategoriaCreateEdit, udmRepository, Helper;

{$R *.dfm}

{ TformCategoriaList }

procedure TformCategoriaList.acl_categoriasUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  act_categoria_update.Enabled:= (fdmt_categorias.RecordCount >= 1);
  act_categoria_export.Visible:= (Self.Tag = 1);
  act_categoria_export.Enabled:= (fdmt_categorias.RecordCount >= 1);
  tmr_focus.Enabled:= (not lbe_categorias_search.Focused);
end;

procedure TformCategoriaList.act_categoria_destroyExecute(Sender: TObject);
begin
  if (TCategoria.remove(fdmt_categoriasID.AsString)) then
    fdmt_categorias.Delete;
end;

procedure TformCategoriaList.act_categoria_exportExecute(Sender: TObject);
begin
  if (Self.Tag <> 1) then Exit();

  if (TAuthService.TipoCategoria <> fdmt_categoriasTIPO.AsString) then
  begin
    THelper.Mensagem('Categoria selecionada é incompatível.');
    Exit();
  end;

  TAuthService.CategoriaId:= fdmt_categoriasID.AsString;
  Close;
end;

procedure TformCategoriaList.act_categoria_store_despesaExecute(
  Sender: TObject);
var
  v_form: TformCategoriaCreateEdit;
  v_tipo_categoria_old: string;
begin
  TAuthService.CategoriaId:= EmptyStr;
  v_tipo_categoria_old:= TAuthService.TipoCategoria;

  TAuthService.TipoCategoria:= 'D';
  try
    v_form:= TformCategoriaCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  TAuthService.TipoCategoria:= v_tipo_categoria_old;
  if (TAuthService.CategoriaId <> EmptyStr) then
    list('');
end;

procedure TformCategoriaList.act_categoria_store_receiraExecute(Sender: TObject);
var
  v_form: TformCategoriaCreateEdit;
  v_tipo_categoria_old: string;
begin
  TAuthService.CategoriaId:= EmptyStr;
  v_tipo_categoria_old:= TAuthService.TipoCategoria;

  TAuthService.TipoCategoria:= 'R';
  try
    v_form:= TformCategoriaCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  TAuthService.TipoCategoria:= v_tipo_categoria_old;
  if (TAuthService.CategoriaId <> EmptyStr) then
    list('');
end;

procedure TformCategoriaList.act_categoria_updateExecute(Sender: TObject);
var
  v_form: TformCategoriaCreateEdit;
begin
  TAuthService.CategoriaId:= fdmt_categoriasID.AsString;
  try
    v_form:= TformCategoriaCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.CategoriaId <> EmptyStr) then
    list('');
end;

procedure TformCategoriaList.act_rollbackExecute(Sender: TObject);
begin
  TAuthService.CategoriaId:= EmptyStr;
  Close;
end;

procedure TformCategoriaList.dbg_categoriasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  if (fdmt_categoriasCATEGORIA_ID.AsString = EmptyStr) then
  begin
    TDBGrid(Sender).Canvas.Font.Size:= 14;
    if (fdmt_categoriasTIPO.AsString = 'D') then
      TDBGrid(Sender).Canvas.Font.Color:= clRed
    else
      TDBGrid(Sender).Canvas.Font.Color:= clGreen;
  end;

  If (gdSelected in state) then
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);
end;

procedure TformCategoriaList.FormCreate(Sender: TObject);
begin
  inherited;
  list('');
end;

procedure TformCategoriaList.lbe_categorias_searchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN: begin
      list(Trim(TCustomEdit(Sender).Text));
    end;
    38: begin
      fdmt_categorias.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_categorias.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformCategoriaList.list(search: string);
begin
  TCategoria.list(search, fdmt_categorias);
end;

procedure TformCategoriaList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_categorias_search.Focused then lbe_categorias_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
