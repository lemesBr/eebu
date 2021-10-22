unit VendaItem;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  Item;

type
  TVendaItem = class(TModel)
  private
    FEMPRESA_ID: String;
    FUSER_ID: String;
    FVENDA_ID: String;
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
    function  save(): Boolean;
    function delete(): Boolean;

    class function find(Id: string): TVendaItem;
    class function findByVenda(VendaId: string): TObjectList<TVendaItem>; overload;
    class procedure findByVenda(VendaId: string; pDt: TFDMemTable); overload;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property UserId: String  read FUSER_ID write FUSER_ID;
    property VendaId: String  read FVENDA_ID write FVENDA_ID;
    property ItemId: String  read FITEM_ID write FITEM_ID;
    property Unitario: Extended  read FUNITARIO write FUNITARIO;
    property Qtde: Extended  read FQTDE write FQTDE;
    property Subtotal: Extended  read FSUBTOTAL write FSUBTOTAL;
    property Acrescimo: Extended  read FACRESCIMO write FACRESCIMO;
    property Desconto: Extended  read FDESCONTO write FDESCONTO;
    property Total: Extended  read FTOTAL write FTOTAL;

    property Item: TItem read getItem;
  end;

implementation

uses
  AuthService;

{ TVendaItem }

constructor TVendaItem.Create;
begin
  Self.Table:= 'VENDA_ITENS';
end;

function TVendaItem.delete: Boolean;
const
  FSql: string =
  'UPDATE VENDA_ITENS               ' +
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
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('DELETED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftString;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('DELETED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao remover o item da venda. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

destructor TVendaItem.Destroy;
begin
  if Assigned(Self.FITEM) then FreeAndNil(Self.FITEM);

  inherited;
end;

class function TVendaItem.find(Id: string): TVendaItem;
const
  FSql: string = 'SELECT * FROM VENDA_ITENS WHERE (ID = :ID)';
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
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TVendaItem.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.VendaId:= FDQuery.FieldByName('VENDA_ID').AsString;
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

class procedure TVendaItem.findByVenda(VendaId: string; pDt: TFDMemTable);
var
  vList: TObjectList<TVendaItem>;
  I: Integer;
begin
  pDt.Open();
  pDt.DisableControls();
  pDt.EmptyDataSet();
  vList:= TVendaItem.findByVenda(VendaId);
  if Assigned(vList) then
  begin
    for I:= 0 to Pred(vList.Count) do
    begin
      pDt.Append();
      pDt.FieldByName('ID').AsString:= vList.Items[I].Id;
      pDt.FieldByName('ITEM').AsInteger:= (I + 1);
      pDt.FieldByName('REFERENCIA').AsInteger:= vList.Items[I].Item.Referencia;
      pDt.FieldByName('NOME').AsString:= vList.Items[I].Item.Nome;
      pDt.FieldByName('UNIDADE').AsString:= vList.Items[I].Item.Unidade;
      pDt.FieldByName('UNITARIO').AsExtended:= vList.Items[I].Unitario;
      pDt.FieldByName('QTDE').AsExtended:= vList.Items[I].Qtde;
      pDt.FieldByName('SUBTOTAL').AsExtended:= vList.Items[I].Subtotal;
      pDt.FieldByName('ACRESCIMO').AsExtended:= vList.Items[I].Acrescimo;
      pDt.FieldByName('DESCONTO').AsExtended:= vList.Items[I].Desconto;
      pDt.FieldByName('TOTAL').AsExtended:= vList.Items[I].Total;
      pDt.Post();
    end;
    FreeAndNil(vList);
  end;
  pDt.First();
  pDt.EnableControls();
end;

function TVendaItem.getItem: TItem;
begin
  if not Assigned(Self.FITEM) then
    Self.FITEM:= TItem.find(Self.FITEM_ID);

  Result:= Self.FITEM;
end;

class function TVendaItem.findByVenda(VendaId: string): TObjectList<TVendaItem>;
const
  FSql: string =
  'SELECT ID FROM VENDA_ITENS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (VENDA_ID = :VENDA_ID) ' +
  'AND (DELETED_AT IS NULL) ' +
  'ORDER BY CREATED_AT';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('VENDA_ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Params.ParamByName('VENDA_ID').AsString:= VendaId;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TObjectList<TVendaItem>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TVendaItem.find(FDQuery.FieldByName('ID').AsString));
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

function TVendaItem.save: Boolean;
begin
  Result:= inherited;
end;

function TVendaItem.store: Boolean;
const
  FSql: string =
  'INSERT INTO VENDA_ITENS ( ' +
  '  ID,                     ' +
  '  EMPRESA_ID,             ' +
  '  USER_ID,                ' +
  '  VENDA_ID,               ' +
  '  ITEM_ID,                ' +
  '  UNITARIO,               ' +
  '  QTDE,                   ' +
  '  SUBTOTAL,               ' +
  '  ACRESCIMO,              ' +
  '  DESCONTO,               ' +
  '  TOTAL,                  ' +
  '  CREATED_AT,             ' +
  '  UPDATED_AT)             ' +
  'VALUES (                  ' +
  '  :ID,                    ' +
  '  :EMPRESA_ID,            ' +
  '  :USER_ID,               ' +
  '  :VENDA_ID,              ' +
  '  :ITEM_ID,               ' +
  '  :UNITARIO,              ' +
  '  :QTDE,                  ' +
  '  :SUBTOTAL,              ' +
  '  :ACRESCIMO,             ' +
  '  :DESCONTO,              ' +
  '  :TOTAL,                 ' +
  '  :CREATED_AT,            ' +
  '  :UPDATED_AT)            ';
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
      FDQuery.Params.ParamByName('USER_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('VENDA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('ITEM_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('UNITARIO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('QTDE').DataType:= ftExtended;
      FDQuery.Params.ParamByName('SUBTOTAL').DataType:= ftExtended;
      FDQuery.Params.ParamByName('ACRESCIMO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('DESCONTO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('TOTAL').DataType:= ftExtended;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare();

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.Terminal.EmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('USER_ID').AsString:= Self.UserId;
      FDQuery.Params.ParamByName('VENDA_ID').AsString:= Self.VendaId;
      FDQuery.Params.ParamByName('ITEM_ID').AsString:= Self.ItemId;
      FDQuery.Params.ParamByName('UNITARIO').AsExtended:= Self.Unitario;
      FDQuery.Params.ParamByName('QTDE').AsExtended:= Self.Qtde;
      FDQuery.Params.ParamByName('SUBTOTAL').AsExtended:= Self.Subtotal;
      FDQuery.Params.ParamByName('ACRESCIMO').AsExtended:= Self.Acrescimo;
      FDQuery.Params.ParamByName('DESCONTO').AsExtended:= Self.Desconto;
      FDQuery.Params.ParamByName('TOTAL').AsExtended:= Self.Total;
      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.ExecSQL();
    except on e: exception do
    begin
      Result:= False;
      raise Exception.Create('Falha ao gravar dados do item da venda. Erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TVendaItem.update: Boolean;
const
  FSql: string =
  'UPDATE VENDA_ITENS               ' +
  'SET ACRESCIMO = :ACRESCIMO,      ' +
  '    DESCONTO = :DESCONTO,        ' +
  '    TOTAL = :TOTAL,              ' +
  '    UPDATED_AT = :UPDATED_AT,    ' +
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
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('ACRESCIMO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('DESCONTO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('TOTAL').DataType:= ftExtended;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('ACRESCIMO').AsExtended:= Self.Acrescimo;
      FDQuery.Params.ParamByName('DESCONTO').AsExtended:= Self.Desconto;
      FDQuery.Params.ParamByName('TOTAL').AsExtended:= Self.Total;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL();
    except on e: exception do
    begin
      Result:= False;
      raise Exception.Create('Falha ao gravar dados do item da venda. Erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
