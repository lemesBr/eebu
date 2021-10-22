unit NfeDetArma;

interface

uses
  Model, Classes, Generics.Collections, SysUtils;

type
  TNfeDetArma = class(TModel)
  private
    FID: String;
    FEMPRESA_ID: String;
    FNFE_DET_ID: String;
    FTPARMA: String;
    FNSERIE: String;
    FNCANO: String;
    FDESCR: String;
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
    class function find(id: string): TNfeDetArma;

    property Id: String  read FID write FID;
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeDetId: String  read FNFE_DET_ID write FNFE_DET_ID;
    property Tparma: String  read FTPARMA write FTPARMA;
    property Nserie: String  read FNSERIE write FNSERIE;
    property Ncano: String  read FNCANO write FNCANO;
    property Descr: String  read FDESCR write FDESCR;
    property CreatedAt: TDateTime  read FCREATED_AT write FCREATED_AT;
    property UpdatedAt: TDateTime  read FUPDATED_AT write FUPDATED_AT;
    property DeletedAt: TDateTime  read FDELETED_AT write FDELETED_AT;
    property Synchronized: String  read FSYNCHRONIZED write FSYNCHRONIZED;

  end;

implementation



{ TNfeDetArma }

constructor TNfeDetArma.Create;
begin
  Self.Table:= 'NFE_DET_ARMA';
end;

class function TNfeDetArma.find(id: string): TNfeDetArma;
begin

end;

function TNfeDetArma.save: Boolean;
begin
  if (self.FID = EmptyStr) then
    Result:= Self.store
  else Result:= Self.update;
end;

function TNfeDetArma.store: Boolean;
begin

end;

function TNfeDetArma.update: Boolean;
begin

end;

end.
