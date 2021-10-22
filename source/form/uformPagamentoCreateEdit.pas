unit uformPagamentoCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Pagamento, System.StrUtils, System.DateUtils,
  Vcl.ComCtrls, Vcl.Mask;

type
  TformPagamentoCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_confirmar: TButton;
    btn_cancelar: TButton;
    acl_pagamento: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    pnl_body: TPanel;
    pnl_left: TPanel;
    pnl_recebimento: TPanel;
    bvl_5: TBevel;
    lb_pagamento: TLabel;
    ckb_situacao: TCheckBox;
    lbe_descontos_taxas: TLabeledEdit;
    lbe_juros_multa: TLabeledEdit;
    lbe_valor_pago: TLabeledEdit;
    dtp_pagamento: TDateTimePicker;
    pnl_repetir: TPanel;
    bvl_4: TBevel;
    ckb_repetir: TCheckBox;
    cbx_ocorrencia: TComboBox;
    lbe_vezes: TLabeledEdit;
    pnl_edits: TPanel;
    lb_competencia: TLabel;
    lb_vencimento: TLabel;
    lbe_categoria: TLabeledEdit;
    lbe_conta: TLabeledEdit;
    lbe_descricao: TLabeledEdit;
    lbe_valor: TLabeledEdit;
    dtp_competencia: TDateTimePicker;
    dtp_vencimento: TDateTimePicker;
    pnl_right: TPanel;
    bvl_3: TBevel;
    lbe_pessoa: TLabeledEdit;
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbe_categoriaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_contaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_pessoaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_valorChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure acl_pagamentoUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
    Pagamento: TPagamento;
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
  formPagamentoCreateEdit: TformPagamentoCreateEdit;

implementation

uses
  Helper, CustomEditHelper, AuthService, uformCategoriaList, uformContaList, 
  uformPessoaList;

{$R *.dfm}

procedure TformPagamentoCreateEdit.acl_pagamentoUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  cbx_ocorrencia.Enabled:= ckb_repetir.Checked;
  lbe_vezes.Enabled:= ckb_repetir.Checked;
  dtp_pagamento.Enabled:= ckb_situacao.Checked;
  lbe_descontos_taxas.Enabled:= ckb_situacao.Checked;
  lbe_juros_multa.Enabled:= ckb_situacao.Checked;
  lbe_valor_pago.Enabled:= ckb_situacao.Checked;

  if (not ckb_repetir.Checked) and (lbe_vezes.Text <> '') then
    lbe_vezes.Text:= '';

  if ckb_situacao.Checked and (lbe_valor_pago.Text = '0,00') then
  begin
    lbe_valor_pago.Text:= lbe_valor.Text;
  end
  else if (not ckb_situacao.Checked) and (lbe_valor_pago.Text <> '0,00') then
  begin
    lbe_descontos_taxas.Text:= '0,00';
    lbe_juros_multa.Text:= '0,00';
    lbe_valor_pago.Text:= '0,00';
  end;
end;

procedure TformPagamentoCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.PagamentoId:= EmptyStr;
  Close;
end;

procedure TformPagamentoCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformPagamentoCreateEdit.EdtToObj;
begin
  Pagamento.Descricao:= lbe_descricao.Text;
  Pagamento.Competencia:= dtp_competencia.DateTime;
  Pagamento.Valor:= THelper.StringToExtended(lbe_valor.Text);
  Pagamento.DescontosTaxas:= THelper.StringToExtended(lbe_descontos_taxas.Text);
  Pagamento.JurosMulta:= THelper.StringToExtended(lbe_juros_multa.Text);

  Pagamento.ValorPago:= THelper.StringToExtended(lbe_valor_pago.Text);
  Pagamento.Vencimento:= dtp_vencimento.DateTime;
  Pagamento.Pagamento:= dtp_pagamento.DateTime;
  Pagamento.Situacao:= IfThen(ckb_situacao.Checked, 'F', 'A');
end;

procedure TformPagamentoCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  TCustomEdit(lbe_valor).EditFloat();
  TCustomEdit(lbe_descontos_taxas).EditFloat();
  TCustomEdit(lbe_juros_multa).EditFloat();
  TCustomEdit(lbe_valor_pago).EditFloat();

  if TAuthService.PagamentoId = EmptyStr then Pagamento:= TPagamento.Create
  else Pagamento:= TPagamento.find(TAuthService.PagamentoId);
  ObjToEdt;
end;

procedure TformPagamentoCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Pagamento);
end;

procedure TformPagamentoCreateEdit.lbe_categoriaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = 112) then
  begin
    TAuthService.CategoriaId:= EmptyStr;
    TAuthService.TipoCategoria:= 'D';
    try
      formCategoriaList:= TformCategoriaList.Create(nil);
      formCategoriaList.Tag:= 1;
      formCategoriaList.ShowModal;
    finally
      FreeAndNil(formCategoriaList);
    end;

    if (TAuthService.CategoriaId <> EmptyStr) then
    begin
      Pagamento.CategoriaId:= TAuthService.CategoriaId;
      lbe_categoria.Text:= Pagamento.Categoria.Nome;
    end;
  end;
end;

procedure TformPagamentoCreateEdit.lbe_contaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = 112) then
  begin
    TAuthService.ContaId:= EmptyStr;
    try
      formContaList:= TformContaList.Create(nil);
      formContaList.Tag:= 1;
      formContaList.ShowModal;
    finally
      FreeAndNil(formContaList);
    end;

    if (TAuthService.ContaId <> EmptyStr) then
    begin
      Pagamento.ContaId:= TAuthService.ContaId;
      lbe_conta.Text:= Pagamento.Conta.Nome;
    end;
  end;
end;

procedure TformPagamentoCreateEdit.lbe_pessoaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = 112) then
  begin
    TAuthService.PessoaId:= EmptyStr;
    try
      formPessoaList:= TformPessoaList.Create(nil);
      formPessoaList.Tag:= 1;
      formPessoaList.ShowModal;
    finally
      FreeAndNil(formPessoaList);
    end;

    if (TAuthService.PessoaId <> EmptyStr) then
    begin
      Pagamento.PessoaId:= TAuthService.PessoaId;
      lbe_pessoa.Text:= Pagamento.Pessoa.Nome;
    end;
  end;
end;

procedure TformPagamentoCreateEdit.lbe_valorChange(Sender: TObject);
var
  Pago: Extended;
begin
  if not ckb_situacao.Checked then Exit();

  Pago:= THelper.StringToExtended(lbe_valor.Text) -
    THelper.StringToExtended(lbe_descontos_taxas.Text) +
      THelper.StringToExtended(lbe_juros_multa.Text);

  lbe_valor_pago.Text:= THelper.ExtendedToString(Pago);
end;

procedure TformPagamentoCreateEdit.ObjToEdt;
begin
  if (Pagamento.Id = EmptyStr) then
  begin
    pnl_header.Caption:= 'NOVO PAGAMENTO';
    dtp_competencia.DateTime:= Now;
    dtp_vencimento.DateTime:= Now;
    dtp_pagamento.DateTime:= Now;
    Exit();
  end
  else
  begin
    pnl_header.Caption:= 'EDITAR PAGAMENTO';
    ckb_repetir.Checked:= False;
    pnl_repetir.Visible:= False;
  end;

  if Assigned(Pagamento.Conta) then
  lbe_conta.Text:= Pagamento.Conta.Nome;
  if Assigned(Pagamento.Pessoa) then
  lbe_pessoa.Text:= Pagamento.Pessoa.Nome;
  if Assigned(Pagamento.Categoria) then
  lbe_categoria.Text:= Pagamento.Categoria.Nome;
  lbe_descricao.Text:= Pagamento.Descricao;
  dtp_competencia.DateTime:= Pagamento.Competencia;
  lbe_valor.Text:= THelper.ExtendedToString(Pagamento.Valor);
  lbe_descontos_taxas.Text:= THelper.ExtendedToString(Pagamento.DescontosTaxas);
  lbe_juros_multa.Text:= THelper.ExtendedToString(Pagamento.JurosMulta);
  lbe_valor_pago.Text:= THelper.ExtendedToString(Pagamento.ValorPago);
  dtp_vencimento.DateTime:= Pagamento.Vencimento;
  ckb_situacao.Checked:= Pagamento.Situacao = 'F';
  if Pagamento.Situacao = 'A' then
    dtp_pagamento.DateTime:= Now
  else
    dtp_pagamento.DateTime:= Pagamento.Pagamento;
end;

procedure TformPagamentoCreateEdit.onEnter(Sender: TObject);
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

procedure TformPagamentoCreateEdit.save;
var
  vVesez: Integer;
  vDescricao: string;
  I: Integer;
begin
  EdtToObj;
  try
    if validaCamposObrigatorios() then
    begin
      if Pagamento.validate() then
      begin
        if (ckb_repetir.Checked) then
        begin
          vVesez:= StrToIntDef(lbe_vezes.Text, 1);
          vDescricao:= Pagamento.Descricao;

          Pagamento.Descricao:= '1/' + vVesez.ToString() + ' - ' + vDescricao;
          Pagamento.save();

          for I:= 1 to Pred(vVesez) do
          begin
            case cbx_ocorrencia.ItemIndex of
              0: begin
                Pagamento.Competencia:= IncDay(Pagamento.Competencia, 1);
                Pagamento.Vencimento:= IncDay(Pagamento.Vencimento, 1);
              end;
              1: begin
                Pagamento.Competencia:= IncWeek(Pagamento.Competencia, 1);
                Pagamento.Vencimento:= IncWeek(Pagamento.Vencimento, 1);
              end;
              2: begin
                Pagamento.Competencia:= IncMonth(Pagamento.Competencia, 1);
                Pagamento.Vencimento:= IncMonth(Pagamento.Vencimento, 1);
              end;
              3: begin
                Pagamento.Competencia:= IncMonth(Pagamento.Competencia, 2);
                Pagamento.Vencimento:= IncMonth(Pagamento.Vencimento, 2);
              end;
              4: begin
                Pagamento.Competencia:= IncMonth(Pagamento.Competencia, 3);
                Pagamento.Vencimento:= IncMonth(Pagamento.Vencimento, 3);
              end;
              5: begin
                Pagamento.Competencia:= IncMonth(Pagamento.Competencia, 6);
                Pagamento.Vencimento:= IncMonth(Pagamento.Vencimento, 6);
              end;
              6: begin
                Pagamento.Competencia:= IncYear(Pagamento.Competencia, 1);
                Pagamento.Vencimento:= IncMonth(Pagamento.Vencimento, 1);
              end;
            end;

            Pagamento.Id:= EmptyStr;
            Pagamento.Descricao:= (I + 1).ToString() + '/' + vVesez.ToString() + ' - ' + vDescricao;
            Pagamento.Situacao:= 'A';
            Pagamento.save();
          end;

          TAuthService.PagamentoId:= Pagamento.Id;
          Close;
        end
        else if Pagamento.save() then
        begin
          TAuthService.PagamentoId:= Pagamento.Id;
          Close;
        end;
      end;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformPagamentoCreateEdit.setRequired(Obj: TObject);
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

function TformPagamentoCreateEdit.validaCamposObrigatorios: Boolean;
var
  vRequired: Integer;
begin
  vRequired:= 0;
  if (Trim(lbe_descricao.Text) = '') then
  begin
    setRequired(lbe_descricao);
    Inc(vRequired);
  end;

  if (Trim(lbe_categoria.Text) = '') then
  begin
    setRequired(lbe_categoria);
    Inc(vRequired);
  end;

  if (Trim(lbe_conta.Text) = '') then
  begin
    setRequired(lbe_conta);
    Inc(vRequired);
  end;

  if (Trim(lbe_conta.Text) = '') then
  begin
    setRequired(lbe_conta);
    Inc(vRequired);
  end;

  if (Trim(lbe_valor.Text) = '0,00') then
  begin
    setRequired(lbe_valor);
    Inc(vRequired);
  end;

  if (Trim(lbe_pessoa.Text) = '') then
  begin
    setRequired(lbe_pessoa);
    Inc(vRequired);
  end;

  if ckb_repetir.Checked and
  (StrToIntDef(lbe_vezes.Text, 0) = 0) then
  begin
    setRequired(lbe_vezes);
    Inc(vRequired);
  end;

  Result:= (vRequired = 0);
  if (not Result) then  THelper.Mensagem('Preencha os dados obrigatórios do pagamento.');
end;

end.
