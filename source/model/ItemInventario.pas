unit ItemInventario;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  Item;

type
  TItemInventario = class(TModel)
  private
    FEMPRESA_ID: String;
    FUSER_ID: String;
    FITEM_ID: String;
    FUNIDADE_ID: String;
    FCOMPETENCIA: TDateTime;
    FPRECO_COMPRA: Extended;
    FESTOQUE_ATUAL: Extended;
    FESTOQUE_INFORMADO: Extended;
    FDIFERENCA: Extended;
    FTIPO: Integer;
    FITEM: TItem;

    function getItem: TItem;
  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property UserId: String  read FUSER_ID write FUSER_ID;
    property ItemId: String  read FITEM_ID write FITEM_ID;
    property UnidadeId: String  read FUNIDADE_ID write FUNIDADE_ID;
    property Competencia: TDateTime  read FCOMPETENCIA write FCOMPETENCIA;
    property PrecoCompra: Extended  read FPRECO_COMPRA write FPRECO_COMPRA;
    property EstoqueAtual: Extended  read FESTOQUE_ATUAL write FESTOQUE_ATUAL;
    property EstoqueInformado: Extended  read FESTOQUE_INFORMADO write FESTOQUE_INFORMADO;
    property Diferenca: Extended  read FDIFERENCA write FDIFERENCA;
    property Tipo: Integer  read FTIPO write FTIPO;

    property Item: TItem  read getItem;

  end;

implementation

uses
  AuthService;

{ TItemInventario }

constructor TItemInventario.Create;
begin
  Self.Table:= 'ITEM_INVENTARIOS';
end;

destructor TItemInventario.Destroy;
begin
  if Assigned(Self.FITEM) then FreeAndNil(Self.FITEM);

  inherited;
end;

function TItemInventario.getItem: TItem;
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

function TItemInventario.save: Boolean;
begin
  Result:= inherited;
end;

function TItemInventario.store: Boolean;
const
  FSql: string =
  'INSERT INTO ITEM_INVENTARIOS ( ' +
  '  ID,                          ' +
  '  EMPRESA_ID,                  ' +
  '  USER_ID,                     ' +
  '  ITEM_ID,                     ' +
  '  UNIDADE_ID,                  ' +
  '  COMPETENCIA,                 ' +
  '  PRECO_COMPRA,                ' +
  '  ESTOQUE_ATUAL,               ' +
  '  ESTOQUE_INFORMADO,           ' +
  '  DIFERENCA,                   ' +
  '  TIPO,                        ' +
  '  CREATED_AT,                  ' +
  '  UPDATED_AT)                  ' +
  'VALUES (                       ' +
  '  :ID,                         ' +
  '  :EMPRESA_ID,                 ' +
  '  :USER_ID,                    ' +
  '  :ITEM_ID,                    ' +
  '  :UNIDADE_ID,                 ' +
  '  :COMPETENCIA,                ' +
  '  :PRECO_COMPRA,               ' +
  '  :ESTOQUE_ATUAL,              ' +
  '  :ESTOQUE_INFORMADO,          ' +
  '  :DIFERENCA,                  ' +
  '  :TIPO,                       ' +
  '  :CREATED_AT,                 ' +
  '  :UPDATED_AT)                 ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    Self.StartTransaction;
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('USER_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('ITEM_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('UNIDADE_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('COMPETENCIA').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('PRECO_COMPRA').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('ESTOQUE_ATUAL').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('ESTOQUE_INFORMADO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('DIFERENCA').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('TIPO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('USER_ID').AsString:= Self.UserId;
      FDQuery.Params.ParamByName('ITEM_ID').AsString:= Self.ItemId;
      FDQuery.Params.ParamByName('UNIDADE_ID').AsString:= Self.UnidadeId;
      FDQuery.Params.ParamByName('COMPETENCIA').AsDateTime:= Self.Competencia;
      FDQuery.Params.ParamByName('PRECO_COMPRA').AsFMTBCD:= Self.PrecoCompra;
      FDQuery.Params.ParamByName('ESTOQUE_ATUAL').AsFMTBCD:= Self.EstoqueAtual;
      FDQuery.Params.ParamByName('ESTOQUE_INFORMADO').AsFMTBCD:= Self.EstoqueInformado;
      FDQuery.Params.ParamByName('DIFERENCA').AsFMTBCD:= Self.Diferenca;
      FDQuery.Params.ParamByName('TIPO').AsInteger:= Self.Tipo;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;

      Self.Item.UnidadeId:= Self.UnidadeId;
      Self.Item.PrecoCompra:= Self.PrecoCompra;
      Self.Item.save();

      Self.Commit;
    except on e: Exception do
      begin
        Self.Rollback;
        Result:= False;
        raise Exception.Create('Falha ao inserir item. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TItemInventario.update: Boolean;
begin
  Result:= True;
end;

end.
