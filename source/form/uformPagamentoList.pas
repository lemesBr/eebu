unit uformPagamentoList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.Imaging.pngimage, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.Menus, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Actions, Vcl.ActnList,
  System.DateUtils, System.StrUtils, Conta, Categoria, Pessoa;

type
  TformPagamentoList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_pagamentos_header: TPanel;
    pnl_pagamentos_footer: TPanel;
    btn_rollback: TButton;
    btn_pagamento_store: TButton;
    btn_pagamento_update: TButton;
    btn_pagamento_destroy: TButton;
    pnl_pagamentos_body: TPanel;
    bvl_3: TBevel;
    dbg_pagamentos: TDBGrid;
    pnl_totais: TPanel;
    bvl_4: TBevel;
    Bevel1: TBevel;
    pnl_totais_left: TPanel;
    Panel1: TPanel;
    lbl_total_pagas: TLabel;
    lbl_total_pagar: TLabel;
    lbl_total_vencidas: TLabel;
    lbl_total_pagamentos: TLabel;
    Panel2: TPanel;
    lbl_pagas: TLabel;
    lbl_pagar: TLabel;
    lbl_vencidas: TLabel;
    lbl_pagamentos: TLabel;
    pnl_totais_right: TPanel;
    Panel3: TPanel;
    lbl_numero_lancamentos: TLabel;
    lbl_numero_lancamentos_selecionados: TLabel;
    lbl_total_lancamentos_selecionados: TLabel;
    Panel4: TPanel;
    lbl_lancamentos: TLabel;
    lbl_lancamentos_selecionados: TLabel;
    lbl_lancamentos_selecionados_total: TLabel;
    acl_pagamentos: TActionList;
    act_rollback: TAction;
    act_pagamento_store: TAction;
    act_pagamento_update: TAction;
    act_pagamento_destroy: TAction;
    fdmt_pagamentos: TFDMemTable;
    fdmt_pagamentosID: TStringField;
    fdmt_pagamentosDATA: TDateField;
    fdmt_pagamentosCATEGORIA: TStringField;
    fdmt_pagamentosDESCRICAO: TStringField;
    fdmt_pagamentosPESSOA: TStringField;
    fdmt_pagamentosVALOR: TFloatField;
    fdmt_pagamentosSITUACAO: TStringField;
    fdmt_pagamentosSELECIONADO: TStringField;
    tmr_focus: TTimer;
    ds_pagamentos: TDataSource;
    btn_pagamento: TButton;
    act_pagamento_pago: TAction;
    ppm_pagamento: TPopupMenu;
    DEFINIRCOMOPAGO: TMenuItem;
    pnl_search: TPanel;
    lb_filtro: TLabel;
    lb_start: TLabel;
    lb_end: TLabel;
    lb_situacao: TLabel;
    lb_conta: TLabel;
    lb_categoria: TLabel;
    lb_pessoa: TLabel;
    lbe_search: TLabeledEdit;
    dtp_end: TDateTimePicker;
    dtp_start: TDateTimePicker;
    cbx_filtro: TComboBox;
    edb_pessoa: TButtonedEdit;
    edb_categoria: TButtonedEdit;
    cbx_situacao: TComboBox;
    edb_conta: TButtonedEdit;
    act_imprimir: TAction;
    procedure tmr_focusTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_pagamento_storeExecute(Sender: TObject);
    procedure act_pagamento_updateExecute(Sender: TObject);
    procedure act_pagamento_destroyExecute(Sender: TObject);
    procedure lbe_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbg_pagamentosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure acl_pagamentosUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure dbg_pagamentosDblClick(Sender: TObject);
    procedure act_pagamento_pagoExecute(Sender: TObject);
    procedure edb_contaLeftButtonClick(Sender: TObject);
    procedure edb_contaRightButtonClick(Sender: TObject);
    procedure edb_categoriaLeftButtonClick(Sender: TObject);
    procedure edb_categoriaRightButtonClick(Sender: TObject);
    procedure edb_pessoaLeftButtonClick(Sender: TObject);
    procedure edb_pessoaRightButtonClick(Sender: TObject);
    procedure edb_contaChange(Sender: TObject);
    procedure act_imprimirExecute(Sender: TObject);
  private
    { Private declarations }
    Conta: TConta;
    Categoria: TCategoria;
    Pessoa: TPessoa;
    vFiltro: Integer;

    procedure list(pFiltro,
                   pSituacao: Integer;
                   pDtInicial,
                   pDtFinal: TDate;
                   pContaId,
                   pCategoriaId,
                   pPessoaId,
                   pSearch: string);

    procedure listRefresh();
    procedure calculaTotais();
  public
    { Public declarations }
  end;

var
  formPagamentoList: TformPagamentoList;

implementation

uses
  Pagamento, Helper, udmRepository, AuthService, uformPagamentoCreateEdit,
  uformContaList, uformCategoriaList, uformPessoaList;

{$R *.dfm}

{ TformPagamentoList }

procedure TformPagamentoList.acl_pagamentosUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_pagamento_update.Enabled:= (fdmt_pagamentos.RecordCount >= 1);
  act_pagamento_destroy.Enabled:= act_pagamento_update.Enabled;
  act_pagamento_pago.Enabled:= (fdmt_pagamentos.RecordCount >= 1) and (fdmt_pagamentosSITUACAO.AsString = 'A');
  tmr_focus.Enabled:= (not lbe_search.Focused);
end;

procedure TformPagamentoList.act_imprimirExecute(Sender: TObject);
begin
  TPagamento.imprimir(cbx_filtro.ItemIndex,
                      cbx_situacao.ItemIndex,
                      dtp_start.Date,
                      dtp_end.Date,
                      IfThen(Assigned(Conta), Conta.Id, ''),
                      IfThen(Assigned(Categoria), Categoria.Id, ''),
                      IfThen(Assigned(Pessoa), Pessoa.Id, ''),
                      Trim(lbe_search.Text));
end;

procedure TformPagamentoList.act_pagamento_destroyExecute(Sender: TObject);
begin
  if TPagamento.remove(fdmt_pagamentosID.AsString) then
  begin
    fdmt_pagamentos.Delete;
    calculaTotais();
  end;
end;

procedure TformPagamentoList.act_pagamento_pagoExecute(Sender: TObject);
var
  vPago: TPagamento;
begin
  try
    try
      vPago:= TPagamento.find(fdmt_pagamentosID.AsString);
      if not Assigned(vPago) then
        raise Exception.Create('Falha ao consultar dados do pagamento.');

      vPago.Pagamento:= Now();
      vPago.Situacao:= 'F';
      vPago.save();

      fdmt_pagamentos.Edit();
      fdmt_pagamentosDATA.AsDateTime:= vPago.Pagamento;
      fdmt_pagamentosSITUACAO.AsString:= vPago.Situacao;
      fdmt_pagamentos.Post();

      calculaTotais();
    except on e: Exception do
      THelper.Mensagem('Falha ao tentar pagar. Erro: ' + e.Message);
    end;
  finally
    FreeAndNil(vPago);
  end;
end;

procedure TformPagamentoList.act_pagamento_storeExecute(Sender: TObject);
begin
  TAuthService.PagamentoId:= EmptyStr;
  try
    formPagamentoCreateEdit:= TformPagamentoCreateEdit.Create(nil);
    formPagamentoCreateEdit.ShowModal;
  finally
    FreeAndNil(formPagamentoCreateEdit);
  end;

  if (TAuthService.PagamentoId <> EmptyStr) then
    listRefresh();
end;

procedure TformPagamentoList.act_pagamento_updateExecute(Sender: TObject);
begin
  TAuthService.PagamentoId:= fdmt_pagamentosID.AsString;
  try
    formPagamentoCreateEdit:= TformPagamentoCreateEdit.Create(nil);
    formPagamentoCreateEdit.ShowModal;
  finally
    FreeAndNil(formPagamentoCreateEdit);
  end;

  if (TAuthService.PagamentoId <> EmptyStr) then
    listRefresh();
end;

procedure TformPagamentoList.act_rollbackExecute(Sender: TObject);
begin
  Close;
end;

procedure TformPagamentoList.calculaTotais;
var
  Pagas,
  Pagar,
  Vencidas: Extended;
  NumeroSelecionados: Integer;
  TotalNumeroSelecionados: Extended;
  vClone: TFDMemTable;
begin
  lbl_numero_lancamentos.Caption:= fdmt_pagamentos.RecordCount.ToString();

  Pagas:= 0;
  Pagar:= 0;
  Vencidas:= 0;
  NumeroSelecionados:= 0;
  TotalNumeroSelecionados:= 0;

  vClone:= TFDMemTable.Create(nil);
  vClone.CloneCursor(fdmt_pagamentos);
  vClone.DisableControls;
  vClone.First;
  while not vClone.Eof do
  begin
    if (vClone.FieldByName('SITUACAO').AsString = 'A') then
    begin
      Pagar:= Pagar + vClone.FieldByName('VALOR').AsExtended;
      if (vClone.FieldByName('DATA').AsDateTime < Date) then
        Vencidas:= Vencidas + vClone.FieldByName('VALOR').AsExtended;
    end
    else if (vClone.FieldByName('SITUACAO').AsString = 'F') then
      Pagas:= Pagas + vClone.FieldByName('VALOR').AsExtended;

    if (vClone.FieldByName('SELECIONADO').AsString = 'S') then
    begin
      NumeroSelecionados:= NumeroSelecionados + 1;
      TotalNumeroSelecionados:= TotalNumeroSelecionados + vClone.FieldByName('VALOR').AsExtended;
    end;

    vClone.Next;
  end;
  vClone.Close;
  FreeAndNil(vClone);

  lbl_total_pagas.Caption:= THelper.ExtendedToString(Pagas);
  lbl_total_pagar.Caption:= THelper.ExtendedToString(Pagar);
  lbl_total_vencidas.Caption:= THelper.ExtendedToString(Vencidas);
  lbl_total_pagamentos.Caption:= THelper.ExtendedToString(Pagas + Pagar);
  lbl_numero_lancamentos_selecionados.Caption:= NumeroSelecionados.ToString();
  lbl_total_lancamentos_selecionados.Caption:= THelper.ExtendedToString(TotalNumeroSelecionados);
end;

procedure TformPagamentoList.dbg_pagamentosDblClick(Sender: TObject);
begin
  if (TDBGrid(Sender).DataSource.Dataset.IsEmpty) then
    Exit();

  TDBGrid(Sender).DataSource.Dataset.Edit;
  TDBGrid(Sender).DataSource.Dataset.FieldByName('SELECIONADO').AsString:=
    IfThen(TDBGrid(Sender).DataSource.Dataset.FieldByName('SELECIONADO').AsString = 'S', 'N', 'S');
  TDBGrid(Sender).DataSource.Dataset.Post;

  calculaTotais();
end;

procedure TformPagamentoList.dbg_pagamentosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  if (fdmt_pagamentosSITUACAO.AsString = 'A') and
     (vFiltro = 2) and
     (fdmt_pagamentosDATA.AsDateTime < Date) then
  begin
    TDBGrid(Sender).Canvas.Font.Color:= clRed;
  end;

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

  if not fdmt_pagamentos.IsEmpty then
  begin
    if (Column.Field.FieldName = 'SITUACAO') then
    begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      if (fdmt_pagamentosSITUACAO.AsString = 'F') then
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 10, Rect.Top + 1, 1);
    end
    else if (Column.Field.FieldName = 'SELECIONADO') then
    begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      if (fdmt_pagamentosSELECIONADO.AsString = 'S') then
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 10, Rect.Top + 1, 5)
      else
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 10, Rect.Top + 1, 2);
    end;
  end;
end;

procedure TformPagamentoList.edb_categoriaLeftButtonClick(Sender: TObject);
var
  v_form: TformCategoriaList;
begin
  TAuthService.CategoriaId:= EmptyStr;
  TAuthService.TipoCategoria:= 'D';
  try
    v_form:= TformCategoriaList.Create(nil);
    v_form.Tag:= 1;
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.CategoriaId <> EmptyStr) then
  begin
    FreeAndNil(Categoria);
    Categoria:= TCategoria.find(TAuthService.CategoriaId);
    edb_categoria.Text:= Categoria.Nome;
  end;
end;

procedure TformPagamentoList.edb_categoriaRightButtonClick(Sender: TObject);
begin
  FreeAndNil(Categoria);
  TButtonedEdit(Sender).Text:= '';
end;

procedure TformPagamentoList.edb_contaChange(Sender: TObject);
begin
  TButtonedEdit(Sender).LeftButton.Visible:= (Trim(TButtonedEdit(Sender).Text) = '');
  TButtonedEdit(Sender).RightButton.Visible:= (Trim(TButtonedEdit(Sender).Text) <> '');
end;

procedure TformPagamentoList.edb_contaLeftButtonClick(Sender: TObject);
var
  v_form: TformContaList;
begin
  TAuthService.ContaId:= EmptyStr;
  try
    v_form:= TformContaList.Create(nil);
    v_form.Tag:= 1;
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.ContaId <> EmptyStr) then
  begin
    FreeAndNil(Conta);
    Conta:= TConta.find(TAuthService.ContaId);
    edb_conta.Text:= Conta.Nome;
  end;
end;

procedure TformPagamentoList.edb_contaRightButtonClick(Sender: TObject);
begin
  FreeAndNil(Conta);
  TButtonedEdit(Sender).Text:= '';
end;

procedure TformPagamentoList.edb_pessoaLeftButtonClick(Sender: TObject);
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
    FreeAndNil(Pessoa);
    Pessoa:= TPessoa.find(TAuthService.PessoaId);
    edb_pessoa.Text:= Pessoa.Nome;
  end;
end;

procedure TformPagamentoList.edb_pessoaRightButtonClick(Sender: TObject);
begin
  FreeAndNil(Pessoa);
  TButtonedEdit(Sender).Text:= '';
end;

procedure TformPagamentoList.FormCreate(Sender: TObject);
begin
  inherited;
  Conta:= nil;
  Categoria:= nil;
  Pessoa:= nil;

  cbx_filtro.ItemIndex:= 2;
  dtp_start.Date:= StartOfTheMonth(Now);
  dtp_end.Date:= EndOfTheMonth(now);
  cbx_situacao.ItemIndex:= 1;

  list(cbx_filtro.ItemIndex,
       cbx_situacao.ItemIndex,
       dtp_start.Date,
       dtp_end.Date,
       '',
       '',
       '',
       '');
end;

procedure TformPagamentoList.lbe_searchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN: list(cbx_filtro.ItemIndex,
                     cbx_situacao.ItemIndex,
                     dtp_start.Date,
                     dtp_end.Date,
                     IfThen(Assigned(Conta), Conta.Id, ''),
                     IfThen(Assigned(Categoria), Categoria.Id, ''),
                     IfThen(Assigned(Pessoa), Pessoa.Id, ''),
                     Trim(TCustomEdit(Sender).Text));
    38: begin
      fdmt_pagamentos.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_pagamentos.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformPagamentoList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_search.Focused and
    not cbx_filtro.Focused and
    not dtp_start.Focused and
    not dtp_end.Focused and
    not cbx_situacao.Focused then lbe_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

procedure TformPagamentoList.list(pFiltro,
                                  pSituacao: Integer;
                                  pDtInicial,
                                  pDtFinal: TDate;
                                  pContaId,
                                  pCategoriaId,
                                  pPessoaId,
                                  pSearch: string);
begin
  TPagamento.list(pFiltro,
                  pSituacao,
                  pDtInicial,
                  pDtFinal,
                  pContaId,
                  pCategoriaId,
                  pPessoaId,
                  pSearch,
                  fdmt_pagamentos);

  vFiltro:= pFiltro;
  calculaTotais();
end;

procedure TformPagamentoList.listRefresh;
begin
  list(cbx_filtro.ItemIndex,
       cbx_situacao.ItemIndex,
       dtp_start.Date,
       dtp_end.Date,
       IfThen(Assigned(Conta), Conta.Id, ''),
       IfThen(Assigned(Categoria), Categoria.Id, ''),
       IfThen(Assigned(Pessoa), Pessoa.Id, ''),
       Trim(lbe_search.Text));
end;

end.
