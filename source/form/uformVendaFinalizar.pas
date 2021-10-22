unit uformVendaFinalizar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, System.Math, Venda, Generics.Collections,
  Recebimento;

type
  TformVendaFinalizar = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    pnl_subtotal: TPanel;
    pnl_left: TPanel;
    pnl_desconto: TPanel;
    pnl_acrescimo: TPanel;
    pnl_total: TPanel;
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
    pnl_recebido: TPanel;
    pnl_troco: TPanel;
    pnl_valor: TPanel;
    edt_valor: TEdit;
    pnl_rigth: TPanel;
    acl_venda: TActionList;
    act_recebiemnto_click: TAction;
    btn_cancelar: TButton;
    act_cancelar: TAction;
    btn_confirmar: TButton;
    act_confirmar: TAction;
    tmr_focus: TTimer;
    procedure edt_valorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure act_recebiemnto_clickExecute(Sender: TObject);
    procedure acl_vendaUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure act_cancelarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tmr_focusTimer(Sender: TObject);
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
    function ReceberCt(pModalidade: string; pValor: Currency): Boolean;
  public
    { Public declarations }
  end;

var
  formVendaFinalizar: TformVendaFinalizar;

implementation

uses
  AuthService, Helper, CustomEditHelper, VendaRecebimento, udmRepository,
  uformVendaParcelamento, uformCartaoParcelamento;

{$R *.dfm}

procedure TformVendaFinalizar.acl_vendaUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_confirmar.Enabled:= (TAuthService.vRestante <= 0);
  pnl_valor.Visible:= (TAuthService.vRestante > 0);

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

  tmr_focus.Enabled:= (pnl_valor.Visible) and (not edt_valor.Focused);
end;

procedure TformVendaFinalizar.act_recebiemnto_clickExecute(Sender: TObject);
var
  PagamentoAnterior: Integer;
begin
  PagamentoAnterior:= Pagamento;
  Pagamento:= TPanel(Sender).Tag;
  if ((Pagamento = 0) and (TAuthService.vRecebido = 0) and (TAuthService.vAcrescimo = 0)) or
     ((Pagamento = 1) and (TAuthService.vRecebido = 0) and (TAuthService.vDesconto = 0)) or
     ((Pagamento in[2..13]) and (TAuthService.vRestante > 0)) then
  begin
    pnl_valor.Top:= (Sender as TPanel).Top;
    edt_valor.Text:= THelper.ExtendedToString(TAuthService.vRestante);
    edt_valor.SelectAll;

    edt_valor.ReadOnly:= (Pagamento in[6,11,12]);
  end
  else
  begin
    Pagamento:= PagamentoAnterior;
  end;
end;

procedure TformVendaFinalizar.act_confirmarExecute(Sender: TObject);
var
  I: Integer;
  aAcrescimo: Extended;
  aDesconto: Extended;
begin
  if not THelper.Mensagem('Deseja realmente finalizar a venda?', 1) then Exit();

  TAuthService.Venda.Situacao:= 'F';
  TAuthService.Venda.Acrescimo:= TAuthService.vAcrescimo;
  TAuthService.Venda.Desconto:= TAuthService.vDesconto;
  TAuthService.Venda.Total:= TAuthService.Venda.Subtotal + TAuthService.Venda.Acrescimo - TAuthService.Venda.Desconto;

  aAcrescimo:= 0;
  aDesconto:= 0;

  for I:= 0 to Pred(TAuthService.Venda.Itens.Count) do
  begin
    TAuthService.Venda.Itens.Items[I].Acrescimo:= THelper.TruncateValue(SimpleRoundTo((TAuthService.Venda.Itens.Items[I].Subtotal * TAuthService.pAcrescimo) / 100, -6), 2);
    aAcrescimo:= aAcrescimo + TAuthService.Venda.Itens.Items[I].Acrescimo;

    TAuthService.Venda.Itens.Items[I].Desconto:= THelper.TruncateValue(SimpleRoundTo((TAuthService.Venda.Itens.Items[I].Subtotal * TAuthService.pDesconto) / 100, -6), 2);
    aDesconto:= aDesconto + TAuthService.Venda.Itens.Items[I].Desconto;

    if (I = Pred(TAuthService.Venda.Itens.Count)) then
    begin
      TAuthService.Venda.Itens.Items[I].Acrescimo:= TAuthService.Venda.Itens.Items[I].Acrescimo + (TAuthService.vAcrescimo - aAcrescimo);
      TAuthService.Venda.Itens.Items[I].Desconto:= TAuthService.Venda.Itens.Items[I].Desconto + (TAuthService.vDesconto - aDesconto);
    end;

    TAuthService.Venda.Itens.Items[I].Total:= TAuthService.Venda.Itens.Items[I].Subtotal + TAuthService.Venda.Itens.Items[I].Acrescimo - TAuthService.Venda.Itens.Items[I].Desconto;
  end;

  TAuthService.Venda.Recebimentos.Clear;
  if (vDinheiro > 0) then
  begin
    TAuthService.Venda.Recebimentos.Add(TVendaRecebimento.Create);
    TAuthService.Venda.Recebimentos.Last.Tpag:= '01';
    TAuthService.Venda.Recebimentos.Last.Recebido:= vDinheiro;
    TAuthService.Venda.Recebimentos.Last.Troco:= TAuthService.vTroco;
  end;

  if (vCheque > 0) then
  begin
    TAuthService.Venda.Recebimentos.Add(TVendaRecebimento.Create);
    TAuthService.Venda.Recebimentos.Last.Tpag:= '02';
    TAuthService.Venda.Recebimentos.Last.Recebido:= vCheque;
    TAuthService.Venda.Recebimentos.Last.Troco:= 0;
  end;

  if (vCredito > 0) then
  begin
    TAuthService.Venda.Recebimentos.Add(TVendaRecebimento.Create);
    TAuthService.Venda.Recebimentos.Last.Tpag:= '03';
    TAuthService.Venda.Recebimentos.Last.Recebido:= vCredito;
    TAuthService.Venda.Recebimentos.Last.Troco:= 0;
  end;

  if (vDebito > 0) then
  begin
    TAuthService.Venda.Recebimentos.Add(TVendaRecebimento.Create);
    TAuthService.Venda.Recebimentos.Last.Tpag:= '04';
    TAuthService.Venda.Recebimentos.Last.Recebido:= vDebito;
    TAuthService.Venda.Recebimentos.Last.Troco:= 0;
  end;

  if (vCreditoLoja > 0) then
  begin
    TAuthService.Venda.Recebimentos.Add(TVendaRecebimento.Create);
    TAuthService.Venda.Recebimentos.Last.Tpag:= '05';
    TAuthService.Venda.Recebimentos.Last.Recebido:= vCreditoLoja;
    TAuthService.Venda.Recebimentos.Last.Troco:= 0;
  end;

  if (vValeAlimentacao > 0) then
  begin
    TAuthService.Venda.Recebimentos.Add(TVendaRecebimento.Create);
    TAuthService.Venda.Recebimentos.Last.Tpag:= '10';
    TAuthService.Venda.Recebimentos.Last.Recebido:= vValeAlimentacao;
    TAuthService.Venda.Recebimentos.Last.Troco:= 0;
  end;

  if (vValeRefeicao > 0) then
  begin
    TAuthService.Venda.Recebimentos.Add(TVendaRecebimento.Create);
    TAuthService.Venda.Recebimentos.Last.Tpag:= '11';
    TAuthService.Venda.Recebimentos.Last.Recebido:= vValeRefeicao;
    TAuthService.Venda.Recebimentos.Last.Troco:= 0;
  end;

  if (vValePresente > 0) then
  begin
    TAuthService.Venda.Recebimentos.Add(TVendaRecebimento.Create);
    TAuthService.Venda.Recebimentos.Last.Tpag:= '12';
    TAuthService.Venda.Recebimentos.Last.Recebido:= vValePresente;
    TAuthService.Venda.Recebimentos.Last.Troco:= 0;
  end;

  if (vValeCombustivel > 0) then
  begin
    TAuthService.Venda.Recebimentos.Add(TVendaRecebimento.Create);
    TAuthService.Venda.Recebimentos.Last.Tpag:= '13';
    TAuthService.Venda.Recebimentos.Last.Recebido:= vValeCombustivel;
    TAuthService.Venda.Recebimentos.Last.Troco:= 0;
  end;

  if (vDuplicataMercantil > 0) then
  begin
    TAuthService.Venda.Recebimentos.Add(TVendaRecebimento.Create);
    TAuthService.Venda.Recebimentos.Last.Tpag:= '14';
    TAuthService.Venda.Recebimentos.Last.Recebido:= vDuplicataMercantil;
    TAuthService.Venda.Recebimentos.Last.Troco:= 0;
  end;

  if (vBoletoBancario > 0) then
  begin
    TAuthService.Venda.Recebimentos.Add(TVendaRecebimento.Create);
    TAuthService.Venda.Recebimentos.Last.Tpag:= '15';
    TAuthService.Venda.Recebimentos.Last.Recebido:= vBoletoBancario;
    TAuthService.Venda.Recebimentos.Last.Troco:= 0;
  end;

  if (vOutro > 0) then
  begin
    TAuthService.Venda.Recebimentos.Add(TVendaRecebimento.Create);
    TAuthService.Venda.Recebimentos.Last.Tpag:= '90';
    TAuthService.Venda.Recebimentos.Last.Recebido:= vOutro;
    TAuthService.Venda.Recebimentos.Last.Troco:= 0;
  end;

  try
    if TAuthService.Venda.save() then
    begin
      if THelper.Mensagem('Deseja imprimir o comprovante?', 1) then
      begin
        try
          TVenda.imprimir(TAuthService.Venda.Id, TAuthService.getAuthenticatedConfig.PrintMode);
        except on e: Exception do
          THelper.Mensagem(e.Message);
        end;
      end;
      TAuthService.VendaId:= TAuthService.Venda.Id;
      Close;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformVendaFinalizar.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.VendaId:= EmptyStr;
  Close;
end;

procedure TformVendaFinalizar.edt_valorKeyDown(Sender: TObject; var Key: Word;
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
        0: begin
          if vValor > 0 then
          begin
            TAuthService.vAcrescimo:= vValor;
            TAuthService.pAcrescimo:= THelper.TruncateValue(SimpleRoundTo((vValor * 100 ) / TAuthService.vSubtotal, -6), 2);
          end
          else
          begin
            if Abs(vValor) <= 100 then
            begin
              TAuthService.pAcrescimo:= Abs(vValor);
              TAuthService.vAcrescimo:= THelper.TruncateValue(SimpleRoundTo((TAuthService.vSubtotal * TAuthService.pAcrescimo) / 100, -6), 2);
            end
            else
            begin
              Exit;
            end;
          end;

          TAuthService.vTotal:= TAuthService.vSubtotal + TAuthService.vAcrescimo - TAuthService.vDesconto;
          TAuthService.vRestante:= TAuthService.vTotal;

          act_recebiemnto_clickExecute(pnl_dinheiro);
          Resumir;
          Exit;
        end;
        1: begin
          if vValor > 0 then
          begin
            TAuthService.vDesconto:= vValor;
            TAuthService.pDesconto:= THelper.TruncateValue(SimpleRoundTo((vValor * 100 ) / TAuthService.vSubtotal, -6), 2);
          end
          else
          begin
            if Abs(vValor) <= 100 then
            begin
              TAuthService.pDesconto:= Abs(vValor);
              TAuthService.vDesconto:= THelper.TruncateValue(SimpleRoundTo((TAuthService.vSubtotal * TAuthService.pDesconto) / 100, -6), 2);
            end
            else
            begin
              Exit;
            end;
          end;

          TAuthService.vTotal:= TAuthService.vSubtotal + TAuthService.vAcrescimo - TAuthService.vDesconto;
          TAuthService.vRestante:= TAuthService.vTotal;

          act_recebiemnto_clickExecute(pnl_dinheiro);
          Resumir;
          Exit;
        end;
        2: vDinheiro:= vDinheiro + vValor;
        3: begin
          if (vValor > TAuthService.vRestante) then
          begin
            edt_valor.Text:= THelper.ExtendedToString(TAuthService.vRestante);
            edt_valor.SelectAll;
            Exit;
          end;

          vCheque:= vCheque + vValor;
        end;
        4: begin
          if (vValor > TAuthService.vRestante) or (not ReceberCt('C', vValor)) then
          begin
            edt_valor.Text:= THelper.ExtendedToString(TAuthService.vRestante);
            edt_valor.SelectAll();
            Exit();
          end;

          vCredito:= vCredito + vValor;
        end;
        5: begin
          if (vValor > TAuthService.vRestante) or (not ReceberCt('D', vValor)) then
          begin
            edt_valor.Text:= THelper.ExtendedToString(TAuthService.vRestante);
            edt_valor.SelectAll();
            Exit();
          end;

          vDebito:= vDebito + vValor;
        end;
        6: begin
          if (vValor > TAuthService.vRestante) then
          begin
            edt_valor.Text:= THelper.ExtendedToString(TAuthService.vRestante);
            edt_valor.SelectAll;
            Exit;
          end;

          vCreditoLoja:= vCreditoLoja + vValor;
        end;
        7: begin
          if (vValor > TAuthService.vRestante) or (not ReceberCt('A', vValor)) then
          begin
            edt_valor.Text:= THelper.ExtendedToString(TAuthService.vRestante);
            edt_valor.SelectAll();
            Exit();
          end;

          vValeAlimentacao:= vValeAlimentacao + vValor;
        end;
        8: begin
          if (vValor > TAuthService.vRestante) or (not ReceberCt('R', vValor)) then
          begin
            edt_valor.Text:= THelper.ExtendedToString(TAuthService.vRestante);
            edt_valor.SelectAll();
            Exit();
          end;

          vValeRefeicao:= vValeRefeicao + vValor;
        end;
        9: begin
          if (vValor > TAuthService.vRestante) or (not ReceberCt('P', vValor)) then
          begin
            edt_valor.Text:= THelper.ExtendedToString(TAuthService.vRestante);
            edt_valor.SelectAll();
            Exit();
          end;

          vValePresente:= vValePresente + vValor;
        end;
        10: begin
          if (vValor > TAuthService.vRestante) or (not ReceberCt('T', vValor)) then
          begin
            edt_valor.Text:= THelper.ExtendedToString(TAuthService.vRestante);
            edt_valor.SelectAll();
            Exit();
          end;

          vValeCombustivel:= vValeCombustivel + vValor;
        end;
        11: begin
          if (vValor > TAuthService.vRestante) then
          begin
            edt_valor.Text:= THelper.ExtendedToString(TAuthService.vRestante);
            edt_valor.SelectAll;
            Exit;
          end;

          FreeAndNil(TAuthService.lParcelas);
          try
            formVendaParcelamento:= TformVendaParcelamento.Create(nil);
            formVendaParcelamento.ShowModal;
          finally
            FreeAndNil(formVendaParcelamento);
          end;

          if not Assigned(TAuthService.lParcelas) then
          begin
            edt_valor.Text:= THelper.ExtendedToString(TAuthService.vRestante);
            edt_valor.SelectAll;
            Exit;
          end;

          vDuplicataMercantil:= vDuplicataMercantil + vValor;
        end;
        12: begin
          if (vValor > TAuthService.vRestante) then
          begin
            edt_valor.Text:= THelper.ExtendedToString(TAuthService.vRestante);
            edt_valor.SelectAll;
            Exit;
          end;

          FreeAndNil(TAuthService.lParcelas);
          try
            formVendaParcelamento:= TformVendaParcelamento.Create(nil);
            formVendaParcelamento.ShowModal;
          finally
            FreeAndNil(formVendaParcelamento);
          end;

          if not Assigned(TAuthService.lParcelas) then
          begin
            edt_valor.Text:= THelper.ExtendedToString(TAuthService.vRestante);
            edt_valor.SelectAll;
            Exit;
          end;

          vBoletoBancario:= vBoletoBancario + vValor;
        end;
        13: begin
          if (vValor > TAuthService.vRestante) then
          begin
            edt_valor.Text:= THelper.ExtendedToString(TAuthService.vRestante);
            edt_valor.SelectAll;
            Exit;
          end;

          vOutro:= vOutro + vValor;
        end;
      end;

      if Pagamento > 0 then
      begin
        TAuthService.vRecebido:= TAuthService.vRecebido + vValor;

        if not (TAuthService.vRecebido >= TAuthService.vTotal) then
          TAuthService.vRestante:= TAuthService.vTotal - TAuthService.vRecebido
        else
        begin
          TAuthService.vRestante:= 0;
          TAuthService.vTroco:= TAuthService.vRecebido - TAuthService.vTotal;
        end;
      end;

      Resumir;
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
      0: act_recebiemnto_clickExecute(pnl_acrescimo);
      1: act_recebiemnto_clickExecute(pnl_desconto);
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

procedure TformVendaFinalizar.FormCreate(Sender: TObject);
begin
  inherited;
  Organizar();
  TAuthService.listCtRecebimento:= TObjectList<TRecebimento>.Create;
end;

procedure TformVendaFinalizar.FormDestroy(Sender: TObject);
begin
  FreeAndNil(TAuthService.lParcelas);
  FreeAndNil(TAuthService.listCtRecebimento);
end;

procedure TformVendaFinalizar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    13: if (TAuthService.vRestante <= 0) then act_confirmarExecute(Self);
  end;
end;

procedure TformVendaFinalizar.FormShow(Sender: TObject);
begin
  Resumir();
  act_recebiemnto_clickExecute(pnl_dinheiro);
end;

procedure TformVendaFinalizar.Organizar;
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

  TAuthService.vSubtotal:= TAuthService.Venda.Subtotal;
  TAuthService.vDesconto:= 0;
  TAuthService.pDesconto:= 0;
  TAuthService.vAcrescimo:= 0;
  TAuthService.pAcrescimo:= 0;
  TAuthService.vTotal:= TAuthService.vSubtotal;
  TAuthService.vRecebido:= 0;
  TAuthService.vRestante:= TAuthService.vTotal;
  TAuthService.vTroco:= 0;
end;

function TformVendaFinalizar.ReceberCt(pModalidade: string;
  pValor: Currency): Boolean;
var
  v_form: TformCartaoParcelamento;
begin
  try
    v_form:= TformCartaoParcelamento.Create(nil);
    v_form.fModalidade:= pModalidade;
    v_form.fTotal:= pValor;
    v_form.list();
    if (v_form.fdmt_cartoes.RecordCount = 0) then
    begin
      Result:= False;
      Exit();
    end
    else if (v_form.fdmt_cartoes.RecordCount = 1) and (pModalidade <> 'C') then
    begin
      v_form.processar();
      Result:= v_form.fOk;
      Exit();
    end;
    v_form.ShowModal;
    Result:= v_form.fOk;
  finally
    FreeAndNil(v_form);
  end;
end;

procedure TformVendaFinalizar.Resumir;
begin
  pnl_subtotal.Caption:= 'SUBTOTAL - ' + THelper.ExtendedToString(TAuthService.vSubtotal) + '  ';
  pnl_desconto.Caption:= 'DESCONTO - ' + THelper.ExtendedToString(TAuthService.vDesconto) + '  ';
  pnl_acrescimo.Caption:= 'ACRESCIMO - ' + THelper.ExtendedToString(TAuthService.vAcrescimo) + '  ';
  pnl_total.Caption:= 'TOTAL - ' + THelper.ExtendedToString(TAuthService.vTotal) + '  ';

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

  pnl_recebido.Caption:= 'RECEBIDO - ' + THelper.ExtendedToString(TAuthService.vRecebido) + '  ';
  pnl_troco.Caption:= 'TROCO - ' + THelper.ExtendedToString(TAuthService.vTroco) + '  ';
  edt_valor.Text:= THelper.ExtendedToString(TAuthService.vRestante);
  edt_valor.SelectAll;
end;

procedure TformVendaFinalizar.tmr_focusTimer(Sender: TObject);
begin
  try
    if (pnl_valor.Visible) and
       (not edt_valor.Focused) then edt_valor.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
