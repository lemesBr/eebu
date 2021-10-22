unit uformCompraCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Actions, Vcl.ActnList, Compra, Item, System.Math;

type
  TformCompraCreateEdit = class(TformBase)
    acl_compra: TActionList;
    act_remover_item: TAction;
    act_cancelar: TAction;
    act_salvar_orcamento: TAction;
    act_prosseguir: TAction;
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
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_salvar_orcamento: TButton;
    btn_prosseguir: TButton;
    btn_cancelar: TButton;
    btn_remover_item: TButton;
    pnl_body: TPanel;
    bvl_3: TBevel;
    bvl_5: TBevel;
    bvl_4: TBevel;
    pnl_1: TPanel;
    lbe_competencia: TLabel;
    dtp_competencia: TDateTimePicker;
    lbe_pessoa: TLabeledEdit;
    lbe_referencia: TLabeledEdit;
    lbe_user: TLabeledEdit;
    pnl_3: TPanel;
    lbe_subtotal: TLabeledEdit;
    dbg_itens: TDBGrid;
    pnl_2: TPanel;
    lbe_item: TLabeledEdit;
    edt_item_nome: TEdit;
    lbe_item_preco: TLabeledEdit;
    lbe_item_qtde: TLabeledEdit;
    lbe_item_subtotal: TLabeledEdit;
    ds_itens: TDataSource;
    act_consultar_orcamento: TAction;
    btn_consultar_orcamento: TButton;
    procedure act_remover_itemExecute(Sender: TObject);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_salvar_orcamentoExecute(Sender: TObject);
    procedure act_prosseguirExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure acl_compraUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure dbg_itensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbe_itemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_item_qtdeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_pessoaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_userKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_item_precoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure act_consultar_orcamentoExecute(Sender: TObject);
  private
    { Private declarations }
    Item: TItem;
    procedure ObjToEdt();
    procedure EdtToObj();
    procedure save();
    procedure setItem(vtype: Integer = 0);
    procedure confirmarItem();
    procedure cleanItem();
    procedure findPessoa();
    procedure findItem();
    procedure findUser();
    procedure calcTotal();
    procedure onChance(Sender: TObject);

    function validaCamposObrigatorios(): Boolean;
  public
    { Public declarations }
  end;

var
  formCompraCreateEdit: TformCompraCreateEdit;

implementation

uses
  Helper, AuthService, CompraItem, uformItemList, uformPessoaList,
  uformUserList, CustomEditHelper, uformCompraFinalizar, Nfe,
  uformCompraItensAjuste, uformCompraOrcamentoList;

{$R *.dfm}

procedure TformCompraCreateEdit.act_prosseguirExecute(Sender: TObject);
var
  vFM: TformCompraItensAjuste;
begin
  lbe_item.SetFocus();
  EdtToObj();
  try
    if not validaCamposObrigatorios() then Exit();

    try
      vFM:= TformCompraItensAjuste.Create(nil);
      vFM.ShowModal();
    finally
      FreeAndNil(vFM);
    end;

    if (TAuthService.CompraId <> EmptyStr) then
      Close();

  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformCompraCreateEdit.act_consultar_orcamentoExecute(Sender: TObject);
var
  v_form: TformCompraOrcamentoList;
begin
  lbe_item.SetFocus();
  try
    v_form:= TformCompraOrcamentoList.Create(nil);
    v_form.ShowModal();
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.CompraId <> EmptyStr) then
  begin
    FreeAndNil(TAuthService.Compra);
    TAuthService.Compra:= TCompra.find(TAuthService.CompraId);
    ObjToEdt();
  end;
end;

procedure TformCompraCreateEdit.acl_compraUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  lbe_pessoa.Enabled:= (TAuthService.NfeId = EmptyStr);
  act_remover_item.Enabled:= (fdmt_itens.RecordCount >= 1) and
                             (TAuthService.NfeId = EmptyStr);

  act_consultar_orcamento.Enabled:= (TAuthService.NfeId = EmptyStr);

  act_salvar_orcamento.Enabled:= (fdmt_itens.RecordCount >= 1) and
                                  Assigned(TAuthService.Compra) and
                                 (TAuthService.Compra.Situacao = 'A') and
                                 (TAuthService.NfeId = EmptyStr);

  act_prosseguir.Enabled:= (fdmt_itens.RecordCount >= 1);
end;

procedure TformCompraCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  lbe_item.SetFocus();
  if (fdmt_itens.RecordCount = 0) or THelper.Mensagem('Deseja realmente cancelar?', 1) then
  begin
    TAuthService.NfeId:= EmptyStr;
    TAuthService.CompraId:= EmptyStr;
    Close();
  end;
end;

procedure TformCompraCreateEdit.act_salvar_orcamentoExecute(Sender: TObject);
begin
  lbe_item.SetFocus();
  if THelper.Mensagem('Deseja salvar orçamento?', 1) then
    save();
end;

procedure TformCompraCreateEdit.act_remover_itemExecute(Sender: TObject);
begin
  lbe_item.SetFocus();
  if THelper.Mensagem('Deseja realmente remover o item selecionado?', 1) then
  begin
    fdmt_itens.Delete();
    calcTotal();
  end;
end;

procedure TformCompraCreateEdit.calcTotal;
var
  vSubtotal,
  vAcrescimo,
  vDesconto,
  vTotal: Currency;
begin
  vSubtotal:= 0;
  vAcrescimo:= 0;
  vDesconto:= 0;
  vTotal:= 0;

  with fdmt_itens do
  begin
    DisableControls();
    First();
    while not Eof do
    begin
      vSubtotal:= (vSubtotal + fdmt_itensSUBTOTAL.AsCurrency);
      vAcrescimo:= (vAcrescimo + fdmt_itensACRESCIMO.AsCurrency);
      vDesconto:= (vDesconto + fdmt_itensDESCONTO.AsCurrency);
      vTotal:= (vTotal + fdmt_itensTOTAL.AsCurrency);
      Next;
    end;
    EnableControls();
  end;

  lbe_subtotal.Text:= THelper.ExtendedToString(vSubtotal);

  TAuthService.Compra.Subtotal:= vSubtotal;
  TAuthService.Compra.Acrescimo:= vAcrescimo;
  TAuthService.Compra.Desconto:= vDesconto;
  TAuthService.Compra.Total:= vTotal;
end;

procedure TformCompraCreateEdit.cleanItem;
begin
  lbe_item.Text:= EmptyStr;
  edt_item_nome.Text:= EmptyStr;
  lbe_item_preco.Text:= '0,00';
  lbe_item_preco.ReadOnly:= True;
  lbe_item_qtde.Text:= '0,000';
  lbe_item_qtde.ReadOnly:= True;
  lbe_item_subtotal.Text:= '0,00';

  FreeAndNil(Item);

  lbe_item.SetFocus();
end;

procedure TformCompraCreateEdit.confirmarItem;
begin
  if not Assigned(Item) then
  begin
    cleanItem();
    Exit();
  end;

  if (THelper.StringToExtended(lbe_item_preco.Text) <= 0) then Exit();
  if (THelper.StringToExtended(lbe_item_qtde.Text) <= 0) then Exit();
  if (TAuthService.NfeId <> EmptyStr) then Exit();

  fdmt_itens.Append();
  fdmt_itensITEM_ID.AsString:= Item.Id;
  fdmt_itensITEM_REFERENCIA.AsInteger:= Item.Referencia;
  fdmt_itensITEM_NOME.AsString:= Item.Nome;
  if Assigned(Item.Unidade) then
    fdmt_itensITEM_UNIDADE.AsString:= Item.Unidade.Unidade;
  fdmt_itensUNITARIO.AsExtended:= THelper.StringToExtended(lbe_item_preco.Text);
  fdmt_itensQTDE.AsExtended:= THelper.StringToExtended(lbe_item_qtde.Text);
  fdmt_itensSUBTOTAL.AsExtended:= (fdmt_itensUNITARIO.AsExtended * fdmt_itensQTDE.AsExtended);
  fdmt_itensACRESCIMO.AsExtended:= 0;
  fdmt_itensDESCONTO.AsExtended:= 0;
  fdmt_itensTOTAL.AsExtended:= 0;
  fdmt_itens.Post();
  cleanItem();
  calcTotal();
end;

procedure TformCompraCreateEdit.dbg_itensDrawColumnCell(Sender: TObject;
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

procedure TformCompraCreateEdit.EdtToObj;
begin
  TAuthService.Compra.Referencia:= StrToIntDef(lbe_referencia.Text, 0);
  TAuthService.Compra.Competencia:= dtp_competencia.Date;
  TAuthService.Compra.Itens.Clear();
  with fdmt_itens do
  begin
    DisableControls();
    First();
    while not Eof do
    begin
       TAuthService.Compra.Itens.Add(TCompraItem.Create);
       with TAuthService.Compra.Itens.Last() do
       begin
         ItemId:= fdmt_itensITEM_ID.AsString;
         Unitario:= fdmt_itensUNITARIO.AsCurrency;
         Qtde:= fdmt_itensQTDE.AsCurrency;
         Subtotal:= fdmt_itensSUBTOTAL.AsCurrency;
         Acrescimo:= fdmt_itensACRESCIMO.AsCurrency;
         Desconto:= fdmt_itensDESCONTO.AsCurrency;
         Total:= (Subtotal + Acrescimo - Desconto);
       end;
       Next();
    end;
    EnableControls();
  end;
end;

procedure TformCompraCreateEdit.findItem;
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
    setItem();
  end;
end;

procedure TformCompraCreateEdit.findPessoa;
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
    TAuthService.Compra.PessoaId:= TAuthService.PessoaId;
    lbe_pessoa.Text:= TAuthService.Compra.Pessoa.Nome;
    lbe_pessoa.Color:= clWindow;
    lbe_item.SetFocus();
  end;
end;

procedure TformCompraCreateEdit.findUser;
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
    TAuthService.Compra.UserId:= TAuthService.UserId;
    lbe_user.Text:= TAuthService.Compra.User.Nome;
  end;
end;

procedure TformCompraCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  lbe_item_preco.OnChange:= onChance;
  TCustomEdit(lbe_item_preco).EditFloat();
  lbe_item_qtde.OnChange:= onChance;
  TCustomEdit(lbe_item_subtotal).EditFloat();
  TCustomEdit(lbe_subtotal).EditFloat();
  fdmt_itens.Open();

  if (TAuthService.CompraId = EmptyStr) then
  begin
     TAuthService.Compra:= TCompra.Create();
     TAuthService.Compra.Situacao:= 'A';
  end
  else
  begin
    TAuthService.Compra:= TCompra.find(TAuthService.CompraId);
  end;

  ObjToEdt();
end;

procedure TformCompraCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(TAuthService.Compra);
  FreeAndNil(Item);
end;

procedure TformCompraCreateEdit.FormShow(Sender: TObject);
begin
  lbe_item.SetFocus();
end;

procedure TformCompraCreateEdit.lbe_itemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    13: begin
      TCustomEdit(Sender).Text:= Trim(TCustomEdit(Sender).Text);
      if (fdmt_itens.RecordCount >= 1) and (TCustomEdit(Sender).Text = EmptyStr) then
      begin
        act_prosseguirExecute(Sender);
        Exit();
      end
      else if (TCustomEdit(Sender).Text = EmptyStr) then Exit();
      if Assigned(Item) then FreeAndNil(Item);
      Item:= TItem.findByReferencia(StrToIntDef(TCustomEdit(Sender).Text, 0));
      if Assigned(Item) then
      begin
        setItem();
        Exit();
      end;
      Item:= TItem.findByEan(TCustomEdit(Sender).Text);
      if Assigned(Item) then
      begin
        setItem();
        Exit();
      end;
      findItem();
    end;
    27: cleanItem();
    38: begin
      fdmt_itens.Prior();
      Key:= 35;
    end;
    40: begin
      fdmt_itens.Next();
      Key:= 35;
    end;
    112: findItem();
  end;
end;

procedure TformCompraCreateEdit.lbe_item_precoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    13: lbe_item_qtde.SetFocus();
    27: cleanItem();
  end;
end;

procedure TformCompraCreateEdit.lbe_item_qtdeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    13: confirmarItem();
    27: cleanItem();
  end;
end;

procedure TformCompraCreateEdit.lbe_pessoaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    13: lbe_item.SetFocus();
    112: findPessoa();
  end;
end;

procedure TformCompraCreateEdit.lbe_userKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    112: findUser();
  end;
end;

procedure TformCompraCreateEdit.ObjToEdt;
var
  vNfe: TNfe;
  I: Integer;
begin
  if (TAuthService.Compra.Id = EmptyStr) then
  begin
    lbe_referencia.Text:= TAuthService.Compra.nextReferencia().ToString();
    dtp_competencia.Date:= Now;
    TAuthService.Compra.UserId:= TAuthService.getAuthenticatedUserId;
    lbe_user.Text:= TAuthService.Compra.User.Nome;
    if (TAuthService.NfeId <> EmptyStr) then
    begin
      vNfe:= TNfe.find(TAuthService.NfeId);
      if Assigned(vNfe) then
      begin
        TAuthService.Compra.PessoaId:= vNfe.ParticipanteId;
        TAuthService.Compra.NfeId:= vNfe.Id;
        lbe_pessoa.Text:= TAuthService.Compra.Pessoa.Nome;
        for I:= 0 to Pred(vNfe.Det.Count) do
        begin
          fdmt_itens.Append();
          fdmt_itensITEM_ID.AsString:= vNfe.Det.Items[I].ItemId;
          fdmt_itensITEM_REFERENCIA.AsInteger:= vNfe.Det.Items[I].ITEM.Referencia;
          fdmt_itensITEM_NOME.AsString:= vNfe.Det.Items[I].ITEM.Nome;
          fdmt_itensITEM_UNIDADE.AsString:= vNfe.Det.Items[I].ITEM.Unidade.Unidade;
          fdmt_itensUNITARIO.AsExtended:=
            THelper.TruncateValue(SimpleRoundTo((
              (vNfe.Det.Items[I].Vprod + vNfe.Det.Items[I].Vfrete +
                vNfe.Det.Items[I].Vseg - vNfe.Det.Items[I].Vdesc +
                  vNfe.Det.Items[I].Voutro) / vNfe.Det.Items[I].Qcom) / vNfe.Det.Items[I].CONVERSOR.FatorConversao, -2), 2);
          fdmt_itensQTDE.AsExtended:=
            (vNfe.Det.Items[I].Qcom * vNfe.Det.Items[I].CONVERSOR.FatorConversao);
          fdmt_itensSUBTOTAL.AsExtended:= (fdmt_itensUNITARIO.AsExtended * fdmt_itensQTDE.AsExtended);
          fdmt_itensACRESCIMO.AsExtended:= 0;
          fdmt_itensDESCONTO.AsExtended:= 0;
          fdmt_itensTOTAL.AsExtended:= 0;
          fdmt_itens.Post();
        end;
        calcTotal();
        FreeAndNil(vNfe);
      end;
    end;
    Exit();
  end;

  lbe_user.Text:= TAuthService.Compra.User.Nome;
  lbe_pessoa.Text:= TAuthService.Compra.Pessoa.Nome;
  lbe_referencia.Text:= TAuthService.Compra.Referencia.ToString();
  dtp_competencia.Date:= TAuthService.Compra.Competencia;
  TCompra.listItens(TAuthService.Compra.Id,fdmt_itens);
  lbe_subtotal.Text:= THelper.ExtendedToString(TAuthService.Compra.Subtotal);
end;

procedure TformCompraCreateEdit.onChance(Sender: TObject);
var
  vPreco,
  vQtde,
  vSubtotal: Extended;
begin
  if not Assigned(Item) then Exit();

  vPreco:= THelper.StringToExtended(lbe_item_preco.Text);
  vQtde:= THelper.StringToExtended(lbe_item_qtde.Text);
  vSubtotal:= (vPreco * vQtde);

  lbe_item_subtotal.Text:= THelper.ExtendedToString(vSubtotal);
end;

procedure TformCompraCreateEdit.save;
begin
  EdtToObj();
  try
    if not validaCamposObrigatorios() then Exit();
    if TAuthService.Compra.save() then
    begin
      TAuthService.CompraId:= TAuthService.Compra.Id;
      Close();
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformCompraCreateEdit.setItem(vtype: Integer);
begin
  case vtype of
    0,
    1: begin
      lbe_item.Text:= Item.Referencia.ToString();
      edt_item_nome.Text:= Item.Nome;
      lbe_item_preco.Text:= THelper.ExtendedToString(Item.PrecoCompra);
      lbe_item_preco.ReadOnly:= False;
      lbe_item_qtde.Text:= '0,000';
      lbe_item_qtde.ReadOnly:= False;
      lbe_item_subtotal.Text:= THelper.ExtendedToString(Item.PrecoCompra * 1);

      lbe_item_preco.SetFocus();
    end;
  end;
end;

function TformCompraCreateEdit.validaCamposObrigatorios: Boolean;
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
