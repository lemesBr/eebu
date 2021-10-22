unit uformTerminalCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Terminal, Conta, Categoria, Vcl.Mask,
  System.StrUtils;

type
  TformTerminalCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    btn_cancelar: TButton;
    btn_confirmar: TButton;
    acl_terminal: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    lbe_referencia: TLabeledEdit;
    edb_conta: TButtonedEdit;
    lb_conta: TLabel;
    edb_categoria: TButtonedEdit;
    lb_categoria: TLabel;
    bed_pessoa: TButtonedEdit;
    lb_pessoa: TLabel;
    lbe_parcelamento: TLabeledEdit;
    lbe_print_path: TLabeledEdit;
    bed_operacao_fiscal: TButtonedEdit;
    lbe_nfce_serie: TLabeledEdit;
    lbe_nfce_numero: TLabeledEdit;
    lbe_nfce_print_path: TLabeledEdit;
    lb_operacao_fiscal: TLabel;
    cbx_nfce_printer_model: TComboBox;
    lb_nfce_printer_model: TLabel;
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edb_contaChange(Sender: TObject);
    procedure edb_contaLeftButtonClick(Sender: TObject);
    procedure edb_contaRightButtonClick(Sender: TObject);
    procedure edb_categoriaRightButtonClick(Sender: TObject);
    procedure edb_categoriaLeftButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bed_pessoaLeftButtonClick(Sender: TObject);
    procedure bed_pessoaRightButtonClick(Sender: TObject);
    procedure bed_operacao_fiscalLeftButtonClick(Sender: TObject);
    procedure bed_operacao_fiscalRightButtonClick(Sender: TObject);
  private
    { Private declarations }
    Terminal: TTerminal;
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
  formTerminalCreateEdit: TformTerminalCreateEdit;

implementation

{$R *.dfm}

uses udmRepository, AuthService, Helper, uformContaList, uformCategoriaList,
  uformPessoaList, uformOperacaoFiscalList;

procedure TformTerminalCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.TerminalId:= EmptyStr;
  Close();
end;

procedure TformTerminalCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformTerminalCreateEdit.bed_operacao_fiscalLeftButtonClick(
  Sender: TObject);
var
  vF: TformOperacaoFiscalList;
begin
  TAuthService.OperacaoFiscalId:= EmptyStr;
  try
    vF:= TformOperacaoFiscalList.Create(nil);
    vF.Tag:= 1;
    vF.ShowModal;
  finally
    FreeAndNil(vF);
  end;

  if (TAuthService.OperacaoFiscalId <> EmptyStr) then
  begin
    Terminal.NfceOperacaoFiscalId:= TAuthService.OperacaoFiscalId;
    Terminal.NfceNatop:= Terminal.Nfce.Natop;
    bed_operacao_fiscal.Text:= Terminal.Nfce.Nome;
    bed_operacao_fiscal.Color:= clWhite;
    bed_operacao_fiscal.OnEnter:= nil;
  end;
end;

procedure TformTerminalCreateEdit.bed_operacao_fiscalRightButtonClick(
  Sender: TObject);
begin
  Terminal.NfceOperacaoFiscalId:= '';
  Terminal.NfceNatop:= '';
  TButtonedEdit(Sender).Text:= '';
end;

procedure TformTerminalCreateEdit.bed_pessoaLeftButtonClick(Sender: TObject);
var
  vF: TformPessoaList;
begin
  TAuthService.PessoaId:= EmptyStr;
  try
    vF:= TformPessoaList.Create(nil);
    vF.Tag:= 1;
    vF.ShowModal;
  finally
    FreeAndNil(vF);
  end;

  if (TAuthService.PessoaId <> EmptyStr) then
  begin
    Terminal.PessoaId:= TAuthService.PessoaId;
    bed_pessoa.Text:= Terminal.Pessoa.Nome;
    bed_pessoa.Color:= clWhite;
    bed_pessoa.OnEnter:= nil;
  end;
end;

procedure TformTerminalCreateEdit.bed_pessoaRightButtonClick(Sender: TObject);
begin
  Terminal.PessoaId:= '';
  TButtonedEdit(Sender).Text:= '';
end;

procedure TformTerminalCreateEdit.edb_categoriaLeftButtonClick(Sender: TObject);
var
  vF: TformCategoriaList;
begin
  TAuthService.CategoriaId:= EmptyStr;
  TAuthService.TipoCategoria:= 'R';
  try
    vF:= TformCategoriaList.Create(nil);
    vF.Tag:= 1;
    vF.ShowModal;
  finally
    FreeAndNil(vF);
  end;

  if (TAuthService.CategoriaId <> EmptyStr) then
  begin
    Terminal.CategoriaId:= TAuthService.CategoriaId;
    edb_categoria.Text:= Terminal.Categoria.Nome;
    edb_categoria.Color:= clWhite;
    edb_categoria.OnEnter:= nil;
  end;
end;

procedure TformTerminalCreateEdit.edb_categoriaRightButtonClick(
  Sender: TObject);
begin
  Terminal.CategoriaId:= '';
  TButtonedEdit(Sender).Text:= '';
end;

procedure TformTerminalCreateEdit.edb_contaChange(Sender: TObject);
begin
  TButtonedEdit(Sender).LeftButton.Visible:= (Trim(TButtonedEdit(Sender).Text) = '');
  TButtonedEdit(Sender).RightButton.Visible:= (Trim(TButtonedEdit(Sender).Text) <> '');
end;

procedure TformTerminalCreateEdit.edb_contaLeftButtonClick(Sender: TObject);
var
  vF: TformContaList;
begin
  TAuthService.ContaId:= EmptyStr;
  try
    vF:= TformContaList.Create(nil);
    vF.Tag:= 1;
    vF.ShowModal;
  finally
    FreeAndNil(vF);
  end;

  if (TAuthService.ContaId <> EmptyStr) then
  begin
    Terminal.ContaId:= TAuthService.ContaId;
    edb_conta.Text:= Terminal.Conta.Nome;
    edb_conta.Color:= clWhite;
    edb_conta.OnEnter:= nil;
  end;
end;

procedure TformTerminalCreateEdit.edb_contaRightButtonClick(Sender: TObject);
begin
  Terminal.ContaId:= '';
  TButtonedEdit(Sender).Text:= '';
end;

procedure TformTerminalCreateEdit.EdtToObj;
begin
  Terminal.Parcelamento:= StrToIntDef(lbe_parcelamento.Text, 0);
  Terminal.PrintPath:= lbe_print_path.Text;
  Terminal.NfceSerie:= StrToIntDef(lbe_nfce_serie.Text, 1);
  Terminal.NfceNumero:= StrToIntDef(lbe_nfce_numero.Text, 1);
  Terminal.NfcePrintPath:= Trim(lbe_nfce_print_path.Text);
  Terminal.NfcePrinterModel:= cbx_nfce_printer_model.ItemIndex;
end;

procedure TformTerminalCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  if (TAuthService.TerminalId = EmptyStr) then Terminal:= TTerminal.Create
  else Terminal:= TTerminal.find(TAuthService.TerminalId);
  ObjToEdt;
end;

procedure TformTerminalCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Terminal);
end;

procedure TformTerminalCreateEdit.ObjToEdt;
begin
  cbx_nfce_printer_model.ItemIndex:= 0;
  if (Terminal.Id = '') then Exit();

  lbe_referencia.Text:= Terminal.Referencia.ToString();
  if Assigned(Terminal.Conta) then
    edb_conta.Text:= Terminal.Conta.Nome;
  if Assigned(Terminal.Categoria) then
    edb_categoria.Text:= Terminal.Categoria.Nome;
  if Assigned(Terminal.Pessoa) then
    bed_pessoa.Text:= Terminal.Pessoa.Nome;
  lbe_parcelamento.Text:= IfThen(Terminal.Parcelamento > 0, Terminal.Parcelamento.ToString(), '');
  lbe_print_path.Text:= Terminal.PrintPath;
  if Assigned(Terminal.Nfce) then
    bed_operacao_fiscal.Text:= Terminal.Nfce.Nome;
  lbe_nfce_serie.Text:= Terminal.NfceSerie.ToString();
  lbe_nfce_numero.Text:= Terminal.NfceNumero.ToString();
  lbe_nfce_print_path.Text:= Terminal.NfcePrintPath;
  cbx_nfce_printer_model.ItemIndex:= Terminal.NfcePrinterModel;
end;

procedure TformTerminalCreateEdit.onEnter(Sender: TObject);
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
  end
  else if (Sender is TButtonedEdit) then
  begin
    TButtonedEdit(Sender).Color:= clWhite;
    TButtonedEdit(Sender).OnEnter:= nil;
  end;
end;

procedure TformTerminalCreateEdit.save;
begin
  EdtToObj();
  try
    if not validaCamposObrigatorios() then Exit();

    if Terminal.save() then
    begin
      TAuthService.TerminalId:= Terminal.Id;
      Close();
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformTerminalCreateEdit.setRequired(Obj: TObject);
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
  end
  else if (Obj is TButtonedEdit) then
  begin
    TButtonedEdit(Obj).Color:= $00AAAAFF;
    TButtonedEdit(Obj).OnEnter:= onEnter;
  end;
end;

function TformTerminalCreateEdit.validaCamposObrigatorios: Boolean;
var
  vRequired: Integer;
begin
  vRequired:= 0;
  if (Trim(edb_conta.Text) = '') then
  begin
    setRequired(edb_conta);
    Inc(vRequired);
  end;

  if (Trim(edb_categoria.Text) = '') then
  begin
    setRequired(edb_categoria);
    Inc(vRequired);
  end;

  if (Trim(bed_pessoa.Text) = '') then
  begin
    setRequired(bed_pessoa);
    Inc(vRequired);
  end;

  if (StrToIntDef(lbe_parcelamento.Text, 0) = 0) then
  begin
    setRequired(lbe_parcelamento);
    Inc(vRequired);
  end;

  if (Trim(lbe_print_path.Text) = '') then
  begin
    setRequired(lbe_print_path);
    Inc(vRequired);
  end;

  Result:= (vRequired = 0);
  if (not Result) then  THelper.Mensagem('Preencha os dados obrigatórios.');
end;

end.
