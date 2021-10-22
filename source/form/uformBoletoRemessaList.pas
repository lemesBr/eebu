unit uformBoletoRemessaList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Actions, Vcl.ActnList, Conta;

type
  TformBoletoRemessaList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_remessa_header: TPanel;
    pnl_remessa_footer: TPanel;
    btn_gerar_remessa: TButton;
    pnl_remessa_body: TPanel;
    dbg_boletos: TDBGrid;
    fdmt_boletos: TFDMemTable;
    fdmt_boletosID: TStringField;
    fdmt_boletosPROCESSAMENTO: TDateField;
    ds_boletos: TDataSource;
    acl_boletos: TActionList;
    act_rollback: TAction;
    act_gerar_remessa: TAction;
    btn_rollback: TButton;
    pnl_boletos_conta: TPanel;
    lbe_boletos_conta: TLabeledEdit;
    tmr_focus: TTimer;
    bvl_3: TBevel;
    fdmt_boletosBOLETO: TStringField;
    fdmt_boletosPESSOA: TStringField;
    fdmt_boletosREFERENTE: TStringField;
    fdmt_boletosVENCIMENTO: TDateField;
    fdmt_boletosVALOR: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure dbg_boletosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_gerar_remessaExecute(Sender: TObject);
    procedure acl_boletosUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure lbe_boletos_contaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure tmr_focusTimer(Sender: TObject);
  private
    { Private declarations }
    Conta: TConta;
    procedure list();
  public
    { Public declarations }
  end;

var
  formBoletoRemessaList: TformBoletoRemessaList;

implementation

uses
  Boleto, AuthService, uformContaList, udmRepository;

{$R *.dfm}

{ TformBoletoRemessaList }

procedure TformBoletoRemessaList.acl_boletosUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_gerar_remessa.Enabled:= (fdmt_boletos.RecordCount >= 1);
  tmr_focus.Enabled:= (not lbe_boletos_conta.Focused);
end;

procedure TformBoletoRemessaList.act_gerar_remessaExecute(Sender: TObject);
begin
  if TBoleto.GerarArquivoRemessa(Conta.Id) then
  begin
    FreeAndNil(Conta);
    lbe_boletos_conta.Text:= EmptyStr;
    fdmt_boletos.EmptyDataSet;
  end;
end;

procedure TformBoletoRemessaList.act_rollbackExecute(Sender: TObject);
begin
  Close;
end;

procedure TformBoletoRemessaList.dbg_boletosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  If (gdSelected in state) then
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);
end;

procedure TformBoletoRemessaList.FormCreate(Sender: TObject);
begin
  inherited;
  FreeAndNil(Conta);
  fdmt_boletos.Open;
end;

procedure TformBoletoRemessaList.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Conta);
end;

procedure TformBoletoRemessaList.lbe_boletos_contaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  v_form: TformContaList;
begin
  case Key of
    112: begin
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
        list();
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

procedure TformBoletoRemessaList.list();
begin
  TBoleto.listByContaIdRemessaIsNull(Conta.Id, fdmt_boletos);
end;

procedure TformBoletoRemessaList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_boletos_conta.Focused then lbe_boletos_conta.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
