unit Conexao;

interface

uses
  System.Classes, System.SysUtils, Vcl.Forms,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TConexao = class(TFDConnection)
  strict private
    class var FInstance: TConexao;
    class procedure AutoConfig(Conexao: TFDConnection);
  private
    class procedure ReleaseInstance();
  public
    class function GetInstance(): TConexao;
  end;

implementation

{ TConexao }

class procedure TConexao.AutoConfig(Conexao: TFDConnection);
begin
  Conexao.Params.LoadFromFile(ExtractFilePath(Application.ExeName) + 'FDCFirebird.ini');
  Conexao.Connected:= True;
end;

class function TConexao.GetInstance: TConexao;
begin
  if not Assigned(Self.FInstance) then
  begin
    Self.FInstance:= TConexao.Create(nil);
    Self.AutoConfig(Self.FInstance);
  end;
  Result:= Self.FInstance;
end;

class procedure TConexao.ReleaseInstance;
begin
  if Assigned(Self.FInstance) then
    Self.FInstance.Free;
end;

initialization
finalization
  TConexao.ReleaseInstance();

end.
