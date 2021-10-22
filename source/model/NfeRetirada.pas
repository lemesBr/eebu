unit NfeRetirada;

interface

uses
  Model, Classes, Generics.Collections, SysUtils;

type
  TNfeRetirada = class(TModel)
  private
    FID: String;
    FEMPRESA_ID: String;
    FNFE_ID: String;
    FCNPJCPF: String;
    FXLGR: String;
    FNRO: String;
    FXCPL: String;
    FXBAIRRO: String;
    FCMUN: String;
    FXMUN: String;
    FUF: String;
    FCREATED_AT: TDateTime;
    FUPDATED_AT: TDateTime;
    FDELETED_AT: TDateTime;
    FSYNCHRONIZED: String;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function find(id: string): TNfeRetirada;

    property Id: String  read FID write FID;
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeId: String  read FNFE_ID write FNFE_ID;
    property Cnpjcpf: String  read FCNPJCPF write FCNPJCPF;
    property Xlgr: String  read FXLGR write FXLGR;
    property Nro: String  read FNRO write FNRO;
    property Xcpl: String  read FXCPL write FXCPL;
    property Xbairro: String  read FXBAIRRO write FXBAIRRO;
    property Cmun: String  read FCMUN write FCMUN;
    property Xmun: String  read FXMUN write FXMUN;
    property Uf: String  read FUF write FUF;
    property CreatedAt: TDateTime  read FCREATED_AT write FCREATED_AT;
    property UpdatedAt: TDateTime  read FUPDATED_AT write FUPDATED_AT;
    property DeletedAt: TDateTime  read FDELETED_AT write FDELETED_AT;
    property Synchronized: String  read FSYNCHRONIZED write FSYNCHRONIZED;

  end;

implementation



{ TNfeRetirada }

constructor TNfeRetirada.Create;
begin
  Self.Table:= 'NFE_RETIRADA';
end;

class function TNfeRetirada.find(id: string): TNfeRetirada;
begin

end;

function TNfeRetirada.save: Boolean;
begin
  if (self.FID = EmptyStr) then
    Result:= Self.store
  else Result:= Self.update;
end;

function TNfeRetirada.store: Boolean;
begin

end;

function TNfeRetirada.update: Boolean;
begin

end;

end.
