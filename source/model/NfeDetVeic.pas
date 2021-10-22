unit NfeDetVeic;

interface

uses
  Model, Classes, Generics.Collections, SysUtils;

type
  TNfeDetVeic = class(TModel)
  private
    FID: String;
    FEMPRESA_ID: String;
    FNFE_DET_ID: String;
    FTPOP: String;
    FCHASSI: String;
    FCCOR: String;
    FXCOR: String;
    FPOT: String;
    FCILIN: String;
    FPESOL: String;
    FPESOB: String;
    FNSERIE: String;
    FTPCOMB: String;
    FNMOTOR: String;
    FCMT: String;
    FDIST: String;
    FANOMOD: Integer;
    FANOFAB: Integer;
    FTPPINT: String;
    FTPREST: Integer;
    FESPVEIC: Integer;
    FVIN: String;
    FCONDVEIC: String;
    FCMOD: String;
    FCCORDENATRAN: String;
    FLOTA: Integer;
    FTPVEIC: Integer;
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
    class function find(id: string): TNfeDetVeic;

    property Id: String  read FID write FID;
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeDetId: String  read FNFE_DET_ID write FNFE_DET_ID;
    property Tpop: String  read FTPOP write FTPOP;
    property Chassi: String  read FCHASSI write FCHASSI;
    property Ccor: String  read FCCOR write FCCOR;
    property Xcor: String  read FXCOR write FXCOR;
    property Pot: String  read FPOT write FPOT;
    property Cilin: String  read FCILIN write FCILIN;
    property Pesol: String  read FPESOL write FPESOL;
    property Pesob: String  read FPESOB write FPESOB;
    property Nserie: String  read FNSERIE write FNSERIE;
    property Tpcomb: String  read FTPCOMB write FTPCOMB;
    property Nmotor: String  read FNMOTOR write FNMOTOR;
    property Cmt: String  read FCMT write FCMT;
    property Dist: String  read FDIST write FDIST;
    property Anomod: Integer  read FANOMOD write FANOMOD;
    property Anofab: Integer  read FANOFAB write FANOFAB;
    property Tppint: String  read FTPPINT write FTPPINT;
    property Tprest: Integer  read FTPREST write FTPREST;
    property Espveic: Integer  read FESPVEIC write FESPVEIC;
    property Vin: String  read FVIN write FVIN;
    property Condveic: String  read FCONDVEIC write FCONDVEIC;
    property Cmod: String  read FCMOD write FCMOD;
    property Ccordenatran: String  read FCCORDENATRAN write FCCORDENATRAN;
    property Lota: Integer  read FLOTA write FLOTA;
    property Tpveic: Integer  read FTPVEIC write FTPVEIC;
    property CreatedAt: TDateTime  read FCREATED_AT write FCREATED_AT;
    property UpdatedAt: TDateTime  read FUPDATED_AT write FUPDATED_AT;
    property DeletedAt: TDateTime  read FDELETED_AT write FDELETED_AT;
    property Synchronized: String  read FSYNCHRONIZED write FSYNCHRONIZED;

  end;

implementation



{ TNfeDetVeic }

constructor TNfeDetVeic.Create;
begin
  Self.Table:= 'NFE_DET_VEIC';
end;

class function TNfeDetVeic.find(id: string): TNfeDetVeic;
begin

end;

function TNfeDetVeic.save: Boolean;
begin
  if (self.FID = EmptyStr) then
    Result:= Self.store
  else Result:= Self.update;
end;

function TNfeDetVeic.store: Boolean;
begin

end;

function TNfeDetVeic.update: Boolean;
begin

end;

end.
