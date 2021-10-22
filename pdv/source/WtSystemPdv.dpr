program WtSystemPdv;

uses
  Vcl.Forms,
  uformPrincipal in 'form\uformPrincipal.pas' {formPrincipal},
  Conexao in 'db\Conexao.pas',
  AuthService in 'service\AuthService.pas',
  Helper in 'helper\Helper.pas',
  uformBase in 'form\uformBase.pas' {formBase},
  uformMensagem in 'form\uformMensagem.pas' {formMensagem},
  Movimento in 'model\Movimento.pas',
  Terminal in 'model\Terminal.pas',
  uformStartConfig in 'form\uformStartConfig.pas' {formStartConfig},
  udmServidor in 'dm\udmServidor.pas' {dmServidor: TDataModule},
  Model in 'model\Model.pas',
  Empresa in 'model\Empresa.pas',
  Pessoa in 'model\Pessoa.pas',
  Item in 'model\Item.pas',
  Cartao in 'model\Cartao.pas',
  User in 'model\User.pas',
  Ncm in 'model\Ncm.pas',
  Turno in 'model\Turno.pas',
  uformAbrirMovimento in 'form\uformAbrirMovimento.pas' {formAbrirMovimento},
  uformMovimentoAberto in 'form\uformMovimentoAberto.pas' {formMovimentoAberto},
  Suprimento in 'model\Suprimento.pas',
  Sangria in 'model\Sangria.pas',
  Venda in 'model\Venda.pas',
  VendaItem in 'model\VendaItem.pas',
  VendaRecebimento in 'model\VendaRecebimento.pas',
  Recebimento in 'model\Recebimento.pas',
  CustomEditHelper in 'helper\CustomEditHelper.pas',
  uformVendaFinalizar in 'form\uformVendaFinalizar.pas' {formVendaFinalizar},
  uformCartaoParcelamento in 'form\uformCartaoParcelamento.pas' {formCartaoParcelamento},
  uformVendaParcelamento in 'form\uformVendaParcelamento.pas' {formVendaParcelamento},
  udmRepository in 'dm\udmRepository.pas' {dmRepository: TDataModule},
  uformSuprimento in 'form\uformSuprimento.pas' {formSuprimento},
  uformSangria in 'form\uformSangria.pas' {formSangria},
  uformItemList in 'form\uformItemList.pas' {formItemList},
  uformPessoaList in 'form\uformPessoaList.pas' {formPessoaList},
  uformManutencaoVendas in 'form\uformManutencaoVendas.pas' {formManutencaoVendas},
  uformFecharMovimento in 'form\uformFecharMovimento.pas' {formFecharMovimento},
  MovimentoFechamento in 'model\MovimentoFechamento.pas',
  uformMovimentoList in 'form\uformMovimentoList.pas' {formMovimentoList},
  MovimentoResumo in 'model\MovimentoResumo.pas',
  Nfe in 'model\Nfe.pas',
  NfeDet in 'model\NfeDet.pas',
  NfeDetIcms in 'model\NfeDetIcms.pas',
  NfeDetIpi in 'model\NfeDetIpi.pas',
  NfeDetPis in 'model\NfeDetPis.pas',
  NfeDetCofins in 'model\NfeDetCofins.pas',
  NfeTotalIcms in 'model\NfeTotalIcms.pas',
  NfePag in 'model\NfePag.pas',
  NfeConfiguracao in 'model\NfeConfiguracao.pas',
  uformNfeConfiguracaoCreateEdit in 'form\uformNfeConfiguracaoCreateEdit.pas' {formNfeConfiguracaoCreateEdit},
  uformManutencaoNFCe in 'form\uformManutencaoNFCe.pas' {formManutencaoNFCe},
  uformDescription in 'form\uformDescription.pas' {formDescription},
  BalancaConfiguracao in 'model\BalancaConfiguracao.pas',
  uformBalancaConfiguracaoCreateEdit in 'form\uformBalancaConfiguracaoCreateEdit.pas' {formBalancaConfiguracaoCreateEdit};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmRepository, dmRepository);
  Application.CreateForm(TdmServidor, dmServidor);
  Application.CreateForm(TformPrincipal, formPrincipal);
  Application.Run;
end.
