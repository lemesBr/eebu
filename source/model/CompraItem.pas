unit CompraItem;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  Item;

type
  TCompraItem = class(TModel)
  private
    FEMPRESA_ID: String;
    FUSER_ID: String;
    FCOMPRA_ID: String;
    FITEM_ID: String;
    FUNITARIO: Extended;
    FQTDE: Extended;
    FSUBTOTAL: Extended;
    FACRESCIMO: Extended;
    FDESCONTO: Extended;
    FTOTAL: Extended;
    FITEM: TItem;

    function getItem: TItem;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    class function find(id: string): TCompraItem;
    class function findByCompraId(CompraId: string): TObjectList<TCompraItem>;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property UserId: String  read FUSER_ID write FUSER_ID;
    property CompraId: String  read FCOMPRA_ID write FCOMPRA_ID;
    property ItemId: String  read FITEM_ID write FITEM_ID;
    property Unitario: Extended  read FUNITARIO write FUNITARIO;
    property Qtde: Extended  read FQTDE write FQTDE;
    property Subtotal: Extended  read FSUBTOTAL write FSUBTOTAL;
    property Acrescimo: Extended  read FACRESCIMO write FACRESCIMO;
    property Desconto: Extended  read FDESCONTO write FDESCONTO;
    property Total: Extended  read FTOTAL write FTOTAL;

    property Item: TItem  read getItem;

  end;

implementation

uses
  AuthService;

{ TCompraItem }

constructor TCompraItem.Create;
begin
  Self.Table:= 'COMPRA_ITENS';
end;

destructor TCompraItem.Destroy;
begin
  if Assigned(Self.FITEM) then FreeAndNil(Self.FITEM);

  inherited;
end;

class function TCompraItem.find(id: string): TCompraItem;
const
  FSql: string = 'SELECT * FROM COMPRA_ITENS WHERE (ID = :ID)';
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
        Result:= TCompraItem.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.CompraId:= FDQuery.FieldByName('COMPRA_ID').AsString;
        Result.ItemId:= FDQuery.FieldByName('ITEM_ID').AsString;
        Result.UserId:= FDQuery.FieldByName('USER_ID').AsString;
        Result.Unitario:= FDQuery.FieldByName('UNITARIO').AsExtended;
        Result.Qtde:= FDQuery.FieldByName('QTDE').AsExtended;
        Result.Subtotal:= FDQuery.FieldByName('SUBTOTAL').AsExtended;
        Result.Acrescimo:= FDQuery.FieldByName('ACRESCIMO').AsExtended;
        Result.Desconto:= FDQuery.FieldByName('DESCONTO').AsExtended;
        Result.Total:= FDQuery.FieldByName('TOTAL').AsExtended;
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

class function TCompraItem.findByCompraId(
  CompraId: string): TObjectList<TCompraItem>;
const
  FSql: string =
  'SELECT ID FROM COMPRA_ITENS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (COMPRA_ID = :COMPRA_ID) ' +
  'AND (DELETED_AT IS NULL)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('COMPRA_ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('COMPRA_ID').AsString:= CompraId;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TCompraItem>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TCompraItem.find(FDQuery.FieldByName('ID').AsString));
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

function TCompraItem.getItem: TItem;
begin
  if not Assigned(Self.FITEM) then
    Self.FITEM:= TItem.find(Self.FITEM_ID);

  Result:= Self.FITEM;
end;

function TCompraItem.save: Boolean;
begin
  Result:= inherited;
end;

function TCompraItem.store: Boolean;
const
  FSql: string =
  'INSERT INTO COMPRA_ITENS (' +
  '  ID,                    ' +
  '  EMPRESA_ID,            ' +
  '  USER_ID,               ' +
  '  COMPRA_ID,             ' +
  '  ITEM_ID,               ' +
  '  UNITARIO,              ' +
  '  QTDE,                  ' +
  '  SUBTOTAL,              ' +
  '  ACRESCIMO,             ' +
  '  DESCONTO,              ' +
  '  TOTAL,                 ' +
  '  CREATED_AT,            ' +
  '  UPDATED_AT)            ' +
  'VALUES (                 ' +
  '  :ID,                   ' +
  '  :EMPRESA_ID,           ' +
  '  :USER_ID,              ' +
  '  :COMPRA_ID,            ' +
  '  :ITEM_ID,              ' +
  '  :UNITARIO,             ' +
  '  :QTDE,                 ' +
  '  :SUBTOTAL,             ' +
  '  :ACRESCIMO,            ' +
  '  :DESCONTO,             ' +
  '  :TOTAL,                ' +
  '  :CREATED_AT,           ' +
  '  :UPDATED_AT)           ';
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
      FDQuery.Params.ParamByName('USER_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('COMPRA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('ITEM_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('UNITARIO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('QTDE').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('SUBTOTAL').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('ACRESCIMO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('DESCONTO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('TOTAL').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('USER_ID').AsString:= Self.UserId;
      FDQuery.Params.ParamByName('COMPRA_ID').AsString:= Self.CompraId;
      FDQuery.Params.ParamByName('ITEM_ID').AsString:= Self.ItemId;
      FDQuery.Params.ParamByName('UNITARIO').AsFMTBCD:= Self.Unitario;
      FDQuery.Params.ParamByName('QTDE').AsFMTBCD:= Self.Qtde;
      FDQuery.Params.ParamByName('SUBTOTAL').AsFMTBCD:= Self.Subtotal;
      FDQuery.Params.ParamByName('ACRESCIMO').AsFMTBCD:= Self.Acrescimo;
      FDQuery.Params.ParamByName('DESCONTO').AsFMTBCD:= Self.Desconto;
      FDQuery.Params.ParamByName('TOTAL').AsFMTBCD:= Self.Total;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('Item. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TCompraItem.update: Boolean;
const
  FSql: string =
  'UPDATE COMPRA_ITENS                    ' +
  'SET USER_ID = :USER_ID,                ' +
  '    COMPRA_ID = :COMPRA_ID,            ' +
  '    ITEM_ID = :ITEM_ID,                ' +
  '    UNITARIO = :UNITARIO,              ' +
  '    QTDE = :QTDE,                      ' +
  '    SUBTOTAL = :SUBTOTAL,              ' +
  '    ACRESCIMO = :ACRESCIMO,            ' +
  '    DESCONTO = :DESCONTO,              ' +
  '    TOTAL = :TOTAL,                    ' +
  '    UPDATED_AT = :UPDATED_AT,          ' +
  '    SYNCHRONIZED = :SYNCHRONIZED       ' +
  'WHERE (ID = :ID)                       ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('USER_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('COMPRA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('ITEM_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('UNITARIO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('QTDE').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('SUBTOTAL').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('ACRESCIMO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('DESCONTO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('TOTAL').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('USER_ID').AsString:= Self.UserId;
      FDQuery.Params.ParamByName('COMPRA_ID').AsString:= Self.CompraId;
      FDQuery.Params.ParamByName('ITEM_ID').AsString:= Self.ItemId;
      FDQuery.Params.ParamByName('UNITARIO').AsFMTBCD:= Self.Unitario;
      FDQuery.Params.ParamByName('QTDE').AsFMTBCD:= Self.Qtde;
      FDQuery.Params.ParamByName('SUBTOTAL').AsFMTBCD:= Self.Subtotal;
      FDQuery.Params.ParamByName('ACRESCIMO').AsFMTBCD:= Self.Acrescimo;
      FDQuery.Params.ParamByName('DESCONTO').AsFMTBCD:= Self.Desconto;
      FDQuery.Params.ParamByName('TOTAL').AsFMTBCD:= Self.Total;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('Item. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
