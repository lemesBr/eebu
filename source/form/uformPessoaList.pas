unit uformPessoaList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.pngimage, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Actions, Vcl.ActnList;

type
  TformPessoaList = class(TformBase)
    acl_pessoas: TActionList;
    act_rollback: TAction;
    act_pessoa_store: TAction;
    act_pessoa_update: TAction;
    act_pessoa_export: TAction;
    fdmt_pessoas: TFDMemTable;
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_pessoas_head: TPanel;
    pnl_pessoas_foooter: TPanel;
    btn_pessoa_export: TButton;
    btn_pessoa_store: TButton;
    btn_pessoa_update: TButton;
    btn_rollback: TButton;
    pnl_pessoas_body: TPanel;
    bvl_3: TBevel;
    pnl_pessoas_search: TPanel;
    lbe_pessoas_search: TLabeledEdit;
    dbg_pessoas: TDBGrid;
    tmr_focus: TTimer;
    ds_pessoas: TDataSource;
    fdmt_pessoasID: TStringField;
    fdmt_pessoasNOME: TStringField;
    fdmt_pessoasDOCUMENTO: TStringField;
    fdmt_pessoasEMAIL: TStringField;
    fdmt_pessoasFONE: TStringField;
    fdmt_pessoasCODIGO: TIntegerField;
    btn_pessoa_destroy: TButton;
    act_pessoa_destroy: TAction;
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_pessoa_storeExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbe_pessoas_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbg_pessoasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure tmr_focusTimer(Sender: TObject);
    procedure acl_pessoasUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure act_pessoa_updateExecute(Sender: TObject);
    procedure act_pessoa_exportExecute(Sender: TObject);
    procedure act_pessoa_destroyExecute(Sender: TObject);
  private
    { Private declarations }
    procedure list(search: string);
  public
    { Public declarations }
  end;

var
  formPessoaList: TformPessoaList;

implementation

uses
  AuthService, uformPessoaCreateEdit, Pessoa, udmRepository;

{$R *.dfm}

procedure TformPessoaList.acl_pessoasUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_pessoa_update.Enabled:= (fdmt_pessoas.RecordCount >= 1);
  act_pessoa_destroy.Enabled:= (fdmt_pessoas.RecordCount >= 1);
  act_pessoa_export.Visible:= (Self.Tag = 1);
  act_pessoa_export.Enabled:= (Self.Tag = 1) and (fdmt_pessoas.RecordCount >= 1);
  tmr_focus.Enabled:= (not lbe_pessoas_search.Focused);
end;

procedure TformPessoaList.act_pessoa_updateExecute(Sender: TObject);
var
  v_form: TformPessoaCreateEdit;
begin
  TAuthService.PessoaId:= fdmt_pessoasID.AsString;
  try
    v_form:= TformPessoaCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.PessoaId <> EmptyStr) then
    list(Trim(lbe_pessoas_search.Text));
end;

procedure TformPessoaList.act_pessoa_storeExecute(Sender: TObject);
var
  v_form: TformPessoaCreateEdit;
begin
  TAuthService.PessoaId:= EmptyStr;
  try
    v_form:= TformPessoaCreateEdit.Create(nil);
    v_form.ShowModal;
  finally
    FreeAndNil(v_form);
  end;

  if (TAuthService.PessoaId <> EmptyStr) then
    list(Trim(lbe_pessoas_search.Text));
end;

procedure TformPessoaList.act_pessoa_destroyExecute(Sender: TObject);
begin
  if (TPessoa.remove(fdmt_pessoasID.AsString)) then
    fdmt_pessoas.Delete;
end;

procedure TformPessoaList.act_pessoa_exportExecute(Sender: TObject);
begin
  if not (Self.Tag = 1) then Exit();

  TAuthService.PessoaId:= fdmt_pessoasID.AsString;
  Close;
end;

procedure TformPessoaList.act_rollbackExecute(Sender: TObject);
begin
  TAuthService.PessoaId:= EmptyStr;
  Close;
end;

procedure TformPessoaList.dbg_pessoasDrawColumnCell(Sender: TObject;
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

procedure TformPessoaList.FormCreate(Sender: TObject);
begin
  inherited;
  dbg_pessoas.OnDblClick:= act_pessoa_exportExecute;
  list('');
end;

procedure TformPessoaList.lbe_pessoas_searchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: begin
      if (Trim(TCustomEdit(Sender).Text) <> EmptyStr) then
        list(Trim(TCustomEdit(Sender).Text));
    end;
    38: begin
      fdmt_pessoas.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_pessoas.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformPessoaList.list(search: string);
begin
  TPessoa.list(search,fdmt_pessoas);
end;

procedure TformPessoaList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_pessoas_search.Focused then lbe_pessoas_search.SetFocus
    else TTimer(Sender).Enabled:= False;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
