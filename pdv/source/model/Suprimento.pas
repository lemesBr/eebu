unit Suprimento;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB,
  System.Math;

type
  TSuprimento = class(TModel)
  private
    FEMPRESA_ID: String;
    FMOVIMENTO_ID: String;
    FVALOR: Extended;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    destructor Destroy; override;
    constructor Create();
    function  save(): Boolean;


    class function find(Id: string): TSuprimento;
    class function findByMovimento(MovimentoId: string): TObjectList<TSuprimento>;
    class procedure imprimir(Id: string);

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property MovimentoId: String  read FMOVIMENTO_ID write FMOVIMENTO_ID;
    property Valor: Extended  read FVALOR write FVALOR;

  end;

implementation

uses
  AuthService, Movimento, Helper;

{ TSuprimento }

constructor TSuprimento.Create;
begin
  Self.Table:= 'SUPRIMENTOS';
end;

destructor TSuprimento.Destroy;
begin

  inherited;
end;

class function TSuprimento.find(Id: string): TSuprimento;
const
  FSql: string = 'SELECT * FROM SUPRIMENTOS WHERE (ID = :ID)';
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
        Result:= TSuprimento.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.MovimentoId:= FDQuery.FieldByName('MOVIMENTO_ID').AsString;
        Result.Valor:= FDQuery.FieldByName('VALOR').AsExtended;
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

class function TSuprimento.findByMovimento(
  MovimentoId: string): TObjectList<TSuprimento>;
const
  FSql: string =
  'SELECT ID FROM SUPRIMENTOS ' +
  'WHERE (EMPRESA_ID = :EMPRESA_ID) ' +
  'AND (MOVIMENTO_ID = :MOVIMENTO_ID) ' +
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
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Params.ParamByName('MOVIMENTO_ID').AsString:= MovimentoId;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TObjectList<TSuprimento>.Create;
        FDQuery.First();
        while not FDQuery.Eof do
        begin
          Result.Add(TSuprimento.find(FDQuery.FieldByName('ID').AsString));
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

class procedure TSuprimento.imprimir(Id: string);
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
  vSuprimento: TSuprimento;
  vMovimento: TMovimento;
  Print: TStringList;
  F: TextFile;
  I: Integer;
begin
  try
    vSuprimento:= nil;
    vMovimento:= nil;
    Print:= nil;
    try
      vSuprimento:= TSuprimento.find(Id);
      if not Assigned(vSuprimento) then
        raise Exception.Create('Falha ao consultar dados do suprimento.');

      vMovimento:= TMovimento.find(vSuprimento.MovimentoId);
      if not Assigned(vMovimento) then
        raise Exception.Create('Falha ao consultar dados do movimento.');

      Print:= TStringList.Create;
      Print.Add('-----------------( SUPRIMENTO )-----------------');
      Print.Add('CAIXA      : ' + TAuthService.Terminal.Nome);
      Print.Add('MOVIMENTO  : ' + vMovimento.Referencia.ToString());
      Print.Add('OPERADOR   : ' + Copy(vMovimento.Operador.Nome, 1, IfThen(Pos(' ', vMovimento.Operador.Nome, 1) > 0, Pos(' ', vMovimento.Operador.Nome, 1), 20)));
      Print.Add('MOMENTO    : ' + FormatDateTime('dd/mm/yyyyy hh:mm:ss', vSuprimento.CreatedAt));
      Print.Add(StringOfChar('-',48));
      Print.Add('VALOR      : ' + THelper.ExtendedToString(vSuprimento.Valor) + '+');
      Print.Add('');
      print.Add('     --------------------------------------     ');
      Print.Add('                VISTO DO OPERADOR               ');

      for I := 0 to 5 do
        Print.Add('');

      AssignFile(F, TAuthService.Terminal.PrintPath);
      Rewrite(F);

      for I := 0 to Pred(Print.Count) do
        Writeln(F, unFonte, Print[I]);

      Writeln(F,unCorte);
      CloseFile(F);
    except on e: Exception do
      THelper.Mensagem('Falha ao imprimir suprimento. Erro ' + e.Message);
    end;
  finally
    FreeAndNil(vSuprimento);
    FreeAndNil(vMovimento);
    FreeAndNil(Print);
  end;
end;

function TSuprimento.save: Boolean;
begin
  Result:= inherited;
end;

function TSuprimento.store: Boolean;
const
  FSql: string =
  'INSERT INTO SUPRIMENTOS ( ' +
  '  ID,                     ' +
  '  EMPRESA_ID,             ' +
  '  MOVIMENTO_ID,           ' +
  '  VALOR,                  ' +
  '  CREATED_AT,             ' +
  '  UPDATED_AT)             ' +
  'VALUES (                  ' +
  '  :ID,                    ' +
  '  :EMPRESA_ID,            ' +
  '  :MOVIMENTO_ID,          ' +
  '  :VALOR,                 ' +
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
      FDQuery.Params.ParamByName('MOVIMENTO_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('VALOR').DataType:= ftExtended;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
      FDQuery.Prepare();

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.Terminal.EmpresaId;
      Self.MovimentoId:= TAuthService.Terminal.Movimento.Id;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('MOVIMENTO_ID').AsString:= Self.MovimentoId;
      FDQuery.Params.ParamByName('VALOR').AsExtended:= Self.Valor;
      FDQuery.Params.ParamByName('CREATED_AT').AsDateTime:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').AsDateTime:= Now;
      FDQuery.ExecSQL();
    except on e: exception do
    begin
      Result:= False;
      raise Exception.Create('Falha ao gravar dados do suprimento. Erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TSuprimento.update: Boolean;
begin
  Result:= True;
end;

end.
