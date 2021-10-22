unit uformVendaCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, System.Actions, Vcl.ActnList, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Venda, Item, System.Math,
  System.StrUtils;

type
  TformVendaCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_main: TPanel;
    lbe_pessoa: TLabeledEdit;
    lbe_referencia: TLabeledEdit;
    dtp_competencia: TDateTimePicker;
    pnl_categorias_search: TPanel;
    bvl_3: TBevel;
    Panel1: TPanel;
    Bevel1: TBevel;
    dbg_categorias: TDBGrid;
    lbe_subtotal: TLabeledEdit;
    Panel2: TPanel;
    Bevel2: TBevel;
    lbe_item: TLabeledEdit;
    edt_item_nome: TEdit;
    lbe_item_preco: TLabeledEdit;
    lbe_item_qtde: TLabeledEdit;
    lbe_item_subtotal: TLabeledEdit;
    fdmt_itens: TFDMemTable;
    ds_itens: TDataSource;
    acl_venda: TActionList;
    fdmt_itensITEM_ID: TStringField;
    fdmt_itensITEM_REFERENCIA: TIntegerField;
    fdmt_itensITEM_NOME: TStringField;
    fdmt_itensQTDE: TCurrencyField;
    fdmt_itensSUBTOTAL: TCurrencyField;
    fdmt_itensACRESCIMO: TCurrencyField;
    fdmt_itensDESCONTO: TCurrencyField;
    fdmt_itensTOTAL: TCurrencyField;
    act_cancelar: TAction;
    act_salvar_orcamento: TAction;
    btn_salvar_orcamento: TButton;
    btn_confirmar: TButton;
    btn_cancelar: TButton;
    act_confirmar: TAction;
    lbe_user: TLabeledEdit;
    fdmt_itensITEM_UNIDADE: TStringField;
    fdmt_itensUNITARIO: TCurrencyField;
    Label1: TLabel;
    btn_remover_item: TButton;
    act_remover_item: TAction;
    btn_consultar_orcamento: TButton;
    act_consultar_orcamento: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbe_pessoaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_userKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_itemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbg_categoriasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_salvar_orcamentoExecute(Sender: TObject);
    procedure lbe_item_qtdeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_item_qtdeExit(Sender: TObject);
    procedure lbe_item_qtdeChange(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure acl_vendaUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure act_remover_itemExecute(Sender: TObject);
    procedure act_consultar_orcamentoExecute(Sender: TObject);
  private
    { Private declarations }
    Item: TItem;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();
    procedure setItem(vtype: Integer = 0);
    procedure confirmarItem();
    procedure cleanItem();
    procedure findPessoa;
    procedure findItem;
    procedure findUser;
    procedure calcTotal;

    function validaCamposObrigatorios(): Boolean;
  public
    { Public declarations }
  end;

var
  formVendaCreateEdit: TformVendaCreateEdit;

implementation

uses
  AuthService, uformPessoaList, uformUserList, uformItemList, CustomEditHelper,
  Helper, VendaItem, uformVendaFinalizar, udmRepository, uformOrcamentoList;

{$R *.dfm}

procedure TformVendaCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  lbe_item.SetFocus;
  if (fdmt_itens.RecordCount = 0) or THelper.Mensagem('Deseja realmente cancelar?', 1) then
  begin
    TAuthService.VendaId:= EmptyStr;
    Close();
  end;
end;

procedure TformVendaCreateEdit.acl_vendaUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_remover_item.Enabled:= (fdmt_itens.RecordCount >= 1);
  act_salvar_orcamento.Enabled:= (fdmt_itens.RecordCount >= 1) and
    Assigned(TAuthService.Venda) and (TAuthService.Venda.Situacao = 'A');
  act_confirmar.Enabled:= (fdmt_itens.RecordCount >= 1);
end;

procedure TformVendaCreateEdit.act_remover_itemExecute(Sender: TObject);
begin
  lbe_item.SetFocus;
  if THelper.Mensagem('Deseja realmente remover o item selecionado?', 1) then
  begin
    fdmt_itens.Delete;
    calcTotal;
  end;
end;

procedure TformVendaCreateEdit.act_salvar_orcamentoExecute(Sender: TObject);
begin
  lbe_item.SetFocus;
  if THelper.Mensagem('Deseja salvar orçamento?', 1) then
    save();
end;

procedure TformVendaCreateEdit.act_confirmarExecute(Sender: TObject);
var
  v_form: TformVendaFinalizar;
begin
  EdtToObj;
  try
    if validaCamposObrigatorios() then
    begin
      try
        v_form:= TformVendaFinalizar.Create(nil);
        v_form.ShowModal;
      finally
        FreeAndNil(v_form);
      end;

      if (TAuthService.VendaId <> EmptyStr) then
        Close
      else
        lbe_item.SetFocus;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformVendaCreateEdit.act_consultar_orcamentoExecute(Sender: TObject);
var
  v_form: TformOrcamentoList;
begin
  lbe_item.SetFocus;
  try
    v_form:= TformOrcamentoList.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.VendaId <> EmptyStr) then
  begin
    FreeAndNil(TAuthService.Venda);
    TAuthService.Venda:= TVenda.find(TAuthService.VendaId);
    ObjToEdt;
  end;
end;

procedure TformVendaCreateEdit.calcTotal;
var
  SubTotal,
  Acrescimo,
  Desconto,
  Total: Currency;
begin
  SubTotal:= 0;
  Acrescimo:= 0;
  Desconto:= 0;
  Total:= 0;

  with fdmt_itens do
  begin
    DisableControls;
    First;
    while not Eof do
    begin
      SubTotal:= SubTotal + fdmt_itensSUBTOTAL.AsCurrency;
      Acrescimo:= Acrescimo + fdmt_itensACRESCIMO.AsCurrency;
      Desconto:= Desconto + fdmt_itensDESCONTO.AsCurrency;
      Total:= Total + fdmt_itensTOTAL.AsCurrency;
      Next;
    end;
    EnableControls;
  end;

  lbe_subtotal.Text:= THelper.ExtendedToString(SubTotal);

  TAuthService.Venda.Subtotal:= SubTotal;
  TAuthService.Venda.Acrescimo:= Acrescimo;
  TAuthService.Venda.Desconto:= Desconto;
  TAuthService.Venda.Total:= Total;
end;

procedure TformVendaCreateEdit.cleanItem;
begin
  lbe_item.Text:= EmptyStr;
  edt_item_nome.Text:= EmptyStr;
  lbe_item_preco.Text:= '0,00';
  lbe_item_qtde.Text:= '0,000';
  lbe_item_qtde.ReadOnly:= True;
  lbe_item_subtotal.Text:= '0,00';
  FreeAndNil(Item);
  lbe_item.SetFocus;
end;

procedure TformVendaCreateEdit.confirmarItem;
begin
  if not Assigned(Item) then
  begin
    cleanItem;
    Exit;
  end;

  if (THelper.StringToExtended(lbe_item_qtde.Text) <= 0) then Exit;

  fdmt_itens.Append;
  fdmt_itensITEM_ID.AsString:= Item.Id;
  fdmt_itensITEM_REFERENCIA.AsInteger:= Item.Referencia;
  fdmt_itensITEM_NOME.AsString:= Item.Nome;
  if Assigned(Item.Unidade) then
    fdmt_itensITEM_UNIDADE.AsString:= Item.Unidade.Unidade;
  fdmt_itensUNITARIO.AsExtended:= Item.PrecoVenda;
  fdmt_itensQTDE.AsExtended:= THelper.StringToExtended(lbe_item_qtde.Text);
  fdmt_itensSUBTOTAL.AsExtended:= fdmt_itensUNITARIO.AsExtended * fdmt_itensQTDE.AsExtended;
  fdmt_itensACRESCIMO.AsExtended:= 0;
  fdmt_itensDESCONTO.AsExtended:= 0;
  fdmt_itensTOTAL.AsExtended:= 0;
  fdmt_itens.Post;
  cleanItem;
  calcTotal;
end;

procedure TformVendaCreateEdit.dbg_categoriasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  If (gdSelected in state) then
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);
end;

procedure TformVendaCreateEdit.EdtToObj;
begin
  TAuthService.Venda.Referencia:= StrToIntDef(lbe_referencia.Text, 0);
  TAuthService.Venda.Competencia:= dtp_competencia.Date;
  TAuthService.Venda.Situacao:= 'A';
  TAuthService.Venda.Itens.Clear;
  with fdmt_itens do
  begin
    DisableControls;
    First;
    while not Eof do
    begin
       TAuthService.Venda.Itens.Add(TVendaItem.Create);
       TAuthService.Venda.Itens.Last.ItemId:= fdmt_itensITEM_ID.AsString;
       TAuthService.Venda.Itens.Last.Unitario:= fdmt_itensUNITARIO.AsCurrency;
       TAuthService.Venda.Itens.Last.Qtde:= fdmt_itensQTDE.AsCurrency;
       TAuthService.Venda.Itens.Last.Subtotal:= fdmt_itensSUBTOTAL.AsCurrency;
       TAuthService.Venda.Itens.Last.Acrescimo:= fdmt_itensACRESCIMO.AsCurrency;
       TAuthService.Venda.Itens.Last.Desconto:= fdmt_itensDESCONTO.AsCurrency;
       TAuthService.Venda.Itens.Last.Total:= fdmt_itensTOTAL.AsCurrency;
       Next;
    end;
    EnableControls;
  end;
end;

procedure TformVendaCreateEdit.findItem;
var
  v_form: TformItemList;
begin
  TAuthService.ItemId:= EmptyStr;
  try
    v_form:= TformItemList.Create(nil);
    v_form.Tag:= 1;
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.ItemId <> EmptyStr) then
  begin
    if Assigned(Item) then FreeAndNil(Item);
    Item:= TItem.find(TAuthService.ItemId);
    setItem;
  end;
end;

procedure TformVendaCreateEdit.findPessoa;
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
    TAuthService.Venda.PessoaId:= TAuthService.PessoaId;
    lbe_pessoa.Text:= TAuthService.Venda.Pessoa.Nome;
    lbe_pessoa.Color:= clWindow;
    lbe_item.SetFocus;
  end;
end;

procedure TformVendaCreateEdit.findUser;
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
    TAuthService.Venda.UserId:= TAuthService.UserId;
    lbe_user.Text:= TAuthService.Venda.User.Nome;
  end;
end;

procedure TformVendaCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  TCustomEdit(lbe_item_preco).EditFloat;
  TCustomEdit(lbe_item_subtotal).EditFloat;
  TCustomEdit(lbe_subtotal).EditFloat;
  fdmt_itens.Open;

  FreeAndNil(TAuthService.Venda);
  if TAuthService.VendaId = EmptyStr then TAuthService.Venda:= TVenda.Create
  else TAuthService.Venda:= TVenda.find(TAuthService.VendaId);
  ObjToEdt;
end;

procedure TformVendaCreateEdit.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(TAuthService.Venda);
  FreeAndNil(Item);
end;

procedure TformVendaCreateEdit.FormShow(Sender: TObject);
begin
  lbe_item.SetFocus;
end;

procedure TformVendaCreateEdit.lbe_itemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    13: begin
      TCustomEdit(Sender).Text:= Trim(TCustomEdit(Sender).Text);
      if (fdmt_itens.RecordCount >= 1) and (TCustomEdit(Sender).Text = EmptyStr) then
      begin
        act_confirmarExecute(Sender);
        Exit();
      end
      else if (TCustomEdit(Sender).Text = EmptyStr) then Exit();
      if Assigned(Item) then FreeAndNil(Item);
      Item:= TItem.findByReferencia(StrToIntDef(TCustomEdit(Sender).Text, 0));
      if Assigned(Item) then
      begin
        setItem;
        Exit();
      end;
      Item:= TItem.findByEan(TCustomEdit(Sender).Text);
      if Assigned(Item) then
      begin
        setItem();
        Exit();
      end;
      findItem;
    end;
    27: cleanItem;
    38: begin
      fdmt_itens.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_itens.Next;
      Key:= 35;
    end;
    112: findItem;
  end;
end;

procedure TformVendaCreateEdit.lbe_item_qtdeChange(Sender: TObject);
begin
  if not Assigned(Item) then Exit;
  lbe_item_subtotal.Text:= THelper.ExtendedToString(Item.PrecoVenda * THelper.StringToExtended(TCustomEdit(Sender).Text));
end;

procedure TformVendaCreateEdit.lbe_item_qtdeExit(Sender: TObject);
begin
  if Assigned(Item) then
  begin
    lbe_item.Text:= EmptyStr;
    edt_item_nome.Text:= EmptyStr;
    lbe_item_preco.Text:= '0,00';
    lbe_item_qtde.Text:= '0,000';
    lbe_item_qtde.ReadOnly:= True;
    lbe_item_subtotal.Text:= '0,00';
    FreeAndNil(Item);
  end;
end;

procedure TformVendaCreateEdit.lbe_item_qtdeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    13: confirmarItem();
    27: cleanItem;
  end;
end;

procedure TformVendaCreateEdit.lbe_pessoaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    13: lbe_item.SetFocus;
    112: findPessoa;
  end;
end;

procedure TformVendaCreateEdit.lbe_userKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    112: findUser;
  end;
end;

procedure TformVendaCreateEdit.ObjToEdt;
begin
  if (TAuthService.Venda.Id = EmptyStr) then
  begin
    TAuthService.Venda.Situacao:= 'A';
    lbe_referencia.Text:= TAuthService.Venda.nextReferencia().ToString();
    dtp_competencia.Date:= Now;
    TAuthService.Venda.UserId:= TAuthService.getAuthenticatedUserId;
    lbe_user.Text:= TAuthService.Venda.User.Nome;
    TAuthService.Venda.PessoaId:= TAuthService.getAuthenticatedConfig().VendaPessoaDefault;
    if Assigned(TAuthService.Venda.Pessoa) then
    lbe_pessoa.Text:= TAuthService.Venda.Pessoa.Nome;
    Exit();
  end;

  lbe_pessoa.Text:= TAuthService.Venda.Pessoa.Nome;
  lbe_referencia.Text:= TAuthService.Venda.Referencia.ToString();
  dtp_competencia.Date:= TAuthService.Venda.Competencia;
  TVenda.listItens(TAuthService.Venda.Id,fdmt_itens);
  lbe_user.Text:= TAuthService.Venda.User.Nome;
  lbe_subtotal.Text:= THelper.ExtendedToString(TAuthService.Venda.Subtotal);
end;

procedure TformVendaCreateEdit.save;
begin
  EdtToObj;
  try
    if validaCamposObrigatorios() then
      if TAuthService.Venda.save() then
      begin
        TAuthService.VendaId:= TAuthService.Venda.Id;
        Close;
      end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformVendaCreateEdit.setItem(vtype: Integer);
begin
  case vtype of
    0: begin
      lbe_item.Text:= Item.Referencia.ToString();
      edt_item_nome.Text:= Item.Nome;
      lbe_item_preco.Text:= THelper.ExtendedToString(Item.PrecoVenda);
      lbe_item_qtde.Text:= '1,000';
      lbe_item_qtde.ReadOnly:= False;
      lbe_item_qtde.SetFocus;
      lbe_item_subtotal.Text:= THelper.ExtendedToString(Item.PrecoVenda * 1);
    end;
    1: begin
      lbe_item.Text:= Item.Referencia.ToString();
      edt_item_nome.Text:= Item.Nome;
      lbe_item_preco.Text:= THelper.ExtendedToString(Item.PrecoVenda);
      lbe_item_qtde.Text:= '1,000';
      lbe_item_subtotal.Text:= THelper.ExtendedToString(Item.PrecoVenda * 1);

      confirmarItem();
    end;
  end;
end;

function TformVendaCreateEdit.validaCamposObrigatorios: Boolean;
begin
  Result:= True;
  if (Trim(lbe_pessoa.Text) = '') then
  begin
    Result:= False;
    lbe_pessoa.Color:= $00AAAAFF;
    lbe_pessoa.SetFocus;
  end;
end;

end.
