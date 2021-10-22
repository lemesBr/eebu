unit uformCategoriaCreateEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Categoria, System.Actions, Vcl.ActnList;

type
  TformCategoriaCreateEdit = class(TformBase)
    pnl_body: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_save: TButton;
    pnl_main: TPanel;
    btn_cancel: TButton;
    lbe_categoria: TLabeledEdit;
    lbe_nome: TLabeledEdit;
    act_categoria: TActionList;
    act_cancel: TAction;
    act_save: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure act_cancelExecute(Sender: TObject);
    procedure act_saveExecute(Sender: TObject);
    procedure lbe_categoriaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    Categoria: TCategoria;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();
  public
    { Public declarations }
  end;

var
  formCategoriaCreateEdit: TformCategoriaCreateEdit;

implementation

uses
  AuthService, udmRepository, uformCategoriaList, Helper;

{$R *.dfm}

procedure TformCategoriaCreateEdit.act_cancelExecute(Sender: TObject);
begin
  TAuthService.CategoriaId:= EmptyStr;
  Close;
end;

procedure TformCategoriaCreateEdit.act_saveExecute(Sender: TObject);
begin
  save();
end;

procedure TformCategoriaCreateEdit.EdtToObj;
begin
  Categoria.Nome:= lbe_nome.Text;
end;

procedure TformCategoriaCreateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  if (TAuthService.CategoriaId = EmptyStr) then
  begin
    Categoria:= TCategoria.Create;
    Categoria.Tipo:= TAuthService.TipoCategoria;
  end
  else Categoria:= TCategoria.find(TAuthService.CategoriaId);
  ObjToEdt;
end;

procedure TformCategoriaCreateEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Categoria);
end;

procedure TformCategoriaCreateEdit.lbe_categoriaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  v_form: TformCategoriaList;
begin
  if (Key = 112) then
  begin
    TAuthService.CategoriaId:= EmptyStr;
    try
      v_form:= TformCategoriaList.Create(nil);
      v_form.Tag:= 1;
      v_form.ShowModal;
    finally
      FreeAndNil(v_form);
    end;

    if (TAuthService.CategoriaId <> EmptyStr) then
    begin
      Categoria.CategoriaId:= TAuthService.CategoriaId;
      lbe_categoria.Text:= Categoria.Categoria.Nome;
    end;
  end;
end;

procedure TformCategoriaCreateEdit.ObjToEdt;
begin
  if Categoria.Id = EmptyStr then
  begin
    if Categoria.Tipo = 'R' then
      pnl_header.Caption:= 'NOVA CATEGORIA DE RECEITA'
    else
      pnl_header.Caption:= 'NOVA CATEGORIA DE DESPESA';
    Exit;
  end
  else
  begin
    if Categoria.Tipo = 'R' then
      pnl_header.Caption:= 'EDITAR CATEGORIA DE RECEITA'
    else
      pnl_header.Caption:= 'EDITAR CATEGORIA DE DESPESA';
  end;

  TAuthService.TipoCategoria:= Categoria.Tipo;
  if Assigned(Categoria.Categoria) then
    lbe_categoria.Text:= Categoria.Categoria.Nome;
  lbe_nome.Text:= Categoria.Nome;
end;

procedure TformCategoriaCreateEdit.save;
begin
  EdtToObj;
  try
    if THelper.ValidaCamposObrigatorios(pnl_main) then
    begin
      if Categoria.save then
      begin
        TAuthService.CategoriaId:= Categoria.Id;
        Close;
      end;
    end;
  except on e: Exception do
    THelper.Mensagem(e.Message);
  end;
end;

end.
