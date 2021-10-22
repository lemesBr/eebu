unit uformCartaoCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Cartao, CustomEditHelper, System.StrUtils,
  Vcl.Mask;

type
  TformCartaoCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    acl_cartao: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    btn_cancelar: TButton;
    btn_confirmar: TButton;
    lbe_nome: TLabeledEdit;
    cbx_modalidade: TComboBox;
    lbe_compensa_credito: TLabeledEdit;
    lbe_taxa_credito: TLabeledEdit;
    lbe_compensa_debito: TLabeledEdit;
    lbe_taxa_debito: TLabeledEdit;
    lb_modalidade: TLabel;
    lbe_pessoa: TLabeledEdit;
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbe_pessoaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    Cartao: TCartao;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();

    procedure setRequired(Obj: TObject);
    procedure onEnter(Sender: TObject);
    function validaCamposObrigatorios(): Boolean;
  public
    { Public declarations }
  end;

var
  formCartaoCreateEdit: TformCartaoCreateEdit;

implementation

{$R *.dfm}

uses udmRepository, AuthService, uformPessoaList, Helper;

procedure TformCartaoCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.CartaoId:= EmptyStr;
  Close();
end;

procedure TformCartaoCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformCartaoCreateEdit.EdtToObj;
begin
  Cartao.Nome:= lbe_nome.Text;
  case cbx_modalidade.ItemIndex of
    0: Cartao.Modalidade:= 'C';
    1: Cartao.Modalidade:= 'D';
    2: Cartao.Modalidade:= 'A';
    3: Cartao.Modalidade:= 'R';
    4: Cartao.Modalidade:= 'P';
    5: Cartao.Modalidade:= 'T';
    6: Cartao.Modalidade:= 'X';
  end;
  Cartao.CompensaCredito:= StrToIntDef(lbe_compensa_credito.Text, 1);
  Cartao.TaxaCredito:= THelper.StringToExtended(lbe_taxa_credito.Text);
  Cartao.CompensaDebito:= StrToIntDef(lbe_compensa_debito.Text, 1);
  Cartao.TaxaDebito:= THelper.StringToExtended(lbe_taxa_debito.Text);
end;

procedure TformCartaoCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  TCustomEdit(lbe_taxa_credito).EditFloat();
  TCustomEdit(lbe_taxa_debito).EditFloat();

  if (TAuthService.CartaoId = EmptyStr) then Cartao:= TCartao.Create
  else Cartao:= TCartao.find(TAuthService.CartaoId);
  ObjToEdt;
end;

procedure TformCartaoCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Cartao);
end;

procedure TformCartaoCreateEdit.lbe_pessoaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  v_form: TformPessoaList;
begin
  if (Key = 112) then
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
      Cartao.PessoaId:= TAuthService.PessoaId;
      lbe_pessoa.Text:= Cartao.Pessoa.Nome;
    end;
  end;
end;

procedure TformCartaoCreateEdit.ObjToEdt;
begin
  if (Cartao.Id = EmptyStr) then
  begin
    pnl_header.Caption:= 'NOVO CARTÃO';
    cbx_modalidade.ItemIndex:= 6;
    Exit();
  end;

  pnl_header.Caption:= 'EDITAR CARTÃO';
  lbe_nome.Text:= Cartao.Nome;
  cbx_modalidade.ItemIndex:= AnsiIndexStr(Cartao.Modalidade, ['C','D','A','R','P','T','X']);
  lbe_compensa_credito.Text:= Cartao.CompensaCredito.ToString();
  lbe_taxa_credito.Text:= THelper.ExtendedToString(Cartao.TaxaCredito);
  lbe_compensa_debito.Text:= Cartao.CompensaDebito.ToString();
  lbe_taxa_debito.Text:= THelper.ExtendedToString(Cartao.TaxaDebito);
  if Assigned(Cartao.Pessoa) then
  lbe_pessoa.Text:= Cartao.Pessoa.Nome;
end;

procedure TformCartaoCreateEdit.onEnter(Sender: TObject);
begin
  if (Sender is TLabeledEdit) then
  begin
    TLabeledEdit(Sender).Color:= clWhite;
    TLabeledEdit(Sender).OnEnter:= nil;
  end
  else if (Sender is TMaskEdit) then
  begin
    TMaskEdit(Sender).Color:= clWhite;
    TMaskEdit(Sender).OnEnter:= nil;
  end
  else if (Sender is TComboBox) then
  begin
    TComboBox(Sender).Color:= clWhite;
    TComboBox(Sender).OnEnter:= nil;
  end;
end;

procedure TformCartaoCreateEdit.save;
begin
  EdtToObj;
  try
    if validaCamposObrigatorios() then
    begin
      if Cartao.save() then
      begin
        TAuthService.CartaoId:= Cartao.Id;
        Close;
      end;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformCartaoCreateEdit.setRequired(Obj: TObject);
begin
  if (Obj is TLabeledEdit) then
  begin
    TLabeledEdit(Obj).Color:= $00AAAAFF;
    TLabeledEdit(Obj).OnEnter:= onEnter;
  end
  else if (Obj is TMaskEdit) then
  begin
    TMaskEdit(Obj).Color:= $00AAAAFF;
    TMaskEdit(Obj).OnEnter:= onEnter;
  end
  else if (Obj is TComboBox) then
  begin
    TComboBox(Obj).Color:= $00AAAAFF;
    TComboBox(Obj).OnEnter:= onEnter;
  end;
end;

function TformCartaoCreateEdit.validaCamposObrigatorios: Boolean;
var
  vRequired: Integer;
begin
  vRequired:= 0;
  if (Trim(lbe_nome.Text) = '') then
  begin
    setRequired(lbe_nome);
    Inc(vRequired);
  end;

  if (Trim(lbe_pessoa.Text) = '') then
  begin
    setRequired(lbe_pessoa);
    Inc(vRequired);
  end;

  Result:= (vRequired = 0);
  if (not Result) then  THelper.Mensagem('Preencha os dados obrigatórios do cartão.');
end;

end.
