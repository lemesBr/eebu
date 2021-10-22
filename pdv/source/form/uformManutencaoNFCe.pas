unit uformManutencaoNFCe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, System.Actions, Vcl.ActnList, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Math, Vcl.Menus;

type
  TformManutencaoNFCe = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_rollback: TButton;
    btn_nfce: TButton;
    pnl_body: TPanel;
    bvl_3: TBevel;
    dbg_nfce: TDBGrid;
    pnl_search: TPanel;
    lbe_search: TLabeledEdit;
    fdmt_nfce: TFDMemTable;
    fdmt_nfceID: TStringField;
    ds_nfce: TDataSource;
    tmr_focus: TTimer;
    acl_nfce: TActionList;
    act_rollback: TAction;
    act_imprimir: TAction;
    act_cancelar: TAction;
    act_enviar: TAction;
    fdmt_nfceNNF: TIntegerField;
    fdmt_nfceCHNFE: TStringField;
    fdmt_nfcePESSOA: TStringField;
    fdmt_nfceTOTAL: TFloatField;
    fdmt_nfceCSTAT: TIntegerField;
    fdmt_nfceCHECK: TIntegerField;
    ppm_nfce: TPopupMenu;
    ENVIARNFCe1: TMenuItem;
    IMPRIMIRNFCe1: TMenuItem;
    CANCELARNFCe1: TMenuItem;
    pnl_totais: TPanel;
    bvl_4: TBevel;
    bvl_5: TBevel;
    pnl_totais_left: TPanel;
    pnl_totais_left_valores: TPanel;
    lb_nfce_geradas_valor: TLabel;
    lb_nfce_enviar_valor: TLabel;
    lb_nfce_canceladas_valor: TLabel;
    lb_nfce_enviadas_valor: TLabel;
    pnl_totais_left_legendas: TPanel;
    lb_nfce_geradas_legenda: TLabel;
    lb_nfce_enviar_legenda: TLabel;
    lb_nfce_canceladas_legenda: TLabel;
    lb_nfce_enviadas_legenda: TLabel;
    pnl_totais_right: TPanel;
    pnl_totais_right_valores: TPanel;
    lb_numero_nfce_valor: TLabel;
    lb_numero_nfce_selecionadas_valor: TLabel;
    lb_total_nfce_selecionadas_valor: TLabel;
    pnl_totais_right_legendas: TPanel;
    lb_numero_nfce_legenda: TLabel;
    lb_numero_nfce_selecionadas_legenda: TLabel;
    lb_total_nfce_selecionadas_legenda: TLabel;
    act_enviar_pendentes: TAction;
    ENVIARPENDENTES1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_enviarExecute(Sender: TObject);
    procedure dbg_nfceDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure lbe_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmr_focusTimer(Sender: TObject);
    procedure acl_nfceUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure dbg_nfceDblClick(Sender: TObject);
    procedure act_imprimirExecute(Sender: TObject);
    procedure act_cancelarExecute(Sender: TObject);
    procedure act_enviar_pendentesExecute(Sender: TObject);
  private
    { Private declarations }
    TotalPendentes: Integer;
    procedure list(pSearch: string);
    procedure calculaTotais();
  public
    { Public declarations }
  end;

var
  formManutencaoNFCe: TformManutencaoNFCe;

implementation

uses
  Nfe, udmRepository, Helper, AuthService, uformDescription;

{$R *.dfm}

{ TformManutencaoNFCe }

procedure TformManutencaoNFCe.acl_nfceUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_enviar.Enabled:= (fdmt_nfce.RecordCount >= 1) and (fdmt_nfceCSTAT.AsInteger in[0,99]);
  act_imprimir.Enabled:= (fdmt_nfce.RecordCount >= 1) and (fdmt_nfceCSTAT.AsInteger in[99,100,150]);
  act_cancelar.Enabled:= (fdmt_nfce.RecordCount >= 1) and (fdmt_nfceCSTAT.AsInteger in[100,150]);
  act_enviar_pendentes.Enabled:= (TotalPendentes >= 1);
  tmr_focus.Enabled:= (not lbe_search.Focused);
end;

procedure TformManutencaoNFCe.act_cancelarExecute(Sender: TObject);
var
  v_form: TformDescription;
begin
  TAuthService.Description:= 'JUSTIFICATIVA';
  try
    v_form:= TformDescription.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.Description = EmptyStr)  then Exit();

  try
    TNfe.cancelar(fdmt_nfceID.AsString);
    list(lbe_search.Text);
  except on e: exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformManutencaoNFCe.act_enviarExecute(Sender: TObject);
var
  vNFCe: TNfe;
begin
  try
    try
      vNFCe:= TNfe.find(fdmt_nfceID.AsString);
      vNFCe.enviar();
      list(lbe_search.Text);
    except on e: Exception do
      THelper.Mensagem(e.Message);
    end;
  finally
    FreeAndNil(vNFCe);
  end;
end;

procedure TformManutencaoNFCe.act_enviar_pendentesExecute(Sender: TObject);
var
  vNFCe: TNfe;
  vLoop: Integer;
begin
  vNFCe:= nil;
  vLoop:= 0;

  while (vLoop <= 1) do
  begin
    list('');
    if (TotalPendentes = 0) then Exit();

    while not fdmt_nfce.Eof do
    begin
      if (fdmt_nfceCSTAT.AsInteger in[0,99]) then
      begin
        try
          try
            vNFCe:= TNfe.find(fdmt_nfceID.AsString);
            vNFCe.enviar(2);

            fdmt_nfce.Edit();
            fdmt_nfceCSTAT.AsInteger:= 100;
            fdmt_nfce.Post();
          except
            //--
          end;
        finally
          FreeAndNil(vNFCe);
        end;
      end;

      fdmt_nfce.Next();
    end;

    Inc(vLoop);
  end;

  list('');
end;

procedure TformManutencaoNFCe.act_imprimirExecute(Sender: TObject);
begin
  try
    TNfe.imprimir(fdmt_nfceID.AsString, 0);
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformManutencaoNFCe.act_rollbackExecute(Sender: TObject);
begin
  Close();
end;

procedure TformManutencaoNFCe.calculaTotais;
var
  v_nfce_geradas,
  v_nfce_enviar,
  v_nfce_canceladas,
  v_nfce_enviadas: Extended;
  v_numero_nfce_selecionadas: Integer;
  v_total_nfce_selecionadas: Extended;
  vClone: TFDMemTable;
begin
  lb_numero_nfce_valor.Caption:= fdmt_nfce.RecordCount.ToString();
  TotalPendentes:= 0;
  v_nfce_geradas:= 0;
  v_nfce_enviar:= 0;
  v_nfce_canceladas:= 0;
  v_nfce_enviadas:= 0;
  v_numero_nfce_selecionadas:= 0;
  v_total_nfce_selecionadas:= 0;

  vClone:= TFDMemTable.Create(nil);
  vClone.CloneCursor(fdmt_nfce);
  vClone.DisableControls();
  vClone.First();
  while not vClone.Eof do
  begin
    v_nfce_geradas:= v_nfce_geradas + vClone.FieldByName('TOTAL').AsExtended;

    case vClone.FieldByName('CSTAT').AsInteger of
      0,99: v_nfce_enviar:= v_nfce_enviar + vClone.FieldByName('TOTAL').AsExtended;
      101,151: v_nfce_canceladas:= v_nfce_canceladas + vClone.FieldByName('TOTAL').AsExtended;
      100,150: v_nfce_enviadas:= v_nfce_enviadas + vClone.FieldByName('TOTAL').AsExtended;
    end;

    if vClone.FieldByName('CSTAT').AsInteger in[0,99] then
      Inc(TotalPendentes);

    if (vClone.FieldByName('CHECK').AsInteger >= 1) then
    begin
      Inc(v_numero_nfce_selecionadas);
      v_total_nfce_selecionadas:= v_total_nfce_selecionadas + vClone.FieldByName('TOTAL').AsExtended;
    end;

    vClone.Next();
  end;
  vClone.Close();
  FreeAndNil(vClone);

  lb_nfce_geradas_valor.Caption:= THelper.ExtendedToString(v_nfce_geradas);
  lb_nfce_enviar_valor.Caption:= THelper.ExtendedToString(v_nfce_enviar);
  lb_nfce_canceladas_valor.Caption:= THelper.ExtendedToString(v_nfce_canceladas);
  lb_nfce_enviadas_valor.Caption:= THelper.ExtendedToString(v_nfce_enviadas);
  lb_numero_nfce_selecionadas_valor.Caption:= v_numero_nfce_selecionadas.ToString();
  lb_total_nfce_selecionadas_valor.Caption:= THelper.ExtendedToString(v_total_nfce_selecionadas);
end;

procedure TformManutencaoNFCe.dbg_nfceDblClick(Sender: TObject);
begin
  if not (TDBGrid(Sender).DataSource.Dataset.RecordCount >= 1) then
    Exit();

  TDBGrid(Sender).DataSource.DataSet.Edit();
  TDBGrid(Sender).DataSource.DataSet.FieldByName('CHECK').AsInteger:=
    IfThen(TDBGrid(Sender).DataSource.DataSet.FieldByName('CHECK').AsInteger >= 1,0,1);
  TDBGrid(Sender).DataSource.DataSet.Post();

  calculaTotais();
end;

procedure TformManutencaoNFCe.dbg_nfceDrawColumnCell(Sender: TObject;
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

  if not fdmt_nfce.IsEmpty then
  begin
    if Column.FieldName = 'CSTAT' then
    begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      case fdmt_nfceCSTAT.AsInteger of
        99: dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 7, Rect.Top + 1, 19);
        100,150: dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 7, Rect.Top + 1, 1);
        101,151: dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 7, Rect.Top + 1, 23);
      end;
    end
    else if Column.FieldName = 'CHECK' then
    begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      if (fdmt_nfceCHECK.AsInteger >= 1) then
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 7, Rect.Top + 1, 5)
      else
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 7, Rect.Top + 1, 2);
    end;
  end;
end;

procedure TformManutencaoNFCe.FormCreate(Sender: TObject);
begin
  inherited;
  list('');
end;

procedure TformManutencaoNFCe.lbe_searchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    13: list(lbe_search.Text);
    38: begin
      fdmt_nfce.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_nfce.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformManutencaoNFCe.list(pSearch: string);
begin
  TNfe.list(Trim(pSearch), fdmt_nfce);
  calculaTotais();
end;

procedure TformManutencaoNFCe.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_search.Focused then lbe_search.SetFocus;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
