unit AuthService;

interface

uses
  User, System.SysUtils, Generics.Collections, Recebimento,
  EmpresaConfiguracao, Venda, Wt, Compra;

type
  TAuthService = class
  strict private
    class var FUSER: TUser;
    class var FEMPRESACF: TEmpresaConfiguracao;
  private
    class procedure ReleaseInstance();
  public
    class var UserId: string;
    class var RoleId: string;
    class var PermissionId: string;
    class var PessoaId: string;
    class var UnidadeId: string;
    class var CategoriaId: string;
    class var ItemId: string;
    class var VendaId: string;
    class var CompraId: string;
    class var OperacaoFiscalId: string;
    class var GrupoTributarioId: string;
    class var ConfiguracaoFiscalId: string;
    class var ConfiguracaoFiscalIcmsId: string;
    class var NfeId: string;
    class var NfeDetId: string;
    class var Ncm: string;
    class var FormaRecebimentoId: string;
    class var vSubtotal: Currency;
    class var vDesconto: Currency;
    class var pDesconto: Currency;
    class var vAcrescimo: Currency;
    class var pAcrescimo: Currency;
    class var vTotal: Currency;
    class var vRecebido: Currency;
    class var vRestante: Currency;
    class var vTroco: Currency;
    class var ContaId: string;
    class var RecebimentoId: string;
    class var PagamentoId: string;
    class var TipoMensagem: Integer;
    class var TipoCategoria: string;
    class var NfeInfcplId: string;
    class var NfeInfadfiscoId: string;
    class var UnidadeConversaoId: string;
    class var CedenteId: string;
    class var SPEDId: string;
    class var CartaoId: string;
    class var BoletoConfiguracaoId: string;
    class var NfeNumeroId: string;
    class var TerminalId: string;
    class var TurnoId: string;
    class var lParcelas: TObjectList<TRecebimento>;
    class var listCtRecebimento: TObjectList<TRecebimento>;
    class var Description: string;
    class var License: TWt;
    class var lVendas: string;
    class var Venda: TVenda;
    class var Compra: TCompra;
    class var Screen: Boolean;
    class var Width: Integer;
    class var Height: Integer;
    class function userAuthenticate(id: string): Boolean; overload;
    class function userAuthenticate(email, senha: string): Boolean; overload;
    class function checkAuthentication(): Boolean;
    class function getAuthenticatedUserId(): string;
    class function getAuthenticatedEmpresaId(): string;
    class function getAuthenticatedPermission(Permission: string): Boolean;
    class function logout(): Boolean;
    class function getAuthenticatedConfig(pUpdate: Boolean = False): TEmpresaConfiguracao;
  end;

implementation

uses
  Helper, uformEmpresaConfiguracaoCreateEdit;

{ TAuthService }

class function TAuthService.checkAuthentication: Boolean;
begin
  Result:= Assigned(Self.FUSER);
end;

class function TAuthService.getAuthenticatedConfig(pUpdate: Boolean): TEmpresaConfiguracao;
var
  v_form: TformEmpresaConfiguracaoCreateEdit;
begin
  if pUpdate then
    FreeAndNil(Self.FEMPRESACF);

  if not Assigned(Self.FEMPRESACF) then
    Self.FEMPRESACF:= TEmpresaConfiguracao.findByEmpresaId();

  while not Assigned(Self.FEMPRESACF) do
  begin
    try
      v_form:= TformEmpresaConfiguracaoCreateEdit.Create(nil);
      v_form.ShowModal;
    finally
      FreeAndNil(v_form);
    end;

    Self.FEMPRESACF:= TEmpresaConfiguracao.findByEmpresaId();
  end;

  Result:= Self.FEMPRESACF;
end;

class function TAuthService.getAuthenticatedEmpresaId: string;
begin
  if Assigned(Self.FUSER) then
    Result:= Self.FUSER.EmpresaId
  else Result:= EmptyStr;
end;

class function TAuthService.getAuthenticatedPermission(
  Permission: string): Boolean;
var
  I: Integer;
begin
  Result:= False;
  for I := 0 to Pred(Self.FUSER.Permissions.Count) do
    if Self.FUSER.Permissions.Items[I].Permission = Permission then
    begin
      Result:= True;
      Continue;
    end;
end;

class function TAuthService.getAuthenticatedUserId: string;
begin
  if Assigned(Self.FUSER) then
    Result:= Self.FUSER.Id
  else Result:= EmptyStr;
end;

class function TAuthService.logout: Boolean;
begin
  if Assigned(Self.FUSER) then FreeAndNil(Self.FUSER);
  Result:= not Assigned(Self.FUSER);
end;

class procedure TAuthService.ReleaseInstance;
begin
  FreeAndNil(Self.FUSER);
  FreeAndNil(Self.FEMPRESACF);
  FreeAndNil(TAuthService.License);
end;

class function TAuthService.userAuthenticate(id: string): Boolean;
begin
  if Assigned(Self.FUSER) then FreeAndNil(Self.FUSER);
  Self.FUSER:= TUser.find(id);
  Result:= Assigned(Self.FUSER);
end;

class function TAuthService.userAuthenticate(email, senha: string): Boolean;
begin
  if Assigned(Self.FUSER) then
  begin
    FreeAndNil(Self.FUSER);
    FreeAndNil(Self.FEMPRESACF);
  end;
  senha:= THelper.MD5String(email + senha);
  Self.FUSER:= TUser.login(senha);
  Result:= Assigned(Self.FUSER);
end;

initialization
finalization
  TAuthService.ReleaseInstance();

end.
