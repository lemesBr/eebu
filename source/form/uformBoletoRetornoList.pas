unit uformBoletoRetornoList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, Generics.Collections,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, System.Actions, Vcl.ActnList, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, ACBrBoleto, Conta;

type
  TformBoletoRetornoList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_boletos_header: TPanel;
    pnl_boletos_footer: TPanel;
    pnl_boletos_body: TPanel;
    btn_rollback: TButton;
    btn_read_retorno: TButton;
    dbg_boletos: TDBGrid;
    fdmt_boletos: TFDMemTable;
    fdmt_boletosID: TStringField;
    ds_boletos: TDataSource;
    acl_boletos: TActionList;
    act_rollback: TAction;
    act_importar_retorno: TAction;
    opd_retorno: TOpenDialog;
    btn_confirm_retorno: TButton;
    act_confirmar_retorno: TAction;
    pnl_boletos_conta: TPanel;
    lbe_boletos_conta: TLabeledEdit;
    bvl_3: TBevel;
    tmr_focus: TTimer;
    fdmt_boletosBOLETO: TStringField;
    fdmt_boletosPESSOA: TStringField;
    fdmt_boletosREFERENTE: TStringField;
    fdmt_boletosVALOR_RECEBIDO: TFloatField;
    fdmt_boletosDATA_CREDITO: TDateField;
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_importar_retornoExecute(Sender: TObject);
    procedure dbg_boletosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure acl_boletosUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure act_confirmar_retornoExecute(Sender: TObject);
    procedure lbe_boletos_contaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tmr_focusTimer(Sender: TObject);
  private
    { Private declarations }
    Conta: TConta;
  public
    { Public declarations }
  end;

var
  formBoletoRetornoList: TformBoletoRetornoList;

implementation

uses
  Boleto, AuthService, uformContaList, udmRepository;

{$R *.dfm}

procedure TformBoletoRetornoList.acl_boletosUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_importar_retorno.Enabled:= Assigned(Conta);
  act_confirmar_retorno.Enabled:= (fdmt_boletos.RecordCount >= 1);
  tmr_focus.Enabled:= (not lbe_boletos_conta.Focused);
end;

procedure TformBoletoRetornoList.act_confirmar_retornoExecute(Sender: TObject);
begin
  if TBoleto.confirmarRetorno(fdmt_boletos) then
  begin
    FreeAndNil(Conta);
    lbe_boletos_conta.Text:= EmptyStr;
    fdmt_boletos.EmptyDataSet;
  end;
end;

procedure TformBoletoRetornoList.act_importar_retornoExecute(Sender: TObject);
var
  Boleto: TBoleto;
  ACBrBoleto: TACBrBoleto;
  I: Integer;
begin
  if opd_retorno.Execute then
  begin
    try
      try
        Boleto:= nil;
        ACBrBoleto:= nil;
        if not Assigned(Conta.BoletoConfiguracao) then
          raise Exception.Create('Conta sem dados do banco.');

        if not Assigned(Conta.Cedente) then
          raise Exception.Create('Conta sem dados do cedente.');

        ACBrBoleto:= TACBrBoleto.Create(nil);
        ACBrBoleto.Banco.TipoCobranca:= TACBrTipoCobranca(Conta.BoletoConfiguracao.TipoCobranca);
        ACBrBoleto.Cedente.CodigoCedente:= Conta.Cedente.CodigoCedente;
        ACBrBoleto.Cedente.Agencia:= Conta.Cedente.Agencia;
        ACBrBoleto.Cedente.AgenciaDigito:= Conta.Cedente.AgenciaDigito;
        ACBrBoleto.Cedente.Conta:= Conta.Cedente.Conta;
        ACBrBoleto.Cedente.ContaDigito:= Conta.Cedente.ContaDigito;

        ACBrBoleto.NomeArqRetorno:= opd_retorno.FileName;
        ACBrBoleto.LerRetorno();

        fdmt_boletos.Open();
        fdmt_boletos.DisableControls;
        fdmt_boletos.EmptyDataSet;

        for I:= 0 to Pred(ACBrBoleto.ListadeBoletos.Count) do
        begin
          if (ACBrBoleto.ListadeBoletos.Objects[I].OcorrenciaOriginal.Tipo = toRetornoLiquidado) then
          begin
            Boleto:= TBoleto.findByNumeroDocumento(ACBrBoleto.ListadeBoletos.Objects[I].NumeroDocumento);
            if Assigned(Boleto) then
            begin
              fdmt_boletos.Append;
              fdmt_boletos.FieldByName('ID').AsString:= Boleto.Id;
              fdmt_boletos.FieldByName('BOLETO').AsString:= Boleto.Recebimento.Boleto;
              fdmt_boletos.FieldByName('PESSOA').AsString:= Boleto.Recebimento.Pessoa.Nome;
              fdmt_boletos.FieldByName('REFERENTE').AsString:= Boleto.Recebimento.Descricao;
              fdmt_boletos.FieldByName('VALOR_RECEBIDO').AsExtended:= ACBrBoleto.ListadeBoletos.Objects[I].ValorRecebido;
              fdmt_boletos.FieldByName('DATA_CREDITO').AsDateTime:= ACBrBoleto.ListadeBoletos.Objects[I].DataCredito;
              fdmt_boletos.Post;
              FreeAndNil(Boleto);
            end;
          end;
        end;

        fdmt_boletos.First;
        fdmt_boletos.EnableControls;
      except on e: exception do
        raise Exception.Create('Falha ao importar arquivo de retorno. Erro: ' + e.Message);
      end;
    finally
      if Assigned(ACBrBoleto) then FreeAndNil(ACBrBoleto);
      if Assigned(Boleto) then FreeAndNil(Boleto);
    end;
  end;
end;

procedure TformBoletoRetornoList.act_rollbackExecute(Sender: TObject);
begin
  Close;
end;

procedure TformBoletoRetornoList.dbg_boletosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  if (gdSelected in State) then
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);
end;

procedure TformBoletoRetornoList.FormCreate(Sender: TObject);
begin
  inherited;
  FreeAndNil(Conta);
  fdmt_boletos.Open;
end;

procedure TformBoletoRetornoList.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Conta);
end;

procedure TformBoletoRetornoList.lbe_boletos_contaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  v_form: TformContaList;
begin
  case Key of
    112: begin
      if (fdmt_boletos.RecordCount >= 1) then Exit();

      TAuthService.ContaId:= EmptyStr;
      try
        v_form:= TformContaList.Create(nil);
        v_form.Tag:= 1;
        v_form.ShowModal;
      finally
        FreeAndNil(v_form);
      end;

      if (TAuthService.ContaId <> EmptyStr) then
      begin
        if Assigned(Conta) then FreeAndNil(Conta);
        Conta:= TConta.find(TAuthService.ContaId);
        lbe_boletos_conta.Text:= Conta.Nome;
      end;
    end;
    38: begin
      fdmt_boletos.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_boletos.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformBoletoRetornoList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_boletos_conta.Focused then lbe_boletos_conta.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
