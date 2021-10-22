unit Empresa;

interface

uses
  Model, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  Contabilista, NfeConfiguracao, System.StrUtils, ACBrValidador;

type
  TEmpresa = class(TModel)
  private
    FTIPO_PESSOA: String;
    FREFERENCIA: Integer;
    FNOME: String;
    FRAZAO_SOCIAL: String;
    FDOCUMENTO: String;
    FIE: String;
    FIEST: String;
    FIM: String;
    FCNAE: String;
    FCRT: String;
    FCEP: String;
    FLOGRADOURO: String;
    FNUMERO: String;
    FCOMPLEMENTO: String;
    FBAIRRO: String;
    FCODIGO_MUNICIPIO: String;
    FNOME_MUNICIPIO: String;
    FUF: String;
    FFONE: String;
    FCELULAR: String;
    FEMAIL: String;
    FCONTROLE_CONSULTA: TDate;
    FULTIMA_CONSULTA: TDateTime;
    FULTIMO_NSU: Integer;

    FCONTABILISTA: TContabilista;
    FNFECONFIGURACAO: TNfeConfiguracao;

    function getContabilista: TContabilista;
    function getNfeConfiguracao: TNfeConfiguracao;
    function getBairro: String;
    function getComplemento: String;
    procedure getEmail(const Value: String);
    function getLogradouro: String;
    function getNome: String;
    function getNomeMunicipio: String;
    function getRazaoSocial: String;
    procedure setBairro(const Value: String);
    procedure setComplemento(const Value: String);
    function setEmail: String;
    procedure setLogradouro(const Value: String);
    procedure setNome(const Value: String);
    procedure setNomeMunicipio(const Value: String);
    procedure setRazaoSocial(const Value: String);

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    function validate(): Boolean;
    function importarItens: Boolean;
    function importarPessoas(): Boolean;
    procedure unidades();
    procedure categorias();
    class function find(id: string): TEmpresa;
    class function list(search: string): TObjectList<TEmpresa>;

    property TipoPessoa: String  read FTIPO_PESSOA write FTIPO_PESSOA;
    property Referencia: Integer  read FREFERENCIA write FREFERENCIA;
    property Nome: String  read getNome write setNome;
    property RazaoSocial: String  read getRazaoSocial write setRazaoSocial;
    property Documento: String  read FDOCUMENTO write FDOCUMENTO;
    property Ie: String  read FIE write FIE;
    property Iest: String  read FIEST write FIEST;
    property Im: String  read FIM write FIM;
    property Cnae: String  read FCNAE write FCNAE;
    property Crt: String  read FCRT write FCRT;
    property Cep: String  read FCEP write FCEP;
    property Logradouro: String  read getLogradouro write setLogradouro;
    property Numero: String  read FNUMERO write FNUMERO;
    property Complemento: String  read getComplemento write setComplemento;
    property Bairro: String  read getBairro write setBairro;
    property CodigoMunicipio: String  read FCODIGO_MUNICIPIO write FCODIGO_MUNICIPIO;
    property NomeMunicipio: String  read getNomeMunicipio write setNomeMunicipio;
    property Uf: String  read FUF write FUF;
    property Fone: String  read FFONE write FFONE;
    property Celular: String  read FCELULAR write FCELULAR;
    property Email: String  read setEmail write getEmail;
    property ControleConsulta: TDate read FCONTROLE_CONSULTA write FCONTROLE_CONSULTA;
    property UltimaConsulta: TDateTime read FULTIMA_CONSULTA write FULTIMA_CONSULTA;
    property UltimoNsu: Integer read FULTIMO_NSU write FULTIMO_NSU;

    property Contabilista: TContabilista read getContabilista;
    property NfeConfiguracao: TNfeConfiguracao read getNfeConfiguracao;

  end;

implementation

uses
  User, AuthService, Helper, Vcl.Dialogs, System.Classes, Item, Pessoa,
  Unidade, Categoria;

{ TEmpresa }

procedure TEmpresa.categorias;
var
  vCategorias: TStringList;
  vItem: string;
  vCategoria: TCategoria;
  I: Integer;
  vCategoriaId: string;
begin
  vCategorias:= TStringList.Create;
  vCategorias.Add('OUTRAS RECEITAS|R|');
  vCategorias.Add(' AJUSTE CAIXA|R|');
  vCategorias.Add(' DEVOLUÇÃO DE ADIANTAMENTO|R|');
  vCategorias.Add('RECEITAS DE VENDAS|R|');
  vCategorias.Add(' VENDAS|R|');
  vCategorias.Add('RECEITAS FINANCEIRAS|R|');
  vCategorias.Add(' APLICAÇÕES FINANCEIRAS|R|');
  vCategorias.Add('DESPESAS ADMINISTRATIVAS E COMERCIAIS|D|');
  vCategorias.Add(' ÁGUA|D|');
  vCategorias.Add(' ALUGUEL|D|');
  vCategorias.Add(' ASSESSORIAS E ASSOCIAÇÕES|D|');
  vCategorias.Add(' CARTÓRIO|D|');
  vCategorias.Add(' COMBUSTÍVEL E TRANSLADOS|D|');
  vCategorias.Add(' CONFRATERNIZAÇÕES|D|');
  vCategorias.Add(' CONTABILIDADE|D|');
  vCategorias.Add(' CORREIOS|D|');
  vCategorias.Add(' CURSOS E TREINAMENTOS|D|');
  vCategorias.Add(' DISTRIBUIÇÃO DE LUCROS|D|');
  vCategorias.Add(' EMPRÉSTIMOS|D|');
  vCategorias.Add(' ENCARGOS - RESCISÕES TRABALHISTAS|D|');
  vCategorias.Add(' ENCARGOS FUNCIONÁRIOS - 13O SALÁRIO|D|');
  vCategorias.Add(' ENCARGOS FUNCIONÁRIOS - ALIMENTAÇÃO|D|');
  vCategorias.Add(' ENCARGOS FUNCIONÁRIOS - ASSIST. MÉDICA E ODONTOL.|D|');
  vCategorias.Add(' ENCARGOS FUNCIONÁRIOS - EXAMES PRÉ E DEMISSIONAIS|D|');
  vCategorias.Add(' ENCARGOS FUNCIONÁRIOS - FGTS|D|');
  vCategorias.Add(' ENCARGOS FUNCIONÁRIOS - HORAS EXTRAS|D|');
  vCategorias.Add(' ENCARGOS FUNCIONÁRIOS - INSS|D|');
  vCategorias.Add(' ENCARGOS FUNCIONÁRIOS - VALE TRANSPORTE|D|');
  vCategorias.Add(' ENERGIA ELÉTRICA|D|');
  vCategorias.Add(' IMPOSTOS - ALVARÁ|D|');
  vCategorias.Add(' IMPOSTOS - COLETA DE LIXO|D|');
  vCategorias.Add(' IMPOSTOS - IPTU|D|');
  vCategorias.Add(' IMPOSTOS - PIS|D|');
  vCategorias.Add(' INTERNET|D|');
  vCategorias.Add(' LICENÇA OU ALUGUEL DE SOFTWARES|D|');
  vCategorias.Add(' LIMPEZA|D|');
  vCategorias.Add(' MANUTENÇÃO EQUIPAMENTOS|D|');
  vCategorias.Add(' MARKETING E PUBLICIDADE|D|');
  vCategorias.Add(' MATERIAL DE ESCRITÓRIO|D|');
  vCategorias.Add(' MATERIAL REFORMA|D|');
  vCategorias.Add(' REMUNERAÇÃO FUNCIONÁRIOS|D|');
  vCategorias.Add(' SEGURANÇA|D|');
  vCategorias.Add(' SUPERMERCADO|D|');
  vCategorias.Add(' TELEFONIA|D|');
  vCategorias.Add(' TRANSPORTADORA|D|');
  vCategorias.Add(' VIAGENS|D|');
  vCategorias.Add('DESPESAS DE PRODUTOS VENDIDOS|D|');
  vCategorias.Add(' COMISSÃO VENDEDORES|D|');
  vCategorias.Add(' FORNECEDOR|D|');
  vCategorias.Add(' IMPOSTOS - COFINS|D|');
  vCategorias.Add(' IMPOSTOS - CSSL|D|');
  vCategorias.Add(' IMPOSTOS - ICMS|D|');
  vCategorias.Add(' IMPOSTOS - IMPORTAÇÃO IPI|D|');
  vCategorias.Add(' IMPOSTOS – IRPJ|D|');
  vCategorias.Add(' IMPOSTOS – ISS|D|');
  vCategorias.Add('DESPESAS FINANCEIRAS|D|');
  vCategorias.Add(' DESPESAS BANCÁRIAS|D|');
  vCategorias.Add('INVESTIMENTOS|D|');
  vCategorias.Add(' AQUISIÇÃO DE EQUIPAMENTOS|D|');
  vCategorias.Add('OUTRAS DESPESAS|D|');
  vCategorias.Add(' ADIANTAMENTO – FUNCIONÁRIOS|D|');
  vCategorias.Add(' AJUSTE CAIXA|D|');

  vCategoriaId:= '';
  for I:= 0 to Pred(vCategorias.Count) do
  begin
    vItem:= vCategorias[I];
    if (vItem[1] <> ' ') then
      vCategoriaId:= '';

    vItem:= Trim(vItem);
    vCategoria:= TCategoria.Create;
    vCategoria.EmpresaId:= Self.Id;
    vCategoria.CategoriaId:= vCategoriaId;
    vCategoria.Nome:= THelper.DevolveConteudoDelimitado('|',vItem);
    vCategoria.Tipo:= THelper.DevolveConteudoDelimitado('|',vItem);
    vCategoria.save();

    if (vCategoriaId = '') then
      vCategoriaId:= vCategoria.Id;

    FreeAndNil(vCategoria);
  end;
  FreeAndNil(vCategorias);
end;

constructor TEmpresa.Create;
begin
  Self.Table:= 'EMPRESAS';
  FreeAndNil(Self.FCONTABILISTA);
end;

destructor TEmpresa.Destroy;
begin
  if Assigned(Self.FCONTABILISTA) then FreeAndNil(Self.FCONTABILISTA);
  if Assigned(Self.FNFECONFIGURACAO) then FreeAndNil(Self.FNFECONFIGURACAO);
end;

class function TEmpresa.find(id: string): TEmpresa;
const
  FSql: string = 'SELECT * FROM EMPRESAS WHERE (ID = :ID)';
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
        Result:= TEmpresa.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.TipoPessoa:= FDQuery.FieldByName('TIPO_PESSOA').AsString;
        Result.Referencia:= FDQuery.FieldByName('REFERENCIA').AsInteger;
        Result.Nome:= FDQuery.FieldByName('NOME').AsString;
        Result.RazaoSocial:= FDQuery.FieldByName('RAZAO_SOCIAL').AsString;
        Result.Documento:= FDQuery.FieldByName('DOCUMENTO').AsString;
        Result.Ie:= FDQuery.FieldByName('IE').AsString;
        Result.Iest:= FDQuery.FieldByName('IEST').AsString;
        Result.Im:= FDQuery.FieldByName('IM').AsString;
        Result.Cnae:= FDQuery.FieldByName('CNAE').AsString;
        Result.Crt:= FDQuery.FieldByName('CRT').AsString;
        Result.Cep:= FDQuery.FieldByName('CEP').AsString;
        Result.Logradouro:= FDQuery.FieldByName('LOGRADOURO').AsString;
        Result.Numero:= FDQuery.FieldByName('NUMERO').AsString;
        Result.Complemento:= FDQuery.FieldByName('COMPLEMENTO').AsString;
        Result.Bairro:= FDQuery.FieldByName('BAIRRO').AsString;
        Result.CodigoMunicipio:= FDQuery.FieldByName('CODIGO_MUNICIPIO').AsString;
        Result.NomeMunicipio:= FDQuery.FieldByName('NOME_MUNICIPIO').AsString;
        Result.Uf:= FDQuery.FieldByName('UF').AsString;
        Result.Fone:= FDQuery.FieldByName('FONE').AsString;
        Result.Celular:= FDQuery.FieldByName('CELULAR').AsString;
        Result.Email:= FDQuery.FieldByName('EMAIL').AsString;
        Result.ControleConsulta:= FDQuery.FieldByName('CONTROLE_CONSULTA').AsDateTime;
        Result.UltimaConsulta:= FDQuery.FieldByName('ULTIMA_CONSULTA').AsDateTime;
        Result.UltimoNsu:= FDQuery.FieldByName('ULTIMO_NSU').AsInteger;
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

function TEmpresa.getBairro: String;
begin
  Result:= THelper.RemoveAcentos(FBAIRRO);
end;

function TEmpresa.getComplemento: String;
begin
  Result:= THelper.RemoveAcentos(FCOMPLEMENTO);
end;

function TEmpresa.getContabilista: TContabilista;
const
  FSql: string =
  'SELECT FIRST 1 ID FROM CONTABILISTAS ' +
  'WHERE EMPRESA_ID = :EMPRESA_ID';
var
  FDQuery: TFDQuery;
begin
  if not Assigned(Self.FCONTABILISTA) then
  begin
    try
      try
        FDQuery:= TModel.createQuery;
        FDQuery.SQL.Add(FSql);
        FDQuery.Prepare;
        FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
        FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.Id;
        FDQuery.Open();
        if FDQuery.RecordCount = 0 then Self.FCONTABILISTA:= nil
        else Self.FCONTABILISTA:= TContabilista.find(FDQuery.FieldByName('ID').AsString);
      except
        Self.FCONTABILISTA:= nil;
      end;
    finally
      FreeAndNil(FDQuery);
    end;
  end;
  Result:= Self.FCONTABILISTA;
end;

procedure TEmpresa.getEmail(const Value: String);
begin
  FEMAIL:= THelper.RemoveAcentos(Value);
end;

function TEmpresa.getLogradouro: String;
begin
  Result:= THelper.RemoveAcentos(FLOGRADOURO);
end;

function TEmpresa.getNfeConfiguracao: TNfeConfiguracao;
const
  FSql: string =
  'SELECT FIRST 1 ID FROM NFE_CONFIGURACOES ' +
  'WHERE EMPRESA_ID = :EMPRESA_ID';
var
  FDQuery: TFDQuery;
begin
  if not Assigned(Self.FNFECONFIGURACAO) then
  begin
    try
      try
        FDQuery:= Self.createQuery;
        FDQuery.SQL.Add(FSql);
        FDQuery.Prepare;
        FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
        FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.Id;
        FDQuery.Open();
        if FDQuery.RecordCount = 0 then Self.FNFECONFIGURACAO:= nil
        else Self.FNFECONFIGURACAO:= TNfeConfiguracao.find(FDQuery.FieldByName('ID').AsString);
      except
        Self.FNFECONFIGURACAO:= nil;
      end;
    finally
      FreeAndNil(FDQuery);
    end;
  end;
  Result:= Self.FNFECONFIGURACAO;
end;

function TEmpresa.getNome: String;
begin
  Result:= THelper.RemoveAcentos(FNOME);
end;

function TEmpresa.getNomeMunicipio: String;
begin
  Result:= THelper.RemoveAcentos(FNOME_MUNICIPIO);
end;

function TEmpresa.getRazaoSocial: String;
begin
  Result:= THelper.RemoveAcentos(FRAZAO_SOCIAL);
end;

function TEmpresa.importarItens: Boolean;
var
  v_open: TOpenDialog;
  v_linha: string;
  v_arquivo: TStringList;
  v_item: TItem;
  I: Integer;
begin
  Result:= True;
  try
    try
      v_open:= TOpenDialog.Create(nil);
      v_arquivo:= TStringList.Create;
      v_item:= TItem.Create;

      if v_open.Execute then
      begin
        Self.StartTransaction();
        v_arquivo.LoadFromFile(v_open.FileName);
        for I:= 0 to Pred(v_arquivo.Count) do
        begin
          v_linha:= v_arquivo[I];

          v_item.Id:= '';
          v_item.EmpresaId:= '';
          v_item.GrupoTributarioId:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_item.Referencia:= StrToIntDef(THelper.DevolveConteudoDelimitado('|', v_linha), 0);
          v_item.Ean:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_item.Nome:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_item.Ncm:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_item.Extipi:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_item.UnidadeId:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_item.EanTributavel:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_item.UnidadeTributavelId:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_item.TipoItem:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_item.CodigoGenero:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_item.CodigoServico:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_item.AliquotaIcms:= StrToFloatDef(THelper.DevolveConteudoDelimitado('|', v_linha), 0);
          v_item.Cest:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_item.PrecoCompra:= StrToFloatDef(THelper.DevolveConteudoDelimitado('|', v_linha), 0);
          v_item.PrecoVenda:= StrToFloatDef(THelper.DevolveConteudoDelimitado('|', v_linha), 0);
          v_item.EstoqueDisponivel:= StrToFloatDef(THelper.DevolveConteudoDelimitado('|', v_linha), 0);
          v_item.EstoqueMinimo:= StrToFloatDef(THelper.DevolveConteudoDelimitado('|', v_linha), 0);
          v_item.EstoqueIdeal:= StrToFloatDef(THelper.DevolveConteudoDelimitado('|', v_linha), 0);
          v_item.EstoqueMaximo:= StrToFloatDef(THelper.DevolveConteudoDelimitado('|', v_linha), 0);
          v_item.Synchronized:= '';

          v_item.save();
        end;

        Self.Commit();
      end;
    except on e: exception do
      begin
        Self.Rollback();
        Result:= False;
        THelper.Mensagem('Falha ao importar itens. erro: ' + e.Message);
      end;
    end;
  finally
    if Assigned(v_open) then FreeAndNil(v_open);
    if Assigned(v_arquivo) then FreeAndNil(v_arquivo);
    if Assigned(v_item) then FreeAndNil(v_item);
  end;
end;

function TEmpresa.importarPessoas: Boolean;
var
  v_open: TOpenDialog;
  v_linha: string;
  v_arquivo: TStringList;
  v_pessoa: TPessoa;
  I: Integer;
begin
  Result:= True;
  try
    try
      v_open:= TOpenDialog.Create(nil);
      v_arquivo:= TStringList.Create;
      v_pessoa:= TPessoa.Create;

      if v_open.Execute then
      begin
        Self.StartTransaction();
        v_arquivo.LoadFromFile(v_open.FileName);
        for I:= 0 to Pred(v_arquivo.Count) do
        begin
          v_linha:= v_arquivo[I];

          v_pessoa.Id:= '';
          v_pessoa.EmpresaId:= '';
          v_pessoa.TipoPessoa:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_pessoa.Referencia:= StrToIntDef(THelper.DevolveConteudoDelimitado('|', v_linha), 0);
          v_pessoa.Nome:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_pessoa.RazaoSocial:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_pessoa.Documento:= THelper.ReturnsInteger(THelper.DevolveConteudoDelimitado('|', v_linha));
          v_pessoa.Idestrangeiro:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_pessoa.Im:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_pessoa.Isuf:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_pessoa.Simples:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_pessoa.Indiedest:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_pessoa.Ie:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_pessoa.DataFundacaoNascimento:= StrToDateDef(THelper.DevolveConteudoDelimitado('|', v_linha), Now);
          v_pessoa.Cep:= THelper.ReturnsInteger(THelper.DevolveConteudoDelimitado('|', v_linha));
          v_pessoa.Logradouro:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_pessoa.Numero:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_pessoa.Complemento:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_pessoa.Bairro:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_pessoa.CodigoMunicipio:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_pessoa.NomeMunicipio:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_pessoa.Uf:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_pessoa.Fone:= THelper.ReturnsInteger(THelper.DevolveConteudoDelimitado('|', v_linha));
          v_pessoa.Celular:= THelper.ReturnsInteger(THelper.DevolveConteudoDelimitado('|', v_linha));
          v_pessoa.Email:= LowerCase(THelper.DevolveConteudoDelimitado('|', v_linha));
          v_pessoa.Observacao:= THelper.DevolveConteudoDelimitado('|', v_linha);
          v_pessoa.Synchronized:= '';

          if (v_pessoa.RazaoSocial.Length > 60) then v_pessoa.RazaoSocial:= Copy(v_pessoa.RazaoSocial,1,60);
          if (v_pessoa.Ie.Length <= 6) then v_pessoa.Ie:= '';
          if (v_pessoa.TipoPessoa = 'J') and (v_pessoa.Ie.Length = 0) then v_pessoa.Indiedest:= '2';
          if (v_pessoa.TipoPessoa = 'F') and (v_pessoa.Ie.Length > 0) then v_pessoa.Indiedest:= '1';
          if (v_pessoa.TipoPessoa = 'F') and (v_pessoa.Ie.Length = 0) then v_pessoa.Indiedest:= '9';
          if (v_pessoa.Cep.Length <> 8) then v_pessoa.Cep:= '';
          if (v_pessoa.Logradouro.Length > 60) then v_pessoa.Logradouro:= Copy(v_pessoa.Logradouro,1,60);
          if (v_pessoa.CodigoMunicipio.Length <> 7) then v_pessoa.CodigoMunicipio:= '';
          if (v_pessoa.Fone.Length <> 10) then v_pessoa.Fone:= '';
          if (v_pessoa.Celular.Length <> 11) then v_pessoa.Celular:= '';

          if v_pessoa.validate(2) then
            v_pessoa.save();
        end;

        Self.Commit();
      end;
    except on e: exception do
      begin
        Self.Rollback();
        Result:= False;
        THelper.Mensagem('Falha ao importar pessoas. erro: ' + e.Message + ' ' + v_pessoa.Nome);
      end;
    end;
  finally
    if Assigned(v_open) then FreeAndNil(v_open);
    if Assigned(v_arquivo) then FreeAndNil(v_arquivo);
    if Assigned(v_pessoa) then FreeAndNil(v_pessoa);
  end;
end;

class function TEmpresa.list(search: string): TObjectList<TEmpresa>;
const
  FSql: string =
  'SELECT E.* FROM EMPRESAS E ' +
  'JOIN USER_EMPRESAS UE ON(E.ID = UE.EMPRESA_ID) ' +
  'WHERE (UE.EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (E.NOME LIKE :SEARCH) OR (E.CNPJ LIKE :SEARCH)';
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
        Result:= TObjectList<TEmpresa>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TEmpresa.find(FDQuery.FieldByName('ID').AsString));
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

function TEmpresa.save: Boolean;
begin
  Result:= inherited;
end;

procedure TEmpresa.setBairro(const Value: String);
begin
  FBAIRRO:= THelper.RemoveAcentos(Value);
end;

procedure TEmpresa.setComplemento(const Value: String);
begin
  FCOMPLEMENTO:= THelper.RemoveAcentos(Value);
end;

function TEmpresa.setEmail: String;
begin
  Result:= THelper.RemoveAcentos(FEMAIL);
end;

procedure TEmpresa.setLogradouro(const Value: String);
begin
  FLOGRADOURO:= THelper.RemoveAcentos(Value);
end;

procedure TEmpresa.setNome(const Value: String);
begin
  FNOME:= THelper.RemoveAcentos(Value);
end;

procedure TEmpresa.setNomeMunicipio(const Value: String);
begin
  FNOME_MUNICIPIO:= THelper.RemoveAcentos(Value);
end;

procedure TEmpresa.setRazaoSocial(const Value: String);
begin
  FRAZAO_SOCIAL:= THelper.RemoveAcentos(Value);
end;

function TEmpresa.store: Boolean;
const
  FSql: string =
  'INSERT INTO EMPRESAS ( ' +
  '  ID,                  ' +
  '  TIPO_PESSOA,         ' +
  '  REFERENCIA,          ' +
  '  NOME,                ' +
  '  RAZAO_SOCIAL,        ' +
  '  DOCUMENTO,           ' +
  '  IE,                  ' +
  '  IEST,                ' +
  '  IM,                  ' +
  '  CNAE,                ' +
  '  CRT,                 ' +
  '  CEP,                 ' +
  '  LOGRADOURO,          ' +
  '  NUMERO,              ' +
  '  COMPLEMENTO,         ' +
  '  BAIRRO,              ' +
  '  CODIGO_MUNICIPIO,    ' +
  '  NOME_MUNICIPIO,      ' +
  '  UF,                  ' +
  '  FONE,                ' +
  '  CELULAR,             ' +
  '  EMAIL,               ' +
  '  CONTROLE_CONSULTA,   ' +
  '  ULTIMA_CONSULTA,     ' +
  '  ULTIMO_NSU,          ' +
  '  CREATED_AT,          ' +
  '  UPDATED_AT)          ' +
  'VALUES (               ' +
  '  :ID,                 ' +
  '  :TIPO_PESSOA,        ' +
  '  :REFERENCIA,         ' +
  '  :NOME,               ' +
  '  :RAZAO_SOCIAL,       ' +
  '  :DOCUMENTO,          ' +
  '  :IE,                 ' +
  '  :IEST,               ' +
  '  :IM,                 ' +
  '  :CNAE,               ' +
  '  :CRT,                ' +
  '  :CEP,                ' +
  '  :LOGRADOURO,         ' +
  '  :NUMERO,             ' +
  '  :COMPLEMENTO,        ' +
  '  :BAIRRO,             ' +
  '  :CODIGO_MUNICIPIO,   ' +
  '  :NOME_MUNICIPIO,     ' +
  '  :UF,                 ' +
  '  :FONE,               ' +
  '  :CELULAR,            ' +
  '  :EMAIL,              ' +
  '  :CONTROLE_CONSULTA,  ' +
  '  :ULTIMA_CONSULTA,    ' +
  '  :ULTIMO_NSU,         ' +
  '  :CREATED_AT,         ' +
  '  :UPDATED_AT)         ';
var
  FDQuery: TFDQuery;
  User: TUser;
begin
  Result:= True;
  User:= nil;
  try
    Self.StartTransaction();
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('TIPO_PESSOA').DataType:= ftString;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NOME').DataType:= ftString;
      FDQuery.Params.ParamByName('RAZAO_SOCIAL').DataType:= ftString;
      FDQuery.Params.ParamByName('DOCUMENTO').DataType:= ftString;
      FDQuery.Params.ParamByName('IE').DataType:= ftString;
      FDQuery.Params.ParamByName('IEST').DataType:= ftString;
      FDQuery.Params.ParamByName('IM').DataType:= ftString;
      FDQuery.Params.ParamByName('CNAE').DataType:= ftString;
      FDQuery.Params.ParamByName('CRT').DataType:= ftString;
      FDQuery.Params.ParamByName('CEP').DataType:= ftString;
      FDQuery.Params.ParamByName('LOGRADOURO').DataType:= ftString;
      FDQuery.Params.ParamByName('NUMERO').DataType:= ftString;
      FDQuery.Params.ParamByName('COMPLEMENTO').DataType:= ftString;
      FDQuery.Params.ParamByName('BAIRRO').DataType:= ftString;
      FDQuery.Params.ParamByName('CODIGO_MUNICIPIO').DataType:= ftString;
      FDQuery.Params.ParamByName('NOME_MUNICIPIO').DataType:= ftString;
      FDQuery.Params.ParamByName('UF').DataType:= ftString;
      FDQuery.Params.ParamByName('FONE').DataType:= ftString;
      FDQuery.Params.ParamByName('CELULAR').DataType:= ftString;
      FDQuery.Params.ParamByName('EMAIL').DataType:= ftString;
      FDQuery.Params.ParamByName('CONTROLE_CONSULTA').DataType:= ftDate;
      FDQuery.Params.ParamByName('ULTIMA_CONSULTA').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('ULTIMO_NSU').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare();

      Self.Id:= Self.generateId;
      Self.Referencia:= Self.nextReferencia(Self.Referencia);

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.TipoPessoa <> EmptyStr) then
        FDQuery.Params.ParamByName('TIPO_PESSOA').AsString:= Self.TipoPessoa;
      if (Self.Referencia > 0) then
        FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= Self.Referencia;
      if (Self.Nome <> EmptyStr) then
        FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      if (Self.RazaoSocial <> EmptyStr) then
        FDQuery.Params.ParamByName('RAZAO_SOCIAL').AsString:= Self.RazaoSocial;
      if (Self.Documento <> EmptyStr) then
        FDQuery.Params.ParamByName('DOCUMENTO').AsString:= Self.Documento;
      if (Self.Ie <> EmptyStr) then
        FDQuery.Params.ParamByName('IE').AsString:= Self.Ie;
      if (Self.Iest <> EmptyStr) then
        FDQuery.Params.ParamByName('IEST').AsString:= Self.Iest;
      if (Self.Im <> EmptyStr) then
        FDQuery.Params.ParamByName('IM').AsString:= Self.Im;
      if (Self.Cnae <> EmptyStr) then
        FDQuery.Params.ParamByName('CNAE').AsString:= Self.Cnae;
      if (Self.Crt <> EmptyStr) then
        FDQuery.Params.ParamByName('CRT').AsString:= Self.Crt;
      if (Self.Cep <> EmptyStr) then
        FDQuery.Params.ParamByName('CEP').AsString:= Self.Cep;
      if (Self.Logradouro <> EmptyStr) then
        FDQuery.Params.ParamByName('LOGRADOURO').AsString:= Self.Logradouro;
      if (Self.Numero <> EmptyStr) then
        FDQuery.Params.ParamByName('NUMERO').AsString:= Self.Numero;
      if (Self.Complemento <> EmptyStr) then
        FDQuery.Params.ParamByName('COMPLEMENTO').AsString:= Self.Complemento;
      if (Self.Bairro <> EmptyStr) then
        FDQuery.Params.ParamByName('BAIRRO').AsString:= Self.Bairro;
      if (Self.CodigoMunicipio <> EmptyStr) then
        FDQuery.Params.ParamByName('CODIGO_MUNICIPIO').AsString:= Self.CodigoMunicipio;
      if (Self.NomeMunicipio <> EmptyStr) then
        FDQuery.Params.ParamByName('NOME_MUNICIPIO').AsString:= Self.NomeMunicipio;
      if (Self.Uf <> EmptyStr) then
        FDQuery.Params.ParamByName('UF').AsString:= Self.Uf;
      if (Self.Fone <> EmptyStr) then
        FDQuery.Params.ParamByName('FONE').AsString:= Self.Fone;
      if (Self.Celular <> EmptyStr) then
        FDQuery.Params.ParamByName('CELULAR').AsString:= Self.Celular;
      if (Self.Email <> EmptyStr) then
        FDQuery.Params.ParamByName('EMAIL').AsString:= Self.Email;
      if (Self.ControleConsulta > 0) then
        FDQuery.Params.ParamByName('CONTROLE_CONSULTA').AsDate:= Self.ControleConsulta;
      if (Self.UltimaConsulta > 0) then
        FDQuery.Params.ParamByName('ULTIMA_CONSULTA').AsDateTime:= Self.UltimaConsulta;
      if (Self.UltimoNsu >= 1) then
        FDQuery.Params.ParamByName('ULTIMO_NSU').AsInteger:= Self.UltimoNsu;
      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.ExecSQL;

      Self.unidades();
      Self.categorias();

      User:= TUser.find(TAuthService.getAuthenticatedUserId);

      FDQuery.SQL.Clear();
      FDQuery.SQL.Add('INSERT INTO USER_EMPRESAS (USER_ID, EMPRESA_ID) VALUES (:USER_ID, :EMPRESA_ID)');
      FDQuery.Params.ParamByName('USER_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('USER_ID').AsString:= User.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.Id;
      FDQuery.ExecSQL();

      User.EmpresaId:= Self.Id;
      User.save();

      Self.Commit();
    except on e: exception do
      begin
        Self.Rollback();
        Result:= False;
        raise Exception.Create('Falha ao gravar dados da empresa. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(User);
    FreeAndNil(FDQuery);
  end;
end;

procedure TEmpresa.unidades;
var
  vUnidades: TStringList;
  vItem: string;
  vUnidade: TUnidade;
  I: Integer;
begin
  vUnidades:= TStringList.Create;
  vUnidades.Add('AMPOLA|AMPOLA|');
  vUnidades.Add('BALDE|BALDE|');
  vUnidades.Add('BANDEJ|BANDEJA|');
  vUnidades.Add('BARRA|BARRA|');
  vUnidades.Add('BISNAG|BISNAGA|');
  vUnidades.Add('BLOCO|BLOCO|');
  vUnidades.Add('BOBINA|BOBINA|');
  vUnidades.Add('BOMB|BOMBONA|');
  vUnidades.Add('CAPS|CAPSULA|');
  vUnidades.Add('CART|CARTELA|');
  vUnidades.Add('CENTO|CENTO|');
  vUnidades.Add('CJ|CONJUNTO|');
  vUnidades.Add('CM|CENTIMETRO|');
  vUnidades.Add('CM2|CENTIMETRO QUADRADO|');
  vUnidades.Add('CX|CAIXA|');
  vUnidades.Add('CX2|CAIXA COM 2 UNIDADES|');
  vUnidades.Add('CX3|CAIXA COM 3 UNIDADES|');
  vUnidades.Add('CX5|CAIXA COM 5 UNIDADES|');
  vUnidades.Add('CX10|CAIXA COM 10 UNIDADES|');
  vUnidades.Add('CX15|CAIXA COM 15 UNIDADES|');
  vUnidades.Add('CX20|CAIXA COM 20 UNIDADES|');
  vUnidades.Add('CX25|CAIXA COM 25 UNIDADES|');
  vUnidades.Add('CX50|CAIXA COM 50 UNIDADES|');
  vUnidades.Add('CX100|CAIXA COM 100 UNIDADES|');
  vUnidades.Add('DISP|DISPLAY|');
  vUnidades.Add('DUZIA|DUZIA|');
  vUnidades.Add('EMBAL|EMBALAGEM|');
  vUnidades.Add('FARDO|FARDO|');
  vUnidades.Add('FOLHA|FOLHA|');
  vUnidades.Add('FRASCO|FRASCO|');
  vUnidades.Add('GALAO|GALÃO|');
  vUnidades.Add('GF|GARRAFA|');
  vUnidades.Add('GRAMAS|GRAMAS|');
  vUnidades.Add('JOGO|JOGO|');
  vUnidades.Add('KG|QUILOGRAMA|');
  vUnidades.Add('KIT|KIT|');
  vUnidades.Add('LATA|LATA|');
  vUnidades.Add('LITRO|LITRO|');
  vUnidades.Add('M|METRO|');
  vUnidades.Add('M2|METRO QUADRADO|');
  vUnidades.Add('M3|METRO CÚBICO|');
  vUnidades.Add('MILHEI|MILHEIRO|');
  vUnidades.Add('ML|MILILITRO|');
  vUnidades.Add('MWH|MEGAWATT HORA|');
  vUnidades.Add('PACOTE|PACOTE|');
  vUnidades.Add('PALETE|PALETE|');
  vUnidades.Add('PARES|PARES|');
  vUnidades.Add('PC|PEÇA|');
  vUnidades.Add('POTE|POTE|');
  vUnidades.Add('K|QUILATE|');
  vUnidades.Add('RESMA|RESMA|');
  vUnidades.Add('ROLO|ROLO|');
  vUnidades.Add('SACO|SACO|');
  vUnidades.Add('SACOLA|SACOLA|');
  vUnidades.Add('TAMBOR|TAMBOR|');
  vUnidades.Add('TANQUE|TANQUE|');
  vUnidades.Add('TON|TONELADA|');
  vUnidades.Add('TUBO|TUBO|');
  vUnidades.Add('UNID|UNIDADE|');
  vUnidades.Add('VASIL|VASILHAME|');
  vUnidades.Add('VIDRO|VIDRO|');

  for I:= 0 to Pred(vUnidades.Count) do
  begin
    vItem:= vUnidades[I];
    vUnidade:= TUnidade.Create;
    vUnidade.EmpresaId:= Self.Id;
    vUnidade.Unidade:= THelper.DevolveConteudoDelimitado('|',vItem);
    vUnidade.Nome:= THelper.DevolveConteudoDelimitado('|',vItem);
    vUnidade.save();
    FreeAndNil(vUnidade);
  end;
  FreeAndNil(vUnidades);
end;

function TEmpresa.update: Boolean;
const
  FSql: string =
  'UPDATE EMPRESAS                            ' +
  'SET TIPO_PESSOA = :TIPO_PESSOA,            ' +
  '    REFERENCIA = :REFERENCIA,              ' +
  '    NOME = :NOME,                          ' +
  '    RAZAO_SOCIAL = :RAZAO_SOCIAL,          ' +
  '    DOCUMENTO = :DOCUMENTO,                ' +
  '    IE = :IE,                              ' +
  '    IEST = :IEST,                          ' +
  '    IM = :IM,                              ' +
  '    CNAE = :CNAE,                          ' +
  '    CRT = :CRT,                            ' +
  '    CEP = :CEP,                            ' +
  '    LOGRADOURO = :LOGRADOURO,              ' +
  '    NUMERO = :NUMERO,                      ' +
  '    COMPLEMENTO = :COMPLEMENTO,            ' +
  '    BAIRRO = :BAIRRO,                      ' +
  '    CODIGO_MUNICIPIO = :CODIGO_MUNICIPIO,  ' +
  '    NOME_MUNICIPIO = :NOME_MUNICIPIO,      ' +
  '    UF = :UF,                              ' +
  '    FONE = :FONE,                          ' +
  '    CELULAR = :CELULAR,                    ' +
  '    EMAIL = :EMAIL,                        ' +
  '    CONTROLE_CONSULTA = :CONTROLE_CONSULTA,' +
  '    ULTIMA_CONSULTA = :ULTIMA_CONSULTA,    ' +
  '    ULTIMO_NSU = :ULTIMO_NSU,              ' +
  '    UPDATED_AT = :UPDATED_AT,              ' +
  '    SYNCHRONIZED = :SYNCHRONIZED           ' +
  'WHERE (ID = :ID)                           ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('TIPO_PESSOA').DataType:= ftString;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('NOME').DataType:= ftString;
      FDQuery.Params.ParamByName('RAZAO_SOCIAL').DataType:= ftString;
      FDQuery.Params.ParamByName('DOCUMENTO').DataType:= ftString;
      FDQuery.Params.ParamByName('IE').DataType:= ftString;
      FDQuery.Params.ParamByName('IEST').DataType:= ftString;
      FDQuery.Params.ParamByName('IM').DataType:= ftString;
      FDQuery.Params.ParamByName('CNAE').DataType:= ftString;
      FDQuery.Params.ParamByName('CRT').DataType:= ftString;
      FDQuery.Params.ParamByName('CEP').DataType:= ftString;
      FDQuery.Params.ParamByName('LOGRADOURO').DataType:= ftString;
      FDQuery.Params.ParamByName('NUMERO').DataType:= ftString;
      FDQuery.Params.ParamByName('COMPLEMENTO').DataType:= ftString;
      FDQuery.Params.ParamByName('BAIRRO').DataType:= ftString;
      FDQuery.Params.ParamByName('CODIGO_MUNICIPIO').DataType:= ftString;
      FDQuery.Params.ParamByName('NOME_MUNICIPIO').DataType:= ftString;
      FDQuery.Params.ParamByName('UF').DataType:= ftString;
      FDQuery.Params.ParamByName('FONE').DataType:= ftString;
      FDQuery.Params.ParamByName('CELULAR').DataType:= ftString;
      FDQuery.Params.ParamByName('EMAIL').DataType:= ftString;
      FDQuery.Params.ParamByName('CONTROLE_CONSULTA').DataType:= ftDate;
      FDQuery.Params.ParamByName('ULTIMA_CONSULTA').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('ULTIMO_NSU').DataType:= ftInteger;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftString;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.TipoPessoa <> EmptyStr) then
        FDQuery.Params.ParamByName('TIPO_PESSOA').AsString:= Self.TipoPessoa;
      if (Self.Referencia > 0) then
        FDQuery.Params.ParamByName('CODIGO_REFERENCIA').AsInteger:= Self.Referencia;
      if (Self.Nome <> EmptyStr) then
        FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      if (Self.RazaoSocial <> EmptyStr) then
        FDQuery.Params.ParamByName('RAZAO_SOCIAL').AsString:= Self.RazaoSocial;
      if (Self.Documento <> EmptyStr) then
        FDQuery.Params.ParamByName('DOCUMENTO').AsString:= Self.Documento;
      if (Self.Ie <> EmptyStr) then
        FDQuery.Params.ParamByName('IE').AsString:= Self.Ie;
      if (Self.Iest <> EmptyStr) then
        FDQuery.Params.ParamByName('IEST').AsString:= Self.Iest;
      if (Self.Im <> EmptyStr) then
        FDQuery.Params.ParamByName('IM').AsString:= Self.Im;
      if (Self.Cnae <> EmptyStr) then
        FDQuery.Params.ParamByName('CNAE').AsString:= Self.Cnae;
      if (Self.Crt <> EmptyStr) then
        FDQuery.Params.ParamByName('CRT').AsString:= Self.Crt;
      if (Self.Cep <> EmptyStr) then
        FDQuery.Params.ParamByName('CEP').AsString:= Self.Cep;
      if (Self.Logradouro <> EmptyStr) then
        FDQuery.Params.ParamByName('LOGRADOURO').AsString:= Self.Logradouro;
      if (Self.Numero <> EmptyStr) then
        FDQuery.Params.ParamByName('NUMERO').AsString:= Self.Numero;
      if (Self.Complemento <> EmptyStr) then
        FDQuery.Params.ParamByName('COMPLEMENTO').AsString:= Self.Complemento;
      if (Self.Bairro <> EmptyStr) then
        FDQuery.Params.ParamByName('BAIRRO').AsString:= Self.Bairro;
      if (Self.CodigoMunicipio <> EmptyStr) then
        FDQuery.Params.ParamByName('CODIGO_MUNICIPIO').AsString:= Self.CodigoMunicipio;
      if (Self.NomeMunicipio <> EmptyStr) then
        FDQuery.Params.ParamByName('NOME_MUNICIPIO').AsString:= Self.NomeMunicipio;
      if (Self.Uf <> EmptyStr) then
        FDQuery.Params.ParamByName('UF').AsString:= Self.Uf;
      if (Self.Fone <> EmptyStr) then
        FDQuery.Params.ParamByName('FONE').AsString:= Self.Fone;
      if (Self.Celular <> EmptyStr) then
        FDQuery.Params.ParamByName('CELULAR').AsString:= Self.Celular;
      if (Self.Email <> EmptyStr) then
        FDQuery.Params.ParamByName('EMAIL').AsString:= Self.Email;
      if (Self.ControleConsulta > 0) then
        FDQuery.Params.ParamByName('CONTROLE_CONSULTA').AsDate:= Self.ControleConsulta;
      if (Self.UltimaConsulta > 0) then
        FDQuery.Params.ParamByName('ULTIMA_CONSULTA').AsDateTime:= Self.UltimaConsulta;
      if (Self.UltimoNsu >= 1) then
        FDQuery.Params.ParamByName('ULTIMO_NSU').AsInteger:= Self.UltimoNsu;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao gravar dados da empresa. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TEmpresa.validate(): Boolean;
var
  vMensagem: string;
  vTitle: string;
begin
  Result:= True;
  try
    vTitle:= 'OPSSS!' + #13;

    if (Self.TipoPessoa = 'F')
    and (Trim(Self.Documento) <> '')
    and (ValidarCPF(Trim(Self.Documento)) <> '') then
    begin
      vMensagem:= 'CPF informado é inválido.';
      Exit();
    end;

    if (Self.TipoPessoa = 'J')
    and (Trim(Self.Documento) <> '')
    and (ValidarCNPJ(Trim(Self.Documento)) <> '') then
    begin
      vMensagem:= 'CNPJ informado é inválido.';
      Exit();
    end;

    if (Trim(Self.Ie) <> '')
    and (ValidarIE(Trim(Self.Ie), Self.Uf) <> '') then
    begin
      vMensagem:= 'Inscrição estadual informada é inválida.';
      Exit();
    end;

    if (Trim(Self.Cep) <> '')
    and (Trim(Self.Cep).Length <= 7) then
    begin
      vMensagem:= 'CEP informado é inválido.';
      Exit();
    end;
  finally
    if (vMensagem <> '') then
    begin
      THelper.Mensagem(vTitle + vMensagem);
      Result:= False;
    end;
  end;
end;

end.
