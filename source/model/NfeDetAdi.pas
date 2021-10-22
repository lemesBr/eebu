unit NfeDetAdi;

interface

uses
  Model, Classes, Generics.Collections, SysUtils;

type
  TNfeDetAdi = class(TModel)
  private
    FID: String;
    FEMPRESA_ID: String;
    FNFE_DET_DI_ID: String;
    FNADICAO: Integer;
    FNSEQADI: Integer;
    FCFABRICANTE: String;
    FVDESCDI: Extended;
    FNDRAW: String;
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
    class function find(id: string): TNfeDetAdi;

    property Id: String  read FID write FID;
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeDetDiId: String  read FNFE_DET_DI_ID write FNFE_DET_DI_ID;
    property Nadicao: Integer  read FNADICAO write FNADICAO;
    property Nseqadi: Integer  read FNSEQADI write FNSEQADI;
    property Cfabricante: String  read FCFABRICANTE write FCFABRICANTE;
    property Vdescdi: Extended  read FVDESCDI write FVDESCDI;
    property Ndraw: String  read FNDRAW write FNDRAW;
    property CreatedAt: TDateTime  read FCREATED_AT write FCREATED_AT;
    property UpdatedAt: TDateTime  read FUPDATED_AT write FUPDATED_AT;
    property DeletedAt: TDateTime  read FDELETED_AT write FDELETED_AT;
    property Synchronized: String  read FSYNCHRONIZED write FSYNCHRONIZED;

  end;

implementation



{ TNfeDetAdi }

constructor TNfeDetAdi.Create;
begin
  Self.Table:= 'NFE_DET_ADI';
end;

class function TNfeDetAdi.find(id: string): TNfeDetAdi;
begin

end;

function TNfeDetAdi.save: Boolean;
begin
  if (self.FID = EmptyStr) then
    Result:= Self.store
  else Result:= Self.update;
end;

function TNfeDetAdi.store: Boolean;
begin

end;

function TNfeDetAdi.update: Boolean;
begin

end;

end.
