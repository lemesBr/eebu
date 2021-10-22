unit NfeCompra;

interface

uses
  Model, Classes, Generics.Collections, SysUtils;

type
  TNfeCompra = class(TModel)
  private
    FID: String;
    FEMPRESA_ID: String;
    FNFE_ID: String;
    FXNEMP: String;
    FXPED: String;
    FXCONT: String;
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
    class function find(id: string): TNfeCompra;

    property Id: String  read FID write FID;
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeId: String  read FNFE_ID write FNFE_ID;
    property Xnemp: String  read FXNEMP write FXNEMP;
    property Xped: String  read FXPED write FXPED;
    property Xcont: String  read FXCONT write FXCONT;
    property CreatedAt: TDateTime  read FCREATED_AT write FCREATED_AT;
    property UpdatedAt: TDateTime  read FUPDATED_AT write FUPDATED_AT;
    property DeletedAt: TDateTime  read FDELETED_AT write FDELETED_AT;
    property Synchronized: String  read FSYNCHRONIZED write FSYNCHRONIZED;

  end;

implementation



{ TNfeCompra }

constructor TNfeCompra.Create;
begin
  Self.Table:= 'NFE_COMPRA';
end;

class function TNfeCompra.find(id: string): TNfeCompra;
begin

end;

function TNfeCompra.save: Boolean;
begin
  if (self.FID = EmptyStr) then
    Result:= Self.store
  else Result:= Self.update;
end;

function TNfeCompra.store: Boolean;
begin

end;

function TNfeCompra.update: Boolean;
begin

end;

end.
