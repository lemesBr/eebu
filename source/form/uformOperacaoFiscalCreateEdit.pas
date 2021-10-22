unit uformOperacaoFiscalCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  OperacaoFiscal, System.Actions, Vcl.ActnList, System.Math, System.StrUtils;

type
  TformOperacaoFiscalCreateEdit = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_confirmar: TButton;
    pnl_body: TPanel;
    btn_cancelar: TButton;
    lbe_nome: TLabeledEdit;
    acl_operacao_fiscal: TActionList;
    act_cancelar: TAction;
    act_confirmar: TAction;
    cbx_modelo: TComboBox;
    lb_modelo: TLabel;
    cbx_tpnf: TComboBox;
    lb_tpnf: TLabel;
    lb_iddest: TLabel;
    cbx_finnfe: TComboBox;
    lb_finnfe: TLabel;
    cbx_tpimp: TComboBox;
    lb_tpimp: TLabel;
    cbx_indfinal: TComboBox;
    lb_indfinal: TLabel;
    cbx_iddest: TComboBox;
    Label1: TLabel;
    cbx_indpres: TComboBox;
    lb_indpres: TLabel;
    lbe_natop: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_confirmarExecute(Sender: TObject);
  private
    { Private declarations }
    OperacaoFiscal: TOperacaoFiscal;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();
  public
    { Public declarations }
  end;

var
  formOperacaoFiscalCreateEdit: TformOperacaoFiscalCreateEdit;

implementation

uses
  AuthService, udmRepository, Helper;

{$R *.dfm}

{ TformOperacaoFiscalCreateEdit }

procedure TformOperacaoFiscalCreateEdit.act_confirmarExecute(Sender: TObject);
begin
  save();
end;

procedure TformOperacaoFiscalCreateEdit.act_cancelarExecute(Sender: TObject);
begin
  TAuthService.OperacaoFiscalId:= EmptyStr;
  Close;
end;

procedure TformOperacaoFiscalCreateEdit.EdtToObj;
begin
  OperacaoFiscal.Nome:= lbe_nome.Text;
  case cbx_modelo.ItemIndex of
    0: OperacaoFiscal.Modelo:= '01';
    1: OperacaoFiscal.Modelo:= '1B';
    2: OperacaoFiscal.Modelo:= '04';
    3: OperacaoFiscal.Modelo:= '55';
    4: OperacaoFiscal.Modelo:= '65';
  end;
  OperacaoFiscal.Tpnf:= IntToStr(cbx_tpnf.ItemIndex);
  OperacaoFiscal.Finnfe:= IntToStr(cbx_finnfe.ItemIndex + 1);
  OperacaoFiscal.Tpimp:= IntToStr(cbx_tpimp.ItemIndex);
  OperacaoFiscal.Indfinal:= IntToStr(cbx_indfinal.ItemIndex);
  OperacaoFiscal.Iddest:= IntToStr(cbx_iddest.ItemIndex + 1);
  case cbx_indpres.ItemIndex of
    0: OperacaoFiscal.Indpres:= '0';
    1: OperacaoFiscal.Indpres:= '1';
    2: OperacaoFiscal.Indpres:= '2';
    3: OperacaoFiscal.Indpres:= '3';
    4: OperacaoFiscal.Indpres:= '4';
    5: OperacaoFiscal.Indpres:= '5';
    6: OperacaoFiscal.Indpres:= '9';
  end;
  OperacaoFiscal.Natop:= THelper.RemoveAcentos(lbe_natop.Text);
end;

procedure TformOperacaoFiscalCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  if TAuthService.OperacaoFiscalId = EmptyStr then OperacaoFiscal:= TOperacaoFiscal.Create
  else OperacaoFiscal:= TOperacaoFiscal.find(TAuthService.OperacaoFiscalId);
  ObjToEdt;
end;

procedure TformOperacaoFiscalCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(OperacaoFiscal);
end;

procedure TformOperacaoFiscalCreateEdit.ObjToEdt;
begin
  if (OperacaoFiscal.Id = EmptyStr) then
  begin
    pnl_header.Caption:= 'NOVA OPERAÇÃO FISCAL';
    cbx_modelo.ItemIndex:= 3;
    cbx_tpnf.ItemIndex:= 1;
    cbx_finnfe.ItemIndex:= 0;
    cbx_tpimp.ItemIndex:= 1;
    cbx_indfinal.ItemIndex:= 0;
    cbx_iddest.ItemIndex:= 0;
    cbx_indpres.ItemIndex:= 1;
    Exit();
  end;

  pnl_header.Caption:= 'EDITAR OPERAÇÃO FISCAL';
  lbe_nome.Text:= OperacaoFiscal.Nome;
  cbx_modelo.ItemIndex:= AnsiIndexStr(OperacaoFiscal.Modelo, ['01','1B','04','55','65']);
  cbx_tpnf.ItemIndex:= StrToIntDef(OperacaoFiscal.Tpnf, 0);
  cbx_finnfe.ItemIndex:= StrToIntDef(OperacaoFiscal.Finnfe, 1) - 1;
  cbx_tpimp.ItemIndex:= StrToIntDef(OperacaoFiscal.Tpimp, 1);
  cbx_indfinal.ItemIndex:= StrToIntDef(OperacaoFiscal.Indfinal, 0);
  cbx_iddest.ItemIndex:= StrToIntDef(OperacaoFiscal.Iddest, 1) - 1;
  cbx_indpres.ItemIndex:= IfThen(StrToIntDef(OperacaoFiscal.Indpres, 0) <= 5, StrToIntDef(OperacaoFiscal.Indpres, 0), 6);
  lbe_natop.Text:= OperacaoFiscal.Natop;
end;

procedure TformOperacaoFiscalCreateEdit.save;
begin
  EdtToObj;
  try
    if OperacaoFiscal.validate then
    begin
      if OperacaoFiscal.save then
      begin
        TAuthService.OperacaoFiscalId:= OperacaoFiscal.Id;
        Close;
      end;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

end.
