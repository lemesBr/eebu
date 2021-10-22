unit Helper;

interface

uses
  Winapi.Windows, System.SysUtils, IdHashMessageDigest, Vcl.ExtCtrls,
  Vcl.Graphics, Vcl.Mask, pcnConversao, IdBaseComponent,
  IdComponent, IdIPWatch, System.Zip, Winapi.ShellAPI;

type
  THelper = class
    class function SerialDrive(Drive: string): string;
    class function MD5String(const Texto: string): string;
    class function CPFMask(Numero: string): string;
    class function CNPJMask(Numero: string): string;
    class function FONEMask(Numero: string): string;
    class function TruncateValue(Value: Extended; Decimal: integer): Extended;
    class function ReturnsInteger(Const Value: string): string;
    class function ExtendedToString(Value: Extended; Moeda: Boolean = True): string;
    class function StringToExtended(Value: string): Extended;
    class function RemoveAcentos(Value: string): string;
    class function ValidaCamposObrigatorios(Panel: TPanel): Boolean;
    class function Mensagem(Mensagem: string; Tipo: Integer = 0): Boolean;
    class function ValidarCPF(Value: string): Boolean;
    class function ValidarCNPJ(Value: string): Boolean;
    class function DevolveConteudoDelimitado(Delimidador: string; var Linha: string): string;
    class function StrEsquerda(S: string; vt: integer):string;
    class function StrDireita(S: string; vt: integer): string;
    class function StrCentro(S: string; vt: integer): string;
    class function FormaPagamentoToDescStr(vPg: string): string;
    class function ValueIn(Value: Integer; const Values: array of Integer): Boolean;
    class function localIp(): string;
    class function criarZipDirectory(DirectoryName: string): Boolean;
    class Procedure removeDir(vHandle: THandle; Const vDir: String);
  end;

implementation

uses
  uformMensagem, AuthService;

{ THelper }

class procedure THelper.removeDir(vHandle: THandle; const vDir: String);
var
  OpStruc: TSHFileOpStruct;
  FromBuffer, ToBuffer: Array[0..128] of Char;
begin
  fillChar(OpStruc, Sizeof(OpStruc), 0 );
  FillChar(FromBuffer, Sizeof(FromBuffer), 0 );
  FillChar(ToBuffer, Sizeof(ToBuffer), 0 );
  StrPCopy(FromBuffer, vDir);

  With OpStruc Do
  Begin
    Wnd:= vHandle;
    wFunc:=FO_DELETE;
    pFrom:= @FromBuffer;
    pTo:= @ToBuffer;
    fFlags:= FOF_NOCONFIRMATION;
    fAnyOperationsAborted:=False;
    hNameMappings:= nil;
  End;

  ShFileOperation(OpStruc);
end;

class function THelper.CNPJMask(Numero: string): string;
begin
  Result:= EmptyStr;
  if Numero.Length = 14 then
  begin
    Result:=
    Copy(Numero,1,2) +
    '.' + Copy(Numero,3,3) +
    '.' + Copy(Numero,6,3) +
    '/' + Copy(Numero,9,4) +
    '-' + Copy(Numero,13,2);
  end;
end;

class function THelper.CPFMask(Numero: string): string;
begin
  Result:= EmptyStr;
  if Numero.Length = 11 then
  begin
    Result:=
    Copy(Numero,1,3) +
    '.' + Copy(Numero,4,3) +
    '.' + Copy(Numero,7,3) +
    '-' + Copy(Numero,10,2);
  end;
end;

class function THelper.criarZipDirectory(DirectoryName: string): Boolean;
begin
  Result:= True;
  try
    TZipFile.ZipDirectoryContents(DirectoryName + '.zip', DirectoryName);
  except
    Result:= False;
  end;
end;

class function THelper.DevolveConteudoDelimitado(Delimidador: string;
  var Linha: string): string;
var
  PosBarra: integer;
begin
  PosBarra:=Pos(Delimidador,Linha);
  Result:= StringReplace((Copy(Linha,1,PosBarra-1)),'[#]','|',[rfReplaceAll]);
  Delete(Linha,1,PosBarra);
end;

class function THelper.ExtendedToString(Value: Extended; Moeda: Boolean): string;
begin
  if (Moeda) then Result:= FormatFloat('###,##0.00', Value)
  else Result:= FormatFloat('###,###0.000', Value);
end;

class function THelper.FONEMask(Numero: string): string;
begin
  Result:= EmptyStr;
  case Numero.Length of
    10: begin
      Result:=
      '(' + Copy(Numero,1,2) +
      ')' + Copy(Numero,3,4) +
      '-' + Copy(Numero,7,4);
    end;
    11: begin
      Result:=
      '(' + Copy(Numero,1,2) +
      ')' + Copy(Numero,3,5) +
      '-' + Copy(Numero,8,4);
    end;
  end;
end;

class function THelper.FormaPagamentoToDescStr(vPg: string): string;
var
  t: TpcnFormaPagamento;
  Ok: Boolean;
begin
  t:= StrToFormaPagamento(Ok,vPg);

  case t of
    fpDinheiro: Result:= 'DINHEIRO';
    fpCheque: Result:= 'CHEQUE';
    fpCartaoCredito: Result:= 'CARTAO CREDITO';
    fpCartaoDebito: Result:= 'CARTAO DEBITO';
    fpCreditoLoja: Result:= 'CREDITO LOJA';
    fpValeAlimentacao: Result:= 'VALE ALIMENTACAO';
    fpValeRefeicao: Result:= 'VALE REFEICAO';
    fpValePresente: Result:= 'VALE PRESENTE';
    fpValeCombustivel: Result:= 'VALE COMBUSTÕVEL';
    fpDuplicataMercantil: Result:= 'DUPLICATA MERCANTIL';
    fpBoletoBancario: Result:= 'BOLETO BANCARIO';
    fpSemPagamento: Result:= 'SEM PAGAMENTO';
    fpOutro: Result:= 'OUTRO';
  end;
end;

class function THelper.localIp: string;
var
  IdIPWatch: TIdIPWatch;
begin
  try
    try
      IdIPWatch:= TIdIPWatch.Create(nil);
      Result:= IdIPWatch.LocalIP;
    except
      Result:= '';
    end;
  finally
    FreeAndNil(IdIPWatch);
  end;
end;

class function THelper.MD5String(const Texto: string): string;
var
  MD5Id: TIdHashMessageDigest5;
begin
  MD5Id:= TIdHashMessageDigest5.Create;
  try
    Result:= LowerCase(MD5Id.HashStringAsHex(Texto));
  finally
    MD5Id.Free;
  end;
end;

class function THelper.Mensagem(Mensagem: string; Tipo: Integer): Boolean;
begin
  TAuthService.TipoMensagem:= Tipo;
  try
    formMensagem:= TformMensagem.Create(nil);
    formMensagem.lbl_mensagem.Caption:= Mensagem;
    formMensagem.ShowModal;
    Result:= formMensagem.Tag = 1;
  finally
    FreeAndNil(formMensagem);
  end;
end;

class function THelper.RemoveAcentos(Value: string): string;
const
  ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹';
  SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
var
   X: Integer;
begin;
  for X:= 1 to Length(Value) do
  begin
    if Pos(Value[X],ComAcento) <> 0 then
      Value[X]:= SemAcento[Pos(Value[X], ComAcento)];

    Result:= Value;
  end;
end;

class function THelper.ReturnsInteger(const Value: string): string;
var 
  I: integer;
  stringValue: string;
begin
  stringValue:= '';
  for I:= 1 To Length(Value) Do
  begin
    if CharInSet((Value[I]),['0'..'9']) then
    begin
      stringValue:= stringValue + Copy(Value, I, 1);
    end;
  end;
  result:= stringValue;
end;

class function THelper.SerialDrive(Drive: string): string;
Var
	Serial,
	DirLen,
  Flags: DWORD;
	DirLabel: Array[0..11] of Char;
begin
  Try
    GetVolumeInformation(PChar(Drive+':\'),DirLabel,12,@Serial,DirLen,Flags,nil,0);
    Result:= IntToHex(Serial,8);
  Except
    Result:= EmptyStr;
  end;
end;

class function THelper.StrCentro(S: string; vt: integer): string;
Var
  X : integer;
begin
  X := StrToInt(ReturnsInteger(FloatToStr(TruncateValue((vt - Length(S)) / 2,0))));
  Result:= StringOfChar(' ',X) + S + StringOfChar(' ',X);
end;

class function THelper.StrDireita(S: string; vt: integer): string;
Var X : Integer;
    H : String;
begin
  H := StringOfChar(' ',vt);
  X := Length(S);
  Delete(H,1,X);
  Result := H+S ;
end;

class function THelper.StrEsquerda(S: string; vt: integer): string;
Var X : Integer;
    H : String;
begin
  H := StringOfChar(' ',vt);
  X := Length(S);
  Delete(H,1,X);

  if Length(S) > vt then
    S:= Copy(S,1,vt);

  Result := S+H;
end;

class function THelper.StringToExtended(Value: string): Extended;
begin
  Value:= Trim(Value);
  Value:= StringReplace(Value, '.', '', [rfReplaceAll]);
  Result:= StrToFloatDef(Value, 0);
end;

class function THelper.TruncateValue(Value: Extended;
  Decimal: integer): Extended;
Var
  stringValue: String;
  positionNumber: Integer;
begin
  stringValue:= FloatToStr(Value);
  positionNumber:= Pos(FormatSettings.DecimalSeparator, stringValue);
  if (positionNumber > 0) then
    stringValue:= Copy(stringValue, 1, positionNumber + Decimal);
  Result:= StrToFloatDef(stringValue, 0);
end;

class function THelper.ValidaCamposObrigatorios(Panel: TPanel): Boolean;
var
  I,A: Integer;
  Rs: string;
begin
  Result:= True;
  Rs:= '';
  for I:= 0 to Pred(Panel.ControlCount) do
  begin
    if Panel.Controls[I] is TLabeledEdit then
    begin
      if (TLabeledEdit(Panel.Controls[I]).Tag >= 1) and (Trim(TLabeledEdit(Panel.Controls[I]).Text) = EmptyStr) then
      begin
        TLabeledEdit(Panel.Controls[I]).Color:= $00AAAAFF;
        Rs:= 'S';
      end
      else
        TLabeledEdit(Panel.Controls[I]).Color:= clWhite;
    end
    else
    if Panel.Controls[I] is TMaskEdit then
    begin
      if (TMaskEdit(Panel.Controls[I]).Tag >= 1) and (Trim(TMaskEdit(Panel.Controls[I]).Text) = EmptyStr) then
      begin
        TMaskEdit(Panel.Controls[I]).Color:= $00AAAAFF;
        Rs:= 'S';
      end
      else
        TMaskEdit(Panel.Controls[I]).Color:= clWhite;
    end
    else
    if Panel.Controls[I] is TPanel then
    begin
      for A:= 0 to Pred((Panel.Controls[I] as TPanel).ControlCount ) do
      begin
        if (Panel.Controls[I] as TPanel).Controls[A] is TLabeledEdit then
        begin
          if (TLabeledEdit((Panel.Controls[I] as TPanel).Controls[A]).Tag >= 1) and
          (Trim(TLabeledEdit((Panel.Controls[I] as TPanel).Controls[A]).Text) = EmptyStr) then
          begin
            TLabeledEdit((Panel.Controls[I] as TPanel).Controls[A]).Color:= $00AAAAFF;
            Rs:= 'S';
          end
          else
            TLabeledEdit((Panel.Controls[I] as TPanel).Controls[A]).Color:= clWhite;
        end
        else
        if (Panel.Controls[I] as TPanel).Controls[A] is TMaskEdit then
        begin
          if (TMaskEdit((Panel.Controls[I] as TPanel).Controls[A]).Tag >= 1) and
          (Trim(TMaskEdit((Panel.Controls[I] as TPanel).Controls[A]).Text) = EmptyStr) then
          begin
            TMaskEdit((Panel.Controls[I] as TPanel).Controls[A]).Color:= $00AAAAFF;
            Rs:= 'S';
          end
          else
            TMaskEdit((Panel.Controls[I] as TPanel).Controls[A]).Color:= clWhite;
        end;
      end;
    end;
  end;

  if Rs <> '' then
    Result:= False;
end;

class function THelper.ValidarCNPJ(Value: string): Boolean;
Var
  d1, d4, xx, nCount, fator, resto, digito1, digito2: integer;
  Check: String;
begin
  if ((Value = '00000000000000') or (Value = '11111111111111') or
      (Value = '22222222222222') or (Value = '33333333333333') or
      (Value = '44444444444444') or (Value = '55555555555555') or
      (Value = '66666666666666') or (Value = '77777777777777') or
      (Value = '88888888888888') or (Value = '99999999999999') or
      (length(Value) <> 14))
     then begin
              Result := false;
              Exit();
            end;
  d1 := 0;
  d4 := 0;
  xx := 1;
  for nCount := 1 to Length(Value) - 2 do
  begin
    if Pos(Copy(Value, nCount, 1), '/-.') = 0 then
    begin
      if xx < 5 then
      begin
        fator := 6 - xx;
      end
      else
      begin
        fator := 14 - xx;
      end;
      d1 := d1 + StrToInt(Copy(Value, nCount, 1)) * fator;
      if xx < 6 then
      begin
        fator := 7 - xx;
      end
      else
      begin
        fator := 15 - xx;
      end;
      d4 := d4 + StrToInt(Copy(Value, nCount, 1)) * fator;
      xx := xx + 1;
    end;
  end;
  resto := (d1 mod 11);
  if resto < 2 then
  begin
    digito1 := 0;
  end
  else
  begin
    digito1 := 11 - resto;
  end;
  d4 := d4 + 2 * digito1;
  resto := (d4 mod 11);
  if resto < 2 then
  begin
    digito2 := 0;
  end
  else
  begin
    digito2 := 11 - resto;
  end;
  Check := IntToStr(digito1) + IntToStr(digito2);
  if Check <> Copy(Value, succ(Length(Value) - 2), 2) then
  begin
    Result := False;
  end
  else
  begin
    Result := True;
  end;
end;

class function THelper.ValidarCPF(Value: string): Boolean;
Var
  d1, d4, xx, nCount, resto, digito1, digito2: integer;
  Check: String;
Begin
  if (                           (Value = '11111111111') or
      (Value = '22222222222') or (Value = '33333333333') or
      (Value = '44444444444') or (Value = '55555555555') or
      (Value = '66666666666') or (Value = '77777777777') or
      (Value = '88888888888') or (Value = '99999999999') or
      (length(Value) <> 11))
     then begin
              Result := false;
              Exit();
            end;

  d1 := 0;
  d4 := 0;
  xx := 1;
  for nCount := 1 to Length(Value) - 2 do
  begin
    if Pos(Copy(Value, nCount, 1), '/-.') = 0 then
    begin
      d1 := d1 + (11 - xx) * StrToInt(Copy(Value, nCount, 1));
      d4 := d4 + (12 - xx) * StrToInt(Copy(Value, nCount, 1));
      xx := xx + 1;
    end;
  end;
  resto := (d1 mod 11);
  if resto < 2 then
  begin
    digito1 := 0;
  end
  else
  begin
    digito1 := 11 - resto;
  end;
  d4 := d4 + 2 * digito1;
  resto := (d4 mod 11);
  if resto < 2 then
  begin
    digito2 := 0;
  end
  else
  begin
    digito2 := 11 - resto;
  end;
  Check := IntToStr(digito1) + IntToStr(digito2);
  if Check <> Copy(Value, succ(Length(Value) - 2), 2) then
  begin
    Result := False;
  end
  else
  begin
    Result := True;
  end;
end;

class function THelper.ValueIn(Value: Integer;
  const Values: array of Integer): Boolean;
var
  I: Integer;
begin
  Result:= False;
  for I:= Low(Values) to High(Values) do
  begin
    if (Value = Values[I]) then
    begin
      Result:= True;
      Break;
    end;
  end;
end;

end.
