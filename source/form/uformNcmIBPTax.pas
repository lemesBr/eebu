unit uformNcmIBPTax;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  ACBrBase, ACBrSocket, ACBrIBPTax, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.DBCtrls, System.Actions, Vcl.ActnList;

type
  TformNcmIBPTax = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_export: TButton;
    pnl_body: TPanel;
    ACBrIBPTax: TACBrIBPTax;
    dbg_ncms: TDBGrid;
    fdmt_impostos: TFDMemTable;
    ds_impostos: TDataSource;
    fdmt_impostosNCM: TStringField;
    fdmt_impostosDESCRICAO: TStringField;
    opd_csv: TOpenDialog;
    dbm_descricao: TDBMemo;
    btn_rollback: TButton;
    btn_update: TButton;
    pnl_search: TPanel;
    lbe_search: TLabeledEdit;
    acl_categorias: TActionList;
    act_rollback: TAction;
    act_ncm_update: TAction;
    act_ncm_export: TAction;
    tmr_focus: TTimer;
    fdmt_impostosNACIONAL: TFloatField;
    fdmt_impostosIMPORTADO: TFloatField;
    fdmt_impostosESTADUAL: TFloatField;
    fdmt_impostosMUNICIPAL: TFloatField;
    bvl_3: TBevel;
    bvl_4: TBevel;
    procedure dbg_ncmsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_ncm_updateExecute(Sender: TObject);
    procedure act_ncm_exportExecute(Sender: TObject);
    procedure acl_categoriasUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure tmr_focusTimer(Sender: TObject);
    procedure lbe_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure importNCM();
    procedure list(search: string);
  public
    { Public declarations }
  end;

var
  formNcmIBPTax: TformNcmIBPTax;

implementation

uses
  AuthService, Ncm, Helper, udmRepository;

{$R *.dfm}

procedure TformNcmIBPTax.acl_categoriasUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_ncm_export.Visible:= (Self.Tag = 1);
  act_ncm_export.Enabled:= (Self.Tag = 1) and (fdmt_impostos.RecordCount >= 1);
  tmr_focus.Enabled:= (not lbe_search.Focused);
end;

procedure TformNcmIBPTax.act_ncm_exportExecute(Sender: TObject);
begin
  if not (Self.Tag = 1) then Exit();

  TAuthService.Ncm:= fdmt_impostosNCM.AsString;
  Close;
end;

procedure TformNcmIBPTax.act_ncm_updateExecute(Sender: TObject);
begin
  importNCM();
end;

procedure TformNcmIBPTax.act_rollbackExecute(Sender: TObject);
begin
  TAuthService.Ncm:= EmptyStr;
  Close;
end;

procedure TformNcmIBPTax.dbg_ncmsDrawColumnCell(Sender: TObject;
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

procedure TformNcmIBPTax.FormCreate(Sender: TObject);
begin
  inherited;
  dbg_ncms.OnDblClick:= act_ncm_exportExecute;
end;

procedure TformNcmIBPTax.importNCM;
var
  Ncm: TNcm;
  I: Integer;
begin
  Ncm:= nil;
  if opd_csv.Execute() then
  begin
    if ACBrIBPTax.AbrirTabela(opd_csv.FileName) then
    begin
      fdmt_impostos.Open();
      fdmt_impostos.DisableControls;
      fdmt_impostos.EmptyDataSet;
      for I:= 0 to Pred(ACBrIBPTax.Itens.Count) do
      begin
        fdmt_impostos.Append;
        fdmt_impostosNCM.AsString:= ACBrIBPTax.Itens[I].NCM;
        fdmt_impostosDESCRICAO.AsString:= UpperCase(THelper.RemoveAcentos(ACBrIBPTax.Itens[I].DESCRICAO));
        fdmt_impostosNACIONAL.AsFloat:= ACBrIBPTax.Itens[I].FEDERALNACIONAL;
        fdmt_impostosIMPORTADO.AsFloat:= ACBrIBPTax.Itens[I].FEDERALIMPORTADO;
        fdmt_impostosESTADUAL.AsFloat:= ACBrIBPTax.Itens[I].ESTADUAL;
        fdmt_impostosMUNICIPAL.AsFloat:= ACBrIBPTax.Itens[I].MUNICIPAL;
        fdmt_impostos.Post;
      end;
      if (fdmt_impostos.RecordCount >= 1) then TNcm.removeAll();
      fdmt_impostos.First;
      while not fdmt_impostos.Eof do
      begin
        if not Assigned(Ncm) then Ncm:= TNcm.Create;

        Ncm.Ncm:= fdmt_impostosNCM.AsString;
        Ncm.Descricao:= fdmt_impostosDESCRICAO.AsString;
        Ncm.Nacional:= fdmt_impostosNACIONAL.AsExtended;
        Ncm.Importado:= fdmt_impostosIMPORTADO.AsExtended;
        Ncm.Estadual:= fdmt_impostosESTADUAL.AsExtended;
        Ncm.Municipal:= fdmt_impostosMUNICIPAL.AsExtended;
        Ncm.save();

        fdmt_impostos.Next;
      end;
      fdmt_impostos.First;
      fdmt_impostos.EnableControls;
    end;
  end;
  FreeAndNil(Ncm);
end;

procedure TformNcmIBPTax.lbe_searchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: begin
      if (Trim(TCustomEdit(Sender).Text) <> EmptyStr) then
        list(Trim(TCustomEdit(Sender).Text));
    end;
    38: begin
      fdmt_impostos.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_impostos.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformNcmIBPTax.list(search: string);
begin
  TNcm.list(search, fdmt_impostos);
end;

procedure TformNcmIBPTax.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_search.Focused then lbe_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
