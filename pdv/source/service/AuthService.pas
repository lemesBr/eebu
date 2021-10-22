unit AuthService;

interface

uses
  System.SysUtils, Generics.Collections, Terminal, Venda, Recebimento;

type
  TAuthService = class
  private
    class procedure ReleaseInstance();
  public
    class var Terminal: TTerminal;
    class var Authenticated: Boolean;
    class var Venda: TVenda;
    class var vSubtotal: Currency;
    class var vDesconto: Currency;
    class var pDesconto: Currency;
    class var vAcrescimo: Currency;
    class var pAcrescimo: Currency;
    class var vTotal: Currency;
    class var vRecebido: Currency;
    class var vRestante: Currency;
    class var vTroco: Currency;
    class var lParcelas: TObjectList<TRecebimento>;
    class var listCtRecebimento: TObjectList<TRecebimento>;
    class var TipoMensagem: Integer;
    class var Screen: Boolean;
    class var Width: Integer;
    class var Height: Integer;
    class var ItemReferencia: Integer;
    class var PessoaId: string;
    class var Description: string;
    class var lVendas: string;
    class var NfeId: string;

    class procedure identify();
  end;

implementation

{ TAuthService }

uses Helper, uformStartConfig, udmServidor;

class procedure TAuthService.identify;
var
  Authentication: string;
begin
  if Assigned(Self.Terminal) then
    Exit();

  Authentication:= THelper.SerialDrive('C');
  Authentication:= THelper.MD5String(Authentication);
  Authentication:= UpperCase(Authentication);

  Self.Terminal:= TTerminal.findByAuthentication(Authentication);

  if not Assigned(Self.Terminal) then
  begin
    try
      formStartConfig:= TformStartConfig.Create(nil);
      formStartConfig.lbe_authentication.Text:= Authentication;
      formStartConfig.ShowModal();
    finally
      FreeAndNil(formStartConfig);
    end;

    Self.Terminal:= TTerminal.findByAuthentication(Authentication);
    if Assigned(Self.Terminal) then
      dmServidor.importData();
  end;
end;

class procedure TAuthService.ReleaseInstance;
begin
  if Assigned(Self.Terminal) then
    FreeAndNil(Self.Terminal);
end;

initialization
finalization
  TAuthService.ReleaseInstance();

end.
