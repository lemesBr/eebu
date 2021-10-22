unit Conta;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  Cedente, BoletoConfiguracao, System.DateUtils, System.StrUtils;

type
  TConta = class(TModel)
  private
    FEMPRESA_ID: String;
    FNOME: String;
    FSALDO_INICIAL: Extended;
    FDATA_SALDO_INICIAL: TDateTime;
    FCEDENTE: TCedente;
    FBOLETOCONFIGURACAO: TBoletoConfiguracao;

    function getCedente: TCedente;
    function getBoletoConfiguracao: TBoletoConfiguracao;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    function delete(): Boolean;
    function saldo: Extended;
    class function find(id: string): TConta;
    class function list(search: string): TObjectList<TConta>; overload;
    class function remove(id: string): Boolean;
    class procedure list(search: string; DataSet: TFDMemTable); overload;
    class function saldoAnterior(ContaId: string; Dt: TDate): Extended;
    class procedure imprimirExtrato(pId: string;
                                    pDtInicial,
                                    pDtFinal: TDate;
                                    pDt: TFDMemTable);

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property Nome: String  read FNOME write FNOME;
    property SaldoInicial: Extended  read FSALDO_INICIAL write FSALDO_INICIAL;
    property DataSaldoInicial: TDateTime  read FDATA_SALDO_INICIAL write FDATA_SALDO_INICIAL;

    property Cedente: TCedente read getCedente;
    property BoletoConfiguracao: TBoletoConfiguracao read getBoletoConfiguracao;

  end;

implementation

uses
  AuthService, Helper, Empresa, uformPrint;

{ TConta }

constructor TConta.Create;
begin
  Self.Table:= 'CONTAS';
end;

function TConta.delete: Boolean;
const
  FSql: string =
  'UPDATE CONTAS                   ' +
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
        raise Exception.Create('Falha ao remover a conta. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

destructor TConta.Destroy;
begin
  if Assigned(FCEDENTE) then FreeAndNil(FCEDENTE);
  if Assigned(FBOLETOCONFIGURACAO) then FreeAndNil(FBOLETOCONFIGURACAO);

  inherited;
end;

class function TConta.find(id: string): TConta;
const
  FSql: string = 'SELECT * FROM CONTAS WHERE (ID = :ID)';
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
        Result:= TConta.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.Nome:= FDQuery.FieldByName('NOME').AsString;
        Result.SaldoInicial:= FDQuery.FieldByName('SALDO_INICIAL').AsExtended;
        Result.DataSaldoInicial:= FDQuery.FieldByName('DATA_SALDO_INICIAL').AsDateTime;
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

function TConta.getBoletoConfiguracao: TBoletoConfiguracao;
begin
  if not Assigned(FBOLETOCONFIGURACAO) then
    FBOLETOCONFIGURACAO:= TBoletoConfiguracao.findByContaId(Self.Id);

  Result:= FBOLETOCONFIGURACAO;
end;

function TConta.getCedente: TCedente;
begin
  if not Assigned(FCEDENTE) then
    FCEDENTE:= TCedente.findByContaId(Self.Id);

  Result:= FCEDENTE;
end;

class procedure TConta.imprimirExtrato(pId: string;
                                       pDtInicial,
                                       pDtFinal: TDate;
                                       pDt: TFDMemTable);
var
  vEmpresa: TEmpresa;
  vConta: TConta;
  Print: TStringList;
  formPrint: TformPrint;
  vOldSaldo,
  vCreditos,
  vDebitos,
  vSaldo: Extended;
  vCount: Integer;
begin
  try
    vEmpresa:= nil;
    vConta:= nil;
    Print:= nil;
    try
      if not (pDt.RecordCount >= 1) then
        raise Exception.Create('Nenhum dado foi encontrado.');

      vEmpresa:= TEmpresa.find(TAuthService.getAuthenticatedEmpresaId);
      if not Assigned(vEmpresa) then
        raise Exception.Create('Falha ao consultar dados da empresa.');

      vConta:= TConta.find(pId);
      if not Assigned(vConta) then
        raise Exception.Create('Falha ao consultar dados da conta.');

      Print:= TStringList.Create;

      Print.Add('H|' +
                THelper.StrEsquerda('EXTRATO',18) +
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

      Print.Add('H|' + 'CONTA           : ' + vConta.Nome);
      Print.Add('H|' + 'PERIODO INICIAL : ' + FormatDateTime('dd/mm/yyyy', pDtInicial));
      Print.Add('H|' + 'PERIODO FINAL   : ' + FormatDateTime('dd/mm/yyyy', pDtFinal));

      Print.Add('H|' + StringOfChar('-', 88));

      Print.Add('H|' + THelper.StrEsquerda('DATA', 10) + ' ' +
                       THelper.StrEsquerda('CATEGORIA', 10) + ' ' +
                       THelper.StrEsquerda('PESSOA', 21) + ' ' +
                       THelper.StrEsquerda('DESCRICAO', 21) + ' ' +
                       THelper.StrDireita('VALOR', 10) + ' ' +
                       THelper.StrDireita('SALDO', 11));

      Print.Add('H|' + StringOfChar('-', 88));

      vCount:= pDt.RecordCount;
      vOldSaldo:= 0.9999;
      vCreditos:= 0;
      vDebitos:= 0;
      pDt.DisableControls;
      pDt.First;
      while not pDt.Eof do
      begin
        if (vOldSaldo = 0.9999) then
          vOldSaldo:= THelper.StringToExtended(pDt.FieldByName('SALDO').AsString);

        if (pDt.FieldByName('TIPO').AsString = 'E') then
          vCreditos:= (vCreditos + pDt.FieldByName('VALOR').AsExtended)
        else if (pDt.FieldByName('TIPO').AsString = 'S') then
          vDebitos:= (vDebitos + pDt.FieldByName('VALOR').AsExtended);

        Print.Add('D|' +
          THelper.StrEsquerda(pDt.FieldByName('DATA_VIEW').AsString, 10) + ' ' +
          THelper.StrEsquerda(pDt.FieldByName('CATEGORIA').AsString, 10) + ' ' +
          THelper.StrEsquerda(pDt.FieldByName('PESSOA').AsString, 21) + ' ' +
          THelper.StrEsquerda(pDt.FieldByName('REFERENTE').AsString, 21) + ' ' +
          THelper.StrDireita(pDt.FieldByName('VALOR_VIEW').AsString, 10) + ' ' +
          THelper.StrDireita(pDt.FieldByName('SALDO').AsString, 11));

        pDt.Next();
      end;
      pDt.First;
      pDt.EnableControls;

      vSaldo:= vOldSaldo + vCreditos - vDebitos;

      Print.Add('F|' + StringOfChar('-', 88));

      Print.Add('F|' + THelper.StrEsquerda('NUMERO DE LANCAMENTOS', 44) +
        THelper.StrDireita(vCount.ToString(), 44));
      Print.Add('F|' + THelper.StrEsquerda('SALDO ANTERIOR (R$)', 44) +
        THelper.StrDireita(THelper.ExtendedToString(vOldSaldo), 44));
      Print.Add('F|' + THelper.StrEsquerda('CRÉDITOS (R$)', 44) +
        THelper.StrDireita(THelper.ExtendedToString(vCreditos), 44));
      Print.Add('F|' + THelper.StrEsquerda('DÉBITOS (R$)', 44) +
        THelper.StrDireita(THelper.ExtendedToString(vDebitos), 44));
      Print.Add('F|' + THelper.StrEsquerda('SALDO (R$)', 44) +
        THelper.StrDireita(THelper.ExtendedToString(vSaldo), 44));

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
    if Assigned(vConta) then FreeAndNil(vConta);
    if Assigned(Print) then FreeAndNil(Print);
  end;
end;

class function TConta.list(search: string): TObjectList<TConta>;
const
  FSql: string =
  'SELECT ID FROM CONTAS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (DELETED_AT IS NULL) ' +
  'AND (NOME LIKE :SEARCH)';
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
        Result:= TObjectList<TConta>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TConta.find(FDQuery.FieldByName('ID').AsString));
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

class procedure TConta.list(search: string; DataSet: TFDMemTable);
var
  vList: TObjectList<TConta>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  vList:= TConta.list(search);
  if Assigned(vList) then
  begin
    for I:= 0 to Pred(vList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= vList.Items[I].Id;
      DataSet.FieldByName('NOME').AsString:= vList.Items[I].Nome;
      DataSet.FieldByName('SALDO').AsExtended:= vList.Items[I].SaldoInicial +
        vList.Items[I].saldo();
      DataSet.Post;
    end;
    FreeAndNil(vList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TConta.remove(id: string): Boolean;
var
  Conta: TConta;
begin
  Result:= False;
  Conta:= TConta.find(id);
  if not Assigned(Conta) then
  begin
    THelper.Mensagem('Conta não encontrado. A conta pode ter sido previamente excluída por outro usuário!');
    Exit();
  end;

  try
    if not THelper.Mensagem('Deseja realmente remover está conta?', 1) then
      Exit();

    Result:= Conta.delete();
  finally
    FreeAndNil(Conta);
  end;
end;

function TConta.saldo: Extended;
const
  FSql: string =
  'SELECT                                   ' +
  '  SUM(                                   ' +
  '      IIF(X.TIPO = :TIPOE, X.VALOR,0) -  ' +
  '      IIF(X.TIPO = :TIPOS, X.VALOR,0)    ' +
  '  ) AS SALDO                             ' +
  'FROM VIEW_CONTA_EXTRATO X                ' +
  'WHERE (X.EMPRESA_ID = :EMPRESA_ID)       ' +
  'AND (X.DATA BETWEEN :INICIAL AND :FINAL) ' +
  'AND (X.CONTA_ID = :CONTA_ID)             ';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery();
    try
      FDQuery.Close();
      FDQuery.SQL.Clear();
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('TIPOE').DataType:= ftString;
      FDQuery.Params.ParamByName('TIPOS').DataType:= ftString;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('INICIAL').DataType:= ftDate;
      FDQuery.Params.ParamByName('FINAL').DataType:= ftDate;
      FDQuery.Params.ParamByName('CONTA_ID').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('TIPOE').AsString:= 'E';
      FDQuery.Params.ParamByName('TIPOS').AsString:= 'S';
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('INICIAL').AsDate:= IncDay(Self.DataSaldoInicial);
      FDQuery.Params.ParamByName('FINAL').AsDate:= Now;
      FDQuery.Params.ParamByName('CONTA_ID').AsString:= Self.Id;
      FDQuery.Open();

      if not (FDQuery.RecordCount >= 1) then Result:= 0
      else Result:= FDQuery.FieldByName('SALDO').AsExtended;
    except
      Result:= 0;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TConta.saldoAnterior(ContaId: string; Dt: TDate): Extended;
const
  FSql: string =
  'SELECT                                   ' +
  '  SUM(                                   ' +
  '      IIF(X.TIPO = :TIPOE, X.VALOR,0) -  ' +
  '      IIF(X.TIPO = :TIPOS, X.VALOR,0)    ' +
  '  ) AS SALDO                             ' +
  'FROM VIEW_CONTA_EXTRATO X                ' +
  'WHERE (X.EMPRESA_ID = :EMPRESA_ID)       ' +
  'AND (X.DATA BETWEEN :INICIAL AND :FINAL) ' +
  'AND (X.CONTA_ID = :CONTA_ID)             ';
var
  FDQuery: TFDQuery;
  vConta: TConta;
begin
  try
    FDQuery:= Self.createQuery();
    try
      vConta:= TConta.find(ContaId);

      FDQuery.Close();
      FDQuery.SQL.Clear();
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('TIPOE').DataType:= ftString;
      FDQuery.Params.ParamByName('TIPOS').DataType:= ftString;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('INICIAL').DataType:= ftDate;
      FDQuery.Params.ParamByName('FINAL').DataType:= ftDate;
      FDQuery.Params.ParamByName('CONTA_ID').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('TIPOE').AsString:= 'E';
      FDQuery.Params.ParamByName('TIPOS').AsString:= 'S';
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= vConta.EmpresaId;
      FDQuery.Params.ParamByName('INICIAL').AsDate:= IncDay(vConta.DataSaldoInicial);
      FDQuery.Params.ParamByName('FINAL').AsDate:= Dt;
      FDQuery.Params.ParamByName('CONTA_ID').AsString:= vConta.Id;
      FDQuery.Open();

      if not (FDQuery.RecordCount >= 1) then Result:= 0
      else Result:= vConta.SaldoInicial + FDQuery.FieldByName('SALDO').AsExtended;
    except
      Result:= 0;
    end;
  finally
    FreeAndNil(vConta);
    FreeAndNil(FDQuery);
  end;
end;

function TConta.save: Boolean;
begin
  Result:= inherited;
end;

function TConta.store: Boolean;
const
  FSql: string =
  'INSERT INTO CONTAS (  ' +
  '  ID,                 ' +
  '  EMPRESA_ID,         ' +
  '  NOME,               ' +
  '  SALDO_INICIAL,      ' +
  '  DATA_SALDO_INICIAL, ' +
  '  CREATED_AT,         ' +
  '  UPDATED_AT)         ' +
  'VALUES (              ' +
  '  :ID,                ' +
  '  :EMPRESA_ID,        ' +
  '  :NOME,              ' +
  '  :SALDO_INICIAL,     ' +
  '  :DATA_SALDO_INICIAL,' +
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
      FDQuery.Params.ParamByName('NOME').DataType:= ftString;
      FDQuery.Params.ParamByName('SALDO_INICIAL').DataType:= ftExtended;
      FDQuery.Params.ParamByName('DATA_SALDO_INICIAL').DataType:= ftDate;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      FDQuery.Params.ParamByName('SALDO_INICIAL').AsExtended:= Self.SaldoInicial;
      FDQuery.Params.ParamByName('DATA_SALDO_INICIAL').AsDate:= Self.DataSaldoInicial;
      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao inserir a conta. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TConta.update: Boolean;
const
  FSql: string =
  'UPDATE CONTAS                                ' +
  'SET NOME = :NOME,                            ' +
  '    SALDO_INICIAL = :SALDO_INICIAL,          ' +
  '    DATA_SALDO_INICIAL = :DATA_SALDO_INICIAL,' +
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
      FDQuery.Params.ParamByName('SALDO_INICIAL').DataType:= ftExtended;
      FDQuery.Params.ParamByName('DATA_SALDO_INICIAL').DataType:= ftDate;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftString;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('NOME').AsString:= Self.Nome;
      FDQuery.Params.ParamByName('SALDO_INICIAL').AsExtended:= Self.SaldoInicial;
      FDQuery.Params.ParamByName('DATA_SALDO_INICIAL').AsDate:= Self.DataSaldoInicial;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: exception do
      begin
        Result:= False;
        raise Exception.Create('Falha ao atualizar a conta. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
