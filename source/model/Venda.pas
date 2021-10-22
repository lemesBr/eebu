unit Venda;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  VendaItem, Pessoa, User, VendaRecebimento, System.StrUtils, ACBrUtil;

type
  TVenda = class(TModel)
  private
    FEMPRESA_ID: String;
    FPESSOA_ID: String;
    FUSER_ID: String;
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

    function getPessoa: TPessoa;
    function getUser: TUser;
    function getItens: TObjectList<TVendaItem>;
    function getRecebimentos: TObjectList<TVendaRecebimento>;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    function delete(): Boolean;
    function nfe: Boolean;
    function boleto: Boolean;
    class function find(id: string): TVenda;
    class function list(pSituacao: Integer;
                        pDtInicial,
                        pDtFinal: TDate;
                        pPessoaId,
                        pUserId,
                        pSearch: string): TObjectList<TVenda>; overload;
    class procedure list(pSituacao: Integer;
                         pDtInicial,
                         pDtFinal: TDate;
                         pPessoaId,
                         pUserId,
                         pSearch: string; pDt: TFDMemTable); overload;
    class function remove(id: string): Boolean;
    class procedure listItens(id: string; DataSet: TFDMemTable);
    class procedure imprimir(Id: string; Modo: Integer = 0); overload;
    class procedure imprimir(pSituacao: Integer;
                             pDtInicial,
                             pDtFinal: TDate;
                             pPessoaId,
                             pUserId,
                             pSearch: string); overload;
    class function unicPessoa(lvendaId: string): Boolean;
    class function updatePessoa(VendaId, PessoaId: string): Boolean;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property PessoaId: String  read FPESSOA_ID write FPESSOA_ID;
    property UserId: String  read FUSER_ID write FUSER_ID;
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

  end;

implementation

uses
  AuthService, Helper, Empresa, uformPrint;

{ TVenda }

function TVenda.boleto: Boolean;
const
  FSql: string =
  'SELECT COUNT(*) AS QTD FROM RECEBIMENTOS ' +
  'WHERE (VENDA_ID = :ID) ' +
  'AND (BOLETO IS NOT NULL)';
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

      Result:= (FDQuery.FieldByName('QTD').AsInteger >= 1);
    except
      Result:= False;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

constructor TVenda.Create;
begin
  Self.Table:= 'VENDAS';
end;

function TVenda.delete: Boolean;
const
  FSql: string =
  'UPDATE VENDAS                    ' +
  'SET UPDATED_AT = :UPDATED_AT,    ' +
  '    DELETED_AT = :DELETED_AT,    ' +
  '    SYNCHRONIZED = :SYNCHRONIZED ' +
  'WHERE (ID = :ID)                 ';

  FVITEMSql: string =
  'UPDATE VENDA_ITENS               ' +
  'SET UPDATED_AT = :UPDATED_AT,    ' +
  '    DELETED_AT = :DELETED_AT,    ' +
  '    SYNCHRONIZED = :SYNCHRONIZED ' +
  'WHERE (VENDA_ID = :VENDA_ID)     ';

  FVRECEBIMENTOSql: string =
  'UPDATE VENDA_RECEBIMENTOS        ' +
  'SET UPDATED_AT = :UPDATED_AT,    ' +
  '    DELETED_AT = :DELETED_AT,    ' +
  '    SYNCHRONIZED = :SYNCHRONIZED ' +
  'WHERE (VENDA_ID = :VENDA_ID)     ';

  FRECEBIMENTOSql: string =
  'UPDATE RECEBIMENTOS              ' +
  'SET UPDATED_AT = :UPDATED_AT,    ' +
  '    DELETED_AT = :DELETED_AT,    ' +
  '    SYNCHRONIZED = :SYNCHRONIZED ' +
  'WHERE (VENDA_ID = :VENDA_ID)     ';
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
      FDQuery.SQL.Add(FVITEMSql);
      FDQuery.Params.ParamByName('VENDA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('DELETED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('VENDA_ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('DELETED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;

      FDQuery.SQL.Clear;
      FDQuery.SQL.Add(FVRECEBIMENTOSql);
      FDQuery.Params.ParamByName('VENDA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('DELETED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('VENDA_ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('DELETED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;

      FDQuery.SQL.Clear;
      FDQuery.SQL.Add(FRECEBIMENTOSql);
      FDQuery.Params.ParamByName('VENDA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('DELETED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('VENDA_ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('DELETED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;

      FDQuery.SQL.Clear;
      FDQuery.SQL.Add('DELETE FROM NFE_VENDAS WHERE VENDA_ID = :VENDA_ID');
      FDQuery.Params.ParamByName('VENDA_ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('VENDA_ID').AsString:= Self.Id;
      FDQuery.ExecSQL();

      Self.Commit;
    except on e: exception do
      begin
        Self.Rollback;
        Result:= False;
        raise Exception.Create('Falha ao remover a venda. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

destructor TVenda.Destroy;
begin
  if Assigned(Self.FPESSOA) then FreeAndNil(Self.FPESSOA);
  if Assigned(Self.FUSER) then FreeAndNil(Self.FUSER);
  if Assigned(Self.FITENS) then FreeAndNil(Self.FITENS);
  if Assigned(Self.FRECEBIMENTOS) then FreeAndNil(Self.FRECEBIMENTOS);

  inherited;
end;

class function TVenda.find(id: string): TVenda;
const
  FSql: string = 'SELECT * FROM VENDAS WHERE (ID = :ID)';
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
        Result:= TVenda.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.PessoaId:= FDQuery.FieldByName('PESSOA_ID').AsString;
        Result.UserId:= FDQuery.FieldByName('USER_ID').AsString;
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

function TVenda.getItens: TObjectList<TVendaItem>;
begin
  if not Assigned(FITENS) and (Self.Id <> EmptyStr) then
    Self.FITENS:= TVendaItem.findByVendaId(Self.Id);

  if not Assigned(FITENS) then
    Self.FITENS:= TObjectList<TVendaItem>.Create;

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
  if not Assigned(FRECEBIMENTOS) and (Self.Id <> EmptyStr) then
    Self.FRECEBIMENTOS:= TVendaRecebimento.findByVendaId(Self.Id);

  if not Assigned(FRECEBIMENTOS) then
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

class procedure TVenda.imprimir(pSituacao: Integer;
                                pDtInicial,
                                pDtFinal: TDate;
                                pPessoaId,
                                pUserId,
                                pSearch: string);
var
  vEmpresa: TEmpresa;
  vPessoa: TPessoa;
  vUser: TUser;
  vList: TObjectList<TVenda>;
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

      vList:= TVenda.list(pSituacao,
                          pDtInicial,
                          pDtFinal,
                          pPessoaId,
                          pUserId,
                          pSearch);

      if not Assigned(vList) then
        raise Exception.Create('Nenhum dado foi encontrado.');

      Print:= TStringList.Create;

      Print.Add('H|' +
                THelper.StrEsquerda('VENDAS',18) +
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
        Print.Add('H|' + 'VENDEDOR        : ' + vUser.Nome);

      vPessoa:= TPessoa.find(pPessoaId);
      if Assigned(vPessoa) then
        Print.Add('H|' + 'PESSOA          : ' + vPessoa.Nome);

      Print.Add('H|' + StringOfChar('-', 88));

      if Assigned(vPessoa) then
      begin
        Print.Add('H|' + THelper.StrEsquerda('REFERENCIA', 10) + ' ' +
                         THelper.StrEsquerda('COMPETENCIA', 12) + ' ' +
                         THelper.StrEsquerda('VENDEDOR', 50) + ' ' +
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
                         THelper.StrEsquerda('VENDEDOR', 15) + ' ' +
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

      Print.Add('F|' + THelper.StrEsquerda('VENDAS', 44) +
        THelper.StrDireita(vCount.ToString(), 44));
      Print.Add('F|' + THelper.StrEsquerda('TOTAL VENDIDO (R$)', 44) +
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

class procedure TVenda.imprimir(Id: string; Modo: Integer);
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
  formPrint: TformPrint;
  F: TextFile;
  I: Integer;
begin
  try
    vEmpresa:= nil;
    vVenda:= nil;
    try
      vEmpresa:= TEmpresa.find(TAuthService.getAuthenticatedEmpresaId);
      if not Assigned(vEmpresa) then
        raise Exception.Create('Falha ao consultar dados da empresa.');

      vVenda:= TVenda.find(id);
      if not Assigned(vVenda) then
        raise Exception.Create('Falha ao consultar dados da venda.');

      Print:= TStringList.Create;
      case Modo of
        0: begin
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
                THelper.StrDireita(vVenda.Itens.Items[I].Item.Unidade.Unidade,2) + ' ' +
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
          Print.Add(unCompactado + THelper.StrDireita('Cuiaba - MT (65) 3028-3207 / 99293-3321', 48));

          for I:= 0 to 5 do
            Print.Add('');

          AssignFile(F,TAuthService.getAuthenticatedConfig.PrintPath);
          Rewrite(F);
          for I := 0 to Pred(Print.Count) do
            Writeln(F, unFonte, Print[I]);

          Writeln(F,unCorte);
          CloseFile(F);
        end;
        1: begin
          Print.Add('H|' +
                    THelper.StrEsquerda('COMPROVANTE DE VENDA',28) +
                    THelper.StrDireita(FormatDateTime('dd/mm/yyyy',Now),60));

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

          Print.Add('H|' + 'PESSOA     : ' + vVenda.Pessoa.Nome);
          Print.Add('H|' + 'CPF/CNPJ   : ' +
                           IfThen(vVenda.Pessoa.Documento.Length = 14,
                           THelper.CNPJMask(vVenda.Pessoa.Documento),
                           THelper.CPFMask(vVenda.Pessoa.Documento)));
          Print.Add('H|' + 'REFERENCIA : ' + IntToStr(vVenda.Referencia));
          Print.Add('H|' + 'DATA       : ' + FormatDateTime('dd/mm/yyyy',vVenda.Competencia));

          Print.Add('H|' + StringOfChar('-', 88));

          Print.Add('H|' + THelper.StrEsquerda('CODIGO', 6) + ' ' +
                           THelper.StrEsquerda('ITEM', 40) + ' ' +
                           THelper.StrDireita('MEDIDA', 6) + ' ' +
                           THelper.StrDireita('UNIT', 10) + ' ' +
                           THelper.StrDireita('QTD', 10) + ' ' +
                           THelper.StrDireita('SUB', 11));

          Print.Add('H|' + StringOfChar('-', 88));

          for I:= 0 to Pred(vVenda.Itens.Count) do
          begin
            Print.Add('D|' +
              THelper.StrEsquerda(vVenda.Itens.Items[I].Item.Referencia.ToString(), 6) + ' ' +
                THelper.StrEsquerda(vVenda.Itens.Items[I].Item.Nome,40) + ' ' +
                  THelper.StrDireita(vVenda.Itens.Items[I].Item.Unidade.Unidade, 6) + ' ' +
                    THelper.StrDireita(THelper.ExtendedToString(vVenda.Itens.Items[I].Unitario), 10) + ' ' +
                      THelper.StrDireita(THelper.ExtendedToString(vVenda.Itens.Items[I].Qtde,False), 10) + ' ' +
                        THelper.StrDireita(THelper.ExtendedToString(vVenda.Itens.Items[I].Total), 11));
          end;
          Print.Add('F|' + THelper.StrDireita('----------------------------', 88));
          if (vVenda.Desconto > 0) or (vVenda.Acrescimo > 0) then
          begin
            Print.Add('F|' + 'SUBTOTAL R$' + THelper.StrDireita(THelper.ExtendedToString(vVenda.Subtotal), 77));
            Print.Add('F|' + 'ACRESCIMO R$' + THelper.StrDireita(THelper.ExtendedToString(vVenda.Acrescimo), 76));
            Print.Add('F|' + 'DESCONTO R$' + THelper.StrDireita(THelper.ExtendedToString(vVenda.Desconto), 77));
            Print.Add('F|' + THelper.StrDireita('----------------------------', 88));
          end;
          Print.Add('F|' + 'TOTAL R$' + THelper.StrDireita(THelper.ExtendedToString(vVenda.Total), 80));

          TAuthService.vRecebido:= 0;
          TAuthService.vTroco:= 0;
          for I:= 0 to Pred(vVenda.Recebimentos.Count) do
          begin
            TAuthService.vRecebido:= TAuthService.vRecebido + vVenda.Recebimentos.Items[I].Recebido;
            TAuthService.vTroco:= TAuthService.vTroco + vVenda.Recebimentos.Items[I].Troco;

            Print.Add('F|' + THelper.StrEsquerda(THelper.FormaPagamentoToDescStr(vVenda.Recebimentos.Items[I].Tpag), 44) +
              THelper.StrDireita(THelper.ExtendedToString(vVenda.Recebimentos.Items[I].Recebido), 44));
          end;

          if (vVenda.Recebimentos.Count >= 2) and (TAuthService.vTroco > 0) then
            Print.Add('F|' + 'SOMA R$' + THelper.StrDireita(THelper.ExtendedToString(TAuthService.vRecebido), 81));
          if TAuthService.vTroco > 0 then
            Print.Add('F|' + 'TROCO R$' + THelper.StrDireita(THelper.ExtendedToString(TAuthService.vTroco), 80));

          Print.Add('F|' + StringOfChar('-',88));
          Print.Add('F|' + THelper.StrDireita('WWW.WTSYSTEM.COM.BR', 88));
          Print.Add('F|' + THelper.StrDireita('CUIABA - MT (65) 3028-3207 / 99293-3321', 88));

          for I:= 0 to 3 do
            Print.Add('F|' + '');

          Print.Add('F|' + THelper.StrCentro('----------------------------', 88));
          Print.Add('F|' + THelper.StrCentro('ASSINATURA', 88));

          try
            formPrint:= TformPrint.Create(nil);
            formPrint.Print(Print);
          finally
            FreeAndNil(formPrint);
          end;
        end;
      end;
    except on e: Exception do
      raise Exception.Create('Falha ao imprimir. Erro: ' + e.Message);
    end;
  finally
    if Assigned(vEmpresa) then FreeAndNil(vEmpresa);
    if Assigned(vVenda) then FreeAndNil(vVenda);
    if Assigned(Print) then FreeAndNil(Print);
  end;
end;

class function TVenda.list(pSituacao: Integer;
                           pDtInicial,
                           pDtFinal: TDate;
                           pPessoaId,
                           pUserId,
                           pSearch: string): TObjectList<TVenda>;
var
  FSql: string;
  FDQuery: TFDQuery;
  vReferencia: Integer;
begin
  try
    FDQuery:= Self.createQuery;
    try
      vReferencia:= StrToIntDef(pSearch, 0);

      FSql:= 'SELECT V.ID FROM VENDAS V ' +
      'WHERE (V.EMPRESA_ID = :EMPRESA_ID) AND (V.DELETED_AT IS NULL) ' +
      'AND (V.COMPETENCIA BETWEEN :DTINICIAL AND :DTFINAL) ' +
      'AND (V.SITUACAO = :SITUACAO) ';

      if (pPessoaId <> '') then
        FSql:= FSql + 'AND (V.PESSOA_ID = :PESSOA_ID) ';

      if (pUserId <> '') then
        FSql:= FSql + 'AND (V.USER_ID = :USER_ID) ';

      if (vReferencia >= 1) then
        FSql:= FSql + 'AND (V.REFERENCIA = :REFERENCIA) ';

      FSql:= FSql + 'ORDER BY V.COMPETENCIA DESC, V.REFERENCIA DESC';
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
        Result:= TObjectList<TVenda>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TVenda.find(FDQuery.FieldByName('ID').AsString));
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

class procedure TVenda.list(pSituacao: Integer;
                            pDtInicial,
                            pDtFinal: TDate;
                            pPessoaId,
                            pUserId,
                            pSearch: string;
                            pDt: TFDMemTable);
var
  vList: TObjectList<TVenda>;
  I: Integer;
begin
  pDt.Open();
  pDt.DisableControls;
  pDt.EmptyDataSet;
  vList:= Self.list(pSituacao,
                    pDtInicial,
                    pDtFinal,
                    pPessoaId,
                    pUserId,
                    pSearch);
  if Assigned(vList) then
  begin
    for I := 0 to Pred(vList.Count) do
    begin
      pDt.Append;
      pDt.FieldByName('ID').AsString:= vList.Items[I].Id;
      pDt.FieldByName('REFERENCIA').AsInteger:= vList.Items[I].Referencia;
      pDt.FieldByName('COMPETENCIA').AsDateTime:= vList.Items[I].Competencia;
      pDt.FieldByName('SUBTOTAL').AsExtended:= vList.Items[I].Subtotal;
      pDt.FieldByName('ACRESCIMO').AsExtended:= vList.Items[I].Acrescimo;
      pDt.FieldByName('DESCONTO').AsExtended:= vList.Items[I].Desconto;
      pDt.FieldByName('TOTAL').AsExtended:= vList.Items[I].Total;
      pDt.FieldByName('PESSOA').AsString:= vList.Items[I].Pessoa.Nome;
      pDt.FieldByName('VENDEDOR').AsString:= vList.Items[I].User.Nome;
      pDt.FieldByName('NFE').AsString:= IfThen(vList.Items[I].nfe, 'S', 'N');
      pDt.FieldByName('BOLETO').AsString:= IfThen(vList.Items[I].boleto, 'S', 'N');
      pDt.Post;
    end;
    FreeAndNil(vList);
  end;
  pDt.First;
  pDt.EnableControls;
end;

class procedure TVenda.listItens(id: string; DataSet: TFDMemTable);
var
  vList: TObjectList<TVendaItem>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  vList:= TVendaItem.findByVendaId(id);
  if Assigned(vList) then
  begin
    for I := 0 to Pred(vList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ITEM_ID').AsString:= vList.Items[I].ItemId;
      DataSet.FieldByName('ITEM_REFERENCIA').AsInteger:= vList.Items[I].Item.Referencia;
      DataSet.FieldByName('ITEM_NOME').AsString:= vList.Items[I].Item.Nome;
      if Assigned(vList.Items[I].Item.Unidade) then
        DataSet.FieldByName('ITEM_UNIDADE').AsString:= vList.Items[I].Item.Unidade.Unidade;
      DataSet.FieldByName('UNITARIO').AsExtended:= vList.Items[I].Unitario;
      DataSet.FieldByName('QTDE').AsExtended:= vList.Items[I].Qtde;
      DataSet.FieldByName('SUBTOTAL').AsExtended:= vList.Items[I].Subtotal;
      DataSet.FieldByName('ACRESCIMO').AsExtended:= vList.Items[I].Acrescimo;
      DataSet.FieldByName('DESCONTO').AsExtended:= vList.Items[I].Desconto;
      DataSet.FieldByName('TOTAL').AsExtended:= vList.Items[I].Total;
      DataSet.Post;
    end;
    FreeAndNil(vList);
  end;
  DataSet.First;
  DataSet.EnableControls;
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
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
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

class function TVenda.remove(id: string): Boolean;
var
  Venda: TVenda;
begin
  Result:= False;
  Venda:= TVenda.find(id);
  if not Assigned(Venda) then
  begin
    THelper.Mensagem('Venda não encontrada. A venda pode ter sido previamente removida por outro usuário!');
    Exit();
  end;

  try
    if not THelper.Mensagem('Deseja realmente remover?', 1) then
      Exit();

    Result:= Venda.delete();
  finally
    FreeAndNil(Venda);
  end;
end;

function TVenda.save: Boolean;
begin
  Result:= inherited;
end;

function TVenda.store: Boolean;
const
  FSql: string =
  'INSERT INTO VENDAS (' +
  '  ID,               ' +
  '  EMPRESA_ID,       ' +
  '  PESSOA_ID,        ' +
  '  USER_ID,          ' +
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
  vCtModalidade: Integer;
begin
  Result:= True;
  try
    Self.StartTransaction;
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PESSOA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('USER_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('COMPETENCIA').DataType:= ftDate;
      FDQuery.Params.ParamByName('SUBTOTAL').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('ACRESCIMO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('DESCONTO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('TOTAL').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('SITUACAO').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;
      Self.Referencia:= Self.nextReferencia(Self.Referencia);

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      if (Self.PessoaId <> EmptyStr) then
      FDQuery.Params.ParamByName('PESSOA_ID').AsString:= Self.PessoaId;
      FDQuery.Params.ParamByName('USER_ID').AsString:= Self.UserId;
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= Self.Referencia;
      FDQuery.Params.ParamByName('COMPETENCIA').AsDate:= Self.Competencia;
      FDQuery.Params.ParamByName('SUBTOTAL').AsFMTBCD:= Self.Subtotal;
      FDQuery.Params.ParamByName('ACRESCIMO').AsFMTBCD:= Self.Acrescimo;
      FDQuery.Params.ParamByName('DESCONTO').AsFMTBCD:= Self.Desconto;
      FDQuery.Params.ParamByName('TOTAL').AsFMTBCD:= Self.Total;
      FDQuery.Params.ParamByName('SITUACAO').AsString:= Self.Situacao;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;

      for I:= 0 to Pred(Self.Itens.Count) do
      begin
        Self.Itens.Items[I].VendaId:= Self.Id;
        Self.Itens.Items[I].UserId:= Self.UserId;
        Self.Itens.Items[I].save();
      end;

      if (Self.Situacao = 'A') then
      begin
        Self.Recebimentos.Clear();
        FreeAndNil(TAuthService.listCtRecebimento);
      end;

      for I:= 0 to Pred(Self.Recebimentos.Count) do
      begin
        Self.Recebimentos.Items[I].VendaId:= Self.Id;
        Self.Recebimentos.Items[I].save();
      end;

      if Assigned(TAuthService.listCtRecebimento) then
      begin
        for I:= 0 to Pred(TAuthService.listCtRecebimento.Count) do
        begin
          TAuthService.listCtRecebimento.Items[I].PessoaId:= Self.PessoaId;
          TAuthService.listCtRecebimento.Items[I].VendaId:= Self.Id;

          vCtModalidade:= AnsiIndexStr(
            TAuthService.listCtRecebimento.Items[I].Cartao.Modalidade,
            ['X','C','D','A','R','P','T']
          );

          if (TAuthService.listCtRecebimento.Items[I].Modalidade = 'C') and
            (vCtModalidade in[0,1])  then
          begin
            TAuthService.listCtRecebimento.Items[I].Descricao:=
              TAuthService.listCtRecebimento.Items[I].Parcela.ToString() + '/' +
                TAuthService.listCtRecebimento.Items[I].QtdeParcelas.ToString() + ' - ' +
                  TAuthService.listCtRecebimento.Items[I].Cartao.Nome +
                    ' CREDITO' + ' - VENDA ' + Self.Referencia.ToString();
          end
          else
          begin
            TAuthService.listCtRecebimento.Items[I].Descricao:=
              TAuthService.listCtRecebimento.Items[I].Cartao.Nome +
                IfThen(vCtModalidade in[0,2], ' DEBITO', '') + ' - VENDA ' + Self.Referencia.ToString();
          end;

          TAuthService.listCtRecebimento.Items[I].save();
        end;
      end;

      Self.Commit;
    except on e: exception do
    begin
      Self.Rollback;
      Result:= False;
      raise Exception.Create('Falha ao inserir a venda. Erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TVenda.unicPessoa(lvendaId: string): Boolean;
var
  FSql: string;
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FSql:= 'SELECT COUNT(DISTINCT V.PESSOA_ID) AS QTD FROM VENDAS V WHERE V.ID IN(' + lvendaId + ')';
      FDQuery.SQL.Add(FSql);
      FDQuery.Prepare;
      FDQuery.Open();

      Result:= (FDQuery.FieldByName('QTD').AsInteger = 1);
    except
      Result:= False;
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
  '    USER_ID = :USER_ID,          ' +
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
  vCtModalidade: Integer;
begin
  Result:= True;
  try
    Self.StartTransaction;
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('PESSOA_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('USER_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('COMPETENCIA').DataType:= ftDate;
      FDQuery.Params.ParamByName('SUBTOTAL').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('ACRESCIMO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('DESCONTO').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('TOTAL').DataType:= ftFMTBcd;
      FDQuery.Params.ParamByName('SITUACAO').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.PessoaId <> EmptyStr) then
      FDQuery.Params.ParamByName('PESSOA_ID').AsString:= Self.PessoaId;
      FDQuery.Params.ParamByName('USER_ID').AsString:= Self.UserId;
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= Self.Referencia;
      FDQuery.Params.ParamByName('COMPETENCIA').AsDate:= Self.Competencia;
      FDQuery.Params.ParamByName('SUBTOTAL').AsFMTBCD:= Self.Subtotal;
      FDQuery.Params.ParamByName('ACRESCIMO').AsFMTBCD:= Self.Acrescimo;
      FDQuery.Params.ParamByName('DESCONTO').AsFMTBCD:= Self.Desconto;
      FDQuery.Params.ParamByName('TOTAL').AsFMTBCD:= Self.Total;
      FDQuery.Params.ParamByName('SITUACAO').AsString:= Self.Situacao;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;

      FDQuery.Close();
      FDQuery.SQL.Clear();
      FDQuery.SQL.Add('DELETE FROM VENDA_ITENS WHERE (VENDA_ID = :VENDA_ID) AND  (EMPRESA_ID = :EMPRESA_ID)');
      FDQuery.Params.ParamByName('VENDA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('VENDA_ID').AsString:=  Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.ExecSQL();

      FDQuery.Close();
      FDQuery.SQL.Clear();
      FDQuery.SQL.Add('DELETE FROM VENDA_RECEBIMENTOS WHERE (VENDA_ID = :VENDA_ID) AND  (EMPRESA_ID = :EMPRESA_ID)');
      FDQuery.Params.ParamByName('VENDA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('VENDA_ID').AsString:=  Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.ExecSQL();

      FDQuery.Close();
      FDQuery.SQL.Clear();
      FDQuery.SQL.Add('DELETE FROM RECEBIMENTOS WHERE (VENDA_ID = :VENDA_ID) AND  (EMPRESA_ID = :EMPRESA_ID)');
      FDQuery.Params.ParamByName('VENDA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('VENDA_ID').AsString:=  Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.getAuthenticatedEmpresaId;
      FDQuery.ExecSQL();

      for I:= 0 to Pred(Self.Itens.Count) do
      begin
        Self.Itens.Items[I].VendaId:= Self.Id;
        Self.Itens.Items[I].UserId:= Self.UserId;
        Self.Itens.Items[I].save();
      end;

      if (Self.Situacao = 'A') then
      begin
        Self.Recebimentos.Clear();
        FreeAndNil(TAuthService.listCtRecebimento);
      end;

      for I:= 0 to Pred(Self.Recebimentos.Count) do
      begin
        Self.Recebimentos.Items[I].VendaId:= Self.Id;
        Self.Recebimentos.Items[I].save();
      end;

      if Assigned(TAuthService.listCtRecebimento) then
      begin
        for I:= 0 to Pred(TAuthService.listCtRecebimento.Count) do
        begin
          TAuthService.listCtRecebimento.Items[I].PessoaId:= Self.PessoaId;
          TAuthService.listCtRecebimento.Items[I].VendaId:= Self.Id;

          vCtModalidade:= AnsiIndexStr(
            TAuthService.listCtRecebimento.Items[I].Cartao.Modalidade,
            ['X','C','D','A','R','P','T']
          );

          if (TAuthService.listCtRecebimento.Items[I].Modalidade = 'C') and
            (vCtModalidade in[0,1])  then
          begin
            TAuthService.listCtRecebimento.Items[I].Descricao:=
              TAuthService.listCtRecebimento.Items[I].Parcela.ToString() + '/' +
                TAuthService.listCtRecebimento.Items[I].QtdeParcelas.ToString() + ' - ' +
                  TAuthService.listCtRecebimento.Items[I].Cartao.Nome +
                    ' CREDITO' + ' - VENDA ' + Self.Referencia.ToString();
          end
          else
          begin
            TAuthService.listCtRecebimento.Items[I].Descricao:=
              TAuthService.listCtRecebimento.Items[I].Cartao.Nome +
                IfThen(vCtModalidade in[0,2], ' DEBITO', '') + ' - VENDA ' + Self.Referencia.ToString();
          end;

          TAuthService.listCtRecebimento.Items[I].save();
        end;
      end;

      Self.Commit;
    except on e: exception do
    begin
      Self.Rollback;
      Result:= False;
      raise Exception.Create('Falha ao atualizar a venda. Erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TVenda.updatePessoa(VendaId, PessoaId: string): Boolean;
var
  FDQuery: TFDQuery;
  vSql: string;
begin
  Result:= True;
  try
    TVenda.StartTransaction;
    FDQuery:= TVenda.createQuery;
    try
      vSql:=
        'UPDATE VENDAS SET PESSOA_ID = :PESSOA_ID ' +
        'WHERE ID = :VENDA_ID';
      FDQuery.Close();
      FDQuery.SQL.Clear();
      FDQuery.SQL.Add(vSql);
      FDQuery.Params.ParamByName('PESSOA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('VENDA_ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('PESSOA_ID').AsString:= PessoaId;
      FDQuery.Params.ParamByName('VENDA_ID').AsString:= VendaId;
      FDQuery.ExecSQL();

      vSql:=
        'UPDATE RECEBIMENTOS SET PESSOA_ID = :PESSOA_ID ' +
        'WHERE VENDA_ID = :VENDA_ID';
      FDQuery.Close();
      FDQuery.SQL.Clear();
      FDQuery.SQL.Add(vSql);
      FDQuery.Params.ParamByName('PESSOA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('VENDA_ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('PESSOA_ID').AsString:= PessoaId;
      FDQuery.Params.ParamByName('VENDA_ID').AsString:= VendaId;
      FDQuery.ExecSQL();

      TVenda.Commit;
    except on e: exception do
      begin
        TVenda.Rollback;
        Result:= False;
        raise Exception.Create('Falha ao atualizar. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
