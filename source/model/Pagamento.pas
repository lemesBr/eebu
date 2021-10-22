unit Pagamento;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  Conta, Pessoa, Categoria, System.StrUtils;

type
  TPagamento = class(TModel)
  private
    FEMPRESA_ID: String;
    FCONTA_ID: String;
    FPESSOA_ID: String;
    FCATEGORIA_ID: String;
    FCOMPRA_ID: String;
    FREFERENCIA: Integer;
    FDESCRICAO: String;
    FCOMPETENCIA: TDateTime;
    FVALOR: Extended;
    FDESCONTOS_TAXAS: Extended;
    FJUROS_MULTA: Extended;
    FVALOR_PAGO: Extended;
    FVENCIMENTO: TDateTime;
    FPAGAMENTO: TDateTime;
    FSITUACAO: String;

    FCONTA: TConta;
    FPESSOA: TPessoa;
    FCATEGORIA: TCategoria;

    function getConta: TConta;
    function getPessoa: TPessoa;
    function getCategoria: TCategoria;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    function delete(): Boolean;
    function validate(vtype: integer = 0): Boolean;
    class function find(id: string): TPagamento;
    class function findByCompraId(CompraId: string): TObjectList<TPagamento>;
    class function list(pFiltro,
                        pSituacao: Integer;
                        pDtInicial,
                        pDtFinal: TDate;
                        pContaId,
                        pCategoriaId,
                        pPessoaId,
                        pSearch: string): TObjectList<TPagamento>; overload;
    class procedure list(pFiltro,
                         pSituacao: Integer;
                         pDtInicial,
                         pDtFinal: TDate;
                         pContaId,
                         pCategoriaId,
                         pPessoaId,
                         pSearch: string;
                         DataSet: TFDMemTable); overload;
    class function remove(id: string): Boolean;
    class procedure imprimir(pFiltro,
                             pSituacao: Integer;
                             pDtInicial,
                             pDtFinal: TDate;
                             pContaId,
                             pCategoriaId,
                             pPessoaId,
                             pSearch: string);

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property ContaId: String  read FCONTA_ID write FCONTA_ID;
    property PessoaId: String  read FPESSOA_ID write FPESSOA_ID;
    property CategoriaId: String  read FCATEGORIA_ID write FCATEGORIA_ID;
    property CompraId: String  read FCOMPRA_ID write FCOMPRA_ID;
    property Referencia: Integer  read FREFERENCIA write FREFERENCIA;
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    property Competencia: TDateTime  read FCOMPETENCIA write FCOMPETENCIA;
    property Valor: Extended  read FVALOR write FVALOR;
    property DescontosTaxas: Extended  read FDESCONTOS_TAXAS write FDESCONTOS_TAXAS;
    property JurosMulta: Extended  read FJUROS_MULTA write FJUROS_MULTA;
    property ValorPago: Extended  read FVALOR_PAGO write FVALOR_PAGO;
    property Vencimento: TDateTime  read FVENCIMENTO write FVENCIMENTO;
    property Pagamento: TDateTime  read FPAGAMENTO write FPAGAMENTO;
    property Situacao: String  read FSITUACAO write FSITUACAO;

    property Conta: TConta read getConta;
    property Pessoa: TPessoa read getPessoa;
    property Categoria: TCategoria read getCategoria;

  end;

implementation

uses
  AuthService, Helper, uformPrint, Empresa;

{ TPagamento }

constructor TPagamento.Create;
begin
  Self.Table:= 'PAGAMENTOS';
end;

function TPagamento.delete: Boolean;
const
  FSql: string =
  'UPDATE PAGAMENTOS                ' +
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
        raise Exception.Create('falha ao remover o pagamento. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

destructor TPagamento.Destroy;
begin
  if Assigned(FCONTA) then FreeAndNil(FCONTA);
  if Assigned(FPESSOA) then FreeAndNil(FPESSOA);
  if Assigned(FCATEGORIA) then FreeAndNil(FCATEGORIA);

  inherited;
end;

class function TPagamento.find(id: string): TPagamento;
const
  FSql: string =
  'SELECT * FROM PAGAMENTOS WHERE (ID = :ID) ' +
  'AND (DELETED_AT IS NULL)';
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
        Result:= TPagamento.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.ContaId:= FDQuery.FieldByName('CONTA_ID').AsString;
        Result.PessoaId:= FDQuery.FieldByName('PESSOA_ID').AsString;
        Result.CategoriaId:= FDQuery.FieldByName('CATEGORIA_ID').AsString;
        Result.CompraId:= FDQuery.FieldByName('COMPRA_ID').AsString;
        Result.Referencia:= FDQuery.FieldByName('REFERENCIA').AsInteger;
        Result.Descricao:= FDQuery.FieldByName('DESCRICAO').AsString;
        Result.Competencia:= FDQuery.FieldByName('COMPETENCIA').AsDateTime;
        Result.Valor:= FDQuery.FieldByName('VALOR').AsExtended;
        Result.DescontosTaxas:= FDQuery.FieldByName('DESCONTOS_TAXAS').AsExtended;
        Result.JurosMulta:= FDQuery.FieldByName('JUROS_MULTA').AsExtended;
        Result.ValorPago:= FDQuery.FieldByName('VALOR_PAGO').AsExtended;
        Result.Vencimento:= FDQuery.FieldByName('VENCIMENTO').AsDateTime;
        Result.Pagamento:= FDQuery.FieldByName('PAGAMENTO').AsDateTime;
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

class function TPagamento.findByCompraId(
  CompraId: string): TObjectList<TPagamento>;
const
  FSql: string =
  'SELECT ID FROM PAGAMENTOS ' +
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
        Result:= TObjectList<TPagamento>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TPagamento.find(FDQuery.FieldByName('ID').AsString));
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

function TPagamento.getCategoria: TCategoria;
begin
  if not Assigned(Self.FCATEGORIA) then
    Self.FCATEGORIA:= TCategoria.find(Self.CategoriaId)
  else if Self.FCATEGORIA.Id <> Self.CategoriaId then
  begin
    FreeAndNil(FCATEGORIA);
    Self.FCATEGORIA:= TCategoria.find(Self.CategoriaId);
  end;
  Result:= Self.FCATEGORIA;
end;

function TPagamento.getConta: TConta;
begin
  if not Assigned(Self.FCONTA) then
    Self.FCONTA:= TConta.find(Self.ContaId)
  else if Self.FCONTA.Id <> Self.ContaId then
  begin
    FreeAndNil(FCONTA);
    Self.FCONTA:= TConta.find(Self.ContaId);
  end;
  Result:= Self.FCONTA;
end;

function TPagamento.getPessoa: TPessoa;
begin
  if not Assigned(Self.FPESSOA) then
    Self.FPESSOA:= TPessoa.find(Self.PessoaId)
  else if Self.FPESSOA.Id <> Self.PessoaId then
  begin
    FreeAndNil(FPESSOA);
    Self.FPESSOA:= TPessoa.find(Self.PessoaId);
  end;
  Result:= Self.FPESSOA;
end;

class procedure TPagamento.imprimir(pFiltro,
                                    pSituacao: Integer;
                                    pDtInicial,
                                    pDtFinal: TDate;
                                    pContaId,
                                    pCategoriaId,
                                    pPessoaId,
                                    pSearch: string);
var
  vEmpresa: TEmpresa;
  vConta: TConta;
  vCategoria: TCategoria;
  vPessoa: TPessoa;
  Print: TStringList;
  formPrint: TformPrint;
  vDt: TFDMemTable;
  vTotalPagas,
  vTotalPagar,
  vTotalVencidas,
  vTotal: Extended;
begin
  try
    vEmpresa:= nil;
    vConta:= nil;
    vCategoria:= nil;
    vPessoa:= nil;
    try
      vEmpresa:= TEmpresa.find(TAuthService.getAuthenticatedEmpresaId);
      if not Assigned(vEmpresa) then
        raise Exception.Create('Falha ao consultar dados da empresa.');

      vDt:= TFDMemTable.Create(nil);
      vDt.FieldDefs.Add('ID', ftString, 32);
      vDt.FieldDefs.Add('DATA', ftDate);
      vDt.FieldDefs.Add('CATEGORIA', ftString, 255);
      vDt.FieldDefs.Add('DESCRICAO', ftString, 255);
      vDt.FieldDefs.Add('PESSOA', ftString, 255);
      vDt.FieldDefs.Add('VALOR', ftFloat);
      vDt.FieldDefs.Add('SITUACAO', ftString, 1);
      vDt.IndexFieldNames:= 'DATA';

      TPagamento.list(pFiltro,
                      pSituacao,
                      pDtInicial,
                      pDtFinal,
                      pContaId,
                      pCategoriaId,
                      pPessoaId,
                      pSearch,
                      vDt);

      if not (vDt.RecordCount >= 1) then
        raise Exception.Create('Nenhum dado foi encontrado.');

      Print:= TStringList.Create;

      Print.Add('H|' +
                THelper.StrEsquerda('PAGAMENTOS',18) +
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

      case pFiltro of
        1: Print.Add('H|' + 'FILTRO          : DATA DE COMPETENCIA');
        2: Print.Add('H|' + 'FILTRO          : DATA DE VENCIMENTO');
        3: Print.Add('H|' + 'FILTRO          : DATA DE RECEBIMENTO');
      end;

      if (pFiltro in[1,2,3]) then
      begin
        Print.Add('H|' + 'PERIODO INICIAL : ' + FormatDateTime('dd/mm/yyyy', pDtInicial));
        Print.Add('H|' + 'PERIODO FINAL   : ' + FormatDateTime('dd/mm/yyyy', pDtFinal));
      end;

      case pSituacao of
        1: Print.Add('H|' + 'STATUS          : A PAGAR');
        2: Print.Add('H|' + 'STATUS          : PAGAS');
      end;

      vConta:= TConta.find(pContaId);
      if Assigned(vConta) then
        Print.Add('H|' + 'CONTA           : ' + vConta.Nome);

      vCategoria:= TCategoria.find(pCategoriaId);
      if Assigned(vCategoria) then
        Print.Add('H|' + 'CATEGORIA       : ' + vCategoria.Nome);

      vPessoa:= TPessoa.find(pPessoaId);
      if Assigned(vPessoa) then
        Print.Add('H|' + 'PESSOA          : ' + vPessoa.Nome);

      Print.Add('H|' + StringOfChar('-', 88));

      if Assigned(vPessoa) then
      begin
        Print.Add('H|' + THelper.StrEsquerda('DATA', 10) + ' ' +
                         THelper.StrEsquerda('CATEGORIA', 18) + ' ' +
                         THelper.StrEsquerda('DESCRICAO', 45) + ' ' +
                         THelper.StrDireita('VALOR', 10));
      end
      else
      begin
        Print.Add('H|' + THelper.StrEsquerda('DATA', 10) + ' ' +
                         THelper.StrEsquerda('DESCRICAO', 35) + ' ' +
                         THelper.StrEsquerda('PESSOA', 28) + ' ' +
                         THelper.StrDireita('VALOR', 10));
      end;

      Print.Add('H|' + StringOfChar('-', 88));

      vTotalPagas:= 0;
      vTotalPagar:= 0;
      vTotalVencidas:= 0;
      vTotal:= 0;
      while not vDt.Eof do
      begin
        vTotal:= (vTotal + vDt.FieldByName('VALOR').AsExtended);
        if (vDt.FieldByName('SITUACAO').AsString = 'F') then
          vTotalPagas:= (vTotalPagas + vDt.FieldByName('VALOR').AsExtended)
        else
        begin
          vTotalPagar:= (vTotalPagar + vDt.FieldByName('VALOR').AsExtended);
          if (pFiltro = 2) and (vDt.FieldByName('DATA').AsDateTime < Date) then
            vTotalVencidas:= (vTotalVencidas + vDt.FieldByName('VALOR').AsExtended);
        end;

        if Assigned(vPessoa) then
        begin
          Print.Add('D|' +
            THelper.StrEsquerda(FormatDateTime('dd/mm/yyyy', vDt.FieldByName('DATA').AsDateTime), 10) + ' ' +
            THelper.StrEsquerda(vDt.FieldByName('CATEGORIA').AsString, 18) + ' ' +
            THelper.StrEsquerda(vDt.FieldByName('DESCRICAO').AsString, 45) + ' ' +
            THelper.StrDireita(THelper.ExtendedToString(vDt.FieldByName('VALOR').AsExtended), 10) + ' ' +
            IfThen(vDt.FieldByName('SITUACAO').AsString = 'F', '$', ' '));
        end
        else
        begin
          Print.Add('D|' +
            THelper.StrEsquerda(FormatDateTime('dd/mm/yyyy', vDt.FieldByName('DATA').AsDateTime), 10) + ' ' +
            THelper.StrEsquerda(vDt.FieldByName('DESCRICAO').AsString, 35) + ' ' +
            THelper.StrEsquerda(vDt.FieldByName('PESSOA').AsString, 28) + ' ' +
            THelper.StrDireita(THelper.ExtendedToString(vDt.FieldByName('VALOR').AsExtended), 10) + ' ' +
            IfThen(vDt.FieldByName('SITUACAO').AsString = 'F', '$', ' '));
        end;

        vDt.Next();
      end;

      Print.Add('F|' + StringOfChar('-', 88));

      Print.Add('F|' + THelper.StrEsquerda('NUMERO DE LANCAMENTOS', 44) +
        THelper.StrDireita(vDt.RecordCount.ToString(), 44));
      Print.Add('F|' + THelper.StrEsquerda('PAGAS (R$)', 44) +
        THelper.StrDireita(THelper.ExtendedToString(vTotalPagas), 44));
      Print.Add('F|' + THelper.StrEsquerda('A PAGAR (R$)', 44) +
        THelper.StrDireita(THelper.ExtendedToString(vTotalPagar), 44));
      Print.Add('F|' + THelper.StrEsquerda('VENCIDAS (R$)', 44) +
        THelper.StrDireita(THelper.ExtendedToString(vTotalVencidas), 44));
      Print.Add('F|' + THelper.StrEsquerda('TOTAL DE PAGAMENTOS (R$)', 44) +
        THelper.StrDireita(THelper.ExtendedToString(vTotal), 44));

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
    FreeAndNil(vDt);
    if Assigned(vEmpresa) then FreeAndNil(vEmpresa);
    if Assigned(vConta) then FreeAndNil(vConta);
    if Assigned(vCategoria) then FreeAndNil(vCategoria);
    if Assigned(vPessoa) then FreeAndNil(vPessoa);
    if Assigned(Print) then FreeAndNil(Print);
  end;
end;

class function TPagamento.list(pFiltro,
                               pSituacao: Integer;
                               pDtInicial,
                               pDtFinal: TDate;
                               pContaId,
                               pCategoriaId,
                               pPessoaId,
                               pSearch: string): TObjectList<TPagamento>;
var
  FSql: string;
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FSql:=
      'SELECT PG.ID FROM PAGAMENTOS PG ' +
      'JOIN CATEGORIAS C ON(C.ID = PG.CATEGORIA_ID) ' +
      'JOIN CONTAS CT ON(CT.ID = PG.CONTA_ID) ' +
      'JOIN PESSOAS P ON(P.ID = PG.PESSOA_ID) ' +
      'WHERE (PG.EMPRESA_ID = :EMPRESA_ID) AND (PG.DELETED_AT IS NULL) ';

      case pFiltro of
        1: FSql:= FSql + 'AND (PG.COMPETENCIA BETWEEN :DTINICIAL AND :DTFINAL) ';
        2: FSql:= FSql + 'AND (PG.VENCIMENTO BETWEEN :DTINICIAL AND :DTFINAL) ';
        3: FSql:= FSql + 'AND (PG.PAGAMENTO BETWEEN :DTINICIAL AND :DTFINAL) ';
      end;

      if (pSituacao in[1,2]) then
        FSql:= FSql + 'AND (PG.SITUACAO = :SITUACAO) ';

      if (pContaId <> '') then
        FSql:= FSql + 'AND (PG.CONTA_ID = :CONTA_ID) ';

      if (pCategoriaId <> '') then
        FSql:= FSql + 'AND (PG.CATEGORIA_ID = :CATEGORIA_ID) ';

      if (pPessoaId <> '') then
        FSql:= FSql + 'AND (PG.PESSOA_ID = :PESSOA_ID) ';

      FSql:= FSql + 'AND (PG.DESCRICAO LIKE :DESCRICAO)';
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;

      if (pFiltro in[1,2,3]) then
      begin
        FDQuery.Params.ParamByName('DTINICIAL').DataType:= ftDate;
        FDQuery.Params.ParamByName('DTFINAL').DataType:= ftDate;
      end;

      if (pSituacao in[1,2]) then
        FDQuery.Params.ParamByName('SITUACAO').DataType:= ftString;

      if (pContaId <> '') then
        FDQuery.Params.ParamByName('CONTA_ID').DataType:= ftString;

      if (pCategoriaId <> '') then
        FDQuery.Params.ParamByName('CATEGORIA_ID').DataType:= ftString;

      if (pPessoaId <> '') then
        FDQuery.Params.ParamByName('PESSOA_ID').DataType:= ftString;

      FDQuery.Params.ParamByName('DESCRICAO').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;

      if (pFiltro in[1,2,3]) then
      begin
        FDQuery.Params.ParamByName('DTINICIAL').AsDate:= pDtInicial;
        FDQuery.Params.ParamByName('DTFINAL').AsDate:= pDtFinal;
      end;

      case pSituacao of
        1: FDQuery.Params.ParamByName('SITUACAO').AsString:= 'A';
        2: FDQuery.Params.ParamByName('SITUACAO').AsString:= 'F';
      end;

      if (pContaId <> '') then
        FDQuery.Params.ParamByName('CONTA_ID').AsString:= pContaId;

      if (pCategoriaId <> '') then
        FDQuery.Params.ParamByName('CATEGORIA_ID').AsString:= pCategoriaId;

      if (pPessoaId <> '') then
        FDQuery.Params.ParamByName('PESSOA_ID').AsString:= pPessoaId;

      FDQuery.Params.ParamByName('DESCRICAO').AsString:= '%' + pSearch + '%';
      FDQuery.Open();

      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TObjectList<TPagamento>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TPagamento.find(FDQuery.FieldByName('ID').AsString));
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

class function TPagamento.remove(id: string): Boolean;
var
  Pagamento: TPagamento;
begin
  Result:= False;
  Pagamento:= TPagamento.find(id);
  if not Assigned(Pagamento) then
  begin
    THelper.Mensagem('Pagamento não encontrado. O pagamento pode ter sido previamente excluído por outro usuário!');
    Exit();
  end;

  try
    if (Pagamento.CompraId <> EmptyStr) then
    begin
      THelper.Mensagem('Não é possivel remover lançamentos de compra ou venda. Remova a compra ou venda para excluir os lançamentos financeiros!');
      Exit();
    end
    else
    begin
      if not THelper.Mensagem('Deseja realmente remover o pagamento?', 1) then
        Exit();
    end;

    Result:= Pagamento.delete();
  finally
    FreeAndNil(Pagamento);
  end;
end;

function TPagamento.save: Boolean;
begin
  Result:= inherited;
end;

function TPagamento.store: Boolean;
const
  FSql: string =
  'INSERT INTO PAGAMENTOS ( ' +
  '  ID,                    ' +
  '  EMPRESA_ID,            ' +
  '  CONTA_ID,              ' +
  '  PESSOA_ID,             ' +
  '  CATEGORIA_ID,          ' +
  '  COMPRA_ID,             ' +
  '  REFERENCIA,            ' +
  '  DESCRICAO,             ' +
  '  COMPETENCIA,           ' +
  '  VALOR,                 ' +
  '  DESCONTOS_TAXAS,       ' +
  '  JUROS_MULTA,           ' +
  '  VALOR_PAGO,            ' +
  '  VENCIMENTO,            ' +
  '  PAGAMENTO,             ' +
  '  SITUACAO,              ' +
  '  CREATED_AT,            ' +
  '  UPDATED_AT)            ' +
  'VALUES (                 ' +
  '  :ID,                   ' +
  '  :EMPRESA_ID,           ' +
  '  :CONTA_ID,             ' +
  '  :PESSOA_ID,            ' +
  '  :CATEGORIA_ID,         ' +
  '  :COMPRA_ID,            ' +
  '  :REFERENCIA,           ' +
  '  :DESCRICAO,            ' +
  '  :COMPETENCIA,          ' +
  '  :VALOR,                ' +
  '  :DESCONTOS_TAXAS,      ' +
  '  :JUROS_MULTA,          ' +
  '  :VALOR_PAGO,           ' +
  '  :VENCIMENTO,           ' +
  '  :PAGAMENTO,            ' +
  '  :SITUACAO,             ' +
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
      FDQuery.Params.ParamByName('CONTA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PESSOA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CATEGORIA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('COMPRA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('DESCRICAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('COMPETENCIA').DataType:= ftDate;
      FDQuery.Params.ParamByName('VALOR').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('DESCONTOS_TAXAS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('JUROS_MULTA').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALOR_PAGO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VENCIMENTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('PAGAMENTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('SITUACAO').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;
      Self.Referencia:= Self.nextReferencia(Self.Referencia);

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      if (Self.ContaId <> EmptyStr) then
        FDQuery.Params.ParamByName('CONTA_ID').AsString:= Self.ContaId;
      if (Self.PessoaId <> EmptyStr) then
        FDQuery.Params.ParamByName('PESSOA_ID').AsString:= Self.PessoaId;
      if (Self.CategoriaId <> EmptyStr) then
        FDQuery.Params.ParamByName('CATEGORIA_ID').AsString:= Self.CategoriaId;
      if (Self.CompraId <> EmptyStr) then
        FDQuery.Params.ParamByName('COMPRA_ID').AsString:= Self.CompraId;
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= Self.Referencia;
      if (Self.Descricao <> EmptyStr) then
        FDQuery.Params.ParamByName('DESCRICAO').AsString:= Self.Descricao;
      FDQuery.Params.ParamByName('COMPETENCIA').AsDate:= Self.Competencia;
      FDQuery.Params.ParamByName('VALOR').AsFMTBCD:= Self.Valor;
      FDQuery.Params.ParamByName('VENCIMENTO').AsDate:= Self.Vencimento;
      FDQuery.Params.ParamByName('SITUACAO').AsString:= Self.Situacao;
      if (Self.Situacao = 'A') then
      begin
        FDQuery.Params.ParamByName('DESCONTOS_TAXAS').AsFMTBCD:= 0;
        FDQuery.Params.ParamByName('JUROS_MULTA').AsFMTBCD:= 0;
        FDQuery.Params.ParamByName('VALOR_PAGO').AsFMTBCD:= 0;
      end
      else
      begin
        FDQuery.Params.ParamByName('DESCONTOS_TAXAS').AsFMTBCD:= Self.DescontosTaxas;
        FDQuery.Params.ParamByName('JUROS_MULTA').AsFMTBCD:= Self.JurosMulta;
        FDQuery.Params.ParamByName('VALOR_PAGO').AsFMTBCD:=
          (Self.Valor - Self.DescontosTaxas + Self.JurosMulta);
        FDQuery.Params.ParamByName('PAGAMENTO').AsDate:= Self.Pagamento;
      end;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('falha ao inserir o pagamento. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TPagamento.update: Boolean;
const
  FSql: string =
  'UPDATE PAGAMENTOS                       ' +
  'SET CONTA_ID = :CONTA_ID,               ' +
  '    PESSOA_ID = :PESSOA_ID,             ' +
  '    CATEGORIA_ID = :CATEGORIA_ID,       ' +
  '    COMPRA_ID = :COMPRA_ID,             ' +
  '    REFERENCIA = :REFERENCIA,           ' +
  '    DESCRICAO = :DESCRICAO,             ' +
  '    COMPETENCIA = :COMPETENCIA,         ' +
  '    VALOR = :VALOR,                     ' +
  '    DESCONTOS_TAXAS = :DESCONTOS_TAXAS, ' +
  '    JUROS_MULTA = :JUROS_MULTA,         ' +
  '    VALOR_PAGO = :VALOR_PAGO,           ' +
  '    VENCIMENTO = :VENCIMENTO,           ' +
  '    PAGAMENTO = :PAGAMENTO,             ' +
  '    SITUACAO = :SITUACAO,               ' +
  '    UPDATED_AT = :UPDATED_AT,           ' +
  '    SYNCHRONIZED = :SYNCHRONIZED        ' +
  'WHERE (ID = :ID)                        ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CONTA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PESSOA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CATEGORIA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('COMPRA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('DESCRICAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('COMPETENCIA').DataType:= ftDate;
      FDQuery.Params.ParamByName('VALOR').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('DESCONTOS_TAXAS').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('JUROS_MULTA').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VALOR_PAGO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('VENCIMENTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('PAGAMENTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('SITUACAO').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.ContaId <> EmptyStr) then
        FDQuery.Params.ParamByName('CONTA_ID').AsString:= Self.ContaId;
      if (Self.PessoaId <> EmptyStr) then
        FDQuery.Params.ParamByName('PESSOA_ID').AsString:= Self.PessoaId;
      if (Self.CategoriaId <> EmptyStr) then
        FDQuery.Params.ParamByName('CATEGORIA_ID').AsString:= Self.CategoriaId;
      if (Self.CompraId <> EmptyStr) then
        FDQuery.Params.ParamByName('COMPRA_ID').AsString:= Self.CompraId;
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= Self.Referencia;
      if (Self.Descricao <> EmptyStr) then
        FDQuery.Params.ParamByName('DESCRICAO').AsString:= Self.Descricao;
      FDQuery.Params.ParamByName('COMPETENCIA').AsDate:= Self.Competencia;
      FDQuery.Params.ParamByName('VALOR').AsFMTBCD:= Self.Valor;
      FDQuery.Params.ParamByName('VENCIMENTO').AsDate:= Self.Vencimento;
      FDQuery.Params.ParamByName('SITUACAO').AsString:= Self.Situacao;
      if (Self.Situacao = 'A') then
      begin
        FDQuery.Params.ParamByName('DESCONTOS_TAXAS').AsFMTBCD:= 0;
        FDQuery.Params.ParamByName('JUROS_MULTA').AsFMTBCD:= 0;
        FDQuery.Params.ParamByName('VALOR_PAGO').AsFMTBCD:= 0;
      end
      else
      begin
        FDQuery.Params.ParamByName('DESCONTOS_TAXAS').AsFMTBCD:= Self.DescontosTaxas;
        FDQuery.Params.ParamByName('JUROS_MULTA').AsFMTBCD:= Self.JurosMulta;
        FDQuery.Params.ParamByName('VALOR_PAGO').AsFMTBCD:=
          (Self.Valor - Self.DescontosTaxas + Self.JurosMulta);
        FDQuery.Params.ParamByName('PAGAMENTO').AsDate:= Self.Pagamento;
      end;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('falha ao atualizar o pagamento. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TPagamento.validate(vtype: integer): Boolean;
begin
  Result:= True;
end;

class procedure TPagamento.list(pFiltro,
                                pSituacao: Integer;
                                pDtInicial,
                                pDtFinal: TDate;
                                pContaId,
                                pCategoriaId,
                                pPessoaId,
                                pSearch: string;
                                DataSet: TFDMemTable);
var
  vList: TObjectList<TPagamento>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  vList:= TPagamento.list(pFiltro,
                          pSituacao,
                          pDtInicial,
                          pDtFinal,
                          pContaId,
                          pCategoriaId,
                          pPessoaId,
                          pSearch);

  if Assigned(vList) then
  begin
    for I := 0 to Pred(vList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= vList.Items[I].Id;
      DataSet.FieldByName('CATEGORIA').AsString:= vList.Items[I].Categoria.Nome;
      DataSet.FieldByName('DESCRICAO').AsString:= vList.Items[I].Descricao;
      DataSet.FieldByName('PESSOA').AsString:= vList.Items[I].Pessoa.Nome;
      DataSet.FieldByName('SITUACAO').AsString:= vList.Items[I].Situacao;
      case pFiltro of
        0: begin
          if (vList.Items[I].Situacao = 'A') then
            DataSet.FieldByName('DATA').AsDateTime:= vList.Items[I].Vencimento
          else
            DataSet.FieldByName('DATA').AsDateTime:= vList.Items[I].Pagamento;
        end;
        1: DataSet.FieldByName('DATA').AsDateTime:= vList.Items[I].Competencia;
        2: DataSet.FieldByName('DATA').AsDateTime:= vList.Items[I].Vencimento;
        3: DataSet.FieldByName('DATA').AsDateTime:= vList.Items[I].Pagamento;
      end;
      if (vList.Items[I].Situacao = 'A') then
        DataSet.FieldByName('VALOR').AsExtended:= vList.Items[I].Valor
      else
        DataSet.FieldByName('VALOR').AsExtended:= vList.Items[I].ValorPago;
      DataSet.Post;
    end;
    FreeAndNil(vList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

end.
