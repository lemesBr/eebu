unit uformCompraList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Vcl.Tabs, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Actions, Vcl.ActnList, System.DateUtils, Pessoa,
  User, System.StrUtils, System.Math, Vcl.Menus;

type
  TformCompraList = class(TformBase)
    acl_compras: TActionList;
    act_rollback: TAction;
    act_store: TAction;
    act_update: TAction;
    act_destroy: TAction;
    fdmt_compras: TFDMemTable;
    fdmt_comprasID: TStringField;
    fdmt_comprasREFERENCIA: TIntegerField;
    fdmt_comprasCOMPETENCIA: TDateField;
    fdmt_comprasSUBTOTAL: TCurrencyField;
    fdmt_comprasACRESCIMO: TCurrencyField;
    fdmt_comprasDESCONTO: TCurrencyField;
    fdmt_comprasTOTAL: TCurrencyField;
    fdmt_comprasPESSOA: TStringField;
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_compras_head: TPanel;
    tmr_focus: TTimer;
    ds_compras: TDataSource;
    pnl_body: TPanel;
    bvl_3: TBevel;
    bvl_4: TBevel;
    pnl_footer: TPanel;
    btn_store: TButton;
    btn_rollback: TButton;
    btn_destroy: TButton;
    btn_update: TButton;
    dbg_compras: TDBGrid;
    fdmt_comprasNFE_ID: TStringField;
    fdmt_comprasCHECK: TIntegerField;
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
    btn_compra: TButton;
    ppm_compra: TPopupMenu;
    act_reimprimir_comprovante: TAction;
    act_compra_nf: TAction;
    act_imprimir: TAction;
    REIMPRIMIRCOMPROVANTE: TMenuItem;
    GERARNOTAFISCAL: TMenuItem;
    IMPRIMIR: TMenuItem;
    fdmt_comprasUSER: TStringField;
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_storeExecute(Sender: TObject);
    procedure act_updateExecute(Sender: TObject);
    procedure act_destroyExecute(Sender: TObject);
    procedure tmr_focusTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure acl_comprasUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure dbg_comprasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure lbe_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure edb_userChange(Sender: TObject);
    procedure edb_userRightButtonClick(Sender: TObject);
    procedure edb_pessoaRightButtonClick(Sender: TObject);
    procedure edb_userLeftButtonClick(Sender: TObject);
    procedure edb_pessoaLeftButtonClick(Sender: TObject);
    procedure dbg_comprasDblClick(Sender: TObject);
    procedure act_imprimirExecute(Sender: TObject);
    procedure act_reimprimir_comprovanteExecute(Sender: TObject);
    procedure act_compra_nfExecute(Sender: TObject);
  private
    { Private declarations }
    Pessoa: TPessoa;
    User: TUser;
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
  formCompraList: TformCompraList;

implementation

uses
  Compra, AuthService, uformCompraCreateEdit, udmRepository, uformUserList,
  uformPessoaList, Helper, uformNfeList, Nfe, uformOperacaoFiscalList;

{$R *.dfm}

procedure TformCompraList.acl_comprasUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_update.Enabled:= (fdmt_compras.RecordCount >= 1);
  act_destroy.Enabled:= (fdmt_compras.RecordCount >= 1);
  act_compra_nf.Enabled:= (fdmt_compras.RecordCount >= 1) and
                          (fdmt_comprasNFE_ID.AsString = EmptyStr) and
                          (TotalSelecionadas = 0);
  tmr_focus.Enabled:= (not lbe_search.Focused);
end;

procedure TformCompraList.act_compra_nfExecute(Sender: TObject);
var
  v_form: TformOperacaoFiscalList;
begin
  TAuthService.OperacaoFiscalId:= EmptyStr;
  try
    v_form:= TformOperacaoFiscalList.Create(nil);
    v_form.Tag:= 1;
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.OperacaoFiscalId <> EmptyStr) then
    exportarToNf(TAuthService.OperacaoFiscalId);
end;

procedure TformCompraList.act_destroyExecute(Sender: TObject);
begin
  if (fdmt_comprasNFE_ID.AsString <> '') then
  begin
    THelper.Mensagem('Compra vinculada a uma nota fiscal. Cancele a nota fiscal para assim poder remover a compra!');
    Exit();
  end;

  if (TCompra.remove(fdmt_comprasID.AsString)) then
  begin
    fdmt_compras.Delete();
    calculaTotais();
  end;
end;

procedure TformCompraList.act_imprimirExecute(Sender: TObject);
begin
  try
    TCompra.imprimir(1,
                     dtp_start.Date,
                     dtp_end.Date,
                     IfThen(Assigned(Pessoa), Pessoa.Id, ''),
                     IfThen(Assigned(User), User.Id, ''),
                     Trim(lbe_search.Text));

  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformCompraList.act_storeExecute(Sender: TObject);
begin
  TAuthService.CompraId:= EmptyStr;
  TAuthService.NfeId:= EmptyStr;
  try
    formCompraCreateEdit:= TformCompraCreateEdit.Create(nil);
    formCompraCreateEdit.ShowModal;
  finally
    FreeAndNil(formCompraCreateEdit);
  end;

  if (TAuthService.CompraId <> EmptyStr) then
    list(dtp_start.Date,
         dtp_end.Date,
         IfThen(Assigned(Pessoa), Pessoa.Id, ''),
         IfThen(Assigned(User), User.Id, ''),
         Trim(lbe_search.Text));
end;

procedure TformCompraList.act_updateExecute(Sender: TObject);
begin
  if (fdmt_comprasNFE_ID.AsString <> '') then
  begin
    THelper.Mensagem('Compra vinculada a uma nota fiscal. Cancele a nota fiscal para assim poder remover a compra!');
    Exit();
  end;

  TAuthService.CompraId:= fdmt_comprasID.AsString;
  TAuthService.NfeId:= EmptyStr;
  try
    formCompraCreateEdit:= TformCompraCreateEdit.Create(nil);
    formCompraCreateEdit.ShowModal;
  finally
    FreeAndNil(formCompraCreateEdit);
  end;

  if (TAuthService.CompraId <> EmptyStr) then
    list(dtp_start.Date,
         dtp_end.Date,
         IfThen(Assigned(Pessoa), Pessoa.Id, ''),
         IfThen(Assigned(User), User.Id, ''),
         Trim(lbe_search.Text));
end;

procedure TformCompraList.calculaTotais;
var
  NfsEmitidas,
  NfsEmitir: Extended;
  TotalNumeroSelecionados: Extended;
  vClone: TFDMemTable;
begin
  lbl_numero_lancamentos.Caption:= fdmt_compras.RecordCount.ToString();

  NfsEmitidas:= 0;
  NfsEmitir:= 0;
  TotalSelecionadas:= 0;
  TotalNumeroSelecionados:= 0;

  vClone:= TFDMemTable.Create(nil);
  vClone.CloneCursor(fdmt_compras);
  vClone.DisableControls;
  vClone.First;
  while not vClone.Eof do
  begin
    if (vClone.FieldByName('NFE_ID').AsString <> '') then
      NfsEmitidas:= NfsEmitidas + vClone.FieldByName('TOTAL').AsExtended
    else
      NfsEmitir:= NfsEmitir + vClone.FieldByName('TOTAL').AsExtended;

    if (vClone.FieldByName('CHECK').AsInteger >= 1) then
    begin
      Inc(TotalSelecionadas);
      TotalNumeroSelecionados:= TotalNumeroSelecionados + vClone.FieldByName('TOTAL').AsExtended;
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

procedure TformCompraList.act_reimprimir_comprovanteExecute(Sender: TObject);
begin
  if not (fdmt_compras.RecordCount >= 1) then Exit();
  if not THelper.Mensagem('Deseja reimprimir o comprovante?', 1) then Exit();

  try
    TCompra.imprimir(fdmt_comprasID.AsString);
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformCompraList.act_rollbackExecute(Sender: TObject);
begin
  Close;
end;

procedure TformCompraList.dbg_comprasDblClick(Sender: TObject);
begin
  if not (TDBGrid(Sender).DataSource.Dataset.RecordCount >= 1) then
    Exit();

  if (TDBGrid(Sender).DataSource.DataSet.FieldByName('NFE_ID').AsString <> '') then
    Exit();

  TDBGrid(Sender).DataSource.DataSet.Edit;
  TDBGrid(Sender).DataSource.DataSet.FieldByName('CHECK').AsInteger:=
    IfThen(TDBGrid(Sender).DataSource.DataSet.FieldByName('CHECK').AsInteger >= 1,0,1);
  TDBGrid(Sender).DataSource.DataSet.Post;

  calculaTotais();
end;

procedure TformCompraList.dbg_comprasDrawColumnCell(Sender: TObject;
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

  if not fdmt_compras.IsEmpty then
  begin
    if (Column.FieldName = 'NFE_ID') then
    begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      if (fdmt_comprasNFE_ID.AsString <> '') then
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 7, Rect.Top + 1, 20);
    end
    else if Column.FieldName = 'CHECK' then
    begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      if (fdmt_comprasCHECK.AsInteger >= 1) then
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 7, Rect.Top + 1, 5)
      else
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 7, Rect.Top + 1, 2);
    end;
  end;
end;

procedure TformCompraList.edb_pessoaLeftButtonClick(Sender: TObject);
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

procedure TformCompraList.edb_pessoaRightButtonClick(Sender: TObject);
begin
  FreeAndNil(Pessoa);
  TButtonedEdit(Sender).Text:= '';
end;

procedure TformCompraList.edb_userChange(Sender: TObject);
begin
  TButtonedEdit(Sender).LeftButton.Visible:= (Trim(TButtonedEdit(Sender).Text) = '');
  TButtonedEdit(Sender).RightButton.Visible:= (Trim(TButtonedEdit(Sender).Text) <> '');
end;

procedure TformCompraList.edb_userLeftButtonClick(Sender: TObject);
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

procedure TformCompraList.edb_userRightButtonClick(Sender: TObject);
begin
  FreeAndNil(User);
  TButtonedEdit(Sender).Text:= '';
end;

procedure TformCompraList.exportarToNf(Id: string);
var
  vForm: TformNfeList;
  vNfe: TNfe;
  vCompraId: string;
begin
  if (Id = EmptyStr) then
    Exit();

  vCompraId:= fdmt_comprasID.AsString;
  TAuthService.NfeId:= TNfe.compraToNfe(vCompraId, Id);
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

procedure TformCompraList.FormCreate(Sender: TObject);
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

procedure TformCompraList.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Pessoa);
  FreeAndNil(User);
end;

procedure TformCompraList.lbe_searchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    13: list(dtp_start.Date,
             dtp_end.Date,
             IfThen(Assigned(Pessoa), Pessoa.Id, ''),
             IfThen(Assigned(User), User.Id, ''),
             Trim(lbe_search.Text));
    38: begin
      fdmt_compras.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_compras.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformCompraList.list(pDtInicial,
                               pDtFinal: TDate;
                               pPessoaId,
                               pUserId,
                               pSearch: string);
begin
  TCompra.list(1,
               pDtInicial,
               pDtFinal,
               pPessoaId,
               pUserId,
               pSearch,
               fdmt_compras);

  calculaTotais();
end;

procedure TformCompraList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_search.Focused and
    not dtp_start.Focused and
    not dtp_end.Focused then lbe_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
