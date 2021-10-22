unit uformFormaRecebimentoList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, System.Actions, Vcl.ActnList, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TformFormaRecebimentoList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_formas_recebimentos_header: TPanel;
    pnl_formas_recebimentos_footer: TPanel;
    pnl_formas_recebimentos_body: TPanel;
    pnl_formas_recebimentos_search: TPanel;
    lbe_formas_recebimentos_search: TLabeledEdit;
    dbg_formas_recebimentos: TDBGrid;
    bvl_3: TBevel;
    btn_rollback: TButton;
    btn_forma_recebimento_store: TButton;
    btn_forma_recebimento_update: TButton;
    btn_forma_recebimento_export: TButton;
    fdmt_formas_recebimentos: TFDMemTable;
    fdmt_formas_recebimentosID: TStringField;
    ds_formas_recebimentos: TDataSource;
    tmr_focus: TTimer;
    acl_formas_recebimentos: TActionList;
    act_rollback: TAction;
    act_forma_recebimento_store: TAction;
    act_forma_recebimento_update: TAction;
    act_forma_recebimento_export: TAction;
    fdmt_formas_recebimentosTPAG: TStringField;
    fdmt_formas_recebimentosNOME: TStringField;
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_forma_recebimento_storeExecute(Sender: TObject);
    procedure act_forma_recebimento_updateExecute(Sender: TObject);
    procedure act_forma_recebimento_exportExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbg_formas_recebimentosDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure tmr_focusTimer(Sender: TObject);
    procedure acl_formas_recebimentosUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure lbe_formas_recebimentos_searchKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure list(search: string);
  public
    { Public declarations }
  end;

var
  formFormaRecebimentoList: TformFormaRecebimentoList;

implementation

uses
  FormaRecebimento, AuthService, uformFormaRecebimentoCreateEdit;

{$R *.dfm}

procedure TformFormaRecebimentoList.acl_formas_recebimentosUpdate(
  Action: TBasicAction; var Handled: Boolean);
begin
  act_forma_recebimento_store.Enabled:= True;
  act_forma_recebimento_update.Enabled:= (fdmt_formas_recebimentos.RecordCount >= 1);
  act_forma_recebimento_export.Enabled:= (fdmt_formas_recebimentos.RecordCount >= 1);
  tmr_focus.Enabled:= (not lbe_formas_recebimentos_search.Focused);
end;

procedure TformFormaRecebimentoList.act_forma_recebimento_exportExecute(
  Sender: TObject);
begin
  TAuthService.FormaRecebimentoId:= fdmt_formas_recebimentosID.AsString;
  Close;
end;

procedure TformFormaRecebimentoList.act_forma_recebimento_storeExecute(
  Sender: TObject);
begin
  TAuthService.FormaRecebimentoId:= EmptyStr;
  try
    formFormaRecebimentoCreateEdit:= TformFormaRecebimentoCreateEdit.Create(nil);
    formFormaRecebimentoCreateEdit.ShowModal;
  finally
    FreeAndNil(formFormaRecebimentoCreateEdit);
  end;

  if (TAuthService.FormaRecebimentoId <> EmptyStr) then
    list(Trim(lbe_formas_recebimentos_search.Text));
end;

procedure TformFormaRecebimentoList.act_forma_recebimento_updateExecute(
  Sender: TObject);
begin
  TAuthService.FormaRecebimentoId:= fdmt_formas_recebimentosID.AsString;
  try
    formFormaRecebimentoCreateEdit:= TformFormaRecebimentoCreateEdit.Create(nil);
    formFormaRecebimentoCreateEdit.ShowModal;
  finally
    FreeAndNil(formFormaRecebimentoCreateEdit);
  end;

  if (TAuthService.FormaRecebimentoId <> EmptyStr) then
    list(Trim(lbe_formas_recebimentos_search.Text));
end;

procedure TformFormaRecebimentoList.act_rollbackExecute(Sender: TObject);
begin
  TAuthService.FormaRecebimentoId:= EmptyStr;
  Close;
end;

procedure TformFormaRecebimentoList.dbg_formas_recebimentosDrawColumnCell(
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

procedure TformFormaRecebimentoList.FormCreate(Sender: TObject);
begin
  inherited;
  list('');
end;

procedure TformFormaRecebimentoList.lbe_formas_recebimentos_searchKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    13: begin
      if (Trim(TCustomEdit(Sender).Text) <> EmptyStr) then
        list(Trim(TCustomEdit(Sender).Text));
    end;
    38: begin
      fdmt_formas_recebimentos.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_formas_recebimentos.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformFormaRecebimentoList.list(search: string);
begin
  TFormaRecebimento.list(search, fdmt_formas_recebimentos);
end;

procedure TformFormaRecebimentoList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_formas_recebimentos_search.Focused then lbe_formas_recebimentos_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
