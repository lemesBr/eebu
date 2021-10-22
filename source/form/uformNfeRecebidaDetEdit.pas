unit uformNfeRecebidaDetEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  NfeDet, System.Actions, Vcl.ActnList;

type
  TformNfeRecebidaDetEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    lbe_xprod: TLabeledEdit;
    lbe_ucom: TLabeledEdit;
    lbe_qcom: TLabeledEdit;
    bvl_3: TBevel;
    btn_cancelar: TButton;
    btn_confirmar: TButton;
    act_det: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    lbe_item: TLabeledEdit;
    lbe_item_unidade: TLabeledEdit;
    lbe_conversor: TLabeledEdit;
    lbe_qtd_convertida: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure lbe_itemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_conversorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    vDet: TNfeDet;
    procedure ObjToEdt;
    procedure save();
  public
    { Public declarations }
  end;

var
  formNfeRecebidaDetEdit: TformNfeRecebidaDetEdit;

implementation

{$R *.dfm}

uses CustomEditHelper, AuthService, Helper, udmRepository, uformItemList,
  uformItemUnidadeConversorList;

procedure TformNfeRecebidaDetEdit.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.NfeDetId:= EmptyStr;
  Close;
end;

procedure TformNfeRecebidaDetEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformNfeRecebidaDetEdit.FormCreate(Sender: TObject);
begin
  inherited;
  lbe_qcom.Tag:= 1;
  TCustomEdit(lbe_qcom).EditFloat();
  lbe_qtd_convertida.Tag:= 1;
  TCustomEdit(lbe_qtd_convertida).EditFloat();
  vDet:= TNfeDet.find(TAuthService.NfeDetId);
  pnl_header.Caption:= 'AJUSTE DO ITEM - ' + vDet.Xprod;
  ObjToEdt();
end;

procedure TformNfeRecebidaDetEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(vDet);
end;

procedure TformNfeRecebidaDetEdit.lbe_conversorKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  v_form: TformItemUnidadeConversorList;
begin
  case Key of
    112:begin
      if (vDet.ItemId = EmptyStr) then Exit();
      TAuthService.ItemId:= vDet.ItemId;
      TAuthService.UnidadeConversaoId:= EmptyStr;
      try
        v_form:= TformItemUnidadeConversorList.Create(nil);
        v_form.Tag:= 1;
        v_form.ShowModal;
      finally
        FreeAndNil(v_form);
      end;

      if (TAuthService.UnidadeConversaoId <> EmptyStr) then
      begin
        vDet.UnidadeConversaoId:= TAuthService.UnidadeConversaoId;
        lbe_conversor.Text:=
          '1 ' + vDet.CONVERSOR.Unidade +
          ' -> ' + THelper.ExtendedToString(vDet.CONVERSOR.FatorConversao, False) +
          ' ' + vDet.CONVERSOR.Item.Unidade.Unidade;

        lbe_qtd_convertida.Text:= THelper.ExtendedToString(vDet.Qcom * vDet.CONVERSOR.FatorConversao,False);
      end;
    end;
  end;
end;

procedure TformNfeRecebidaDetEdit.lbe_itemKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  v_form: TformItemList;
begin
  case Key of
    112:begin
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
        vDet.ItemId:= TAuthService.ItemId;
        lbe_item.Text:= vDet.ITEM.Nome;
        lbe_item_unidade.Text:= vDet.ITEM.Unidade.Unidade;
      end;
    end;
  end;
end;

procedure TformNfeRecebidaDetEdit.ObjToEdt;
begin
  lbe_xprod.Text:= vDet.Xprod;
  lbe_ucom.Text:= vDet.Ucom;
  lbe_qcom.Text:= THelper.ExtendedToString(vDet.Qcom,False);

  if (vDet.ItemId <> EmptyStr) then
  begin
    lbe_item.Text:= vDet.ITEM.Nome;
    lbe_item_unidade.Text:= vDet.ITEM.Unidade.Unidade;
  end;

  if (vDet.UnidadeConversaoId <> EmptyStr) then
  begin
    lbe_conversor.Text:=
      '1 ' + vDet.CONVERSOR.Unidade +
      ' ' + THelper.ExtendedToString(vDet.CONVERSOR.FatorConversao, False) +
      ' ' + vDet.CONVERSOR.Item.Unidade.Unidade;

    lbe_qtd_convertida.Text:= THelper.ExtendedToString(vDet.Qcom * vDet.CONVERSOR.FatorConversao,False);
  end;
end;

procedure TformNfeRecebidaDetEdit.save;
begin
  try
    if vDet.save() then
    begin
      vDet.rememberItem();
      TAuthService.NfeDetId:= vDet.Id;
      Close;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

end.
