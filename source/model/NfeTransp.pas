unit NfeTransp;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TNfeTransp = class(TModel)
  private
    FEMPRESA_ID: String;
    FNFE_ID: String;
    FMODFRETE: String;
    FCNPJCPF: String;
    FXNOME: String;
    FIE: String;
    FXENDER: String;
    FXMUN: String;
    FUF: String;
    FVAGAO: String;
    FBALSA: String;

  protected
    function store(): Boolean; override;
    function update(): Boolean; override;
  public
    constructor Create();
    function save(): Boolean;
    class function findByNfeId(NfeId: string): TNfeTransp;

    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    property NfeId: String  read FNFE_ID write FNFE_ID;
    property Modfrete: String  read FMODFRETE write FMODFRETE;
    property Cnpjcpf: String  read FCNPJCPF write FCNPJCPF;
    property Xnome: String  read FXNOME write FXNOME;
    property Ie: String  read FIE write FIE;
    property Xender: String  read FXENDER write FXENDER;
    property Xmun: String  read FXMUN write FXMUN;
    property Uf: String  read FUF write FUF;
    property Vagao: String  read FVAGAO write FVAGAO;
    property Balsa: String  read FBALSA write FBALSA;

  end;

implementation

uses
  AuthService;



{ TNfeTransp }

constructor TNfeTransp.Create;
begin
  Self.Table:= 'NFE_TRANSP';
  Self.Modfrete:= '9';
end;

class function TNfeTransp.findByNfeId(NfeId: string): TNfeTransp;
const
  FSql: string =
  'SELECT * FROM NFE_TRANSP WHERE (NFE_ID = :NFE_ID)' +
  ' AND (DELETED_AT IS NULL)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('NFE_ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('NFE_ID').AsString:= NfeId;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TNfeTransp.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.EmpresaId:= FDQuery.FieldByName('EMPRESA_ID').AsString;
        Result.NfeId:= FDQuery.FieldByName('NFE_ID').AsString;
        Result.Modfrete:= FDQuery.FieldByName('MODFRETE').AsString;
        Result.Cnpjcpf:= FDQuery.FieldByName('CNPJCPF').AsString;
        Result.Xnome:= FDQuery.FieldByName('XNOME').AsString;
        Result.Ie:= FDQuery.FieldByName('IE').AsString;
        Result.Xender:= FDQuery.FieldByName('XENDER').AsString;
        Result.Xmun:= FDQuery.FieldByName('XMUN').AsString;
        Result.Uf:= FDQuery.FieldByName('UF').AsString;
        Result.Vagao:= FDQuery.FieldByName('VAGAO').AsString;
        Result.Balsa:= FDQuery.FieldByName('BALSA').AsString;
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

function TNfeTransp.save: Boolean;
begin
  Result:= inherited;
end;

function TNfeTransp.store: Boolean;
const
  FSql: string =
  'INSERT INTO NFE_TRANSP (' +
  '  ID,                   ' +
  '  EMPRESA_ID,           ' +
  '  NFE_ID,               ' +
  '  MODFRETE,             ' +
  '  CNPJCPF,              ' +
  '  XNOME,                ' +
  '  IE,                   ' +
  '  XENDER,               ' +
  '  XMUN,                 ' +
  '  UF,                   ' +
  '  VAGAO,                ' +
  '  BALSA,                ' +
  '  CREATED_AT,           ' +
  '  UPDATED_AT)           ' +
  'VALUES (                ' +
  '  :ID,                  ' +
  '  :EMPRESA_ID,          ' +
  '  :NFE_ID,              ' +
  '  :MODFRETE,            ' +
  '  :CNPJCPF,             ' +
  '  :XNOME,               ' +
  '  :IE,                  ' +
  '  :XENDER,              ' +
  '  :XMUN,                ' +
  '  :UF,                  ' +
  '  :VAGAO,               ' +
  '  :BALSA,               ' +
  '  :CREATED_AT,          ' +
  '  :UPDATED_AT)          ';
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
      FDQuery.Params.ParamByName('NFE_ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('MODFRETE').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CNPJCPF').DataType:= ftWideString;
      FDQuery.Params.ParamByName('XNOME').DataType:= ftWideString;
      FDQuery.Params.ParamByName('IE').DataType:= ftWideString;
      FDQuery.Params.ParamByName('XENDER').DataType:= ftWideString;
      FDQuery.Params.ParamByName('XMUN').DataType:= ftWideString;
      FDQuery.Params.ParamByName('UF').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('VAGAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('BALSA').DataType:= ftWideString;
      FDQuery.Params.ParamByName('CREATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Prepare;

      Self.Id:= Self.generateId;
      Self.EmpresaId:= TAuthService.getAuthenticatedEmpresaId;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= Self.EmpresaId;
      FDQuery.Params.ParamByName('NFE_ID').AsString:= Self.NfeId;
      if (Self.Modfrete <> EmptyStr) then
      FDQuery.Params.ParamByName('MODFRETE').AsString:= Self.Modfrete;
      if (Self.Cnpjcpf <> EmptyStr) then
      FDQuery.Params.ParamByName('CNPJCPF').AsString:= Self.Cnpjcpf;
      if (Self.Xnome <> EmptyStr) then
      FDQuery.Params.ParamByName('XNOME').AsString:= Self.Xnome;
      if (Self.Ie <> EmptyStr) then
      FDQuery.Params.ParamByName('IE').AsString:= Self.Ie;
      if (Self.Xender <> EmptyStr) then
      FDQuery.Params.ParamByName('XENDER').AsString:= Self.Xender;
      if (Self.Xmun <> EmptyStr) then
      FDQuery.Params.ParamByName('XMUN').AsString:= Self.Xmun;
      if (Self.Uf <> EmptyStr) then
      FDQuery.Params.ParamByName('UF').AsString:= Self.Uf;
      if (Self.Vagao <> EmptyStr) then
      FDQuery.Params.ParamByName('VAGAO').AsString:= Self.Vagao;
      if (Self.Balsa <> EmptyStr) then
      FDQuery.Params.ParamByName('BALSA').AsString:= Self.Balsa;
      FDQuery.Params.ParamByName('CREATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.ExecSQL;
    except on e: Exception do
      begin
        Result:= False;
        raise Exception.Create('falha ao inserir transportadora. erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TNfeTransp.update: Boolean;
const
  FSql: string =
  'UPDATE NFE_TRANSP                ' +
  'SET MODFRETE = :MODFRETE,        ' +
  '    CNPJCPF = :CNPJCPF,          ' +
  '    XNOME = :XNOME,              ' +
  '    IE = :IE,                    ' +
  '    XENDER = :XENDER,            ' +
  '    XMUN = :XMUN,                ' +
  '    UF = :UF,                    ' +
  '    VAGAO = :VAGAO,              ' +
  '    BALSA = :BALSA,              ' +
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
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('MODFRETE').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('CNPJCPF').DataType:= ftWideString;
      FDQuery.Params.ParamByName('XNOME').DataType:= ftWideString;
      FDQuery.Params.ParamByName('IE').DataType:= ftWideString;
      FDQuery.Params.ParamByName('XENDER').DataType:= ftWideString;
      FDQuery.Params.ParamByName('XMUN').DataType:= ftWideString;
      FDQuery.Params.ParamByName('UF').DataType:= ftFixedWideChar;
      FDQuery.Params.ParamByName('VAGAO').DataType:= ftWideString;
      FDQuery.Params.ParamByName('BALSA').DataType:= ftWideString;
      FDQuery.Params.ParamByName('UPDATED_AT').DataType:= ftTimeStamp;
      FDQuery.Params.ParamByName('SYNCHRONIZED').DataType:= ftFixedWideChar;
      FDQuery.Prepare;

      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      if (Self.Modfrete <> EmptyStr) then
      FDQuery.Params.ParamByName('MODFRETE').AsString:= Self.Modfrete;
      if (Self.Cnpjcpf <> EmptyStr) then
      FDQuery.Params.ParamByName('CNPJCPF').AsString:= Self.Cnpjcpf;
      if (Self.Xnome <> EmptyStr) then
      FDQuery.Params.ParamByName('XNOME').AsString:= Self.Xnome;
      if (Self.Ie <> EmptyStr) then
      FDQuery.Params.ParamByName('IE').AsString:= Self.Ie;
      if (Self.Xender <> EmptyStr) then
      FDQuery.Params.ParamByName('XENDER').AsString:= Self.Xender;
      if (Self.Xmun <> EmptyStr) then
      FDQuery.Params.ParamByName('XMUN').AsString:= Self.Xmun;
      if (Self.Uf <> EmptyStr) then
      FDQuery.Params.ParamByName('UF').AsString:= Self.Uf;
      if (Self.Vagao <> EmptyStr) then
      FDQuery.Params.ParamByName('VAGAO').AsString:= Self.Vagao;
      if (Self.Balsa <> EmptyStr) then
      FDQuery.Params.ParamByName('BALSA').AsString:= Self.Balsa;
      FDQuery.Params.ParamByName('UPDATED_AT').Value:= Now;
      FDQuery.Params.ParamByName('SYNCHRONIZED').AsString:= 'N';
      FDQuery.ExecSQL;
    except on e: Exception do
    begin
      Result:= False;
      raise Exception.Create('falha ao atualizar transportadora. erro: ' + e.Message);
    end;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
