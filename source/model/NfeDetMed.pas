unit NfeDetMed;

interface

uses
  Model, Classes, Generics.Collections, SysUtils;

type
  TNfeDetMed = class(TModel)
  private
    FID: String;
    FEMPRESA_ID: String;
    FNFE_DET_ID: String;
    FCPRODANVISA: String;
    FVPMC: Extended;
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
    class function find(id: string): TNfeDetMed;

    property Id: String  read FID write FID;
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeDetId: String  read FNFE_DET_ID write FNFE_DET_ID;
    property Cprodanvisa: String  read FCPRODANVISA write FCPRODANVISA;
    property Vpmc: Extended  read FVPMC write FVPMC;
    property CreatedAt: TDateTime  read FCREATED_AT write FCREATED_AT;
    property UpdatedAt: TDateTime  read FUPDATED_AT write FUPDATED_AT;
    property DeletedAt: TDateTime  read FDELETED_AT write FDELETED_AT;
    property Synchronized: String  read FSYNCHRONIZED write FSYNCHRONIZED;

  end;

implementation



{ TNfeDetMed }

constructor TNfeDetMed.Create;
begin
  Self.Table:= 'NFE_DET_MED';
end;

class function TNfeDetMed.find(id: string): TNfeDetMed;
begin

end;

function TNfeDetMed.save: Boolean;
begin
  if (self.FID = EmptyStr) then
    Result:= Self.store
  else Result:= Self.update;
end;

function TNfeDetMed.store: Boolean;
begin

end;

function TNfeDetMed.update: Boolean;
begin

end;

end.
