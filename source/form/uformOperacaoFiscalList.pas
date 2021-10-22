unit uformOperacaoFiscalList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, System.Actions, Vcl.ActnList, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TformOperacaoFiscalList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_operacoes_fiscais_header: TPanel;
    pnl_operacoes_fiscais_footer: TPanel;
    pnl_operacoes_fiscais_body: TPanel;
    btn_rollback: TButton;
    btn_operacao_fiscal_store: TButton;
    btn_operacao_fiscal_export: TButton;
    btn_operacao_fiscal_update: TButton;
    bvl_3: TBevel;
    dbg_operacoes_fiscais: TDBGrid;
    pnl_operacoes_fiscais_search: TPanel;
    lbe_operacoes_fiscais_search: TLabeledEdit;
    fdmt_operacoes_fiscais: TFDMemTable;
    fdmt_operacoes_fiscaisID: TStringField;
    ds_operacoes_fiscais: TDataSource;
    tmr_focus: TTimer;
    acl_operacoes_fiscais: TActionList;
    act_rollback: TAction;
    act_operacao_fiscal_store: TAction;
    act_operacao_fiscal_update: TAction;
    act_operacao_fiscal_export: TAction;
    fdmt_operacoes_fiscaisNOME: TStringField;
    act_operacao_fiscal_destroy: TAction;
    btn_operacao_fiscal_destroy: TButton;
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_operacao_fiscal_storeExecute(Sender: TObject);
    procedure act_operacao_fiscal_updateExecute(Sender: TObject);
    procedure act_operacao_fiscal_exportExecute(Sender: TObject);
    procedure acl_operacoes_fiscaisUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure tmr_focusTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbe_operacoes_fiscais_searchKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure dbg_operacoes_fiscaisDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure act_operacao_fiscal_destroyExecute(Sender: TObject);
  private
    { Private declarations }
    procedure list(search: string);
  public
    { Public declarations }
  end;

var
  formOperacaoFiscalList: TformOperacaoFiscalList;

implementation

uses
  AuthService, OperacaoFiscal, uformOperacaoFiscalCreateEdit, udmRepository;

{$R *.dfm}

procedure TformOperacaoFiscalList.acl_operacoes_fiscaisUpdate(
  Action: TBasicAction; var Handled: Boolean);
begin
  act_operacao_fiscal_update.Enabled:= (fdmt_operacoes_fiscais.RecordCount >= 1);
  act_operacao_fiscal_destroy.Enabled:= (fdmt_operacoes_fiscais.RecordCount >= 1);
  act_operacao_fiscal_export.Visible:= (Self.Tag = 1);
  act_operacao_fiscal_export.Enabled:= (Self.Tag = 1) and (fdmt_operacoes_fiscais.RecordCount >= 1);
  tmr_focus.Enabled:= (not lbe_operacoes_fiscais_search.Focused);
end;

procedure TformOperacaoFiscalList.act_operacao_fiscal_destroyExecute(
  Sender: TObject);
begin
  if TOperacaoFiscal.remove(fdmt_operacoes_fiscaisID.AsString) then
    fdmt_operacoes_fiscais.Delete;
end;

procedure TformOperacaoFiscalList.act_operacao_fiscal_exportExecute(
  Sender: TObject);
begin
  if not (Self.Tag = 1) then  Exit();

  TAuthService.OperacaoFiscalId:= fdmt_operacoes_fiscaisID.AsString;
  Close;
end;

procedure TformOperacaoFiscalList.act_operacao_fiscal_storeExecute(
  Sender: TObject);
var
  v_form: TformOperacaoFiscalCreateEdit;
begin
  TAuthService.OperacaoFiscalId:= EmptyStr;
  try
    v_form:= TformOperacaoFiscalCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.OperacaoFiscalId <> EmptyStr) then
    list(Trim(lbe_operacoes_fiscais_search.Text));
end;

procedure TformOperacaoFiscalList.act_operacao_fiscal_updateExecute(
  Sender: TObject);
var
  v_form: TformOperacaoFiscalCreateEdit;
begin
  TAuthService.OperacaoFiscalId:= fdmt_operacoes_fiscaisID.AsString;
  try
    v_form:= TformOperacaoFiscalCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.OperacaoFiscalId <> EmptyStr) then
    list(Trim(lbe_operacoes_fiscais_search.Text));
end;

procedure TformOperacaoFiscalList.act_rollbackExecute(Sender: TObject);
begin
  TAuthService.OperacaoFiscalId:= EmptyStr;
  Close;
end;

procedure TformOperacaoFiscalList.dbg_operacoes_fiscaisDrawColumnCell(
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

procedure TformOperacaoFiscalList.FormCreate(Sender: TObject);
begin
  inherited;
  dbg_operacoes_fiscais.OnDblClick:= act_operacao_fiscal_exportExecute;
  list('');
end;

procedure TformOperacaoFiscalList.lbe_operacoes_fiscais_searchKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN: begin
      if (Trim(TCustomEdit(Sender).Text) <> EmptyStr) then
        list(Trim(TCustomEdit(Sender).Text));
    end;
    38: begin
      fdmt_operacoes_fiscais.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_operacoes_fiscais.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformOperacaoFiscalList.list(search: string);
begin
  TOperacaoFiscal.list(search,fdmt_operacoes_fiscais);
end;

procedure TformOperacaoFiscalList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_operacoes_fiscais_search.Focused then lbe_operacoes_fiscais_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
