unit Cedente;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TCedente = class(TModel)
  private
    FEMPRESA_ID: String;
    FCONTA_ID: String;
    FNOME: String;
    FCODIGO_CEDENTE: String;
    FCODIGO_TRANSMISSAO: String;
    FAGENCIA: String;
    FAGENCIA_DIGITO: String;
    FCONTA: String;
    FCONTA_DIGITO: String;
    FMODALIDADE: String;
    FCONVENIO: String;
    FTIPO_DOCUMENTO: Integer;
    FTIPO_CARTEIRA: Integer;
    FRESPON_EMISSAO: Integer;
    FCARAC_TITULO: Integer;
    FCNPJCPF: String;
    FTIPO_INSCRICAO: String;
    FLOGRADOURO: String;
    FNUMERO_RES: String;
    FCOMPLEMENTO: String;
    FBAIRRO: String;
    FCIDADE: String;
    FUF: String;
    FCEP: String;
    FTELEFONE: String;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    function validate(): Boolean;
    class function findByContaId(ContaId: string): TCedente;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property ContaId: String  read FCONTA_ID write FCONTA_ID;
    property Nome: String  read FNOME write FNOME;
    property CodigoCedente: String  read FCODIGO_CEDENTE write FCODIGO_CEDENTE;
    property CodigoTransmissao: String  read FCODIGO_TRANSMISSAO write FCODIGO_TRANSMISSAO;
    property Agencia: String  read FAGENCIA write FAGENCIA;
    property AgenciaDigito: String  read FAGENCIA_DIGITO write FAGENCIA_DIGITO;
    property Conta: String  read FCONTA write FCONTA;
    property ContaDigito: String  read FCONTA_DIGITO write FCONTA_DIGITO;
    property Modalidade: String  read FMODALIDADE write FMODALIDADE;
    property Convenio: String  read FCONVENIO write FCONVENIO;
    property TipoDocumento: Integer  read FTIPO_DOCUMENTO write FTIPO_DOCUMENTO;
    property TipoCarteira: Integer  read FTIPO_CARTEIRA write FTIPO_CARTEIRA;
    property ResponEmissao: Integer  read FRESPON_EMISSAO write FRESPON_EMISSAO;
    property CaracTitulo: Integer  read FCARAC_TITULO write FCARAC_TITULO;
    property Cnpjcpf: String  read FCNPJCPF write FCNPJCPF;
    property TipoInscricao: String  read FTIPO_INSCRICAO write FTIPO_INSCRICAO;
    property Logradouro: String  read FLOGRADOURO write FLOGRADOURO;
    property NumeroRes: String  read FNUMERO_RES write FNUMERO_RES;
    property Complemento: String  read FCOMPLEMENTO write FCOMPLEMENTO;
    property Bairro: String  read FBAIRRO write FBAIRRO;
    property Cidade: String  read FCIDADE write FCIDADE;
    property Uf: String  read FUF write FUF;
    property Cep: String  read FCEP write FCEP;
    property Telefone: String  read FTELEFONE write FTELEFONE;

  end;

implementation

uses
  AuthService, Helper;

{ TCedente }

constructor TCedente.Create;
begin
  Self.Table:= 'CEDENTES';
end;

class function TCedente.findByContaId(ContaId: string): TCedente;
const
  FSql: string = 'SELECT * FROM CEDENTES WHERE (CONTA_ID = :CONTA_ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('CONTA_ID').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('CONTA_ID').AsString:= ContaId;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TCedente.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.ContaId:= FDQuery.FieldByName('CONTA_ID').AsString;
        Result.Nome:= FDQuery.FieldByName('NOME').AsString;
        Result.CodigoCedente:= FDQuery.FieldByName('CODIGO_CEDENTE').AsString;
        Result.CodigoTransmissao:= FDQuery.FieldByName('CODIGO_TRANSMISSAO').AsString;
        Result.Agencia:= FDQuery.FieldByName('AGENCIA').AsString;
        Result.AgenciaDigito:= FDQuery.FieldByName('AGENCIA_DIGITO').AsString;
        Result.Conta:= FDQuery.FieldByName('CONTA').AsString;
        Result.ContaDigito:= FDQuery.FieldByName('CONTA_DIGITO').AsString;
        Result.Modalidade:= FDQuery.FieldByName('MODALIDADE').AsString;
        Result.Convenio:= FDQuery.FieldByName('CONVENIO').AsString;
        Result.TipoDocumento:= FDQuery.FieldByName('TIPO_DOCUMENTO').AsInteger;
        Result.TipoCarteira:= FDQuery.FieldByName('TIPO_CARTEIRA').AsInteger;
        Result.ResponEmissao:= FDQuery.FieldByName('RESPON_EMISSAO').AsInteger;
        Result.CaracTitulo:= FDQuery.FieldByName('CARAC_TITULO').AsInteger;
        Result.Cnpjcpf:= FDQuery.FieldByName('CNPJCPF').AsString;
        Result.TipoInscricao:= FDQuery.FieldByName('TIPO_INSCRICAO').AsString;
        Result.Logradouro:= FDQuery.FieldByName('LOGRADOURO').AsString;
        Result.NumeroRes:= FDQuery.FieldByName('NUMERO_RES').AsString;
        Result.Complemento:= FDQuery.FieldByName('COMPLEMENTO').AsString;
        Result.Bairro:= FDQuery.FieldByName('BAIRRO').AsString;
        Result.Cidade:= FDQuery.FieldByName('CIDADE').AsString;
        Result.Uf:= FDQuery.FieldByName('UF').AsString;
        Result.Cep:= FDQuery.FieldByName('CEP').AsString;
        Result.Telefone:= FDQuery.FieldByName('TELEFONE').AsString;
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

function TCedente.save: Boolean;
begin
  Result:= inherited;
end;

function TCedente.store: Boolean;
const
  FSql: string =
  'INSERT INTO CEDENTES (' +
  '  ID,                 ' +
  '  EMPRESA_ID,         ' +
  '  CONTA_ID,           ' +
  '  NOME,               ' +
  '  CODIGO_CEDENTE,     ' +
  '  CODIGO_TRANSMISSAO, ' +
  '  AGENCIA,            ' +
  '  AGENCIA_DIGITO,     ' +
  '  CONTA,              ' +
  '  CONTA_DIGITO,       ' +
  '  MODALIDADE,         ' +
  '  CONVENIO,           ' +
  '  TIPO_DOCUMENTO,     ' +
  '  TIPO_CARTEIRA,      ' +
  '  RESPON_EMISSAO,     ' +
  '  CARAC_TITULO,       ' +
  '  CNPJCPF,            ' +
  '  TIPO_INSCRICAO,     ' +
  '  LOGRADOURO,         ' +
  '  NUMERO_RES,         ' +
  '  COMPLEMENTO,        ' +
  '  BAIRRO,             ' +
  '  CIDADE,             ' +
  '  UF,                 ' +
  '  CEP,                ' +
  '  TELEFONE,           ' +
  '  CREATED_AT,         ' +
  '  UPDATED_AT)         ' +
  'VALUES (              ' +
  '  :ID,                ' +
  '  :EMPRESA_ID,        ' +
  '  :CONTA_ID,          ' +
  '  :NOME,              ' +
  '  :CODIGO_CEDENTE,    ' +
  '  :CODIGO_TRANSMISSAO,' +
  '  :AGENCIA,           ' +
  '  :AGENCIA_DIGITO,    ' +
  '  :CONTA,             ' +
  '  :CONTA_DIGITO,      ' +
  '  :MODALIDADE,        ' +
  '  :CONVENIO,          ' +
  '  :TIPO_DOCUMENTO,    ' +
  '  :TIPO_CARTEIRA,     ' +
  '  :RESPON_EMISSAO,    ' +
  '  :CARAC_TITULO,      ' +
  '  :CNPJCPF,           ' +
  '  :TIPO_INSCRICAO,    ' +
  '  :LOGRADOURO,        ' +
  '  :NUMERO_RES,        ' +
  '  :COMPLEMENTO,       ' +
  '  :BAIRRO,            ' +
  '  :CIDADE,            ' +
  '  :UF,                ' +
  '  :CEP,               ' +
  '  :TELEFONE,          ' +
  '  :CREATED_AT,        ' +
  '  :UPDATED_AT)        ';
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
      FDQuery.Params.ParamByName('NOME').DataType:= ftString;
      FDQuery.Params.ParamByName('CODIGO_CEDENTE').DataType:= ftString;
      FDQuery.Params.ParamByName('CODIGO_TRANSMISSAO').DataType:= ftString;
      FDQuery.Params.ParamByName('AGENCIA').DataType:= ftString;
      FDQuery.Params.ParamByName('AGENCIA_DIGITO').DataType:= ftString;
      FDQuery.Params.ParamByName('CONTA').DataType:= ftString;
      FDQuery.Params.ParamByName('CONTA_DIGITO').DataType:= ftString;
      FDQuery.Params.ParamByName('MODALIDADE').DataType:= ftString;
      FDQuery.Params.ParamByName('CONVENIO').DataType:= ftString;
      FDQuery.Params.ParamByName('TIPO_DOCUMENTO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('TIPO_CARTEIRA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('RESPON_EMISSAO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CARAC_TITULO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CNPJCPF').DataType:= ftString;
      FDQuery.Params.ParamByName('TIPO_INSCRICAO').DataType:= ftString;
      FDQuery.Params.ParamByName('LOGRADOURO').DataType:= ftString;
      FDQuery.Params.ParamByName('NUMERO_RES').DataType:= ftString;
      FDQuery.Params.ParamByName('COMPLEMENTO').DataType:= ftString;
      FDQuery.Params.ParamByName('BAIRRO').DataType:= ftString;
      FDQuery.Params.ParamByName('CIDADE').DataType:= ftString;
      FDQuery.Params.ParamByName('UF').DataType:= ftString;
      FDQuery.Params.ParamByName('CEP').DataType:= ftString;
      FDQuery.Params.ParamByName('TELEFONE').DataType:= ftString;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('CONTA_ID').AsString:= Self.ContaId;
      if (Self.Nome <> EmptyStr) then
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      if (Self.CodigoCedente <> EmptyStr) then
      FDQuery.Params.ParamByName('CODIGO_CEDENTE').AsString:= Self.CodigoCedente;
      if (Self.CodigoTransmissao <> EmptyStr) then
      FDQuery.Params.ParamByName('CODIGO_TRANSMISSAO').AsString:= Self.CodigoTransmissao;
      if (Self.Agencia <> EmptyStr) then
      FDQuery.Params.ParamByName('AGENCIA').AsString:= Self.Agencia;
      if (Self.AgenciaDigito <> EmptyStr) then
      FDQuery.Params.ParamByName('AGENCIA_DIGITO').AsString:= Self.AgenciaDigito;
      if (Self.Conta <> EmptyStr) then
      FDQuery.Params.ParamByName('CONTA').AsString:= Self.Conta;
      if (Self.ContaDigito <> EmptyStr) then
      FDQuery.Params.ParamByName('CONTA_DIGITO').AsString:= Self.ContaDigito;
      if (Self.Modalidade <> EmptyStr) then
      FDQuery.Params.ParamByName('MODALIDADE').AsString:= Self.Modalidade;
      if (Self.Convenio <> EmptyStr) then
      FDQuery.Params.ParamByName('CONVENIO').AsString:= Self.Convenio;
      if (Self.TipoDocumento in[1,2]) then
      FDQuery.Params.ParamByName('TIPO_DOCUMENTO').AsInteger:= Self.TipoDocumento;
      if (Self.TipoCarteira in[0..2]) then
      FDQuery.Params.ParamByName('TIPO_CARTEIRA').AsInteger:= Self.TipoCarteira;
      if (Self.ResponEmissao in[0..3]) then
      FDQuery.Params.ParamByName('RESPON_EMISSAO').AsInteger:= Self.ResponEmissao;
      if (Self.CaracTitulo in[0..4]) then
      FDQuery.Params.ParamByName('CARAC_TITULO').AsInteger:= Self.CaracTitulo;
      if (Self.Cnpjcpf <> EmptyStr) then
      FDQuery.Params.ParamByName('CNPJCPF').AsString:= Self.Cnpjcpf;
      if (Self.TipoInscricao <> EmptyStr) then
      FDQuery.Params.ParamByName('TIPO_INSCRICAO').AsString:= Self.TipoInscricao;
      if (Self.Logradouro <> EmptyStr) then
      FDQuery.Params.ParamByName('LOGRADOURO').AsString:= Self.Logradouro;
      if (Self.NumeroRes <> EmptyStr) then
      FDQuery.Params.ParamByName('NUMERO_RES').AsString:= Self.NumeroRes;
      if (Self.Complemento <> EmptyStr) then
      FDQuery.Params.ParamByName('COMPLEMENTO').AsString:= Self.Complemento;
      if (Self.Bairro <> EmptyStr) then
      FDQuery.Params.ParamByName('BAIRRO').AsString:= Self.Bairro;
      if (Self.Cidade <> EmptyStr) then
      FDQuery.Params.ParamByName('CIDADE').AsString:= Self.Cidade;
      if (Self.Uf <> EmptyStr) then
      FDQuery.Params.ParamByName('UF').AsString:= Self.Uf;
      if (Self.Cep <> EmptyStr) then
      FDQuery.Params.ParamByName('CEP').AsString:= Self.Cep;
      if (Self.Telefone <> EmptyStr) then
      FDQuery.Params.ParamByName('TELEFONE').AsString:= Self.Telefone;
      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao inserir dados do cedente. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TCedente.update: Boolean;
const
  FSql: string =
  'UPDATE CEDENTES                              ' +
  'SET NOME = :NOME,                            ' +
  '    CODIGO_CEDENTE = :CODIGO_CEDENTE,        ' +
  '    CODIGO_TRANSMISSAO = :CODIGO_TRANSMISSAO,' +
  '    AGENCIA = :AGENCIA,                      ' +
  '    AGENCIA_DIGITO = :AGENCIA_DIGITO,        ' +
  '    CONTA = :CONTA,                          ' +
  '    CONTA_DIGITO = :CONTA_DIGITO,            ' +
  '    MODALIDADE = :MODALIDADE,                ' +
  '    CONVENIO = :CONVENIO,                    ' +
  '    TIPO_DOCUMENTO = :TIPO_DOCUMENTO,        ' +
  '    TIPO_CARTEIRA = :TIPO_CARTEIRA,          ' +
  '    RESPON_EMISSAO = :RESPON_EMISSAO,        ' +
  '    CARAC_TITULO = :CARAC_TITULO,            ' +
  '    CNPJCPF = :CNPJCPF,                      ' +
  '    TIPO_INSCRICAO = :TIPO_INSCRICAO,        ' +
  '    LOGRADOURO = :LOGRADOURO,                ' +
  '    NUMERO_RES = :NUMERO_RES,                ' +
  '    COMPLEMENTO = :COMPLEMENTO,              ' +
  '    BAIRRO = :BAIRRO,                        ' +
  '    CIDADE = :CIDADE,                        ' +
  '    UF = :UF,                                ' +
  '    CEP = :CEP,                              ' +
  '    TELEFONE = :TELEFONE,                    ' +
  '    UPDATED_AT = :UPDATED_AT,                ' +
  '    SYNCHRONIZED = :SYNCHRONIZED             ' +
  'WHERE (ID = :ID)                             ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('NOME').DataType:= ftString;
      FDQuery.Params.ParamByName('CODIGO_CEDENTE').DataType:= ftString;
      FDQuery.Params.ParamByName('CODIGO_TRANSMISSAO').DataType:= ftString;
      FDQuery.Params.ParamByName('AGENCIA').DataType:= ftString;
      FDQuery.Params.ParamByName('AGENCIA_DIGITO').DataType:= ftString;
      FDQuery.Params.ParamByName('CONTA').DataType:= ftString;
      FDQuery.Params.ParamByName('CONTA_DIGITO').DataType:= ftString;
      FDQuery.Params.ParamByName('MODALIDADE').DataType:= ftString;
      FDQuery.Params.ParamByName('CONVENIO').DataType:= ftString;
      FDQuery.Params.ParamByName('TIPO_DOCUMENTO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('TIPO_CARTEIRA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('RESPON_EMISSAO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CARAC_TITULO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('CNPJCPF').DataType:= ftString;
      FDQuery.Params.ParamByName('TIPO_INSCRICAO').DataType:= ftString;
      FDQuery.Params.ParamByName('LOGRADOURO').DataType:= ftString;
      FDQuery.Params.ParamByName('NUMERO_RES').DataType:= ftString;
      FDQuery.Params.ParamByName('COMPLEMENTO').DataType:= ftString;
      FDQuery.Params.ParamByName('BAIRRO').DataType:= ftString;
      FDQuery.Params.ParamByName('CIDADE').DataType:= ftString;
      FDQuery.Params.ParamByName('UF').DataType:= ftString;
      FDQuery.Params.ParamByName('CEP').DataType:= ftString;
      FDQuery.Params.ParamByName('TELEFONE').DataType:= ftString;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftString;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.Nome <> EmptyStr) then
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      if (Self.CodigoCedente <> EmptyStr) then
      FDQuery.Params.ParamByName('CODIGO_CEDENTE').AsString:= Self.CodigoCedente;
      if (Self.CodigoTransmissao <> EmptyStr) then
      FDQuery.Params.ParamByName('CODIGO_TRANSMISSAO').AsString:= Self.CodigoTransmissao;
      if (Self.Agencia <> EmptyStr) then
      FDQuery.Params.ParamByName('AGENCIA').AsString:= Self.Agencia;
      if (Self.AgenciaDigito <> EmptyStr) then
      FDQuery.Params.ParamByName('AGENCIA_DIGITO').AsString:= Self.AgenciaDigito;
      if (Self.Conta <> EmptyStr) then
      FDQuery.Params.ParamByName('CONTA').AsString:= Self.Conta;
      if (Self.ContaDigito <> EmptyStr) then
      FDQuery.Params.ParamByName('CONTA_DIGITO').AsString:= Self.ContaDigito;
      if (Self.Modalidade <> EmptyStr) then
      FDQuery.Params.ParamByName('MODALIDADE').AsString:= Self.Modalidade;
      if (Self.Convenio <> EmptyStr) then
      FDQuery.Params.ParamByName('CONVENIO').AsString:= Self.Convenio;
      if (Self.TipoDocumento in[1,2]) then
      FDQuery.Params.ParamByName('TIPO_DOCUMENTO').AsInteger:= Self.TipoDocumento;
      if (Self.TipoCarteira in[0..2]) then
      FDQuery.Params.ParamByName('TIPO_CARTEIRA').AsInteger:= Self.TipoCarteira;
      if (Self.ResponEmissao in[0..3]) then
      FDQuery.Params.ParamByName('RESPON_EMISSAO').AsInteger:= Self.ResponEmissao;
      if (Self.CaracTitulo in[0..4]) then
      FDQuery.Params.ParamByName('CARAC_TITULO').AsInteger:= Self.CaracTitulo;
      if (Self.Cnpjcpf <> EmptyStr) then
      FDQuery.Params.ParamByName('CNPJCPF').AsString:= Self.Cnpjcpf;
      if (Self.TipoInscricao <> EmptyStr) then
      FDQuery.Params.ParamByName('TIPO_INSCRICAO').AsString:= Self.TipoInscricao;
      if (Self.Logradouro <> EmptyStr) then
      FDQuery.Params.ParamByName('LOGRADOURO').AsString:= Self.Logradouro;
      if (Self.NumeroRes <> EmptyStr) then
      FDQuery.Params.ParamByName('NUMERO_RES').AsString:= Self.NumeroRes;
      if (Self.Complemento <> EmptyStr) then
      FDQuery.Params.ParamByName('COMPLEMENTO').AsString:= Self.Complemento;
      if (Self.Bairro <> EmptyStr) then
      FDQuery.Params.ParamByName('BAIRRO').AsString:= Self.Bairro;
      if (Self.Cidade <> EmptyStr) then
      FDQuery.Params.ParamByName('CIDADE').AsString:= Self.Cidade;
      if (Self.Uf <> EmptyStr) then
      FDQuery.Params.ParamByName('UF').AsString:= Self.Uf;
      if (Self.Cep <> EmptyStr) then
      FDQuery.Params.ParamByName('CEP').AsString:= Self.Cep;
      if (Self.Telefone <> EmptyStr) then
      FDQuery.Params.ParamByName('TELEFONE').AsString:= Self.Telefone;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('CEDENTE. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TCedente.validate(): Boolean;
var
  vTitle: string;
  vMessage: string;
begin
  Result:= True;
  try
    vTitle:= 'OPSSS!' + #13;

    if (Trim(Self.Cnpjcpf).Length = 14)
    and (not THelper.ValidarCNPJ(Trim(Self.Cnpjcpf))) then
    begin
      vMessage:= 'CPF/CNPJ informado é inválido.';
      Exit();
    end
    else
    if (Trim(Self.Cnpjcpf).Length <= 13)
    and (not THelper.ValidarCPF(Trim(Self.Cnpjcpf))) then
    begin
      vMessage:= 'CPF/CNPJ informado é inválido.';
      Exit();
    end;

    if (Trim(Self.Cep) <> '')
    and (Trim(Self.Cep).Length <= 7) then
    begin
      vMessage:= 'CEP informado é inválido.';
      Exit();
    end;
  finally
    if (vMessage <> '') then
    begin
      THelper.Mensagem(vTitle + vMessage);
      Result:= False;
    end;
  end;
end;

end.
