unit NfeTranspVeic;

interface

uses
  Model, Classes, Generics.Collections, SysUtils;

type
  TNfeTranspVeic = class(TModel)
  private
    FID: String;
    FEMPRESA_ID: String;
    FNFE_TRANSP_ID: String;
    FPLACA: String;
    FUF: String;
    FRNTC: String;
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
    class function find(id: string): TNfeTranspVeic;

    property Id: String  read FID write FID;
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeTranspId: String  read FNFE_TRANSP_ID write FNFE_TRANSP_ID;
    property Placa: String  read FPLACA write FPLACA;
    property Uf: String  read FUF write FUF;
    property Rntc: String  read FRNTC write FRNTC;
    property CreatedAt: TDateTime  read FCREATED_AT write FCREATED_AT;
    property UpdatedAt: TDateTime  read FUPDATED_AT write FUPDATED_AT;
    property DeletedAt: TDateTime  read FDELETED_AT write FDELETED_AT;
    property Synchronized: String  read FSYNCHRONIZED write FSYNCHRONIZED;

  end;

implementation



{ TNfeTranspVeic }

constructor TNfeTranspVeic.Create;
begin
  Self.Table:= 'NFE_TRANSP_VEIC';
end;

class function TNfeTranspVeic.find(id: string): TNfeTranspVeic;
begin

end;

function TNfeTranspVeic.save: Boolean;
begin
  if (self.FID = EmptyStr) then
    Result:= Self.store
  else Result:= Self.update;
end;

function TNfeTranspVeic.store: Boolean;
begin

end;

function TNfeTranspVeic.update: Boolean;
begin

end;

end.
