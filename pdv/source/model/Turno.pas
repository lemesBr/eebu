unit Turno;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TTurno = class(TModel)
  private
    FEMPRESA_ID: String;
    FREFERENCIA: Integer;
    FNOME: String;
    FINICIO: String;
    FFIM: String;

  public 
    constructor Create();
    function save(): Boolean;

    class function find(Id: string): TTurno;
    class function all(): TObjectList<TTurno>;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property Referencia: Integer  read FREFERENCIA write FREFERENCIA;
    property Nome: String  read FNOME write FNOME;
    property Inicio: String  read FINICIO write FINICIO;
    property Fim: String  read FFIM write FFIM;

  end;

implementation

uses
  AuthService;

{ TTurno }

class function TTurno.all: TObjectList<TTurno>;
const
  FSql: string =
  'SELECT ID FROM TURNOS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TObjectList<TTurno>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TTurno.find(FDQuery.FieldByName('ID').AsString));
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

constructor TTurno.Create;
begin
  Self.Table:= 'TURNOS';
end;

class function TTurno.find(Id: string): TTurno;
const
  FSql: string = 'SELECT * FROM TURNOS WHERE (ID = :ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('ID').AsString:= Id;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TTurno.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.Referencia:= FDQuery.FieldByName('REFERENCIA').AsInteger;
        Result.Nome:= FDQuery.FieldByName('NOME').AsString;
        Result.Inicio:= FDQuery.FieldByName('INICIO').AsString;
        Result.Fim:= FDQuery.FieldByName('FIM').AsString;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TTurno.save: Boolean;
const
  FSql: string =
  'UPDATE OR INSERT INTO TURNOS ( ' +
  '  ID,                          ' +
  '  EMPRESA_ID,                  ' +
  '  REFERENCIA,                  ' +
  '  NOME,                        ' +
  '  INICIO,                      ' +
  '  FIM)                         ' +
  'VALUES (                       ' +
  '  :ID,                         ' +
  '  :EMPRESA_ID,                 ' +
  '  :REFERENCIA,                 ' +
  '  :NOME,                       ' +
  '  :INICIO,                     ' +
  '  :FIM) MATCHING (ID)          ';
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
      FDQuery.Params.ParamByName('NOME').DataType:= ftString;
      FDQuery.Params.ParamByName('INICIO').DataType:= ftString;
      FDQuery.Params.ParamByName('FIM').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= Self.Referencia;
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      FDQuery.Params.ParamByName('INICIO').AsString:= Self.Inicio;
      FDQuery.Params.ParamByName('FIM').AsString:= Self.Fim;
      FDQuery.ExecSQL();
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao gravar dados do turno. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
