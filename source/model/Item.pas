unit Item;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  Unidade, GrupoTributario, Ncm;

type
  TItem = class(TModel)
  private
    FEMPRESA_ID: String;
    FGRUPO_TRIBUTARIO_ID: String;
    FREFERENCIA: Integer;
    FEAN: String;
    FNOME: String;
    FNCM: String;
    FEXTIPI: String;
    FUNIDADE_ID: String;
    FEAN_TRIBUTAVEL: String;
    FUNIDADE_TRIBUTAVEL_ID: String;
    FTIPO_ITEM: String;
    FCODIGO_GENERO: String;
    FCODIGO_SERVICO: String;
    FALIQUOTA_ICMS: Extended;
    FCEST: String;
    FPRECO_COMPRA: Extended;
    FPRECO_VENDA: Extended;
    FESTOQUE_DISPONIVEL: Extended;
    FESTOQUE_MINIMO: Extended;
    FESTOQUE_IDEAL: Extended;
    FESTOQUE_MAXIMO: Extended;

    FGRUPOTRIBUTARIO: TGrupoTributario;
    FUNIDADE: TUnidade;
    FUNIDADE_TRIBUTAVE: TUnidade;
    FOBJNCM: TNcm;

    function getGrupoTributario: TGrupoTributario;
    function getUnidade: TUnidade;
    function getUnidadeTributave: TUnidade;
    function getObjNcm: TNcm;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    function delete(): Boolean;
    function validade(vtype: integer = 0): Boolean;
    function estoque(): Extended;
    class function find(id: string): TItem;
    class function findByReferencia(Referencia: Integer): TItem;
    class function findByEan(Ean: string): TItem;
    class function list(search: string): TObjectList<TItem>; overload;
    class procedure list(search: string; DataSet: TFDMemTable); overload;
    class function remove(id: string): Boolean;
    class function listEstoque(search: string): TObjectList<TItem>; overload;
    class procedure listEstoque(search: string; DataSet: TFDMemTable); overload;
    class procedure imprimirEstoque(pSearch: string);
    class procedure movimento(ItemId: string; sDate, eDate: TDate; DataSet: TFDMemTable);

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property GrupoTributarioId: String  read FGRUPO_TRIBUTARIO_ID write FGRUPO_TRIBUTARIO_ID;
    property Referencia: Integer  read FREFERENCIA write FREFERENCIA;
    property Ean: String  read FEAN write FEAN;
    property Nome: String  read FNOME write FNOME;
    property Ncm: String  read FNCM write FNCM;
    property Extipi: String  read FEXTIPI write FEXTIPI;
    property UnidadeId: String  read FUNIDADE_ID write FUNIDADE_ID;
    property EanTributavel: String  read FEAN_TRIBUTAVEL write FEAN_TRIBUTAVEL;
    property UnidadeTributavelId: String  read FUNIDADE_TRIBUTAVEL_ID write FUNIDADE_TRIBUTAVEL_ID;
    property TipoItem: String  read FTIPO_ITEM write FTIPO_ITEM;
    property CodigoGenero: String  read FCODIGO_GENERO write FCODIGO_GENERO;
    property CodigoServico: String  read FCODIGO_SERVICO write FCODIGO_SERVICO;
    property AliquotaIcms: Extended  read FALIQUOTA_ICMS write FALIQUOTA_ICMS;
    property Cest: String  read FCEST write FCEST;
    property PrecoCompra: Extended  read FPRECO_COMPRA write FPRECO_COMPRA;
    property PrecoVenda: Extended  read FPRECO_VENDA write FPRECO_VENDA;
    property EstoqueDisponivel: Extended  read FESTOQUE_DISPONIVEL write FESTOQUE_DISPONIVEL;
    property EstoqueMinimo: Extended  read FESTOQUE_MINIMO write FESTOQUE_MINIMO;
    property EstoqueIdeal: Extended  read FESTOQUE_IDEAL write FESTOQUE_IDEAL;
    property EstoqueMaximo: Extended  read FESTOQUE_MAXIMO write FESTOQUE_MAXIMO;

    property GrupoTributario: TGrupoTributario read getGrupoTributario;
    property Unidade: TUnidade read getUnidade;
    property UnidadeTributave: TUnidade read getUnidadeTributave;
    property ObjNcm: TNcm read getObjNcm;

  end;

implementation

uses
  AuthService, Helper, uformItemCreateEdit, uformPrint, System.StrUtils,
  Empresa;

{ TItem }

constructor TItem.Create;
begin
  Self.Table:= 'ITENS';
  Self.Referencia:= Self.nextReferencia(0);
end;

function TItem.delete: Boolean;
const
  FSql: string =
  'UPDATE ITENS                     ' +
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
        raise Exception.Create('falha ao remover o item. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

destructor TItem.Destroy;
begin
  if Assigned(Self.FGRUPOTRIBUTARIO) then FreeAndNil(Self.FGRUPOTRIBUTARIO);
  if Assigned(Self.FUNIDADE) then FreeAndNil(Self.FUNIDADE);
  if Assigned(Self.FUNIDADE_TRIBUTAVE) then FreeAndNil(Self.FUNIDADE_TRIBUTAVE);
  if Assigned(Self.FOBJNCM) then FreeAndNil(Self.FOBJNCM);
end;

function TItem.estoque: Extended;
const
  FSql: string =
  'SELECT (                          ' +
  'SUM(IIF(V.TIPO = 1, V.QTDE, 0)) - ' +
  'SUM(IIF(V.TIPO = 0, V.QTDE, 0))   ' +
  ') AS QTDE                         ' +
  'FROM VIEW_ITEM_MOVIMENTO V        ' +
  'WHERE V.EMPRESA_ID = :EMPRESA_ID  ' +
  'AND V.ITEM_ID = :ITEM_ID          ';
var
  FDQuery: TFDQuery;
begin
  if (Self.Id = EmptyStr) then
  begin
    Result:= 0;
    Exit();
  end;

  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('ITEM_ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('ITEM_ID').AsString:= Self.Id;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= Self.EstoqueDisponivel
      else
        Result:= Self.EstoqueDisponivel + FDQuery.FieldByName('QTDE').AsExtended;
    except
      Result:= 0;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TItem.find(id: string): TItem;
const
  FSql: string = 'SELECT * FROM ITENS WHERE (ID = :ID)';
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
        Result:= TItem.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.GrupoTributarioId:= FDQuery.FieldByName('GRUPO_TRIBUTARIO_ID').AsString;
        Result.Referencia:= FDQuery.FieldByName('REFERENCIA').AsInteger;
        Result.Ean:= FDQuery.FieldByName('EAN').AsString;
        Result.Nome:= FDQuery.FieldByName('NOME').AsString;
        Result.Ncm:= FDQuery.FieldByName('NCM').AsString;
        Result.Extipi:= FDQuery.FieldByName('EXTIPI').AsString;
        Result.UnidadeId:= FDQuery.FieldByName('UNIDADE_ID').AsString;
        Result.EanTributavel:= FDQuery.FieldByName('EAN_TRIBUTAVEL').AsString;
        Result.UnidadeTributavelId:= FDQuery.FieldByName('UNIDADE_TRIBUTAVEL_ID').AsString;
        Result.TipoItem:= FDQuery.FieldByName('TIPO_ITEM').AsString;
        Result.CodigoGenero:= FDQuery.FieldByName('CODIGO_GENERO').AsString;
        Result.CodigoServico:= FDQuery.FieldByName('CODIGO_SERVICO').AsString;
        Result.AliquotaIcms:= FDQuery.FieldByName('ALIQUOTA_ICMS').AsExtended;
        Result.Cest:= FDQuery.FieldByName('CEST').AsString;
        Result.PrecoCompra:= FDQuery.FieldByName('PRECO_COMPRA').AsExtended;
        Result.PrecoVenda:= FDQuery.FieldByName('PRECO_VENDA').AsExtended;
        Result.EstoqueDisponivel:= FDQuery.FieldByName('ESTOQUE_DISPONIVEL').AsExtended;
        Result.EstoqueMinimo:= FDQuery.FieldByName('ESTOQUE_MINIMO').AsExtended;
        Result.EstoqueIdeal:= FDQuery.FieldByName('ESTOQUE_IDEAL').AsExtended;
        Result.EstoqueMaximo:= FDQuery.FieldByName('ESTOQUE_MAXIMO').AsExtended;
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

class function TItem.findByReferencia(Referencia: Integer): TItem;
const
  FSql: string =
  'SELECT ID FROM ITENS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (REFERENCIA = :REFERENCIA) ' +
  'AND (DELETED_AT IS NULL)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= Referencia;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Open();

      if FDQuery.RecordCount = 0 then Result:= nil
      else
        Result:= TItem.find(FDQuery.FieldByName('ID').AsString);
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TItem.findByEan(Ean: string): TItem;
const
  FSql: string =
  'SELECT ID FROM ITENS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (EAN = :EAN) ' +
  'AND (DELETED_AT IS NULL)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= TModel.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EAN').DataType:= ftWideString;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EAN').AsString:= Ean;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Open();

      if FDQuery.RecordCount = 0 then Result:= nil
      else
        Result:= TItem.find(FDQuery.FieldByName('ID').AsString);
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TItem.getGrupoTributario: TGrupoTributario;
begin
  if not Assigned(Self.FGRUPOTRIBUTARIO) then
    Self.FGRUPOTRIBUTARIO:= TGrupoTributario.find(Self.GrupoTributarioId)
  else if Self.FGRUPOTRIBUTARIO.Id <> Self.GrupoTributarioId then
  begin
    FreeAndNil(FGRUPOTRIBUTARIO);
    Self.FGRUPOTRIBUTARIO:= TGrupoTributario.find(Self.GrupoTributarioId);
  end;
  Result:= Self.FGRUPOTRIBUTARIO;
end;

function TItem.getObjNcm: TNcm;
begin
  if not Assigned(Self.FOBJNCM) then
    Self.FOBJNCM:= TNcm.find(Self.Ncm)
  else if Self.FOBJNCM.Ncm <> Self.Ncm then
  begin
    FreeAndNil(FOBJNCM);
    Self.FOBJNCM:= TNcm.find(Self.Ncm);
  end;
  Result:= Self.FOBJNCM;
end;

function TItem.getUnidade: TUnidade;
begin
  if not Assigned(Self.FUNIDADE) then
    Self.FUNIDADE:= TUnidade.find(Self.UnidadeId)
  else if Self.FUNIDADE.Id <> Self.UnidadeId then
  begin
    FreeAndNil(FUNIDADE);
    Self.FUNIDADE:= TUnidade.find(Self.UnidadeId);
  end;
  Result:= Self.FUNIDADE;
end;

function TItem.getUnidadeTributave: TUnidade;
begin
  if not Assigned(Self.FUNIDADE_TRIBUTAVE) then
    Self.FUNIDADE_TRIBUTAVE:= TUnidade.find(Self.UnidadeTributavelId)
  else if Self.FUNIDADE_TRIBUTAVE.Id <> Self.UnidadeTributavelId then
  begin
    FreeAndNil(FUNIDADE_TRIBUTAVE);
    Self.FUNIDADE_TRIBUTAVE:= TUnidade.find(Self.UnidadeTributavelId);
  end;
  Result:= Self.FUNIDADE_TRIBUTAVE;
end;

class procedure TItem.imprimirEstoque(pSearch: string);
var
  vEmpresa: TEmpresa;
  Print: TStringList;
  formPrint: TformPrint;
  vItems: TObjectList<TItem>;
  vCount: Integer;
  vTotal,
  vCusto: Extended;
  I: Integer;
begin
  try
    vEmpresa:= nil;
    try
      vEmpresa:= TEmpresa.find(TAuthService.getAuthenticatedEmpresaId);
      if not Assigned(vEmpresa) then
        raise Exception.Create('Falha ao consultar dados da empresa.');

      vItems:= TItem.listEstoque(pSearch);

      if not Assigned(vItems) then
        raise Exception.Create('Nenhum dado foi encontrado.');

      Print:= TStringList.Create;

      Print.Add('H|' +
                THelper.StrEsquerda('INVENTARIO',18) +
                THelper.StrDireita(FormatDateTime('dd/mm/yyyy',Now),70));

      Print.Add('H|' + StringOfChar('-', 88));

      Print.Add('H|' + THelper.StrCentro(vEmpresa.Nome, 88));
      Print.Add('H|' + THelper.StrCentro(vEmpresa.Logradouro + ' ' +
                                         vEmpresa.Numero, 88));
      Print.Add('H|' + THelper.StrCentro(vEmpresa.Cep + ' - ' +
                                         vEmpresa.NomeMunicipio + ' - ' +
                                         vEmpresa.Uf, 88));
      Print.Add('H|' + THelper.StrCentro('CPF/CNPJ:' +
                                         IfThen(vEmpresa.Documento.Length = 14,
                                         THelper.CNPJMask(vEmpresa.Documento),
                                         THelper.CPFMask(vEmpresa.Documento)) +
                                         ' - ' + 'IE: ' + vEmpresa.Ie, 88));
      Print.Add('H|' + THelper.StrCentro('FONE: ' + THelper.FONEMask(vEmpresa.Fone), 88));

      Print.Add('H|' + StringOfChar('-', 88));

      Print.Add('H|' + THelper.StrEsquerda('CODIGO', 6) + ' ' +
                       THelper.StrEsquerda('ITEM', 40) + ' ' +
                       THelper.StrDireita('MEDIDA', 6) + ' ' +
                       THelper.StrDireita('CUSTO', 10) + ' ' +
                       THelper.StrDireita('QTD', 10) + ' ' +
                       THelper.StrDireita('TOTAL', 10));

      Print.Add('H|' + StringOfChar('-', 88));

      vCount:= 0;
      vCusto:= 0;
      for I:= 0 to Pred(vItems.Count) do
      begin
        if not ((vItems.Items[I].estoque > 0) and (vItems.Items[I].PrecoCompra > 0)) then
          Continue;

        Inc(vCount);
        vTotal:= (vItems.Items[I].estoque * vItems.Items[I].PrecoCompra);
        vCusto:= (vCusto + vTotal);

        Print.Add('D|' +
          THelper.StrEsquerda(vItems.Items[I].Referencia.ToString(), 6) + ' ' +
          THelper.StrEsquerda(vItems.Items[I].Nome, 40) + ' ' +
          THelper.StrDireita(vItems.Items[I].Unidade.Unidade, 6) + ' ' +
          THelper.StrDireita(THelper.ExtendedToString(vItems.Items[I].PrecoCompra), 10) + ' ' +
          THelper.StrDireita(THelper.ExtendedToString(vItems.Items[I].estoque), 10) + ' ' +
          THelper.StrDireita(THelper.ExtendedToString(vTotal), 10));
      end;

      Print.Add('F|' + StringOfChar('-', 88));

      Print.Add('F|' + THelper.StrEsquerda('ITENS', 44) +
        THelper.StrDireita(vCount.ToString(), 44));
      Print.Add('F|' + THelper.StrEsquerda('CUSTO (R$)', 44) +
        THelper.StrDireita(THelper.ExtendedToString(vCusto), 44));

      Print.Add('F|' + StringOfChar('-',88));
      Print.Add('F|' + THelper.StrDireita('WWW.WTSYSTEM.COM.BR', 88));
      Print.Add('F|' + THelper.StrDireita('CUIABA - MT (65) 3028-3207 / 99293-3321', 88));

      try
        formPrint:= TformPrint.Create(nil);
        formPrint.Print(Print);
      finally
        FreeAndNil(formPrint);
      end;
    except on e: Exception do
      raise Exception.Create('Falha ao imprimir. Erro: ' + e.Message);
    end;
  finally
    if Assigned(vEmpresa) then FreeAndNil(vEmpresa);
    if Assigned(vItems) then FreeAndNil(vItems);
    if Assigned(Print) then FreeAndNil(Print);
  end;
end;

class function TItem.list(search: string): TObjectList<TItem>;
const
  FSql: string =
  'SELECT FIRST 30 I.ID FROM ITENS I ' +
  'WHERE (I.EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (I.DELETED_AT IS NULL) ' +
  'AND ((I.NOME LIKE :SEARCH) OR (I.REFERENCIA = :REFERENCIA) OR (I.EAN = :EAN))';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('SEARCH').DataType:= ftString;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('EAN').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('SEARCH').AsString:= '%' + search + '%';
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= StrToIntDef(search, 0);
      FDQuery.Params.ParamByName('EAN').AsString:= search;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TItem>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TItem.find(FDQuery.FieldByName('ID').AsString));
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

class procedure TItem.list(search: string; DataSet: TFDMemTable);
var
  vlist: TObjectList<TItem>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  vlist:= TItem.list(search);
  if Assigned(vlist) then
  begin
    for I := 0 to Pred(vlist.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= vlist.Items[I].Id;
      DataSet.FieldByName('REFERENCIA').AsInteger:= vlist.Items[I].Referencia;
      DataSet.FieldByName('EAN').AsString:= vlist.Items[I].Ean;
      DataSet.FieldByName('NOME').AsString:= vlist.Items[I].Nome;
      DataSet.FieldByName('PRECO_VENDA').AsExtended:= vlist.Items[I].PrecoVenda;
      DataSet.FieldByName('ESTOQUE_DISPONIVEL').AsExtended:= vlist.Items[I].estoque;
      DataSet.Post;
    end;
    FreeAndNil(vlist);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TItem.listEstoque(search: string): TObjectList<TItem>;
const
  FSql: string =
  'SELECT I.ID FROM ITENS I ' +
  'WHERE (I.EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (I.DELETED_AT IS NULL) ' +
  'AND (I.NOME LIKE :SEARCH) ORDER BY I.NOME';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('SEARCH').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('SEARCH').AsString:= '%' + search + '%';
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TItem>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TItem.find(FDQuery.FieldByName('ID').AsString));
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

class procedure TItem.listEstoque(search: string; DataSet: TFDMemTable);
var
  v_list: TObjectList<TItem>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  v_list:= TItem.listEstoque(search);
  if Assigned(v_list) then
  begin
    for I := 0 to Pred(v_list.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= v_list.Items[I].Id;
      DataSet.FieldByName('REFERENCIA').AsInteger:= v_list.Items[I].Referencia;
      DataSet.FieldByName('NOME').AsString:= v_list.Items[I].Nome;
      DataSet.FieldByName('UNIDADE').AsString:= v_list.Items[I].Unidade.Unidade;
      DataSet.FieldByName('PRECO_COMPRA').AsExtended:= v_list.Items[I].PrecoCompra;
      DataSet.FieldByName('PRECO_VENDA').AsExtended:= v_list.Items[I].PrecoVenda;
      DataSet.FieldByName('ESTOQUE').AsExtended:= v_list.Items[I].estoque;
      if (DataSet.FieldByName('ESTOQUE').AsExtended > 0) then
      begin
        DataSet.FieldByName('CUSTO_TOTAL').AsExtended:=
          DataSet.FieldByName('ESTOQUE').AsExtended *
            DataSet.FieldByName('PRECO_COMPRA').AsExtended;
      end
      else
        DataSet.FieldByName('CUSTO_TOTAL').AsExtended:= 0;
      DataSet.Post;
    end;
    FreeAndNil(v_list);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class procedure TItem.movimento(ItemId: string; sDate, eDate: TDate;
  DataSet: TFDMemTable);
const
  FSql: string =
  'SELECT ' +
  '    IM.MOVIMENTO, ' +
  '    P.NOME AS PESSOA, ' +
  '    U.NOME AS USUARIO, ' +
  '    I.ESTOQUE_DISPONIVEL + ' +
  '    COALESCE((SELECT SUM(IIF(IM1.TIPO = 1, IM1.QTDE, 0)) - SUM(IIF(IM1.TIPO = 0, IM1.QTDE, 0)) FROM VIEW_ITEM_MOVIMENTO IM1 ' +
  '    WHERE IM1.ITEM_ID = IM.ITEM_ID AND IM1.MOVIMENTO < IM.MOVIMENTO),0) AS ANTERIOR, ' +
  '    IM.QTDE AS MOVIMENTADO, ' +
  '    I.ESTOQUE_DISPONIVEL + ' +
  '    COALESCE((SELECT SUM(IIF(IM1.TIPO = 1, IM1.QTDE, 0)) - SUM(IIF(IM1.TIPO = 0, IM1.QTDE, 0)) FROM VIEW_ITEM_MOVIMENTO IM1 ' +
  '    WHERE IM1.ITEM_ID = IM.ITEM_ID AND IM1.MOVIMENTO < IM.MOVIMENTO),0)  + IIF(IM.TIPO = 1, IM.QTDE,  IM.QTDE * -1)  AS ATUAL, ' +
  '    IM.DESCRICAO, ' +
  '    IM.TIPO ' +
  'FROM VIEW_ITEM_MOVIMENTO IM ' +
  'LEFT JOIN PESSOAS P ON(P.ID = IM.PESSOA_ID) ' +
  'JOIN USERS U ON(U.ID = IM.USER_ID) ' +
  'JOIN ITENS I ON(I.ID = IM.ITEM_ID) ' +
  'WHERE IM.ITEM_ID = :ITEM_ID ' +
  'AND IM.MOVIMENTO BETWEEN :SMOVIMENTO AND :EMOVIMENTO ' +
  'ORDER BY IM.MOVIMENTO DESC ';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ITEM_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('SMOVIMENTO').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('EMOVIMENTO').DataType:= ftDateTime;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ITEM_ID').AsString:= ItemId;
      FDQuery.Params.ParamByName('SMOVIMENTO').AsDateTime:=
        StrToDateTimeDef(DateToStr(sDate) + ' 00:00:00', Now);
      FDQuery.Params.ParamByName('EMOVIMENTO').AsDateTime:=
        StrToDateTimeDef(DateToStr(eDate) + ' 23:59:59', Now);
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Exit()
      else
      begin
        FDQuery.First;

        DataSet.Open();
        DataSet.DisableControls;
        DataSet.EmptyDataSet;
        while not FDQuery.Eof do
        begin
          DataSet.Append;
          DataSet.FieldByName('MOVIMENTO').AsDateTime:=
            FDQuery.FieldByName('MOVIMENTO').AsDateTime;
          DataSet.FieldByName('PESSOA').AsString:=
            FDQuery.FieldByName('PESSOA').AsString;
          DataSet.FieldByName('USUARIO').AsString:=
            FDQuery.FieldByName('USUARIO').AsString;
          DataSet.FieldByName('ANTERIOR').AsExtended:=
            FDQuery.FieldByName('ANTERIOR').AsExtended;
          DataSet.FieldByName('MOVIMENTADO').AsExtended:=
            FDQuery.FieldByName('MOVIMENTADO').AsExtended;
          DataSet.FieldByName('ATUAL').AsExtended:=
            FDQuery.FieldByName('ATUAL').AsExtended;
          DataSet.FieldByName('DESCRICAO').AsString:=
            FDQuery.FieldByName('DESCRICAO').AsString;
          DataSet.FieldByName('TIPO').AsInteger:=
            FDQuery.FieldByName('TIPO').AsInteger;
          DataSet.Post;

          FDQuery.Next;
        end;
        DataSet.First;
        DataSet.EnableControls;
      end;
    except
      Exit();
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TItem.remove(id: string): Boolean;
var
  Item: TItem;
begin
  Result:= False;
  Item:= TItem.find(id);
  if not Assigned(Item) then
  begin
    THelper.Mensagem('Item não encontrado. O item pode ter sido previamente excluído por outro usuário!');
    Exit();
  end;

  try
    if not THelper.Mensagem('Confirmar a exclusão deste item?', 1) then
      Exit();

    Result:= Item.delete();
  finally
    FreeAndNil(Item);
  end;
end;

function TItem.save: Boolean;
begin
  Result:= inherited;
end;

function TItem.store: Boolean;
const
  FSql: string =
  'INSERT INTO ITENS (      ' +
  '  ID,                    ' +
  '  EMPRESA_ID,            ' +
  '  GRUPO_TRIBUTARIO_ID,   ' +
  '  REFERENCIA,            ' +
  '  EAN,                   ' +
  '  NOME,                  ' +
  '  NCM,                   ' +
  '  EXTIPI,                ' +
  '  UNIDADE_ID,            ' +
  '  EAN_TRIBUTAVEL,        ' +
  '  UNIDADE_TRIBUTAVEL_ID, ' +
  '  TIPO_ITEM,             ' +
  '  CODIGO_GENERO,         ' +
  '  CODIGO_SERVICO,        ' +
  '  ALIQUOTA_ICMS,         ' +
  '  CEST,                  ' +
  '  PRECO_COMPRA,          ' +
  '  PRECO_VENDA,           ' +
  '  ESTOQUE_DISPONIVEL,    ' +
  '  ESTOQUE_MINIMO,        ' +
  '  ESTOQUE_IDEAL,         ' +
  '  ESTOQUE_MAXIMO,        ' +
  '  CREATED_AT,            ' +
  '  UPDATED_AT)            ' +
  'VALUES (                 ' +
  '  :ID,                   ' +
  '  :EMPRESA_ID,           ' +
  '  :GRUPO_TRIBUTARIO_ID,  ' +
  '  :REFERENCIA,           ' +
  '  :EAN,                  ' +
  '  :NOME,                 ' +
  '  :NCM,                  ' +
  '  :EXTIPI,               ' +
  '  :UNIDADE_ID,           ' +
  '  :EAN_TRIBUTAVEL,       ' +
  '  :UNIDADE_TRIBUTAVEL_ID,' +
  '  :TIPO_ITEM,            ' +
  '  :CODIGO_GENERO,        ' +
  '  :CODIGO_SERVICO,       ' +
  '  :ALIQUOTA_ICMS,        ' +
  '  :CEST,                 ' +
  '  :PRECO_COMPRA,         ' +
  '  :PRECO_VENDA,          ' +
  '  :ESTOQUE_DISPONIVEL,   ' +
  '  :ESTOQUE_MINIMO,       ' +
  '  :ESTOQUE_IDEAL,        ' +
  '  :ESTOQUE_MAXIMO,       ' +
  '  :CREATED_AT,           ' +
  '  :UPDATED_AT)           ';
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
      FDQuery.Params.ParamByName('GRUPO_TRIBUTARIO_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('EAN').DataType:= ftWideString;
      FDQuery.Params.ParamByName('NOME').DataType:= ftWideString;
      FDQuery.Params.ParamByName('NCM').DataType:= ftWideString;
      FDQuery.Params.ParamByName('EXTIPI').DataType:= ftWideString;
      FDQuery.Params.ParamByName('UNIDADE_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('EAN_TRIBUTAVEL').DataType:= ftWideString;
      FDQuery.Params.ParamByName('UNIDADE_TRIBUTAVEL_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('TIPO_ITEM').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CODIGO_GENERO').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CODIGO_SERVICO').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('ALIQUOTA_ICMS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CEST').DataType:= ftWideString;
      FDQuery.Params.ParamByName('PRECO_COMPRA').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PRECO_VENDA').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('ESTOQUE_DISPONIVEL').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('ESTOQUE_MINIMO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('ESTOQUE_IDEAL').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('ESTOQUE_MAXIMO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;
      Self.Referencia:= Self.nextReferencia(Self.Referencia);

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      if (Self.GrupoTributarioId <> EmptyStr) then
      FDQuery.Params.ParamByName('GRUPO_TRIBUTARIO_ID').AsString:= Self.GrupoTributarioId;
      if (Self.Referencia >= 1) then
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= Self.Referencia;
      if (Self.Ean <> EmptyStr) then
      FDQuery.Params.ParamByName('EAN').AsString:= Self.Ean;
      if (Self.Nome <> EmptyStr) then
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      if (Self.Ncm <> EmptyStr) then
      FDQuery.Params.ParamByName('NCM').AsString:= Self.Ncm;
      if (Self.Extipi <> EmptyStr) then
      FDQuery.Params.ParamByName('EXTIPI').AsString:= Self.Extipi;
      if (Self.UnidadeId <> EmptyStr) then
      FDQuery.Params.ParamByName('UNIDADE_ID').AsString:= Self.UnidadeId;
      if (Self.EanTributavel <> EmptyStr) then
      FDQuery.Params.ParamByName('EAN_TRIBUTAVEL').AsString:= Self.EanTributavel;
      if (Self.UnidadeTributavelId <> EmptyStr) then
      FDQuery.Params.ParamByName('UNIDADE_TRIBUTAVEL_ID').AsString:= Self.UnidadeTributavelId;
      if (Self.TipoItem <> EmptyStr) then
      FDQuery.Params.ParamByName('TIPO_ITEM').AsString:= Self.TipoItem;
      if (Self.CodigoGenero <> EmptyStr) then
      FDQuery.Params.ParamByName('CODIGO_GENERO').AsString:= Self.CodigoGenero;
      if (Self.CodigoServico <> EmptyStr) then
      FDQuery.Params.ParamByName('CODIGO_SERVICO').AsString:= Self.CodigoServico;
      if (Self.AliquotaIcms >= 0) then
      FDQuery.Params.ParamByName('ALIQUOTA_ICMS').AsFMTBCD:= Self.AliquotaIcms;
      if (Self.Cest <> EmptyStr) then
      FDQuery.Params.ParamByName('CEST').AsString:= Self.Cest;
      if (Self.PrecoCompra >= 0) then
      FDQuery.Params.ParamByName('PRECO_COMPRA').AsFMTBCD:= Self.PrecoCompra;
      if (Self.PrecoVenda >= 0) then
      FDQuery.Params.ParamByName('PRECO_VENDA').AsFMTBCD:= Self.PrecoVenda;
      if (Self.EstoqueDisponivel >= 0) then
      FDQuery.Params.ParamByName('ESTOQUE_DISPONIVEL').AsFMTBCD:= Self.EstoqueDisponivel;
      if (Self.EstoqueMinimo >= 0) then
      FDQuery.Params.ParamByName('ESTOQUE_MINIMO').AsFMTBCD:= Self.EstoqueMinimo;
      if (Self.EstoqueIdeal >= 0) then
      FDQuery.Params.ParamByName('ESTOQUE_IDEAL').AsFMTBCD:= Self.EstoqueIdeal;
      if (Self.EstoqueMaximo >= 0) then
      FDQuery.Params.ParamByName('ESTOQUE_MAXIMO').AsFMTBCD:= Self.EstoqueMaximo;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
      Self.Commit;
    except on e: Exception do
    begin
      Self.Rollback;
      Result:= False;
      raise Exception.Create('falha ao inserir item. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TItem.update: Boolean;
const
  FSql: string =
  'UPDATE ITENS                                       ' +
  'SET GRUPO_TRIBUTARIO_ID = :GRUPO_TRIBUTARIO_ID,    ' +
  '    REFERENCIA = :REFERENCIA,                      ' +
  '    EAN = :EAN,                                    ' +
  '    NOME = :NOME,                                  ' +
  '    NCM = :NCM,                                    ' +
  '    EXTIPI = :EXTIPI,                              ' +
  '    UNIDADE_ID = :UNIDADE_ID,                      ' +
  '    EAN_TRIBUTAVEL = :EAN_TRIBUTAVEL,              ' +
  '    UNIDADE_TRIBUTAVEL_ID = :UNIDADE_TRIBUTAVEL_ID,' +
  '    TIPO_ITEM = :TIPO_ITEM,                        ' +
  '    CODIGO_GENERO = :CODIGO_GENERO,                ' +
  '    CODIGO_SERVICO = :CODIGO_SERVICO,              ' +
  '    ALIQUOTA_ICMS = :ALIQUOTA_ICMS,                ' +
  '    CEST = :CEST,                                  ' +
  '    PRECO_COMPRA = :PRECO_COMPRA,                  ' +
  '    PRECO_VENDA = :PRECO_VENDA,                    ' +
  '    ESTOQUE_MINIMO = :ESTOQUE_MINIMO,              ' +
  '    ESTOQUE_IDEAL = :ESTOQUE_IDEAL,                ' +
  '    ESTOQUE_MAXIMO = :ESTOQUE_MAXIMO,              ' +
  '    UPDATED_AT = :UPDATED_AT,                      ' +
  '    SYNCHRONIZED = :SYNCHRONIZED                   ' +
  'WHERE (ID = :ID)                                   ';
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
      FDQuery.Params.ParamByName('GRUPO_TRIBUTARIO_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('EAN').DataType:= ftWideString;
      FDQuery.Params.ParamByName('NOME').DataType:= ftWideString;
      FDQuery.Params.ParamByName('NCM').DataType:= ftWideString;
      FDQuery.Params.ParamByName('EXTIPI').DataType:= ftWideString;
      FDQuery.Params.ParamByName('UNIDADE_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('EAN_TRIBUTAVEL').DataType:= ftWideString;
      FDQuery.Params.ParamByName('UNIDADE_TRIBUTAVEL_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('TIPO_ITEM').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CODIGO_GENERO').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CODIGO_SERVICO').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('ALIQUOTA_ICMS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('CEST').DataType:= ftWideString;
      FDQuery.Params.ParamByName('PRECO_COMPRA').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('PRECO_VENDA').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('ESTOQUE_MINIMO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('ESTOQUE_IDEAL').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('ESTOQUE_MAXIMO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.GrupoTributarioId <> EmptyStr) then
      FDQuery.Params.ParamByName('GRUPO_TRIBUTARIO_ID').AsString:= Self.GrupoTributarioId;
      if (Self.Referencia >= 1) then
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= Self.Referencia;
      if (Self.Ean <> EmptyStr) then
      FDQuery.Params.ParamByName('EAN').AsString:= Self.Ean;
      if (Self.Nome <> EmptyStr) then
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      if (Self.Ncm <> EmptyStr) then
      FDQuery.Params.ParamByName('NCM').AsString:= Self.Ncm;
      if (Self.Extipi <> EmptyStr) then
      FDQuery.Params.ParamByName('EXTIPI').AsString:= Self.Extipi;
      if (Self.UnidadeId <> EmptyStr) then
      FDQuery.Params.ParamByName('UNIDADE_ID').AsString:= Self.UnidadeId;
      if (Self.EanTributavel <> EmptyStr) then
      FDQuery.Params.ParamByName('EAN_TRIBUTAVEL').AsString:= Self.EanTributavel;
      if (Self.UnidadeTributavelId <> EmptyStr) then
      FDQuery.Params.ParamByName('UNIDADE_TRIBUTAVEL_ID').AsString:= Self.UnidadeTributavelId;
      if (Self.TipoItem <> EmptyStr) then
      FDQuery.Params.ParamByName('TIPO_ITEM').AsString:= Self.TipoItem;
      if (Self.CodigoGenero <> EmptyStr) then
      FDQuery.Params.ParamByName('CODIGO_GENERO').AsString:= Self.CodigoGenero;
      if (Self.CodigoServico <> EmptyStr) then
      FDQuery.Params.ParamByName('CODIGO_SERVICO').AsString:= Self.CodigoServico;
      if (Self.AliquotaIcms >= 0) then
      FDQuery.Params.ParamByName('ALIQUOTA_ICMS').AsFMTBCD:= Self.AliquotaIcms;
      if (Self.Cest <> EmptyStr) then
      FDQuery.Params.ParamByName('CEST').AsString:= Self.Cest;
      if (Self.PrecoCompra >= 0) then
      FDQuery.Params.ParamByName('PRECO_COMPRA').AsFMTBCD:= Self.PrecoCompra;
      if (Self.PrecoVenda >= 0) then
      FDQuery.Params.ParamByName('PRECO_VENDA').AsFMTBCD:= Self.PrecoVenda;
      if (Self.EstoqueMinimo >= 0) then
      FDQuery.Params.ParamByName('ESTOQUE_MINIMO').AsFMTBCD:= Self.EstoqueMinimo;
      if (Self.EstoqueIdeal >= 0) then
      FDQuery.Params.ParamByName('ESTOQUE_IDEAL').AsFMTBCD:= Self.EstoqueIdeal;
      if (Self.EstoqueMaximo >= 0) then
      FDQuery.Params.ParamByName('ESTOQUE_MAXIMO').AsFMTBCD:= Self.EstoqueMaximo;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
      Self.Commit;
    except on e: Exception do
    begin
      Self.Rollback;
      Result:= False;
      raise Exception.Create('falha ao atualizar item. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TItem.validade(vtype: integer): Boolean;
var
  v_itemValidate: Integer;
  v_form: TformItemCreateEdit;
  v_title: string;
  v_msg: string;
begin
  Result:= True;
  case vtype of
    0: begin
      try
        v_title:= 'OPSSS!' + #13;

        if (Trim(Self.Nome) <> '')
        and (Trim(Self.Nome).Length <= 2) then
        begin
          v_msg:= 'Nome informado é inválido.';
          Exit();
        end;

        if (Trim(Self.Ean) <> '')
        and (Trim(Self.Ean).Length <= 7) then
        begin
          v_msg:= 'Código de barras informado é inválido.';
          Exit();
        end;

        if (Trim(Self.EanTributavel) <> '')
        and (Trim(Self.EanTributavel).Length <= 7) then
        begin
          v_msg:= 'Código de barras tributável informado é inválido.';
          Exit();
        end;

        if (Trim(Self.Cest) <> '')
        and (Trim(Self.Cest).Length <= 6) then
        begin
          v_msg:= 'CEST informado é inválido.';
          Exit();
        end;
      finally
        if (v_msg <> '') then
        begin
          THelper.Mensagem(v_title + v_msg);
          Result:= False;
        end;
      end;
    end;
    1: begin
      v_itemValidate:= 0;
      if (Self.Referencia <= 0) then Inc(v_itemValidate);
      if (Trim(Self.Nome) = '') then Inc(v_itemValidate);
      if (Trim(Self.UnidadeId) = '') then Inc(v_itemValidate);
      if (Trim(Self.UnidadeTributavelId) = '') then Inc(v_itemValidate);
      if (Trim(Self.TipoItem) = '') then Inc(v_itemValidate);
      if (Trim(Self.Ncm) = '') then Inc(v_itemValidate);
      if (Trim(Self.Cest) = '') then Inc(v_itemValidate);
      if (Trim(Self.GrupoTributarioId) = '') then Inc(v_itemValidate);
      if (Self.PrecoVenda <= 0) then Inc(v_itemValidate);
      if (v_itemValidate >= 1) then
      begin
        try
          TAuthService.ItemId:= Self.Id;
          v_form:= TformItemCreateEdit.Create(nil);
          v_form.Tag:= 1;
          v_form.ShowModal;
        finally
          FreeAndNil(v_form);
        end;
        Result:= (TAuthService.ItemId <> EmptyStr);
      end;
    end;
  end;
end;

end.
