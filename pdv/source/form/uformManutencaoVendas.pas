unit uformManutencaoVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, System.Actions, Vcl.ActnList, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Math, System.StrUtils;

type
  TformManutencaoVendas = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    pnl_totais: TPanel;
    bvl_5: TBevel;
    bvl_6: TBevel;
    pnl_totais_left: TPanel;
    Panel1: TPanel;
    lbl_total_recebidas: TLabel;
    lbl_total_receber: TLabel;
    lbl_total_vencidas: TLabel;
    Panel2: TPanel;
    lbl_recebidas: TLabel;
    lbl_receber: TLabel;
    lbl_vencidas: TLabel;
    pnl_totais_right: TPanel;
    Panel3: TPanel;
    lbl_numero_lancamentos: TLabel;
    lbl_numero_lancamentos_selecionados: TLabel;
    lbl_total_lancamentos_selecionados: TLabel;
    Panel4: TPanel;
    lbl_lancamentos: TLabel;
    lbl_lancamentos_selecionados: TLabel;
    lbl_lancamentos_selecionados_total: TLabel;
    dbg_vendas: TDBGrid;
    pnl_search: TPanel;
    lbe_search: TLabeledEdit;
    btn_rollback: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    acl_vendas: TActionList;
    act_rollback: TAction;
    act_reimprimir: TAction;
    act_cancelar: TAction;
    act_nfce: TAction;
    fdmt_vendas: TFDMemTable;
    fdmt_vendasID: TStringField;
    fdmt_vendasREFERENCIA: TIntegerField;
    fdmt_vendasSUBTOTAL: TCurrencyField;
    fdmt_vendasACRESCIMO: TCurrencyField;
    fdmt_vendasDESCONTO: TCurrencyField;
    fdmt_vendasTOTAL: TCurrencyField;
    fdmt_vendasPESSOA: TStringField;
    fdmt_vendasSITUACAO: TStringField;
    fdmt_vendasCHECK: TIntegerField;
    fdmt_vendasCOMPETENCIA: TDateTimeField;
    ds_vendas: TDataSource;
    tmr_focus: TTimer;
    bvl_3: TBevel;
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_reimprimirExecute(Sender: TObject);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_nfceExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbg_vendasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbg_vendasDblClick(Sender: TObject);
    procedure lbe_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmr_focusTimer(Sender: TObject);
    procedure acl_vendasUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
    procedure list(pSearch: string);
    procedure calculaTotais();
  public
    { Public declarations }
  end;

var
  formManutencaoVendas: TformManutencaoVendas;

implementation

uses
  Venda, udmRepository, Helper, Nfe, AuthService;

{$R *.dfm}

procedure TformManutencaoVendas.acl_vendasUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_reimprimir.Enabled:= (fdmt_vendas.RecordCount >= 1);
  act_cancelar.Enabled:= (fdmt_vendas.RecordCount >= 1) and (fdmt_vendasSITUACAO.AsString = 'F');
  act_nfce.Enabled:= (fdmt_vendas.RecordCount >= 1) and (fdmt_vendasSITUACAO.AsString = 'F');
  tmr_focus.Enabled:= (not lbe_search.Focused);
end;

procedure TformManutencaoVendas.act_cancelarExecute(Sender: TObject);
var
  vVenda: TVenda;
begin
  lbe_search.SetFocus();
  if not (fdmt_vendas.RecordCount >= 1) then Exit();
  if not THelper.Mensagem('Deseja realmente cancelar?', 1) then Exit();

  try
    vVenda:= nil;
    try
      vVenda:= TVenda.find(fdmt_vendasID.AsString);
      vVenda.Situacao:= 'C';
      vVenda.save();

      fdmt_vendas.Edit();
      fdmt_vendasSITUACAO.AsString:= 'C';
      fdmt_vendas.Post();

      calculaTotais();
    except on e: Exception do
      THelper.Mensagem(e.Message);
    end;
  finally
    FreeAndNil(vVenda);
  end;
end;

procedure TformManutencaoVendas.act_nfceExecute(Sender: TObject);
var
  vNfe: TNfe;
begin
  lbe_search.SetFocus();
  if THelper.Mensagem('Deseja emitir nota fiscal de consumidor?', 1) then
  begin
    try
      try
        TAuthService.NfeId:= TNfe.vendaToNFCe(fdmt_vendasID.AsString);
        vNfe:= TNfe.find(TAuthService.NfeId);
        if Assigned(vNfe) then
        begin
          vNfe.enviar();

          fdmt_vendas.Edit();
          fdmt_vendasSITUACAO.AsString:= 'N';
          fdmt_vendas.Post();

          calculaTotais();
        end;
      except on e: Exception do
        THelper.Mensagem(e.Message);
      end;
    finally
      if Assigned(vNfe) then FreeAndNil(vNfe);
    end;
  end;
end;

procedure TformManutencaoVendas.act_reimprimirExecute(Sender: TObject);
begin
  lbe_search.SetFocus();
  if not (fdmt_vendas.RecordCount >= 1) then Exit();
  if not THelper.Mensagem('Deseja reimprimir o comprovante?', 1) then Exit();

  try
    TVenda.imprimir(fdmt_vendasID.AsString);
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformManutencaoVendas.act_rollbackExecute(Sender: TObject);
begin
  Close();
end;

procedure TformManutencaoVendas.calculaTotais;
var
  vTotalNFCeEmitida,
  vTotalVendaCancelada,
  vTotalVenda: Extended;
  TotalSelecionados: Integer;
  vTotalSelecionados: Extended;
  vClone: TFDMemTable;
begin
  lbl_numero_lancamentos.Caption:= fdmt_vendas.RecordCount.ToString();

  vTotalNFCeEmitida:= 0;
  vTotalVendaCancelada:= 0;
  vTotalVenda:= 0;
  TotalSelecionados:= 0;
  vTotalSelecionados:= 0;

  vClone:= TFDMemTable.Create(nil);
  vClone.CloneCursor(fdmt_vendas);
  vClone.DisableControls();
  vClone.First();
  while not vClone.Eof do
  begin
    case AnsiIndexStr(vClone.FieldByName('SITUACAO').AsString, ['F', 'C','N']) of
      0: vTotalVenda:= vTotalVenda + vClone.FieldByName('TOTAL').AsExtended;
      1: vTotalVendaCancelada:= vTotalVendaCancelada + vClone.FieldByName('SUBTOTAL').AsExtended;
      2: vTotalNFCeEmitida:= vTotalNFCeEmitida + vClone.FieldByName('TOTAL').AsExtended;
    end;

    if (vClone.FieldByName('CHECK').AsInteger >= 1) then
    begin
      Inc(TotalSelecionados);
      vTotalSelecionados:= vTotalSelecionados + vClone.FieldByName('TOTAL').AsExtended;
    end;

    vClone.Next();
  end;
  vClone.Close();
  FreeAndNil(vClone);

  lbl_total_recebidas.Caption:= THelper.ExtendedToString(vTotalNFCeEmitida);
  lbl_total_receber.Caption:= THelper.ExtendedToString(vTotalVendaCancelada);
  lbl_total_vencidas.Caption:= THelper.ExtendedToString(vTotalNFCeEmitida + vTotalVenda);
  lbl_numero_lancamentos_selecionados.Caption:= TotalSelecionados.ToString();
  lbl_total_lancamentos_selecionados.Caption:= THelper.ExtendedToString(vTotalSelecionados);
end;

procedure TformManutencaoVendas.dbg_vendasDblClick(Sender: TObject);
begin
  if not (TDBGrid(Sender).DataSource.Dataset.RecordCount >= 1) then
    Exit();

  TDBGrid(Sender).DataSource.DataSet.Edit();
  TDBGrid(Sender).DataSource.DataSet.FieldByName('CHECK').AsInteger:=
    IfThen(TDBGrid(Sender).DataSource.DataSet.FieldByName('CHECK').AsInteger >= 1,0,1);
  TDBGrid(Sender).DataSource.DataSet.Post();

  calculaTotais();
end;

procedure TformManutencaoVendas.dbg_vendasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  if (gdSelected in State) then
  begin
    TDBGrid(Sender).Canvas.Font.Style:= [fsBold];
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;
  end;

  if not Odd(TDBGrid(Sender).DataSource.DataSet.RecNo) then
  begin
    if not (gdSelected in State) then
    begin
      TDBGrid(Sender).Canvas.Brush.Color:= $00E2E2E2;
      TDBGrid(Sender).Canvas.FillRect(Rect);
      TDBGrid(Sender).DefaultDrawDataCell(Rect,Column.Field,State);
    end;
  end;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);

  if not fdmt_vendas.IsEmpty then
  begin
    if Column.FieldName = 'SITUACAO' then
    begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      if (fdmt_vendasSITUACAO.AsString = 'F') then
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 7, Rect.Top + 1, 1)
      else if (fdmt_vendasSITUACAO.AsString = 'C') then
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 7, Rect.Top + 1, 23)
      else if (fdmt_vendasSITUACAO.AsString = 'N') then
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 7, Rect.Top + 1, 20);
    end
    else if Column.FieldName = 'CHECK' then
    begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      if (fdmt_vendasCHECK.AsInteger >= 1) then
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 7, Rect.Top + 1, 5)
      else
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 7, Rect.Top + 1, 2);
    end;
  end;
end;

procedure TformManutencaoVendas.FormCreate(Sender: TObject);
begin
  inherited;
  list('');
end;

procedure TformManutencaoVendas.lbe_searchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    13: list(Trim(lbe_search.Text));
    38: begin
      fdmt_vendas.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_vendas.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformManutencaoVendas.list(pSearch: string);
begin
  TVenda.list(pSearch, fdmt_vendas);
  calculaTotais();
end;

procedure TformManutencaoVendas.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_search.Focused then lbe_search.SetFocus;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
