unit UnidadeConversao;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  Item;

type
  TUnidadeConversao = class(TModel)
  private
    FEMPRESA_ID: String;
    FITEM_ID: String;
    FUNIDADE: String;
    FFATOR_CONVERSAO: Extended;
    FITEM: TItem;

    function getItem: TItem;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    class function find(id: string): TUnidadeConversao;
    class function findByItemId(ItemId: string): TObjectList<TUnidadeConversao>; overload;
    class procedure findByItemId(ItemId: string; vDs: TFDMemTable); overload;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property ItemId: String  read FITEM_ID write FITEM_ID;
    property Unidade: String  read FUNIDADE write FUNIDADE;
    property FatorConversao: Extended  read FFATOR_CONVERSAO write FFATOR_CONVERSAO;

    property Item: TItem read getItem;

  end;

implementation

uses
  AuthService, Helper;

{ TUnidadeConversao }

constructor TUnidadeConversao.Create;
begin
  Self.Table:= 'UNIDADE_CONVERSOES';
end;

destructor TUnidadeConversao.Destroy;
begin
  if Assigned(Self.FITEM) then FreeAndNil(Self.FITEM);

  inherited;
end;

class function TUnidadeConversao.find(id: string): TUnidadeConversao;
const
  FSql: string = 'SELECT * FROM UNIDADE_CONVERSOES WHERE (ID = :ID)';
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
        Result:= TUnidadeConversao.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.ItemId:= FDQuery.FieldByName('ITEM_ID').AsString;
        Result.Unidade:= FDQuery.FieldByName('UNIDADE').AsString;
        Result.FatorConversao:= FDQuery.FieldByName('FATOR_CONVERSAO').AsExtended;
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

class procedure TUnidadeConversao.findByItemId(ItemId: string;
  vDs: TFDMemTable);
var
  vList: TObjectList<TUnidadeConversao>;
  I: Integer;
begin
  vDs.Open();
  vDs.DisableControls;
  vDs.EmptyDataSet;
  vList:= TUnidadeConversao.findByItemId(ItemId);
  if Assigned(vList) then
  begin
    for I:= 0 to Pred(vList.Count) do
    begin
      vDs.Append;
      vDs.FieldByName('ID').AsString:= vList.Items[I].Id;
      vDs.FieldByName('DESCRICAO').AsString:= '1 ' + vList.Items[I].Unidade +
        ' -> ' + THelper.ExtendedToString(vList.Items[I].FatorConversao, False) +
        ' ' + vList.Items[I].Item.Unidade.Unidade;
      vDs.Post;
    end;
    FreeAndNil(vList);
  end;
  vDs.First;
  vDs.EnableControls;
end;

function TUnidadeConversao.getItem: TItem;
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

class function TUnidadeConversao.findByItemId(
  ItemId: string): TObjectList<TUnidadeConversao>;
const
  FSql: string = 'SELECT * FROM UNIDADE_CONVERSOES WHERE (ITEM_ID = :ITEM_ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ITEM_ID').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ITEM_ID').AsString:= ItemId;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TUnidadeConversao>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TUnidadeConversao.Create);
          Result.Last.Id:= FDQuery.FieldByName('ID').AsString;
          Result.Last.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
          Result.Last.ItemId:= FDQuery.FieldByName('ITEM_ID').AsString;
          Result.Last.Unidade:= FDQuery.FieldByName('UNIDADE').AsString;
          Result.Last.FatorConversao:= FDQuery.FieldByName('FATOR_CONVERSAO').AsExtended;
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

function TUnidadeConversao.save: Boolean;
begin
  Result:= inherited;
end;

function TUnidadeConversao.store: Boolean;
const
  FSql: string =
  'INSERT INTO UNIDADE_CONVERSOES (' +
  '  ID,                           ' +
  '  EMPRESA_ID,                   ' +
  '  ITEM_ID,                      ' +
  '  UNIDADE,                      ' +
  '  FATOR_CONVERSAO,              ' +
  '  CREATED_AT,                   ' +
  '  UPDATED_AT)                   ' +
  'VALUES (                        ' +
  '  :ID,                          ' +
  '  :EMPRESA_ID,                  ' +
  '  :ITEM_ID,                     ' +
  '  :UNIDADE,                     ' +
  '  :FATOR_CONVERSAO,             ' +
  '  :CREATED_AT,                  ' +
  '  :UPDATED_AT)                  ';
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
      FDQuery.Params.ParamByName('ITEM_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('UNIDADE').DataType:= ftString;
      FDQuery.Params.ParamByName('FATOR_CONVERSAO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('ITEM_ID').AsString:= Self.ItemId;
      FDQuery.Params.ParamByName('UNIDADE').AsString:= Self.Unidade;
      FDQuery.Params.ParamByName('FATOR_CONVERSAO').AsExtended:= Self.FatorConversao;
      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao inserir conversor de unidade. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TUnidadeConversao.update: Boolean;
const
  FSql: string =
  'UPDATE UNIDADE_CONVERSOES              ' +
  'SET UNIDADE = :UNIDADE,                ' +
  '    FATOR_CONVERSAO = :FATOR_CONVERSAO,' +
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
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('UNIDADE').DataType:= ftString;
      FDQuery.Params.ParamByName('FATOR_CONVERSAO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftString;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('UNIDADE').AsString:= Self.Unidade;
      FDQuery.Params.ParamByName('FATOR_CONVERSAO').AsExtended:= Self.FatorConversao;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao atualizar conversor de unidade. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
