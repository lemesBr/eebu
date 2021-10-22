unit NfeCanaDeduc;

interface

uses
  Model, Classes, Generics.Collections, SysUtils;

type
  TNfeCanaDeduc = class(TModel)
  private
    FID: String;
    FEMPRESA_ID: String;
    FNFE_CANA_ID: String;
    FXDED: String;
    FVDED: Extended;
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
    class function find(id: string): TNfeCanaDeduc;

    property Id: String  read FID write FID;
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeCanaId: String  read FNFE_CANA_ID write FNFE_CANA_ID;
    property Xded: String  read FXDED write FXDED;
    property Vded: Extended  read FVDED write FVDED;
    property CreatedAt: TDateTime  read FCREATED_AT write FCREATED_AT;
    property UpdatedAt: TDateTime  read FUPDATED_AT write FUPDATED_AT;
    property DeletedAt: TDateTime  read FDELETED_AT write FDELETED_AT;
    property Synchronized: String  read FSYNCHRONIZED write FSYNCHRONIZED;

  end;

implementation



{ TNfeCanaDeduc }

constructor TNfeCanaDeduc.Create;
begin
  Self.Table:= 'NFE_CANA_DEDUC';
end;

class function TNfeCanaDeduc.find(id: string): TNfeCanaDeduc;
begin

end;

function TNfeCanaDeduc.save: Boolean;
begin
  if (self.FID = EmptyStr) then
    Result:= Self.store
  else Result:= Self.update;
end;

function TNfeCanaDeduc.store: Boolean;
begin

end;

function TNfeCanaDeduc.update: Boolean;
begin

end;

end.
