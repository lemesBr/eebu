unit uformItemUnidadeConversorCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, UnidadeConversao;

type
  TformItemUnidadeConversorCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    lbe_item: TLabeledEdit;
    lbe_item_unidade: TLabeledEdit;
    lbe_ucom: TLabeledEdit;
    lbe_fator_conversao: TLabeledEdit;
    act_conversor: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    btn_cancelar: TButton;
    btn_confirmar: TButton;
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    UnidadeConversao: TUnidadeConversao;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();
  public
    { Public declarations }
  end;

var
  formItemUnidadeConversorCreateEdit: TformItemUnidadeConversorCreateEdit;

implementation

{$R *.dfm}

uses udmRepository, CustomEditHelper, AuthService, Helper;

procedure TformItemUnidadeConversorCreateEdit.act_cancelarExecute(
  Sender: TObject);
begin
  TAuthService.UnidadeConversaoId:= EmptyStr;
  Close;
end;

procedure TformItemUnidadeConversorCreateEdit.act_confirmarExecute(
  Sender: TObject);
begin
  save();
end;

procedure TformItemUnidadeConversorCreateEdit.EdtToObj;
begin
  UnidadeConversao.Unidade:= lbe_ucom.Text;
  UnidadeConversao.FatorConversao:= THelper.StringToExtended(lbe_fator_conversao.Text);
end;

procedure TformItemUnidadeConversorCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  lbe_fator_conversao.Tag:= 1;
  TCustomEdit(lbe_fator_conversao).EditFloat();

  if TAuthService.UnidadeConversaoId = EmptyStr then
  begin
    UnidadeConversao:= TUnidadeConversao.Create;
    UnidadeConversao.ItemId:= TAuthService.ItemId;
  end
  else
    UnidadeConversao:= TUnidadeConversao.find(TAuthService.UnidadeConversaoId);

  ObjToEdt;
end;

procedure TformItemUnidadeConversorCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(UnidadeConversao);
end;

procedure TformItemUnidadeConversorCreateEdit.ObjToEdt;
begin
  lbe_item.Text:= UnidadeConversao.Item.Nome;
  lbe_ucom.Text:= UnidadeConversao.Unidade;
  lbe_item_unidade.Text:= UnidadeConversao.Item.Unidade.Unidade;
  lbe_fator_conversao.Text:= THelper.ExtendedToString(UnidadeConversao.FatorConversao,False);
end;

procedure TformItemUnidadeConversorCreateEdit.save;
begin
  EdtToObj;
  try
    if UnidadeConversao.save() then
    begin
      TAuthService.UnidadeConversaoId:= UnidadeConversao.Id;
      Close;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

end.
