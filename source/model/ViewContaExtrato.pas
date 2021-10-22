unit ViewContaExtrato;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  Pessoa, Categoria;

type
  TViewContaExtrato = class(TModel)
  private
    FEMPRESA_ID: String;
    FCONTA_ID: String;
    FPESSOA_ID: String;
    FCATEGORIA_ID: String;
    FDESCRICAO: String;
    FVALOR: Extended;
    FDATA: TDateTime;
    FTIPO: String;
    FCATEGORIA: TCategoria;
    FPESSOA: TPessoa;

    function getCategoria: TCategoria;
    function getPessoa: TPessoa;

  public
    destructor Destroy; override;

    class function listExtrato(ContaId: string; DtInicial, DtFinal: TDate): TObjectList<TViewContaExtrato>; overload;
    class procedure listExtrato(ContaId: string; DtInicial, DtFinal: TDate; DataSet: TFDMemTable); overload;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property ContaId: String  read FCONTA_ID write FCONTA_ID;
    property PessoaId: String  read FPESSOA_ID write FPESSOA_ID;
    property CategoriaId: String  read FCATEGORIA_ID write FCATEGORIA_ID;
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    property Valor: Extended  read FVALOR write FVALOR;
    property Data: TDateTime  read FDATA write FDATA;
    property Tipo: String  read FTIPO write FTIPO;

    property Pessoa: TPessoa read getPessoa;
    property Categoria: TCategoria read getCategoria;

  end;

implementation

uses
  AuthService;

{ TViewContaExtrato }

destructor TViewContaExtrato.Destroy;
begin
  if Assigned(FPESSOA) then FreeAndNil(FPESSOA);
  if Assigned(FCATEGORIA) then FreeAndNil(FCATEGORIA);

  inherited;
end;

function TViewContaExtrato.getCategoria: TCategoria;
begin
  if not Assigned(Self.FCATEGORIA) then
    Self.FCATEGORIA:= TCategoria.find(Self.CategoriaId);

  Result:= Self.FCATEGORIA;
end;

function TViewContaExtrato.getPessoa: TPessoa;
begin
  if not Assigned(Self.FPESSOA) then
    Self.FPESSOA:= TPessoa.find(Self.PessoaId);

  Result:= Self.FPESSOA;
end;

class procedure TViewContaExtrato.listExtrato(ContaId: string; DtInicial,
  DtFinal: TDate; DataSet: TFDMemTable);
var
  vList: TObjectList<TViewContaExtrato>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  vList:= TViewContaExtrato.listExtrato(ContaId, DtInicial, DtFinal);
  if Assigned(vList) then
  begin
    for I:= 0 to Pred(vList.Count) do
    begin
      DataSet.Append();
      DataSet.FieldByName('ID').AsString:= vList.Items[I].Id;
      DataSet.FieldByName('DATA').AsDateTime:= vList.Items[I].Data;
      if Assigned(vList.Items[I].Categoria) then
        DataSet.FieldByName('CATEGORIA').AsString:= vList.Items[I].Categoria.Nome;
      if Assigned(vList.Items[I].Pessoa) then
        DataSet.FieldByName('PESSOA').AsString:= vList.Items[I].Pessoa.Nome;
      DataSet.FieldByName('REFERENTE').AsString:= vList.Items[I].Descricao;
      DataSet.FieldByName('VALOR').AsExtended:= vList.Items[I].Valor;
      DataSet.FieldByName('TIPO').AsString:= vList.Items[I].Tipo;
      DataSet.Post();
    end;
    FreeAndNil(vList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TViewContaExtrato.listExtrato(ContaId: string; DtInicial,
  DtFinal: TDate): TObjectList<TViewContaExtrato>;
const
  FSql: string =
  'SELECT X.* FROM VIEW_CONTA_EXTRATO X     ' +
  'WHERE (X.EMPRESA_ID = :EMPRESA_ID)       ' +
  'AND (X.DATA BETWEEN :INICIAL AND :FINAL) ' +
  'AND (X.CONTA_ID = :CONTA_ID)             ' +
  'ORDER BY X.DATA                          ';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('INICIAL').DataType:= ftDate;
      FDQuery.Params.ParamByName('FINAL').DataType:= ftDate;
      FDQuery.Params.ParamByName('CONTA_ID').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('INICIAL').AsDate:= DtInicial;
      FDQuery.Params.ParamByName('FINAL').AsDate:= DtFinal;
      FDQuery.Params.ParamByName('CONTA_ID').AsString:= ContaId;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TViewContaExtrato>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TViewContaExtrato.Create);
          Result.Last.Id:= FDQuery.FieldByName('ID').AsString;
          Result.Last.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
          Result.Last.ContaId:= FDQuery.FieldByName('CONTA_ID').AsString;
          Result.Last.PessoaId:= FDQuery.FieldByName('PESSOA_ID').AsString;
          Result.Last.CategoriaId:= FDQuery.FieldByName('CATEGORIA_ID').AsString;
          Result.Last.Descricao:= FDQuery.FieldByName('DESCRICAO').AsString;
          Result.Last.Valor:= FDQuery.FieldByName('VALOR').AsExtended;
          Result.Last.Data:= FDQuery.FieldByName('DATA').AsDateTime;
          Result.Last.Tipo:= FDQuery.FieldByName('TIPO').AsString;
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

end.
