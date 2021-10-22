unit NfeDetDi;

interface

uses
  Model, Classes, Generics.Collections, SysUtils;

type
  TNfeDetDi = class(TModel)
  private
    FID: String;
    FEMPRESA_ID: String;
    FNFE_DET_ID: String;
    FNDI: String;
    FDDI: TDateTime;
    FXLOCDESEMB: String;
    FUFDESEMB: String;
    FDDESEMB: TDateTime;
    FTPVIATRANSP: String;
    FVAFRMM: Extended;
    FTPINTERMEDIO: String;
    FCNPJ: String;
    FUFTERCEIRO: String;
    FCEXPORTADOR: String;
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
    class function find(id: string): TNfeDetDi;

    property Id: String  read FID write FID;
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeDetId: String  read FNFE_DET_ID write FNFE_DET_ID;
    property Ndi: String  read FNDI write FNDI;
    property Ddi: TDateTime  read FDDI write FDDI;
    property Xlocdesemb: String  read FXLOCDESEMB write FXLOCDESEMB;
    property Ufdesemb: String  read FUFDESEMB write FUFDESEMB;
    property Ddesemb: TDateTime  read FDDESEMB write FDDESEMB;
    property Tpviatransp: String  read FTPVIATRANSP write FTPVIATRANSP;
    property Vafrmm: Extended  read FVAFRMM write FVAFRMM;
    property Tpintermedio: String  read FTPINTERMEDIO write FTPINTERMEDIO;
    property Cnpj: String  read FCNPJ write FCNPJ;
    property Ufterceiro: String  read FUFTERCEIRO write FUFTERCEIRO;
    property Cexportador: String  read FCEXPORTADOR write FCEXPORTADOR;
    property CreatedAt: TDateTime  read FCREATED_AT write FCREATED_AT;
    property UpdatedAt: TDateTime  read FUPDATED_AT write FUPDATED_AT;
    property DeletedAt: TDateTime  read FDELETED_AT write FDELETED_AT;
    property Synchronized: String  read FSYNCHRONIZED write FSYNCHRONIZED;

  end;

implementation



{ TNfeDetDi }

constructor TNfeDetDi.Create;
begin
  Self.Table:= 'NFE_DET_DI';
end;

class function TNfeDetDi.find(id: string): TNfeDetDi;
begin

end;

function TNfeDetDi.save: Boolean;
begin
  if (self.FID = EmptyStr) then
    Result:= Self.store
  else Result:= Self.update;
end;

function TNfeDetDi.store: Boolean;
begin

end;

function TNfeDetDi.update: Boolean;
begin

end;

end.
