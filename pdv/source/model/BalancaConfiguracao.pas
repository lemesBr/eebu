unit BalancaConfiguracao;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TBalancaConfiguracao = class(TModel)
  private
    FEMPRESA_ID: String;
    FMODELO: Integer;
    FHANDSHAKE: Integer;
    FPARITY: Integer;
    FSTOP: Integer;
    FDATA: Integer;
    FBAUD: Integer;
    FPORTA: String;
    FDIGITOS: Integer;
    FDIGITO_INICIAL: Integer;
    FPRODUTO_DIGITO_INICIAL: Integer;
    FPRODUTO_DIGITO_FINAL: Integer;
    FPESO_DIGITO_INICIAL: Integer;
    FPESO_DIGITO_FINAL: Integer;
    FPESO_DIGITOS_DECIMAL: Integer;
    FPESO: String;
    FTIME_OUT: Integer;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function find(): TBalancaConfiguracao;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property Modelo: Integer  read FMODELO write FMODELO;
    property Handshake: Integer  read FHANDSHAKE write FHANDSHAKE;
    property Parity: Integer  read FPARITY write FPARITY;
    property Stop: Integer  read FSTOP write FSTOP;
    property Data: Integer  read FDATA write FDATA;
    property Baud: Integer  read FBAUD write FBAUD;
    property Porta: String  read FPORTA write FPORTA;
    property Digitos: Integer  read FDIGITOS write FDIGITOS;
    property DigitoInicial: Integer  read FDIGITO_INICIAL write FDIGITO_INICIAL;
    property ProdutoDigitoInicial: Integer  read FPRODUTO_DIGITO_INICIAL write FPRODUTO_DIGITO_INICIAL;
    property ProdutoDigitoFinal: Integer  read FPRODUTO_DIGITO_FINAL write FPRODUTO_DIGITO_FINAL;
    property PesoDigitoInicial: Integer  read FPESO_DIGITO_INICIAL write FPESO_DIGITO_INICIAL;
    property PesoDigitoFinal: Integer  read FPESO_DIGITO_FINAL write FPESO_DIGITO_FINAL;
    property PesoDigitosDecimal: Integer  read FPESO_DIGITOS_DECIMAL write FPESO_DIGITOS_DECIMAL;
    property Peso: String  read FPESO write FPESO;
    property TimeOut: Integer  read FTIME_OUT write FTIME_OUT;

  end;

implementation

uses
  AuthService;

{ TBalancaConfiguracao }

constructor TBalancaConfiguracao.Create;
begin
  Self.Table:= 'BALANCA_CONFIGURACOES';
end;

class function TBalancaConfiguracao.find(): TBalancaConfiguracao;
const
  FSql: string = 'SELECT * FROM BALANCA_CONFIGURACOES WHERE (EMPRESA_ID = :EMPRESA_ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= TAuthService.Terminal.EmpresaId;
      FDQuery.Open();
      if (FDQuery.RecordCount = 0) then Result:= nil
      else
      begin
        Result:= TBalancaConfiguracao.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.Modelo:= FDQuery.FieldByName('MODELO').AsInteger;
        Result.Handshake:= FDQuery.FieldByName('HANDSHAKE').AsInteger;
        Result.Parity:= FDQuery.FieldByName('PARITY').AsInteger;
        Result.Stop:= FDQuery.FieldByName('STOP').AsInteger;
        Result.Data:= FDQuery.FieldByName('DATA').AsInteger;
        Result.Baud:= FDQuery.FieldByName('BAUD').AsInteger;
        Result.Porta:= FDQuery.FieldByName('PORTA').AsString;
        Result.Digitos:= FDQuery.FieldByName('DIGITOS').AsInteger;
        Result.DigitoInicial:= FDQuery.FieldByName('DIGITO_INICIAL').AsInteger;
        Result.ProdutoDigitoInicial:= FDQuery.FieldByName('PRODUTO_DIGITO_INICIAL').AsInteger;
        Result.ProdutoDigitoFinal:= FDQuery.FieldByName('PRODUTO_DIGITO_FINAL').AsInteger;
        Result.PesoDigitoInicial:= FDQuery.FieldByName('PESO_DIGITO_INICIAL').AsInteger;
        Result.PesoDigitoFinal:= FDQuery.FieldByName('PESO_DIGITO_FINAL').AsInteger;
        Result.PesoDigitosDecimal:= FDQuery.FieldByName('PESO_DIGITOS_DECIMAL').AsInteger;
        Result.Peso:= FDQuery.FieldByName('PESO').AsString;
        Result.TimeOut:= FDQuery.FieldByName('TIME_OUT').AsInteger;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TBalancaConfiguracao.save: Boolean;
const
  FSql: string =
  'UPDATE OR INSERT INTO BALANCA_CONFIGURACOES ( ' +
  '  ID,                                         ' +
  '  EMPRESA_ID,                                 ' +
  '  MODELO,                                     ' +
  '  HANDSHAKE,                                  ' +
  '  PARITY,                                     ' +
  '  STOP,                                       ' +
  '  DATA,                                       ' +
  '  BAUD,                                       ' +
  '  PORTA,                                      ' +
  '  DIGITOS,                                    ' +
  '  DIGITO_INICIAL,                             ' +
  '  PRODUTO_DIGITO_INICIAL,                     ' +
  '  PRODUTO_DIGITO_FINAL,                       ' +
  '  PESO_DIGITO_INICIAL,                        ' +
  '  PESO_DIGITO_FINAL,                          ' +
  '  PESO_DIGITOS_DECIMAL,                       ' +
  '  PESO,                                       ' +
  '  TIME_OUT)                                   ' +
  'VALUES (                                      ' +
  '  :ID,                                        ' +
  '  :EMPRESA_ID,                                ' +
  '  :MODELO,                                    ' +
  '  :HANDSHAKE,                                 ' +
  '  :PARITY,                                    ' +
  '  :STOP,                                      ' +
  '  :DATA,                                      ' +
  '  :BAUD,                                      ' +
  '  :PORTA,                                     ' +
  '  :DIGITOS,                                   ' +
  '  :DIGITO_INICIAL,                            ' +
  '  :PRODUTO_DIGITO_INICIAL,                    ' +
  '  :PRODUTO_DIGITO_FINAL,                      ' +
  '  :PESO_DIGITO_INICIAL,                       ' +
  '  :PESO_DIGITO_FINAL,                         ' +
  '  :PESO_DIGITOS_DECIMAL,                      ' +
  '  :PESO,                                      ' +
  '  :TIME_OUT) MATCHING (ID)                    ';
var
  FDQuery: TFDQuery;
begin
  Result:= True;
  try
    FDQuery:= TModel.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('MODELO').DataType:= ftInteger;
      FDQuery.Params.ParamByName('HANDSHAKE').DataType:= ftInteger;
      FDQuery.Params.ParamByName('PARITY').DataType:= ftInteger;
      FDQuery.Params.ParamByName('STOP').DataType:= ftInteger;
      FDQuery.Params.ParamByName('DATA').DataType:= ftInteger;
      FDQuery.Params.ParamByName('BAUD').DataType:= ftInteger;
      FDQuery.Params.ParamByName('PORTA').DataType:= ftString;
      FDQuery.Params.ParamByName('DIGITOS').DataType:= ftInteger;
      FDQuery.Params.ParamByName('DIGITO_INICIAL').DataType:= ftInteger;
      FDQuery.Params.ParamByName('PRODUTO_DIGITO_INICIAL').DataType:= ftInteger;
      FDQuery.Params.ParamByName('PRODUTO_DIGITO_FINAL').DataType:= ftInteger;
      FDQuery.Params.ParamByName('PESO_DIGITO_INICIAL').DataType:= ftInteger;
      FDQuery.Params.ParamByName('PESO_DIGITO_FINAL').DataType:= ftInteger;
      FDQuery.Params.ParamByName('PESO_DIGITOS_DECIMAL').DataType:= ftInteger;
      FDQuery.Params.ParamByName('PESO').DataType:= ftString;
      FDQuery.Params.ParamByName('TIME_OUT').DataType:= ftInteger;
      FDQuery.Prepare();

      if (Self.Id = EmptyStr) then
      begin
        Self.Id:= Self.generateId;
        Self.EmpresaId:= TAuthService.Terminal.EmpresaId;
      end;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('MODELO').AsInteger:= Self.Modelo;
      FDQuery.Params.ParamByName('HANDSHAKE').AsInteger:= Self.Handshake;
      FDQuery.Params.ParamByName('PARITY').AsInteger:= Self.Parity;
      FDQuery.Params.ParamByName('STOP').AsInteger:= Self.Stop;
      FDQuery.Params.ParamByName('DATA').AsInteger:= Self.Data;
      FDQuery.Params.ParamByName('BAUD').AsInteger:= Self.Baud;
      FDQuery.Params.ParamByName('PORTA').AsString:= Self.Porta;
      FDQuery.Params.ParamByName('DIGITOS').AsInteger:= Self.Digitos;
      FDQuery.Params.ParamByName('DIGITO_INICIAL').AsInteger:= Self.DigitoInicial;
      FDQuery.Params.ParamByName('PRODUTO_DIGITO_INICIAL').AsInteger:= Self.ProdutoDigitoInicial;
      FDQuery.Params.ParamByName('PRODUTO_DIGITO_FINAL').AsInteger:= Self.ProdutoDigitoFinal;
      FDQuery.Params.ParamByName('PESO_DIGITO_INICIAL').AsInteger:= Self.PesoDigitoInicial;
      FDQuery.Params.ParamByName('PESO_DIGITO_FINAL').AsInteger:= Self.PesoDigitoFinal;
      FDQuery.Params.ParamByName('PESO_DIGITOS_DECIMAL').AsInteger:= Self.PesoDigitosDecimal;
      FDQuery.Params.ParamByName('PESO').AsString:= Self.Peso;
      FDQuery.Params.ParamByName('TIME_OUT').AsInteger:= Self.TimeOut;
      FDQuery.ExecSQL();
    except on e: exception do
    begin
      Result:= False;
      raise Exception.Create('Falha ao gravar dados. Erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TBalancaConfiguracao.store: Boolean;
begin
  Result:= True;
end;

function TBalancaConfiguracao.update: Boolean;
begin
  Result:= True;
end;

end.
