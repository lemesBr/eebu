unit uformFecharMovimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, System.Generics.Collections;

type
  TformFecharMovimento = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_cancelar: TButton;
    btn_confirmar: TButton;
    pnl_body: TPanel;
    pnl_left: TPanel;
    pnl_dinheiro: TPanel;
    pnl_cheque: TPanel;
    pnl_credito: TPanel;
    pnl_debito: TPanel;
    pnl_credito_loja: TPanel;
    pnl_vale_alimentacao: TPanel;
    pnl_vale_refeicao: TPanel;
    pnl_vale_presente: TPanel;
    pnl_vale_combustivel: TPanel;
    pnl_duplicata_mercantil: TPanel;
    pnl_boleto_bancario: TPanel;
    pnl_outro: TPanel;
    pnl_rigth: TPanel;
    pnl_valor: TPanel;
    edt_valor: TEdit;
    pnl_recebimentos: TPanel;
    lbe_senha_operador: TLabeledEdit;
    cbx_gerente: TComboBox;
    lbe_senha_gerente: TLabeledEdit;
    lb_gerente: TLabel;
    acl_fechamento: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    act_recebiemnto_click: TAction;
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure act_recebiemnto_clickExecute(Sender: TObject);
    procedure edt_valorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure acl_fechamentoUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure lbe_senha_operadorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    Pagamento: Integer;
    vValor: Currency;
    vDinheiro: Currency;
    vCheque: Currency;
    vCredito: Currency;
    vDebito: Currency;
    vCreditoLoja: Currency;
    vValeAlimentacao: Currency;
    vValeRefeicao: Currency;
    vValePresente: Currency;
    vValeCombustivel: Currency;
    vDuplicataMercantil: Currency;
    vBoletoBancario: Currency;
    vOutro: Currency;

    procedure Organizar();
    procedure Resumir();
  public
    { Public declarations }
  end;

var
  formFecharMovimento: TformFecharMovimento;

implementation

{$R *.dfm}

uses udmRepository, User, Helper, AuthService, Conexao, Movimento,
  MovimentoFechamento;

procedure TformFecharMovimento.acl_fechamentoUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  if (vDinheiro > 0) then pnl_dinheiro.Font.Color:= clGreen else pnl_dinheiro.Font.Color:= clSilver;
  if (vCheque > 0) then pnl_cheque.Font.Color:= clGreen else pnl_cheque.Font.Color:= clSilver;
  if (vCredito > 0) then pnl_credito.Font.Color:= clGreen else pnl_credito.Font.Color:= clSilver;
  if (vDebito > 0) then pnl_debito.Font.Color:= clGreen else pnl_debito.Font.Color:= clSilver;
  if (vCreditoLoja > 0) then pnl_credito_loja.Font.Color:= clGreen else pnl_credito_loja.Font.Color:= clSilver;
  if (vValeAlimentacao > 0) then pnl_vale_alimentacao.Font.Color:= clGreen else pnl_vale_alimentacao.Font.Color:= clSilver;
  if (vValeRefeicao > 0) then pnl_vale_refeicao.Font.Color:= clGreen else pnl_vale_refeicao.Font.Color:= clSilver;
  if (vValePresente > 0) then pnl_vale_presente.Font.Color:= clGreen else pnl_vale_presente.Font.Color:= clSilver;
  if (vValeCombustivel > 0) then pnl_vale_combustivel.Font.Color:= clGreen else pnl_vale_combustivel.Font.Color:= clSilver;
  if (vDuplicataMercantil > 0) then pnl_duplicata_mercantil.Font.Color:= clGreen else pnl_duplicata_mercantil.Font.Color:= clSilver;
  if (vBoletoBancario > 0) then pnl_boleto_bancario.Font.Color:= clGreen else pnl_boleto_bancario.Font.Color:= clSilver;
  if (vOutro > 0) then pnl_outro.Font.Color:= clGreen else pnl_outro.Font.Color:= clSilver;

end;

procedure TformFecharMovimento.act_cancelarExecute(Sender: TObject);
begin
  Close();
end;

procedure TformFecharMovimento.act_confirmarExecute(Sender: TObject);
var
  vMovimento: TMovimento;
  vUser: TUser;
  vEmail,
  vPassword: string;
  I: Integer;
  J: Integer;
begin
  try
    TConexao.GetInstance.StartTransaction();
    vMovimento:= TMovimento.find(TAuthService.Terminal.Movimento.Id);
    try
      vUser:= TUser.find(vMovimento.OperadorId);
      vEmail:= vUser.Email;
      vPassword:= Trim(lbe_senha_operador.Text);
      vPassword:= THelper.MD5String(vEmail + vPassword);
      FreeAndNil(vUser);
      vUser:= TUser.login(vPassword);

      if not Assigned(vUser) then
        raise Exception.Create('Senha do operador inválida.');

      FreeAndNil(vUser);

      vEmail:= Trim(cbx_gerente.Text);
      vPassword:= Trim(lbe_senha_gerente.Text);
      vPassword:= THelper.MD5String(vEmail + vPassword);
      vUser:= TUser.login(vPassword);
      if not Assigned(vUser) then
        raise Exception.Create('Senha do gerente inválida.');

      vMovimento.GerenteId:= vUser.Id;
      FreeAndNil(vUser);

      vMovimento.Fechamento:= Now;
      vMovimento.Suprimento:= 0;
      vMovimento.Sangria:= 0;
      vMovimento.Subtotal:= 0;
      vMovimento.Acrescimo:= 0;
      vMovimento.Desconto:= 0;
      vMovimento.Recebido:= 0;

      for I:= 0 to Pred(vMovimento.Suprimentos.Count) do
        vMovimento.Suprimento:= vMovimento.Suprimento + vMovimento.Suprimentos.Items[I].Valor;
      for I:= 0 to Pred(vMovimento.Sangrias.Count) do
        vMovimento.Sangria:= vMovimento.Sangria + vMovimento.Sangrias.Items[I].Valor;
      for I:= 0 to Pred(vMovimento.Vendas.Count) do
      begin
        vMovimento.Subtotal:= vMovimento.Subtotal + vMovimento.Vendas.Items[I].Subtotal;
        vMovimento.Acrescimo:= vMovimento.Acrescimo + vMovimento.Vendas.Items[I].Acrescimo;
        vMovimento.Desconto:= vMovimento.Desconto + vMovimento.Vendas.Items[I].Desconto;
        for J:= 0 to Pred(vMovimento.Vendas.Items[I].Recebimentos.Count) do
          vMovimento.Recebido:= vMovimento.Recebido + vMovimento.Vendas.Items[I].Recebimentos.Items[J].Recebido;
      end;
      vMovimento.Total:= (vMovimento.Subtotal + vMovimento.Acrescimo) - vMovimento.Desconto;
      vMovimento.Troco:= vMovimento.Recebido - vMovimento.Total;
      vMovimento.Situacao:= 'F';
      vMovimento.save();

      if (vDinheiro > 0) then
      begin
        vMovimento.Fechamentos.Add(TMovimentoFechamento.Create);
        vMovimento.Fechamentos.Last.Tpag:= '01';
        vMovimento.Fechamentos.Last.Declarado:= vDinheiro;
      end;

      if (vCheque > 0) then
      begin
        vMovimento.Fechamentos.Add(TMovimentoFechamento.Create);
        vMovimento.Fechamentos.Last.Tpag:= '02';
        vMovimento.Fechamentos.Last.Declarado:= vCheque;
      end;

      if (vCredito > 0) then
      begin
        vMovimento.Fechamentos.Add(TMovimentoFechamento.Create);
        vMovimento.Fechamentos.Last.Tpag:= '03';
        vMovimento.Fechamentos.Last.Declarado:= vCredito;
      end;

      if (vDebito > 0) then
      begin
        vMovimento.Fechamentos.Add(TMovimentoFechamento.Create);
        vMovimento.Fechamentos.Last.Tpag:= '04';
        vMovimento.Fechamentos.Last.Declarado:= vDebito;
      end;

      if (vCreditoLoja > 0) then
      begin
        vMovimento.Fechamentos.Add(TMovimentoFechamento.Create);
        vMovimento.Fechamentos.Last.Tpag:= '05';
        vMovimento.Fechamentos.Last.Declarado:= vCreditoLoja;
      end;

      if (vValeAlimentacao > 0) then
      begin
        vMovimento.Fechamentos.Add(TMovimentoFechamento.Create);
        vMovimento.Fechamentos.Last.Tpag:= '10';
        vMovimento.Fechamentos.Last.Declarado:= vValeAlimentacao;
      end;

      if (vValeRefeicao > 0) then
      begin
        vMovimento.Fechamentos.Add(TMovimentoFechamento.Create);
        vMovimento.Fechamentos.Last.Tpag:= '11';
        vMovimento.Fechamentos.Last.Declarado:= vValeRefeicao;
      end;

      if (vValePresente > 0) then
      begin
        vMovimento.Fechamentos.Add(TMovimentoFechamento.Create);
        vMovimento.Fechamentos.Last.Tpag:= '12';
        vMovimento.Fechamentos.Last.Declarado:= vValePresente;
      end;

      if (vValeCombustivel > 0) then
      begin
        vMovimento.Fechamentos.Add(TMovimentoFechamento.Create);
        vMovimento.Fechamentos.Last.Tpag:= '13';
        vMovimento.Fechamentos.Last.Declarado:= vValeCombustivel;
      end;

      if (vDuplicataMercantil > 0) then
      begin
        vMovimento.Fechamentos.Add(TMovimentoFechamento.Create);
        vMovimento.Fechamentos.Last.Tpag:= '14';
        vMovimento.Fechamentos.Last.Declarado:= vDuplicataMercantil;
      end;

      if (vBoletoBancario > 0) then
      begin
        vMovimento.Fechamentos.Add(TMovimentoFechamento.Create);
        vMovimento.Fechamentos.Last.Tpag:= '15';
        vMovimento.Fechamentos.Last.Declarado:= vBoletoBancario;
      end;

      if (vOutro > 0) then
      begin
        vMovimento.Fechamentos.Add(TMovimentoFechamento.Create);
        vMovimento.Fechamentos.Last.Tpag:= '90';
        vMovimento.Fechamentos.Last.Declarado:= vOutro;
      end;

      for I:= 0 to Pred(vMovimento.Fechamentos.Count) do
      begin
        vMovimento.Fechamentos.Items[I].MovimentoId:= vMovimento.Id;
        vMovimento.Fechamentos.Items[I].save();
      end;

//      TAuthService.Venda.Situacao:= 'C';
//      TAuthService.Venda.Acrescimo:= 0;
//      TAuthService.Venda.Desconto:= 0;
//      TAuthService.Venda.Total:= 0;
//      TAuthService.Venda.save();

      FreeAndNil(TAuthService.Venda);
      FreeAndNil(TAuthService.Terminal);
      TConexao.GetInstance.Commit();

      if THelper.Mensagem('Fechamento realizado com sucesso. Deseja imprimir?', 1) then
        TMovimento.imprimirFechamento(vMovimento.Id);

      Close();
    except on e: Exception do
      begin
        TConexao.GetInstance.Rollback();
        THelper.Mensagem(e.Message);
      end;
    end;
  finally
    FreeAndNil(vMovimento);
  end;
end;

procedure TformFecharMovimento.act_recebiemnto_clickExecute(Sender: TObject);
begin
  Pagamento:= TPanel(Sender).Tag;

  pnl_valor.Top:= (Sender as TPanel).Top;
  edt_valor.Text:= THelper.ExtendedToString(0);
  edt_valor.SelectAll();
end;

procedure TformFecharMovimento.edt_valorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  MovePagamento: Integer;
begin
  MovePagamento:= Pagamento;
  case Key of
    13: begin
      vValor:= THelper.StringToExtended(edt_valor.Text);

      if (vValor <= 0) and (Pagamento >= 2) then Exit();

      case Pagamento of
        2: vDinheiro:= vDinheiro + vValor;
        3: vCheque:= vCheque + vValor;
        4: vCredito:= vCredito + vValor;
        5: vDebito:= vDebito + vValor;
        6: vCreditoLoja:= vCreditoLoja + vValor;
        7: vValeAlimentacao:= vValeAlimentacao + vValor;
        8: vValeRefeicao:= vValeRefeicao + vValor;
        9: vValePresente:= vValePresente + vValor;
        10: vValeCombustivel:= vValeCombustivel + vValor;
        11: vDuplicataMercantil:= vDuplicataMercantil + vValor;
        12: vBoletoBancario:= vBoletoBancario + vValor;
        13: vOutro:= vOutro + vValor;
      end;

      Resumir();
    end;
    38: begin
      MovePagamento:= Pagamento - 1;
      Key:= 0;
    end;
    40: begin
      MovePagamento:= Pagamento + 1;
      Key:= 0;
    end;
  end;

  if (MovePagamento <> Pagamento) then
  begin
    case MovePagamento of
      2: act_recebiemnto_clickExecute(pnl_dinheiro);
      3: act_recebiemnto_clickExecute(pnl_cheque);
      4: act_recebiemnto_clickExecute(pnl_credito);
      5: act_recebiemnto_clickExecute(pnl_debito);
      6: act_recebiemnto_clickExecute(pnl_credito_loja);
      7: act_recebiemnto_clickExecute(pnl_vale_alimentacao);
      8: act_recebiemnto_clickExecute(pnl_vale_refeicao);
      9: act_recebiemnto_clickExecute(pnl_vale_presente);
      10: act_recebiemnto_clickExecute(pnl_vale_combustivel);
      11: act_recebiemnto_clickExecute(pnl_duplicata_mercantil);
      12: act_recebiemnto_clickExecute(pnl_boleto_bancario);
      13: act_recebiemnto_clickExecute(pnl_outro);
    end;
  end;
end;

procedure TformFecharMovimento.FormCreate(Sender: TObject);
var
  vUsers: TObjectList<TUser>;
  I: Integer;
begin
  inherited;

  vUsers:= TUser.all();
  if Assigned(vUsers) then
  begin
    cbx_gerente.Items.Clear();
    for I:= 0 to Pred(vUsers.Count) do
      cbx_gerente.Items.Add(vUsers.Items[I].Email);
    FreeAndNil(vUsers);
  end;

  Organizar();
end;

procedure TformFecharMovimento.lbe_senha_operadorKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = 13) then
  begin
    case TWinControl(Sender).TabOrder of
      1: cbx_gerente.SetFocus();
      2: lbe_senha_gerente.SetFocus();
      3: act_confirmarExecute(Sender);
    end;
  end;
end;

procedure TformFecharMovimento.Organizar;
begin
  Pagamento:= 2;
  vValor:= 0;
  vDinheiro:= 0;
  vCheque:= 0;
  vCredito:= 0;
  vDebito:= 0;
  vCreditoLoja:= 0;
  vValeAlimentacao:= 0;
  vValeRefeicao:= 0;
  vValePresente:= 0;
  vValeCombustivel:= 0;
  vDuplicataMercantil:= 0;
  vBoletoBancario:= 0;
  vOutro:= 0;
end;

procedure TformFecharMovimento.Resumir;
begin
  pnl_dinheiro.Caption:= 'DINHEIRO - ' + THelper.ExtendedToString(vDinheiro) + '  ';
  pnl_cheque.Caption:= 'CHEQUE - ' + THelper.ExtendedToString(vCheque) + '  ';
  pnl_credito.Caption:= 'CARTAO DE CREDITO - ' + THelper.ExtendedToString(vCredito) + '  ';
  pnl_debito.Caption:= 'CARTAO DE DEBITO - ' + THelper.ExtendedToString(vDebito) + '  ';
  pnl_credito_loja.Caption:= 'CREDITO LOJA - ' + THelper.ExtendedToString(vCreditoLoja) + '  ';
  pnl_vale_alimentacao.Caption:= 'VALE ALIMENTACAO - ' + THelper.ExtendedToString(vValeAlimentacao) + '  ';
  pnl_vale_refeicao.Caption:= 'VALE REFEICAO - ' + THelper.ExtendedToString(vValeRefeicao) + '  ';
  pnl_vale_presente.Caption:= 'VALE PRESENTE - ' + THelper.ExtendedToString(vValePresente) + '  ';
  pnl_vale_combustivel.Caption:= 'VALE COMBUSTIVEL - ' + THelper.ExtendedToString(vValeCombustivel) + '  ';
  pnl_duplicata_mercantil.Caption:= 'DUPLICATA MERCANTIL - ' + THelper.ExtendedToString(vDuplicataMercantil) + '  ';
  pnl_boleto_bancario.Caption:= 'BOLETO BANCARIO - ' + THelper.ExtendedToString(vBoletoBancario) + '  ';
  pnl_outro.Caption:= 'OUTRO - ' + THelper.ExtendedToString(vOutro) + '  ';

  edt_valor.Text:= THelper.ExtendedToString(0);
  edt_valor.SelectAll();
end;

end.
