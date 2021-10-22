unit uformContaList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Actions, Vcl.ActnList, Vcl.Tabs, Vcl.Mask, ACBrBase, ACBrBoleto,
  Cedente, System.Math, Conta, Vcl.Buttons, Vcl.FileCtrl, BoletoConfiguracao,
  System.StrUtils, Vcl.Menus, System.DateUtils;

type
  TformContaList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    pnl_header: TPanel;
    fdmt_contas: TFDMemTable;
    ds_contas: TDataSource;
    tmr_focus: TTimer;
    acl_contas: TActionList;
    act_rollback: TAction;
    act_conta_store: TAction;
    act_conta_update: TAction;
    act_conta_export: TAction;
    fdmt_contasID: TStringField;
    fdmt_contasNOME: TStringField;
    act_conta_destroy: TAction;
    pnl_body: TPanel;
    bvl_2: TBevel;
    dbg_contas: TDBGrid;
    pnl_footer: TPanel;
    btn_conta_export: TButton;
    btn_rollback: TButton;
    btn_conta_store: TButton;
    btn_conta_update: TButton;
    btn_conta_destroy: TButton;
    btn_boleto: TButton;
    act_cedente: TAction;
    ppm_boleto: TPopupMenu;
    CEDENTE1: TMenuItem;
    act_boleto: TAction;
    BOLETO: TMenuItem;
    fdmt_contasSALDO: TFloatField;
    pnl_contas: TPanel;
    pnl_contas_totais: TPanel;
    bvl_4: TBevel;
    pnl_extrato: TPanel;
    dbg_extrato: TDBGrid;
    pnl_search_extrato: TPanel;
    dtp_end: TDateTimePicker;
    dtp_start: TDateTimePicker;
    fdmt_extrato: TFDMemTable;
    StringField1: TStringField;
    ds_extrato: TDataSource;
    fdmt_extratoDATA: TDateField;
    fdmt_extratoCATEGORIA: TStringField;
    fdmt_extratoPESSOA: TStringField;
    fdmt_extratoREFERENTE: TStringField;
    fdmt_extratoVALOR: TFloatField;
    fdmt_extratoTIPO: TStringField;
    fdmt_extratoDATA_VIEW: TStringField;
    fdmt_extratoVALOR_VIEW: TStringField;
    fdmt_extratoSALDO: TStringField;
    btn_extrato: TButton;
    pnl_totais_right: TPanel;
    lb_saldo_total: TLabel;
    pnl_totais_left: TPanel;
    lb_total: TLabel;
    lb_start: TLabel;
    lb_end: TLabel;
    bvl_5: TBevel;
    act_imprimir_extrato: TAction;
    IMPRIMIREXTRATO1: TMenuItem;
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_conta_storeExecute(Sender: TObject);
    procedure act_conta_updateExecute(Sender: TObject);
    procedure act_conta_exportExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbg_contasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure lbe_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure acl_contasUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure act_conta_destroyExecute(Sender: TObject);
    procedure dbg_contasDblClick(Sender: TObject);
    procedure act_cedenteExecute(Sender: TObject);
    procedure act_boletoExecute(Sender: TObject);
    procedure fdmt_contasAfterScroll(DataSet: TDataSet);
    procedure dbg_extratoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btn_extratoClick(Sender: TObject);
    procedure act_imprimir_extratoExecute(Sender: TObject);
  private
    { Private declarations }
    procedure list(search: string);
  public
    { Public declarations }
  end;

var
  formContaList: TformContaList;

implementation

uses
  AuthService, uformContaCreateEdit, udmRepository, Helper, CustomEditHelper,
  uformCedenteCreateEdit, uformBoletoCreateEdit, ViewContaExtrato;

{$R *.dfm}

procedure TformContaList.acl_contasUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_conta_update.Enabled:= (fdmt_contas.RecordCount >= 1);
  act_conta_destroy.Enabled:= (fdmt_contas.RecordCount >= 1);
  act_conta_export.Visible:= (Self.Tag = 1);
  act_conta_export.Enabled:= (Self.Tag = 1) and (fdmt_contas.RecordCount >= 1);
  act_cedente.Enabled:= (Self.Tag = 0) and (fdmt_contas.RecordCount >= 1);
  act_boleto.Enabled:= (Self.Tag = 0) and (fdmt_contas.RecordCount >= 1);
  btn_boleto.Visible:= (Self.Tag = 0);
end;

procedure TformContaList.act_boletoExecute(Sender: TObject);
var
  v_form: TformBoletoCreateEdit;
begin
  TAuthService.ContaId:= fdmt_contasID.AsString;
  try
    v_form:= TformBoletoCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;
end;

procedure TformContaList.act_cedenteExecute(Sender: TObject);
var
  v_form: TformCedenteCreateEdit;
begin
  TAuthService.ContaId:= fdmt_contasID.AsString;
  try
    v_form:= TformCedenteCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;
end;

procedure TformContaList.act_conta_destroyExecute(Sender: TObject);
begin
  if (TConta.remove(fdmt_contasID.AsString)) then
    fdmt_contas.Delete;
end;

procedure TformContaList.act_conta_exportExecute(Sender: TObject);
begin
  TAuthService.ContaId:= fdmt_contasID.AsString;
  Close;
end;

procedure TformContaList.act_conta_storeExecute(Sender: TObject);
var
  v_form: TformContaCreateEdit;
begin
  TAuthService.ContaId:= EmptyStr;
  try
    v_form:= TformContaCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.ContaId <> EmptyStr) then
    list('');
end;

procedure TformContaList.act_conta_updateExecute(Sender: TObject);
var
  v_form: TformContaCreateEdit;
begin
  TAuthService.ContaId:= fdmt_contasID.AsString;
  try
    v_form:= TformContaCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.ContaId <> EmptyStr) then
    list('');
end;

procedure TformContaList.act_imprimir_extratoExecute(Sender: TObject);
begin
  try
    TConta.imprimirExtrato(fdmt_contasID.AsString,
                           dtp_start.Date,
                           dtp_end.Date,
                           fdmt_extrato);
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformContaList.act_rollbackExecute(Sender: TObject);
begin
  TAuthService.ContaId:= EmptyStr;
  Close;
end;

procedure TformContaList.btn_extratoClick(Sender: TObject);
begin
  fdmt_contasAfterScroll(fdmt_contas);
  dbg_extrato.SetFocus();
end;

procedure TformContaList.dbg_contasDblClick(Sender: TObject);
begin
  if not (Self.Tag = 1) then Exit();

  act_conta_exportExecute(Sender);
end;

procedure TformContaList.dbg_contasDrawColumnCell(Sender: TObject;
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

procedure TformContaList.dbg_extratoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  if (gdSelected in State) then
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);

  if (TDBGrid(Sender).DataSource.DataSet.RecordCount >= 1) then
  begin
    if (Column.Field.FieldName = 'VALOR_VIEW') then
    begin
      if (TDBGrid(Sender).DataSource.DataSet.FieldByName('TIPO').AsString = 'E') then
      begin
        TDBGrid(Sender).Canvas.Font.Color:= clGreen;
        TDBGrid(Sender).Canvas.FillRect(Rect);
        TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
      end
      else if (TDBGrid(Sender).DataSource.DataSet.FieldByName('TIPO').AsString = 'S') then
      begin
        TDBGrid(Sender).Canvas.Font.Color:= clRed;
        TDBGrid(Sender).Canvas.FillRect(Rect);
        TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
      end;
    end
    else if (Column.Field.FieldName = 'SALDO') and (Column.Field.AsString <> EmptyStr) then
    begin
      TDBGrid(Sender).Canvas.Font.Style:= [fsBold];
      TDBGrid(Sender).Canvas.FillRect(Rect);
      TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
  end;
end;

procedure TformContaList.fdmt_contasAfterScroll(DataSet: TDataSet);
var
  vDataSaldoAnterior: TDate;
  vSaldoAnterior,
  vSaldo, vSaldoOld: Extended;
  vDt: string;
begin
  if (fdmt_contasID.AsString <> EmptyStr) then
  begin
    TViewContaExtrato.listExtrato(fdmt_contasID.AsString,dtp_start.Date, dtp_end.Date, fdmt_extrato);

    vDataSaldoAnterior:= IncDay(dtp_start.Date, -1);
    vSaldoAnterior:= TConta.saldoAnterior(fdmt_contasID.AsString, vDataSaldoAnterior);

    vSaldo:= vSaldoAnterior;
    vSaldoOld:= vSaldo;

    fdmt_extrato.DisableControls();
    fdmt_extrato.First();
    vDt:= '';
    while not fdmt_extrato.Eof do
    begin
      if (fdmt_extratoTIPO.AsString = 'E') then
        vSaldo:= (vSaldo + fdmt_extratoVALOR.AsExtended)
      else
        vSaldo:= (vSaldo - fdmt_extratoVALOR.AsExtended);

      fdmt_extrato.Edit();
      if (fdmt_extratoTIPO.AsString = 'E') then
        fdmt_extratoVALOR_VIEW.AsString:=
          THelper.ExtendedToString(fdmt_extratoVALOR.AsExtended)
      else
        fdmt_extratoVALOR_VIEW.AsString:=
          THelper.ExtendedToString(fdmt_extratoVALOR.AsExtended * -1);
      fdmt_extrato.Post();

      if not (vDt = FormatDateTime('ddmmyyyy',fdmt_extratoDATA.AsDateTime)) then
      begin
        if (vDt <> '') then
        begin
          fdmt_extrato.Prior();

          fdmt_extrato.Edit();
          fdmt_extratoSALDO.AsString:= THelper.ExtendedToString(vSaldoOld);
          fdmt_extrato.Post();

          fdmt_extrato.Next();
        end;

        fdmt_extrato.Edit();
        fdmt_extratoDATA_VIEW.AsString:= FormatDateTime('dd/mm/yy',fdmt_extratoDATA.AsDateTime);
        fdmt_extrato.Post();

        vDt:= FormatDateTime('ddmmyyyy',fdmt_extratoDATA.AsDateTime);
      end;

      vSaldoOld:= vSaldo;

      fdmt_extrato.Next();
    end;

    if (fdmt_extrato.RecordCount >= 1) then
    begin
      fdmt_extrato.Edit();
      fdmt_extratoSALDO.AsString:= THelper.ExtendedToString(vSaldo);
      fdmt_extrato.Post();
    end;

    fdmt_extrato.Append();
    fdmt_extratoDATA.AsDateTime:= vDataSaldoAnterior;
    fdmt_extratoDATA_VIEW.AsString:= FormatDateTime('dd/mm/yy',vDataSaldoAnterior);
    fdmt_extratoREFERENTE.AsString:= 'SALDO ANTERIOR';
    fdmt_extratoSALDO.AsString:= THelper.ExtendedToString(vSaldoAnterior);
    fdmt_extrato.Post();

    fdmt_extrato.First();
    fdmt_extrato.EnableControls();
  end;
end;

procedure TformContaList.FormCreate(Sender: TObject);
begin
  inherited;
  dtp_start.Date:= StartOfTheMonth(Now);
  dtp_end.Date:= Now;
  list('');
end;

procedure TformContaList.lbe_searchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    13: list('');
    38: begin
      fdmt_contas.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_contas.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformContaList.list(search: string);
var
  vTotal: Extended;
begin
  fdmt_contas.AfterScroll:= nil;
  TConta.list(search, fdmt_contas);

  fdmt_contas.DisableControls();
  fdmt_contas.First();
  vTotal:= 0;
  while not fdmt_contas.Eof do
  begin
    vTotal:= (vTotal + fdmt_contasSALDO.AsExtended);
    fdmt_contas.Next();
  end;
  fdmt_contas.First();
  fdmt_contas.EnableControls();
  fdmt_contas.AfterScroll:= fdmt_contasAfterScroll;
  fdmt_contasAfterScroll(fdmt_contas);

  if (THelper.ExtendedToString(vTotal) = '0,00') then
    lb_saldo_total.Font.Color:= clBlack
  else if (vTotal < 0) then
    lb_saldo_total.Font.Color:= clRed
  else if (vTotal > 0) then
    lb_saldo_total.Font.Color:= clGreen;

  lb_saldo_total.Caption:= THelper.ExtendedToString(vTotal);
end;

end.
