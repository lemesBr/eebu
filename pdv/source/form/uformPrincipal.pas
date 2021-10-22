unit uformPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  ACBrUtil, Vcl.Imaging.pngimage, System.Math;

type
  TformPrincipal = class(TForm)
    timer: TTimer;
    pnl_right: TPanel;
    pnl_center: TPanel;
    pnl_main: TPanel;
    pnl_footer: TPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label1: TLabel;
    lb_subtotal: TLabel;
    ed_lancamento: TEdit;
    fdmt_itens: TFDMemTable;
    fdmt_itensID: TStringField;
    fdmt_itensITEM: TIntegerField;
    fdmt_itensREFERENCIA: TIntegerField;
    fdmt_itensNOME: TStringField;
    fdmt_itensUNITARIO: TFloatField;
    fdmt_itensQTDE: TFloatField;
    fdmt_itensSUBTOTAL: TFloatField;
    fdmt_itensACRESCIMO: TFloatField;
    fdmt_itensDESCONTO: TFloatField;
    fdmt_itensTOTAL: TFloatField;
    mem_itens: TMemo;
    Image1: TImage;
    pnl_lancamento: TPanel;
    Bevel3: TBevel;
    fdmt_itensUNIDADE: TStringField;
    procedure timerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ed_lancamentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ed_lancamentoKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure novaVenda();
    procedure novoItem(pItem: string; pQtd: Extended = 1; pPeso: string = 'S');
    procedure calculaTotal();
    procedure writeItem();
    procedure writeAllItem();
    function cancelarVenda(): Boolean;
  public
    { Public declarations }
  end;

var
  formPrincipal: TformPrincipal;

implementation

uses
  AuthService, udmServidor, Helper, uformAbrirMovimento, uformMovimentoAberto,
  Venda, Item, VendaItem, uformVendaFinalizar, uformSuprimento, uformSangria,
  uformItemList, uformPessoaList, uformManutencaoVendas, uformFecharMovimento,
  uformMovimentoList, uformNfeConfiguracaoCreateEdit, uformManutencaoNFCe,
  uformBalancaConfiguracaoCreateEdit;

{$R *.dfm}

procedure TformPrincipal.calculaTotal;
var
  vSubTotal: Extended;
begin
  vSubTotal:= 0;
  fdmt_itens.DisableControls();
  fdmt_itens.First();
  while not fdmt_itens.Eof do
  begin
    vSubTotal:= (vSubTotal + fdmt_itensSUBTOTAL.AsExtended);
    fdmt_itens.Next();
  end;
  fdmt_itens.First();
  fdmt_itens.EnableControls();

  lb_subtotal.Caption:= THelper.ExtendedToString(vSubTotal);

  TAuthService.Venda.Subtotal:= vSubTotal;
end;

function TformPrincipal.cancelarVenda(): Boolean;
begin
  Result:= False;
  try
    if not THelper.Mensagem('Deseja realmente cancelar a venda?', 1) then Exit();

    TAuthService.Venda.Situacao:= 'C';
    TAuthService.Venda.Acrescimo:= 0;
    TAuthService.Venda.Desconto:= 0;
    TAuthService.Venda.Total:= 0;
    TAuthService.Venda.save();

    FreeAndNil(TAuthService.Venda);
    Result:= True;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformPrincipal.ed_lancamentoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  vValue: string;
  vS01: string;
  vS02: string;
  vQtd: Extended;
  vItem: string;
  vVendaItem: TVendaItem;
  I: Integer;
begin
  case Key of
    13: begin
      vValue:= Trim(ed_lancamento.Text) + '*';
      if (vValue = '*') and (fdmt_itens.RecordCount >= 1) then
      begin
        TAuthService.Venda.freeItens();
        try
          formVendaFinalizar:= TformVendaFinalizar.Create(nil);
          formVendaFinalizar.ShowModal();
        finally
          FreeAndNil(formVendaFinalizar);
        end;

        if not Assigned(TAuthService.Venda) then
        begin
          novaVenda();
          TVendaItem.findByVenda(TAuthService.Venda.Id, fdmt_itens);
          writeAllItem();
          calculaTotal();
        end;

        Exit();
      end
      else if (vValue = '*') then Exit();

      vS01:= THelper.DevolveConteudoDelimitado('*', vValue);
      if (vValue = '') then
      begin
        if (vS01.Length >= 10) and
          Assigned(TAuthService.Terminal.Balanca) and
          (vS01.Length = TAuthService.Terminal.Balanca.Digitos) and
          (vS01[1] = TAuthService.Terminal.Balanca.DigitoInicial.ToString()) then
        begin
          vItem:= '';
          for I:= TAuthService.Terminal.Balanca.ProdutoDigitoInicial to TAuthService.Terminal.Balanca.ProdutoDigitoFinal do
            vItem:= vItem + vS01[I];

          vS02:= '';
          for I:= TAuthService.Terminal.Balanca.PesoDigitoInicial to TAuthService.Terminal.Balanca.PesoDigitoFinal do
          begin
            vS02:= vS02 + vS01[I];
            if (I + TAuthService.Terminal.Balanca.PesoDigitosDecimal) = TAuthService.Terminal.Balanca.PesoDigitoFinal then
              vS02:= vS02 + ',';
          end;

          vQtd:= StrToFloatDef(vS02, 1);
          novoItem(vItem, vQtd, TAuthService.Terminal.Balanca.Peso);
        end
        else
        begin
          vItem:= vS01;
          novoItem(vItem);
        end;
      end
      else
      begin
        vS02:= THelper.DevolveConteudoDelimitado('*', vValue);
        vQtd:= StrToFloatDef(vS01, 1);
        vItem:= vS02;
        novoItem(vItem, vQtd);
      end;
    end;
    113: begin
      if (fdmt_itens.RecordCount >= 1) then Exit();

      try
        formSuprimento:= TformSuprimento.Create(nil);
        formSuprimento.ShowModal();
      finally
        FreeAndNil(formSuprimento);
      end;
    end;
    114: begin
      if (fdmt_itens.RecordCount >= 1) then Exit();

      try
        formSangria:= TformSangria.Create(nil);
        formSangria.ShowModal();
      finally
        FreeAndNil(formSangria);
      end;
    end;
    115: begin
      if not (fdmt_itens.RecordCount >= 1) then Exit();

      if cancelarVenda() then
      begin
        novaVenda();
        TVendaItem.findByVenda(TAuthService.Venda.Id, fdmt_itens);
        writeAllItem();
        calculaTotal();
      end;
    end;
    116: begin
      if not (fdmt_itens.RecordCount >= 1) then Exit();
      vValue:= Trim(ed_lancamento.Text);
      if (StrToIntDef(vValue, 0) = 0) then Exit();

      if fdmt_itens.Locate('ITEM',vValue,[]) then
      begin
        if THelper.Mensagem('Deseja realmente remover o item ' + vValue + '?', 1) then
        begin
          try
            vVendaItem:= TVendaItem.find(fdmt_itensID.AsString);
            if Assigned(vVendaItem) and vVendaItem.delete() then
            begin
              vVendaItem.Acrescimo:= 0;
              vVendaItem.Desconto:= 0;
              vVendaItem.Total:= 0;
              vVendaItem.save();

              mem_itens.Lines.Add(
                'ITEM ' + vValue + ' CANCELADO' +
                THelper.StrDireita('-' +THelper.ExtendedToString(fdmt_itensSUBTOTAL.AsExtended), 28)
              );

              fdmt_itens.Edit();
              fdmt_itensSUBTOTAL.AsExtended:= 0;
              fdmt_itensACRESCIMO.AsExtended:= 0;
              fdmt_itensDESCONTO.AsExtended:= 0;
              fdmt_itensTOTAL.AsExtended:= 0;
              fdmt_itens.Post();

              calculaTotal();
              ed_lancamento.Text:= '';

              FreeAndNil(vVendaItem);
            end;
          except on e: Exception do
            THelper.Mensagem(e.Message);
          end;
        end;
      end;
    end;
    117: begin
      TAuthService.ItemReferencia:= 0;
      try
        formItemList:= TformItemList.Create(nil);
        formItemList.ShowModal();
      finally
        FreeAndNil(formItemList);
      end;

      if (TAuthService.ItemReferencia > 0) then
        ed_lancamento.Text:= '*' + TAuthService.ItemReferencia.ToString();
    end;
    118: begin
      TAuthService.PessoaId:= EmptyStr;
      try
        formPessoaList:= TformPessoaList.Create(nil);
        formPessoaList.ShowModal();
      finally
        FreeAndNil(formPessoaList);
      end;

      if (TAuthService.PessoaId <> EmptyStr) then
      begin
        try
          TAuthService.Venda.PessoaId:= TAuthService.PessoaId;
          TAuthService.Venda.save();
          THelper.Mensagem('Pessoa identificada com sucesso.');
        except on e: Exception do
          THelper.Mensagem(e.Message);
        end;
      end;
    end;
    119: begin
      if (fdmt_itens.RecordCount >= 1) then Exit();

      if THelper.Mensagem('Deseja importar dados para o sistema de venda?', 1) then
        dmServidor.importData();
    end;
    120: begin
      if (fdmt_itens.RecordCount >= 1) then Exit();

      try
        formManutencaoVendas:= TformManutencaoVendas.Create(nil);
        formManutencaoVendas.ShowModal();
      finally
        FreeAndNil(formManutencaoVendas);
      end;
    end;
    121: begin
      if (fdmt_itens.RecordCount >= 1) then Exit();

      try
        formManutencaoNFCe:= TformManutencaoNFCe.Create(nil);
        formManutencaoNFCe.ShowModal();
      finally
        FreeAndNil(formManutencaoNFCe);
      end;
    end;
    122: begin
      if (fdmt_itens.RecordCount >= 1) then Exit();

      try
        formFecharMovimento:= TformFecharMovimento.Create(nil);
        formFecharMovimento.ShowModal();
      finally
        FreeAndNil(formFecharMovimento);
      end;

      timer.Enabled:= not Assigned(TAuthService.Terminal);
    end;
    123: begin
      if (fdmt_itens.RecordCount >= 1) then Exit();

      if THelper.Mensagem('Deseja realmente fechar o sistema?', 1) then
        Application.Terminate();
    end;
  end;

  if (Shift = [ssCtrl]) and (Key = 69) then
  begin
    try
      formMovimentoList:= TformMovimentoList.Create(nil);
      formMovimentoList.ShowModal();
    finally
      FreeAndNil(formMovimentoList);
    end;
  end;

  if (Shift = [ssCtrl]) and (Key = 78) then
  begin
    try
      formNfeConfiguracaoCreateEdit:= TformNfeConfiguracaoCreateEdit.Create(nil);
      formNfeConfiguracaoCreateEdit.ShowModal();
    finally
      FreeAndNil(formNfeConfiguracaoCreateEdit);
    end;
  end;

  if (Shift = [ssCtrl]) and (Key = 66) then
  begin
    try
      formBalancaConfiguracaoCreateEdit:= TformBalancaConfiguracaoCreateEdit.Create(nil);
      formBalancaConfiguracaoCreateEdit.ShowModal();
    finally
      FreeAndNil(formBalancaConfiguracaoCreateEdit);
    end;
  end;
end;

procedure TformPrincipal.ed_lancamentoKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9',',','*',#8]) then
    Key:= #0;
end;

procedure TformPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Abort();
end;

procedure TformPrincipal.FormDestroy(Sender: TObject);
begin
  FreeAndNil(TAuthService.Venda);
end;

procedure TformPrincipal.FormShow(Sender: TObject);
begin
  timer.Enabled:= True;
end;

procedure TformPrincipal.novaVenda;
var
  vVenda: TVenda;
begin
  try
    vVenda:= TVenda.Create;
    try
      vVenda.PessoaId:= TAuthService.Terminal.PessoaId;
      vVenda.Competencia:= Now();
      vVenda.Situacao:= 'A';
      vVenda.save();

      TAuthService.Venda:= TVenda.find(vVenda.Id);
    except on e: Exception do
      THelper.Mensagem(e.Message);
    end;
  finally
    FreeAndNil(vVenda);
  end;
end;

procedure TformPrincipal.novoItem(pItem: string; pQtd: Extended; pPeso: string);
var
  vItem: TItem;
  vVendaItem: TVendaItem;
  vReferencia: Integer;
begin
  try
    vItem:= nil;
    vVendaItem:= nil;
    try
      if (pItem.Length >= 7) then
        vItem:= TItem.findByEan(pItem);

      if not Assigned(vItem) then
      begin
        vReferencia:= StrToIntDef(pItem, 0);
        vItem:= TItem.findByReferencia(vReferencia);
      end;

      if not Assigned(vItem) then
        raise Exception.Create('Item informado inexistente.');

      if (pPeso = 'N') then
        pQtd:= THelper.TruncateValue((pQtd / vItem.PrecoVenda), 4);

      vVendaItem:= TVendaItem.Create;
      vVendaItem.UserId:= TAuthService.Venda.UserId;
      vVendaItem.VendaId:= TAuthService.Venda.Id;
      vVendaItem.ItemId:= vItem.Id;
      vVendaItem.Unitario:= vItem.PrecoVenda;
      vVendaItem.Qtde:= pQtd;
      vVendaItem.Subtotal:= THelper.TruncateValue(SimpleRoundTo((vVendaItem.Unitario * vVendaItem.Qtde)), 2);
      vVendaItem.Acrescimo:= 0;
      vVendaItem.Desconto:= 0;
      vVendaItem.Total:= vVendaItem.Subtotal;
      vVendaItem.save();

      fdmt_itens.Last();
      fdmt_itens.Append();
      fdmt_itens.FieldByName('ID').AsString:= vVendaItem.Id;
      fdmt_itens.FieldByName('ITEM').AsInteger:= (fdmt_itens.RecordCount + 1);
      fdmt_itens.FieldByName('REFERENCIA').AsInteger:= vVendaItem.Item.Referencia;
      fdmt_itens.FieldByName('NOME').AsString:= vVendaItem.Item.Nome;
      fdmt_itens.FieldByName('UNIDADE').AsString:= vVendaItem.Item.Unidade;
      fdmt_itens.FieldByName('UNITARIO').AsExtended:= vVendaItem.Unitario;
      fdmt_itens.FieldByName('QTDE').AsExtended:= vVendaItem.Qtde;
      fdmt_itens.FieldByName('SUBTOTAL').AsExtended:= vVendaItem.Subtotal;
      fdmt_itens.FieldByName('ACRESCIMO').AsExtended:= vVendaItem.Acrescimo;
      fdmt_itens.FieldByName('DESCONTO').AsExtended:= vVendaItem.Desconto;
      fdmt_itens.FieldByName('TOTAL').AsExtended:= vVendaItem.Total;
      fdmt_itens.Post();

      writeItem();

      calculaTotal();

      ed_lancamento.Text:= '';
      ed_lancamento.SetFocus;
    except on e: Exception do
      THelper.Mensagem(e.Message);
    end;
  finally
    FreeAndNil(vItem);
    FreeAndNil(vVendaItem);
  end;
end;

procedure TformPrincipal.timerTimer(Sender: TObject);
begin
  timer.Enabled:= False;
  TAuthService.identify();
  if not Assigned(TAuthService.Terminal) then
  begin
    THelper.Mensagem('Falha ao consultar dados do terminal.');
    Application.Terminate();
  end;

  if not Assigned(TAuthService.Terminal.Movimento) then
  begin
    try
      formAbrirMovimento:= TformAbrirMovimento.Create(nil);
      formAbrirMovimento.ShowModal();
    finally
      FreeAndNil(formAbrirMovimento);
    end;
  end
  else
  begin
    try
      formMovimentoAberto:= TformMovimentoAberto.Create(nil);
      formMovimentoAberto.ShowModal();
    finally
      FreeAndNil(formMovimentoAberto);
    end;
  end;

  if not TAuthService.Authenticated then
  begin
    Application.Terminate();
    Exit();
  end;

  TAuthService.Venda:= TVenda.findOpen();
  if not Assigned(TAuthService.Venda) then
    novaVenda();

  TVendaItem.findByVenda(TAuthService.Venda.Id, fdmt_itens);
  writeAllItem();
  calculaTotal();
end;

procedure TformPrincipal.writeAllItem;
begin
  mem_itens.Lines.Clear();

  fdmt_itens.DisableControls();
  fdmt_itens.First();
  while not fdmt_itens.Eof do
  begin
    writeItem();
    fdmt_itens.Next();
  end;
  fdmt_itens.First();
  fdmt_itens.EnableControls();
end;

procedure TformPrincipal.writeItem;
begin
  mem_itens.Lines.Add(
    THelper.StrEsquerda(PadLeft(fdmt_itensITEM.AsString,3, '0'), 3) + ' ' +
    THelper.StrEsquerda(PadLeft(fdmt_itensREFERENCIA.AsString,7, '0'), 7) + ' ' +
    THelper.StrEsquerda(fdmt_itensNOME.AsString, 40) + ' ' +
    THelper.StrDireita(THelper.ExtendedToString(fdmt_itensQTDE.AsExtended, False), 10) + ' ' +
    THelper.StrEsquerda(fdmt_itensUNIDADE.AsString, 6) + '  X' +
    THelper.StrDireita(THelper.ExtendedToString(fdmt_itensUNITARIO.AsExtended), 10) + ' ' +
    THelper.StrDireita(THelper.ExtendedToString(fdmt_itensSUBTOTAL.AsExtended), 10)
  );
end;

initialization
  {$IFDEF RELEASE}
    ReportMemoryLeaksOnShutdown:= False;
  {$ELSE}
    ReportMemoryLeaksOnShutdown:= True;
  {$ENDIF}

end.
