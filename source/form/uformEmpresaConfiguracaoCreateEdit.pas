unit uformEmpresaConfiguracaoCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, EmpresaConfiguracao, Pessoa;

type
  TformEmpresaConfiguracaoCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_confirmar: TButton;
    pnl_body: TPanel;
    btn_cancelar: TButton;
    acl_empresa_configuracao: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    lbe_venda_conta: TLabeledEdit;
    lbe_venda_categoria: TLabeledEdit;
    lbe_print_path: TLabeledEdit;
    lbe_nfce_operacao_fiscal: TLabeledEdit;
    lbe_nfe_operacao_fiscal: TLabeledEdit;
    lbe_parcelamento: TLabeledEdit;
    lbe_print_mode: TLabeledEdit;
    bed_pessoa: TButtonedEdit;
    lb_pessoa: TLabel;
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure lbe_venda_contaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_venda_categoriaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbe_nfce_operacao_fiscalKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_nfe_operacao_fiscalKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bed_pessoaChange(Sender: TObject);
    procedure bed_pessoaLeftButtonClick(Sender: TObject);
    procedure bed_pessoaRightButtonClick(Sender: TObject);
  private
    { Private declarations }
    EmpresaConfiguracao: TEmpresaConfiguracao;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();
  public
    { Public declarations }
  end;

var
  formEmpresaConfiguracaoCreateEdit: TformEmpresaConfiguracaoCreateEdit;

implementation

{$R *.dfm}

uses udmRepository, uformContaList, AuthService, uformCategoriaList, Helper,
  uformOperacaoFiscalList, uformPessoaList;

procedure TformEmpresaConfiguracaoCreateEdit.act_cancelarExecute(
  Sender: TObject);
begin
  Close;
end;

procedure TformEmpresaConfiguracaoCreateEdit.act_confirmarExecute(
  Sender: TObject);
begin
  save();
end;

procedure TformEmpresaConfiguracaoCreateEdit.bed_pessoaChange(Sender: TObject);
begin
  TButtonedEdit(Sender).LeftButton.Visible:= (Trim(TButtonedEdit(Sender).Text) = '');
  TButtonedEdit(Sender).RightButton.Visible:= (Trim(TButtonedEdit(Sender).Text) <> '');
end;

procedure TformEmpresaConfiguracaoCreateEdit.bed_pessoaLeftButtonClick(
  Sender: TObject);
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
    EmpresaConfiguracao.VendaPessoaDefault:= TAuthService.PessoaId;
    bed_pessoa.Text:= EmpresaConfiguracao.Pessoa.Nome;
  end;
end;

procedure TformEmpresaConfiguracaoCreateEdit.bed_pessoaRightButtonClick(
  Sender: TObject);
begin
  EmpresaConfiguracao.VendaPessoaDefault:= '';
  TButtonedEdit(Sender).Text:= '';
end;

procedure TformEmpresaConfiguracaoCreateEdit.EdtToObj;
begin
  EmpresaConfiguracao.Parcelamento:= StrToIntDef(lbe_parcelamento.Text,1);
  EmpresaConfiguracao.PrintPath:= lbe_print_path.Text;
  EmpresaConfiguracao.PrintMode:= StrToIntDef(lbe_print_mode.Text, 0);
end;

procedure TformEmpresaConfiguracaoCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  EmpresaConfiguracao:= TEmpresaConfiguracao.findByEmpresaId;
  if not Assigned(EmpresaConfiguracao) then
    EmpresaConfiguracao:= TEmpresaConfiguracao.Create;
  ObjToEdt();
end;

procedure TformEmpresaConfiguracaoCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(EmpresaConfiguracao);
end;

procedure TformEmpresaConfiguracaoCreateEdit.lbe_nfe_operacao_fiscalKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
var
  v_form: TformOperacaoFiscalList;
begin
  case Key of
    112: begin
      TAuthService.OperacaoFiscalId:= EmptyStr;
      try
        v_form:= TformOperacaoFiscalList.Create(nil);
        v_form.Tag:= 1;
        v_form.ShowModal;
      finally
        FreeAndNil(v_form);
      end;

      if (TAuthService.OperacaoFiscalId <> EmptyStr) then
      begin
        EmpresaConfiguracao.NfeOperacaoFiscalId:= TAuthService.OperacaoFiscalId;
        lbe_nfe_operacao_fiscal.Text:= EmpresaConfiguracao.Nfe.Nome;
      end;
    end;
  end;
end;

procedure TformEmpresaConfiguracaoCreateEdit.lbe_nfce_operacao_fiscalKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
var
  v_form: TformOperacaoFiscalList;
begin
  case Key of
    112: begin
      TAuthService.OperacaoFiscalId:= EmptyStr;
      try
        v_form:= TformOperacaoFiscalList.Create(nil);
        v_form.Tag:= 1;
        v_form.ShowModal;
      finally
        FreeAndNil(v_form);
      end;

      if (TAuthService.OperacaoFiscalId <> EmptyStr) then
      begin
        EmpresaConfiguracao.NfceOperacaoFiscalId:= TAuthService.OperacaoFiscalId;
        lbe_nfce_operacao_fiscal.Text:= EmpresaConfiguracao.Nfce.Nome;
      end;
    end;
  end;
end;

procedure TformEmpresaConfiguracaoCreateEdit.lbe_venda_categoriaKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
var
  v_form: TformCategoriaList;
begin
  case Key of
    112: begin
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
        EmpresaConfiguracao.VendaCategoriaId:= TAuthService.CategoriaId;
        lbe_venda_categoria.Text:= EmpresaConfiguracao.Categoria.Nome;
      end;
    end;
  end;
end;

procedure TformEmpresaConfiguracaoCreateEdit.lbe_venda_contaKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
var
  v_form: TformContaList;
begin
  case Key of
    112: begin
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
        EmpresaConfiguracao.VendaContaId:= TAuthService.ContaId;
        lbe_venda_conta.Text:= EmpresaConfiguracao.Conta.Nome;
      end;
    end;
  end;
end;

procedure TformEmpresaConfiguracaoCreateEdit.ObjToEdt;
begin
  if (EmpresaConfiguracao.Id = EmptyStr) then Exit();

  if Assigned(EmpresaConfiguracao.Conta) then
  lbe_venda_conta.Text:= EmpresaConfiguracao.Conta.Nome;
  if Assigned(EmpresaConfiguracao.Categoria) then
  lbe_venda_categoria.Text:= EmpresaConfiguracao.Categoria.Nome;
  if Assigned(EmpresaConfiguracao.Pessoa) then
  bed_pessoa.Text:= EmpresaConfiguracao.Pessoa.Nome;
  if Assigned(EmpresaConfiguracao.Nfce) then
  lbe_nfce_operacao_fiscal.Text:= EmpresaConfiguracao.Nfce.Nome;
  if Assigned(EmpresaConfiguracao.Nfe) then
  lbe_nfe_operacao_fiscal.Text:= EmpresaConfiguracao.Nfe.Nome;
  lbe_parcelamento.Text:= EmpresaConfiguracao.Parcelamento.ToString();
  lbe_print_path.Text:= EmpresaConfiguracao.PrintPath;
  lbe_print_mode.Text:= EmpresaConfiguracao.PrintMode.ToString();
end;

procedure TformEmpresaConfiguracaoCreateEdit.save;
begin
  EdtToObj;
  try
    if EmpresaConfiguracao.save() then
    begin
      TAuthService.getAuthenticatedConfig(True);
      Close;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

end.
