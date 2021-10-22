unit NfeTranspVolLacres;

interface

uses
  Model, Classes, Generics.Collections, SysUtils;

type
  TNfeTranspVolLacres = class(TModel)
  private
    FID: String;
    FEMPRESA_ID: String;
    FNFE_TRANSP_VOL_ID: String;
    FNLACRE: String;
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
    class function find(id: string): TNfeTranspVolLacres;

    property Id: String  read FID write FID;
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeTranspVolId: String  read FNFE_TRANSP_VOL_ID write FNFE_TRANSP_VOL_ID;
    property Nlacre: String  read FNLACRE write FNLACRE;
    property CreatedAt: TDateTime  read FCREATED_AT write FCREATED_AT;
    property UpdatedAt: TDateTime  read FUPDATED_AT write FUPDATED_AT;
    property DeletedAt: TDateTime  read FDELETED_AT write FDELETED_AT;
    property Synchronized: String  read FSYNCHRONIZED write FSYNCHRONIZED;

  end;

implementation



{ TNfeTranspVolLacres }

constructor TNfeTranspVolLacres.Create;
begin
  Self.Table:= 'NFE_TRANSP_VOL_LACRES';
end;

class function TNfeTranspVolLacres.find(id: string): TNfeTranspVolLacres;
begin

end;

function TNfeTranspVolLacres.save: Boolean;
begin
  if (self.FID = EmptyStr) then
    Result:= Self.store
  else Result:= Self.update;
end;

function TNfeTranspVolLacres.store: Boolean;
begin

end;

function TNfeTranspVolLacres.update: Boolean;
begin

end;

end.
