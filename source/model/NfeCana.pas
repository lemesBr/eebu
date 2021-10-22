unit NfeCana;

interface

uses
  Model, Classes, Generics.Collections, SysUtils;

type
  TNfeCana = class(TModel)
  private
    FID: String;
    FEMPRESA_ID: String;
    FNFE_ID: String;
    FSAFRA: String;
    FREF: String;
    FQTOTMES: Extended;
    FQTOTANT: Extended;
    FQTOTGER: Extended;
    FVFOR: Extended;
    FVTOTDED: Extended;
    FVLIQFOR: Extended;
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
    class function find(id: string): TNfeCana;

    property Id: String  read FID write FID;
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeId: String  read FNFE_ID write FNFE_ID;
    property Safra: String  read FSAFRA write FSAFRA;
    property Ref: String  read FREF write FREF;
    property Qtotmes: Extended  read FQTOTMES write FQTOTMES;
    property Qtotant: Extended  read FQTOTANT write FQTOTANT;
    property Qtotger: Extended  read FQTOTGER write FQTOTGER;
    property Vfor: Extended  read FVFOR write FVFOR;
    property Vtotded: Extended  read FVTOTDED write FVTOTDED;
    property Vliqfor: Extended  read FVLIQFOR write FVLIQFOR;
    property CreatedAt: TDateTime  read FCREATED_AT write FCREATED_AT;
    property UpdatedAt: TDateTime  read FUPDATED_AT write FUPDATED_AT;
    property DeletedAt: TDateTime  read FDELETED_AT write FDELETED_AT;
    property Synchronized: String  read FSYNCHRONIZED write FSYNCHRONIZED;

  end;

implementation



{ TNfeCana }

constructor TNfeCana.Create;
begin
  Self.Table:= 'NFE_CANA';
end;

class function TNfeCana.find(id: string): TNfeCana;
begin

end;

function TNfeCana.save: Boolean;
begin
  if (self.FID = EmptyStr) then
    Result:= Self.store
  else Result:= Self.update;
end;

function TNfeCana.store: Boolean;
begin

end;

function TNfeCana.update: Boolean;
begin

end;

end.
