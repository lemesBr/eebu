unit uformPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.Menus,
  System.Actions, Vcl.ActnList, Vcl.Ribbon, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan, Vcl.RibbonLunaStyleActnCtrls, Vcl.ToolWin, Vcl.ActnCtrls, MidasLib,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.ActnMenus, Vcl.RibbonActnMenus,
  Vcl.ComCtrls, System.DateUtils;

type
  TformPrincipal = class(TformBase)
    Ribbon: TRibbon;
    acl_principal: TActionManager;
    RibbonPage1: TRibbonPage;
    RibbonPage2: TRibbonPage;
    RibbonPage3: TRibbonPage;
    RibbonPage4: TRibbonPage;
    RibbonPage5: TRibbonPage;
    act_empresa: TAction;
    act_contabilista: TAction;
    act_unidades: TAction;
    act_ncms: TAction;
    act_pagamentos: TAction;
    act_recebimentos: TAction;
    act_contas: TAction;
    act_categorias: TAction;
    act_remessa: TAction;
    act_retorno: TAction;
    act_nfe_configuracoes: TAction;
    act_operacoes_fiscais: TAction;
    act_grupos_tributarios: TAction;
    act_configuracoes_fiscais: TAction;
    act_nfe: TAction;
    act_logout: TAction;
    act_users: TAction;
    act_roles: TAction;
    act_permissions: TAction;
    act_vendas_orcamentos: TAction;
    act_itens: TAction;
    act_pessoas: TAction;
    RibbonGroup1: TRibbonGroup;
    RibbonGroup3: TRibbonGroup;
    RibbonGroup5: TRibbonGroup;
    RibbonGroup6: TRibbonGroup;
    RibbonGroup9: TRibbonGroup;
    RibbonGroup12: TRibbonGroup;
    act_sair: TAction;
    act_empresa_configuracao: TAction;
    act_nfe_infcpl: TAction;
    act_nfe_infadfisco: TAction;
    act_compras_orcamentos: TAction;
    act_estoque: TAction;
    act_nfe_recebidas: TAction;
    pnl_theme: TPanel;
    img_theme: TImage;
    RibbonApplicationMenuBar: TRibbonApplicationMenuBar;
    statusb: TStatusBar;
    timer: TTimer;
    act_nfe_empresa: TAction;
    act_sped: TAction;
    act_cartoes: TAction;
    act_plano: TAction;
    pnl_aviso: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    btn_plano: TButton;
    RibbonGroup2: TRibbonGroup;
    RibbonGroup4: TRibbonGroup;
    RibbonGroup7: TRibbonGroup;
    RibbonPage6: TRibbonPage;
    RibbonGroup8: TRibbonGroup;
    timer_size: TTimer;
    act_nfe_numero: TAction;
    act_terminais: TAction;
    act_turnos: TAction;
    procedure act_vendas_orcamentosExecute(Sender: TObject);
    procedure act_pagamentosExecute(Sender: TObject);
    procedure act_recebimentosExecute(Sender: TObject);
    procedure act_itensExecute(Sender: TObject);
    procedure act_pessoasExecute(Sender: TObject);
    procedure act_contasExecute(Sender: TObject);
    procedure act_categoriasExecute(Sender: TObject);
    procedure act_remessaExecute(Sender: TObject);
    procedure act_retornoExecute(Sender: TObject);
    procedure act_empresaExecute(Sender: TObject);
    procedure act_contabilistaExecute(Sender: TObject);
    procedure act_unidadesExecute(Sender: TObject);
    procedure act_ncmsExecute(Sender: TObject);
    procedure act_logoutExecute(Sender: TObject);
    procedure act_usersExecute(Sender: TObject);
    procedure act_rolesExecute(Sender: TObject);
    procedure act_permissionsExecute(Sender: TObject);
    procedure act_nfe_configuracoesExecute(Sender: TObject);
    procedure act_operacoes_fiscaisExecute(Sender: TObject);
    procedure act_grupos_tributariosExecute(Sender: TObject);
    procedure act_configuracoes_fiscaisExecute(Sender: TObject);
    procedure act_nfeExecute(Sender: TObject);
    procedure act_sairExecute(Sender: TObject);
    procedure act_empresa_configuracaoExecute(Sender: TObject);
    procedure act_nfe_infcplExecute(Sender: TObject);
    procedure act_nfe_infadfiscoExecute(Sender: TObject);
    procedure act_compras_orcamentosExecute(Sender: TObject);
    procedure act_estoqueExecute(Sender: TObject);
    procedure act_nfe_recebidasExecute(Sender: TObject);
    procedure timerTimer(Sender: TObject);
    procedure act_nfe_empresaExecute(Sender: TObject);
    procedure act_spedExecute(Sender: TObject);
    procedure act_cartoesExecute(Sender: TObject);
    procedure act_planoExecute(Sender: TObject);
    procedure timer_sizeTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure act_nfe_numeroExecute(Sender: TObject);
    procedure act_terminaisExecute(Sender: TObject);
    procedure act_turnosExecute(Sender: TObject);
  private
    { Private declarations }
    procedure VerificarValidadeLicenca();
  public
    { Public declarations }
  end;

var
  formPrincipal: TformPrincipal;

implementation

uses
  User, AuthService, uformPessoaList, uformUserList, uformPermissionList,
  uformRoleList, uformAuthLogin, uformEmpresaCreateEdit, uformItemList,
  uformUnidadeList, uformCategoriaList, uformContabilistaCreateEdit,
  uformVendaCreateEdit, uformVendaList, uformNfeConfiguracaoCreateEdit,
  uformOperacaoFiscalList, uformGrupoTributarioList,
  uformConfiguracaoFiscalList, uformNfeList, uformNcmIBPTax,
  uformFormaRecebimentoList, uformRecebimentoList, uformContaList,
  uformPagamentoList, udmRepository, uformBoletoRemessaList,
  uformBoletoRetornoList, uformEmpresaConfiguracaoCreateEdit, uformInfCplList,
  uformInfadfiscoList, uformCompraList, uformEstoqueList, 
  uformNfeRecebidasList, Helper, Wt, uformBloqueio, uformNfeEmpresaList,
  uformSPEDList, uformCartaoList, uformNfeNumeroList, uformTerminalList,
  uformTurnoList;

{$R *.dfm}

procedure TformPrincipal.act_cartoesExecute(Sender: TObject);
var
  v_form: TformCartaoList;
begin
  try
    v_form:= TformCartaoList.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;
end;

procedure TformPrincipal.act_categoriasExecute(Sender: TObject);
begin
  try
    formCategoriaList:= TformCategoriaList.Create(nil);
    formCategoriaList.ShowModal;
  finally
    FreeAndNil(formCategoriaList);
  end;
end;

procedure TformPrincipal.act_compras_orcamentosExecute(Sender: TObject);
var
  v_form: TformCompraList;
begin
  try
    v_form:= TformCompraList.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;
end;

procedure TformPrincipal.act_configuracoes_fiscaisExecute(Sender: TObject);
begin
  try
    formConfiguracaoFiscalList:= TformConfiguracaoFiscalList.Create(nil);
    formConfiguracaoFiscalList.ShowModal;
  finally
    FreeAndNil(formConfiguracaoFiscalList);
  end;
end;

procedure TformPrincipal.act_contabilistaExecute(Sender: TObject);
begin
  try
    formContabilistaCreateEdit:= TformContabilistaCreateEdit.Create(nil);
    formContabilistaCreateEdit.ShowModal;
  finally
    FreeAndNil(formContabilistaCreateEdit);
  end;
end;

procedure TformPrincipal.act_contasExecute(Sender: TObject);
begin
  try
    formContaList:= TformContaList.Create(nil);
    formContaList.ShowModal;
  finally
    FreeAndNil(formContaList);
  end;
end;

procedure TformPrincipal.act_empresaExecute(Sender: TObject);
begin
  try
    formEmpresaCreateEdit:= TformEmpresaCreateEdit.Create(nil);
    formEmpresaCreateEdit.ShowModal;
  finally
    formEmpresaCreateEdit.Free;
  end;
end;

procedure TformPrincipal.act_empresa_configuracaoExecute(Sender: TObject);
begin
  try
    formEmpresaConfiguracaoCreateEdit:= TformEmpresaConfiguracaoCreateEdit.Create(nil);
    formEmpresaConfiguracaoCreateEdit.ShowModal;
  finally
    FreeAndNil(formEmpresaConfiguracaoCreateEdit);
  end;
end;

procedure TformPrincipal.act_estoqueExecute(Sender: TObject);
begin
  try
    formEstoqueList:= TformEstoqueList.Create(nil);
    formEstoqueList.ShowModal;
  finally
    FreeAndNil(formEstoqueList);
  end;
end;

procedure TformPrincipal.act_grupos_tributariosExecute(Sender: TObject);
begin
  try
    formGrupoTributarioList:= TformGrupoTributarioList.Create(nil);
    formGrupoTributarioList.ShowModal;
  finally
    FreeAndNil(formGrupoTributarioList);
  end;
end;

procedure TformPrincipal.act_itensExecute(Sender: TObject);
begin
  try
    formItemList:= TformItemList.Create(nil);
    formItemList.ShowModal;
  finally
    FreeAndNil(formItemList);
  end;
end;

procedure TformPrincipal.act_logoutExecute(Sender: TObject);
var
  User: TUser;
begin
  if TAuthService.logout then
  begin
    try
      formAuthLogin:= TformAuthLogin.Create(nil);
      formAuthLogin.ShowModal;
    finally
      FreeAndNil(formAuthLogin);
    end;

    if not TAuthService.checkAuthentication then
      Application.Terminate
    else
    begin
      if TAuthService.getAuthenticatedEmpresaId = '' then
      begin
        try
          formEmpresaCreateEdit:= TformEmpresaCreateEdit.Create(nil);
          formEmpresaCreateEdit.ShowModal;
        finally
          FreeAndNil(formEmpresaCreateEdit);
        end;

        if TAuthService.getAuthenticatedEmpresaId = '' then
          Application.Terminate;
      end;
    end;

    timer.Enabled:= False;

    User:= TUser.find(TAuthService.getAuthenticatedUserId);
    statusb.Panels.Items[0].Text:= 'EMPRESA: ' + User.Empresa.Nome;
    statusb.Panels.Items[1].Text:= 'FONE: ' + THelper.FONEMask(User.Empresa.Fone);
    statusb.Panels.Items[2].Text:= 'USUARIO: ' + User.Nome;
    statusb.Panels.Items[3].Text:= 'IP: ' + THelper.localIp;
    statusb.Panels.Items[4].Text:= 'DATA: ' + FormatDateTime('dd/mm/yyyy', Now);
    FreeAndNil(User);

    VerificarValidadeLicenca();
    timer.Interval:= 3600000;
    timer.Enabled:= True;
  end;
end;

procedure TformPrincipal.act_ncmsExecute(Sender: TObject);
begin
  try
    formNcmIBPTax:= TformNcmIBPTax.Create(nil);
    formNcmIBPTax.ShowModal;
  finally
    FreeAndNil(formNcmIBPTax);
  end;
end;

procedure TformPrincipal.act_nfeExecute(Sender: TObject);
begin
  try
    formNfeList:= TformNfeList.Create(nil);
    formNfeList.ShowModal;
  finally
    FreeAndNil(formNfeList);
  end;
end;

procedure TformPrincipal.act_nfe_configuracoesExecute(Sender: TObject);
begin
  try
    formNfeConfiguracaoCreateEdit:= TformNfeConfiguracaoCreateEdit.Create(nil);
    formNfeConfiguracaoCreateEdit.ShowModal;
  finally
    FreeAndNil(formNfeConfiguracaoCreateEdit);
  end;
end;

procedure TformPrincipal.act_nfe_empresaExecute(Sender: TObject);
var
  v_form: TformNfeEmpresaList;
begin
  try
    v_form:= TformNfeEmpresaList.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;
end;

procedure TformPrincipal.act_nfe_infadfiscoExecute(Sender: TObject);
var
  v_form: TformInfadfiscoList;
begin
  try
    v_form:= TformInfadfiscoList.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;
end;

procedure TformPrincipal.act_nfe_infcplExecute(Sender: TObject);
var
  v_form: TformInfCplList;
begin
  try
    v_form:= TformInfCplList.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;
end;

procedure TformPrincipal.act_nfe_numeroExecute(Sender: TObject);
var
  v_form: TformNfeNumeroList;
begin
  try
    v_form:= TformNfeNumeroList.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;
end;

procedure TformPrincipal.act_nfe_recebidasExecute(Sender: TObject);
var
  v_form: TformNfeRecebidasList;
begin
  try
    v_form:= TformNfeRecebidasList.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;
end;

procedure TformPrincipal.act_operacoes_fiscaisExecute(Sender: TObject);
begin
  try
    formOperacaoFiscalList:= TformOperacaoFiscalList.Create(nil);
    formOperacaoFiscalList.ShowModal;
  finally
    FreeAndNil(formOperacaoFiscalList);
  end;
end;

procedure TformPrincipal.act_pagamentosExecute(Sender: TObject);
begin
  try
    formPagamentoList:= TformPagamentoList.Create(nil);
    formPagamentoList.ShowModal;
  finally
    FreeAndNil(formPagamentoList);
  end;
end;

procedure TformPrincipal.act_permissionsExecute(Sender: TObject);
begin
  try
    formPermissionList:= TformPermissionList.Create(nil);
    formPermissionList.ShowModal;
  finally
    FreeAndNil(formPermissionList);
  end;
end;

procedure TformPrincipal.act_pessoasExecute(Sender: TObject);
begin
  try
    formPessoaList:= TformPessoaList.Create(nil);
    formPessoaList.ShowModal;
  finally
    FreeAndNil(formPessoaList);
  end;
end;

procedure TformPrincipal.act_planoExecute(Sender: TObject);
var
  v_form: TformBloqueio;
begin
  try
    v_form:= TformBloqueio.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (not TWt.verificarKey) then Application.Terminate();
end;

procedure TformPrincipal.act_recebimentosExecute(Sender: TObject);
begin
  try
    formRecebimentoList:= TformRecebimentoList.Create(nil);
    formRecebimentoList.ShowModal;
  finally
    FreeAndNil(formRecebimentoList);
  end;
end;

procedure TformPrincipal.act_remessaExecute(Sender: TObject);
begin
  try
    formBoletoRemessaList:= TformBoletoRemessaList.Create(nil);
    formBoletoRemessaList.ShowModal;
  finally
    FreeAndNil(formBoletoRemessaList);
  end;
end;

procedure TformPrincipal.act_retornoExecute(Sender: TObject);
begin
  try
    formBoletoRetornoList:= TformBoletoRetornoList.Create(nil);
    formBoletoRetornoList.ShowModal;
  finally
    FreeAndNil(formBoletoRetornoList);
  end;
end;

procedure TformPrincipal.act_rolesExecute(Sender: TObject);
begin
  try
    formRoleList:= TformRoleList.Create(nil);
    formRoleList.ShowModal;
  finally
    FreeAndNil(formRoleList);
  end;
end;

procedure TformPrincipal.act_sairExecute(Sender: TObject);
begin
  Close;
end;

procedure TformPrincipal.act_spedExecute(Sender: TObject);
begin
  try
    formSPEDList:= TformSPEDList.Create(nil);
    formSPEDList.ShowModal;
  finally
    FreeAndNil(formSPEDList);
  end;
end;

procedure TformPrincipal.act_terminaisExecute(Sender: TObject);
var
  vFM: TformTerminalList;
begin
  try
    vFM:= TformTerminalList.Create(nil);
    vFM.ShowModal;
  finally
    FreeAndNil(vFM);
  end;
end;

procedure TformPrincipal.act_turnosExecute(Sender: TObject);
var
  vFM: TformTurnoList;
begin
  try
    vFM:= TformTurnoList.Create(nil);
    vFM.ShowModal;
  finally
    FreeAndNil(vFM);
  end;
end;

procedure TformPrincipal.act_unidadesExecute(Sender: TObject);
begin
  try
    formUnidadeList:= TformUnidadeList.Create(nil);
    formUnidadeList.ShowModal;
  finally
    FreeAndNil(formUnidadeList);
  end;
end;

procedure TformPrincipal.act_usersExecute(Sender: TObject);
begin
  try
    formUserList:= TformUserList.Create(nil);
    formUserList.ShowModal;
  finally
    FreeAndNil(formUserList);
  end;
end;

procedure TformPrincipal.act_vendas_orcamentosExecute(Sender: TObject);
begin
  try
    formVendaList:= TformVendaList.Create(nil);
    formVendaList.ShowModal;
  finally
    FreeAndNil(formVendaList);
  end;
end;

procedure TformPrincipal.FormCreate(Sender: TObject);
begin
  inherited;
  timer_size.Enabled:= True;
end;

procedure TformPrincipal.timerTimer(Sender: TObject);
begin
  timer.Enabled:= False;
  //VerificarValidadeLicenca();
  timer.Interval:= 3600000;
  timer.Enabled:= True;
end;

procedure TformPrincipal.timer_sizeTimer(Sender: TObject);
var
  User: TUser;
begin
  TAuthService.Width:= Self.Width;
  TAuthService.Height:= Self.Height;
  TAuthService.Screen:= True;
  timer_size.Enabled:= False;

  try
    formAuthLogin:= TformAuthLogin.Create(nil);
    formAuthLogin.ShowModal;
  finally
    formAuthLogin.Free;
  end;

  if not TAuthService.checkAuthentication then Application.Terminate
  else
  begin
    if TAuthService.getAuthenticatedEmpresaId = '' then
    begin
      try
        formEmpresaCreateEdit:= TformEmpresaCreateEdit.Create(nil);
        formEmpresaCreateEdit.ShowModal;
      finally
        formEmpresaCreateEdit.Free;
      end;

      if TAuthService.getAuthenticatedEmpresaId = '' then Application.Terminate;
    end;
  end;

  timer.Enabled:= False;

  User:= TUser.find(TAuthService.getAuthenticatedUserId);
  statusb.Panels.Items[0].Text:= 'EMPRESA: ' + User.Empresa.Nome;
  statusb.Panels.Items[1].Text:= 'FONE: ' + THelper.FONEMask(User.Empresa.Fone);
  statusb.Panels.Items[2].Text:= 'USUARIO: ' + User.Nome;
  statusb.Panels.Items[3].Text:= 'IP: ' + THelper.localIp;
  statusb.Panels.Items[4].Text:= 'DATA: ' + FormatDateTime('dd/mm/yyyy', Now);
  FreeAndNil(User);

  //VerificarValidadeLicenca();
  timer.Interval:= 3600000;
  timer.Enabled:= True;
end;

procedure TformPrincipal.VerificarValidadeLicenca;
var
  v_form: TformBloqueio;
  vDays: Integer;
begin
  if (not TWt.verificarKey) then
  begin
    try
      v_form:= TformBloqueio.Create(nil);
      v_form.ShowModal;
    finally
      FreeAndNil(v_form);
    end;

    if (not TWt.verificarKey) then Application.Terminate();
  end;

  if Assigned(TAuthService.License) then
  begin
    vDays:= DaysBetween(Now, TAuthService.License.Expiracao);
    pnl_aviso.Visible:= (vDays <= 5);
  end;
end;

initialization
  {$IFDEF RELEASE}
    ReportMemoryLeaksOnShutdown:= False;
  {$ELSE}
    ReportMemoryLeaksOnShutdown:= True;
  {$ENDIF}

end.
