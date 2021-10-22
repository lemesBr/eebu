unit NfeTranspVol;

interface

uses
  Model, Classes, Generics.Collections, SysUtils;

type
  TNfeTranspVol = class(TModel)
  private
    FID: String;
    FEMPRESA_ID: String;
    FNFE_TRANSP_ID: String;
    FQVOL: Integer;
    FESP: String;
    FMARCA: String;
    FNVOL: String;
    FPESOL: Extended;
    FPESOB: Extended;
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
    class function find(id: string): TNfeTranspVol;

    property Id: String  read FID write FID;
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeTranspId: String  read FNFE_TRANSP_ID write FNFE_TRANSP_ID;
    property Qvol: Integer  read FQVOL write FQVOL;
    property Esp: String  read FESP write FESP;
    property Marca: String  read FMARCA write FMARCA;
    property Nvol: String  read FNVOL write FNVOL;
    property Pesol: Extended  read FPESOL write FPESOL;
    property Pesob: Extended  read FPESOB write FPESOB;
    property CreatedAt: TDateTime  read FCREATED_AT write FCREATED_AT;
    property UpdatedAt: TDateTime  read FUPDATED_AT write FUPDATED_AT;
    property DeletedAt: TDateTime  read FDELETED_AT write FDELETED_AT;
    property Synchronized: String  read FSYNCHRONIZED write FSYNCHRONIZED;

  end;

implementation



{ TNfeTranspVol }

constructor TNfeTranspVol.Create;
begin
  Self.Table:= 'NFE_TRANSP_VOL';
end;

class function TNfeTranspVol.find(id: string): TNfeTranspVol;
begin

end;

function TNfeTranspVol.save: Boolean;
begin
  if (self.FID = EmptyStr) then
    Result:= Self.store
  else Result:= Self.update;
end;

function TNfeTranspVol.store: Boolean;
begin

end;

function TNfeTranspVol.update: Boolean;
begin

end;

end.
