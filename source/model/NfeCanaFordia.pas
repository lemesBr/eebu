unit NfeCanaFordia;

interface

uses
  Model, Classes, Generics.Collections, SysUtils;

type
  TNfeCanaFordia = class(TModel)
  private
    FID: String;
    FEMPRESA_ID: String;
    FNFE_CANA_ID: String;
    FDIA: Integer;
    FQTDE: Extended;
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
    class function find(id: string): TNfeCanaFordia;

    property Id: String  read FID write FID;
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeCanaId: String  read FNFE_CANA_ID write FNFE_CANA_ID;
    property Dia: Integer  read FDIA write FDIA;
    property Qtde: Extended  read FQTDE write FQTDE;
    property CreatedAt: TDateTime  read FCREATED_AT write FCREATED_AT;
    property UpdatedAt: TDateTime  read FUPDATED_AT write FUPDATED_AT;
    property DeletedAt: TDateTime  read FDELETED_AT write FDELETED_AT;
    property Synchronized: String  read FSYNCHRONIZED write FSYNCHRONIZED;

  end;

implementation



{ TNfeCanaFordia }

constructor TNfeCanaFordia.Create;
begin
  Self.Table:= 'NFE_CANA_FORDIA';
end;

class function TNfeCanaFordia.find(id: string): TNfeCanaFordia;
begin

end;

function TNfeCanaFordia.save: Boolean;
begin
  if (self.FID = EmptyStr) then
    Result:= Self.store
  else Result:= Self.update;
end;

function TNfeCanaFordia.store: Boolean;
begin

end;

function TNfeCanaFordia.update: Boolean;
begin

end;

end.
