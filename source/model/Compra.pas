unit Compra;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  Pessoa, User, CompraItem, Pagamento, System.StrUtils, ACBrUtil;

type
  TCompra = class(TModel)
  private
    FEMPRESA_ID: String;
    FPESSOA_ID: String;
    FUSER_ID: String;
    FNFE_ID: String;
    FREFERENCIA: Integer;
    FCOMPETENCIA: TDateTime;
    FSUBTOTAL: Extended;
    FACRESCIMO: Extended;
    FDESCONTO: Extended;
    FTOTAL: Extended;
    FSITUACAO: String;

    FPESSOA: TPessoa;
    FUSER: TUser;
    FITENS: TObjectList<TCompraItem>;
    FPAGAMENTOS: TObjectList<TPagamento>;

    function getPessoa: TPessoa;
    function getUser: TUser;
    function getItens: TObjectList<TCompraItem>;
    function getPagamentos: TObjectList<TPagamento>;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    function delete(): Boolean;
    class function find(id: string): TCompra;
    class function list(pSituacao: Integer;
                        pDtInicial,
                        pDtFinal: TDate;
                        pPessoaId,
                        pUserId,
                        pSearch: string): TObjectList<TCompra>; overload;
    class procedure list(pSituacao: Integer;
                         pDtInicial,
                         pDtFinal: TDate;
                         pPessoaId,
                         pUserId,
                         pSearch: string; pDt: TFDMemTable); overload;
    class function remove(id: string): Boolean;
    class procedure listItens(id: string; DataSet: TFDMemTable);
    class procedure imprimir(Id: string); overload;
    class procedure imprimir(pSituacao: Integer;
                             pDtInicial,
                             pDtFinal: TDate;
                             pPessoaId,
                             pUserId,
                             pSearch: string); overload;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property PessoaId: String  read FPESSOA_ID write FPESSOA_ID;
    property UserId: String  read FUSER_ID write FUSER_ID;
    property NfeId: String  read FNFE_ID write FNFE_ID;
    property Referencia: Integer  read FREFERENCIA write FREFERENCIA;
    property Competencia: TDateTime  read FCOMPETENCIA write FCOMPETENCIA;
    property Subtotal: Extended  read FSUBTOTAL write FSUBTOTAL;
    property Acrescimo: Extended  read FACRESCIMO write FACRESCIMO;
    property Desconto: Extended  read FDESCONTO write FDESCONTO;
    property Total: Extended  read FTOTAL write FTOTAL;
    property Situacao: String  read FSITUACAO write FSITUACAO;

    property Pessoa: TPessoa read getPessoa;
    property User: TUser read getUser;
    property Itens: TObjectList<TCompraItem> read getItens;
    property Pagamentos: TObjectList<TPagamento> read getPagamentos;

  end;

implementation

uses
  AuthService, Helper, Empresa, uformPrint;

{ TCompra }

constructor TCompra.Create;
begin
  Self.Table:= 'COMPRAS';
end;

function TCompra.delete: Boolean;
const
  FSql: string =
  'UPDATE COMPRAS                   ' +
  'SET UPDATED_AT = :UPDATED_AT,    ' +
  '    DELETED_AT = :DELETED_AT,    ' +
  '    SYNCHRONIZED = :SYNCHRONIZED ' +
  'WHERE (ID = :ID)                 ';

  FITEMSql: string =
  'UPDATE COMPRA_ITENS              ' +
  'SET UPDATED_AT = :UPDATED_AT,    ' +
  '    DELETED_AT = :DELETED_AT,    ' +
  '    SYNCHRONIZED = :SYNCHRONIZED ' +
  'WHERE (COMPRA_ID = :COMPRA_ID)   ';

  FPAGAMENTOSql: string =
  'UPDATE PAGAMENTOS                ' +
  'SET UPDATED_AT = :UPDATED_AT,    ' +
  '    DELETED_AT = :DELETED_AT,    ' +
  '    SYNCHRONIZED = :SYNCHRONIZED ' +
  'WHERE (COMPRA_ID = :COMPRA_ID)   ';
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
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('DELETED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('DELETED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;

      FDQuery.SQL.Clear;
      FDQuery.SQL.Add(FITEMSql);
      FDQuery.Params.ParamByName('COMPRA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('DELETED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('COMPRA_ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('DELETED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;

      FDQuery.SQL.Clear;
      FDQuery.SQL.Add(FPAGAMENTOSql);
      FDQuery.Params.ParamByName('COMPRA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('DELETED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('COMPRA_ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('DELETED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;

      Self.Commit;
    except on e: exception do
      begin
        Self.Rollback;
        Result:= False;
        raise Exception.Create('Falha ao remover a compra. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

destructor TCompra.Destroy;
begin
  if Assigned(Self.FPESSOA) then FreeAndNil(Self.FPESSOA);
  if Assigned(Self.FUSER) then FreeAndNil(Self.FUSER);
  if Assigned(Self.FITENS) then FreeAndNil(Self.FITENS);
  if Assigned(Self.FPAGAMENTOS) then FreeAndNil(Self.FPAGAMENTOS);

  inherited;
end;

class function TCompra.find(id: string): TCompra;
const
  FSql: string = 'SELECT * FROM COMPRAS WHERE (ID = :ID)';
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
        Result:= TCompra.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.PessoaId:= FDQuery.FieldByName('PESSOA_ID').AsString;
        Result.UserId:= FDQuery.FieldByName('USER_ID').AsString;
        Result.NfeId:= FDQuery.FieldByName('NFE_ID').AsString;
        Result.Referencia:= FDQuery.FieldByName('REFERENCIA').AsInteger;
        Result.Competencia:= FDQuery.FieldByName('COMPETENCIA').AsDateTime;
        Result.Subtotal:= FDQuery.FieldByName('SUBTOTAL').AsExtended;
        Result.Acrescimo:= FDQuery.FieldByName('ACRESCIMO').AsExtended;
        Result.Desconto:= FDQuery.FieldByName('DESCONTO').AsExtended;
        Result.Total:= FDQuery.FieldByName('TOTAL').AsExtended;
        Result.Situacao:= FDQuery.FieldByName('SITUACAO').AsString;
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

function TCompra.getItens: TObjectList<TCompraItem>;
begin
  if not Assigned(FITENS) and (Self.Id <> EmptyStr) then
    Self.FITENS:= TCompraItem.findByCompraId(Self.Id);

  if not Assigned(FITENS) then
    Self.FITENS:= TObjectList<TCompraItem>.Create;

  Result:= Self.FITENS;
end;

function TCompra.getPagamentos: TObjectList<TPagamento>;
begin
  if not Assigned(FPAGAMENTOS) and (Self.Id <> EmptyStr) then
    Self.FPAGAMENTOS:= TPagamento.findByCompraId(Self.Id);

  if not Assigned(FPAGAMENTOS) then
    Self.FPAGAMENTOS:= TObjectList<TPagamento>.Create;

  Result:= Self.FPAGAMENTOS;
end;

function TCompra.getPessoa: TPessoa;
begin
  if not Assigned(Self.FPESSOA) then
    Self.FPESSOA:= TPessoa.find(Self.FPESSOA_ID)
  else if Self.FPESSOA.Id <> Self.FPESSOA_ID then
  begin
    FreeAndNil(FPESSOA);
    Self.FPESSOA:= TPessoa.find(Self.FPESSOA_ID);
  end;
  Result:= Self.FPESSOA;
end;

function TCompra.getUser: TUser;
begin
  if not Assigned(Self.FUSER) then
    Self.FUSER:= TUser.find(Self.FUSER_ID)
  else if Self.FUSER.Id <> Self.FUSER_ID then
  begin
    FreeAndNil(FUSER);
    Self.FUSER:= TUser.find(Self.FUSER_ID)
  end;
  Result:= Self.FUSER;
end;

class procedure TCompra.imprimir(Id: string);
var
  vEmpresa: TEmpresa;
  vCompra: TCompra;
  Print: TStringList;
  formPrint: TformPrint;
  I: Integer;
begin
  try
    vEmpresa:= nil;
    vCompra:= nil;
    try
      vEmpresa:= TEmpresa.find(TAuthService.getAuthenticatedEmpresaId);
      if not Assigned(vEmpresa) then
        raise Exception.Create('Falha ao consultar dados da empresa.');

      vCompra:= TCompra.find(id);
      if not Assigned(vCompra) then
        raise Exception.Create('Falha ao consultar dados da compra.');

      Print:= TStringList.Create;
      Print.Add('H|' +
                THelper.StrEsquerda('COMPROVANTE DE COMPRA', 28) +
                THelper.StrDireita(FormatDateTime('dd/mm/yyyy',Now), 60));

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

      Print.Add('H|' + 'PESSOA     : ' + vCompra.Pessoa.Nome);
      Print.Add('H|' + 'CPF/CNPJ   : ' +
                       IfThen(vCompra.Pessoa.Documento.Length = 14,
                       THelper.CNPJMask(vCompra.Pessoa.Documento),
                       THelper.CPFMask(vCompra.Pessoa.Documento)));
      Print.Add('H|' + 'REFERENCIA : ' + IntToStr(vCompra.Referencia));
      Print.Add('H|' + 'DATA       : ' + FormatDateTime('dd/mm/yyyy',vCompra.Competencia));

      Print.Add('H|' + StringOfChar('-', 88));

      Print.Add('H|' + THelper.StrEsquerda('REFERENCIA', 10) + ' ' +
                       THelper.StrEsquerda('ITEM', 37) + ' ' +
                       THelper.StrDireita('MEDIDA', 6) + ' ' +
                       THelper.StrDireita('UNIT', 10) + ' ' +
                       THelper.StrDireita('QTD', 10) + ' ' +
                       THelper.StrDireita('SUB', 10));

      Print.Add('H|' + StringOfChar('-', 88));

      for I:= 0 to Pred(vCompra.Itens.Count) do
      begin
        Print.Add('D|' +
          THelper.StrEsquerda(PadLeft(vCompra.Itens.Items[I].Item.Referencia.ToString(), 10, '0'), 10) + ' ' +
            THelper.StrEsquerda(vCompra.Itens.Items[I].Item.Nome, 37) + ' ' +
              THelper.StrDireita(vCompra.Itens.Items[I].Item.Unidade.Unidade, 6) + ' ' +
                THelper.StrDireita(THelper.ExtendedToString(vCompra.Itens.Items[I].Unitario), 10) + ' ' +
                  THelper.StrDireita(THelper.ExtendedToString(vCompra.Itens.Items[I].Qtde,False), 10) + ' ' +
                    THelper.StrDireita(THelper.ExtendedToString(vCompra.Itens.Items[I].Subtotal), 10));
      end;

      Print.Add('F|' + StringOfChar('-',88));
      Print.Add('F|' + 'ITENS ' + THelper.StrDireita(vCompra.Itens.Count.ToString(), 82));
      Print.Add('F|' + 'TOTAL R$' + THelper.StrDireita(THelper.ExtendedToString(vCompra.Total), 80));
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
    if Assigned(vCompra) then FreeAndNil(vCompra);
    if Assigned(Print) then FreeAndNil(Print);
  end;
end;

class procedure TCompra.imprimir(pSituacao: Integer;
                                 pDtInicial,
                                 pDtFinal: TDate;
                                 pPessoaId,
                                 pUserId,
                                 pSearch: string);
var
  vEmpresa: TEmpresa;
  vPessoa: TPessoa;
  vUser: TUser;
  vList: TObjectList<TCompra>;
  Print: TStringList;
  formPrint: TformPrint;
  I: Integer;
  vCount: Integer;
  vTotal: Extended;
begin
  try
    vEmpresa:= nil;
    vPessoa:= nil;
    vUser:= nil;
    vList:= nil;
    try
      vEmpresa:= TEmpresa.find(TAuthService.getAuthenticatedEmpresaId);
      if not Assigned(vEmpresa) then
        raise Exception.Create('Falha ao consultar dados da empresa.');

      vList:= TCompra.list(pSituacao,
                           pDtInicial,
                           pDtFinal,
                           pPessoaId,
                           pUserId,
                           pSearch);

      if not Assigned(vList) then
        raise Exception.Create('Nenhum dado foi encontrado.');

      Print:= TStringList.Create;

      Print.Add('H|' +
                THelper.StrEsquerda('COMPRAS',18) +
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

      Print.Add('H|' + 'PERIODO INICIAL : ' + FormatDateTime('dd/mm/yyyy', pDtInicial));
      Print.Add('H|' + 'PERIODO FINAL   : ' + FormatDateTime('dd/mm/yyyy', pDtFinal));

      vUser:= TUser.find(pUserId);
      if Assigned(vUser) then
        Print.Add('H|' + 'COMPRADOR       : ' + vUser.Nome);

      vPessoa:= TPessoa.find(pPessoaId);
      if Assigned(vPessoa) then
        Print.Add('H|' + 'PESSOA          : ' + vPessoa.Nome);

      Print.Add('H|' + StringOfChar('-', 88));

      if Assigned(vPessoa) then
      begin
        Print.Add('H|' + THelper.StrEsquerda('REFERENCIA', 10) + ' ' +
                         THelper.StrEsquerda('COMPETENCIA', 12) + ' ' +
                         THelper.StrEsquerda('COMPRADOR', 50) + ' ' +
                         THelper.StrDireita('TOTAL', 12));
      end
      else if Assigned(vUser) then
      begin
        Print.Add('H|' + THelper.StrEsquerda('REFERENCIA', 10) + ' ' +
                         THelper.StrEsquerda('COMPETENCIA', 12) + ' ' +
                         THelper.StrEsquerda('PESSOA', 50) + ' ' +
                         THelper.StrDireita('TOTAL', 12));
      end
      else
      begin
        Print.Add('H|' + THelper.StrEsquerda('REFERENCIA', 10) + ' ' +
                         THelper.StrEsquerda('COMPETENCIA', 12) + ' ' +
                         THelper.StrEsquerda('COMPRADOR', 15) + ' ' +
                         THelper.StrEsquerda('PESSOA', 35) + ' ' +
                         THelper.StrDireita('TOTAL', 12));
      end;

      Print.Add('H|' + StringOfChar('-', 88));

      vCount:= vList.Count;
      vTotal:= 0;
      for I:= 0 to Pred(vList.Count) do
      begin
        vTotal:= (vTotal + vList.Items[I].Total);

        if Assigned(vPessoa) then
        begin
          Print.Add('D|' +
            THelper.StrEsquerda(PadLeft(vList.Items[I].Referencia.ToString(), 10, '0'), 10) + ' ' +
            THelper.StrEsquerda(FormatDateTime('dd/mm/yyyy', vList.Items[I].Competencia), 12) + ' ' +
            THelper.StrEsquerda(vList.Items[I].User.Nome, 50) + ' ' +
            THelper.StrDireita(THelper.ExtendedToString(vList.Items[I].Total), 12));
        end
        else if Assigned(vUser) then
        begin
          Print.Add('D|' +
            THelper.StrEsquerda(PadLeft(vList.Items[I].Referencia.ToString(), 10, '0'), 10) + ' ' +
            THelper.StrEsquerda(FormatDateTime('dd/mm/yyyy', vList.Items[I].Competencia), 12) + ' ' +
            THelper.StrEsquerda(vList.Items[I].Pessoa.Nome, 50) + ' ' +
            THelper.StrDireita(THelper.ExtendedToString(vList.Items[I].Total), 12));
        end
        else
        begin
          Print.Add('D|' +
            THelper.StrEsquerda(PadLeft(vList.Items[I].Referencia.ToString(), 10, '0'), 10) + ' ' +
            THelper.StrEsquerda(FormatDateTime('dd/mm/yyyy', vList.Items[I].Competencia), 12) + ' ' +
            THelper.StrEsquerda(vList.Items[I].User.Nome, 15) + ' ' +
            THelper.StrEsquerda(vList.Items[I].Pessoa.Nome, 35) + ' ' +
            THelper.StrDireita(THelper.ExtendedToString(vList.Items[I].Total), 12));
        end;
      end;

      Print.Add('F|' + StringOfChar('-', 88));

      Print.Add('F|' + THelper.StrEsquerda('COMPRAS', 44) +
        THelper.StrDireita(vCount.ToString(), 44));
      Print.Add('F|' + THelper.StrEsquerda('TOTAL COMPRADO (R$)', 44) +
        THelper.StrDireita(THelper.ExtendedToString(vTotal), 44));

      Print.Add('F|' + StringOfChar('-', 88));
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
    if Assigned(vPessoa) then FreeAndNil(vPessoa);
    if Assigned(vUser) then FreeAndNil(vUser);
    if Assigned(vList) then FreeAndNil(vList);
    if Assigned(Print) then FreeAndNil(Print);
  end;
end;

class function TCompra.list(pSituacao: Integer;
                            pDtInicial,
                            pDtFinal: TDate;
                            pPessoaId,
                            pUserId,
                            pSearch: string): TObjectList<TCompra>;
var
  FSql: string;
  FDQuery: TFDQuery;
  vReferencia: Integer;
begin
  try
    FDQuery:= Self.createQuery;
    try
      vReferencia:= StrToIntDef(pSearch, 0);

      FSql:= 'SELECT C.ID FROM COMPRAS C ' +
      'WHERE (C.EMPRESA_ID = :EMPRESA_ID) AND (C.DELETED_AT IS NULL) ' +
      'AND (C.COMPETENCIA BETWEEN :DTINICIAL AND :DTFINAL) ' +
      'AND (C.SITUACAO = :SITUACAO) ';

      if (pPessoaId <> '') then
        FSql:= FSql + 'AND (C.PESSOA_ID = :PESSOA_ID) ';

      if (pUserId <> '') then
        FSql:= FSql + 'AND (C.USER_ID = :USER_ID) ';

      if (vReferencia >= 1) then
        FSql:= FSql + 'AND (C.REFERENCIA = :REFERENCIA) ';

      FSql:= FSql + 'ORDER BY C.COMPETENCIA DESC, C.REFERENCIA DESC';
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('DTINICIAL').DataType:= ftDate;
      FDQuery.Params.ParamByName('DTFINAL').DataType:= ftDate;
      FDQuery.Params.ParamByName('SITUACAO').DataType:= ftString;

      if (pPessoaId <> '') then
        FDQuery.Params.ParamByName('PESSOA_ID').DataType:= ftString;

      if (pUserId <> '') then
        FDQuery.Params.ParamByName('USER_ID').DataType:= ftString;

      if (vReferencia >= 1) then
        FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;

      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('DTINICIAL').AsDate:= pDtInicial;
      FDQuery.Params.ParamByName('DTFINAL').AsDate:= pDtFinal;
      FDQuery.Params.ParamByName('SITUACAO').AsString:= IfThen(pSituacao = 0, 'A', 'F');

      if (pPessoaId <> '') then
        FDQuery.Params.ParamByName('PESSOA_ID').AsString:= pPessoaId;

      if (pUserId <> '') then
        FDQuery.Params.ParamByName('USER_ID').AsString:= pUserId;

      if (vReferencia >= 1) then
        FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= vReferencia;

      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TCompra>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TCompra.find(FDQuery.FieldByName('ID').AsString));
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

class procedure TCompra.list(pSituacao: Integer;
                             pDtInicial,
                             pDtFinal: TDate;
                             pPessoaId,
                             pUserId,
                             pSearch: string; pDt: TFDMemTable);
var
  vList: TObjectList<TCompra>;
  I: Integer;
begin
  pDt.Open();
  pDt.DisableControls();
  pDt.EmptyDataSet();
  vList:= TCompra.list(pSituacao,
                       pDtInicial,
                       pDtFinal,
                       pPessoaId,
                       pUserId,
                       pSearch);
  if Assigned(vList) then
  begin
    for I := 0 to Pred(vList.Count) do
    begin
      pDt.Append();
      pDt.FieldByName('ID').AsString:= vList.Items[I].Id;
      pDt.FieldByName('REFERENCIA').AsInteger:= vList.Items[I].Referencia;
      pDt.FieldByName('COMPETENCIA').AsDateTime:= vList.Items[I].Competencia;
      pDt.FieldByName('SUBTOTAL').AsExtended:= vList.Items[I].Subtotal;
      pDt.FieldByName('ACRESCIMO').AsExtended:= vList.Items[I].Acrescimo;
      pDt.FieldByName('DESCONTO').AsExtended:= vList.Items[I].Desconto;
      pDt.FieldByName('TOTAL').AsExtended:= vList.Items[I].Total;
      pDt.FieldByName('PESSOA').AsString:= vList.Items[I].Pessoa.Nome;
      pDt.FieldByName('USER').AsString:= vList.Items[I].User.Nome;
      pDt.FieldByName('NFE_ID').AsString:= vList.Items[I].NfeId;
      pDt.FieldByName('CHECK').AsInteger:= 0;
      pDt.Post();
    end;
    FreeAndNil(vList);
  end;
  pDt.First();
  pDt.EnableControls();
end;

class procedure TCompra.listItens(id: string; DataSet: TFDMemTable);
var
  v_list: TObjectList<TCompraItem>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  v_list:= TCompraItem.findByCompraId(id);
  if Assigned(v_list) then
  begin
    for I := 0 to Pred(v_list.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ITEM_ID').AsString:= v_list.Items[I].ItemId;
      DataSet.FieldByName('ITEM_REFERENCIA').AsInteger:= v_list.Items[I].Item.Referencia;
      DataSet.FieldByName('ITEM_NOME').AsString:= v_list.Items[I].Item.Nome;
      if Assigned(v_list.Items[I].Item.Unidade) then
        DataSet.FieldByName('ITEM_UNIDADE').AsString:= v_list.Items[I].Item.Unidade.Unidade;
      DataSet.FieldByName('UNITARIO').AsExtended:= v_list.Items[I].Unitario;
      DataSet.FieldByName('QTDE').AsExtended:= v_list.Items[I].Qtde;
      DataSet.FieldByName('SUBTOTAL').AsExtended:= v_list.Items[I].Subtotal;
      DataSet.FieldByName('ACRESCIMO').AsExtended:= v_list.Items[I].Acrescimo;
      DataSet.FieldByName('DESCONTO').AsExtended:= v_list.Items[I].Desconto;
      DataSet.FieldByName('TOTAL').AsExtended:= v_list.Items[I].Total;
      DataSet.Post;
    end;
    FreeAndNil(v_list);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TCompra.remove(id: string): Boolean;
var
  compra: TCompra;
begin
  Result:= False;
  compra:= TCompra.find(id);
  if not Assigned(compra) then
  begin
    THelper.Mensagem('Compra inexistente. A compra pode ter sido previamente removida por outro usuário!');
    Exit();
  end;

  try
    if not THelper.Mensagem('Deseja realmente remover?', 1) then
      Exit();

    Result:= compra.delete();
  finally
    FreeAndNil(compra);
  end;
end;

function TCompra.save: Boolean;
begin
  Result:= inherited;
end;

function TCompra.store: Boolean;
const
  FSql: string =
  'INSERT INTO COMPRAS (' +
  '  ID,               ' +
  '  EMPRESA_ID,       ' +
  '  PESSOA_ID,        ' +
  '  USER_ID,          ' +
  '  NFE_ID,           ' +
  '  REFERENCIA,       ' +
  '  COMPETENCIA,      ' +
  '  SUBTOTAL,         ' +
  '  ACRESCIMO,        ' +
  '  DESCONTO,         ' +
  '  TOTAL,            ' +
  '  SITUACAO,         ' +
  '  CREATED_AT,       ' +
  '  UPDATED_AT)       ' +
  'VALUES (            ' +
  '  :ID,              ' +
  '  :EMPRESA_ID,      ' +
  '  :PESSOA_ID,       ' +
  '  :USER_ID,         ' +
  '  :NFE_ID,          ' +
  '  :REFERENCIA,      ' +
  '  :COMPETENCIA,     ' +
  '  :SUBTOTAL,        ' +
  '  :ACRESCIMO,       ' +
  '  :DESCONTO,        ' +
  '  :TOTAL,           ' +
  '  :SITUACAO,        ' +
  '  :CREATED_AT,      ' +
  '  :UPDATED_AT)      ';
var
  FDQuery: TFDQuery;
  I: Integer;
begin
  Result:= True;
  try
    Self.StartTransaction;
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('PESSOA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('USER_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('NFE_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('COMPETENCIA').DataType:= ftDate;
      FDQuery.Params.ParamByName('SUBTOTAL').DataType:= ftExtended;
      FDQuery.Params.ParamByName('ACRESCIMO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('DESCONTO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('TOTAL').DataType:= ftExtended;
      FDQuery.Params.ParamByName('SITUACAO').DataType:= ftString;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare();

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;
      Self.Referencia:= Self.nextReferencia(Self.Referencia);

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('PESSOA_ID').AsString:= Self.PessoaId;
      FDQuery.Params.ParamByName('USER_ID').AsString:= Self.UserId;
      if (Self.NfeId <> EmptyStr) then
      FDQuery.Params.ParamByName('NFE_ID').AsString:= Self.NfeId;
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= Self.Referencia;
      FDQuery.Params.ParamByName('COMPETENCIA').AsDate:= Self.Competencia;
      FDQuery.Params.ParamByName('SUBTOTAL').AsExtended:= Self.Subtotal;
      FDQuery.Params.ParamByName('ACRESCIMO').AsExtended:= Self.Acrescimo;
      FDQuery.Params.ParamByName('DESCONTO').AsExtended:= Self.Desconto;
      FDQuery.Params.ParamByName('TOTAL').AsExtended:= Self.Total;
      FDQuery.Params.ParamByName('SITUACAO').AsString:= Self.Situacao;
      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.ExecSQL();

      if (Self.NfeId <> EmptyStr) then
      begin
        FDQuery.SQL.Clear();
        FDQuery.SQL.Add('UPDATE NFES N SET N.DSAIENT = :DSAIENT, N.NFERECEBIDA = 3 ');
        FDQuery.SQL.Add('WHERE (EMPRESA_ID = :EMPRESA_ID) ');
        FDQuery.SQL.Add('AND (N.ID = :ID)');
        FDQuery.Params.ParamByName('DSAIENT').DataType:= ftDate;
        FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
        FDQuery.Params.ParamByName('ID').DataType:= ftString;
        FDQuery.Prepare();
        FDQuery.Params.ParamByName('DSAIENT').AsDate:= Self.Competencia;
        FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
        FDQuery.Params.ParamByName('ID').AsString:=  Self.NfeId;
        FDQuery.ExecSQL();
      end;

      for I:= 0 to Pred(Self.Itens.Count) do
      begin
        Self.Itens.Items[I].CompraId:= Self.Id;
        Self.Itens.Items[I].UserId:= Self.UserId;
        Self.Itens.Items[I].save();
      end;

      for I:= 0 to Pred(Self.Pagamentos.Count) do
      begin
        Self.Pagamentos.Items[I].CompraId:= Self.Id;
        Self.Pagamentos.Items[I].save();
      end;

      Self.Commit;
    except on e: exception do
    begin
      Self.Rollback;
      Result:= False;
      raise Exception.Create('Falha ao inserir a compra. Erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TCompra.update: Boolean;
const
  FSql: string =
  'UPDATE COMPRAS                   ' +
  'SET PESSOA_ID = :PESSOA_ID,      ' +
  '    USER_ID = :USER_ID,          ' +
  '    NFE_ID = :NFE_ID,            ' +
  '    REFERENCIA = :REFERENCIA,    ' +
  '    COMPETENCIA = :COMPETENCIA,  ' +
  '    SUBTOTAL = :SUBTOTAL,        ' +
  '    ACRESCIMO = :ACRESCIMO,      ' +
  '    DESCONTO = :DESCONTO,        ' +
  '    TOTAL = :TOTAL,              ' +
  '    SITUACAO = :SITUACAO,        ' +
  '    UPDATED_AT = :UPDATED_AT,    ' +
  '    SYNCHRONIZED = :SYNCHRONIZED ' +
  'WHERE (ID = :ID)                 ';
var
  FDQuery: TFDQuery;
  I: Integer;
begin
  Result:= True;
  try
    Self.StartTransaction;
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('PESSOA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('USER_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('NFE_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('COMPETENCIA').DataType:= ftDate;
      FDQuery.Params.ParamByName('SUBTOTAL').DataType:= ftExtended;
      FDQuery.Params.ParamByName('ACRESCIMO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('DESCONTO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('TOTAL').DataType:= ftExtended;
      FDQuery.Params.ParamByName('SITUACAO').DataType:= ftString;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftString;
      FDQuery.Prepare();

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('PESSOA_ID').AsString:= Self.PessoaId;
      FDQuery.Params.ParamByName('USER_ID').AsString:= Self.UserId;
      if (Self.NfeId <> EmptyStr) then
      FDQuery.Params.ParamByName('NFE_ID').AsString:= Self.NfeId;
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= Self.Referencia;
      FDQuery.Params.ParamByName('COMPETENCIA').AsDate:= Self.Competencia;
      FDQuery.Params.ParamByName('SUBTOTAL').AsExtended:= Self.Subtotal;
      FDQuery.Params.ParamByName('ACRESCIMO').AsExtended:= Self.Acrescimo;
      FDQuery.Params.ParamByName('DESCONTO').AsExtended:= Self.Desconto;
      FDQuery.Params.ParamByName('TOTAL').AsExtended:= Self.Total;
      FDQuery.Params.ParamByName('SITUACAO').AsString:= Self.Situacao;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL();

      FDQuery.SQL.Clear();
      FDQuery.SQL.Add('DELETE FROM COMPRA_ITENS WHERE ');
      FDQuery.SQL.Add('(EMPRESA_ID = :EMPRESA_ID) ');
      FDQuery.SQL.Add('AND (COMPRA_ID = :COMPRA_ID)');
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('COMPRA_ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('COMPRA_ID').AsString:=  Self.Id;
      FDQuery.ExecSQL();

      FDQuery.SQL.Clear();
      FDQuery.SQL.Add('DELETE FROM PAGAMENTOS WHERE ');
      FDQuery.SQL.Add('(EMPRESA_ID = :EMPRESA_ID) ');
      FDQuery.SQL.Add('AND (COMPRA_ID = :COMPRA_ID)');
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('COMPRA_ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.Params.ParamByName('COMPRA_ID').AsString:=  Self.Id;
      FDQuery.ExecSQL();

      for I:= 0 to Pred(Self.Itens.Count) do
      begin
        Self.Itens.Items[I].CompraId:= Self.Id;
        Self.Itens.Items[I].UserId:= Self.UserId;
        Self.Itens.Items[I].save();
      end;

      for I:= 0 to Pred(Self.Pagamentos.Count) do
      begin
        Self.Pagamentos.Items[I].CompraId:= Self.Id;
        Self.Pagamentos.Items[I].save();
      end;

      Self.Commit;
    except on e: exception do
    begin
      Self.Rollback;
      Result:= False;
      raise Exception.Create('Falha ao atualizar a compra. Erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
