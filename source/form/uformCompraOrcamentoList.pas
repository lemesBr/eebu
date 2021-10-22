unit uformCompraOrcamentoList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Actions, Vcl.ActnList, Pessoa, User,
  System.StrUtils, System.DateUtils;

type
  TformCompraOrcamentoList = class(TformBase)
    acl_orcamentos: TActionList;
    act_rollback: TAction;
    act_destroy: TAction;
    act_export: TAction;
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_rollback: TButton;
    btn_destroy: TButton;
    btn_export: TButton;
    pnl_body: TPanel;
    bvl_3: TBevel;
    dbg_itens: TDBGrid;
    pnl_search: TPanel;
    lb_start: TLabel;
    lb_end: TLabel;
    lb_user: TLabel;
    lb_pessoa: TLabel;
    lbe_search: TLabeledEdit;
    dtp_end: TDateTimePicker;
    dtp_start: TDateTimePicker;
    edb_pessoa: TButtonedEdit;
    edb_user: TButtonedEdit;
    tmr_focus: TTimer;
    ds_orcamentos: TDataSource;
    fdmt_orcamentos: TFDMemTable;
    fdmt_orcamentosID: TStringField;
    fdmt_orcamentosREFERENCIA: TIntegerField;
    fdmt_orcamentosCOMPETENCIA: TDateField;
    fdmt_orcamentosSUBTOTAL: TCurrencyField;
    fdmt_orcamentosACRESCIMO: TCurrencyField;
    fdmt_orcamentosDESCONTO: TCurrencyField;
    fdmt_orcamentosTOTAL: TCurrencyField;
    fdmt_orcamentosPESSOA: TStringField;
    fdmt_orcamentosUSER: TStringField;
    fdmt_orcamentosNFE_ID: TStringField;
    fdmt_orcamentosCHECK: TIntegerField;
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_destroyExecute(Sender: TObject);
    procedure act_exportExecute(Sender: TObject);
    procedure tmr_focusTimer(Sender: TObject);
    procedure lbe_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edb_userRightButtonClick(Sender: TObject);
    procedure edb_userLeftButtonClick(Sender: TObject);
    procedure edb_userChange(Sender: TObject);
    procedure edb_pessoaRightButtonClick(Sender: TObject);
    procedure edb_pessoaLeftButtonClick(Sender: TObject);
    procedure dbg_itensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure acl_orcamentosUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
    Pessoa: TPessoa;
    User: TUser;
    procedure list(pDtInicial,
                   pDtFinal: TDate;
                   pPessoaId,
                   pUserId,
                   pSearch: string);
  public
    { Public declarations }
  end;

var
  formCompraOrcamentoList: TformCompraOrcamentoList;

implementation

uses
  Compra, uformUserList, AuthService, uformPessoaList;

{$R *.dfm}

procedure TformCompraOrcamentoList.acl_orcamentosUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_destroy.Enabled:= (fdmt_orcamentos.RecordCount >= 1);
  act_export.Enabled:= (fdmt_orcamentos.RecordCount >= 1);
  tmr_focus.Enabled:= (not lbe_search.Focused);
end;

procedure TformCompraOrcamentoList.act_destroyExecute(Sender: TObject);
begin
  if (TCompra.remove(fdmt_orcamentosID.AsString)) then
    fdmt_orcamentos.Delete();
end;

procedure TformCompraOrcamentoList.act_exportExecute(Sender: TObject);
begin
  TAuthService.CompraId:= fdmt_orcamentosID.AsString;
  Close();
end;

procedure TformCompraOrcamentoList.act_rollbackExecute(Sender: TObject);
begin
  TAuthService.CompraId:= EmptyStr;
  Close();
end;

procedure TformCompraOrcamentoList.dbg_itensDrawColumnCell(Sender: TObject;
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

procedure TformCompraOrcamentoList.edb_pessoaLeftButtonClick(Sender: TObject);
var
  v_form: TformPessoaList;
begin
  TAuthService.PessoaId:= EmptyStr;
  try
    v_form:= TformPessoaList.Create(nil);
    v_form.Tag:= 1;
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.PessoaId <> EmptyStr) then
  begin
    Pessoa:= TPessoa.find(TAuthService.PessoaId);
    edb_pessoa.Text:= Pessoa.Nome;
  end;
end;

procedure TformCompraOrcamentoList.edb_pessoaRightButtonClick(Sender: TObject);
begin
  FreeAndNil(Pessoa);
  TButtonedEdit(Sender).Text:= '';
end;

procedure TformCompraOrcamentoList.edb_userChange(Sender: TObject);
begin
  TButtonedEdit(Sender).LeftButton.Visible:= (Trim(TButtonedEdit(Sender).Text) = '');
  TButtonedEdit(Sender).RightButton.Visible:= (Trim(TButtonedEdit(Sender).Text) <> '');
end;

procedure TformCompraOrcamentoList.edb_userLeftButtonClick(Sender: TObject);
var
  v_form: TformUserList;
begin
  TAuthService.UserId:= EmptyStr;
  try
    v_form:= TformUserList.Create(nil);
    v_form.Tag:= 1;
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.UserId <> EmptyStr) then
  begin
    User:= TUser.find(TAuthService.UserId);
    edb_user.Text:= User.Nome;
  end;
end;

procedure TformCompraOrcamentoList.edb_userRightButtonClick(Sender: TObject);
begin
  FreeAndNil(User);
  TButtonedEdit(Sender).Text:= '';
end;

procedure TformCompraOrcamentoList.FormCreate(Sender: TObject);
begin
  inherited;
  Pessoa:= nil;
  User:= nil;

  dtp_start.Date:= StartOfTheMonth(Now);
  dtp_end.Date:= Now;

  list(dtp_start.Date,
       dtp_end.Date,
       '',
       '',
       '');
end;

procedure TformCompraOrcamentoList.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Pessoa);
  FreeAndNil(User);
end;

procedure TformCompraOrcamentoList.lbe_searchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    13: list(dtp_start.Date,
             dtp_end.Date,
             IfThen(Assigned(Pessoa), Pessoa.Id, ''),
             IfThen(Assigned(User), User.Id, ''),
             Trim(lbe_search.Text));
    38: begin
      fdmt_orcamentos.Prior();
      Key:= 35;
    end;
    40: begin
      fdmt_orcamentos.Next();
      Key:= 35;
    end;
  end;

end;

procedure TformCompraOrcamentoList.list(pDtInicial,
                                        pDtFinal: TDate;
                                        pPessoaId,
                                        pUserId,
                                        pSearch: string);
begin
  TCompra.list(0,
              pDtInicial,
              pDtFinal,
              pPessoaId,
              pUserId,
              pSearch,
              fdmt_orcamentos);
end;

procedure TformCompraOrcamentoList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_search.Focused and
    not dtp_start.Focused and
    not dtp_end.Focused then lbe_search.SetFocus;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
