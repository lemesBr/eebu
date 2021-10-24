unit uformItemCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Item, Vcl.ComCtrls, System.StrUtils, System.Math, System.Actions, Vcl.ActnList,
  Vcl.Mask;

type
  TformItemCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_item_header: TPanel;
    pnl_item_footer: TPanel;
    btn_confirmar: TButton;
    pnl_item_body: TPanel;
    btn_cancelar: TButton;
    lbe_nome: TLabeledEdit;
    lbe_referencia: TLabeledEdit;
    lbe_ean: TLabeledEdit;
    lbe_ncm: TLabeledEdit;
    lbe_extipi: TLabeledEdit;
    lbe_unidade: TLabeledEdit;
    lbe_ean_tributavel: TLabeledEdit;
    lbe_unidade_tributave: TLabeledEdit;
    cbx_tipo_item: TComboBox;
    lbe_codigo_genero: TLabeledEdit;
    lbe_codigo_servico: TLabeledEdit;
    lbe_aliquota_icms: TLabeledEdit;
    lbe_cest: TLabeledEdit;
    lbe_preco_compra: TLabeledEdit;
    lbe_preco_venda: TLabeledEdit;
    lbe_estoque_disponivel: TLabeledEdit;
    lbe_estoque_minimo: TLabeledEdit;
    lbe_estoque_maximo: TLabeledEdit;
    lbe_estoque_ideal: TLabeledEdit;
    lbe_grupo_tributario: TLabeledEdit;
    acl_item: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    lb_tipo_item: TLabel;
    lbe_percentual_lucro: TLabeledEdit;
    lbe_valor_lucro: TLabeledEdit;
    bvl_3: TBevel;
    bvl_4: TBevel;
    Button1: TButton;
    act_clone: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbe_unidadeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_unidade_tributaveKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_grupo_tributarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_ncmKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure acl_itemUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure act_cloneExecute(Sender: TObject);
  private
    { Private declarations }
    Item: TItem;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();

    procedure setRequired(Obj: TObject);
    procedure onEnter(Sender: TObject);
    function validaCamposObrigatorios(vtype: Integer = 0): Boolean;

    procedure onChange(Sender: TObject);
    procedure onExit(Sender: TObject);
  public
    { Public declarations }
  end;

var
  formItemCreateEdit: TformItemCreateEdit;

implementation

uses
  AuthService, uformUnidadeList, uformGrupoTributarioList, uformNcmIBPTax,
  udmRepository, CustomEditHelper, Helper, NfeDet;

{$R *.dfm}

{ TformItemCreateEdit }

procedure TformItemCreateEdit.acl_itemUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  lbe_estoque_disponivel.ReadOnly:= (Item.Id <> EmptyStr);
end;

procedure TformItemCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.ItemId:= EmptyStr;
  Close;
end;

procedure TformItemCreateEdit.act_cloneExecute(Sender: TObject);
begin
  inherited;
   if THelper.Mensagem('Você quer mesmo criar um clone deste produto?', 1) then
   begin
      TAuthService.ItemId:= EmptyStr;
      item.Id:= EmptyStr;
      Item.nextReferencia(0);
      save();
   end;
end;

procedure TformItemCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformItemCreateEdit.EdtToObj;
begin
  Item.Referencia:= StrToIntDef(lbe_referencia.Text, 0);
  Item.Ean:= lbe_ean.Text;
  Item.Nome:= lbe_nome.Text;
  Item.Ncm:= lbe_ncm.Text;
  Item.Extipi:= lbe_extipi.Text;
  Item.EanTributavel:= lbe_ean_tributavel.Text;
  case cbx_tipo_item.ItemIndex of
    0: Item.TipoItem:= '00';
    1: Item.TipoItem:= '01';
    2: Item.TipoItem:= '02';
    3: Item.TipoItem:= '03';
    4: Item.TipoItem:= '04';
    5: Item.TipoItem:= '05';
    6: Item.TipoItem:= '06';
    7: Item.TipoItem:= '07';
    8: Item.TipoItem:= '07';
    9: Item.TipoItem:= '09';
    10: Item.TipoItem:= '10';
    11: Item.TipoItem:= '99';
  end;
  Item.CodigoGenero:= lbe_codigo_genero.Text;
  Item.CodigoServico:= lbe_codigo_servico.Text;
  Item.AliquotaIcms:= THelper.StringToExtended(lbe_aliquota_icms.Text);
  Item.Cest:= lbe_cest.Text;
  Item.PrecoCompra:= THelper.StringToExtended(lbe_preco_compra.Text);
  Item.PrecoVenda:= THelper.StringToExtended(lbe_preco_venda.Text);
  Item.EstoqueDisponivel:= THelper.StringToExtended(lbe_estoque_disponivel.Text);
  Item.EstoqueMinimo:= THelper.StringToExtended(lbe_estoque_minimo.Text);
  Item.EstoqueIdeal:= THelper.StringToExtended(lbe_estoque_ideal.Text);
  Item.EstoqueMaximo:= THelper.StringToExtended(lbe_estoque_maximo.Text);
end;

procedure TformItemCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  TCustomEdit(lbe_preco_compra).EditFloat();
  TCustomEdit(lbe_preco_venda).EditFloat();
  TCustomEdit(lbe_percentual_lucro).EditFloat();
  TCustomEdit(lbe_valor_lucro).EditFloat();
  TCustomEdit(lbe_aliquota_icms).EditFloat();
  lbe_estoque_disponivel.Tag:= 1;
  TCustomEdit(lbe_estoque_disponivel).EditFloat();
  lbe_estoque_minimo.Tag:= 1;
  TCustomEdit(lbe_estoque_minimo).EditFloat();
  lbe_estoque_ideal.Tag:= 1;
  TCustomEdit(lbe_estoque_ideal).EditFloat();
  lbe_estoque_maximo.Tag:= 1;
  TCustomEdit(lbe_estoque_maximo).EditFloat();

  lbe_preco_venda.OnEnter:= onEnter;
  lbe_preco_venda.OnExit:= onExit;
  lbe_percentual_lucro.OnEnter:= onEnter;
  lbe_percentual_lucro.OnExit:= onExit;
  lbe_valor_lucro.OnEnter:= onEnter;
  lbe_valor_lucro.OnExit:= onExit;

  if (TAuthService.ItemId = EmptyStr) then Item:= TItem.Create
  else Item:= TItem.find(TAuthService.ItemId);
  ObjToEdt;
end;

procedure TformItemCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Item);
end;

procedure TformItemCreateEdit.FormShow(Sender: TObject);
begin
  if (Self.Tag = 1) then
    validaCamposObrigatorios(1);
end;

procedure TformItemCreateEdit.lbe_grupo_tributarioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  v_form: TformGrupoTributarioList;
begin
  if (Key = 112) then
  begin
    TAuthService.GrupoTributarioId:= EmptyStr;
    try
      v_form:= TformGrupoTributarioList.Create(nil);
      v_form.Tag:= 1;
      v_form.ShowModal;
    finally
      FreeAndNil(v_form);
    end;

    if (TAuthService.GrupoTributarioId <> EmptyStr) then
    begin
      Item.GrupoTributarioId:= TAuthService.GrupoTributarioId;
      lbe_grupo_tributario.Text:= Item.GrupoTributario.Nome;
    end;
  end;
end;

procedure TformItemCreateEdit.lbe_ncmKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  v_form: TformNcmIBPTax;
begin
  if (Key = 112) then
  begin
    TAuthService.Ncm:= EmptyStr;
    try
      v_form:= TformNcmIBPTax.Create(nil);
      v_form.Tag:= 1;
      v_form.ShowModal;
    finally
      FreeAndNil(v_form);
    end;

    if (TAuthService.Ncm <> EmptyStr) then
    begin
      Item.Ncm:= TAuthService.Ncm;
      lbe_ncm.Text:= Item.ObjNcm.Ncm;
    end;
  end;
end;

procedure TformItemCreateEdit.lbe_unidadeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  v_form: TformUnidadeList;
begin
  if (Key = 112) then
  begin
    TAuthService.UnidadeId:= EmptyStr;
    try
      v_form:= TformUnidadeList.Create(nil);
      v_form.Tag:= 1;
      v_form.ShowModal;
    finally
      FreeAndNil(v_form);
    end;

    if (TAuthService.UnidadeId <> EmptyStr) then
    begin
      Item.UnidadeId:= TAuthService.UnidadeId;
      lbe_unidade.Text:= Item.Unidade.Nome;
      if (Item.UnidadeTributavelId = EmptyStr) then
      begin
        Item.UnidadeTributavelId:= TAuthService.UnidadeId;
        lbe_unidade_tributave.Text:= Item.UnidadeTributave.Nome;
      end;
    end;
  end;
end;

procedure TformItemCreateEdit.lbe_unidade_tributaveKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  v_form: TformUnidadeList;
begin
  if (Key = 112) then
  begin
    TAuthService.UnidadeId:= EmptyStr;
    try
      v_form:= TformUnidadeList.Create(nil);
      v_form.Tag:= 1;
      v_form.ShowModal;
    finally
      FreeAndNil(v_form);
    end;

    if (TAuthService.UnidadeId <> EmptyStr) then
    begin
      Item.UnidadeTributavelId:= TAuthService.UnidadeId;
      lbe_unidade_tributave.Text:= Item.UnidadeTributave.Nome;
    end;
  end;
end;

procedure TformItemCreateEdit.ObjToEdt;
var
  vDet: TNfeDet;
begin
  if (Item.Id = EmptyStr) then
  begin
    pnl_item_header.Caption:= 'NOVO ITEM';
    lbe_referencia.Text:= Item.Referencia.ToString();
    if (TAuthService.NfeDetId <> EmptyStr) then
    begin
      if THelper.Mensagem('Deseja preencher os campos com dados do item da nota?', 1) then
      begin
        vDet:= TNfeDet.find(TAuthService.NfeDetId);
        if Assigned(vDet) then
        begin
          lbe_nome.Text:= vDet.Xprod;
          lbe_ean.Text:= vDet.Cean;
          Item.Ncm:= vDet.Ncm;
          if Assigned(Item.ObjNcm) then
            lbe_ncm.Text:= Item.ObjNcm.Ncm
          else
            Item.Ncm:= EmptyStr;
          lbe_extipi.Text:= vDet.Extipi;
          lbe_ean_tributavel.Text:= vDet.Ceantrib;
          lbe_cest.Text:= vDet.Cest;
          lbe_preco_compra.Text:= THelper.ExtendedToString(
            vDet.Vprod + vDet.Vfrete + vDet.Vseg -
              vDet.Vdesc + vDet.Voutro);
          lbe_preco_venda.Text:= lbe_preco_compra.Text;
          FreeAndNil(vDet);
        end;
      end;
    end;
    Exit();
  end;

  pnl_item_header.Caption:= 'EDITAR ITEM';
  if (Item.GrupoTributarioId <> EmptyStr) then
  lbe_grupo_tributario.Text:= Item.GrupoTributario.Nome;
  lbe_referencia.Text:= Item.Referencia.ToString();
  lbe_ean.Text:= Item.Ean;
  lbe_nome.Text:= Item.Nome;
  if Assigned(Item.ObjNcm) then
  lbe_ncm.Text:= Item.ObjNcm.Ncm;
  lbe_extipi.Text:= Item.Extipi;
  if (Item.UnidadeId <> EmptyStr) then
  lbe_unidade.Text:= Item.Unidade.Nome;
  lbe_ean_tributavel.Text:= Item.EanTributavel;
  if (Item.UnidadeTributavelId <> EmptyStr) then
  lbe_unidade_tributave.Text:= Item.UnidadeTributave.Nome;
  cbx_tipo_item.ItemIndex:= IfThen(Item.TipoItem = '99',11,StrToIntDef(Item.TipoItem,0));
  lbe_codigo_genero.Text:= Item.CodigoGenero;
  lbe_codigo_servico.Text:= Item.CodigoServico;
  lbe_aliquota_icms.Text:= THelper.ExtendedToString(Item.AliquotaIcms);
  lbe_cest.Text:= Item.Cest;
  lbe_preco_compra.Text:= THelper.ExtendedToString(Item.PrecoCompra);
  lbe_preco_venda.Text:= THelper.ExtendedToString(Item.PrecoVenda);
  lbe_estoque_disponivel.Text:= THelper.ExtendedToString(Item.estoque, False);
  lbe_estoque_minimo.Text:= THelper.ExtendedToString(Item.EstoqueMinimo, False);
  lbe_estoque_ideal.Text:= THelper.ExtendedToString(Item.EstoqueIdeal, False);
  lbe_estoque_maximo.Text:= THelper.ExtendedToString(Item.EstoqueMaximo, False);
  onChange(lbe_preco_venda);
end;

procedure TformItemCreateEdit.onChange(Sender: TObject);
var
  vCompra,
  vVenda,
  vPercentualLucro,
  vValorLucro: Extended;
begin
  case AnsiIndexStr(TLabeledEdit(Sender).Name,[
                      'lbe_preco_venda',
                      'lbe_percentual_lucro',
                      'lbe_valor_lucro']) of
    0: begin
      vCompra:= THelper.StringToExtended(lbe_preco_compra.Text);
      vVenda:= THelper.StringToExtended(lbe_preco_venda.Text);
      vPercentualLucro:= THelper.TruncateValue(SimpleRoundTo(
        (((vVenda - vCompra) * 100) / vCompra)), 2);
      vValorLucro:= (vVenda - vCompra);
    end;
    1: begin
      vCompra:= THelper.StringToExtended(lbe_preco_compra.Text);
      vPercentualLucro:= THelper.StringToExtended(lbe_percentual_lucro.Text);
      vVenda:= THelper.TruncateValue(SimpleRoundTo(
        (vCompra + ((vCompra * vPercentualLucro) / 100))), 2);
      vValorLucro:= (vVenda - vCompra);
    end;
    2: begin
      vCompra:= THelper.StringToExtended(lbe_preco_compra.Text);
      vValorLucro:= THelper.StringToExtended(lbe_valor_lucro.Text);
      vVenda:= (vCompra + vValorLucro);
      vPercentualLucro:= THelper.TruncateValue(SimpleRoundTo(
        (((vVenda - vCompra) * 100) / vCompra)), 2);
    end;
  end;

  lbe_preco_venda.Text:= THelper.ExtendedToString(vVenda);
  lbe_percentual_lucro.Text:= THelper.ExtendedToString(vPercentualLucro);
  lbe_valor_lucro.Text:= THelper.ExtendedToString(vValorLucro);
end;

procedure TformItemCreateEdit.onEnter(Sender: TObject);
begin
  if (Sender is TLabeledEdit) then
  begin
    TLabeledEdit(Sender).Color:= clWhite;

    case AnsiIndexStr(TLabeledEdit(Sender).Name,[
                      'lbe_preco_venda',
                      'lbe_percentual_lucro',
                      'lbe_valor_lucro']) of
      0,1,2: begin
        lbe_preco_venda.OnChange:= nil;
        lbe_percentual_lucro.OnChange:= nil;
        lbe_valor_lucro.OnChange:= nil;
        TLabeledEdit(Sender).OnChange:= onChange;
      end;
    end;
  end
  else if (Sender is TComboBox) then
    TComboBox(Sender).Color:= clWhite;
end;

procedure TformItemCreateEdit.onExit(Sender: TObject);
begin
  lbe_preco_venda.OnChange:= nil;
  lbe_percentual_lucro.OnChange:= nil;
  lbe_valor_lucro.OnChange:= nil;
end;

procedure TformItemCreateEdit.save;
begin
  EdtToObj;
  try
    if validaCamposObrigatorios(Self.Tag) then
    begin
      if Item.validade() then
      begin
        if Item.save() then
        begin
          TAuthService.ItemId:= Item.Id;
          Close;
        end;
      end;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformItemCreateEdit.setRequired(Obj: TObject);
begin
  if (Obj is TLabeledEdit) then
  begin
    TLabeledEdit(Obj).Color:= $00AAAAFF;
    TLabeledEdit(Obj).OnEnter:= onEnter;
  end
  else if (Obj is TComboBox) then
  begin
    TComboBox(Obj).Color:= $00AAAAFF;
    TComboBox(Obj).OnEnter:= onEnter;
  end;
end;

function TformItemCreateEdit.validaCamposObrigatorios(vtype: Integer): Boolean;
var
  v_required: Integer;
begin
  v_required:= 0;
  case vtype of
    0,1: begin
      if (Trim(lbe_referencia.Text) = '') then
      begin
        setRequired(lbe_referencia);
        Inc(v_required);
      end;

      if (Trim(lbe_nome.Text) = '') then
      begin
        setRequired(lbe_nome);
        Inc(v_required);
      end;

      if (Trim(lbe_unidade.Text) = '') then
      begin
        setRequired(lbe_unidade);
        Inc(v_required);
      end;

      if (Trim(lbe_unidade_tributave.Text) = '') then
      begin
        setRequired(lbe_unidade_tributave);
        Inc(v_required);
      end;

      if (Trim(lbe_ncm.Text) = '') then
      begin
        setRequired(lbe_ncm);
        Inc(v_required);
      end;

      if (Trim(lbe_cest.Text) = '') then
      begin
        setRequired(lbe_cest);
        Inc(v_required);
      end;

      if (Trim(lbe_grupo_tributario.Text) = '') then
      begin
        setRequired(lbe_grupo_tributario);
        Inc(v_required);
      end;

      if (THelper.StringToExtended(lbe_preco_venda.Text) <= 0) then
      begin
        setRequired(lbe_preco_venda);
        Inc(v_required);
      end;
    end;
  end;

  Result:= (v_required = 0);
  if (not Result) then THelper.Mensagem('Preencha os dados obrigatórios do item.');
end;

end.
