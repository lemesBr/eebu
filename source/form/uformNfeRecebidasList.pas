unit uformNfeRecebidasList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Vcl.Grids, Vcl.DBGrids, System.Actions, Vcl.ActnList, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls, System.DateUtils,
  Vcl.DBCtrls, Vcl.Menus;

type
  TformNfeRecebidasList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    btn_rollback: TButton;
    ds_nfe_recebidas: TDataSource;
    tmr_focus: TTimer;
    acl_nfe_recebidas: TActionList;
    act_rollback: TAction;
    act_nfe_consultar: TAction;
    bvl_3: TBevel;
    btn_consultar: TButton;
    pnl_nfes_search: TPanel;
    lbe_nfes_search: TLabeledEdit;
    dtp_start: TDateTimePicker;
    dtp_end: TDateTimePicker;
    dbg_nfes: TDBGrid;
    fdmt_nfe_recebidas: TFDMemTable;
    fdmt_nfe_recebidasID: TStringField;
    fdmt_nfe_recebidasSERIE: TIntegerField;
    fdmt_nfe_recebidasNNF: TIntegerField;
    fdmt_nfe_recebidasDEMI: TDateField;
    fdmt_nfe_recebidasPARTICIPANTE: TStringField;
    fdmt_nfe_recebidasVNF: TCurrencyField;
    pnl_chave: TPanel;
    bvl_4: TBevel;
    fdmt_nfe_recebidasCHNFE: TStringField;
    dbl_chave: TDBText;
    ppm_nfe: TPopupMenu;
    btn_nfe: TButton;
    act_nfe_conhecimento: TAction;
    MANIFESTARCONHECIMENTO: TMenuItem;
    act_nfe_desconhecimento: TAction;
    MANIFESTARDESCONHECIMENTO: TMenuItem;
    act_nfe_itens: TAction;
    act_nfe_confirmar: TAction;
    ITENS: TMenuItem;
    CONFIRMARENTRADA: TMenuItem;
    act_nfe_imprimir: TAction;
    IMPRIMIR: TMenuItem;
    fdmt_nfe_recebidasNFERECEBIDA: TIntegerField;
    btn_importar: TButton;
    act_nfe_importar: TAction;
    OpenDialog: TOpenDialog;
    act_nfe_sped: TAction;
    AJUSTARPARAOSPED: TMenuItem;
    fdmt_nfe_recebidasMODELO: TStringField;
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_nfe_consultarExecute(Sender: TObject);
    procedure act_nfe_confirmarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbg_nfesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure acl_nfe_recebidasUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure lbe_nfes_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmr_focusTimer(Sender: TObject);
    procedure act_nfe_conhecimentoExecute(Sender: TObject);
    procedure act_nfe_desconhecimentoExecute(Sender: TObject);
    procedure act_nfe_itensExecute(Sender: TObject);
    procedure act_nfe_imprimirExecute(Sender: TObject);
    procedure act_nfe_importarExecute(Sender: TObject);
    procedure act_nfe_spedExecute(Sender: TObject);
  private
    { Private declarations }
    procedure list(search: string);
  public
    { Public declarations }
  end;

var
  formNfeRecebidasList: TformNfeRecebidasList;

implementation

uses
  Nfe, udmRepository, Helper, pcnConversao, uformNfeRecebidaDetList,
  AuthService, uformCompraCreateEdit, uformOperacaoFiscalList;

{$R *.dfm}

procedure TformNfeRecebidasList.acl_nfe_recebidasUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_nfe_conhecimento.Enabled:=
    (fdmt_nfe_recebidas.RecordCount >= 1) and
      (fdmt_nfe_recebidasNFERECEBIDA.AsInteger = 0);
  act_nfe_desconhecimento.Enabled:=
    (fdmt_nfe_recebidas.RecordCount >= 1) and
      (fdmt_nfe_recebidasNFERECEBIDA.AsInteger = 0);
  act_nfe_imprimir.Enabled:=
    (fdmt_nfe_recebidas.RecordCount >= 1) and
      (fdmt_nfe_recebidasNFERECEBIDA.AsInteger in [2,3,4]);
  act_nfe_itens.Enabled:=
    (fdmt_nfe_recebidas.RecordCount >= 1) and
      (fdmt_nfe_recebidasNFERECEBIDA.AsInteger in [2,3,4]);
  act_nfe_confirmar.Enabled:=
    (fdmt_nfe_recebidas.RecordCount >= 1) and
      (fdmt_nfe_recebidasNFERECEBIDA.AsInteger = 2);
  act_nfe_sped.Enabled:=
    (fdmt_nfe_recebidas.RecordCount >= 1) and
      (fdmt_nfe_recebidasNFERECEBIDA.AsInteger in [3,4]);

  tmr_focus.Enabled:= (not lbe_nfes_search.Focused);

  if (fdmt_nfe_recebidas.RecordCount >= 1) then
    pnl_chave.Caption:= dbl_chave.Caption
  else
    pnl_chave.Caption:= EmptyStr;
end;

procedure TformNfeRecebidasList.act_nfe_confirmarExecute(Sender: TObject);
var
  v_form: TformCompraCreateEdit;
begin
  TAuthService.CompraId:= EmptyStr;
  TAuthService.NfeId:= fdmt_nfe_recebidasID.AsString;

  if not TNfe.itensAjustados(TAuthService.NfeId) then
  begin
    THelper.Mensagem('Ajuste os itens da nota antes de confirmar.');
    TAuthService.NfeId:= EmptyStr;
    Exit();
  end;

  try
    v_form:= TformCompraCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.NfeId <> EmptyStr) then
    list(Trim(lbe_nfes_search.Text));
end;

procedure TformNfeRecebidasList.act_nfe_conhecimentoExecute(Sender: TObject);
begin
  try
    TNfe.manifestarCiencia(fdmt_nfe_recebidasID.AsString);
    list(Trim(lbe_nfes_search.Text));
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformNfeRecebidasList.act_nfe_consultarExecute(Sender: TObject);
begin
  TNfe.consultaNfeRecebidas();
  list(Trim(lbe_nfes_search.Text));
end;

procedure TformNfeRecebidasList.act_nfe_desconhecimentoExecute(Sender: TObject);
begin
  //
end;

procedure TformNfeRecebidasList.act_nfe_importarExecute(Sender: TObject);
begin
  try
    OpenDialog.Title:= 'Selecione o arquivo XML';
    OpenDialog.DefaultExt:= '*.XML';
    OpenDialog.Filter:= 'Arquivos XML (*.XML)|*.XML';
    if OpenDialog.Execute then
    begin
      TNfe.importarXML(OpenDialog.FileName, 1);
      list(Trim(lbe_nfes_search.Text));
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformNfeRecebidasList.act_nfe_imprimirExecute(Sender: TObject);
begin
  TNfe.imprimir(fdmt_nfe_recebidasID.AsString, 0);
end;

procedure TformNfeRecebidasList.act_nfe_itensExecute(Sender: TObject);
var
  v_form: TformNfeRecebidaDetList;
begin
  TAuthService.NfeId:= fdmt_nfe_recebidasID.AsString;
  try
    v_form:= TformNfeRecebidaDetList.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;
end;

procedure TformNfeRecebidasList.act_nfe_spedExecute(Sender: TObject);
var
  v_form: TformOperacaoFiscalList;
begin
  TAuthService.NfeId:= fdmt_nfe_recebidasID.AsString;
  TAuthService.OperacaoFiscalId:= EmptyStr;
  try
    v_form:= TformOperacaoFiscalList.Create(nil);
    v_form.Tag:= 1;
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.OperacaoFiscalId = EmptyStr) then
  begin
    TAuthService.NfeId:= EmptyStr;
    Exit();
  end;

  try
    TNfe.nfeToEfd(TAuthService.NfeId, TAuthService.OperacaoFiscalId);
    list(Trim(lbe_nfes_search.Text));
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformNfeRecebidasList.act_rollbackExecute(Sender: TObject);
begin
  Close;
end;

procedure TformNfeRecebidasList.dbg_nfesDrawColumnCell(Sender: TObject;
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

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);

  if (fdmt_nfe_recebidas.RecordCount >= 1) then
  begin
    if Column.FieldName = 'NFERECEBIDA' then
    begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      case fdmt_nfe_recebidasNFERECEBIDA.AsInteger of
        0: dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 8, Rect.Top + 1, 8);
        1: dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 8, Rect.Top + 1, 9);
        2: dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 8, Rect.Top + 1, 10);
        3: dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 8, Rect.Top + 1, 11);
        4: dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 8, Rect.Top + 1, 1);
      end;
    end;
  end;
end;

procedure TformNfeRecebidasList.FormCreate(Sender: TObject);
begin
  inherited;
  dtp_start.Date:= StartOfTheMonth(Now);
  dtp_end.Date:= Now;
  list('');
end;

procedure TformNfeRecebidasList.lbe_nfes_searchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN: list(Trim(TCustomEdit(Sender).Text));
    38: begin
      fdmt_nfe_recebidas.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_nfe_recebidas.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformNfeRecebidasList.list(search: string);
begin
  TNfe.listRecebidas(dtp_start.Date, dtp_end.Date, search, fdmt_nfe_recebidas);
end;

procedure TformNfeRecebidasList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_nfes_search.Focused and
    not dtp_start.Focused and
    not dtp_end.Focused then lbe_nfes_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= False;
  end;
end;

end.
