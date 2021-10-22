unit NfeDetRastro;

interface

uses
  Model, Classes, Generics.Collections, SysUtils;

type
  TNfeDetRastro = class(TModel)
  private
    FID: String;
    FEMPRESA_ID: String;
    FNFE_DET_ID: String;
    FNLOTE: String;
    FQLOTE: Extended;
    FDFAB: TDateTime;
    FDVAL: TDateTime;
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
    class function find(id: string): TNfeDetRastro;

    property Id: String  read FID write FID;
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeDetId: String  read FNFE_DET_ID write FNFE_DET_ID;
    property Nlote: String  read FNLOTE write FNLOTE;
    property Qlote: Extended  read FQLOTE write FQLOTE;
    property Dfab: TDateTime  read FDFAB write FDFAB;
    property Dval: TDateTime  read FDVAL write FDVAL;
    property CreatedAt: TDateTime  read FCREATED_AT write FCREATED_AT;
    property UpdatedAt: TDateTime  read FUPDATED_AT write FUPDATED_AT;
    property DeletedAt: TDateTime  read FDELETED_AT write FDELETED_AT;
    property Synchronized: String  read FSYNCHRONIZED write FSYNCHRONIZED;

  end;

implementation



{ TNfeDetRastro }

constructor TNfeDetRastro.Create;
begin
  Self.Table:= 'NFE_DET_RASTRO';
end;

class function TNfeDetRastro.find(id: string): TNfeDetRastro;
begin

end;

function TNfeDetRastro.save: Boolean;
begin
  if (self.FID = EmptyStr) then
    Result:= Self.store
  else Result:= Self.update;
end;

function TNfeDetRastro.store: Boolean;
begin

end;

function TNfeDetRastro.update: Boolean;
begin

end;

end.
