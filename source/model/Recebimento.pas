unit Recebimento;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  Conta, Pessoa, Categoria, System.StrUtils, Cartao;

type
  TRecebimento = class(TModel)
  private
    FEMPRESA_ID: String;
    FCONTA_ID: String;
    FPESSOA_ID: String;
    FCATEGORIA_ID: String;
    FVENDA_ID: String;
    FCARTAO_ID: String;
    FMODALIDADE: String;
    FPARCELA: Integer;
    FQTDE_PARCELAS: Integer;
    FREFERENCIA: Integer;
    FDESCRICAO: String;
    FCOMPETENCIA: TDateTime;
    FVALOR: Extended;
    FDESCONTOS_TAXAS: Extended;
    FJUROS_MULTA: Extended;
    FVALOR_RECEBIDO: Extended;
    FVENCIMENTO: TDateTime;
    FRECEBIMENTO: TDateTime;
    FSITUACAO: String;
    FBOLETO: String;
    FEMAIL: String;

    FCONTA: TConta;
    FPESSOA: TPessoa;
    FCATEGORIA: TCategoria;
    FCARTAO: TCartao;

    function getConta: TConta;
    function getPessoa: TPessoa;
    function getCategoria: TCategoria;
    function getCartao: TCartao;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    function delete(): Boolean;
    function validate(vtype: integer = 0): Boolean;
    class function find(id: string): TRecebimento;
    class function list(pFiltro,
                        pSituacao,
                        pBoleto: Integer;
                        pDtInicial,
                        pDtFinal: TDate;
                        pContaId,
                        pCategoriaId,
                        pPessoaId,
                        pSearch: string): TObjectList<TRecebimento>; overload;
    class procedure list(pFiltro,
                         pSituacao,
                         pBoleto: Integer;
                         pDtInicial,
                         pDtFinal: TDate;
                         pContaId,
                         pCategoriaId,
                         pPessoaId,
                         pSearch: string;
                         DataSet: TFDMemTable); overload;
    class function remove(id: string): Boolean;
    class procedure imprimir(pFiltro,
                             pSituacao,
                             pBoleto: Integer;
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
    property VendaId: String  read FVENDA_ID write FVENDA_ID;
    property CartaoId: String  read FCARTAO_ID write FCARTAO_ID;
    property Modalidade: String  read FMODALIDADE write FMODALIDADE;
    property Parcela: Integer  read FPARCELA write FPARCELA;
    property QtdeParcelas: Integer  read FQTDE_PARCELAS write FQTDE_PARCELAS;
    property Referencia: Integer  read FREFERENCIA write FREFERENCIA;
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    property Competencia: TDateTime  read FCOMPETENCIA write FCOMPETENCIA;
    property Valor: Extended  read FVALOR write FVALOR;
    property DescontosTaxas: Extended  read FDESCONTOS_TAXAS write FDESCONTOS_TAXAS;
    property JurosMulta: Extended  read FJUROS_MULTA write FJUROS_MULTA;
    property ValorRecebido: Extended  read FVALOR_RECEBIDO write FVALOR_RECEBIDO;
    property Vencimento: TDateTime  read FVENCIMENTO write FVENCIMENTO;
    property Recebimento: TDateTime  read FRECEBIMENTO write FRECEBIMENTO;
    property Situacao: String  read FSITUACAO write FSITUACAO;
    property Boleto: String  read FBOLETO write FBOLETO;
    property Email: String  read FEMAIL write FEMAIL;

    property Conta: TConta read getConta;
    property Pessoa: TPessoa read getPessoa;
    property Categoria: TCategoria read getCategoria;
    property Cartao: TCartao read getCartao;
  end;

implementation

uses
  AuthService, Helper, uformPrint, Empresa;

{ TRecebimento }

constructor TRecebimento.Create;
begin
  Self.Table:= 'RECEBIMENTOS';
end;

function TRecebimento.delete: Boolean;
const
  FSql: string =
  'UPDATE RECEBIMENTOS              ' +
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
        raise Exception.Create('Falha ao remover o recebimento. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

destructor TRecebimento.Destroy;
begin
  if Assigned(FCONTA) then FreeAndNil(FCONTA);
  if Assigned(FPESSOA) then FreeAndNil(FPESSOA);
  if Assigned(FCATEGORIA) then FreeAndNil(FCATEGORIA);
  if Assigned(FCARTAO) then FreeAndNil(FCARTAO);

  inherited;
end;

class function TRecebimento.find(id: string): TRecebimento;
const
  FSql: string = 'SELECT * FROM RECEBIMENTOS WHERE (ID = :ID)';
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
        Result:= TRecebimento.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.ContaId:= FDQuery.FieldByName('CONTA_ID').AsString;
        Result.PessoaId:= FDQuery.FieldByName('PESSOA_ID').AsString;
        Result.CategoriaId:= FDQuery.FieldByName('CATEGORIA_ID').AsString;
        Result.VendaId:= FDQuery.FieldByName('VENDA_ID').AsString;
        Result.CartaoId:= FDQuery.FieldByName('CARTAO_ID').AsString;
        Result.Modalidade:= FDQuery.FieldByName('MODALIDADE').AsString;
        Result.Parcela:= FDQuery.FieldByName('PARCELA').AsInteger;
        Result.QtdeParcelas:= FDQuery.FieldByName('QTDE_PARCELAS').AsInteger;
        Result.Referencia:= FDQuery.FieldByName('REFERENCIA').AsInteger;
        Result.Descricao:= FDQuery.FieldByName('DESCRICAO').AsString;
        Result.Competencia:= FDQuery.FieldByName('COMPETENCIA').AsDateTime;
        Result.Valor:= FDQuery.FieldByName('VALOR').AsExtended;
        Result.JurosMulta:= FDQuery.FieldByName('JUROS_MULTA').AsExtended;
        Result.DescontosTaxas:= FDQuery.FieldByName('DESCONTOS_TAXAS').AsExtended;
        Result.ValorRecebido:= FDQuery.FieldByName('VALOR_RECEBIDO').AsExtended;
        Result.Vencimento:= FDQuery.FieldByName('VENCIMENTO').AsDateTime;
        Result.Recebimento:= FDQuery.FieldByName('RECEBIMENTO').AsDateTime;
        Result.Situacao:= FDQuery.FieldByName('SITUACAO').AsString;
        Result.Boleto:= FDQuery.FieldByName('BOLETO').AsString;
        Result.Email:= FDQuery.FieldByName('EMAIL').AsString;
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

function TRecebimento.getCartao: TCartao;
begin
  if not Assigned(Self.FCARTAO) then
    Self.FCARTAO:= TCartao.find(Self.CartaoId);

  Result:= Self.FCARTAO;
end;

function TRecebimento.getCategoria: TCategoria;
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

function TRecebimento.getConta: TConta;
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

function TRecebimento.getPessoa: TPessoa;
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

class procedure TRecebimento.imprimir(pFiltro,
                                      pSituacao,
                                      pBoleto: Integer;
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
  vTotalRecebidas,
  vTotalReceber,
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
      vDt.FieldDefs.Add('BOLETO', ftString, 255);
      vDt.FieldDefs.Add('SELECIONADO', ftString, 1);
      vDt.FieldDefs.Add('EMAIL', ftString, 1);
      vDt.IndexFieldNames:= 'DATA';

      TRecebimento.list(pFiltro,
                        pSituacao,
                        pBoleto,
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
                THelper.StrEsquerda('RECEBIMENTOS',18) +
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
        1: Print.Add('H|' + 'STATUS          : A RECEBER');
        2: Print.Add('H|' + 'STATUS          : RECEBIDO');
      end;

      case pBoleto of
        1: Print.Add('H|' + 'BOLETO          : SEM BOLETO');
        2: Print.Add('H|' + 'BOLETO          : COM BOLETO');
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

      vTotalRecebidas:= 0;
      vTotalReceber:= 0;
      vTotalVencidas:= 0;
      vTotal:= 0;
      while not vDt.Eof do
      begin
        vTotal:= (vTotal + vDt.FieldByName('VALOR').AsExtended);
        if (vDt.FieldByName('SITUACAO').AsString = 'F') then
          vTotalRecebidas:= (vTotalRecebidas + vDt.FieldByName('VALOR').AsExtended)
        else
        begin
          vTotalReceber:= (vTotalReceber + vDt.FieldByName('VALOR').AsExtended);
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
      Print.Add('F|' + THelper.StrEsquerda('RECEBIDAS (R$)', 44) +
        THelper.StrDireita(THelper.ExtendedToString(vTotalRecebidas), 44));
      Print.Add('F|' + THelper.StrEsquerda('A RECEBER (R$)', 44) +
        THelper.StrDireita(THelper.ExtendedToString(vTotalReceber), 44));
      Print.Add('F|' + THelper.StrEsquerda('VENCIDAS (R$)', 44) +
        THelper.StrDireita(THelper.ExtendedToString(vTotalVencidas), 44));
      Print.Add('F|' + THelper.StrEsquerda('TOTAL DE RECEBIMENTOS (R$)', 44) +
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

class function TRecebimento.list(pFiltro,
                                 pSituacao,
                                 pBoleto: Integer;
                                 pDtInicial,
                                 pDtFinal: TDate;
                                 pContaId,
                                 pCategoriaId,
                                 pPessoaId,
                                 pSearch: string): TObjectList<TRecebimento>;
var
  FSql: string;
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FSql:=
      'SELECT R.ID FROM RECEBIMENTOS R ' +
      'JOIN CATEGORIAS C ON(C.ID = R.CATEGORIA_ID) ' +
      'JOIN CONTAS CT ON(CT.ID = R.CONTA_ID) ' +
      'JOIN PESSOAS P ON(P.ID = R.PESSOA_ID) ' +
      'WHERE (R.EMPRESA_ID = :EMPRESA_ID) AND (R.DELETED_AT IS NULL) ';

      case pFiltro of
        1: FSql:= FSql + 'AND (R.COMPETENCIA BETWEEN :DTINICIAL AND :DTFINAL) ';
        2: FSql:= FSql + 'AND (R.VENCIMENTO BETWEEN :DTINICIAL AND :DTFINAL) ';
        3: FSql:= FSql + 'AND (R.RECEBIMENTO BETWEEN :DTINICIAL AND :DTFINAL) ';
      end;

      if (pSituacao in[1,2]) then
        FSql:= FSql + 'AND (R.SITUACAO = :SITUACAO) ';

      case pBoleto of
        1: FSql:= FSql + 'AND (R.BOLETO IS NULL) ';
        2: FSql:= FSql + 'AND (R.BOLETO IS NOT NULL) ';
      end;

      if (pContaId <> '') then
        FSql:= FSql + 'AND (R.CONTA_ID = :CONTA_ID) ';

      if (pCategoriaId <> '') then
        FSql:= FSql + 'AND (R.CATEGORIA_ID = :CATEGORIA_ID) ';

      if (pPessoaId <> '') then
        FSql:= FSql + 'AND (R.PESSOA_ID = :PESSOA_ID) ';

      FSql:= FSql + 'AND ((R.DESCRICAO LIKE :DESCRICAO) OR (R.BOLETO = :BOLETO)) ';
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
      FDQuery.Params.ParamByName('BOLETO').DataType:= ftString;
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
      FDQuery.Params.ParamByName('BOLETO').AsString:= pSearch;
      FDQuery.Open();

      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TRecebimento>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TRecebimento.find(FDQuery.FieldByName('ID').AsString));
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

class function TRecebimento.remove(id: string): Boolean;
var
  Recebimento: TRecebimento;
begin
  Result:= False;
  Recebimento:= TRecebimento.find(id);
  if not Assigned(Recebimento) then
  begin
    THelper.Mensagem('Recebimento não encontrado. O recebimento pode ter sido previamente removido por outro usuário!');
    Exit();
  end;

  try
    if (Recebimento.VendaId <> EmptyStr) then
    begin
      THelper.Mensagem('Não é possivel remover lançamentos de compra ou venda. Remova a compra ou venda para excluir os lançamentos financeiros!');
      Exit();
    end
    else if (Recebimento.Boleto <> EmptyStr) then
    begin
      THelper.Mensagem('Não é possivel remover lançamentos com boleto vinculado. Remova o boleto para excluir o lançamento!');
      Exit();
    end
    else
    begin
      if not THelper.Mensagem('Deseja realmente remover?', 1) then
        Exit();
    end;

    Result:= Recebimento.delete();
  finally
    FreeAndNil(Recebimento);
  end;
end;

function TRecebimento.save: Boolean;
begin
  Result:= inherited;
end;

function TRecebimento.store: Boolean;
const
  FSql: string =
  'INSERT INTO RECEBIMENTOS (' +
  '  ID,                     ' +
  '  EMPRESA_ID,             ' +
  '  CONTA_ID,               ' +
  '  PESSOA_ID,              ' +
  '  CATEGORIA_ID,           ' +
  '  VENDA_ID,               ' +
  '  CARTAO_ID,              ' +
  '  MODALIDADE,             ' +
  '  PARCELA,                ' +
  '  QTDE_PARCELAS,          ' +
  '  REFERENCIA,             ' +
  '  DESCRICAO,              ' +
  '  COMPETENCIA,            ' +
  '  VALOR,                  ' +
  '  DESCONTOS_TAXAS,        ' +
  '  JUROS_MULTA,            ' +
  '  VALOR_RECEBIDO,         ' +
  '  VENCIMENTO,             ' +
  '  RECEBIMENTO,            ' +
  '  SITUACAO,               ' +
  '  CREATED_AT,             ' +
  '  UPDATED_AT)             ' +
  'VALUES (                  ' +
  '  :ID,                    ' +
  '  :EMPRESA_ID,            ' +
  '  :CONTA_ID,              ' +
  '  :PESSOA_ID,             ' +
  '  :CATEGORIA_ID,          ' +
  '  :VENDA_ID,              ' +
  '  :CARTAO_ID,             ' +
  '  :MODALIDADE,            ' +
  '  :PARCELA,               ' +
  '  :QTDE_PARCELAS,         ' +
  '  :REFERENCIA,            ' +
  '  :DESCRICAO,             ' +
  '  :COMPETENCIA,           ' +
  '  :VALOR,                 ' +
  '  :DESCONTOS_TAXAS,       ' +
  '  :JUROS_MULTA,           ' +
  '  :VALOR_RECEBIDO,        ' +
  '  :VENCIMENTO,            ' +
  '  :RECEBIMENTO,           ' +
  '  :SITUACAO,              ' +
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
      FDQuery.Params.ParamByName('CONTA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('PESSOA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('CATEGORIA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('VENDA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('CARTAO_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('MODALIDADE').DataType:= ftString;
      FDQuery.Params.ParamByName('PARCELA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('QTDE_PARCELAS').DataType:= ftInteger;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('DESCRICAO').DataType:= ftString;
      FDQuery.Params.ParamByName('COMPETENCIA').DataType:= ftDate;
      FDQuery.Params.ParamByName('VALOR').DataType:= ftExtended;
      FDQuery.Params.ParamByName('DESCONTOS_TAXAS').DataType:= ftExtended;
      FDQuery.Params.ParamByName('JUROS_MULTA').DataType:= ftExtended;
      FDQuery.Params.ParamByName('VALOR_RECEBIDO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('VENCIMENTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('RECEBIMENTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('SITUACAO').DataType:= ftString;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
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
      if (Self.VendaId <> EmptyStr) then
      FDQuery.Params.ParamByName('VENDA_ID').AsString:= Self.VendaId;
      if (Self.CartaoId <> EmptyStr) then
      FDQuery.Params.ParamByName('CARTAO_ID').AsString:= Self.CartaoId;
      if (Self.Modalidade <> EmptyStr) then
      FDQuery.Params.ParamByName('MODALIDADE').AsString:= Self.Modalidade;
      if (Self.Parcela >= 1) then
      FDQuery.Params.ParamByName('PARCELA').AsInteger:= Self.Parcela;
      if (Self.QtdeParcelas >= 1) then
      FDQuery.Params.ParamByName('QTDE_PARCELAS').AsInteger:= Self.QtdeParcelas;
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= Self.Referencia;
      if (Self.Descricao <> EmptyStr) then
      FDQuery.Params.ParamByName('DESCRICAO').AsString:= Self.Descricao;
      FDQuery.Params.ParamByName('COMPETENCIA').AsDate:= Self.Competencia;
      FDQuery.Params.ParamByName('VALOR').AsExtended:= Self.Valor;
      FDQuery.Params.ParamByName('VENCIMENTO').AsDate:= Self.Vencimento;
      FDQuery.Params.ParamByName('SITUACAO').AsString:= Self.Situacao;
      if (Self.Situacao = 'A') then
      begin
        FDQuery.Params.ParamByName('DESCONTOS_TAXAS').AsExtended:= 0;
        FDQuery.Params.ParamByName('JUROS_MULTA').AsExtended:= 0;
        FDQuery.Params.ParamByName('VALOR_RECEBIDO').AsExtended:= 0;
      end
      else
      begin
        FDQuery.Params.ParamByName('DESCONTOS_TAXAS').AsExtended:= Self.DescontosTaxas;
        FDQuery.Params.ParamByName('JUROS_MULTA').AsExtended:= Self.JurosMulta;
        FDQuery.Params.ParamByName('VALOR_RECEBIDO').AsExtended:=
          (Self.Valor - Self.DescontosTaxas + Self.JurosMulta);
        FDQuery.Params.ParamByName('RECEBIMENTO').AsDate:= Self.Recebimento;
      end;
      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao inserir o recebimento. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TRecebimento.update: Boolean;
const
  FSql: string =
  'UPDATE RECEBIMENTOS                    ' +
  'SET CONTA_ID = :CONTA_ID,              ' +
  '    PESSOA_ID = :PESSOA_ID,            ' +
  '    CATEGORIA_ID = :CATEGORIA_ID,      ' +
  '    VENDA_ID = :VENDA_ID,              ' +
  '    DESCRICAO = :DESCRICAO,            ' +
  '    COMPETENCIA = :COMPETENCIA,        ' +
  '    VALOR = :VALOR,                    ' +
  '    DESCONTOS_TAXAS = :DESCONTOS_TAXAS,' +
  '    JUROS_MULTA = :JUROS_MULTA,        ' +
  '    VALOR_RECEBIDO = :VALOR_RECEBIDO,  ' +
  '    VENCIMENTO = :VENCIMENTO,          ' +
  '    RECEBIMENTO = :RECEBIMENTO,        ' +
  '    SITUACAO = :SITUACAO,              ' +
  '    BOLETO = :BOLETO,                  ' +
  '    EMAIL = :EMAIL,                    ' +
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
      FDQuery.Params.ParamByName('CONTA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('PESSOA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('CATEGORIA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('VENDA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('DESCRICAO').DataType:= ftString;
      FDQuery.Params.ParamByName('COMPETENCIA').DataType:= ftDate;
      FDQuery.Params.ParamByName('VALOR').DataType:= ftExtended;
      FDQuery.Params.ParamByName('DESCONTOS_TAXAS').DataType:= ftExtended;
      FDQuery.Params.ParamByName('JUROS_MULTA').DataType:= ftExtended;
      FDQuery.Params.ParamByName('VALOR_RECEBIDO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('VENCIMENTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('RECEBIMENTO').DataType:= ftDate;
      FDQuery.Params.ParamByName('SITUACAO').DataType:= ftString;
      FDQuery.Params.ParamByName('BOLETO').DataType:= ftString;
      FDQuery.Params.ParamByName('EMAIL').DataType:= ftString;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftString;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.ContaId <> EmptyStr) then
      FDQuery.Params.ParamByName('CONTA_ID').AsString:= Self.ContaId;
      if (Self.PessoaId <> EmptyStr) then
      FDQuery.Params.ParamByName('PESSOA_ID').AsString:= Self.PessoaId;
      if (Self.CategoriaId <> EmptyStr) then
      FDQuery.Params.ParamByName('CATEGORIA_ID').AsString:= Self.CategoriaId;
      if (Self.VendaId <> EmptyStr) then
      FDQuery.Params.ParamByName('VENDA_ID').AsString:= Self.VendaId;
      if (Self.Descricao <> EmptyStr) then
      FDQuery.Params.ParamByName('DESCRICAO').AsString:= Self.Descricao;
      FDQuery.Params.ParamByName('COMPETENCIA').AsDate:= Self.Competencia;
      FDQuery.Params.ParamByName('VALOR').AsExtended:= Self.Valor;
      FDQuery.Params.ParamByName('VENCIMENTO').AsDate:= Self.Vencimento;
      FDQuery.Params.ParamByName('SITUACAO').AsString:= Self.Situacao;
      if (Self.Situacao = 'A') then
      begin
        FDQuery.Params.ParamByName('DESCONTOS_TAXAS').AsExtended:= 0;
        FDQuery.Params.ParamByName('JUROS_MULTA').AsExtended:= 0;
        FDQuery.Params.ParamByName('VALOR_RECEBIDO').AsExtended:= 0;
      end
      else
      begin
        FDQuery.Params.ParamByName('DESCONTOS_TAXAS').AsExtended:= Self.DescontosTaxas;
        FDQuery.Params.ParamByName('JUROS_MULTA').AsExtended:= Self.JurosMulta;
        FDQuery.Params.ParamByName('VALOR_RECEBIDO').AsExtended:=
          (Self.Valor - Self.DescontosTaxas + Self.JurosMulta);
        FDQuery.Params.ParamByName('RECEBIMENTO').AsDate:= Self.Recebimento;
      end;
      if (Self.Boleto <> EmptyStr) then
      FDQuery.Params.ParamByName('BOLETO').AsString:= Self.Boleto;
      FDQuery.Params.ParamByName('EMAIL').AsString:= IfThen(Self.Email = '','N', Self.Email);
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao atualizar o recebimento. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TRecebimento.validate(vtype: integer): Boolean;
begin
  Result:= True;
end;

class procedure TRecebimento.list(pFiltro,
                                  pSituacao,
                                  pBoleto: Integer;
                                  pDtInicial,
                                  pDtFinal: TDate;
                                  pContaId,
                                  pCategoriaId,
                                  pPessoaId,
                                  pSearch: string;
                                  DataSet: TFDMemTable);
var
  vList: TObjectList<TRecebimento>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  vList:= TRecebimento.list(pFiltro,
                            pSituacao,
                            pBoleto,
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
      DataSet.FieldByName('BOLETO').AsString:= Trim(vList.Items[I].Boleto);
      DataSet.FieldByName('EMAIL').AsString:= vList.Items[I].Email;
      case pFiltro of
        0: begin
          if (vList.Items[I].Situacao = 'A') then
            DataSet.FieldByName('DATA').AsDateTime:= vList.Items[I].Vencimento
          else
            DataSet.FieldByName('DATA').AsDateTime:= vList.Items[I].Recebimento;
        end;
        1: DataSet.FieldByName('DATA').AsDateTime:= vList.Items[I].Competencia;
        2: DataSet.FieldByName('DATA').AsDateTime:= vList.Items[I].Vencimento;
        3: DataSet.FieldByName('DATA').AsDateTime:= vList.Items[I].Recebimento;
      end;
      if (vList.Items[I].Situacao = 'A') then
        DataSet.FieldByName('VALOR').AsExtended:= vList.Items[I].Valor
      else
        DataSet.FieldByName('VALOR').AsExtended:= vList.Items[I].ValorRecebido;
      DataSet.Post;
    end;
    FreeAndNil(vList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

end.
