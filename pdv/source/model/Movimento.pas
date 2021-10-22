unit Movimento;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  User, MovimentoFechamento, Suprimento, Sangria, Venda, System.StrUtils,
  System.Math, MovimentoResumo, Nfe;

type
  TMovimento = class(TModel)
  private
    FEMPRESA_ID: String;
    FTERMINAL_ID: String;
    FTURNO_ID: String;
    FOPERADOR_ID: String;
    FGERENTE_ID: String;
    FREFERENCIA: Integer;
    FABERTURA: TDateTime;
    FFECHAMENTO: TDateTime;
    FSUPRIMENTO: Extended;
    FSANGRIA: Extended;
    FSUBTOTAL: Extended;
    FACRESCIMO: Extended;
    FDESCONTO: Extended;
    FTOTAL: Extended;
    FRECEBIDO: Extended;
    FTROCO: Extended;
    FSITUACAO: String;

    FOPERADOR: TUser;
    FGERENTE: TUser;

    FSUPRIMENTOS: TObjectList<TSuprimento>;
    FSANGRIAS: TObjectList<TSangria>;
    FVENDAS: TObjectList<TVenda>;
    FFECHAMENTOS: TObjectList<TMovimentoFechamento>;
    FRESUMOS: TObjectList<TMovimentoResumo>;
    FNOTAS: TObjectList<TNfe>;

    function getOperador: TUser;
    function getGerente: TUser;

    function getSuprimentos: TObjectList<TSuprimento>;
    function getSangrias: TObjectList<TSangria>;
    function getVendas: TObjectList<TVenda>;
    function getFechamentos: TObjectList<TMovimentoFechamento>;
    function getResumos: TObjectList<TMovimentoResumo>;
    function getNotas: TObjectList<TNfe>;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function save(): Boolean;
    procedure sincronizado();

    class function find(Id: string): TMovimento;
    class function findByTerminal(): TMovimento;
    class function listByTerminal(pReferencia: Integer): TObjectList<TMovimento>; overload;
    class procedure listByTerminal(pReferencia: Integer; pDt: TFDMemTable); overload;
    class procedure imprimirAbertura(Id: string);
    class procedure imprimirFechamento(Id: string);

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property TerminalId: String  read FTERMINAL_ID write FTERMINAL_ID;
    property TurnoId: String  read FTURNO_ID write FTURNO_ID;
    property OperadorId: String  read FOPERADOR_ID write FOPERADOR_ID;
    property GerenteId: String  read FGERENTE_ID write FGERENTE_ID;
    property Referencia: Integer  read FREFERENCIA write FREFERENCIA;
    property Abertura: TDateTime  read FABERTURA write FABERTURA;
    property Fechamento: TDateTime  read FFECHAMENTO write FFECHAMENTO;
    property Suprimento: Extended  read FSUPRIMENTO write FSUPRIMENTO;
    property Sangria: Extended  read FSANGRIA write FSANGRIA;
    property Subtotal: Extended  read FSUBTOTAL write FSUBTOTAL;
    property Acrescimo: Extended  read FACRESCIMO write FACRESCIMO;
    property Desconto: Extended  read FDESCONTO write FDESCONTO;
    property Total: Extended  read FTOTAL write FTOTAL;
    property Recebido: Extended  read FRECEBIDO write FRECEBIDO;
    property Troco: Extended  read FTROCO write FTROCO;
    property Situacao: String  read FSITUACAO write FSITUACAO;

    property Operador: TUser read getOperador;
    property Gerente: TUser read getGerente;

    property Suprimentos: TObjectList<TSuprimento> read getSuprimentos;
    property Sangrias: TObjectList<TSangria> read getSangrias;
    property Vendas: TObjectList<TVenda> read getVendas;
    property Fechamentos: TObjectList<TMovimentoFechamento> read getFechamentos;
    property Resumos: TObjectList<TMovimentoResumo> read getResumos;
    property Notas: TObjectList<TNfe> read getNotas;
  end;

implementation

uses
  AuthService, Helper;

{ TMovimento }

constructor TMovimento.Create;
begin
  Self.Table:= 'MOVIMENTOS';
end;

destructor TMovimento.Destroy;
begin
  if Assigned(Self.FOPERADOR) then FreeAndNil(Self.FOPERADOR);
  if Assigned(Self.FGERENTE) then FreeAndNil(Self.FGERENTE);
  if Assigned(Self.FSUPRIMENTOS) then FreeAndNil(Self.FSUPRIMENTOS);
  if Assigned(Self.FSANGRIAS) then FreeAndNil(Self.FSANGRIAS);
  if Assigned(Self.FVENDAS) then FreeAndNil(Self.FVENDAS);
  if Assigned(Self.FFECHAMENTOS) then FreeAndNil(Self.FFECHAMENTOS);
  if Assigned(Self.FRESUMOS) then FreeAndNil(Self.FRESUMOS);
  if Assigned(Self.FNOTAS) then FreeAndNil(Self.FNOTAS);

  inherited;
end;

class function TMovimento.find(Id: string): TMovimento;
const
  FSql: string = 'SELECT * FROM MOVIMENTOS WHERE (ID = :ID)';
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
        Result:= TMovimento.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.TerminalId:= FDQuery.FieldByName('TERMINAL_ID').AsString;
        Result.TurnoId:= FDQuery.FieldByName('TURNO_ID').AsString;
        Result.OperadorId:= FDQuery.FieldByName('OPERADOR_ID').AsString;
        Result.GerenteId:= FDQuery.FieldByName('GERENTE_ID').AsString;
        Result.Referencia:= FDQuery.FieldByName('REFERENCIA').AsInteger;
        Result.Abertura:= FDQuery.FieldByName('ABERTURA').AsDateTime;
        Result.Fechamento:= FDQuery.FieldByName('FECHAMENTO').AsDateTime;
        Result.Suprimento:= FDQuery.FieldByName('SUPRIMENTO').AsExtended;
        Result.Sangria:= FDQuery.FieldByName('SANGRIA').AsExtended;
        Result.Subtotal:= FDQuery.FieldByName('SUBTOTAL').AsExtended;
        Result.Acrescimo:= FDQuery.FieldByName('ACRESCIMO').AsExtended;
        Result.Desconto:= FDQuery.FieldByName('DESCONTO').AsExtended;
        Result.Total:= FDQuery.FieldByName('TOTAL').AsExtended;
        Result.Recebido:= FDQuery.FieldByName('RECEBIDO').AsExtended;
        Result.Troco:= FDQuery.FieldByName('TROCO').AsExtended;
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

class function TMovimento.findByTerminal(): TMovimento;
const
  FSql: string =
  'SELECT ID FROM MOVIMENTOS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (TERMINAL_ID = :TERMINAL_ID) ' +
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
      FDQuery.Params.ParamByName('TERMINAL_ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Params.ParamByName('SITUACAO').AsString:= 'A';
      FDQuery.Params.ParamByName('TERMINAL_ID').AsString:= TAuthService.Terminal.Id;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
        Result:= TMovimento.find(FDQuery.FieldByName('ID').AsString);
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TMovimento.getFechamentos: TObjectList<TMovimentoFechamento>;
begin
  if not Assigned(Self.FFECHAMENTOS) then
    Self.FFECHAMENTOS:= TMovimentoFechamento.findByMovimento(Self.Id);

  if not Assigned(Self.FFECHAMENTOS) then
    Self.FFECHAMENTOS:= TObjectList<TMovimentoFechamento>.Create();

  Result:= Self.FFECHAMENTOS;
end;

function TMovimento.getGerente: TUser;
begin
  if not Assigned(Self.FGERENTE) then
    Self.FGERENTE:= TUser.find(Self.GerenteId);

  Result:= Self.FGERENTE;
end;

function TMovimento.getNotas: TObjectList<TNfe>;
begin
  if not Assigned(Self.FNOTAS) then
    Self.FNOTAS:= TNfe.findByMovimento(Self.Id);

  Result:= Self.FNOTAS;
end;

function TMovimento.getOperador: TUser;
begin
  if not Assigned(Self.FOPERADOR) then
    Self.FOPERADOR:= TUser.find(Self.OperadorId);

  Result:= Self.FOPERADOR;
end;

function TMovimento.getResumos: TObjectList<TMovimentoResumo>;
begin
  if not Assigned(Self.FRESUMOS) then
    Self.FRESUMOS:= TMovimentoResumo.findByMovimento(Self.Id);

  Result:= Self.FRESUMOS;
end;

function TMovimento.getSangrias: TObjectList<TSangria>;
begin
  if not Assigned(Self.FSANGRIAS) then
    Self.FSANGRIAS:= TSangria.findByMovimento(Self.Id);

  if not Assigned(Self.FSANGRIAS) then
    Self.FSANGRIAS:= TObjectList<TSangria>.Create();

  Result:= Self.FSANGRIAS;
end;

function TMovimento.getSuprimentos: TObjectList<TSuprimento>;
begin
  if not Assigned(Self.FSUPRIMENTOS) then
    Self.FSUPRIMENTOS:= TSuprimento.findByMovimento(Self.Id);

  if not Assigned(Self.FSUPRIMENTOS) then
    Self.FSUPRIMENTOS:= TObjectList<TSuprimento>.Create();

  Result:= Self.FSUPRIMENTOS;
end;

function TMovimento.getVendas: TObjectList<TVenda>;
begin
  if not Assigned(Self.FVENDAS) then
    Self.FVENDAS:= TVenda.findByMovimento(Self.Id);

  if not Assigned(Self.FVENDAS) then
    Self.FVENDAS:= TObjectList<TVenda>.Create();

  Result:= Self.FVENDAS;
end;

class procedure TMovimento.imprimirAbertura(Id: string);
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
  vMovimento: TMovimento;
  Print: TStringList;
  I: Integer;
  F: TextFile;
begin
  try
    vMovimento:= nil;
    Print:= nil;
    Try
      vMovimento:= TMovimento.find(Id);
      if not Assigned(vMovimento) then
        raise Exception.Create('Falha ao consultar dados do movimento.');

      Print:= TStringList.Create;
      Print.Add('--------------( ABERTURA DE CAIXA )-------------');
      Print.Add('CAIXA     : ' + TAuthService.Terminal.Nome);
      Print.Add('MOVIMENTO : ' + vMovimento.Referencia.ToString());
      Print.Add('OPERADOR  : ' + Copy(vMovimento.Operador.Nome, 1, IfThen(Pos(' ', vMovimento.Operador.Nome, 1) > 0, Pos(' ', vMovimento.Operador.Nome, 1), 20)));
      Print.Add('GERENTE   : ' + Copy(vMovimento.Gerente.Nome, 1, IfThen(Pos(' ', vMovimento.Gerente.Nome, 1) > 0, Pos(' ', vMovimento.Gerente.Nome, 1), 20)));
      Print.Add('ABERTURA  : ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', vMovimento.Abertura));
      Print.Add(StringOfChar('-',48));
      Print.Add('');
      Print.Add('SUPRIMENTO...: ' + THelper.ExtendedToString(vMovimento.Suprimento));
      Print.Add('');
      Print.Add('    ----------------------------------------    ');
      Print.Add('                VISTO DO OPERADOR               ');
      Print.Add('');
      Print.Add('    ----------------------------------------    ');
      Print.Add('           VISTO DO GERENTE/SUPERVISOR          ');

      for I := 1 to 5 do
        Print.Add('');

      AssignFile(F, TAuthService.Terminal.PrintPath);
      Rewrite(F);

      for I := 0 to Pred(Print.Count) do
        Writeln(F, unFonte, Print[I]);

      Writeln(F, unCorte);
      CloseFile(F);
    except on e: Exception do
      THelper.Mensagem('Falha ao imprimir abertura. Erro ' + e.Message);
    end;
  finally
    FreeAndNil(vMovimento);
    FreeAndNil(Print);
  end;
end;

class procedure TMovimento.imprimirFechamento(Id: string);
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
  vMovimento: TMovimento;
  Print: TStringList;
  I: Integer;
  F: TextFile;
  TotCalculado,
  TotDeclarado,
  TotDiferenca: Extended;
  Calculado: string;
  Declarado: string;
  Diferenca: string;
  Meio: string;
begin
  try
    vMovimento:= nil;
    Print:= nil;
    try
      vMovimento:= TMovimento.find(Id);
      if not Assigned(vMovimento) then
        raise Exception.Create('Falha ao consultar dados do movimento.');

      Print:= TStringList.Create;
      Print.Add('-------------( FECHAMENTO DE CAIXA )------------');
      Print.Add('CAIXA     : ' + TAuthService.Terminal.Nome);
      Print.Add('MOVIMENTO : ' + vMovimento.Referencia.ToString());
      Print.Add('OPERADOR  : ' + Copy(vMovimento.Operador.Nome, 1, IfThen(Pos(' ', vMovimento.Operador.Nome, 1) > 0, Pos(' ', vMovimento.Operador.Nome, 1), 20)));
      Print.Add('GERENTE   : ' + Copy(vMovimento.Gerente.Nome, 1, IfThen(Pos(' ', vMovimento.Gerente.Nome, 1) > 0, Pos(' ', vMovimento.Gerente.Nome, 1), 20)));
      Print.Add('ABERTURA  : ' + FormatDateTime('dd/mm/yyyy hh:mm:ss',vMovimento.Abertura));
      Print.Add('FECHAMENTO: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss',vMovimento.Fechamento));
      Print.Add(StringOfChar('-',48));
      Print.Add('SUPRIMENTO..........:' + THelper.StrDireita(THelper.ExtendedToString(vMovimento.Suprimento), 11) + '+');
      Print.Add('SAMGRIA.............:' + THelper.StrDireita(THelper.ExtendedToString(vMovimento.Sangria), 11) + '-');
      Print.Add('VENDA...............:' + THelper.StrDireita(THelper.ExtendedToString(vMovimento.Subtotal), 11) + '+');
      Print.Add('DESCONTO............:' + THelper.StrDireita(THelper.ExtendedToString(vMovimento.Desconto), 11) + '-');
      Print.Add('ACRESCIMO...........:' + THelper.StrDireita(THelper.ExtendedToString(vMovimento.Acrescimo), 11) + '+');
      Print.Add('TOTAL...............:' + THelper.StrDireita(THelper.ExtendedToString(vMovimento.Total + vMovimento.Suprimento - vMovimento.Sangria), 11) + '=');
      Print.Add('');
      Print.Add('                 CALCULADO  DECLARADO  DIFERENCA');

      TotCalculado:= 0;
      TotDeclarado:= 0;
      TotDiferenca:= 0;

      for I:= 0 to Pred(vMovimento.Resumos.Count) do
      begin
        Calculado := FloatToStrF(vMovimento.Resumos.Items[i].Calculado,ffNumber,9,2);
        Calculado := StringOfChar(' ', 11 - Length(Calculado)) + Calculado;

        Declarado := FloatToStrF(vMovimento.Resumos.Items[i].Declarado,ffNumber,9,2);
        Declarado := StringOfChar(' ', 11 - Length(Declarado)) + Declarado;

        Diferenca := FloatToStrF(vMovimento.Resumos.Items[i].Declarado - vMovimento.Resumos.Items[i].Calculado,ffNumber,9,2);
        Diferenca := StringOfChar(' ', 11 - Length(Diferenca)) + Diferenca;

        Meio := Copy(THelper.FormaPagamentoToDescStr(vMovimento.Resumos.Items[i].Tpag),1,15);
        Meio := StringOfChar(' ', 15 - Length(Meio)) + Meio;

        TotCalculado := TotCalculado + vMovimento.Resumos.Items[i].Calculado;
        TotDeclarado := TotDeclarado + vMovimento.Resumos.Items[i].Declarado;
        TotDiferenca := TotDiferenca + vMovimento.Resumos.Items[i].Declarado - vMovimento.Resumos.Items[i].Calculado;

        Print.Add(Meio + Calculado + Declarado + Diferenca);
      end;

      Print.Add(StringOfChar('-',48));
      Calculado := FloatToStrF(TotCalculado,ffNumber,9,2);
      Calculado := StringOfChar(' ', 11 - Length(Calculado)) + Calculado;
      Declarado := FloatToStrF(TotDeclarado,ffNumber,9,2);
      Declarado := StringOfChar(' ', 11 - Length(Declarado)) + Declarado;
      Diferenca := FloatToStrF(TotDiferenca,ffNumber,9,2);
      Diferenca := StringOfChar(' ', 11 - Length(Diferenca)) + Diferenca;

      Print.Add('TOTAL.........:' + Calculado + Declarado + Diferenca);
      Print.Add('');
      Print.Add('    ----------------------------------------    ');
      Print.Add('                VISTO DO OPERADOR               ');
      Print.Add('');
      Print.Add('    ----------------------------------------    ');
      Print.Add('           VISTO DO GERENTE/SUPERVISOR          ');

      for I := 1 to 5 do
        Print.Add('');

      AssignFile(F, TAuthService.Terminal.PrintPath);
      Rewrite(F);

      for I := 0 to Pred(Print.Count) do
        Writeln(F, unFonte, Print[I]);

      Writeln(F, unCorte);
      CloseFile(F);
    except on e: Exception do
      THelper.Mensagem('Falha ao imprimir fechamento. Erro ' + e.Message);
    end;
  finally
    FreeAndNil(vMovimento);
    FreeAndNil(Print);
  end;
end;

class procedure TMovimento.listByTerminal(pReferencia: Integer;
  pDt: TFDMemTable);
var
  vlist: TObjectList<TMovimento>;
  I: Integer;
begin
  pDt.Open();
  pDt.DisableControls();
  pDt.EmptyDataSet();
  vlist:= TMovimento.listByTerminal(pReferencia);
  if Assigned(vlist) then
  begin
    for I := 0 to Pred(vlist.Count) do
    begin
      pDt.Append();
      pDt.FieldByName('ID').AsString:= vlist.Items[I].Id;
      pDt.FieldByName('REFERENCIA').AsInteger:= vlist.Items[I].Referencia;
      pDt.FieldByName('ABERTURA').AsDateTime:= vlist.Items[I].Abertura;
      pDt.FieldByName('FECHAMENTO').AsDateTime:= vlist.Items[I].Fechamento;
      pDt.FieldByName('TOTAL').AsExtended:= vlist.Items[I].Total;
      pDt.FieldByName('SYNCHRONIZED').AsString:= vlist.Items[I].Synchronized;
      pDt.Post();
    end;
    FreeAndNil(vlist);
  end;
  pDt.First();
  pDt.EnableControls();
end;

class function TMovimento.listByTerminal(
  pReferencia: Integer): TObjectList<TMovimento>;
var
  FDQuery: TFDQuery;
  FSql: string;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FSql:= 'SELECT FIRST 30 ID FROM MOVIMENTOS ' +
      'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
      'AND (TERMINAL_ID = :TERMINAL_ID) ' +
      'AND (SITUACAO = :SITUACAO) ' +
      'AND (DELETED_AT IS NULL) ';

      if (pReferencia >= 1) then
        FSql:= FSql + 'AND (REFERENCIA = :REFERENCIA) ';

      FSql:= FSql + ' ORDER BY REFERENCIA DESC';

      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('TERMINAL_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('SITUACAO').DataType:= ftString;
      if (pReferencia >= 1) then
        FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;

      FDQuery.Prepare();
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Params.ParamByName('TERMINAL_ID').AsString:= TAuthService.Terminal.Id;
      FDQuery.Params.ParamByName('SITUACAO').AsString:= 'F';
      if (pReferencia >= 1) then
        FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= pReferencia;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TObjectList<TMovimento>.Create;
        FDQuery.First();
        while not FDQuery.Eof do
        begin
          Result.Add(TMovimento.find(FDQuery.FieldByName('ID').AsString));
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

function TMovimento.save: Boolean;
begin
  Result:= inherited;
end;

procedure TMovimento.sincronizado;
const
  FSql: string = 'UPDATE MOVIMENTOS SET ' +
  'SYNCHRONIZED = :SYNCHRONIZED, ' +
  'UPDATED_AT = :UPDATED_AT WHERE (ID = :ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftString;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'S';
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now();
      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.ExecSQL();
    except on e: exception do
      raise Exception.Create('Falha ao marcar movimento como sincronizado. Erro: ' + e.Message);
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TMovimento.store: Boolean;
const
  FSql: string =
  'INSERT INTO MOVIMENTOS ( ' +
  '  ID,                    ' +
  '  EMPRESA_ID,            ' +
  '  TERMINAL_ID,           ' +
  '  TURNO_ID,              ' +
  '  OPERADOR_ID,           ' +
  '  GERENTE_ID,            ' +
  '  REFERENCIA,            ' +
  '  ABERTURA,              ' +
  '  FECHAMENTO,            ' +
  '  SUPRIMENTO,            ' +
  '  SANGRIA,               ' +
  '  SUBTOTAL,              ' +
  '  ACRESCIMO,             ' +
  '  DESCONTO,              ' +
  '  TOTAL,                 ' +
  '  RECEBIDO,              ' +
  '  TROCO,                 ' +
  '  SITUACAO,              ' +
  '  CREATED_AT,            ' +
  '  UPDATED_AT)            ' +
  'VALUES (                 ' +
  '  :ID,                   ' +
  '  :EMPRESA_ID,           ' +
  '  :TERMINAL_ID,          ' +
  '  :TURNO_ID,             ' +
  '  :OPERADOR_ID,          ' +
  '  :GERENTE_ID,           ' +
  '  :REFERENCIA,           ' +
  '  :ABERTURA,             ' +
  '  :FECHAMENTO,           ' +
  '  :SUPRIMENTO,           ' +
  '  :SANGRIA,              ' +
  '  :SUBTOTAL,             ' +
  '  :ACRESCIMO,            ' +
  '  :DESCONTO,             ' +
  '  :TOTAL,                ' +
  '  :RECEBIDO,             ' +
  '  :TROCO,                ' +
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
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('TERMINAL_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('TURNO_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('OPERADOR_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('GERENTE_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('ABERTURA').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('FECHAMENTO').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SUPRIMENTO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('SANGRIA').DataType:= ftExtended;
      FDQuery.Params.ParamByName('SUBTOTAL').DataType:= ftExtended;
      FDQuery.Params.ParamByName('ACRESCIMO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('DESCONTO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('TOTAL').DataType:= ftExtended;
      FDQuery.Params.ParamByName('RECEBIDO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('TROCO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('SITUACAO').DataType:= ftString;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare();

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.Terminal.EmpresaId;
      Self.TerminalId:= TAuthService.Terminal.Id;
      Self.Referencia:= Self.nextReferencia(Self.Referencia);

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('TERMINAL_ID').AsString:= Self.TerminalId;
      FDQuery.Params.ParamByName('TURNO_ID').AsString:= Self.TurnoId;
      FDQuery.Params.ParamByName('OPERADOR_ID').AsString:= Self.OperadorId;
      FDQuery.Params.ParamByName('GERENTE_ID').AsString:= Self.GerenteId;
      FDQuery.Params.ParamByName('REFERENCIA').AsInteger:= Self.Referencia;
      FDQuery.Params.ParamByName('ABERTURA').AsDateTime:= Self.Abertura;
      if (Self.Fechamento > 0) then
      FDQuery.Params.ParamByName('FECHAMENTO').AsDateTime:= Self.Fechamento;
      FDQuery.Params.ParamByName('SUPRIMENTO').AsExtended:= Self.Suprimento;
      FDQuery.Params.ParamByName('SANGRIA').AsExtended:= Self.Sangria;
      FDQuery.Params.ParamByName('SUBTOTAL').AsExtended:= Self.Subtotal;
      FDQuery.Params.ParamByName('ACRESCIMO').AsExtended:= Self.Acrescimo;
      FDQuery.Params.ParamByName('DESCONTO').AsExtended:= Self.Desconto;
      FDQuery.Params.ParamByName('TOTAL').AsExtended:= Self.Total;
      FDQuery.Params.ParamByName('RECEBIDO').AsExtended:= Self.Recebido;
      FDQuery.Params.ParamByName('TROCO').AsExtended:= Self.Troco;
      FDQuery.Params.ParamByName('SITUACAO').AsString:= Self.Situacao;
      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.ExecSQL();
    except on e: exception do
    begin
      Result:= False;
      raise Exception.Create('Falha ao gravar dados do movimento. Erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TMovimento.update: Boolean;
const
  FSql: string =
  'UPDATE MOVIMENTOS                ' +
  'SET FECHAMENTO = :FECHAMENTO,    ' +
  '    SUPRIMENTO = :SUPRIMENTO,    ' +
  '    SANGRIA = :SANGRIA,          ' +
  '    SUBTOTAL = :SUBTOTAL,        ' +
  '    ACRESCIMO = :ACRESCIMO,      ' +
  '    DESCONTO = :DESCONTO,        ' +
  '    TOTAL = :TOTAL,              ' +
  '    RECEBIDO = :RECEBIDO,        ' +
  '    TROCO = :TROCO,              ' +
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
      FDQuery.Params.ParamByName('FECHAMENTO').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SUPRIMENTO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('SANGRIA').DataType:= ftExtended;
      FDQuery.Params.ParamByName('SUBTOTAL').DataType:= ftExtended;
      FDQuery.Params.ParamByName('ACRESCIMO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('DESCONTO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('TOTAL').DataType:= ftExtended;
      FDQuery.Params.ParamByName('RECEBIDO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('TROCO').DataType:= ftExtended;
      FDQuery.Params.ParamByName('SITUACAO').DataType:= ftString;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftString;
      FDQuery.Prepare();

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('FECHAMENTO').AsDateTime:= Self.Fechamento;
      FDQuery.Params.ParamByName('SUPRIMENTO').AsExtended:= Self.Suprimento;
      FDQuery.Params.ParamByName('SANGRIA').AsExtended:= Self.Sangria;
      FDQuery.Params.ParamByName('SUBTOTAL').AsExtended:= Self.Subtotal;
      FDQuery.Params.ParamByName('ACRESCIMO').AsExtended:= Self.Acrescimo;
      FDQuery.Params.ParamByName('DESCONTO').AsExtended:= Self.Desconto;
      FDQuery.Params.ParamByName('TOTAL').AsExtended:= Self.Total;
      FDQuery.Params.ParamByName('RECEBIDO').AsExtended:= Self.Recebido;
      FDQuery.Params.ParamByName('TROCO').AsExtended:= Self.Troco;
      FDQuery.Params.ParamByName('SITUACAO').AsString:= Self.Situacao;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL();
    except on e: exception do
    begin
      Result:= False;
      raise Exception.Create('Falha ao gravar dados do movimento. Erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
