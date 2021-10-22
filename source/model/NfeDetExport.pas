unit NfeDetExport;

interface

uses
  Model, Classes, Generics.Collections, SysUtils;

type
  TNfeDetExport = class(TModel)
  private
    FID: String;
    FEMPRESA_ID: String;
    FNFE_DET_ID: String;
    FNDRAW: String;
    FNRE: String;
    FCHNFE: String;
    FQEXPORT: Extended;
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
    class function find(id: string): TNfeDetExport;

    property Id: String  read FID write FID;
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeDetId: String  read FNFE_DET_ID write FNFE_DET_ID;
    property Ndraw: String  read FNDRAW write FNDRAW;
    property Nre: String  read FNRE write FNRE;
    property Chnfe: String  read FCHNFE write FCHNFE;
    property Qexport: Extended  read FQEXPORT write FQEXPORT;
    property CreatedAt: TDateTime  read FCREATED_AT write FCREATED_AT;
    property UpdatedAt: TDateTime  read FUPDATED_AT write FUPDATED_AT;
    property DeletedAt: TDateTime  read FDELETED_AT write FDELETED_AT;
    property Synchronized: String  read FSYNCHRONIZED write FSYNCHRONIZED;

  end;

implementation



{ TNfeDetExport }

constructor TNfeDetExport.Create;
begin
  Self.Table:= 'NFE_DET_EXPORT';
end;

class function TNfeDetExport.find(id: string): TNfeDetExport;
begin

end;

function TNfeDetExport.save: Boolean;
begin
  if (self.FID = EmptyStr) then
    Result:= Self.store
  else Result:= Self.update;
end;

function TNfeDetExport.store: Boolean;
begin

end;

function TNfeDetExport.update: Boolean;
begin

end;

end.
