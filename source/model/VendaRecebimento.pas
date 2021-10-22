unit VendaRecebimento;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  System.DateUtils;

type
  TVendaRecebimento = class(TModel)
  private
    FEMPRESA_ID: String;
    FVENDA_ID: String;
    FTPAG: String;
    FRECEBIDO: Extended;
    FTROCO: Extended;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function findByVendaId(VendaId: string): TObjectList<TVendaRecebimento>;
    class function findBylVendaId(lVendaId: string): TObjectList<TVendaRecebimento>;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property VendaId: String  read FVENDA_ID write FVENDA_ID;
    property Tpag: String  read FTPAG write FTPAG;
    property Recebido: Extended  read FRECEBIDO write FRECEBIDO;
    property Troco: Extended  read FTROCO write FTROCO;

  end;

implementation

uses
  AuthService, Recebimento, Venda;

{ TVendaRecebimento }

constructor TVendaRecebimento.Create;
begin
  Self.Table:= 'VENDA_RECEBIMENTOS';
end;

class function TVendaRecebimento.findBylVendaId(
  lVendaId: string): TObjectList<TVendaRecebimento>;
var
  FSql: string;
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FSql:=
      'SELECT                                  ' +
      '    VR.TPAG,                            ' +
      '    SUM(VR.RECEBIDO) AS RECEBIDO,       ' +
      '    SUM(VR.TROCO) AS TROCO              ' +
      'FROM VENDA_RECEBIMENTOS VR              ' +
      'WHERE VR.VENDA_ID IN (' + lvendaId + ') ' +
      'GROUP BY VR.TPAG';

      FDQuery.SQL.Add(FSql);
      FDQuery.Prepare;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TVendaRecebimento>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TVendaRecebimento.Create);
          Result.Last.Tpag:= FDQuery.FieldByName('TPAG').AsString;
          Result.Last.Recebido:= FDQuery.FieldByName('RECEBIDO').AsExtended;
          Result.Last.Troco:= FDQuery.FieldByName('TROCO').AsExtended;
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

class function TVendaRecebimento.findByVendaId(
  VendaId: string): TObjectList<TVendaRecebimento>;
const
  FSql: string =
  'SELECT * FROM VENDA_RECEBIMENTOS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (VENDA_ID = :VENDA_ID) ' +
  'AND (DELETED_AT IS NULL)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('VENDA_ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('VENDA_ID').AsString:= VendaId;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TVendaRecebimento>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TVendaRecebimento.Create);
          Result.Last.Id:= FDQuery.FieldByName('ID').AsString;
          Result.Last.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
          Result.Last.VendaId:= FDQuery.FieldByName('VENDA_ID').AsString;
          Result.Last.Tpag:= FDQuery.FieldByName('TPAG').AsString;
          Result.Last.Recebido:= FDQuery.FieldByName('RECEBIDO').AsExtended;
          Result.Last.Troco:= FDQuery.FieldByName('TROCO').AsExtended;
          Result.Last.CreatedAt:= FDQuery.FieldByName('CREATED_AT').AsDateTime;
          Result.Last.UpdatedAt:= FDQuery.FieldByName('UPDATED_AT').AsDateTime;
          Result.Last.Synchronized:= FDQuery.FieldByName('SYNCHRONIZED').AsString;
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

function TVendaRecebimento.save: Boolean;
begin
  Result:= inherited;
end;

function TVendaRecebimento.store: Boolean;
const
  FSql: string =
  'INSERT INTO VENDA_RECEBIMENTOS (' +
  '  ID,                           ' +
  '  EMPRESA_ID,                   ' +
  '  VENDA_ID,                     ' +
  '  TPAG,                         ' +
  '  RECEBIDO,                     ' +
  '  TROCO,                        ' +
  '  CREATED_AT,                   ' +
  '  UPDATED_AT)                   ' +
  'VALUES (                        ' +
  '  :ID,                          ' +
  '  :EMPRESA_ID,                  ' +
  '  :VENDA_ID,                    ' +
  '  :TPAG,                        ' +
  '  :RECEBIDO,                    ' +
  '  :TROCO,                       ' +
  '  :CREATED_AT,                  ' +
  '  :UPDATED_AT)                  ';
var
  FDQuery: TFDQuery;
  v_venda: TVenda;
  v_recebimento: TRecebimento;
  I: Integer;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('VENDA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('TPAG').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('RECEBIDO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('TROCO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('VENDA_ID').AsString:= Self.VendaId;
      FDQuery.Params.ParamByName('TPAG').AsString:= Self.Tpag;
      FDQuery.Params.ParamByName('RECEBIDO').AsFMTBCD:= Self.Recebido;
      FDQuery.Params.ParamByName('TROCO').AsFMTBCD:= Self.Troco;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;

      v_venda:= TVenda.find(Self.VendaId);

      if Self.Tpag = '01' then
      begin
        v_recebimento:= TRecebimento.Create;
        v_recebimento.ContaId:= TAuthService.getAuthenticatedConfig.VendaContaId;
        v_recebimento.PessoaId:= v_venda.PessoaId;
        v_recebimento.CategoriaId:= TAuthService.getAuthenticatedConfig.VendaCategoriaId;
        v_recebimento.VendaId:= v_venda.Id;
        v_recebimento.Descricao:= 'DINHEIRO - VENDA ' + v_venda.Referencia.ToString();
        v_recebimento.Competencia:= Now;
        v_recebimento.Valor:= (Self.Recebido - Self.Troco);
        v_recebimento.Vencimento:= Now;
        v_recebimento.Recebimento:= Now;
        v_recebimento.Situacao:= 'F';
        v_recebimento.save;
      end
      else if Self.Tpag = '02' then
      begin
        v_recebimento:= TRecebimento.Create;
        v_recebimento.ContaId:= TAuthService.getAuthenticatedConfig.VendaContaId;
        v_recebimento.PessoaId:= v_venda.PessoaId;
        v_recebimento.CategoriaId:= TAuthService.getAuthenticatedConfig.VendaCategoriaId;
        v_recebimento.VendaId:= v_venda.Id;
        v_recebimento.Descricao:= 'CHEQUE - VENDA ' + v_venda.Referencia.ToString();
        v_recebimento.Competencia:= Now;
        v_recebimento.Valor:= (Self.Recebido - Self.Troco);
        v_recebimento.Vencimento:= Now;
        v_recebimento.Recebimento:= Now;
        v_recebimento.Situacao:= 'F';
        v_recebimento.save;
      end
      else if Self.Tpag = '05' then
      begin
        v_recebimento:= TRecebimento.Create;
        v_recebimento.ContaId:= TAuthService.getAuthenticatedConfig.VendaContaId;
        v_recebimento.PessoaId:= v_venda.PessoaId;
        v_recebimento.CategoriaId:= TAuthService.getAuthenticatedConfig.VendaCategoriaId;
        v_recebimento.VendaId:= v_venda.Id;
        v_recebimento.Descricao:= 'CREDITO LOJA - VENDA ' + v_venda.Referencia.ToString();
        v_recebimento.Competencia:= Now;
        v_recebimento.Valor:= (Self.Recebido - Self.Troco);
        v_recebimento.Vencimento:= EndOfTheMonth(now);
        v_recebimento.Situacao:= 'A';
        v_recebimento.save;
      end
      else if Self.Tpag = '14' then
      begin
        for I:= 0 to Pred(TAuthService.lParcelas.Count) do
        begin
          TAuthService.lParcelas.Items[I].ContaId:= TAuthService.getAuthenticatedConfig.VendaContaId;
          TAuthService.lParcelas.Items[I].PessoaId:= v_venda.PessoaId;
          TAuthService.lParcelas.Items[I].CategoriaId:= TAuthService.getAuthenticatedConfig.VendaCategoriaId;
          TAuthService.lParcelas.Items[I].VendaId:= v_venda.Id;
          TAuthService.lParcelas.Items[I].Descricao:= (I + 1).ToString() + '/' + TAuthService.lParcelas.Count.ToString() + ' - VENDA ' + v_venda.Referencia.ToString();
          TAuthService.lParcelas.Items[I].Situacao:= 'A';
          TAuthService.lParcelas.Items[I].save;
        end;
      end
      else if Self.Tpag = '15' then
      begin
        for I:= 0 to Pred(TAuthService.lParcelas.Count) do
        begin
          TAuthService.lParcelas.Items[I].ContaId:= TAuthService.getAuthenticatedConfig.VendaContaId;
          TAuthService.lParcelas.Items[I].PessoaId:= v_venda.PessoaId;
          TAuthService.lParcelas.Items[I].CategoriaId:= TAuthService.getAuthenticatedConfig.VendaCategoriaId;
          TAuthService.lParcelas.Items[I].VendaId:= v_venda.Id;
          TAuthService.lParcelas.Items[I].Descricao:= (I + 1).ToString() + '/' + TAuthService.lParcelas.Count.ToString() + ' - VENDA ' + v_venda.Referencia.ToString();
          TAuthService.lParcelas.Items[I].Situacao:= 'A';
          TAuthService.lParcelas.Items[I].save;
        end;
      end
      else if Self.Tpag = '90' then
      begin
        v_recebimento:= TRecebimento.Create;
        v_recebimento.ContaId:= TAuthService.getAuthenticatedConfig.VendaContaId;
        v_recebimento.PessoaId:= v_venda.PessoaId;
        v_recebimento.CategoriaId:= TAuthService.getAuthenticatedConfig.VendaCategoriaId;
        v_recebimento.VendaId:= v_venda.Id;
        v_recebimento.Descricao:= 'OUTRO - VENDA ' + v_venda.Referencia.ToString();
        v_recebimento.Competencia:= Now;
        v_recebimento.Valor:= (Self.Recebido - Self.Troco);
        v_recebimento.Vencimento:= Now;
        v_recebimento.Recebimento:= Now;
        v_recebimento.Situacao:= 'F';
        v_recebimento.save;
      end;

    except on e: Exception do
      begin
        Result:= False;
        raise Exception.Create('RECEBIMENTO. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
    if Assigned(v_venda) then FreeAndNil(v_venda);
    if Assigned(v_recebimento) then FreeAndNil(v_recebimento);
  end;
end;

function TVendaRecebimento.update: Boolean;
begin
  Result:= True;
end;

end.
