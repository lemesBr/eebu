unit Item;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TItem = class(TModel)
  private
    FEMPRESA_ID: String;
    FREFERENCIA: Integer;
    FEAN: String;
    FNOME: String;
    FNCM: String;
    FEXTIPI: String;
    FUNIDADE: String;
    FEAN_TRIBUTAVEL: String;
    FUNIDADE_TRIBUTAVEL: String;
    FCEST: String;
    FPRECO_VENDA: Extended;
    FCFOP: String;
    FICMS_ORIG: String;
    FICMS_CST: String;
    FICMS_CSOSN: String;
    FIPI_CST: String;
    FPIS_CST: String;
    FCOFINS_CST: String;

  public 
    constructor Create();
    function save(): Boolean;

    class function find(Id: string): TItem;
    class function findByReferencia(Referencia: Integer): TItem;
    class function findByEan(Ean: string): TItem;
    class function list(pSearch: string): TObjectList<TItem>; overload;
    class procedure list(pSearch: string; pDt: TFDMemTable); overload;


    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property Referencia: Integer  read FREFERENCIA write FREFERENCIA;
    property Ean: String  read FEAN write FEAN;
    property Nome: String  read FNOME write FNOME;
    property Ncm: String  read FNCM write FNCM;
    property Extipi: String  read FEXTIPI write FEXTIPI;
    property Unidade: String  read FUNIDADE write FUNIDADE;
    property EanTributavel: String  read FEAN_TRIBUTAVEL write FEAN_TRIBUTAVEL;
    property UnidadeTributavel: String  read FUNIDADE_TRIBUTAVEL write FUNIDADE_TRIBUTAVEL;
    property Cest: String  read FCEST write FCEST;
    property PrecoVenda: Extended  read FPRECO_VENDA write FPRECO_VENDA;
    property Cfop: String  read FCFOP write FCFOP;
    property IcmsOrig: String  read FICMS_ORIG write FICMS_ORIG;
    property IcmsCst: String  read FICMS_CST write FICMS_CST;
    property IcmsCsosn: String  read FICMS_CSOSN write FICMS_CSOSN;
    property IpiCst: String  read FIPI_CST write FIPI_CST;
    property PisCst: String  read FPIS_CST write FPIS_CST;
    property CofinsCst: String  read FCOFINS_CST write FCOFINS_CST;

  end;

implementation

uses
  AuthService;



{ TItem }

constructor TItem.Create;
begin
  Self.Table:= 'ITENS';
end;

class function TItem.find(Id: string): TItem;
const
  FSql: string = 'SELECT * FROM ITENS WHERE (ID = :ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ID').AsString:= Id;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TItem.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.Referencia:= FDQuery.FieldByName('REFERENCIA').AsInteger;
        Result.Ean:= FDQuery.FieldByName('EAN').AsString;
        Result.Nome:= FDQuery.FieldByName('NOME').AsString;
        Result.Ncm:= FDQuery.FieldByName('NCM').AsString;
        Result.Extipi:= FDQuery.FieldByName('EXTIPI').AsString;
        Result.Unidade:= FDQuery.FieldByName('UNIDADE').AsString;
        Result.EanTributavel:= FDQuery.FieldByName('EAN_TRIBUTAVEL').AsString;
        Result.UnidadeTributavel:= FDQuery.FieldByName('UNIDADE_TRIBUTAVEL').AsString;
        Result.Cest:= FDQuery.FieldByName('CEST').AsString;
        Result.PrecoVenda:= FDQuery.FieldByName('PRECO_VENDA').AsExtended;
        Result.Cfop:= FDQuery.FieldByName('CFOP').AsString;
        Result.IcmsOrig:= FDQuery.FieldByName('ICMS_ORIG').AsString;
        Result.IcmsCst:= FDQuery.FieldByName('ICMS_CST').AsString;
        Result.IcmsCsosn:= FDQuery.FieldByName('ICMS_CSOSN').AsString;
        Result.IpiCst:= FDQuery.FieldByName('IPI_CST').AsString;
        Result.PisCst:= FDQuery.FieldByName('PIS_CST').AsString;
        Result.CofinsCst:= FDQuery.FieldByName('COFINS_CST').AsString;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TItem.findByEan(Ean: string): TItem;
const
  FSql: string =
  'SELECT ID FROM ITENS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (EAN = :EAN)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= TModel.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('EAN').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Params.ParamByName('EAN').AsString:= Ean;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
        Result:= TItem.find(FDQuery.FieldByName('ID').AsString);
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TItem.findByReferencia(Referencia: Integer): TItem;
const
  FSql: string =
  'SELECT ID FROM ITENS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (REFERENCIA = :REFERENCIA)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= Referencia;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
        Result:= TItem.find(FDQuery.FieldByName('ID').AsString);
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TItem.list(pSearch: string): TObjectList<TItem>;
const
  FSql: string =
  'SELECT FIRST 30 ID FROM ITENS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND ((NOME LIKE :SEARCH) OR (REFERENCIA = :REFERENCIA) OR (EAN = :EAN))';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('SEARCH').DataType:= ftString;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('EAN').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Params.ParamByName('SEARCH').AsString:= '%' + pSearch + '%';
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= StrToIntDef(pSearch, 0);
      FDQuery.Params.ParamByName('EAN').AsString:= pSearch;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TObjectList<TItem>.Create;
        FDQuery.First();
        while not FDQuery.Eof do
        begin
          Result.Add(TItem.find(FDQuery.FieldByName('ID').AsString));
          FDQuery.Next();
        end;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class procedure TItem.list(pSearch: string; pDt: TFDMemTable);
var
  vlist: TObjectList<TItem>;
  I: Integer;
begin
  pDt.Open();
  pDt.DisableControls();
  pDt.EmptyDataSet();
  vlist:= TItem.list(pSearch);
  if Assigned(vlist) then
  begin
    for I := 0 to Pred(vlist.Count) do
    begin
      pDt.Append();
      pDt.FieldByName('ID').AsString:= vlist.Items[I].Id;
      pDt.FieldByName('REFERENCIA').AsInteger:= vlist.Items[I].Referencia;
      pDt.FieldByName('EAN').AsString:= vlist.Items[I].Ean;
      pDt.FieldByName('NOME').AsString:= vlist.Items[I].Nome;
      pDt.FieldByName('PRECO_VENDA').AsExtended:= vlist.Items[I].PrecoVenda;
      pDt.Post();
    end;
    FreeAndNil(vlist);
  end;
  pDt.First();
  pDt.EnableControls();
end;

function TItem.save: Boolean;
const
  FSql: string =
  'UPDATE OR INSERT INTO ITENS ( ' +
  '  ID,                         ' +
  '  EMPRESA_ID,                 ' +
  '  REFERENCIA,                 ' +
  '  EAN,                        ' +
  '  NOME,                       ' +
  '  NCM,                        ' +
  '  EXTIPI,                     ' +
  '  UNIDADE,                    ' +
  '  EAN_TRIBUTAVEL,             ' +
  '  UNIDADE_TRIBUTAVEL,         ' +
  '  CEST,                       ' +
  '  PRECO_VENDA,                ' +
  '  CFOP,                       ' +
  '  ICMS_ORIG,                  ' +
  '  ICMS_CST,                   ' +
  '  ICMS_CSOSN,                 ' +
  '  IPI_CST,                    ' +
  '  PIS_CST,                    ' +
  '  COFINS_CST)                 ' +
  'VALUES (                      ' +
  '  :ID,                        ' +
  '  :EMPRESA_ID,                ' +
  '  :REFERENCIA,                ' +
  '  :EAN,                       ' +
  '  :NOME,                      ' +
  '  :NCM,                       ' +
  '  :EXTIPI,                    ' +
  '  :UNIDADE,                   ' +
  '  :EAN_TRIBUTAVEL,            ' +
  '  :UNIDADE_TRIBUTAVEL,        ' +
  '  :CEST,                      ' +
  '  :PRECO_VENDA,               ' +
  '  :CFOP,                      ' +
  '  :ICMS_ORIG,                 ' +
  '  :ICMS_CST,                  ' +
  '  :ICMS_CSOSN,                ' +
  '  :IPI_CST,                   ' +
  '  :PIS_CST,                   ' +
  '  :COFINS_CST) MATCHING (ID)  ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('EAN').DataType:= ftString;
      FDQuery.Params.ParamByName('NOME').DataType:= ftString;
      FDQuery.Params.ParamByName('NCM').DataType:= ftString;
      FDQuery.Params.ParamByName('EXTIPI').DataType:= ftString;
      FDQuery.Params.ParamByName('UNIDADE').DataType:= ftString;
      FDQuery.Params.ParamByName('EAN_TRIBUTAVEL').DataType:= ftString;
      FDQuery.Params.ParamByName('UNIDADE_TRIBUTAVEL').DataType:= ftString;
      FDQuery.Params.ParamByName('CEST').DataType:= ftString;
      FDQuery.Params.ParamByName('PRECO_VENDA').DataType:= ftExtended;
      FDQuery.Params.ParamByName('CFOP').DataType:= ftString;
      FDQuery.Params.ParamByName('ICMS_ORIG').DataType:= ftString;
      FDQuery.Params.ParamByName('ICMS_CST').DataType:= ftString;
      FDQuery.Params.ParamByName('ICMS_CSOSN').DataType:= ftString;
      FDQuery.Params.ParamByName('IPI_CST').DataType:= ftString;
      FDQuery.Params.ParamByName('PIS_CST').DataType:= ftString;
      FDQuery.Params.ParamByName('COFINS_CST').DataType:= ftString;
      FDQuery.Prepare();

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= Self.Referencia;
      if (Self.Ean <> EmptyStr) then
      FDQuery.Params.ParamByName('EAN').AsString:= Self.Ean;
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      if (Self.Ncm <> EmptyStr) then
      FDQuery.Params.ParamByName('NCM').AsString:= Self.Ncm;
      if (Self.Extipi <> EmptyStr) then
      FDQuery.Params.ParamByName('EXTIPI').AsString:= Self.Extipi;
      FDQuery.Params.ParamByName('UNIDADE').AsString:= Self.Unidade;
      if (Self.EanTributavel <> EmptyStr) then
      FDQuery.Params.ParamByName('EAN_TRIBUTAVEL').AsString:= Self.EanTributavel;
      FDQuery.Params.ParamByName('UNIDADE_TRIBUTAVEL').AsString:= Self.UnidadeTributavel;
      if (Self.Cest <> EmptyStr) then
      FDQuery.Params.ParamByName('CEST').AsString:= Self.Cest;
      if (Self.PrecoVenda > 0) then
      FDQuery.Params.ParamByName('PRECO_VENDA').AsExtended:= Self.PrecoVenda;
      FDQuery.Params.ParamByName('CFOP').AsString:= Self.Cfop;
      FDQuery.Params.ParamByName('ICMS_ORIG').AsString:= Self.IcmsOrig;
      if (Self.IcmsCst <> EmptyStr) then
      FDQuery.Params.ParamByName('ICMS_CST').AsString:= Self.IcmsCst;
      if (Self.IcmsCsosn <> EmptyStr) then
      FDQuery.Params.ParamByName('ICMS_CSOSN').AsString:= Self.IcmsCsosn;
      FDQuery.Params.ParamByName('IPI_CST').AsString:= Self.IpiCst;
      FDQuery.Params.ParamByName('PIS_CST').AsString:= Self.PisCst;
      FDQuery.Params.ParamByName('COFINS_CST').AsString:= Self.CofinsCst;
      FDQuery.ExecSQL();
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao gravar dados do item. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
