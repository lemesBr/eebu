unit uformRecebimentoCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Recebimento, System.Math, System.StrUtils,
  System.DateUtils, Vcl.ComCtrls, Vcl.Mask;

type
  TformRecebimentoCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_recebimento_header: TPanel;
    pnl_recebimento_footer: TPanel;
    btn_confirmar: TButton;
    pnl_recebimento_body: TPanel;
    btn_cancelar: TButton;
    lbe_descricao: TLabeledEdit;
    lbe_categoria: TLabeledEdit;
    lbe_conta: TLabeledEdit;
    lbe_pessoa: TLabeledEdit;
    lbe_valor: TLabeledEdit;
    lbe_juros_multa: TLabeledEdit;
    lbe_descontos_taxas: TLabeledEdit;
    lbe_valor_recebido: TLabeledEdit;
    ckb_situacao: TCheckBox;
    acl_recebimento: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    pnl_left: TPanel;
    pnl_right: TPanel;
    bvl_3: TBevel;
    pnl_recebimento: TPanel;
    bvl_5: TBevel;
    pnl_repetir: TPanel;
    bvl_4: TBevel;
    ckb_repetir: TCheckBox;
    cbx_ocorrencia: TComboBox;
    lbe_vezes: TLabeledEdit;
    pnl_edits: TPanel;
    dtp_recebimento: TDateTimePicker;
    lb_recebimento: TLabel;
    dtp_competencia: TDateTimePicker;
    lb_competencia: TLabel;
    dtp_vencimento: TDateTimePicker;
    lb_vencimento: TLabel;
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbe_contaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_pessoaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_categoriaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbe_valorChange(Sender: TObject);
    procedure lbe_descricaoEnter(Sender: TObject);
    procedure acl_recebimentoUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
    Recebimento: TRecebimento;
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
  formRecebimentoCreateEdit: TformRecebimentoCreateEdit;

implementation

{$R *.dfm}

uses CustomEditHelper, AuthService, Helper, uformContaList, uformPessoaList,
  uformCategoriaList, udmRepository;

procedure TformRecebimentoCreateEdit.acl_recebimentoUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  cbx_ocorrencia.Enabled:= ckb_repetir.Checked;
  lbe_vezes.Enabled:= ckb_repetir.Checked; 
  dtp_recebimento.Enabled:= ckb_situacao.Checked;
  lbe_descontos_taxas.Enabled:= ckb_situacao.Checked;
  lbe_juros_multa.Enabled:= ckb_situacao.Checked;
  lbe_valor_recebido.Enabled:= ckb_situacao.Checked;

  if (not ckb_repetir.Checked) and (lbe_vezes.Text <> '') then
    lbe_vezes.Text:= '';

  if ckb_situacao.Checked and (lbe_valor_recebido.Text = '0,00') then
  begin
    lbe_valor_recebido.Text:= lbe_valor.Text;
  end
  else if (not ckb_situacao.Checked) and (lbe_valor_recebido.Text <> '0,00') then
  begin
    lbe_descontos_taxas.Text:= '0,00';
    lbe_juros_multa.Text:= '0,00';
    lbe_valor_recebido.Text:= '0,00';
  end;
end;

procedure TformRecebimentoCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.RecebimentoId:= EmptyStr;
  Close;
end;

procedure TformRecebimentoCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformRecebimentoCreateEdit.EdtToObj;
begin
  Recebimento.Descricao:= lbe_descricao.Text;
  Recebimento.Competencia:= dtp_competencia.Date;
  Recebimento.Valor:= THelper.StringToExtended(lbe_valor.Text);
  Recebimento.DescontosTaxas:= THelper.StringToExtended(lbe_descontos_taxas.Text);
  Recebimento.JurosMulta:= THelper.StringToExtended(lbe_juros_multa.Text);

  Recebimento.ValorRecebido:= THelper.StringToExtended(lbe_valor_recebido.Text);
  Recebimento.Vencimento:= dtp_vencimento.Date;
  Recebimento.Recebimento:= dtp_recebimento.Date;
  Recebimento.Situacao:= IfThen(ckb_situacao.Checked, 'F', 'A');
end;

procedure TformRecebimentoCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  TCustomEdit(lbe_valor).EditFloat();
  TCustomEdit(lbe_descontos_taxas).EditFloat();
  TCustomEdit(lbe_juros_multa).EditFloat();
  TCustomEdit(lbe_valor_recebido).EditFloat();

  if TAuthService.RecebimentoId = EmptyStr then Recebimento:= TRecebimento.Create
  else Recebimento:= TRecebimento.find(TAuthService.RecebimentoId);
  ObjToEdt;
end;

procedure TformRecebimentoCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Recebimento);
end;

procedure TformRecebimentoCreateEdit.lbe_categoriaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = 112) then
  begin
    TAuthService.CategoriaId:= EmptyStr;
    TAuthService.TipoCategoria:= 'R';
    try
      formCategoriaList:= TformCategoriaList.Create(nil);
      formCategoriaList.Tag:= 1;
      formCategoriaList.ShowModal;
    finally
      FreeAndNil(formCategoriaList);
    end;

    if (TAuthService.CategoriaId <> EmptyStr) then
    begin
      Recebimento.CategoriaId:= TAuthService.CategoriaId;
      lbe_categoria.Text:= Recebimento.Categoria.Nome;
    end;
  end;
end;

procedure TformRecebimentoCreateEdit.lbe_contaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  v_form: TformContaList;
begin
  if (Key = 112) then
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
      Recebimento.ContaId:= TAuthService.ContaId;
      lbe_conta.Text:= Recebimento.Conta.Nome;
    end;
  end;
end;

procedure TformRecebimentoCreateEdit.lbe_descricaoEnter(Sender: TObject);
begin
  TLabeledEdit(Sender).Color:= clWindow;
end;

procedure TformRecebimentoCreateEdit.lbe_pessoaKeyDown(Sender: TObject;
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
      Recebimento.PessoaId:= TAuthService.PessoaId;
      lbe_pessoa.Text:= Recebimento.Pessoa.Nome;
    end;
  end;
end;

procedure TformRecebimentoCreateEdit.lbe_valorChange(Sender: TObject);
var
  vRecebido: Extended;
begin
  if not ckb_situacao.Checked then Exit();

  vRecebido:= THelper.StringToExtended(lbe_valor.Text) -
    THelper.StringToExtended(lbe_descontos_taxas.Text) +
      THelper.StringToExtended(lbe_juros_multa.Text);

  lbe_valor_recebido.Text:= THelper.ExtendedToString(vRecebido);
end;

procedure TformRecebimentoCreateEdit.ObjToEdt;
begin
  if (Recebimento.Id = EmptyStr) then
  begin
    pnl_recebimento_header.Caption:= 'NOVO RECEBIMENTO';
    dtp_competencia.Date:= Now;
    dtp_vencimento.Date:= Now;
    dtp_recebimento.Date:= Now;
    Exit();
  end
  else
  begin
    pnl_recebimento_header.Caption:= 'EDITAR RECEBIMENTO';
    ckb_repetir.Checked:= False;
    pnl_repetir.Visible:= False;
  end;

  if Assigned(Recebimento.Conta) then
  lbe_conta.Text:= Recebimento.Conta.Nome;
  if Assigned(Recebimento.Pessoa) then
  lbe_pessoa.Text:= Recebimento.Pessoa.Nome;
  if Assigned(Recebimento.Categoria) then
  lbe_categoria.Text:= Recebimento.Categoria.Nome;
  lbe_descricao.Text:= Recebimento.Descricao;
  dtp_competencia.Date:= Recebimento.Competencia;
  lbe_valor.Text:= THelper.ExtendedToString(Recebimento.Valor);
  lbe_descontos_taxas.Text:= THelper.ExtendedToString(Recebimento.DescontosTaxas);
  lbe_juros_multa.Text:= THelper.ExtendedToString(Recebimento.JurosMulta);
  lbe_valor_recebido.Text:= THelper.ExtendedToString(Recebimento.ValorRecebido);
  dtp_vencimento.Date:= Recebimento.Vencimento;
  ckb_situacao.Checked:= Recebimento.Situacao = 'F';
  if Recebimento.Situacao = 'A' then
    dtp_recebimento.Date:= Now
  else
    dtp_recebimento.Date:= Recebimento.Recebimento;
end;

procedure TformRecebimentoCreateEdit.onEnter(Sender: TObject);
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

procedure TformRecebimentoCreateEdit.save;
var
  vVesez: Integer;
  vDescricao: string;
  I: Integer;
begin
  EdtToObj;
  try
    if validaCamposObrigatorios() then
    begin
      if Recebimento.validate() then
      begin
        if (ckb_repetir.Checked) then
        begin
          vVesez:= StrToIntDef(lbe_vezes.Text, 1);
          vDescricao:= Recebimento.Descricao;
          
          Recebimento.Descricao:= '1/' + vVesez.ToString() + ' - ' + vDescricao;
          Recebimento.save();
          
          for I:= 1 to Pred(vVesez) do
          begin
            case cbx_ocorrencia.ItemIndex of
              0: begin
                Recebimento.Competencia:= IncDay(Recebimento.Competencia, 1);
                Recebimento.Vencimento:= IncDay(Recebimento.Vencimento, 1);
              end;
              1: begin
                Recebimento.Competencia:= IncWeek(Recebimento.Competencia, 1);
                Recebimento.Vencimento:= IncWeek(Recebimento.Vencimento, 1);
              end;
              2: begin
                Recebimento.Competencia:= IncMonth(Recebimento.Competencia, 1);
                Recebimento.Vencimento:= IncMonth(Recebimento.Vencimento, 1);
              end;
              3: begin
                Recebimento.Competencia:= IncMonth(Recebimento.Competencia, 2);
                Recebimento.Vencimento:= IncMonth(Recebimento.Vencimento, 2);
              end;
              4: begin
                Recebimento.Competencia:= IncMonth(Recebimento.Competencia, 3);
                Recebimento.Vencimento:= IncMonth(Recebimento.Vencimento, 3);
              end;
              5: begin
                Recebimento.Competencia:= IncMonth(Recebimento.Competencia, 6);
                Recebimento.Vencimento:= IncMonth(Recebimento.Vencimento, 6);
              end;
              6: begin
                Recebimento.Competencia:= IncYear(Recebimento.Competencia, 1);
                Recebimento.Vencimento:= IncMonth(Recebimento.Vencimento, 1);
              end;
            end;
            
            Recebimento.Id:= EmptyStr;
            Recebimento.Descricao:= (I + 1).ToString() + '/' + vVesez.ToString() + ' - ' + vDescricao;
            Recebimento.Situacao:= 'A'; 
            Recebimento.save();
          end;
          
          TAuthService.RecebimentoId:= Recebimento.Id;
          Close;
        end
        else if Recebimento.save() then
        begin
          TAuthService.RecebimentoId:= Recebimento.Id;
          Close;
        end;
      end;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformRecebimentoCreateEdit.setRequired(Obj: TObject);
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

function TformRecebimentoCreateEdit.validaCamposObrigatorios: Boolean;
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
  if (not Result) then  THelper.Mensagem('Preencha os dados obrigatórios do recebimento.');
end;

end.
