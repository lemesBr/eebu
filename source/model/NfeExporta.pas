unit NfeExporta;

interface

uses
  Model, Classes, Generics.Collections, SysUtils;

type
  TNfeExporta = class(TModel)
  private
    FID: String;
    FEMPRESA_ID: String;
    FNFE_ID: String;
    FUFEMBARQ: String;
    FXLOCEMBARQ: String;
    FUFSAIDAPAIS: String;
    FXLOCEXPORTA: String;
    FXLOCDESPACHO: String;
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
    class function find(id: string): TNfeExporta;

    property Id: String  read FID write FID;
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeId: String  read FNFE_ID write FNFE_ID;
    property Ufembarq: String  read FUFEMBARQ write FUFEMBARQ;
    property Xlocembarq: String  read FXLOCEMBARQ write FXLOCEMBARQ;
    property Ufsaidapais: String  read FUFSAIDAPAIS write FUFSAIDAPAIS;
    property Xlocexporta: String  read FXLOCEXPORTA write FXLOCEXPORTA;
    property Xlocdespacho: String  read FXLOCDESPACHO write FXLOCDESPACHO;
    property CreatedAt: TDateTime  read FCREATED_AT write FCREATED_AT;
    property UpdatedAt: TDateTime  read FUPDATED_AT write FUPDATED_AT;
    property DeletedAt: TDateTime  read FDELETED_AT write FDELETED_AT;
    property Synchronized: String  read FSYNCHRONIZED write FSYNCHRONIZED;

  end;

implementation



{ TNfeExporta }

constructor TNfeExporta.Create;
begin
  Self.Table:= 'NFE_EXPORTA';
end;

class function TNfeExporta.find(id: string): TNfeExporta;
begin

end;

function TNfeExporta.save: Boolean;
begin
  if (self.FID = EmptyStr) then
    Result:= Self.store
  else Result:= Self.update;
end;

function TNfeExporta.store: Boolean;
begin

end;

function TNfeExporta.update: Boolean;
begin

end;

end.
