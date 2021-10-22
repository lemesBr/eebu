unit Cartao;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TCartao = class(TModel)
  private
    FEMPRESA_ID: String;
    FNOME: String;
    FMODALIDADE: String;
    FCOMPENSA_CREDITO: Integer;
    FTAXA_CREDITO: Extended;
    FCOMPENSA_DEBITO: Integer;
    FTAXA_DEBITO: Extended;

  public 
    constructor Create();
    function save(): Boolean;

    class function find(id: string): TCartao;
    class function listByModalidade(Modalidade: string): TObjectList<TCartao>; overload;
    class procedure listByModalidade(Modalidade: string; DataSet: TFDMemTable); overload;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property Nome: String  read FNOME write FNOME;
    property Modalidade: String  read FMODALIDADE write FMODALIDADE;
    property CompensaCredito: Integer  read FCOMPENSA_CREDITO write FCOMPENSA_CREDITO;
    property TaxaCredito: Extended  read FTAXA_CREDITO write FTAXA_CREDITO;
    property CompensaDebito: Integer  read FCOMPENSA_DEBITO write FCOMPENSA_DEBITO;
    property TaxaDebito: Extended  read FTAXA_DEBITO write FTAXA_DEBITO;

  end;

implementation

uses
  AuthService;

{ TCartao }

constructor TCartao.Create;
begin
  Self.Table:= 'CARTOES';
end;

class function TCartao.find(id: string): TCartao;
const
  FSql: string = 'SELECT * FROM CARTOES WHERE (ID = :ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ID').AsString:= id;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TCartao.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.Nome:= FDQuery.FieldByName('NOME').AsString;
        Result.Modalidade:= FDQuery.FieldByName('MODALIDADE').AsString;
        Result.CompensaCredito:= FDQuery.FieldByName('COMPENSA_CREDITO').AsInteger;
        Result.TaxaCredito:= FDQuery.FieldByName('TAXA_CREDITO').AsExtended;
        Result.CompensaDebito:= FDQuery.FieldByName('COMPENSA_DEBITO').AsInteger;
        Result.TaxaDebito:= FDQuery.FieldByName('TAXA_DEBITO').AsExtended;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TCartao.listByModalidade(
  Modalidade: string): TObjectList<TCartao>;
const
  FSql: string =
  'SELECT ID FROM CARTOES ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND ((MODALIDADE = :MODALIDADE) OR ((MODALIDADE = ''X'') AND (:MODALIDADE IN(''C'',''D''))))';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('MODALIDADE').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Params.ParamByName('MODALIDADE').AsString:= Modalidade;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TCartao>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TCartao.find(FDQuery.FieldByName('ID').AsString));
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

class procedure TCartao.listByModalidade(Modalidade: string;
  DataSet: TFDMemTable);
var
  vList: TObjectList<TCartao>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  vList:= TCartao.listByModalidade(Modalidade);
  if Assigned(vList) then
  begin
    for I:= 0 to Pred(vList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= vList.Items[I].Id;
      DataSet.FieldByName('NOME').AsString:= vList.Items[I].Nome;
      DataSet.Post;
    end;
    FreeAndNil(vList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

function TCartao.save: Boolean;
const
  FSql: string =
  'UPDATE OR INSERT INTO CARTOES ( ' +
  '  ID,                           ' +
  '  EMPRESA_ID,                   ' +
  '  NOME,                         ' +
  '  MODALIDADE,                   ' +
  '  COMPENSA_CREDITO,             ' +
  '  TAXA_CREDITO,                 ' +
  '  COMPENSA_DEBITO,              ' +
  '  TAXA_DEBITO)                  ' +
  'VALUES (                        ' +
  '  :ID,                          ' +
  '  :EMPRESA_ID,                  ' +
  '  :NOME,                        ' +
  '  :MODALIDADE,                  ' +
  '  :COMPENSA_CREDITO,            ' +
  '  :TAXA_CREDITO,                ' +
  '  :COMPENSA_DEBITO,             ' +
  '  :TAXA_DEBITO) MATCHING (ID)   ';
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
      FDQuery.Params.ParamByName('NOME').DataType:= ftString;
      FDQuery.Params.ParamByName('MODALIDADE').DataType:= ftString;
      FDQuery.Params.ParamByName('COMPENSA_CREDITO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('TAXA_CREDITO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('COMPENSA_DEBITO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('TAXA_DEBITO').DataType:= ftExtended;
      FDQuery.Prepare();

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      FDQuery.Params.ParamByName('MODALIDADE').AsString:= Self.Modalidade;
      FDQuery.Params.ParamByName('COMPENSA_CREDITO').AsInteger:= Self.CompensaCredito;
      FDQuery.Params.ParamByName('TAXA_CREDITO').AsExtended:= Self.TaxaCredito;
      FDQuery.Params.ParamByName('COMPENSA_DEBITO').AsInteger:= Self.CompensaDebito;
      FDQuery.Params.ParamByName('TAXA_DEBITO').AsExtended:= Self.TaxaDebito;
      FDQuery.ExecSQL();
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao gravar dados do cartão. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
