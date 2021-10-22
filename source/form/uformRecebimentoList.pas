unit uformRecebimentoList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, System.Actions, Vcl.ActnList,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.DateUtils,
  Vcl.ImgList, Vcl.Menus, Vcl.Imaging.pngimage, Vcl.DBCtrls, System.Math,
  System.StrUtils, Datasnap.DBClient, Conta, Categoria, Pessoa;

type
  TformRecebimentoList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_recebimento: TButton;
    pnl_body: TPanel;
    pnl_search: TPanel;
    lbe_search: TLabeledEdit;
    dtp_end: TDateTimePicker;
    dtp_start: TDateTimePicker;
    dbg_recebimentos: TDBGrid;
    bvl_3: TBevel;
    btn_rollback: TButton;
    btn_recebimento_store: TButton;
    btn_recebimento_update: TButton;
    acl_recebimentos: TActionList;
    fdmt_recebimentos: TFDMemTable;
    ds_recebimentos: TDataSource;
    tmr_focus: TTimer;
    act_rollback: TAction;
    act_recebimento_store: TAction;
    act_recebimento_update: TAction;
    act_recebimento_boleto: TAction;
    act_recebimento_destroy: TAction;
    fdmt_recebimentosID: TStringField;
    fdmt_recebimentosDATA: TDateField;
    fdmt_recebimentosCATEGORIA: TStringField;
    fdmt_recebimentosDESCRICAO: TStringField;
    fdmt_recebimentosPESSOA: TStringField;
    fdmt_recebimentosVALOR: TFloatField;
    fdmt_recebimentosSITUACAO: TStringField;
    fdmt_recebimentosBOLETO: TStringField;
    ppm_recebimento: TPopupMenu;
    btn_recebimento_destroy: TButton;
    pnl_totais: TPanel;
    bvl_4: TBevel;
    pnl_totais_left: TPanel;
    pnl_totais_right: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    lbl_total_recebidas: TLabel;
    lbl_recebidas: TLabel;
    lbl_total_receber: TLabel;
    lbl_total_vencidas: TLabel;
    lbl_total_recebimentos: TLabel;
    lbl_receber: TLabel;
    lbl_vencidas: TLabel;
    lbl_recebimentos: TLabel;
    Panel3: TPanel;
    lbl_numero_lancamentos: TLabel;
    lbl_numero_lancamentos_selecionados: TLabel;
    lbl_total_lancamentos_selecionados: TLabel;
    Panel4: TPanel;
    lbl_lancamentos: TLabel;
    lbl_lancamentos_selecionados: TLabel;
    lbl_lancamentos_selecionados_total: TLabel;
    Bevel1: TBevel;
    fdmt_recebimentosSELECIONADO: TStringField;
    act_recebimento_boleto_remover: TAction;
    act_recebimento_boleto_email: TAction;
    ENVIARBOLETONOEMAIL: TMenuItem;
    IMPRIMIRBOLETO: TMenuItem;
    REMOVERBOLETO: TMenuItem;
    act_recebimento_recebido: TAction;
    act_recebimento_recibo: TAction;
    DEFINIRCOMORECEBIDO: TMenuItem;
    EMITIRRECIBO: TMenuItem;
    fdmt_recebimentosEMAIL: TStringField;
    cbx_filtro: TComboBox;
    edb_pessoa: TButtonedEdit;
    edb_categoria: TButtonedEdit;
    cbx_situacao: TComboBox;
    edb_conta: TButtonedEdit;
    lb_filtro: TLabel;
    lb_start: TLabel;
    lb_end: TLabel;
    lb_situacao: TLabel;
    lb_conta: TLabel;
    lb_categoria: TLabel;
    lb_pessoa: TLabel;
    act_imprimir: TAction;
    cbx_boleto: TComboBox;
    lb_boleto: TLabel;
    procedure dbg_recebimentosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure lbe_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_recebimento_storeExecute(Sender: TObject);
    procedure act_recebimento_updateExecute(Sender: TObject);
    procedure act_recebimento_destroyExecute(Sender: TObject);
    procedure tmr_focusTimer(Sender: TObject);
    procedure acl_recebimentosUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure act_recebimento_boletoExecute(Sender: TObject);
    procedure act_recebimento_boleto_removerExecute(Sender: TObject);
    procedure act_recebimento_boleto_emailExecute(Sender: TObject);
    procedure dbg_recebimentosDblClick(Sender: TObject);
    procedure act_recebimento_recebidoExecute(Sender: TObject);
    procedure act_recebimento_reciboExecute(Sender: TObject);
    procedure edb_pessoaLeftButtonClick(Sender: TObject);
    procedure edb_pessoaChange(Sender: TObject);
    procedure edb_pessoaRightButtonClick(Sender: TObject);
    procedure edb_categoriaLeftButtonClick(Sender: TObject);
    procedure edb_contaLeftButtonClick(Sender: TObject);
    procedure edb_contaRightButtonClick(Sender: TObject);
    procedure edb_categoriaRightButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure act_imprimirExecute(Sender: TObject);
  private
    { Private declarations }
    Conta: TConta;
    Categoria: TCategoria;
    Pessoa: TPessoa;
    vFiltro: Integer;

    procedure list(pFiltro,
                   pSituacao,
                   pBoleto: Integer;
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
  formRecebimentoList: TformRecebimentoList;

implementation

uses
  Recebimento, AuthService, uformRecebimentoCreateEdit, Boleto, Helper,
  udmRepository, uformPessoaList, uformCategoriaList, uformContaList;

{$R *.dfm}

{ TformRecebimentoList }

procedure TformRecebimentoList.acl_recebimentosUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_recebimento_update.Enabled:= (fdmt_recebimentos.RecordCount >= 1);
  act_recebimento_destroy.Enabled:= act_recebimento_update.Enabled;
  act_recebimento_recebido.Enabled:= (fdmt_recebimentos.RecordCount >= 1) and (fdmt_recebimentosSITUACAO.AsString = 'A');
  act_recebimento_recibo.Enabled:= (fdmt_recebimentos.RecordCount >= 1) and (fdmt_recebimentosSITUACAO.AsString = 'F');
  act_recebimento_boleto.Enabled:= act_recebimento_recebido.Enabled;
  act_recebimento_boleto_email.Enabled:= act_recebimento_boleto.Enabled and (fdmt_recebimentosBOLETO.AsString <> '');
  act_recebimento_boleto_remover.Enabled:= act_recebimento_boleto_email.Enabled; 
  
  tmr_focus.Enabled:= (not lbe_search.Focused);
end;

procedure TformRecebimentoList.act_imprimirExecute(Sender: TObject);
begin
  TRecebimento.imprimir(cbx_filtro.ItemIndex,
                        cbx_situacao.ItemIndex,
                        cbx_boleto.ItemIndex,
                        dtp_start.Date,
                        dtp_end.Date,
                        IfThen(Assigned(Conta), Conta.Id, ''),
                        IfThen(Assigned(Categoria), Categoria.Id, ''),
                        IfThen(Assigned(Pessoa), Pessoa.Id, ''),
                        Trim(lbe_search.Text));
end;

procedure TformRecebimentoList.act_recebimento_boletoExecute(Sender: TObject);
var
  vRecebimento: TRecebimento;
begin
  try
    vRecebimento:= nil;
    try
      TBoleto.recebimentoToBoleto(fdmt_recebimentosID.AsString);
      vRecebimento:= TRecebimento.find(fdmt_recebimentosID.AsString);
      fdmt_recebimentos.Edit();
      fdmt_recebimentosBOLETO.AsString:= Trim(vRecebimento.Boleto);
      fdmt_recebimentos.Post();
    except on e: Exception do
      THelper.Mensagem(e.Message);
    end;
  finally
    if Assigned(vRecebimento) then FreeAndNil(vRecebimento);
  end;
end;

procedure TformRecebimentoList.act_recebimento_destroyExecute(Sender: TObject);
begin
  if TRecebimento.remove(fdmt_recebimentosID.AsString) then
  begin
    fdmt_recebimentos.Delete;
    calculaTotais();
  end;
end;

procedure TformRecebimentoList.act_recebimento_recebidoExecute(Sender: TObject);
var
  vRecebido: TRecebimento;
begin
  try
    try
      vRecebido:= TRecebimento.find(fdmt_recebimentosID.AsString);
      if not Assigned(vRecebido) then
        raise Exception.Create('Falha ao consultar dados do recebimento.');

      vRecebido.Recebimento:= Now();
      vRecebido.Situacao:= 'F';
      vRecebido.save();

      fdmt_recebimentos.Edit();
      fdmt_recebimentosDATA.AsDateTime:= vRecebido.Recebimento;
      fdmt_recebimentosSITUACAO.AsString:= vRecebido.Situacao;
      fdmt_recebimentos.Post();

      calculaTotais();
    except on e: Exception do
      THelper.Mensagem('Falha ao tentar receber. Erro: ' + e.Message);
    end;
  finally
    FreeAndNil(vRecebido);
  end;
end;

procedure TformRecebimentoList.act_recebimento_reciboExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TformRecebimentoList.act_recebimento_storeExecute(Sender: TObject);
begin
  TAuthService.RecebimentoId:= EmptyStr;
  try
    formRecebimentoCreateEdit:= TformRecebimentoCreateEdit.Create(nil);
    formRecebimentoCreateEdit.ShowModal;
  finally
    FreeAndNil(formRecebimentoCreateEdit);
  end;

  if (TAuthService.RecebimentoId <> EmptyStr) then
    listRefresh();
end;

procedure TformRecebimentoList.act_recebimento_updateExecute(Sender: TObject);
begin
  TAuthService.RecebimentoId:= fdmt_recebimentosID.AsString;
  try
    formRecebimentoCreateEdit:= TformRecebimentoCreateEdit.Create(nil);
    formRecebimentoCreateEdit.ShowModal;
  finally
    FreeAndNil(formRecebimentoCreateEdit);
  end;

  if (TAuthService.RecebimentoId <> EmptyStr) then
    listRefresh();
end;

procedure TformRecebimentoList.act_recebimento_boleto_emailExecute(
  Sender: TObject);
begin
  try
    TBoleto.enviarEmail(fdmt_recebimentosID.AsString);
    fdmt_recebimentos.Edit();
    fdmt_recebimentosEMAIL.AsString:= 'S';
    fdmt_recebimentos.Post();
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformRecebimentoList.act_recebimento_boleto_removerExecute(Sender: TObject);
begin
  if TBoleto.removeByRecebimentoId(fdmt_recebimentosID.AsString) then
  begin
    fdmt_recebimentos.Edit();
    fdmt_recebimentosBOLETO.AsString:= '';
    fdmt_recebimentos.Post;
  end;
end;

procedure TformRecebimentoList.act_rollbackExecute(Sender: TObject);
begin
  Close;
end;

procedure TformRecebimentoList.edb_categoriaLeftButtonClick(Sender: TObject);
var
  v_form: TformCategoriaList;
begin
  TAuthService.CategoriaId:= EmptyStr;
  TAuthService.TipoCategoria:= 'R';
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

procedure TformRecebimentoList.edb_categoriaRightButtonClick(Sender: TObject);
begin
  FreeAndNil(Categoria);
  TButtonedEdit(Sender).Text:= '';
end;

procedure TformRecebimentoList.edb_contaLeftButtonClick(Sender: TObject);
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

procedure TformRecebimentoList.edb_contaRightButtonClick(Sender: TObject);
begin
  FreeAndNil(Conta);
  TButtonedEdit(Sender).Text:= '';
end;

procedure TformRecebimentoList.edb_pessoaChange(Sender: TObject);
begin
  TButtonedEdit(Sender).LeftButton.Visible:= (Trim(TButtonedEdit(Sender).Text) = '');
  TButtonedEdit(Sender).RightButton.Visible:= (Trim(TButtonedEdit(Sender).Text) <> '');
end;

procedure TformRecebimentoList.edb_pessoaLeftButtonClick(Sender: TObject);
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

procedure TformRecebimentoList.edb_pessoaRightButtonClick(Sender: TObject);
begin
  FreeAndNil(Pessoa);
  TButtonedEdit(Sender).Text:= '';
end;

procedure TformRecebimentoList.calculaTotais();
var
  Recebidas,
  Receber,
  Vencidas: Extended;
  NumeroSelecionados: Integer;
  TotalNumeroSelecionados: Extended;
  vClone: TFDMemTable;
begin
  lbl_numero_lancamentos.Caption:= fdmt_recebimentos.RecordCount.ToString();

  Recebidas:= 0;
  Receber:= 0;
  Vencidas:= 0;
  NumeroSelecionados:= 0;
  TotalNumeroSelecionados:= 0;

  vClone:= TFDMemTable.Create(nil);
  vClone.CloneCursor(fdmt_recebimentos);
  vClone.DisableControls;
  vClone.First;
  while not vClone.Eof do
  begin
    if (vClone.FieldByName('SITUACAO').AsString = 'A') then
    begin
      Receber:= Receber + vClone.FieldByName('VALOR').AsExtended;
      if (vFiltro = 2) and (vClone.FieldByName('DATA').AsDateTime < Date) then
        Vencidas:= Vencidas + vClone.FieldByName('VALOR').AsExtended;
    end
    else if (vClone.FieldByName('SITUACAO').AsString = 'F') then
      Recebidas:= Recebidas + vClone.FieldByName('VALOR').AsExtended;

    if (vClone.FieldByName('SELECIONADO').AsString = 'S') then
    begin
      NumeroSelecionados:= NumeroSelecionados + 1;
      TotalNumeroSelecionados:= TotalNumeroSelecionados + vClone.FieldByName('VALOR').AsExtended;
    end;

    vClone.Next;
  end;
  vClone.Close;
  FreeAndNil(vClone);
  
  lbl_total_recebidas.Caption:= THelper.ExtendedToString(Recebidas);
  lbl_total_receber.Caption:= THelper.ExtendedToString(Receber);
  lbl_total_vencidas.Caption:= THelper.ExtendedToString(Vencidas);
  lbl_total_recebimentos.Caption:= THelper.ExtendedToString(Recebidas + Receber);
  lbl_numero_lancamentos_selecionados.Caption:= NumeroSelecionados.ToString();
  lbl_total_lancamentos_selecionados.Caption:= THelper.ExtendedToString(TotalNumeroSelecionados);
end;

procedure TformRecebimentoList.dbg_recebimentosDblClick(Sender: TObject);
begin
  if (TDBGrid(Sender).DataSource.Dataset.IsEmpty) then
    Exit();

  TDBGrid(Sender).DataSource.Dataset.Edit;
  TDBGrid(Sender).DataSource.Dataset.FieldByName('SELECIONADO').AsString:=
    IfThen(TDBGrid(Sender).DataSource.Dataset.FieldByName('SELECIONADO').AsString = 'S', 'N', 'S');
  TDBGrid(Sender).DataSource.Dataset.Post;

  calculaTotais();
end;

procedure TformRecebimentoList.dbg_recebimentosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  if (fdmt_recebimentosSITUACAO.AsString = 'A') and
     (vFiltro = 2) and
     (fdmt_recebimentosDATA.AsDateTime < Date) then
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

  if (TDBGrid(Sender).DataSource.DataSet.RecordCount >= 1) then
  begin
    if (Column.Field.FieldName = 'SITUACAO') then
    begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      if (fdmt_recebimentosSITUACAO.AsString = 'A') and
         (fdmt_recebimentosBOLETO.AsString <> '') then
      begin
        if (fdmt_recebimentosEMAIL.AsString = 'S') then
          dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas, Rect.Left + 10, Rect.Top + 1, 12)
        else
          dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas, Rect.Left + 10, Rect.Top + 1, 0);
      end
      else if (fdmt_recebimentosSITUACAO.AsString = 'F') then
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas, Rect.Left + 10, Rect.Top + 1, 1);
    end
    else if (Column.Field.FieldName = 'SELECIONADO') then
    begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      if (fdmt_recebimentosSELECIONADO.AsString = 'S') then
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas, Rect.Left + 10, Rect.Top + 1, 5)
      else
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas, Rect.Left + 10, Rect.Top + 1, 2);
    end;
  end;
end;

procedure TformRecebimentoList.FormCreate(Sender: TObject);
begin
  inherited;
  Conta:= nil;
  Categoria:= nil;
  Pessoa:= nil;

  cbx_filtro.ItemIndex:= 2;
  dtp_start.Date:= StartOfTheMonth(Now);
  dtp_end.Date:= EndOfTheMonth(now);
  cbx_situacao.ItemIndex:= 1;
  cbx_boleto.ItemIndex:= 0;

  list(cbx_filtro.ItemIndex,
       cbx_situacao.ItemIndex,
       cbx_boleto.ItemIndex,
       dtp_start.Date,
       dtp_end.Date,
       '',
       '',
       '',
       '');
end;

procedure TformRecebimentoList.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Conta);
  FreeAndNil(Categoria);
  FreeAndNil(Pessoa);
end;

procedure TformRecebimentoList.lbe_searchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN: list(cbx_filtro.ItemIndex,
                     cbx_situacao.ItemIndex,
                     cbx_boleto.ItemIndex,
                     dtp_start.Date,
                     dtp_end.Date,
                     IfThen(Assigned(Conta), Conta.Id, ''),
                     IfThen(Assigned(Categoria), Categoria.Id, ''),
                     IfThen(Assigned(Pessoa), Pessoa.Id, ''),
                     Trim(TCustomEdit(Sender).Text));
    38: begin
      fdmt_recebimentos.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_recebimentos.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformRecebimentoList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_search.Focused and
    not cbx_filtro.Focused and
    not dtp_start.Focused and
    not dtp_end.Focused and
    not cbx_situacao.Focused and
    not cbx_boleto.Focused then lbe_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

procedure TformRecebimentoList.list(pFiltro,
                                    pSituacao,
                                    pBoleto: Integer;
                                    pDtInicial,
                                    pDtFinal: TDate;
                                    pContaId,
                                    pCategoriaId,
                                    pPessoaId,
                                    pSearch: string);
begin
  TRecebimento.list(pFiltro,
                    pSituacao,
                    pBoleto,
                    pDtInicial,
                    pDtFinal,
                    pContaId,
                    pCategoriaId,
                    pPessoaId,
                    pSearch,
                    fdmt_recebimentos);

  vFiltro:= pFiltro;
  calculaTotais();
end;

procedure TformRecebimentoList.listRefresh;
begin
  list(cbx_filtro.ItemIndex,
       cbx_situacao.ItemIndex,
       cbx_boleto.ItemIndex,
       dtp_start.Date,
       dtp_end.Date,
       IfThen(Assigned(Conta), Conta.Id, ''),
       IfThen(Assigned(Categoria), Categoria.Id, ''),
       IfThen(Assigned(Pessoa), Pessoa.Id, ''),
       Trim(lbe_search.Text));
end;

end.
