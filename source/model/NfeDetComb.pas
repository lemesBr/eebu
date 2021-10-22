unit NfeDetComb;

interface

uses
  Model, Classes, Generics.Collections, SysUtils;

type
  TNfeDetComb = class(TModel)
  private
    FID: String;
    FEMPRESA_ID: String;
    FNFE_DET_ID: String;
    FCPRODANP: Integer;
    FDESCANP: String;
    FPGLP: Extended;
    FPGNN: Extended;
    FPGNI: Extended;
    FVPART: Extended;
    FCODIF: String;
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
    class function find(id: string): TNfeDetComb;

    property Id: String  read FID write FID;
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeDetId: String  read FNFE_DET_ID write FNFE_DET_ID;
    property Cprodanp: Integer  read FCPRODANP write FCPRODANP;
    property Descanp: String  read FDESCANP write FDESCANP;
    property Pglp: Extended  read FPGLP write FPGLP;
    property Pgnn: Extended  read FPGNN write FPGNN;
    property Pgni: Extended  read FPGNI write FPGNI;
    property Vpart: Extended  read FVPART write FVPART;
    property Codif: String  read FCODIF write FCODIF;
    property CreatedAt: TDateTime  read FCREATED_AT write FCREATED_AT;
    property UpdatedAt: TDateTime  read FUPDATED_AT write FUPDATED_AT;
    property DeletedAt: TDateTime  read FDELETED_AT write FDELETED_AT;
    property Synchronized: String  read FSYNCHRONIZED write FSYNCHRONIZED;

  end;

implementation



{ TNfeDetComb }

constructor TNfeDetComb.Create;
begin
  Self.Table:= 'NFE_DET_COMB';
end;

class function TNfeDetComb.find(id: string): TNfeDetComb;
begin

end;

function TNfeDetComb.save: Boolean;
begin
  if (self.FID = EmptyStr) then
    Result:= Self.store
  else Result:= Self.update;
end;

function TNfeDetComb.store: Boolean;
begin

end;

function TNfeDetComb.update: Boolean;
begin

end;

end.
