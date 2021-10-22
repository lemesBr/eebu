unit ConfiguracaoFiscalIcms;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TConfiguracaoFiscalIcms = class(TModel)
  private
    FEMPRESA_ID: String;
    FCONFIGURACAO_FISCAL_ID: String;
    FUF_DESTINO: String;
    FCFOP: String;
    FCST: String;
    FCSOSN: String;
    FMODBC: String;
    FPREDBC: Extended;
    FPICMS: Extended;
    FMODBCST: String;
    FPMVAST: Extended;
    FPREDBCST: Extended;
    FPICMSST: Extended;
    FMOTDESICMS: String;
    FPCREDSN: Extended;
    FPDIF: Extended;
    FPFCP: Extended;
    FPFCPST: Extended;
    FPFCPSTRET: Extended;
    FPFCPUFDEST: Extended;
    FPICMSUFDEST: Extended;
    FPICMSINTER: Extended;
    FPICMSINTERPART: Extended;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    function delete(): Boolean;
    class function find(id: string): TConfiguracaoFiscalIcms;
    class function listByConfiguracaoFiscalId(ConfiguracaoFiscalId: string): TObjectList<TConfiguracaoFiscalIcms>; overload;
    class procedure listByConfiguracaoFiscalId(ConfiguracaoFiscalId: string; DataSet: TFDMemTable); overload;
    class function remove(id: string): Boolean;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property ConfiguracaoFiscalId: String  read FCONFIGURACAO_FISCAL_ID write FCONFIGURACAO_FISCAL_ID;
    property UfDestino: String  read FUF_DESTINO write FUF_DESTINO;
    property Cfop: String  read FCFOP write FCFOP;
    property Cst: String  read FCST write FCST;
    property Csosn: String  read FCSOSN write FCSOSN;
    property Modbc: String  read FMODBC write FMODBC;
    property Predbc: Extended  read FPREDBC write FPREDBC;
    property Picms: Extended  read FPICMS write FPICMS;
    property Modbcst: String  read FMODBCST write FMODBCST;
    property Pmvast: Extended  read FPMVAST write FPMVAST;
    property Predbcst: Extended  read FPREDBCST write FPREDBCST;
    property Picmsst: Extended  read FPICMSST write FPICMSST;
    property Motdesicms: String  read FMOTDESICMS write FMOTDESICMS;
    property Pcredsn: Extended  read FPCREDSN write FPCREDSN;
    property Pdif: Extended  read FPDIF write FPDIF;
    property Pfcp: Extended  read FPFCP write FPFCP;
    property Pfcpst: Extended  read FPFCPST write FPFCPST;
    property Pfcpstret: Extended  read FPFCPSTRET write FPFCPSTRET;
    property Pfcpufdest: Extended  read FPFCPUFDEST write FPFCPUFDEST;
    property Picmsufdest: Extended  read FPICMSUFDEST write FPICMSUFDEST;
    property Picmsinter: Extended  read FPICMSINTER write FPICMSINTER;
    property Picmsinterpart: Extended  read FPICMSINTERPART write FPICMSINTERPART;

  end;

implementation

uses
  AuthService, Helper;

{ TConfiguracaoFiscalIcms }

constructor TConfiguracaoFiscalIcms.Create;
begin
  Self.Table:= 'CONFIGURACAO_FISCAL_ICMS';
end;

class function TConfiguracaoFiscalIcms.listByConfiguracaoFiscalId(
  ConfiguracaoFiscalId: string): TObjectList<TConfiguracaoFiscalIcms>;
const
  FSql: string =
  'SELECT ID FROM CONFIGURACAO_FISCAL_ICMS ' +
  'WHERE (EMPRESA_ID =:EMPRESA_ID) ' +
  'AND (DELETED_AT IS NULL)' +
  'AND (CONFIGURACAO_FISCAL_ID = :CONFIGURACAO_FISCAL_ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= TModel.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CONFIGURACAO_FISCAL_ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('CONFIGURACAO_FISCAL_ID').AsString:= ConfiguracaoFiscalId;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TConfiguracaoFiscalIcms>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TConfiguracaoFiscalIcms.find(FDQuery.FieldByName('ID').AsString));
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

function TConfiguracaoFiscalIcms.delete: Boolean;
const
  FSql: string =
  'UPDATE CONFIGURACAO_FISCAL_ICMS  ' +
  'SET UPDATED_AT = :UPDATED_AT,    ' +
  '    DELETED_AT = :DELETED_AT,    ' +
  '    SYNCHRONIZED = :SYNCHRONIZED ' +
  'WHERE (ID = :ID)                 ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('DELETED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('DELETED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('falha ao remover configuração fiscal de icms.. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TConfiguracaoFiscalIcms.find(
  id: string): TConfiguracaoFiscalIcms;
const
  FSql: string = 'SELECT * FROM CONFIGURACAO_FISCAL_ICMS WHERE (ID = :ID)';
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
        Result:= TConfiguracaoFiscalIcms.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.ConfiguracaoFiscalId:= FDQuery.FieldByName('CONFIGURACAO_FISCAL_ID').AsString;
        Result.UfDestino:= FDQuery.FieldByName('UF_DESTINO').AsString;
        Result.Cfop:= FDQuery.FieldByName('CFOP').AsString;
        Result.Cst:= FDQuery.FieldByName('CST').AsString;
        Result.Csosn:= FDQuery.FieldByName('CSOSN').AsString;
        Result.Modbc:= FDQuery.FieldByName('MODBC').AsString;
        Result.Predbc:= FDQuery.FieldByName('PREDBC').AsExtended;
        Result.Picms:= FDQuery.FieldByName('PICMS').AsExtended;
        Result.Modbcst:= FDQuery.FieldByName('MODBCST').AsString;
        Result.Pmvast:= FDQuery.FieldByName('PMVAST').AsExtended;
        Result.Predbcst:= FDQuery.FieldByName('PREDBCST').AsExtended;
        Result.Picmsst:= FDQuery.FieldByName('PICMSST').AsExtended;
        Result.Motdesicms:= FDQuery.FieldByName('MOTDESICMS').AsString;
        Result.Pcredsn:= FDQuery.FieldByName('PCREDSN').AsExtended;
        Result.Pdif:= FDQuery.FieldByName('PDIF').AsExtended;
        Result.Pfcp:= FDQuery.FieldByName('PFCP').AsExtended;
        Result.Pfcpst:= FDQuery.FieldByName('PFCPST').AsExtended;
        Result.Pfcpstret:= FDQuery.FieldByName('PFCPSTRET').AsExtended;
        Result.Pfcpufdest:= FDQuery.FieldByName('PFCPUFDEST').AsExtended;
        Result.Picmsufdest:= FDQuery.FieldByName('PICMSUFDEST').AsExtended;
        Result.Picmsinter:= FDQuery.FieldByName('PICMSINTER').AsExtended;
        Result.Picmsinterpart:= FDQuery.FieldByName('PICMSINTERPART').AsExtended;
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

class procedure TConfiguracaoFiscalIcms.listByConfiguracaoFiscalId(
  ConfiguracaoFiscalId: string; DataSet: TFDMemTable);
var
  v_list: TObjectList<TConfiguracaoFiscalIcms>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  v_list:= TConfiguracaoFiscalIcms.listByConfiguracaoFiscalId(ConfiguracaoFiscalId);
  if Assigned(v_list) then
  begin
    for I := 0 to Pred(v_list.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= v_list.Items[I].Id;
      DataSet.FieldByName('UF_DESTINO').AsString:= v_list.Items[I].UfDestino;
      DataSet.Post;
    end;
    FreeAndNil(v_list);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TConfiguracaoFiscalIcms.remove(id: string): Boolean;
var
  ConfiguracaoFiscalIcms: TConfiguracaoFiscalIcms;
begin
  Result:= False;
  ConfiguracaoFiscalIcms:= TConfiguracaoFiscalIcms.find(id);
  if not Assigned(ConfiguracaoFiscalIcms) then
  begin
    THelper.Mensagem('Configuração fiscal de icms não encontrado. A configuração fiscal de icms pode ter sido previamente excluída por outro usuário!');
    Exit();
  end;

  try
    if not THelper.Mensagem('Confirmar a exclusão desta configuração fiscal de icms?', 1) then
      Exit();

    Result:= ConfiguracaoFiscalIcms.delete();
  finally
    FreeAndNil(ConfiguracaoFiscalIcms);
  end;
end;

function TConfiguracaoFiscalIcms.save: Boolean;
begin
  Result:= inherited;
end;

function TConfiguracaoFiscalIcms.store: Boolean;
const
  FSql: string =
  'INSERT INTO CONFIGURACAO_FISCAL_ICMS (' +
  '  ID,                                 ' +
  '  EMPRESA_ID,                         ' +
  '  CONFIGURACAO_FISCAL_ID,             ' +
  '  UF_DESTINO,                         ' +
  '  CFOP,                               ' +
  '  CST,                                ' +
  '  CSOSN,                              ' +
  '  MODBC,                              ' +
  '  PREDBC,                             ' +
  '  PICMS,                              ' +
  '  MODBCST,                            ' +
  '  PMVAST,                             ' +
  '  PREDBCST,                           ' +
  '  PICMSST,                            ' +
  '  MOTDESICMS,                         ' +
  '  PCREDSN,                            ' +
  '  PDIF,                               ' +
  '  PFCP,                               ' +
  '  PFCPST,                             ' +
  '  PFCPSTRET,                          ' +
  '  PFCPUFDEST,                         ' +
  '  PICMSUFDEST,                        ' +
  '  PICMSINTER,                         ' +
  '  PICMSINTERPART,                     ' +
  '  CREATED_AT,                         ' +
  '  UPDATED_AT)                         ' +
  'VALUES (                              ' +
  '  :ID,                                ' +
  '  :EMPRESA_ID,                        ' +
  '  :CONFIGURACAO_FISCAL_ID,            ' +
  '  :UF_DESTINO,                        ' +
  '  :CFOP,                              ' +
  '  :CST,                               ' +
  '  :CSOSN,                             ' +
  '  :MODBC,                             ' +
  '  :PREDBC,                            ' +
  '  :PICMS,                             ' +
  '  :MODBCST,                           ' +
  '  :PMVAST,                            ' +
  '  :PREDBCST,                          ' +
  '  :PICMSST,                           ' +
  '  :MOTDESICMS,                        ' +
  '  :PCREDSN,                           ' +
  '  :PDIF,                              ' +
  '  :PFCP,                              ' +
  '  :PFCPST,                            ' +
  '  :PFCPSTRET,                         ' +
  '  :PFCPUFDEST,                        ' +
  '  :PICMSUFDEST,                       ' +
  '  :PICMSINTER,                        ' +
  '  :PICMSINTERPART,                    ' +
  '  :CREATED_AT,                        ' +
  '  :UPDATED_AT)                        ';
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
      FDQuery.Params.ParamByName('CONFIGURACAO_FISCAL_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('UF_DESTINO').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CFOP').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CSOSN').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('MODBC').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PREDBC').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PICMS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('MODBCST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PMVAST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PREDBCST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PICMSST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('MOTDESICMS').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PCREDSN').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PDIF').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PFCP').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PFCPST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PFCPSTRET').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PFCPUFDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PICMSUFDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PICMSINTER').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PICMSINTERPART').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('CONFIGURACAO_FISCAL_ID').AsString:= Self.ConfiguracaoFiscalId;
      FDQuery.Params.ParamByName('UF_DESTINO').AsString:= Self.UfDestino;
      FDQuery.Params.ParamByName('CFOP').AsString:= Self.Cfop;
      if (Self.Cst <> EmptyStr) then
      FDQuery.Params.ParamByName('CST').AsString:= Self.Cst;
      if (Self.Csosn <> EmptyStr) then
      FDQuery.Params.ParamByName('CSOSN').AsString:= Self.Csosn;
      if (Self.Modbc <> EmptyStr) then
      FDQuery.Params.ParamByName('MODBC').AsString:= Self.Modbc;
      FDQuery.Params.ParamByName('PREDBC').AsFMTBCD:= Self.Predbc;
      FDQuery.Params.ParamByName('PICMS').AsFMTBCD:= Self.Picms;
      if (Self.Modbcst <> EmptyStr) then
      FDQuery.Params.ParamByName('MODBCST').AsString:= Self.Modbcst;
      FDQuery.Params.ParamByName('PMVAST').AsFMTBCD:= Self.Pmvast;
      FDQuery.Params.ParamByName('PREDBCST').AsFMTBCD:= Self.Predbcst;
      FDQuery.Params.ParamByName('PICMSST').AsFMTBCD:= Self.Picmsst;
      if (Self.Motdesicms <> EmptyStr) then
      FDQuery.Params.ParamByName('MOTDESICMS').AsString:= Self.Motdesicms;
      FDQuery.Params.ParamByName('PCREDSN').AsFMTBCD:= Self.Pcredsn;
      FDQuery.Params.ParamByName('PDIF').AsFMTBCD:= Self.Pdif;
      FDQuery.Params.ParamByName('PFCP').AsFMTBCD:= Self.Pfcp;
      FDQuery.Params.ParamByName('PFCPST').AsFMTBCD:= Self.Pfcpst;
      FDQuery.Params.ParamByName('PFCPSTRET').AsFMTBCD:= Self.Pfcpstret;
      FDQuery.Params.ParamByName('PFCPUFDEST').AsFMTBCD:= Self.Pfcpufdest;
      FDQuery.Params.ParamByName('PICMSUFDEST').AsFMTBCD:= Self.Picmsufdest;
      FDQuery.Params.ParamByName('PICMSINTER').AsFMTBCD:= Self.Picmsinter;
      FDQuery.Params.ParamByName('PICMSINTERPART').AsFMTBCD:= Self.Picmsinterpart;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
    begin
      Result:= False;
      raise Exception.Create('falha ao inserir configuração fiscal de icms. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TConfiguracaoFiscalIcms.update: Boolean;
const
  FSql: string =
  'UPDATE CONFIGURACAO_FISCAL_ICMS      ' +
  'SET UF_DESTINO = :UF_DESTINO,        ' +
  '    CFOP = :CFOP,                    ' +
  '    CST = :CST,                      ' +
  '    CSOSN = :CSOSN,                  ' +
  '    MODBC = :MODBC,                  ' +
  '    PREDBC = :PREDBC,                ' +
  '    PICMS = :PICMS,                  ' +
  '    MODBCST = :MODBCST,              ' +
  '    PMVAST = :PMVAST,                ' +
  '    PREDBCST = :PREDBCST,            ' +
  '    PICMSST = :PICMSST,              ' +
  '    MOTDESICMS = :MOTDESICMS,        ' +
  '    PCREDSN = :PCREDSN,              ' +
  '    PDIF = :PDIF,                    ' +
  '    PFCP = :PFCP,                    ' +
  '    PFCPST = :PFCPST,                ' +
  '    PFCPSTRET = :PFCPSTRET,          ' +
  '    PFCPUFDEST = :PFCPUFDEST,        ' +
  '    PICMSUFDEST = :PICMSUFDEST,      ' +
  '    PICMSINTER = :PICMSINTER,        ' +
  '    PICMSINTERPART = :PICMSINTERPART,' +
  '    UPDATED_AT = :UPDATED_AT,        ' +
  '    SYNCHRONIZED = :SYNCHRONIZED     ' +
  'WHERE (ID = :ID)                     ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('UF_DESTINO').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CFOP').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CSOSN').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('MODBC').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PREDBC').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PICMS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('MODBCST').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PMVAST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PREDBCST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PICMSST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('MOTDESICMS').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PCREDSN').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PDIF').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PFCP').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PFCPST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PFCPSTRET').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PFCPUFDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PICMSUFDEST').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PICMSINTER').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PICMSINTERPART').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('UF_DESTINO').AsString:= Self.UfDestino;
      FDQuery.Params.ParamByName('CFOP').AsString:= Self.Cfop;
      if (Self.Cst <> EmptyStr) then
      FDQuery.Params.ParamByName('CST').AsString:= Self.Cst;
      if (Self.Csosn <> EmptyStr) then
      FDQuery.Params.ParamByName('CSOSN').AsString:= Self.Csosn;
      if (Self.Modbc <> EmptyStr) then
      FDQuery.Params.ParamByName('MODBC').AsString:= Self.Modbc;
      FDQuery.Params.ParamByName('PREDBC').AsFMTBCD:= Self.Predbc;
      FDQuery.Params.ParamByName('PICMS').AsFMTBCD:= Self.Picms;
      if (Self.Modbcst <> EmptyStr) then
      FDQuery.Params.ParamByName('MODBCST').AsString:= Self.Modbcst;
      FDQuery.Params.ParamByName('PMVAST').AsFMTBCD:= Self.Pmvast;
      FDQuery.Params.ParamByName('PREDBCST').AsFMTBCD:= Self.Predbcst;
      FDQuery.Params.ParamByName('PICMSST').AsFMTBCD:= Self.Picmsst;
      if (Self.Motdesicms <> EmptyStr) then
      FDQuery.Params.ParamByName('MOTDESICMS').AsString:= Self.Motdesicms;
      FDQuery.Params.ParamByName('PCREDSN').AsFMTBCD:= Self.Pcredsn;
      FDQuery.Params.ParamByName('PDIF').AsFMTBCD:= Self.Pdif;
      FDQuery.Params.ParamByName('PFCP').AsFMTBCD:= Self.Pfcp;
      FDQuery.Params.ParamByName('PFCPST').AsFMTBCD:= Self.Pfcpst;
      FDQuery.Params.ParamByName('PFCPSTRET').AsFMTBCD:= Self.Pfcpstret;
      FDQuery.Params.ParamByName('PFCPUFDEST').AsFMTBCD:= Self.Pfcpufdest;
      FDQuery.Params.ParamByName('PICMSUFDEST').AsFMTBCD:= Self.Picmsufdest;
      FDQuery.Params.ParamByName('PICMSINTER').AsFMTBCD:= Self.Picmsinter;
      FDQuery.Params.ParamByName('PICMSINTERPART').AsFMTBCD:= Self.Picmsinterpart;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
    begin
      Result:= False;
      raise Exception.Create('falha ao atualizar configuração fiscal de icms. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
