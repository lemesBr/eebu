unit udmRepository;

interface

uses
  System.SysUtils, System.Classes, Vcl.ImgList, Vcl.Controls;

type
  TdmRepository = class(TDataModule)
    iml_32: TImageList;
    iml_16: TImageList;
    iml_principal_16: TImageList;
    iml_principal_32: TImageList;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmRepository: TdmRepository;

implementation

uses
  Vcl.Forms, Winapi.Windows;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmRepository.DataModuleCreate(Sender: TObject);
var
  vFonte: Boolean;
begin
  with Screen.Fonts do
    vFonte:= IndexOf(Trim('Bombardier')) > -1;

  if not vFonte then
    AddFontResource(PChar(GetCurrentDir + '\BOMBARD_.ttf'));
end;

end.
