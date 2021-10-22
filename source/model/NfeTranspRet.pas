unit NfeTranspRet;

interface

uses
  Model, Classes, Generics.Collections, SysUtils;

type
  TNfeTranspRet = class(TModel)
  private
    FID: String;
    FEMPRESA_ID: String;
    FNFE_TRANSP_ID: String;
    FVSERV: Extended;
    FVBCRET: Extended;
    FPICMSRET: Extended;
    FVICMSRET: Extended;
    FCFOP: String;
    FCMUNFG: String;
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
    class function find(id: string): TNfeTranspRet;

    property Id: String  read FID write FID;
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeTranspId: String  read FNFE_TRANSP_ID write FNFE_TRANSP_ID;
    property Vserv: Extended  read FVSERV write FVSERV;
    property Vbcret: Extended  read FVBCRET write FVBCRET;
    property Picmsret: Extended  read FPICMSRET write FPICMSRET;
    property Vicmsret: Extended  read FVICMSRET write FVICMSRET;
    property Cfop: String  read FCFOP write FCFOP;
    property Cmunfg: String  read FCMUNFG write FCMUNFG;
    property CreatedAt: TDateTime  read FCREATED_AT write FCREATED_AT;
    property UpdatedAt: TDateTime  read FUPDATED_AT write FUPDATED_AT;
    property DeletedAt: TDateTime  read FDELETED_AT write FDELETED_AT;
    property Synchronized: String  read FSYNCHRONIZED write FSYNCHRONIZED;

  end;

implementation



{ TNfeTranspRet }

constructor TNfeTranspRet.Create;
begin
  Self.Table:= 'NFE_TRANSP_RET';
end;

class function TNfeTranspRet.find(id: string): TNfeTranspRet;
begin

end;

function TNfeTranspRet.save: Boolean;
begin
  if (self.FID = EmptyStr) then
    Result:= Self.store
  else Result:= Self.update;
end;

function TNfeTranspRet.store: Boolean;
begin

end;

function TNfeTranspRet.update: Boolean;
begin

end;

end.
