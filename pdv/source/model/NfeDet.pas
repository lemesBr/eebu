unit NfeDet;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  NfeDetIcms, NfeDetIpi, NfeDetPis, NfeDetCofins, Item, System.StrUtils;

type
  TNfeDet = class(TModel)
  private
    FEMPRESA_ID: String;
    FNFE_ID: String;
    FITEM_ID: String;
    FUNIDADE_CONVERSAO_ID: String;
    FCPROD: String;
    FNITEM: Integer;
    FCEAN: String;
    FXPROD: String;
    FNCM: String;
    FEXTIPI: String;
    FCFOP: String;
    FUCOM: String;
    FQCOM: Extended;
    FVUNCOM: Extended;
    FVPROD: Extended;
    FCEANTRIB: String;
    FUTRIB: String;
    FQTRIB: Extended;
    FVUNTRIB: Extended;
    FVFRETE: Extended;
    FVSEG: Extended;
    FVDESC: Extended;
    FVOUTRO: Extended;
    FINDTOT: String;
    FXPED: String;
    FNITEMPED: String;
    FNRECOPI: String;
    FNFCI: String;
    FCEST: String;
    FVTOTTRIB: Extended;
    FPDEVOL: Extended;
    FVIPIDEVOL: Extended;
    FINFADPROD: String;

    FITEM: TItem;
    FICMS: TNfeDetIcms;
    FIPI: TNfeDetIpi;
    FPIS: TNfeDetPis;
    FCOFINS: TNfeDetCofins;

    function getITEM: TItem;
    function getICMS: TNfeDetIcms;
    function getIPI: TNfeDetIpi;
    function getPIS: TNfeDetPis;
    function getCOFINS: TNfeDetCofins;

    procedure calcularICMSCST00();
    procedure calcularICMSCST10();
    procedure calcularICMSCST20();
    procedure calcularICMSCST30();
    procedure calcularICMSCST40();
    procedure calcularICMSCST41();
    procedure calcularICMSCST50();
    procedure calcularICMSCST51();
    procedure calcularICMSCST60();
    procedure calcularICMSCST70();
    procedure calcularICMSCST80();
    procedure calcularICMSCST81();
    procedure calcularICMSCST90();
    procedure calcularICMSCST91();

    procedure calcularICMSCSOSN101();
    procedure calcularICMSCSOSN102();
    procedure calcularICMSCSOSN103();
    procedure calcularICMSCSOSN201();
    procedure calcularICMSCSOSN202();
    procedure calcularICMSCSOSN203();
    procedure calcularICMSCSOSN300();
    procedure calcularICMSCSOSN400();
    procedure calcularICMSCSOSN500();
    procedure calcularICMSCSOSN900();

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    procedure ICMSCreate();
    procedure IPICreate();
    procedure PISCreate();
    procedure COFINSCreate();
    procedure processaCalculos();
    class function find(id: string): TNfeDet;
    class function findByNfeId(NfeId: string): TObjectList<TNfeDet>; overload;
    class procedure findByNfeId(NfeId: string; DataSet: TFDMemTable); overload;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeId: String  read FNFE_ID write FNFE_ID;
    property ItemId: String  read FITEM_ID write FITEM_ID;
    property UnidadeConversaoId: String  read FUNIDADE_CONVERSAO_ID write FUNIDADE_CONVERSAO_ID;
    property Cprod: String  read FCPROD write FCPROD;
    property Nitem: Integer  read FNITEM write FNITEM;
    property Cean: String  read FCEAN write FCEAN;
    property Xprod: String  read FXPROD write FXPROD;
    property Ncm: String  read FNCM write FNCM;
    property Extipi: String  read FEXTIPI write FEXTIPI;
    property Cfop: String  read FCFOP write FCFOP;
    property Ucom: String  read FUCOM write FUCOM;
    property Qcom: Extended  read FQCOM write FQCOM;
    property Vuncom: Extended  read FVUNCOM write FVUNCOM;
    property Vprod: Extended  read FVPROD write FVPROD;
    property Ceantrib: String  read FCEANTRIB write FCEANTRIB;
    property Utrib: String  read FUTRIB write FUTRIB;
    property Qtrib: Extended  read FQTRIB write FQTRIB;
    property Vuntrib: Extended  read FVUNTRIB write FVUNTRIB;
    property Vfrete: Extended  read FVFRETE write FVFRETE;
    property Vseg: Extended  read FVSEG write FVSEG;
    property Vdesc: Extended  read FVDESC write FVDESC;
    property Voutro: Extended  read FVOUTRO write FVOUTRO;
    property Indtot: String  read FINDTOT write FINDTOT;
    property Xped: String  read FXPED write FXPED;
    property Nitemped: String  read FNITEMPED write FNITEMPED;
    property Nrecopi: String  read FNRECOPI write FNRECOPI;
    property Nfci: String  read FNFCI write FNFCI;
    property Cest: String  read FCEST write FCEST;
    property Vtottrib: Extended  read FVTOTTRIB write FVTOTTRIB;
    property Pdevol: Extended  read FPDEVOL write FPDEVOL;
    property Vipidevol: Extended  read FVIPIDEVOL write FVIPIDEVOL;
    property Infadprod: String  read FINFADPROD write FINFADPROD;
    
    property ITEM: TItem read getITEM;
    property ICMS: TNfeDetIcms read getICMS;
    property IPI: TNfeDetIpi read getIPI;
    property PIS: TNfeDetPis read getPIS;
    property COFINS: TNfeDetCofins read getCOFINS;

  end;

implementation

uses
  AuthService;

{ TNfeDet }

procedure TNfeDet.calcularICMSCSOSN101;
begin
  Self.ICMS.Cst:= 'SN';
  Self.ICMS.Csosn:= '101';
  Self.ICMS.Modbc:= EmptyStr;
  Self.ICMS.Predbc:= 0;
  Self.ICMS.Vbc:= 0;
  Self.ICMS.Picms:= 0;
  Self.ICMS.Vicms:= 0;
  Self.ICMS.Modbcst:= EmptyStr;
  Self.ICMS.Pmvast:= 0;
  Self.ICMS.Predbcst:= 0;
  Self.ICMS.Vbcst:= 0;
  Self.ICMS.Picmsst:= 0;
  Self.ICMS.Vicmsst:= 0;
  Self.ICMS.Ufst:= EmptyStr;
  Self.ICMS.Pbcop:= 0;
  Self.ICMS.Vbcstret:= 0;
  Self.ICMS.Vicmsstret:= 0;
  Self.ICMS.Motdesicms:= EmptyStr;
  Self.ICMS.Vcredicmssn:= (Self.Vprod * Self.ICMS.Pcredsn) / 100;
  Self.ICMS.Vbcstdest:= 0;
  Self.ICMS.Vicmsstdest:= 0;
  Self.ICMS.Vicmsdeson:= 0;
  Self.ICMS.Vicmsop:= 0;
  Self.ICMS.Pdif:= 0;
  Self.ICMS.Vicmsdif:= 0;
  Self.ICMS.Vbcfcp:= 0;
  Self.ICMS.Pfcp:= 0;
  Self.ICMS.Vfcp:= 0;
  Self.ICMS.Vbcfcpst:= 0;
  Self.ICMS.Pfcpst:= 0;
  Self.ICMS.Vfcpst:= 0;
  Self.ICMS.Vbcfcpstret:= 0;
  Self.ICMS.Pfcpstret:= 0;
  Self.ICMS.Vfcpstret:= 0;
  Self.ICMS.Pst:= 0;
end;

procedure TNfeDet.calcularICMSCSOSN102;
begin
  Self.ICMS.Cst:= 'SN';
  Self.ICMS.Csosn:= '102';
  Self.ICMS.Modbc:= EmptyStr;
  Self.ICMS.Predbc:= 0;
  Self.ICMS.Vbc:= 0;
  Self.ICMS.Picms:= 0;
  Self.ICMS.Vicms:= 0;
  Self.ICMS.Modbcst:= EmptyStr;
  Self.ICMS.Pmvast:= 0;
  Self.ICMS.Predbcst:= 0;
  Self.ICMS.Vbcst:= 0;
  Self.ICMS.Picmsst:= 0;
  Self.ICMS.Vicmsst:= 0;
  Self.ICMS.Ufst:= EmptyStr;
  Self.ICMS.Pbcop:= 0;
  Self.ICMS.Vbcstret:= 0;
  Self.ICMS.Vicmsstret:= 0;
  Self.ICMS.Motdesicms:= EmptyStr;
  Self.ICMS.Pcredsn:= 0;
  Self.ICMS.Vcredicmssn:= 0;
  Self.ICMS.Vbcstdest:= 0;
  Self.ICMS.Vicmsstdest:= 0;
  Self.ICMS.Vicmsdeson:= 0;
  Self.ICMS.Vicmsop:= 0;
  Self.ICMS.Pdif:= 0;
  Self.ICMS.Vicmsdif:= 0;
  Self.ICMS.Vbcfcp:= 0;
  Self.ICMS.Pfcp:= 0;
  Self.ICMS.Vfcp:= 0;
  Self.ICMS.Vbcfcpst:= 0;
  Self.ICMS.Pfcpst:= 0;
  Self.ICMS.Vfcpst:= 0;
  Self.ICMS.Vbcfcpstret:= 0;
  Self.ICMS.Pfcpstret:= 0;
  Self.ICMS.Vfcpstret:= 0;
  Self.ICMS.Pst:= 0;
end;

procedure TNfeDet.calcularICMSCSOSN103;
begin
  Self.ICMS.Cst:= 'SN';
  Self.ICMS.Csosn:= '103';
  Self.ICMS.Modbc:= EmptyStr;
  Self.ICMS.Predbc:= 0;
  Self.ICMS.Vbc:= 0;
  Self.ICMS.Picms:= 0;
  Self.ICMS.Vicms:= 0;
  Self.ICMS.Modbcst:= EmptyStr;
  Self.ICMS.Pmvast:= 0;
  Self.ICMS.Predbcst:= 0;
  Self.ICMS.Vbcst:= 0;
  Self.ICMS.Picmsst:= 0;
  Self.ICMS.Vicmsst:= 0;
  Self.ICMS.Ufst:= EmptyStr;
  Self.ICMS.Pbcop:= 0;
  Self.ICMS.Vbcstret:= 0;
  Self.ICMS.Vicmsstret:= 0;
  Self.ICMS.Motdesicms:= EmptyStr;
  Self.ICMS.Pcredsn:= 0;
  Self.ICMS.Vcredicmssn:= 0;
  Self.ICMS.Vbcstdest:= 0;
  Self.ICMS.Vicmsstdest:= 0;
  Self.ICMS.Vicmsdeson:= 0;
  Self.ICMS.Vicmsop:= 0;
  Self.ICMS.Pdif:= 0;
  Self.ICMS.Vicmsdif:= 0;
  Self.ICMS.Vbcfcp:= 0;
  Self.ICMS.Pfcp:= 0;
  Self.ICMS.Vfcp:= 0;
  Self.ICMS.Vbcfcpst:= 0;
  Self.ICMS.Pfcpst:= 0;
  Self.ICMS.Vfcpst:= 0;
  Self.ICMS.Vbcfcpstret:= 0;
  Self.ICMS.Pfcpstret:= 0;
  Self.ICMS.Vfcpstret:= 0;
  Self.ICMS.Pst:= 0;
end;

procedure TNfeDet.calcularICMSCSOSN201;
begin

end;

procedure TNfeDet.calcularICMSCSOSN202;
begin

end;

procedure TNfeDet.calcularICMSCSOSN203;
begin

end;

procedure TNfeDet.calcularICMSCSOSN300;
begin
  Self.ICMS.Cst:= 'SN';
  Self.ICMS.Csosn:= '300';
  Self.ICMS.Modbc:= EmptyStr;
  Self.ICMS.Predbc:= 0;
  Self.ICMS.Vbc:= 0;
  Self.ICMS.Picms:= 0;
  Self.ICMS.Vicms:= 0;
  Self.ICMS.Modbcst:= EmptyStr;
  Self.ICMS.Pmvast:= 0;
  Self.ICMS.Predbcst:= 0;
  Self.ICMS.Vbcst:= 0;
  Self.ICMS.Picmsst:= 0;
  Self.ICMS.Vicmsst:= 0;
  Self.ICMS.Ufst:= EmptyStr;
  Self.ICMS.Pbcop:= 0;
  Self.ICMS.Vbcstret:= 0;
  Self.ICMS.Vicmsstret:= 0;
  Self.ICMS.Motdesicms:= EmptyStr;
  Self.ICMS.Pcredsn:= 0;
  Self.ICMS.Vcredicmssn:= 0;
  Self.ICMS.Vbcstdest:= 0;
  Self.ICMS.Vicmsstdest:= 0;
  Self.ICMS.Vicmsdeson:= 0;
  Self.ICMS.Vicmsop:= 0;
  Self.ICMS.Pdif:= 0;
  Self.ICMS.Vicmsdif:= 0;
  Self.ICMS.Vbcfcp:= 0;
  Self.ICMS.Pfcp:= 0;
  Self.ICMS.Vfcp:= 0;
  Self.ICMS.Vbcfcpst:= 0;
  Self.ICMS.Pfcpst:= 0;
  Self.ICMS.Vfcpst:= 0;
  Self.ICMS.Vbcfcpstret:= 0;
  Self.ICMS.Pfcpstret:= 0;
  Self.ICMS.Vfcpstret:= 0;
  Self.ICMS.Pst:= 0;
end;

procedure TNfeDet.calcularICMSCSOSN400;
begin
  Self.ICMS.Cst:= 'SN';
  Self.ICMS.Csosn:= '400';
  Self.ICMS.Modbc:= EmptyStr;
  Self.ICMS.Predbc:= 0;
  Self.ICMS.Vbc:= 0;
  Self.ICMS.Picms:= 0;
  Self.ICMS.Vicms:= 0;
  Self.ICMS.Modbcst:= EmptyStr;
  Self.ICMS.Pmvast:= 0;
  Self.ICMS.Predbcst:= 0;
  Self.ICMS.Vbcst:= 0;
  Self.ICMS.Picmsst:= 0;
  Self.ICMS.Vicmsst:= 0;
  Self.ICMS.Ufst:= EmptyStr;
  Self.ICMS.Pbcop:= 0;
  Self.ICMS.Vbcstret:= 0;
  Self.ICMS.Vicmsstret:= 0;
  Self.ICMS.Motdesicms:= EmptyStr;
  Self.ICMS.Pcredsn:= 0;
  Self.ICMS.Vcredicmssn:= 0;
  Self.ICMS.Vbcstdest:= 0;
  Self.ICMS.Vicmsstdest:= 0;
  Self.ICMS.Vicmsdeson:= 0;
  Self.ICMS.Vicmsop:= 0;
  Self.ICMS.Pdif:= 0;
  Self.ICMS.Vicmsdif:= 0;
  Self.ICMS.Vbcfcp:= 0;
  Self.ICMS.Pfcp:= 0;
  Self.ICMS.Vfcp:= 0;
  Self.ICMS.Vbcfcpst:= 0;
  Self.ICMS.Pfcpst:= 0;
  Self.ICMS.Vfcpst:= 0;
  Self.ICMS.Vbcfcpstret:= 0;
  Self.ICMS.Pfcpstret:= 0;
  Self.ICMS.Vfcpstret:= 0;
  Self.ICMS.Pst:= 0;
end;

procedure TNfeDet.calcularICMSCSOSN500;
begin

end;

procedure TNfeDet.calcularICMSCSOSN900;
begin

end;

procedure TNfeDet.calcularICMSCST00;
begin
  Self.ICMS.Cst:= '00';
  Self.ICMS.Csosn:= '0';
  Self.ICMS.Modbc:= EmptyStr;
  Self.ICMS.Predbc:= 0;
  Self.ICMS.Vbc:= 0;
  Self.ICMS.Picms:= 0;
  Self.ICMS.Vicms:= 0;
  Self.ICMS.Modbcst:= EmptyStr;
  Self.ICMS.Pmvast:= 0;
  Self.ICMS.Predbcst:= 0;
  Self.ICMS.Vbcst:= 0;
  Self.ICMS.Picmsst:= 0;
  Self.ICMS.Vicmsst:= 0;
  Self.ICMS.Ufst:= EmptyStr;
  Self.ICMS.Pbcop:= 0;
  Self.ICMS.Vbcstret:= 0;
  Self.ICMS.Vicmsstret:= 0;
  Self.ICMS.Motdesicms:= EmptyStr;
  Self.ICMS.Pcredsn:= 0;
  Self.ICMS.Vcredicmssn:= 0;
  Self.ICMS.Vbcstdest:= 0;
  Self.ICMS.Vicmsstdest:= 0;
  Self.ICMS.Vicmsdeson:= 0;
  Self.ICMS.Vicmsop:= 0;
  Self.ICMS.Pdif:= 0;
  Self.ICMS.Vicmsdif:= 0;
  Self.ICMS.Vbcfcp:= 0;
  Self.ICMS.Pfcp:= 0;
  Self.ICMS.Vfcp:= 0;
  Self.ICMS.Vbcfcpst:= 0;
  Self.ICMS.Pfcpst:= 0;
  Self.ICMS.Vfcpst:= 0;
  Self.ICMS.Vbcfcpstret:= 0;
  Self.ICMS.Pfcpstret:= 0;
  Self.ICMS.Vfcpstret:= 0;
  Self.ICMS.Pst:= 0;
end;

procedure TNfeDet.calcularICMSCST10;
begin
  Self.ICMS.Cst:= '10';
  Self.ICMS.Csosn:= '0';
  Self.ICMS.Modbc:= EmptyStr;
  Self.ICMS.Predbc:= 0;
  Self.ICMS.Vbc:= 0;
  Self.ICMS.Picms:= 0;
  Self.ICMS.Vicms:= 0;
  Self.ICMS.Modbcst:= EmptyStr;
  Self.ICMS.Pmvast:= 0;
  Self.ICMS.Predbcst:= 0;
  Self.ICMS.Vbcst:= 0;
  Self.ICMS.Picmsst:= 0;
  Self.ICMS.Vicmsst:= 0;
  Self.ICMS.Ufst:= EmptyStr;
  Self.ICMS.Pbcop:= 0;
  Self.ICMS.Vbcstret:= 0;
  Self.ICMS.Vicmsstret:= 0;
  Self.ICMS.Motdesicms:= EmptyStr;
  Self.ICMS.Pcredsn:= 0;
  Self.ICMS.Vcredicmssn:= 0;
  Self.ICMS.Vbcstdest:= 0;
  Self.ICMS.Vicmsstdest:= 0;
  Self.ICMS.Vicmsdeson:= 0;
  Self.ICMS.Vicmsop:= 0;
  Self.ICMS.Pdif:= 0;
  Self.ICMS.Vicmsdif:= 0;
  Self.ICMS.Vbcfcp:= 0;
  Self.ICMS.Pfcp:= 0;
  Self.ICMS.Vfcp:= 0;
  Self.ICMS.Vbcfcpst:= 0;
  Self.ICMS.Pfcpst:= 0;
  Self.ICMS.Vfcpst:= 0;
  Self.ICMS.Vbcfcpstret:= 0;
  Self.ICMS.Pfcpstret:= 0;
  Self.ICMS.Vfcpstret:= 0;
  Self.ICMS.Pst:= 0;
end;

procedure TNfeDet.calcularICMSCST20;
begin
  Self.ICMS.Cst:= '20';
  Self.ICMS.Csosn:= '0';
  Self.ICMS.Modbc:= EmptyStr;
  Self.ICMS.Predbc:= 0;
  Self.ICMS.Vbc:= 0;
  Self.ICMS.Picms:= 0;
  Self.ICMS.Vicms:= 0;
  Self.ICMS.Modbcst:= EmptyStr;
  Self.ICMS.Pmvast:= 0;
  Self.ICMS.Predbcst:= 0;
  Self.ICMS.Vbcst:= 0;
  Self.ICMS.Picmsst:= 0;
  Self.ICMS.Vicmsst:= 0;
  Self.ICMS.Ufst:= EmptyStr;
  Self.ICMS.Pbcop:= 0;
  Self.ICMS.Vbcstret:= 0;
  Self.ICMS.Vicmsstret:= 0;
  Self.ICMS.Motdesicms:= EmptyStr;
  Self.ICMS.Pcredsn:= 0;
  Self.ICMS.Vcredicmssn:= 0;
  Self.ICMS.Vbcstdest:= 0;
  Self.ICMS.Vicmsstdest:= 0;
  Self.ICMS.Vicmsdeson:= 0;
  Self.ICMS.Vicmsop:= 0;
  Self.ICMS.Pdif:= 0;
  Self.ICMS.Vicmsdif:= 0;
  Self.ICMS.Vbcfcp:= 0;
  Self.ICMS.Pfcp:= 0;
  Self.ICMS.Vfcp:= 0;
  Self.ICMS.Vbcfcpst:= 0;
  Self.ICMS.Pfcpst:= 0;
  Self.ICMS.Vfcpst:= 0;
  Self.ICMS.Vbcfcpstret:= 0;
  Self.ICMS.Pfcpstret:= 0;
  Self.ICMS.Vfcpstret:= 0;
  Self.ICMS.Pst:= 0;
end;

procedure TNfeDet.calcularICMSCST30;
begin
  Self.ICMS.Cst:= '30';
  Self.ICMS.Csosn:= '0';
  Self.ICMS.Modbc:= EmptyStr;
  Self.ICMS.Predbc:= 0;
  Self.ICMS.Vbc:= 0;
  Self.ICMS.Picms:= 0;
  Self.ICMS.Vicms:= 0;
  Self.ICMS.Modbcst:= EmptyStr;
  Self.ICMS.Pmvast:= 0;
  Self.ICMS.Predbcst:= 0;
  Self.ICMS.Vbcst:= 0;
  Self.ICMS.Picmsst:= 0;
  Self.ICMS.Vicmsst:= 0;
  Self.ICMS.Ufst:= EmptyStr;
  Self.ICMS.Pbcop:= 0;
  Self.ICMS.Vbcstret:= 0;
  Self.ICMS.Vicmsstret:= 0;
  Self.ICMS.Motdesicms:= EmptyStr;
  Self.ICMS.Pcredsn:= 0;
  Self.ICMS.Vcredicmssn:= 0;
  Self.ICMS.Vbcstdest:= 0;
  Self.ICMS.Vicmsstdest:= 0;
  Self.ICMS.Vicmsdeson:= 0;
  Self.ICMS.Vicmsop:= 0;
  Self.ICMS.Pdif:= 0;
  Self.ICMS.Vicmsdif:= 0;
  Self.ICMS.Vbcfcp:= 0;
  Self.ICMS.Pfcp:= 0;
  Self.ICMS.Vfcp:= 0;
  Self.ICMS.Vbcfcpst:= 0;
  Self.ICMS.Pfcpst:= 0;
  Self.ICMS.Vfcpst:= 0;
  Self.ICMS.Vbcfcpstret:= 0;
  Self.ICMS.Pfcpstret:= 0;
  Self.ICMS.Vfcpstret:= 0;
  Self.ICMS.Pst:= 0;
end;

procedure TNfeDet.calcularICMSCST40;
begin
  Self.ICMS.Cst:= '40';
  Self.ICMS.Csosn:= '0';
  Self.ICMS.Modbc:= EmptyStr;
  Self.ICMS.Predbc:= 0;
  Self.ICMS.Vbc:= 0;
  Self.ICMS.Picms:= 0;
  Self.ICMS.Vicms:= 0;
  Self.ICMS.Modbcst:= EmptyStr;
  Self.ICMS.Pmvast:= 0;
  Self.ICMS.Predbcst:= 0;
  Self.ICMS.Vbcst:= 0;
  Self.ICMS.Picmsst:= 0;
  Self.ICMS.Vicmsst:= 0;
  Self.ICMS.Ufst:= EmptyStr;
  Self.ICMS.Pbcop:= 0;
  Self.ICMS.Vbcstret:= 0;
  Self.ICMS.Vicmsstret:= 0;
  Self.ICMS.Motdesicms:= Self.ICMS.Motdesicms;
  Self.ICMS.Pcredsn:= 0;
  Self.ICMS.Vcredicmssn:= 0;
  Self.ICMS.Vbcstdest:= 0;
  Self.ICMS.Vicmsstdest:= 0;
  Self.ICMS.Vicmsdeson:= 0;
  Self.ICMS.Vicmsop:= 0;
  Self.ICMS.Pdif:= 0;
  Self.ICMS.Vicmsdif:= 0;
  Self.ICMS.Vbcfcp:= 0;
  Self.ICMS.Pfcp:= 0;
  Self.ICMS.Vfcp:= 0;
  Self.ICMS.Vbcfcpst:= 0;
  Self.ICMS.Pfcpst:= 0;
  Self.ICMS.Vfcpst:= 0;
  Self.ICMS.Vbcfcpstret:= 0;
  Self.ICMS.Pfcpstret:= 0;
  Self.ICMS.Vfcpstret:= 0;
  Self.ICMS.Pst:= 0;
end;

procedure TNfeDet.calcularICMSCST41;
begin
  Self.ICMS.Cst:= '41';
  Self.ICMS.Csosn:= '0';
  Self.ICMS.Modbc:= EmptyStr;
  Self.ICMS.Predbc:= 0;
  Self.ICMS.Vbc:= 0;
  Self.ICMS.Picms:= 0;
  Self.ICMS.Vicms:= 0;
  Self.ICMS.Modbcst:= EmptyStr;
  Self.ICMS.Pmvast:= 0;
  Self.ICMS.Predbcst:= 0;
  Self.ICMS.Vbcst:= 0;
  Self.ICMS.Picmsst:= 0;
  Self.ICMS.Vicmsst:= 0;
  Self.ICMS.Ufst:= EmptyStr;
  Self.ICMS.Pbcop:= 0;
  Self.ICMS.Vbcstret:= 0;
  Self.ICMS.Vicmsstret:= 0;
  Self.ICMS.Motdesicms:= EmptyStr;
  Self.ICMS.Pcredsn:= 0;
  Self.ICMS.Vcredicmssn:= 0;
  Self.ICMS.Vbcstdest:= 0;
  Self.ICMS.Vicmsstdest:= 0;
  Self.ICMS.Vicmsdeson:= 0;
  Self.ICMS.Vicmsop:= 0;
  Self.ICMS.Pdif:= 0;
  Self.ICMS.Vicmsdif:= 0;
  Self.ICMS.Vbcfcp:= 0;
  Self.ICMS.Pfcp:= 0;
  Self.ICMS.Vfcp:= 0;
  Self.ICMS.Vbcfcpst:= 0;
  Self.ICMS.Pfcpst:= 0;
  Self.ICMS.Vfcpst:= 0;
  Self.ICMS.Vbcfcpstret:= 0;
  Self.ICMS.Pfcpstret:= 0;
  Self.ICMS.Vfcpstret:= 0;
  Self.ICMS.Pst:= 0;
end;

procedure TNfeDet.calcularICMSCST50;
begin
  Self.ICMS.Cst:= '50';
  Self.ICMS.Csosn:= '0';
  Self.ICMS.Modbc:= EmptyStr;
  Self.ICMS.Predbc:= 0;
  Self.ICMS.Vbc:= 0;
  Self.ICMS.Picms:= 0;
  Self.ICMS.Vicms:= 0;
  Self.ICMS.Modbcst:= EmptyStr;
  Self.ICMS.Pmvast:= 0;
  Self.ICMS.Predbcst:= 0;
  Self.ICMS.Vbcst:= 0;
  Self.ICMS.Picmsst:= 0;
  Self.ICMS.Vicmsst:= 0;
  Self.ICMS.Ufst:= EmptyStr;
  Self.ICMS.Pbcop:= 0;
  Self.ICMS.Vbcstret:= 0;
  Self.ICMS.Vicmsstret:= 0;
  Self.ICMS.Motdesicms:= EmptyStr;
  Self.ICMS.Pcredsn:= 0;
  Self.ICMS.Vcredicmssn:= 0;
  Self.ICMS.Vbcstdest:= 0;
  Self.ICMS.Vicmsstdest:= 0;
  Self.ICMS.Vicmsdeson:= 0;
  Self.ICMS.Vicmsop:= 0;
  Self.ICMS.Pdif:= 0;
  Self.ICMS.Vicmsdif:= 0;
  Self.ICMS.Vbcfcp:= 0;
  Self.ICMS.Pfcp:= 0;
  Self.ICMS.Vfcp:= 0;
  Self.ICMS.Vbcfcpst:= 0;
  Self.ICMS.Pfcpst:= 0;
  Self.ICMS.Vfcpst:= 0;
  Self.ICMS.Vbcfcpstret:= 0;
  Self.ICMS.Pfcpstret:= 0;
  Self.ICMS.Vfcpstret:= 0;
  Self.ICMS.Pst:= 0;
end;

procedure TNfeDet.calcularICMSCST51;
begin
  Self.ICMS.Cst:= '51';
  Self.ICMS.Csosn:= '0';
  Self.ICMS.Modbc:= EmptyStr;
  Self.ICMS.Predbc:= 0;
  Self.ICMS.Vbc:= 0;
  Self.ICMS.Picms:= 0;
  Self.ICMS.Vicms:= 0;
  Self.ICMS.Modbcst:= EmptyStr;
  Self.ICMS.Pmvast:= 0;
  Self.ICMS.Predbcst:= 0;
  Self.ICMS.Vbcst:= 0;
  Self.ICMS.Picmsst:= 0;
  Self.ICMS.Vicmsst:= 0;
  Self.ICMS.Ufst:= EmptyStr;
  Self.ICMS.Pbcop:= 0;
  Self.ICMS.Vbcstret:= 0;
  Self.ICMS.Vicmsstret:= 0;
  Self.ICMS.Motdesicms:= EmptyStr;
  Self.ICMS.Pcredsn:= 0;
  Self.ICMS.Vcredicmssn:= 0;
  Self.ICMS.Vbcstdest:= 0;
  Self.ICMS.Vicmsstdest:= 0;
  Self.ICMS.Vicmsdeson:= 0;
  Self.ICMS.Vicmsop:= 0;
  Self.ICMS.Pdif:= 0;
  Self.ICMS.Vicmsdif:= 0;
  Self.ICMS.Vbcfcp:= 0;
  Self.ICMS.Pfcp:= 0;
  Self.ICMS.Vfcp:= 0;
  Self.ICMS.Vbcfcpst:= 0;
  Self.ICMS.Pfcpst:= 0;
  Self.ICMS.Vfcpst:= 0;
  Self.ICMS.Vbcfcpstret:= 0;
  Self.ICMS.Pfcpstret:= 0;
  Self.ICMS.Vfcpstret:= 0;
  Self.ICMS.Pst:= 0;
end;

procedure TNfeDet.calcularICMSCST60;
begin
  Self.ICMS.Cst:= '60';
  Self.ICMS.Csosn:= '0';
  Self.ICMS.Modbc:= EmptyStr;
  Self.ICMS.Predbc:= 0;
  Self.ICMS.Vbc:= 0;
  Self.ICMS.Picms:= 0;
  Self.ICMS.Vicms:= 0;
  Self.ICMS.Modbcst:= EmptyStr;
  Self.ICMS.Pmvast:= 0;
  Self.ICMS.Predbcst:= 0;
  Self.ICMS.Vbcst:= 0;
  Self.ICMS.Picmsst:= 0;
  Self.ICMS.Vicmsst:= 0;
  Self.ICMS.Ufst:= EmptyStr;
  Self.ICMS.Pbcop:= 0;
  Self.ICMS.Vbcstret:= 0;
  Self.ICMS.Vicmsstret:= 0;
  Self.ICMS.Motdesicms:= EmptyStr;
  Self.ICMS.Pcredsn:= 0;
  Self.ICMS.Vcredicmssn:= 0;
  Self.ICMS.Vbcstdest:= 0;
  Self.ICMS.Vicmsstdest:= 0;
  Self.ICMS.Vicmsdeson:= 0;
  Self.ICMS.Vicmsop:= 0;
  Self.ICMS.Pdif:= 0;
  Self.ICMS.Vicmsdif:= 0;
  Self.ICMS.Vbcfcp:= 0;
  Self.ICMS.Pfcp:= 0;
  Self.ICMS.Vfcp:= 0;
  Self.ICMS.Vbcfcpst:= 0;
  Self.ICMS.Pfcpst:= 0;
  Self.ICMS.Vfcpst:= 0;
  Self.ICMS.Vbcfcpstret:= 0;
  Self.ICMS.Pfcpstret:= 0;
  Self.ICMS.Vfcpstret:= 0;
  Self.ICMS.Pst:= 0;
end;

procedure TNfeDet.calcularICMSCST70;
begin
  Self.ICMS.Cst:= '70';
  Self.ICMS.Csosn:= '0';
  Self.ICMS.Modbc:= EmptyStr;
  Self.ICMS.Predbc:= 0;
  Self.ICMS.Vbc:= 0;
  Self.ICMS.Picms:= 0;
  Self.ICMS.Vicms:= 0;
  Self.ICMS.Modbcst:= EmptyStr;
  Self.ICMS.Pmvast:= 0;
  Self.ICMS.Predbcst:= 0;
  Self.ICMS.Vbcst:= 0;
  Self.ICMS.Picmsst:= 0;
  Self.ICMS.Vicmsst:= 0;
  Self.ICMS.Ufst:= EmptyStr;
  Self.ICMS.Pbcop:= 0;
  Self.ICMS.Vbcstret:= 0;
  Self.ICMS.Vicmsstret:= 0;
  Self.ICMS.Motdesicms:= EmptyStr;
  Self.ICMS.Pcredsn:= 0;
  Self.ICMS.Vcredicmssn:= 0;
  Self.ICMS.Vbcstdest:= 0;
  Self.ICMS.Vicmsstdest:= 0;
  Self.ICMS.Vicmsdeson:= 0;
  Self.ICMS.Vicmsop:= 0;
  Self.ICMS.Pdif:= 0;
  Self.ICMS.Vicmsdif:= 0;
  Self.ICMS.Vbcfcp:= 0;
  Self.ICMS.Pfcp:= 0;
  Self.ICMS.Vfcp:= 0;
  Self.ICMS.Vbcfcpst:= 0;
  Self.ICMS.Pfcpst:= 0;
  Self.ICMS.Vfcpst:= 0;
  Self.ICMS.Vbcfcpstret:= 0;
  Self.ICMS.Pfcpstret:= 0;
  Self.ICMS.Vfcpstret:= 0;
  Self.ICMS.Pst:= 0;
end;

procedure TNfeDet.calcularICMSCST80;
begin
  Self.ICMS.Cst:= '80';
  Self.ICMS.Csosn:= '0';
  Self.ICMS.Modbc:= EmptyStr;
  Self.ICMS.Predbc:= 0;
  Self.ICMS.Vbc:= 0;
  Self.ICMS.Picms:= 0;
  Self.ICMS.Vicms:= 0;
  Self.ICMS.Modbcst:= EmptyStr;
  Self.ICMS.Pmvast:= 0;
  Self.ICMS.Predbcst:= 0;
  Self.ICMS.Vbcst:= 0;
  Self.ICMS.Picmsst:= 0;
  Self.ICMS.Vicmsst:= 0;
  Self.ICMS.Ufst:= EmptyStr;
  Self.ICMS.Pbcop:= 0;
  Self.ICMS.Vbcstret:= 0;
  Self.ICMS.Vicmsstret:= 0;
  Self.ICMS.Motdesicms:= EmptyStr;
  Self.ICMS.Pcredsn:= 0;
  Self.ICMS.Vcredicmssn:= 0;
  Self.ICMS.Vbcstdest:= 0;
  Self.ICMS.Vicmsstdest:= 0;
  Self.ICMS.Vicmsdeson:= 0;
  Self.ICMS.Vicmsop:= 0;
  Self.ICMS.Pdif:= 0;
  Self.ICMS.Vicmsdif:= 0;
  Self.ICMS.Vbcfcp:= 0;
  Self.ICMS.Pfcp:= 0;
  Self.ICMS.Vfcp:= 0;
  Self.ICMS.Vbcfcpst:= 0;
  Self.ICMS.Pfcpst:= 0;
  Self.ICMS.Vfcpst:= 0;
  Self.ICMS.Vbcfcpstret:= 0;
  Self.ICMS.Pfcpstret:= 0;
  Self.ICMS.Vfcpstret:= 0;
  Self.ICMS.Pst:= 0;
end;

procedure TNfeDet.calcularICMSCST81;
begin
  Self.ICMS.Cst:= '81';
  Self.ICMS.Csosn:= '0';
  Self.ICMS.Modbc:= EmptyStr;
  Self.ICMS.Predbc:= 0;
  Self.ICMS.Vbc:= 0;
  Self.ICMS.Picms:= 0;
  Self.ICMS.Vicms:= 0;
  Self.ICMS.Modbcst:= EmptyStr;
  Self.ICMS.Pmvast:= 0;
  Self.ICMS.Predbcst:= 0;
  Self.ICMS.Vbcst:= 0;
  Self.ICMS.Picmsst:= 0;
  Self.ICMS.Vicmsst:= 0;
  Self.ICMS.Ufst:= EmptyStr;
  Self.ICMS.Pbcop:= 0;
  Self.ICMS.Vbcstret:= 0;
  Self.ICMS.Vicmsstret:= 0;
  Self.ICMS.Motdesicms:= EmptyStr;
  Self.ICMS.Pcredsn:= 0;
  Self.ICMS.Vcredicmssn:= 0;
  Self.ICMS.Vbcstdest:= 0;
  Self.ICMS.Vicmsstdest:= 0;
  Self.ICMS.Vicmsdeson:= 0;
  Self.ICMS.Vicmsop:= 0;
  Self.ICMS.Pdif:= 0;
  Self.ICMS.Vicmsdif:= 0;
  Self.ICMS.Vbcfcp:= 0;
  Self.ICMS.Pfcp:= 0;
  Self.ICMS.Vfcp:= 0;
  Self.ICMS.Vbcfcpst:= 0;
  Self.ICMS.Pfcpst:= 0;
  Self.ICMS.Vfcpst:= 0;
  Self.ICMS.Vbcfcpstret:= 0;
  Self.ICMS.Pfcpstret:= 0;
  Self.ICMS.Vfcpstret:= 0;
  Self.ICMS.Pst:= 0;
end;

procedure TNfeDet.calcularICMSCST90;
begin
  Self.ICMS.Cst:= '90';
  Self.ICMS.Csosn:= '0';
  Self.ICMS.Modbc:= EmptyStr;
  Self.ICMS.Predbc:= 0;
  Self.ICMS.Vbc:= 0;
  Self.ICMS.Picms:= 0;
  Self.ICMS.Vicms:= 0;
  Self.ICMS.Modbcst:= EmptyStr;
  Self.ICMS.Pmvast:= 0;
  Self.ICMS.Predbcst:= 0;
  Self.ICMS.Vbcst:= 0;
  Self.ICMS.Picmsst:= 0;
  Self.ICMS.Vicmsst:= 0;
  Self.ICMS.Ufst:= EmptyStr;
  Self.ICMS.Pbcop:= 0;
  Self.ICMS.Vbcstret:= 0;
  Self.ICMS.Vicmsstret:= 0;
  Self.ICMS.Motdesicms:= EmptyStr;
  Self.ICMS.Pcredsn:= 0;
  Self.ICMS.Vcredicmssn:= 0;
  Self.ICMS.Vbcstdest:= 0;
  Self.ICMS.Vicmsstdest:= 0;
  Self.ICMS.Vicmsdeson:= 0;
  Self.ICMS.Vicmsop:= 0;
  Self.ICMS.Pdif:= 0;
  Self.ICMS.Vicmsdif:= 0;
  Self.ICMS.Vbcfcp:= 0;
  Self.ICMS.Pfcp:= 0;
  Self.ICMS.Vfcp:= 0;
  Self.ICMS.Vbcfcpst:= 0;
  Self.ICMS.Pfcpst:= 0;
  Self.ICMS.Vfcpst:= 0;
  Self.ICMS.Vbcfcpstret:= 0;
  Self.ICMS.Pfcpstret:= 0;
  Self.ICMS.Vfcpstret:= 0;
  Self.ICMS.Pst:= 0;
end;

procedure TNfeDet.calcularICMSCST91;
begin
  Self.ICMS.Cst:= '91';
  Self.ICMS.Csosn:= '0';
  Self.ICMS.Modbc:= EmptyStr;
  Self.ICMS.Predbc:= 0;
  Self.ICMS.Vbc:= 0;
  Self.ICMS.Picms:= 0;
  Self.ICMS.Vicms:= 0;
  Self.ICMS.Modbcst:= EmptyStr;
  Self.ICMS.Pmvast:= 0;
  Self.ICMS.Predbcst:= 0;
  Self.ICMS.Vbcst:= 0;
  Self.ICMS.Picmsst:= 0;
  Self.ICMS.Vicmsst:= 0;
  Self.ICMS.Ufst:= EmptyStr;
  Self.ICMS.Pbcop:= 0;
  Self.ICMS.Vbcstret:= 0;
  Self.ICMS.Vicmsstret:= 0;
  Self.ICMS.Motdesicms:= EmptyStr;
  Self.ICMS.Pcredsn:= 0;
  Self.ICMS.Vcredicmssn:= 0;
  Self.ICMS.Vbcstdest:= 0;
  Self.ICMS.Vicmsstdest:= 0;
  Self.ICMS.Vicmsdeson:= 0;
  Self.ICMS.Vicmsop:= 0;
  Self.ICMS.Pdif:= 0;
  Self.ICMS.Vicmsdif:= 0;
  Self.ICMS.Vbcfcp:= 0;
  Self.ICMS.Pfcp:= 0;
  Self.ICMS.Vfcp:= 0;
  Self.ICMS.Vbcfcpst:= 0;
  Self.ICMS.Pfcpst:= 0;
  Self.ICMS.Vfcpst:= 0;
  Self.ICMS.Vbcfcpstret:= 0;
  Self.ICMS.Pfcpstret:= 0;
  Self.ICMS.Vfcpstret:= 0;
  Self.ICMS.Pst:= 0;
end;

procedure TNfeDet.COFINSCreate;
begin
  if not Assigned(Self.COFINS) then
    Self.FCOFINS:= TNfeDetCofins.Create;
end;

constructor TNfeDet.Create;
begin
  Self.Table:= 'NFE_DET';
end;

procedure TNfeDet.ICMSCreate;
begin
  if not Assigned(Self.ICMS) then
    Self.FICMS:= TNfeDetIcms.Create;
end;

procedure TNfeDet.IPICreate;
begin
  if not Assigned(Self.IPI) then
    Self.FIPI:= TNfeDetIpi.Create;
end;

procedure TNfeDet.PISCreate;
begin
  if not Assigned(Self.PIS) then
    Self.FPIS:= TNfeDetPis.Create;
end;

procedure TNfeDet.processaCalculos;
begin
  Self.Vprod:= (Self.Qcom * Self.Vuncom);
  if (Self.ICMS.Cst <> 'SN') and (Self.ICMS.Cst <> '') and ((Self.ICMS.Csosn = '0') or (Self.ICMS.Csosn = '')) then
  begin
    case AnsiIndexStr(Self.ICMS.Cst,['00','10','20','30','40','41','50','51','60','70','80','81','90','91']) of
      0: calcularICMSCST00();
      1: calcularICMSCST10();
      2: calcularICMSCST20();
      3: calcularICMSCST30();
      4: calcularICMSCST40();
      5: calcularICMSCST41();
      6: calcularICMSCST50();
      7: calcularICMSCST51();
      8: calcularICMSCST60();
      9: calcularICMSCST70();
      10: calcularICMSCST80();
      11: calcularICMSCST81();
      12: calcularICMSCST90();
      13: calcularICMSCST91();
    end;
  end
  else if ((Self.ICMS.Cst = 'SN') or (Self.ICMS.Cst = '')) and (Self.ICMS.Csosn <> '0') and (Self.ICMS.Csosn <> '') then
  begin
    case AnsiIndexStr(Self.ICMS.Csosn,['101','102','103','201','202','203','300','400','500','900']) of
      0: calcularICMSCSOSN101();
      1: calcularICMSCSOSN102();
      2: calcularICMSCSOSN103();
      3: calcularICMSCSOSN201();
      4: calcularICMSCSOSN202();
      5: calcularICMSCSOSN203();
      6: calcularICMSCSOSN300();
      7: calcularICMSCSOSN400();
      8: calcularICMSCSOSN500();
      9: calcularICMSCSOSN900();
    end;
  end;
end;

destructor TNfeDet.Destroy;
begin
  if Assigned(Self.FITEM) then FreeAndNil(Self.FITEM);
  if Assigned(Self.FICMS) then FreeAndNil(Self.FICMS);
  if Assigned(Self.FIPI) then FreeAndNil(Self.FIPI);
  if Assigned(Self.FPIS) then FreeAndNil(Self.FPIS);
  if Assigned(Self.FCOFINS) then FreeAndNil(Self.FCOFINS);

  inherited;
end;

class function TNfeDet.find(id: string): TNfeDet;
const
  FSql: string = 'SELECT * FROM NFE_DET WHERE (ID = :ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ID').AsString:= id;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TNfeDet.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.NfeId:= FDQuery.FieldByName('NFE_ID').AsString;
        Result.ItemId:= FDQuery.FieldByName('ITEM_ID').AsString;
        Result.UnidadeConversaoId:= FDQuery.FieldByName('UNIDADE_CONVERSAO_ID').AsString;
        Result.Cprod:= FDQuery.FieldByName('CPROD').AsString;
        Result.Nitem:= FDQuery.FieldByName('NITEM').AsInteger;
        Result.Cean:= FDQuery.FieldByName('CEAN').AsString;
        Result.Xprod:= FDQuery.FieldByName('XPROD').AsString;
        Result.Ncm:= FDQuery.FieldByName('NCM').AsString;
        Result.Extipi:= FDQuery.FieldByName('EXTIPI').AsString;
        Result.Cfop:= FDQuery.FieldByName('CFOP').AsString;
        Result.Ucom:= FDQuery.FieldByName('UCOM').AsString;
        Result.Qcom:= FDQuery.FieldByName('QCOM').AsExtended;
        Result.Vuncom:= FDQuery.FieldByName('VUNCOM').AsExtended;
        Result.Vprod:= FDQuery.FieldByName('VPROD').AsExtended;
        Result.Ceantrib:= FDQuery.FieldByName('CEANTRIB').AsString;
        Result.Utrib:= FDQuery.FieldByName('UTRIB').AsString;
        Result.Qtrib:= FDQuery.FieldByName('QTRIB').AsExtended;
        Result.Vuntrib:= FDQuery.FieldByName('VUNTRIB').AsExtended;
        Result.Vfrete:= FDQuery.FieldByName('VFRETE').AsExtended;
        Result.Vseg:= FDQuery.FieldByName('VSEG').AsExtended;
        Result.Vdesc:= FDQuery.FieldByName('VDESC').AsExtended;
        Result.Voutro:= FDQuery.FieldByName('VOUTRO').AsExtended;
        Result.Indtot:= FDQuery.FieldByName('INDTOT').AsString;
        Result.Xped:= FDQuery.FieldByName('XPED').AsString;
        Result.Nitemped:= FDQuery.FieldByName('NITEMPED').AsString;
        Result.Nrecopi:= FDQuery.FieldByName('NRECOPI').AsString;
        Result.Nfci:= FDQuery.FieldByName('NFCI').AsString;
        Result.Cest:= FDQuery.FieldByName('CEST').AsString;
        Result.Vtottrib:= FDQuery.FieldByName('VTOTTRIB').AsExtended;
        Result.Pdevol:= FDQuery.FieldByName('PDEVOL').AsExtended;
        Result.Vipidevol:= FDQuery.FieldByName('VIPIDEVOL').AsExtended;
        Result.Infadprod:= FDQuery.FieldByName('INFADPROD').AsString;
        Result.CreatedAt:= FDQuery.FieldByName('CREATED_AT').AsDateTime;
        Result.UpdatedAt:= FDQuery.FieldByName('UPDATED_AT').AsDateTime;
        Result.Synchronized:= FDQuery.FieldByName('SYNCHRONIZED').AsString;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class procedure TNfeDet.findByNfeId(NfeId: string; DataSet: TFDMemTable);
var
  vList: TObjectList<TNfeDet>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  vList:= TNfeDet.findByNfeId(NfeId);
  if Assigned(vList) then
  begin
    for I := 0 to Pred(vList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= vList.Items[I].Id;
      DataSet.FieldByName('CPROD').AsString:= vList.Items[I].Cprod;
      DataSet.FieldByName('XPROD').AsString:= vList.Items[I].Xprod;
      DataSet.FieldByName('NCM').AsString:= vList.Items[I].Ncm;
      if Assigned(vList.Items[I].ICMS) then
      begin
        DataSet.FieldByName('CST').AsString:= vList.Items[I].ICMS.Cst;
        DataSet.FieldByName('CSOSN').AsString:= vList.Items[I].ICMS.Csosn;
      end;
      DataSet.FieldByName('CFOP').AsString:= vList.Items[I].Cfop;
      DataSet.FieldByName('UCOM').AsString:= vList.Items[I].Ucom;
      DataSet.FieldByName('QCOM').AsExtended:= vList.Items[I].Qcom;
      DataSet.FieldByName('VUNCOM').AsExtended:= vList.Items[I].Vuncom;
      DataSet.FieldByName('VDESC').AsExtended:= vList.Items[I].Vdesc;
      DataSet.FieldByName('VPROD').AsExtended:= (vList.Items[I].Vprod - vList.Items[I].Vdesc);
      DataSet.Post;
    end;
    FreeAndNil(vList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TNfeDet.findByNfeId(NfeId: string): TObjectList<TNfeDet>;
const
  FSql: string =
  'SELECT ID FROM NFE_DET WHERE (NFE_ID = :NFE_ID)' +
  ' AND (DELETED_AT IS NULL) ORDER BY NITEM';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('NFE_ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('NFE_ID').AsString:= NfeId;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TNfeDet>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TNfeDet.find(FDQuery.FieldByName('ID').AsString));
          FDQuery.Next;
        end;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeDet.getCOFINS: TNfeDetCofins;
begin
  if not Assigned(Self.FCOFINS) and (Self.Id <> EmptyStr) then
    Self.FCOFINS:= TNfeDetCofins.findByNfeDetId(Self.Id);

  Result:= Self.FCOFINS;
end;

function TNfeDet.getICMS: TNfeDetIcms;
begin
  if not Assigned(Self.FICMS) and (Self.Id <> EmptyStr) then
    Self.FICMS:= TNfeDetIcms.findByNfeDetId(Self.Id);

  Result:= Self.FICMS;
end;

function TNfeDet.getIPI: TNfeDetIpi;
begin
  if not Assigned(Self.FIPI) and (Self.Id <> EmptyStr) then
    Self.FIPI:= TNfeDetIpi.findByNfeDetId(Self.Id);

  Result:= Self.FIPI;
end;

function TNfeDet.getITEM: TItem;
begin
  if not Assigned(Self.FITEM) then
    Self.FITEM:= TItem.find(Self.FITEM_ID)
  else if Self.FITEM.Id <> Self.FITEM_ID then
  begin
    FreeAndNil(FITEM);
    Self.FITEM:= TItem.find(Self.FITEM_ID);
  end;
  Result:= Self.FITEM;
end;

function TNfeDet.getPIS: TNfeDetPis;
begin
  if not Assigned(Self.FPIS) and (Self.Id <> EmptyStr) then
    Self.FPIS:= TNfeDetPis.findByNfeDetId(Self.Id);

  Result:= Self.FPIS;
end;

function TNfeDet.save: Boolean;
begin
  Result:= inherited;
end;

function TNfeDet.store: Boolean;
const
  FSql: string =
  'INSERT INTO NFE_DET (    ' +
  '  ID,                    ' +
  '  EMPRESA_ID,            ' +
  '  NFE_ID,                ' +
  '  ITEM_ID,               ' +
  '  UNIDADE_CONVERSAO_ID,  ' +
  '  CPROD,                 ' +
  '  NITEM,                 ' +
  '  CEAN,                  ' +
  '  XPROD,                 ' +
  '  NCM,                   ' +
  '  EXTIPI,                ' +
  '  CFOP,                  ' +
  '  UCOM,                  ' +
  '  QCOM,                  ' +
  '  VUNCOM,                ' +
  '  VPROD,                 ' +
  '  CEANTRIB,              ' +
  '  UTRIB,                 ' +
  '  QTRIB,                 ' +
  '  VUNTRIB,               ' +
  '  VFRETE,                ' +
  '  VSEG,                  ' +
  '  VDESC,                 ' +
  '  VOUTRO,                ' +
  '  INDTOT,                ' +
  '  XPED,                  ' +
  '  NITEMPED,              ' +
  '  NRECOPI,               ' +
  '  NFCI,                  ' +
  '  CEST,                  ' +
  '  VTOTTRIB,              ' +
  '  PDEVOL,                ' +
  '  VIPIDEVOL,             ' +
  '  INFADPROD,             ' +
  '  CREATED_AT,            ' +
  '  UPDATED_AT)            ' +
  'VALUES (                 ' +
  '  :ID,                   ' +
  '  :EMPRESA_ID,           ' +
  '  :NFE_ID,               ' +
  '  :ITEM_ID,              ' +
  '  :UNIDADE_CONVERSAO_ID, ' +
  '  :CPROD,                ' +
  '  :NITEM,                ' +
  '  :CEAN,                 ' +
  '  :XPROD,                ' +
  '  :NCM,                  ' +
  '  :EXTIPI,               ' +
  '  :CFOP,                 ' +
  '  :UCOM,                 ' +
  '  :QCOM,                 ' +
  '  :VUNCOM,               ' +
  '  :VPROD,                ' +
  '  :CEANTRIB,             ' +
  '  :UTRIB,                ' +
  '  :QTRIB,                ' +
  '  :VUNTRIB,              ' +
  '  :VFRETE,               ' +
  '  :VSEG,                 ' +
  '  :VDESC,                ' +
  '  :VOUTRO,               ' +
  '  :INDTOT,               ' +
  '  :XPED,                 ' +
  '  :NITEMPED,             ' +
  '  :NRECOPI,              ' +
  '  :NFCI,                 ' +
  '  :CEST,                 ' +
  '  :VTOTTRIB,             ' +
  '  :PDEVOL,               ' +
  '  :VIPIDEVOL,            ' +
  '  :INFADPROD,            ' +
  '  :CREATED_AT,           ' +
  '  :UPDATED_AT)           ' ;
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('NFE_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('ITEM_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('UNIDADE_CONVERSAO_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CPROD').DataType:= ftWideString;
      FDQuery.Params.ParamByName('NITEM').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CEAN').DataType:= ftWideString;
      FDQuery.Params.ParamByName('XPROD').DataType:= ftWideString;
      FDQuery.Params.ParamByName('NCM').DataType:= ftWideString;
      FDQuery.Params.ParamByName('EXTIPI').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CFOP').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('UCOM').DataType:= ftWideString;
      FDQuery.Params.ParamByName('QCOM').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VUNCOM').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VPROD').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CEANTRIB').DataType:= ftWideString;
      FDQuery.Params.ParamByName('UTRIB').DataType:= ftWideString;
      FDQuery.Params.ParamByName('QTRIB').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VUNTRIB').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VFRETE').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VSEG').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VDESC').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VOUTRO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('INDTOT').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('XPED').DataType:= ftWideString;
      FDQuery.Params.ParamByName('NITEMPED').DataType:= ftWideString;
      FDQuery.Params.ParamByName('NRECOPI').DataType:= ftWideString;
      FDQuery.Params.ParamByName('NFCI').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CEST').DataType:= ftWideString;
      FDQuery.Params.ParamByName('VTOTTRIB').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PDEVOL').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VIPIDEVOL').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('INFADPROD').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.Terminal.EmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NFE_ID').AsString:= Self.NfeId;
      if (Self.ItemId <> EmptyStr) then
      FDQuery.Params.ParamByName('ITEM_ID').AsString:= Self.ItemId;
      if (Self.UnidadeConversaoId <> EmptyStr) then
      FDQuery.Params.ParamByName('UNIDADE_CONVERSAO_ID').AsString:= Self.UnidadeConversaoId;
      if (Self.Cprod <> EmptyStr) then
      FDQuery.Params.ParamByName('CPROD').AsString:= Self.Cprod;
      if (Self.Nitem > 0) then
      FDQuery.Params.ParamByName('NITEM').AsInteger:= Self.Nitem;
      if (Self.Cean <> EmptyStr) then
      FDQuery.Params.ParamByName('CEAN').AsString:= Self.Cean;
      if (Self.Xprod <> EmptyStr) then
      FDQuery.Params.ParamByName('XPROD').AsString:= Self.Xprod;
      if (Self.Ncm <> EmptyStr) then
      FDQuery.Params.ParamByName('NCM').AsString:= Self.Ncm;
      if (Self.Extipi <> EmptyStr) then
      FDQuery.Params.ParamByName('EXTIPI').AsString:= Self.Extipi;
      if (Self.Cfop <> EmptyStr) then
      FDQuery.Params.ParamByName('CFOP').AsString:= Self.Cfop;
      if (Self.Ucom <> EmptyStr) then
      FDQuery.Params.ParamByName('UCOM').AsString:= Self.Ucom;
      FDQuery.Params.ParamByName('QCOM').AsFMTBCD:= Self.Qcom;
      FDQuery.Params.ParamByName('VUNCOM').AsFMTBCD:= Self.Vuncom;
      FDQuery.Params.ParamByName('VPROD').AsFMTBCD:= Self.Vprod;
      if (Self.Ceantrib <> EmptyStr) then
      FDQuery.Params.ParamByName('CEANTRIB').AsString:= Self.Ceantrib;
      if (Self.Utrib <> EmptyStr) then
      FDQuery.Params.ParamByName('UTRIB').AsString:= Self.Utrib;
      FDQuery.Params.ParamByName('QTRIB').AsFMTBCD:= Self.Qtrib;
      FDQuery.Params.ParamByName('VUNTRIB').AsFMTBCD:= Self.Vuntrib;
      FDQuery.Params.ParamByName('VFRETE').AsFMTBCD:= Self.Vfrete;
      FDQuery.Params.ParamByName('VSEG').AsFMTBCD:= Self.Vseg;
      FDQuery.Params.ParamByName('VDESC').AsFMTBCD:= Self.Vdesc;
      FDQuery.Params.ParamByName('VOUTRO').AsFMTBCD:= Self.Voutro;
      if (Self.Indtot <> EmptyStr) then
      FDQuery.Params.ParamByName('INDTOT').AsString:= Self.Indtot;
      if (Self.Xped <> EmptyStr) then
      FDQuery.Params.ParamByName('XPED').AsString:= Self.Xped;
      if (Self.Nitemped <> EmptyStr) then
      FDQuery.Params.ParamByName('NITEMPED').AsString:= Self.Nitemped;
      if (Self.Nrecopi <> EmptyStr) then
      FDQuery.Params.ParamByName('NRECOPI').AsString:= Self.Nrecopi;
      if (Self.Nfci <> EmptyStr) then
      FDQuery.Params.ParamByName('NFCI').AsString:= Self.Nfci;
      if (Self.Cest <> EmptyStr) then
      FDQuery.Params.ParamByName('CEST').AsString:= Self.Cest;
      FDQuery.Params.ParamByName('VTOTTRIB').AsFMTBCD:= Self.Vtottrib;
      FDQuery.Params.ParamByName('PDEVOL').AsFMTBCD:= Self.Pdevol;
      FDQuery.Params.ParamByName('VIPIDEVOL').AsFMTBCD:= Self.Vipidevol;
      if (Self.Infadprod <> EmptyStr) then
      FDQuery.Params.ParamByName('INFADPROD').AsString:= Self.Infadprod;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;

      if Assigned(Self.ICMS) then
      begin
        Self.ICMS.NfeDetId:= Self.Id;
        Self.ICMS.save();
      end;

      if Assigned(Self.IPI) then
      begin
        Self.IPI.NfeDetId:= Self.Id;
        Self.IPI.save();
      end;

      if Assigned(Self.PIS) then
      begin
        Self.PIS.NfeDetId:= Self.Id;
        Self.PIS.save();
      end;

      if Assigned(Self.COFINS) then
      begin
        Self.COFINS.NfeDetId:= Self.Id;
        Self.COFINS.save();
      end;

    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('Item: ' + Self.Xprod + '. Erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeDet.update: Boolean;
const
  FSql: string =
  'UPDATE NFE_DET                                   ' +
  'SET ITEM_ID = :ITEM_ID,                          ' +
  '    CPROD = :CPROD,                              ' +
  '    NITEM = :NITEM,                              ' +
  '    UNIDADE_CONVERSAO_ID = :UNIDADE_CONVERSAO_ID,' +
  '    CEAN = :CEAN,                                ' +
  '    XPROD = :XPROD,                              ' +
  '    NCM = :NCM,                                  ' +
  '    EXTIPI = :EXTIPI,                            ' +
  '    CFOP = :CFOP,                                ' +
  '    UCOM = :UCOM,                                ' +
  '    QCOM = :QCOM,                                ' +
  '    VUNCOM = :VUNCOM,                            ' +
  '    VPROD = :VPROD,                              ' +
  '    CEANTRIB = :CEANTRIB,                        ' +
  '    UTRIB = :UTRIB,                              ' +
  '    QTRIB = :QTRIB,                              ' +
  '    VUNTRIB = :VUNTRIB,                          ' +
  '    VFRETE = :VFRETE,                            ' +
  '    VSEG = :VSEG,                                ' +
  '    VDESC = :VDESC,                              ' +
  '    VOUTRO = :VOUTRO,                            ' +
  '    INDTOT = :INDTOT,                            ' +
  '    XPED = :XPED,                                ' +
  '    NITEMPED = :NITEMPED,                        ' +
  '    NRECOPI = :NRECOPI,                          ' +
  '    NFCI = :NFCI,                                ' +
  '    CEST = :CEST,                                ' +
  '    VTOTTRIB = :VTOTTRIB,                        ' +
  '    PDEVOL = :PDEVOL,                            ' +
  '    VIPIDEVOL = :VIPIDEVOL,                      ' +
  '    INFADPROD = :INFADPROD,                      ' +
  '    UPDATED_AT = :UPDATED_AT,                    ' +
  '    SYNCHRONIZED = :SYNCHRONIZED                 ' +
  'WHERE (ID = :ID)                                 ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('ITEM_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('UNIDADE_CONVERSAO_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CPROD').DataType:= ftWideString;
      FDQuery.Params.ParamByName('NITEM').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CEAN').DataType:= ftWideString;
      FDQuery.Params.ParamByName('XPROD').DataType:= ftWideString;
      FDQuery.Params.ParamByName('NCM').DataType:= ftWideString;
      FDQuery.Params.ParamByName('EXTIPI').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CFOP').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('UCOM').DataType:= ftWideString;
      FDQuery.Params.ParamByName('QCOM').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VUNCOM').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VPROD').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CEANTRIB').DataType:= ftWideString;
      FDQuery.Params.ParamByName('UTRIB').DataType:= ftWideString;
      FDQuery.Params.ParamByName('QTRIB').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VUNTRIB').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VFRETE').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VSEG').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VDESC').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VOUTRO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('INDTOT').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('XPED').DataType:= ftWideString;
      FDQuery.Params.ParamByName('NITEMPED').DataType:= ftWideString;
      FDQuery.Params.ParamByName('NRECOPI').DataType:= ftWideString;
      FDQuery.Params.ParamByName('NFCI').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CEST').DataType:= ftWideString;
      FDQuery.Params.ParamByName('VTOTTRIB').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PDEVOL').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VIPIDEVOL').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('INFADPROD').DataType:= ftWideString;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.ItemId <> EmptyStr) then
      FDQuery.Params.ParamByName('ITEM_ID').AsString:= Self.ItemId;
      if (Self.UnidadeConversaoId <> EmptyStr) then
      FDQuery.Params.ParamByName('UNIDADE_CONVERSAO_ID').AsString:= Self.UnidadeConversaoId;
      if (Self.Cprod <> EmptyStr) then
      FDQuery.Params.ParamByName('CPROD').AsString:= Self.Cprod;
      if (Self.Nitem > 0) then
      FDQuery.Params.ParamByName('NITEM').AsInteger:= Self.Nitem;
      if (Self.Cean <> EmptyStr) then
      FDQuery.Params.ParamByName('CEAN').AsString:= Self.Cean;
      if (Self.Xprod <> EmptyStr) then
      FDQuery.Params.ParamByName('XPROD').AsString:= Self.Xprod;
      if (Self.Ncm <> EmptyStr) then
      FDQuery.Params.ParamByName('NCM').AsString:= Self.Ncm;
      if (Self.Extipi <> EmptyStr) then
      FDQuery.Params.ParamByName('EXTIPI').AsString:= Self.Extipi;
      if (Self.Cfop <> EmptyStr) then
      FDQuery.Params.ParamByName('CFOP').AsString:= Self.Cfop;
      if (Self.Ucom <> EmptyStr) then
      FDQuery.Params.ParamByName('UCOM').AsString:= Self.Ucom;
      FDQuery.Params.ParamByName('QCOM').AsFMTBCD:= Self.Qcom;
      FDQuery.Params.ParamByName('VUNCOM').AsFMTBCD:= Self.Vuncom;
      FDQuery.Params.ParamByName('VPROD').AsFMTBCD:= Self.Vprod;
      if (Self.Ceantrib <> EmptyStr) then
      FDQuery.Params.ParamByName('CEANTRIB').AsString:= Self.Ceantrib;
      if (Self.Utrib <> EmptyStr) then
      FDQuery.Params.ParamByName('UTRIB').AsString:= Self.Utrib;
      FDQuery.Params.ParamByName('QTRIB').AsFMTBCD:= Self.Qtrib;
      FDQuery.Params.ParamByName('VUNTRIB').AsFMTBCD:= Self.Vuntrib;
      FDQuery.Params.ParamByName('VFRETE').AsFMTBCD:= Self.Vfrete;
      FDQuery.Params.ParamByName('VSEG').AsFMTBCD:= Self.Vseg;
      FDQuery.Params.ParamByName('VDESC').AsFMTBCD:= Self.Vdesc;
      FDQuery.Params.ParamByName('VOUTRO').AsFMTBCD:= Self.Voutro;
      if (Self.Indtot <> EmptyStr) then
      FDQuery.Params.ParamByName('INDTOT').AsString:= Self.Indtot;
      if (Self.Xped <> EmptyStr) then
      FDQuery.Params.ParamByName('XPED').AsString:= Self.Xped;
      if (Self.Nitemped <> EmptyStr) then
      FDQuery.Params.ParamByName('NITEMPED').AsString:= Self.Nitemped;
      if (Self.Nrecopi <> EmptyStr) then
      FDQuery.Params.ParamByName('NRECOPI').AsString:= Self.Nrecopi;
      if (Self.Nfci <> EmptyStr) then
      FDQuery.Params.ParamByName('NFCI').AsString:= Self.Nfci;
      if (Self.Cest <> EmptyStr) then
      FDQuery.Params.ParamByName('CEST').AsString:= Self.Cest;
      FDQuery.Params.ParamByName('VTOTTRIB').AsFMTBCD:= Self.Vtottrib;
      FDQuery.Params.ParamByName('PDEVOL').AsFMTBCD:= Self.Pdevol;
      FDQuery.Params.ParamByName('VIPIDEVOL').AsFMTBCD:= Self.Vipidevol;
      if (Self.Infadprod <> EmptyStr) then
      FDQuery.Params.ParamByName('INFADPROD').AsString:= Self.Infadprod;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;

      if Assigned(Self.ICMS) then
      begin
        Self.ICMS.NfeDetId:= Self.Id;
        Self.ICMS.save();
      end;

      if Assigned(Self.IPI) then
      begin
        Self.IPI.NfeDetId:= Self.Id;
        Self.IPI.save();
      end;

      if Assigned(Self.PIS) then
      begin
        Self.PIS.NfeDetId:= Self.Id;
        Self.PIS.save();
      end;

      if Assigned(Self.COFINS) then
      begin
        Self.COFINS.NfeDetId:= Self.Id;
        Self.COFINS.save();
      end;

    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('Item: ' + Self.Xprod + '. Erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
