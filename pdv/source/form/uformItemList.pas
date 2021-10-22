unit uformItemList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Vcl.Grids, Vcl.DBGrids, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Actions, Vcl.ActnList;

type
  TformItemList = class(TformBase)
    acl_itens: TActionList;
    act_rollback: TAction;
    act_export: TAction;
    fdmt_itens: TFDMemTable;
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_export: TButton;
    btn_rollback: TButton;
    pnl_body: TPanel;
    bvl_3: TBevel;
    pnl_search: TPanel;
    lbe_search: TLabeledEdit;
    dbg_itens: TDBGrid;
    ds_itens: TDataSource;
    fdmt_itensID: TStringField;
    tmr_focus: TTimer;
    fdmt_itensREFERENCIA: TIntegerField;
    fdmt_itensEAN: TStringField;
    fdmt_itensNOME: TStringField;
    fdmt_itensPRECO_VENDA: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure acl_itensUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure act_exportExecute(Sender: TObject);
    procedure act_rollbackExecute(Sender: TObject);
    procedure dbg_itensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure lbe_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmr_focusTimer(Sender: TObject);
    procedure lbe_searchChange(Sender: TObject);
  private
    { Private declarations }
    procedure list(search: string);
  public
    { Public declarations }
  end;

var
  formItemList: TformItemList;

implementation

uses
  Item, AuthService, udmRepository;

{$R *.dfm}

{ TformItemList }

procedure TformItemList.acl_itensUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_export.Enabled:= (fdmt_itens.RecordCount >= 1);
  tmr_focus.Enabled:= (not lbe_search.Focused);
end;

procedure TformItemList.act_exportExecute(Sender: TObject);
begin
  TAuthService.ItemReferencia:= fdmt_itensREFERENCIA.AsInteger;
  Close();
end;

procedure TformItemList.act_rollbackExecute(Sender: TObject);
begin
  TAuthService.ItemReferencia:= 0;
  Close();
end;

procedure  TformItemList.dbg_itensDrawColumnCell(Sender: TObject;
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
end;

procedure TformItemList.FormCreate(Sender: TObject);
begin
  inherited;
  list('');
end;

procedure TformItemList.lbe_searchChange(Sender: TObject);
begin
  list(Trim(lbe_search.Text));
end;

procedure TformItemList.lbe_searchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    13: act_exportExecute(Sender);
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

procedure TformItemList.list(search: string);
begin
  Titem.list(search, fdmt_itens);
end;

procedure TformItemList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_search.Focused then lbe_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
