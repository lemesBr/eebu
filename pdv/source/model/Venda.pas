unit Venda;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  Pessoa, User, VendaItem, VendaRecebimento, Recebimento, System.StrUtils;

type
  TVenda = class(TModel)
  private
    FEMPRESA_ID: String;
    FPESSOA_ID: String;
    FUSER_ID: String;
    FMOVIMENTO_ID: String;
    FREFERENCIA: Integer;
    FCOMPETENCIA: TDateTime;
    FSUBTOTAL: Extended;
    FACRESCIMO: Extended;
    FDESCONTO: Extended;
    FTOTAL: Extended;
    FSITUACAO: String;

    FPESSOA: TPessoa;
    FUSER: TUser;
    FITENS: TObjectList<TVendaItem>;
    FRECEBIMENTOS: TObjectList<TVendaRecebimento>;
    FCONTARECEBER: TObjectList<TRecebimento>;

    function getPessoa: TPessoa;
    function getUser: TUser;
    function getItens: TObjectList<TVendaItem>;
    function getRecebimentos: TObjectList<TVendaRecebimento>;
    function getContaReceber: TObjectList<TRecebimento>;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function  save(): Boolean;
    procedure freeItens();
    function nfe: Boolean;
    class function find(Id: string): TVenda;
    class function findByMovimento(MovimentoId: string): TObjectList<TVenda>;
    class function findOpen(): TVenda;
    class procedure imprimir(Id: string);
    class function list(pSearch: string): TObjectList<TVenda>; overload;
    class procedure list(pSearch: string; pDt: TFDMemTable); overload;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property PessoaId: String  read FPESSOA_ID write FPESSOA_ID;
    property UserId: String  read FUSER_ID write FUSER_ID;
    property MovimentoId: String  read FMOVIMENTO_ID write FMOVIMENTO_ID;
    property Referencia: Integer  read FREFERENCIA write FREFERENCIA;
    property Competencia: TDateTime  read FCOMPETENCIA write FCOMPETENCIA;
    property Subtotal: Extended  read FSUBTOTAL write FSUBTOTAL;
    property Acrescimo: Extended  read FACRESCIMO write FACRESCIMO;
    property Desconto: Extended  read FDESCONTO write FDESCONTO;
    property Total: Extended  read FTOTAL write FTOTAL;
    property Situacao: String  read FSITUACAO write FSITUACAO;

    property Pessoa: TPessoa read getPessoa;
    property User: TUser read getUser;
    property Itens: TObjectList<TVendaItem> read getItens;
    property Recebimentos: TObjectList<TVendaRecebimento> read getRecebimentos;
    property ContaReceber: TObjectList<TRecebimento> read getContaReceber;
  end;

implementation

uses
  AuthService, Helper, Empresa;

{ TVenda }

constructor TVenda.Create;
begin
  Self.Table:= 'VENDAS';
end;

destructor TVenda.Destroy;
begin
  if Assigned(Self.FPESSOA) then FreeAndNil(Self.FPESSOA);
  if Assigned(Self.FUSER) then FreeAndNil(Self.FUSER);
  if Assigned(Self.FITENS) then FreeAndNil(Self.FITENS);
  if Assigned(Self.FRECEBIMENTOS) then FreeAndNil(Self.FRECEBIMENTOS);
  if Assigned(Self.FCONTARECEBER) then FreeAndNil(Self.FCONTARECEBER);

  inherited;
end;

class function TVenda.find(Id: string): TVenda;
const
  FSql: string = 'SELECT * FROM VENDAS WHERE (ID = :ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('ID').AsString:= Id;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TVenda.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.PessoaId:= FDQuery.FieldByName('PESSOA_ID').AsString;
        Result.UserId:= FDQuery.FieldByName('USER_ID').AsString;
        Result.MovimentoId:= FDQuery.FieldByName('MOVIMENTO_ID').AsString;
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

class function TVenda.findByMovimento(MovimentoId: string): TObjectList<TVenda>;
const
  FSql: string =
  'SELECT ID FROM VENDAS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (MOVIMENTO_ID = :MOVIMENTO_ID) ' +
  'AND (SITUACAO = :SITUACAO) ' +
  'AND (DELETED_AT IS NULL)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('MOVIMENTO_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('SITUACAO').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Params.ParamByName('MOVIMENTO_ID').AsString:= MovimentoId;
      FDQuery.Params.ParamByName('SITUACAO').AsString:= 'F';
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TObjectList<TVenda>.Create;
        FDQuery.First();
        while not FDQuery.Eof do
        begin
          Result.Add(TVenda.find(FDQuery.FieldByName('ID').AsString));
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

class function TVenda.findOpen: TVenda;
const
  FSql: string =
  'SELECT ID FROM VENDAS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (SITUACAO = :SITUACAO) ' +
  'AND (DELETED_AT IS NULL)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('SITUACAO').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Params.ParamByName('SITUACAO').AsString:= 'A';
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
        Result:= TVenda.find(FDQuery.FieldByName('ID').AsString);
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

procedure TVenda.freeItens;
begin
  FreeAndNil(FITENS);
end;

function TVenda.getContaReceber: TObjectList<TRecebimento>;
begin
  if not Assigned(Self.FCONTARECEBER) then
    Self.FCONTARECEBER:= TRecebimento.findByVenda(Self.Id);

  if not Assigned(Self.FCONTARECEBER) then
    Self.FCONTARECEBER:= TObjectList<TRecebimento>.Create;

  Result:= Self.FCONTARECEBER;
end;

function TVenda.getItens: TObjectList<TVendaItem>;
begin
  if not Assigned(FITENS) then
    Self.FITENS:= TVendaItem.findByVenda(Self.Id);

  Result:= Self.FITENS;
end;

function TVenda.getPessoa: TPessoa;
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

function TVenda.getRecebimentos: TObjectList<TVendaRecebimento>;
begin
  if not Assigned(Self.FRECEBIMENTOS) then
    Self.FRECEBIMENTOS:= TVendaRecebimento.findByVenda(Self.Id);

  if not Assigned(Self.FRECEBIMENTOS) then
    Self.FRECEBIMENTOS:= TObjectList<TVendaRecebimento>.Create;

  Result:= Self.FRECEBIMENTOS;
end;

function TVenda.getUser: TUser;
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

class procedure TVenda.imprimir(Id: string);
const
  unNormal: string = #27 + '!' + #00;
  unCompactado: string = #27 + '!' + #01;
  unCompactadoNegrito: string = #27 + '!' + #09;
  unNegrito: string = #27 + '!' + #08;
  unDuplaLinhha: string = #27 + '!' + #16;
  unSublinhado: string = #27 + '!' + #128;
  unExpandido: string = #27 + '!' + #32;

  unFonte: string = #27#77 + '1';
  unNGT  : string = #27 + '!' + #08;
  unCorte: string = chr(27)+'m';
var
  vEmpresa: TEmpresa;
  vVenda: TVenda;
  Print: TStringList;
  F: TextFile;
  I: Integer;
begin
  try
    vEmpresa:= nil;
    vVenda:= nil;
    Print:= nil;
    try
      vVenda:= TVenda.find(Id);
      if not Assigned(vVenda) then
        raise Exception.Create('Falha ao consultar dados da venda.');

      vEmpresa:= TEmpresa.find(vVenda.EmpresaId);
      if not Assigned(vEmpresa) then
        raise Exception.Create('Falha ao consultar dados da empresa.');

      Print:= TStringList.Create;
      Print.Add('-----------( COMPROVANTE NAO FISCAL )-----------');
      Print.Add(THelper.StrCentro(vEmpresa.Nome,48));
      Print.Add(THelper.StrCentro(vEmpresa.Logradouro + ' ' + vEmpresa.Numero,48));
      Print.Add(THelper.StrCentro(vEmpresa.Cep + ' - ' + vEmpresa.NomeMunicipio + ' - ' + vEmpresa.Uf,48));
      Print.Add(THelper.StrCentro('CNPJ:' + IfThen(vEmpresa.Documento.Length = 14, THelper.CNPJMask(vEmpresa.Documento), THelper.CPFMask(vEmpresa.Documento))  + ' - ' + 'IE: ' + vEmpresa.Ie,48));
      Print.Add(THelper.StrCentro('FONE: ' + THelper.FONEMask(vEmpresa.Fone),48));
      Print.Add(StringOfChar('-',48));

      Print.Add('PESSOA     : ' + vVenda.Pessoa.Nome);
      Print.Add('CPF/CNPJ   : ' + IfThen(vVenda.Pessoa.Documento.Length = 14, THelper.CNPJMask(vVenda.Pessoa.Documento), THelper.CPFMask(vVenda.Pessoa.Documento)));
      Print.Add('REFERENCIA : ' + IntToStr(vVenda.Referencia));
      Print.Add('DATA       : ' + FormatDateTime('dd/mm/yyyy',vVenda.Competencia));
      Print.Add(StringOfChar('-',48));
      Print.Add('ITEM                     UN  VALOR   QTD   TOTAL');
      Print.Add(StringOfChar('-',48));
      for I:= 0 to Pred(vVenda.Itens.Count) do
      begin
        Print.Add(
          THelper.StrEsquerda(vVenda.Itens.Items[I].Item.Nome,24) + ' ' +
            THelper.StrDireita(vVenda.Itens.Items[I].Item.Unidade,2) + ' ' +
              THelper.StrDireita(THelper.ExtendedToString(vVenda.Itens.Items[I].Unitario),6) + ' ' +
                THelper.StrDireita(THelper.ExtendedToString(vVenda.Itens.Items[I].Qtde,False),6) + ' ' +
                   THelper.StrDireita(THelper.ExtendedToString(vVenda.Itens.Items[I].Total),6));
      end;
      Print.Add(THelper.StrDireita('----------------------------',48));
      if (vVenda.Desconto > 0) or (vVenda.Acrescimo > 0) then
      begin
        Print.Add('SUBTOTAL R$' + THelper.StrDireita(THelper.ExtendedToString(vVenda.Subtotal),37));
        Print.Add('ACRESCIMO R$' + THelper.StrDireita(THelper.ExtendedToString(vVenda.Acrescimo),36));
        Print.Add('DESCONTO R$' + THelper.StrDireita(THelper.ExtendedToString(vVenda.Desconto),37));
        Print.Add(THelper.StrDireita('----------------------------',48));
      end;
      Print.Add('TOTAL R$' + THelper.StrDireita(THelper.ExtendedToString(vVenda.Total),40));

      TAuthService.vRecebido:= 0;
      TAuthService.vTroco:= 0;
      for I:= 0 to Pred(vVenda.Recebimentos.Count) do
      begin
        TAuthService.vRecebido:= TAuthService.vRecebido + vVenda.Recebimentos.Items[I].Recebido;
        TAuthService.vTroco:= TAuthService.vTroco + vVenda.Recebimentos.Items[I].Troco;

        Print.Add(THelper.StrEsquerda(THelper.FormaPagamentoToDescStr(vVenda.Recebimentos.Items[I].Tpag),24) +
          THelper.StrDireita(THelper.ExtendedToString(vVenda.Recebimentos.Items[I].Recebido),24));
      end;

      if (vVenda.Recebimentos.Count >= 2) and (TAuthService.vTroco > 0) then
        Print.Add('SOMA R$' + THelper.StrDireita(THelper.ExtendedToString(TAuthService.vRecebido),41));
      if TAuthService.vTroco > 0 then
        Print.Add('TROCO R$' + THelper.StrDireita(THelper.ExtendedToString(TAuthService.vTroco),40));

      Print.Add(StringOfChar('-',48));
      Print.Add(unCompactado + THelper.StrDireita('www.wtsystem.com.br',48));
      Print.Add(unCompactado + THelper.StrDireita('CUIABA - MT (65) 3028-3207 / 99293-3321', 48));

      for I:= 0 to 5 do
        Print.Add('');

      AssignFile(F, TAuthService.Terminal.PrintPath);
      Rewrite(F);

      for I:= 0 to Pred(Print.Count) do
        Writeln(F, unFonte, Print[I]);

      Writeln(F,unCorte);
      CloseFile(F);
    except on e: Exception do
      THelper.Mensagem('Falha ao imprimir venda. Erro ' + e.Message);
    end;
  finally
    FreeAndNil(vVenda);
    FreeAndNil(vEmpresa);
    FreeAndNil(Print);
  end;
end;

class function TVenda.list(pSearch: string): TObjectList<TVenda>;
const
  FSql: string =
  'SELECT V.ID FROM VENDAS V ' +
  'JOIN PESSOAS P ON((P.ID = V.PESSOA_ID) AND (P.EMPRESA_ID = V.EMPRESA_ID)) ' +
  'WHERE (V.EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (V.MOVIMENTO_ID = :MOVIMENTO_ID) ' +
  'AND (V.DELETED_AT IS NULL) ' +
  'AND (V.SITUACAO <> ''A'')' +
  'AND ((P.NOME LIKE :SEARCH) OR (V.REFERENCIA = :REFERENCIA)) ORDER BY V.REFERENCIA DESC';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('MOVIMENTO_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('SEARCH').DataType:= ftString;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Params.ParamByName('MOVIMENTO_ID').AsString:= TAuthService.Terminal.Movimento.Id;
      FDQuery.Params.ParamByName('SEARCH').AsString:= '%' + pSearch + '%';
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= StrToIntDef(pSearch, 0);
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TObjectList<TVenda>.Create;
        FDQuery.First();
        while not FDQuery.Eof do
        begin
          Result.Add(TVenda.find(FDQuery.FieldByName('ID').AsString));
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

class procedure TVenda.list(pSearch: string; pDt: TFDMemTable);
var
  vlist: TObjectList<TVenda>;
  I: Integer;
begin
  pDt.Open();
  pDt.DisableControls();
  pDt.EmptyDataSet();
  vlist:= TVenda.list(pSearch);
  if Assigned(vlist) then
  begin
    for I := 0 to Pred(vlist.Count) do
    begin
      pDt.Append();
      pDt.FieldByName('ID').AsString:= vlist.Items[I].Id;
      pDt.FieldByName('REFERENCIA').AsInteger:= vlist.Items[I].Referencia;
      pDt.FieldByName('COMPETENCIA').AsDateTime:= vlist.Items[I].CreatedAt;
      pDt.FieldByName('PESSOA').AsString:= vlist.Items[I].Pessoa.Nome;
      pDt.FieldByName('SUBTOTAL').AsExtended:= vlist.Items[I].Subtotal;
      pDt.FieldByName('ACRESCIMO').AsExtended:= vlist.Items[I].Acrescimo;
      pDt.FieldByName('DESCONTO').AsExtended:= vlist.Items[I].Desconto;
      pDt.FieldByName('TOTAL').AsExtended:= vlist.Items[I].Total;
      pDt.FieldByName('SITUACAO').AsString:= IfThen(vlist.Items[I].nfe(),'N', vlist.Items[I].Situacao);
      pDt.FieldByName('CHECK').AsInteger:= 0;
      pDt.Post();
    end;
    FreeAndNil(vlist);
  end;
  pDt.First();
  pDt.EnableControls();
end;

function TVenda.nfe: Boolean;
const
  FSql: string = 'SELECT COUNT(*) AS QTD FROM NFE_VENDAS WHERE (VENDA_ID = :ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('ID').AsString:= id;
      FDQuery.Open();

      Result:= (FDQuery.FieldByName('QTD').AsInteger >= 1);
    except
      Result:= False;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TVenda.save: Boolean;
begin
  Result:= inherited;
end;

function TVenda.store: Boolean;
const
  FSql: string =
  'INSERT INTO VENDAS ( ' +
  '  ID,                ' +
  '  EMPRESA_ID,        ' +
  '  PESSOA_ID,         ' +
  '  USER_ID,           ' +
  '  MOVIMENTO_ID,      ' +
  '  REFERENCIA,        ' +
  '  COMPETENCIA,       ' +
  '  SUBTOTAL,          ' +
  '  ACRESCIMO,         ' +
  '  DESCONTO,          ' +
  '  TOTAL,             ' +
  '  SITUACAO,          ' +
  '  CREATED_AT,        ' +
  '  UPDATED_AT)        ' +
  'VALUES (             ' +
  '  :ID,               ' +
  '  :EMPRESA_ID,       ' +
  '  :PESSOA_ID,        ' +
  '  :USER_ID,          ' +
  '  :MOVIMENTO_ID,     ' +
  '  :REFERENCIA,       ' +
  '  :COMPETENCIA,      ' +
  '  :SUBTOTAL,         ' +
  '  :ACRESCIMO,        ' +
  '  :DESCONTO,         ' +
  '  :TOTAL,            ' +
  '  :SITUACAO,         ' +
  '  :CREATED_AT,       ' +
  '  :UPDATED_AT)       ';
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
      FDQuery.Params.ParamByName('PESSOA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('USER_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('MOVIMENTO_ID').DataType:= ftString;
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
      Self.EmpresaId:= TAuthService.Terminal.EmpresaId;
      Self.UserId:= TAuthService.Terminal.Movimento.OperadorId;
      Self.MovimentoId:= TAuthService.Terminal.Movimento.Id;
      Self.Referencia:= nextReferencia(Self.Referencia);

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('PESSOA_ID').AsString:= Self.PessoaId;
      FDQuery.Params.ParamByName('USER_ID').AsString:= Self.UserId;
      FDQuery.Params.ParamByName('MOVIMENTO_ID').AsString:= Self.MovimentoId;
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
    except on e: exception do
    begin
      Result:= False;
      raise Exception.Create('Falha ao gravar dados do venda. Erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TVenda.update: Boolean;
const
  FSql: string =
  'UPDATE VENDAS                    ' +
  'SET PESSOA_ID = :PESSOA_ID,      ' +
  '    MOVIMENTO_ID = :MOVIMENTO_ID,' +
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
begin
  Result:= True;
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('PESSOA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('MOVIMENTO_ID').DataType:= ftString;
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
      FDQuery.Params.ParamByName('MOVIMENTO_ID').AsString:= Self.MovimentoId;
      FDQuery.Params.ParamByName('COMPETENCIA').AsDate:= Self.Competencia;
      FDQuery.Params.ParamByName('SUBTOTAL').AsExtended:= Self.Subtotal;
      FDQuery.Params.ParamByName('ACRESCIMO').AsExtended:= Self.Acrescimo;
      FDQuery.Params.ParamByName('DESCONTO').AsExtended:= Self.Desconto;
      FDQuery.Params.ParamByName('TOTAL').AsExtended:= Self.Total;
      FDQuery.Params.ParamByName('SITUACAO').AsString:= Self.Situacao;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL();
    except on e: exception do
    begin
      Result:= False;
      raise Exception.Create('Falha ao gravar dados do venda. Erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
