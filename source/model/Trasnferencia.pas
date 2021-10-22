unit Trasnferencia;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TTrasnferencia = class(TModel)
  private
    FID: String;
    FEMPRESA_ID: String;
    FCONTA_ORIGEM_ID: String;
    FCONTA_DESTINO_ID: String;
    FDESCRICAO: String;
    FTOTAL: Extended;
    FCOMPETENCIA: TDateTime;
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
    class function find(id: string): TTrasnferencia;

    property Id: String  read FID write FID;
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property ContaOrigemId: String  read FCONTA_ORIGEM_ID write FCONTA_ORIGEM_ID;
    property ContaDestinoId: String  read FCONTA_DESTINO_ID write FCONTA_DESTINO_ID;
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    property Total: Extended  read FTOTAL write FTOTAL;
    property Competencia: TDateTime  read FCOMPETENCIA write FCOMPETENCIA;
    property CreatedAt: TDateTime  read FCREATED_AT write FCREATED_AT;
    property UpdatedAt: TDateTime  read FUPDATED_AT write FUPDATED_AT;
    property DeletedAt: TDateTime  read FDELETED_AT write FDELETED_AT;
    property Synchronized: String  read FSYNCHRONIZED write FSYNCHRONIZED;

  end;

implementation

uses
  AuthService;

{ TTrasnferencia }

constructor TTrasnferencia.Create;
begin
  Self.Table:= 'TRASNFERENCIAS';
end;

class function TTrasnferencia.find(id: string): TTrasnferencia;
const
  FSql: string = 'SELECT * FROM TRASNFERENCIAS WHERE (ID = :ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= TModel.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('ID').AsString:= id;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TTrasnferencia.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.ContaOrigemId:= FDQuery.FieldByName('CONTA_ORIGEM_ID').AsString;
        Result.ContaDestinoId:= FDQuery.FieldByName('CONTA_DESTINO_ID').AsString;
        Result.Descricao:= FDQuery.FieldByName('DESCRICAO').AsString;
        Result.Total:= FDQuery.FieldByName('TOTAL').AsExtended;
        Result.Competencia:= FDQuery.FieldByName('COMPETENCIA').AsDateTime;
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

function TTrasnferencia.save: Boolean;
begin
  if (self.FID = EmptyStr) then
    Result:= Self.store
  else Result:= Self.update;
end;

function TTrasnferencia.store: Boolean;
const
  FSql: string =
  'INSERT INTO TRASNFERENCIAS (ID,EMPRESA_ID,CONTA_ORIGEM_ID, ' +
  'CONTA_DESTINO_ID,DESCRICAO,TOTAL,COMPETENCIA,CREATED_AT,UPDATED_AT) ' +
  'VALUES (:ID,:EMPRESA_ID,:CONTA_ORIGEM_ID,:CONTA_DESTINO_ID,:DESCRICAO, ' +
  ':TOTAL,:COMPETENCIA,:CREATED_AT,:UPDATED_AT)';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= TModel.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CONTA_ORIGEM_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CONTA_DESTINO_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('DESCRICAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('TOTAL').DataType:= ftFloat;
      FDQuery.Params.ParamByName('COMPETENCIA').DataType:= ftDate;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('CONTA_ORIGEM_ID').AsString:= Self.ContaOrigemId;
      FDQuery.Params.ParamByName('CONTA_DESTINO_ID').AsString:= Self.ContaDestinoId;
      FDQuery.Params.ParamByName('DESCRICAO').AsString:= Self.Descricao;
      FDQuery.Params.ParamByName('TOTAL').AsExtended:= Self.Total;
      FDQuery.Params.ParamByName('COMPETENCIA').AsDate:= Self.Competencia;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except
      Result:= False;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TTrasnferencia.update: Boolean;
const
  FSql: string =
  'UPDATE TRASNFERENCIAS SET CONTA_ORIGEM_ID = :CONTA_ORIGEM_ID, ' +
  'CONTA_DESTINO_ID = :CONTA_DESTINO_ID, DESCRICAO = :DESCRICAO, ' +
  'TOTAL = :TOTAL, COMPETENCIA = :COMPETENCIA, UPDATED_AT = :UPDATED_AT, ' +
  'SYNCHRONIZED = :SYNCHRONIZED WHERE (ID = :ID)';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= TModel.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CONTA_ORIGEM_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CONTA_DESTINO_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('DESCRICAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('TOTAL').DataType:= ftFloat;
      FDQuery.Params.ParamByName('COMPETENCIA').DataType:= ftDate;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('CONTA_ORIGEM_ID').AsString:= Self.ContaOrigemId;
      FDQuery.Params.ParamByName('CONTA_DESTINO_ID').AsString:= Self.ContaDestinoId;
      FDQuery.Params.ParamByName('DESCRICAO').AsString:= Self.Descricao;
      FDQuery.Params.ParamByName('TOTAL').AsExtended:= Self.Total;
      FDQuery.Params.ParamByName('COMPETENCIA').AsDate:= Self.Competencia;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except
      Result:= False;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
