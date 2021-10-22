unit uformNfeRecebidaDetList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Actions, Vcl.ActnList, Nfe;

type
  TformNfeRecebidaDetList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    btn_categoria_store_receita: TButton;
    btn_rollback: TButton;
    pnl_search: TPanel;
    lbe_search: TLabeledEdit;
    bvl_3: TBevel;
    dbg_itens: TDBGrid;
    acl_itens: TActionList;
    act_rollback: TAction;
    act_ajustar_item: TAction;
    fdmt_itens: TFDMemTable;
    ds_itens: TDataSource;
    tmr_focus: TTimer;
    fdmt_itensID: TStringField;
    fdmt_itensCPROD: TStringField;
    fdmt_itensXPROD: TStringField;
    fdmt_itensCFOP: TStringField;
    fdmt_itensUCOM: TStringField;
    fdmt_itensQCOM: TFloatField;
    fdmt_itensVUNCOM: TFloatField;
    fdmt_itensVPROD: TFloatField;
    fdmt_itensVFRETE: TFloatField;
    fdmt_itensVSEG: TFloatField;
    fdmt_itensVDESC: TFloatField;
    fdmt_itensVOUTRO: TFloatField;
    fdmt_itensVTOTAL: TFloatField;
    bvl_4: TBevel;
    pnl_detalhe: TPanel;
    fdmt_itensITEM_ID: TStringField;
    fdmt_itensUNIDADE_CONVERSAO_ID: TStringField;
    lbe_item: TLabeledEdit;
    lbe_item_unidade: TLabeledEdit;
    lbe_conversor: TLabeledEdit;
    lbe_qtd_convertida: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure dbg_itensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_ajustar_itemExecute(Sender: TObject);
    procedure lbe_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmr_focusTimer(Sender: TObject);
    procedure acl_itensUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure fdmt_itensAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    vNfe: TNfe;
    procedure list(search: string);
  public
    { Public declarations }
  end;

var
  formNfeRecebidaDetList: TformNfeRecebidaDetList;

implementation

{$R *.dfm}

uses udmRepository, NfeDet, AuthService, uformNfeRecebidaDetEdit, Helper,
  CustomEditHelper;

{ TformNfeRecebidaDetList }

procedure TformNfeRecebidaDetList.acl_itensUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_ajustar_item.Enabled:= Assigned(vNfe) and (vNfe.Nferecebida = 2);
  tmr_focus.Enabled:= (not lbe_search.Focused);
end;

procedure TformNfeRecebidaDetList.act_ajustar_itemExecute(Sender: TObject);
var
  v_form: TformNfeRecebidaDetEdit;
begin
  TAuthService.NfeDetId:= fdmt_itensID.AsString;
  try
    v_form:= TformNfeRecebidaDetEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.NfeDetId <> EmptyStr) then
    list(Trim(lbe_search.Text));
end;

procedure TformNfeRecebidaDetList.act_rollbackExecute(Sender: TObject);
begin
  TAuthService.NfeId:= EmptyStr;
  Close;
end;

procedure TformNfeRecebidaDetList.dbg_itensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  if (fdmt_itensITEM_ID.AsString <> EmptyStr) and (fdmt_itensITEM_ID.AsString <> EmptyStr) then
    TDBGrid(Sender).Canvas.Font.Color:= clGreen
  else
    TDBGrid(Sender).Canvas.Font.Color:= clRed;

  if (gdSelected in State) then
  begin
    TDBGrid(Sender).Canvas.Font.Style:= [fsBold];
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;
  end;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);
end;

procedure TformNfeRecebidaDetList.fdmt_itensAfterScroll(DataSet: TDataSet);
var
  vDet: TNfeDet;
begin
  lbe_item.Text:= '';
  lbe_item_unidade.Text:= '';
  lbe_conversor.Text:= '';
  lbe_qtd_convertida.Text:= '0,000';

  if not (DataSet.RecordCount >= 1) then Exit();
  if (DataSet.FieldByName('ITEM_ID').AsString = EmptyStr) then Exit();

  vDet:= TNfeDet.find(DataSet.FieldByName('ID').AsString);
  if Assigned(vDet) then
  begin
    if Assigned(vDet.ITEM) then
    begin
      lbe_item.Text:= vDet.ITEM.Nome;
      lbe_item_unidade.Text:= vDet.ITEM.Unidade.Unidade;
    end;

    if Assigned(vDet.CONVERSOR) then
    begin
      lbe_conversor.Text:=
        '1 ' + vDet.CONVERSOR.Unidade +
        ' -> ' + THelper.ExtendedToString(vDet.CONVERSOR.FatorConversao, False) +
        ' ' + vDet.CONVERSOR.Item.Unidade.Unidade;
      lbe_qtd_convertida.Text:=
        THelper.ExtendedToString(vDet.Qcom * vDet.CONVERSOR.FatorConversao,False);
    end;

    FreeAndNil(vDet);
  end;
end;

procedure TformNfeRecebidaDetList.FormCreate(Sender: TObject);
begin
  inherited;
  lbe_qtd_convertida.Tag:= 1;
  TCustomEdit(lbe_qtd_convertida).EditFloat();
  vNfe:= TNfe.find(TAuthService.NfeId);
  pnl_header.Caption:= 'ITENS DA NOTA - ' + vNfe.Nnf.ToString();
  list('');
end;

procedure TformNfeRecebidaDetList.FormDestroy(Sender: TObject);
begin
  FreeAndNil(vNfe);
end;

procedure TformNfeRecebidaDetList.lbe_searchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN: list(Trim(TCustomEdit(Sender).Text));
    38: begin
      fdmt_itens.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_itens.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformNfeRecebidaDetList.list(search: string);
begin
  TNfeDet.findByNfeRecebidaId(vNfe.Id, search, fdmt_itens);
end;

procedure TformNfeRecebidaDetList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_search.Focused then lbe_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= False;
  end;
end;

end.
