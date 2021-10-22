unit uformItemMovimentoList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ComCtrls, Item, System.DateUtils, Vcl.DBCtrls, System.Actions,
  Vcl.ActnList;

type
  TformItemMovimentoList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    bvl_4: TBevel;
    pnl_search: TPanel;
    dbg_movimento: TDBGrid;
    pnl_totais: TPanel;
    bvl_3: TBevel;
    fdmt_movimento: TFDMemTable;
    ds_movimento: TDataSource;
    tmr_focus: TTimer;
    lbe_item: TLabeledEdit;
    dtp_start: TDateTimePicker;
    dtp_end: TDateTimePicker;
    fdmt_movimentoMOVIMENTO: TDateTimeField;
    fdmt_movimentoPESSOA: TStringField;
    fdmt_movimentoUSUARIO: TStringField;
    fdmt_movimentoANTERIOR: TFloatField;
    fdmt_movimentoMOVIMENTADO: TFloatField;
    fdmt_movimentoATUAL: TFloatField;
    fdmt_movimentoDESCRICAO: TStringField;
    fdmt_movimentoTIPO: TIntegerField;
    dbt_descricao: TDBText;
    btn_rollback: TButton;
    btn_movimento_imprimir: TButton;
    acl_movimento: TActionList;
    act_rollback: TAction;
    act_movimento_imprimir: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbe_itemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbg_movimentoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_movimento_imprimirExecute(Sender: TObject);
    procedure tmr_focusTimer(Sender: TObject);
    procedure acl_movimentoUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
    Item: TItem;
    procedure list(ItemId: string; sDate, eDate: TDate);
  public
    { Public declarations }
  end;

var
  formItemMovimentoList: TformItemMovimentoList;

implementation

uses
  AuthService, uformItemList, udmRepository, Helper;

{$R *.dfm}

{ TformItemMovimentoList }

procedure TformItemMovimentoList.acl_movimentoUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  tmr_focus.Enabled:= (not lbe_item.Focused);
end;

procedure TformItemMovimentoList.act_movimento_imprimirExecute(Sender: TObject);
begin
  lbe_item.SetFocus;
  THelper.Mensagem('Funcionalidade está sendo implementada pelos nossos desenvolvedores.');
end;

procedure TformItemMovimentoList.act_rollbackExecute(Sender: TObject);
begin
  Close;
end;

procedure TformItemMovimentoList.dbg_movimentoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  If (gdSelected in state) then
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);

  if not fdmt_movimento.IsEmpty then
  begin
    if Column.FieldName = 'TIPO' then
    begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      if (fdmt_movimentoTIPO.AsInteger >= 1) then
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 7, Rect.Top + 1, 7)
      else
        dmRepository.iml_16.Draw(TDBGrid(Sender).Canvas,Rect.Left + 7, Rect.Top + 1, 6);
    end;
  end;
end;

procedure TformItemMovimentoList.FormCreate(Sender: TObject);
begin
  inherited;
  dtp_start.Date:= IncMonth(Now,-1);
  dtp_end.Date:= Now;

  if (TAuthService.ItemId <> EmptyStr) then
  begin
    Item:= TItem.find(TAuthService.ItemId);
    lbe_item.Text:= Item.Nome;
    list(Item.Id,dtp_start.Date,dtp_end.Date);
  end
  else
    FreeAndNil(Item);
end;

procedure TformItemMovimentoList.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Item);
end;

procedure TformItemMovimentoList.lbe_itemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  v_form: TformItemList;
begin
  case Key of
    38: begin
      fdmt_movimento.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_movimento.Next;
      Key:= 35;
    end;
    112: begin
      TAuthService.ItemId:= EmptyStr;
      try
        v_form:= TformItemList.Create(nil);
        v_form.Tag:= 1;
        v_form.ShowModal;
      finally
        FreeAndNil(v_form);
      end;

      if (TAuthService.ItemId <> EmptyStr) then
      begin
        FreeAndNil(Item);
        Item:= TItem.find(TAuthService.ItemId);
        lbe_item.Text:= Item.Nome;
        list(Item.Id,dtp_start.Date,dtp_end.Date);
      end;
    end;
  end;
end;

procedure TformItemMovimentoList.list(ItemId: string; sDate, eDate: TDate);
begin
  TItem.movimento(ItemId,sDate,eDate,fdmt_movimento);
end;

procedure TformItemMovimentoList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_item.Focused and
    not dtp_start.Focused and
    not dtp_end.Focused then lbe_item.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
