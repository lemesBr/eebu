unit uformVendaList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Vcl.Grids, Vcl.DBGrids, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.Tabs, System.DateUtils,
  System.Math, Vcl.Menus, Pessoa, User, System.StrUtils;

type
  TformVendaList = class(TformBase)
    acl_vendas: TActionList;
    act_rollback: TAction;
    act_venda_store: TAction;
    act_venda_nfe: TAction;
    fdmt_vendas: TFDMemTable;
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_head: TPanel;
    pnl_footer: TPanel;
    btn_venda_store: TButton;
    btn_rollback: TButton;
    bvl_3: TBevel;
    dbg_vendas: TDBGrid;
    tmr_focus: TTimer;
    ds_vendas: TDataSource;
    act_venda_destroy: TAction;
    fdmt_vendasID: TStringField;
    fdmt_vendasREFERENCIA: TIntegerField;
    fdmt_vendasCOMPETENCIA: TDateField;
    fdmt_vendasSUBTOTAL: TCurrencyField;
    fdmt_vendasACRESCIMO: TCurrencyField;
    fdmt_vendasDESCONTO: TCurrencyField;
    fdmt_vendasTOTAL: TCurrencyField;
    fdmt_vendasPESSOA: TStringField;
    fdmt_vendasVENDEDOR: TStringField;
    btn_venda_cancelar: TButton;
    pnl_body: TPanel;
    bvl_4: TBevel;
    fdmt_vendasNFE: TStringField;
    fdmt_vendasCHECK: TIntegerField;
    act_reimprimir_comprovante: TAction;
    btn_venda: TButton;
    ppm_venda: TPopupMenu;
    pnl_totais: TPanel;
    bvl_5: TBevel;
    bvl_6: TBevel;
    pnl_totais_left: TPanel;
    Panel1: TPanel;
    lbl_total_recebidas: TLabel;
    lbl_total_receber: TLabel;
    lbl_total_vencidas: TLabel;
    Panel2: TPanel;
    lbl_recebidas: TLabel;
    lbl_receber: TLabel;
    lbl_vencidas: TLabel;
    pnl_totais_right: TPanel;
    Panel3: TPanel;
    lbl_numero_lancamentos: TLabel;
    lbl_numero_lancamentos_selecionados: TLabel;
    lbl_total_lancamentos_selecionados: TLabel;
    Panel4: TPanel;
    lbl_lancamentos: TLabel;
    lbl_lancamentos_selecionados: TLabel;
    lbl_lancamentos_selecionados_total: TLabel;
    REIMPRIMIR: TMenuItem;
    btn_venda_itens: TButton;
    act_venda_itens: TAction;
    act_venda_nfce: TAction;
    act_venda_nf: TAction;
    GERARNFCe: TMenuItem;
    GERARNFe: TMenuItem;
    GERARNOTAFISCAL: TMenuItem;
    act_venda_pessoa: TAction;
    IDENTIFICARPESSOA: TMenuItem;
    pnl_itens: TPanel;
    dbg_itens: TDBGrid;
    bvl_7: TBevel;
    fdmt_itens: TFDMemTable;
    fdmt_itensITEM_ID: TStringField;
    fdmt_itensITEM_REFERENCIA: TIntegerField;
    fdmt_itensITEM_NOME: TStringField;
    fdmt_itensITEM_UNIDADE: TStringField;
    fdmt_itensUNITARIO: TCurrencyField;
    fdmt_itensQTDE: TCurrencyField;
    fdmt_itensSUBTOTAL: TCurrencyField;
    fdmt_itensACRESCIMO: TCurrencyField;
    fdmt_itensDESCONTO: TCurrencyField;
    fdmt_itensTOTAL: TCurrencyField;
    ds_itens: TDataSource;
    btn_venda_update: TButton;
    act_venda_update: TAction;
    fdmt_vendasBOLETO: TStringField;
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
    act_imprimir: TAction;
    IMPRIMIR: TMenuItem;
    procedure act_venda_storeExecute(Sender: TObject);
    procedure act_rollbackExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbg_vendasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure lbe_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmr_focusTimer(Sender: TObject);
    procedure acl_vendasUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure act_venda_destroyExecute(Sender: TObject);
    procedure act_reimprimir_comprovanteExecute(Sender: TObject);
    procedure dbg_vendasDblClick(Sender: TObject);
    procedure act_venda_itensExecute(Sender: TObject);
    procedure act_venda_nfExecute(Sender: TObject);
    procedure act_venda_nfceExecute(Sender: TObject);
    procedure act_venda_nfeExecute(Sender: TObject);
    procedure act_venda_pessoaExecute(Sender: TObject);
    procedure dbg_itensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbg_itensExit(Sender: TObject);
    procedure act_venda_updateExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edb_userChange(Sender: TObject);
    procedure edb_userLeftButtonClick(Sender: TObject);
    procedure edb_userRightButtonClick(Sender: TObject);
    procedure edb_pessoaRightButtonClick(Sender: TObject);
    procedure edb_pessoaLeftButtonClick(Sender: TObject);
    procedure act_imprimirExecute(Sender: TObject);
  private
    { Private declarations }
    Pessoa: TPessoa;
    User: TUser;
    lVendas: string;
    TotalSelecionadas: Integer;
    procedure list(pDtInicial,
                   pDtFinal: TDate;
                   pPessoaId,
                   pUserId,
                   pSearch: string);
    procedure calculaTotais();
    procedure exportarToNf(Id: string);
  public
    { Public declarations }
  end;

var
  formVendaList: TformVendaList;

implementation

uses
  uformVendaCreateEdit, Venda, AuthService, udmRepository,
  uformOperacaoFiscalList, Nfe, Helper, uformNfeList, uformPessoaList,
  uformUserList;

{$R *.dfm}

procedure TformVendaList.acl_vendasUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_venda_itens.Enabled:= (fdmt_vendas.RecordCount >= 1) and (not pnl_itens.Visible);
  act_venda_update.Enabled:= (fdmt_vendas.RecordCount >= 1);
  act_venda_destroy.Enabled:= (fdmt_vendas.RecordCount >= 1);
  act_reimprimir_comprovante.Enabled:= (fdmt_vendas.RecordCount >= 1);
  act_venda_pessoa.Enabled:= (fdmt_vendas.RecordCount >= 1);
  act_venda_nfce.Enabled:= (TotalSelecionadas >= 1);
  act_venda_nfe.Enabled:= (TotalSelecionadas >= 1);
  act_venda_nf.Enabled:= (TotalSelecionadas >= 1);
  act_imprimir.Enabled:= (fdmt_vendas.RecordCount >= 1);
  tmr_focus.Enabled:= (not lbe_search.Focused);
end;

procedure TformVendaList.act_rollbackExecute(Sender: TObject);
begin
  Close;
end;

procedure TformVendaList.act_venda_destroyExecute(Sender: TObject);
begin
  if (fdmt_vendasNFE.AsString = 'S') then
  begin
    THelper.Mensagem('Venda vinculada a uma nota fiscal. Cancele a nota fiscal para assim poder remover a venda!');
    Exit();
  end;

  if (fdmt_vendasBOLETO.AsString = 'S') then
  begin
    THelper.Mensagem('Boleto vinculado. Cancele os boletos para assim poder remover a venda!');
    Exit();
  end;

  if (TVenda.remove(fdmt_vendasID.AsString)) then
  begin
    fdmt_vendas.Delete;
    calculaTotais();
  end;
end;

procedure TformVendaList.act_imprimirExecute(Sender: TObject);
begin
  try
    TVenda.imprimir(1,
                    dtp_start.Date,
                    dtp_end.Date,
                    IfThen(Assigned(Pessoa), Pessoa.Id, ''),
                    IfThen(Assigned(User), User.Id, ''),
                    Trim(lbe_search.Text));

  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformVendaList.act_reimprimir_comprovanteExecute(Sender: TObject);
begin
  if not (fdmt_vendas.RecordCount >= 1) then Exit();
  if not THelper.Mensagem('Deseja reimprimir o comprovante?', 1) then Exit();

  try
    TVenda.imprimir(fdmt_vendasID.AsString, TAuthService.getAuthenticatedConfig.PrintMode);
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformVendaList.act_venda_itensExecute(Sender: TObject);
begin
  if not (fdmt_vendas.RecordCount >= 1) then Exit();
  TVenda.listItens(fdmt_vendasID.AsString, fdmt_itens);
  pnl_itens.Visible:= True;
  dbg_itens.SetFocus;
end;

procedure TformVendaList.act_venda_nfceExecute(Sender: TObject);
begin
  if (TAuthService.getAuthenticatedConfig.NfceOperacaoFiscalId <> EmptyStr) then
  begin
    if THelper.Mensagem('Deseja realmente gerar NFC-e?',1) then
      exportarToNf(TAuthService.getAuthenticatedConfig.NfceOperacaoFiscalId);
  end
  else
    act_venda_nfExecute(Sender);
end;

procedure TformVendaList.act_venda_nfeExecute(Sender: TObject);
begin
  if (TAuthService.getAuthenticatedConfig.NfeOperacaoFiscalId <> EmptyStr) then
  begin
    if THelper.Mensagem('Deseja realmente gerar NF-e?',1) then
      exportarToNf(TAuthService.getAuthenticatedConfig.NfeOperacaoFiscalId);
  end
  else
    act_venda_nfExecute(Sender);
end;

procedure TformVendaList.act_venda_nfExecute(Sender: TObject);
var
  v_form: TformOperacaoFiscalList;
  vVendas, vVendasOk: string;
  vVendaId: string;
begin
  if (TotalSelecionadas = 1) then
  begin
    TAuthService.OperacaoFiscalId:= EmptyStr;

    try
      v_form:= TformOperacaoFiscalList.Create(nil);
      v_form.Tag:= 1;
      v_form.ShowModal;
    finally
      FreeAndNil(v_form);
    end;

    if (TAuthService.OperacaoFiscalId = EmptyStr) then Exit()
    else exportarToNf(TAuthService.OperacaoFiscalId);
  end
  else if (TotalSelecionadas >= 2) then
  begin
    vVendas:= lVendas;

    vVendaId:= THelper.DevolveConteudoDelimitado('|', vVendas);
    vVendasOk:= QuotedStr(vVendaId);

    while not (vVendas = '') do
    begin
      vVendaId:= THelper.DevolveConteudoDelimitado('|', vVendas);
      vVendasOk:= vVendasOk + ',' + QuotedStr(vVendaId);
    end;

    if not TVenda.unicPessoa(vVendasOk) then
    begin
      THelper.Mensagem('As vendas selecionadas devem ser para a mesma pessoa.');
      Exit();
    end;

    TAuthService.OperacaoFiscalId:= EmptyStr;

    try
      v_form:= TformOperacaoFiscalList.Create(nil);
      v_form.Tag:= 1;
      v_form.ShowModal;
    finally
      FreeAndNil(v_form);
    end;

    if (TAuthService.OperacaoFiscalId = EmptyStr) then Exit()
    else exportarToNf(TAuthService.OperacaoFiscalId);
  end;
end;

procedure TformVendaList.act_venda_pessoaExecute(Sender: TObject);
var
  v_form: TformPessoaList;
  vPessoa: TPessoa;
begin
  if (fdmt_vendasNFE.AsString = 'S') then
  begin
    THelper.Mensagem('Venda vinculada a uma nota fiscal. Cancele a nota fiscal para assim poder editar a venda!');
    Exit();
  end;

  if (fdmt_vendasBOLETO.AsString = 'S') then
  begin
    THelper.Mensagem('Boleto vinculado. Cancele os boletos para assim poder editar a venda!');
    Exit();
  end;

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
    if not THelper.Mensagem('Deseja alterar a pessoa?', 1) then Exit();

    vPessoa:= nil;
    try
      vPessoa:= TPessoa.find(TAuthService.PessoaId);
      if not Assigned(vPessoa) then
        raise Exception.Create('Falha ao consultar dados de pessoa.');

      if TVenda.updatePessoa(fdmt_vendasID.AsString, vPessoa.Id) then
      begin
        fdmt_vendas.Edit();
        fdmt_vendasPESSOA.AsString:= vPessoa.Nome;
        fdmt_vendas.Post();
      end;
    except on e: Exception do
      THelper.Mensagem(e.Message);
    end;
    FreeAndNil(vPessoa);
  end;
end;

procedure TformVendaList.calculaTotais;
var
  NfsEmitidas,
  NfsEmitir: Extended;
  TotalNumeroSelecionados: Extended;
  vClone: TFDMemTable;
begin
  lbl_numero_lancamentos.Caption:= fdmt_vendas.RecordCount.ToString();

  lVendas:= '';
  NfsEmitidas:= 0;
  NfsEmitir:= 0;
  TotalSelecionadas:= 0;
  TotalNumeroSelecionados:= 0;

  vClone:= TFDMemTable.Create(nil);
  vClone.CloneCursor(fdmt_vendas);
  vClone.DisableControls;
  vClone.First;
  while not vClone.Eof do
  begin
    if (vClone.FieldByName('NFE').AsString = 'S') then
      NfsEmitidas:= NfsEmitidas + vClone.FieldByName('TOTAL').AsExtended
    else
      NfsEmitir:= NfsEmitir + vClone.FieldByName('TOTAL').AsExtended;

    if (vClone.FieldByName('CHECK').AsInteger >= 1) then
    begin
      Inc(TotalSelecionadas);
      TotalNumeroSelecionados:= TotalNumeroSelecionados + vClone.FieldByName('TOTAL').AsExtended;
      lVendas:= lVendas + vClone.FieldByName('ID').AsString + '|';
    end;

    vClone.Next;
  end;
  vClone.Close;
  FreeAndNil(vClone);

  lbl_total_recebidas.Caption:= THelper.ExtendedToString(NfsEmitidas);
  lbl_total_receber.Caption:= THelper.ExtendedToString(NfsEmitir);
  lbl_total_vencidas.Caption:= THelper.ExtendedToString(NfsEmitidas + NfsEmitir);
  lbl_numero_lancamentos_selecionados.Caption:= TotalSelecionadas.ToString();
  lbl_total_lancamentos_selecionados.Caption:= THelper.ExtendedToString(TotalNumeroSelecionados);
end;

procedure TformVendaList.act_venda_storeExecute(Sender: TObject);
var
  v_form: TformVendaCreateEdit;
begin
  TAuthService.VendaId:= EmptyStr;
  try
    v_form:= TformVendaCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.VendaId <> EmptyStr) then
    list(dtp_start.Date,
         dtp_end.Date,
         IfThen(Assigned(Pessoa), Pessoa.Id, ''),
         IfThen(Assigned(User), User.Id, ''),
         Trim(lbe_search.Text));
end;

procedure TformVendaList.act_venda_updateExecute(Sender: TObject);
var
  v_form: TformVendaCreateEdit;
begin
  if (fdmt_vendasNFE.AsString = 'S') then
  begin
    THelper.Mensagem('Venda vinculada a uma nota fiscal. Cancele a nota fiscal para assim poder editar a venda!');
    Exit();
  end;

  if (fdmt_vendasBOLETO.AsString = 'S') then
  begin
    THelper.Mensagem('Boleto vinculado. Cancele os boletos para assim poder editar a venda!');
    Exit();
  end;

  TAuthService.VendaId:= fdmt_vendasID.AsString;
  try
    v_form:= TformVendaCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.VendaId <> EmptyStr) then
    list(dtp_start.Date,
         dtp_end.Date,
         IfThen(Assigned(Pessoa), Pessoa.Id, ''),
         IfThen(Assigned(User), User.Id, ''),
         Trim(lbe_search.Text));
end;

procedure TformVendaList.dbg_itensDrawColumnCell(Sender: TObject;
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

procedure TformVendaList.dbg_itensExit(Sender: TObject);
begin
  pnl_itens.Visible:= False;
end;

procedure TformVendaList.dbg_vendasDblClick(Sender: TObject);
begin
  if not (TDBGrid(Sender).DataSource.Dataset.RecordCount >= 1) then
    Exit();

  if (TDBGrid(Sender).DataSource.DataSet.FieldByName('NFE').AsString = 'S') then
    Exit();

  TDBGrid(Sender).DataSource.DataSet.Edit;
  TDBGrid(Sender).DataSource.DataSet.FieldByName('CHECK').AsInteger:=
    IfThen(TDBGrid(Sender).DataSource.DataSet.FieldByName('CHECK').AsInteger >= 1,0,1);
  TDBGrid(Sender).DataSource.DataSet.Post;

  calculaTotais();
end;

procedure TformVendaList.dbg_vendasDrawColumnCell(Sender: TObject;
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

  if not fdmt_vendas.IsEmpty then
  begin
    if Column.FieldName = 'NFE' then
    begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      if (fdmt_vendasNFE.AsString = 'S') then
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 7, Rect.Top + 1, 20);
    end
    else if Column.FieldName = 'CHECK' then
    begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      if (fdmt_vendasCHECK.AsInteger >= 1) then
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 7, Rect.Top + 1, 5)
      else
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 7, Rect.Top + 1, 2);
    end;
  end;
end;

procedure TformVendaList.edb_pessoaLeftButtonClick(Sender: TObject);
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

procedure TformVendaList.edb_pessoaRightButtonClick(Sender: TObject);
begin
  FreeAndNil(Pessoa);
  TButtonedEdit(Sender).Text:= '';
end;

procedure TformVendaList.edb_userChange(Sender: TObject);
begin
  TButtonedEdit(Sender).LeftButton.Visible:= (Trim(TButtonedEdit(Sender).Text) = '');
  TButtonedEdit(Sender).RightButton.Visible:= (Trim(TButtonedEdit(Sender).Text) <> '');
end;

procedure TformVendaList.edb_userLeftButtonClick(Sender: TObject);
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

procedure TformVendaList.edb_userRightButtonClick(Sender: TObject);
begin
  FreeAndNil(User);
  TButtonedEdit(Sender).Text:= '';
end;

procedure TformVendaList.exportarToNf(Id: string);
var
  vForm: TformNfeList;
  vNfe: TNfe;
  vVendas, vVendasOk: string;
  vVendaId: string;
begin
  if (Id = EmptyStr) then
    Exit();

  if (TotalSelecionadas = 1) then
  begin
    vVendas:= lVendas;
    vVendaId:= THelper.DevolveConteudoDelimitado('|', vVendas);
    TAuthService.NfeId:= TNfe.vendaToNfe(vVendaId, Id);
  end
  else if (TotalSelecionadas >= 2) then
  begin
    vVendas:= lVendas;
    vVendaId:= THelper.DevolveConteudoDelimitado('|', vVendas);
    vVendasOk:= QuotedStr(vVendaId);

    while not (vVendas = '') do
    begin
      vVendaId:= THelper.DevolveConteudoDelimitado('|', vVendas);
      vVendasOk:= vVendasOk + ',' + QuotedStr(vVendaId);
    end;

    if not TVenda.unicPessoa(vVendasOk) then
    begin
      THelper.Mensagem('As vendas selecionadas devem ser para a mesma pessoa.');
      Exit();
    end;

    TAuthService.NfeId:= TNfe.lvendasToNfe(vVendaId, vVendasOk, Id);
  end;

  vNfe:= TNfe.find(TAuthService.NfeId);
  if not Assigned(vNfe) then
    Exit();

  try
    try
      if (AnsiIndexStr(vNfe.Modelo, ['01','1B','04','55', '65']) in[0,1,2]) then
        THelper.Mensagem('Nota fiscal gerada com sucesso.')
      else
      begin
        if THelper.Mensagem('Nota fiscal gerada com sucesso. Deseja enviar?', 1) then
          vNfe.enviar();
      end;
    except on e: Exception do
      begin
        THelper.Mensagem(e.Message);
        try
          vForm:= TformNfeList.Create(nil);
          vForm.ShowModal;
        finally
          FreeAndNil(vForm);
        end;
      end;
    end;
  finally
    if Assigned(vNfe) then FreeAndNil(vNfe);
  end;

  list(dtp_start.Date,
       dtp_end.Date,
       IfThen(Assigned(Pessoa), Pessoa.Id, ''),
       IfThen(Assigned(User), User.Id, ''),
       Trim(lbe_search.Text));
end;

procedure TformVendaList.FormCreate(Sender: TObject);
begin
  inherited;
  Pessoa:= nil;
  User:= nil;

  dtp_start.Date:= StartOfTheMonth(Now);
  dtp_end.Date:= Now;

  pnl_itens.Visible:= False;

  list(dtp_start.Date,
       dtp_end.Date,
       '',
       '',
       '');
end;

procedure TformVendaList.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Pessoa);
  FreeAndNil(User);
end;

procedure TformVendaList.lbe_searchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    13: list(dtp_start.Date,
             dtp_end.Date,
             IfThen(Assigned(Pessoa), Pessoa.Id, ''),
             IfThen(Assigned(User), User.Id, ''),
             Trim(lbe_search.Text));
    38: begin
      fdmt_vendas.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_vendas.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformVendaList.list(pDtInicial,
                              pDtFinal: TDate;
                              pPessoaId,
                              pUserId,
                              pSearch: string);
begin
  TVenda.list(1,
              pDtInicial,
              pDtFinal,
              pPessoaId,
              pUserId,
              pSearch,
              fdmt_vendas);

  calculaTotais();
end;

procedure TformVendaList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_search.Focused and
    not dbg_itens.Focused and
    not dtp_start.Focused and
    not dtp_end.Focused then lbe_search.SetFocus;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
