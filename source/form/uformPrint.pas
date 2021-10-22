unit uformPrint;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLPreviewForm, RLReport,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, RLFilters, RLHTMLFilter,
  RLXLSFilter, RLPDFFilter;

type
  TformPrint = class(TForm)
    RLPreviewSetup: TRLPreviewSetup;
    RLReport: TRLReport;
    rlb_header: TRLBand;
    RLHTMLFilter: TRLHTMLFilter;
    RLPDFFilter: TRLPDFFilter;
    RLXLSFilter: TRLXLSFilter;
    rlb_detail: TRLBand;
    rldb_text: TRLDBText;
    fdmt_data: TFDMemTable;
    fdmt_dataLINHA: TStringField;
    ds_data: TDataSource;
    rlb_footer: TRLBand;
    rlb_ffooter: TRLBand;
    rls_ffooter: TRLSystemInfo;
    rll_ffooter: TRLLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Print(Print: TStringList);
  end;

var
  formPrint: TformPrint;

implementation

uses
  Venda, Empresa, AuthService, Helper, System.StrUtils;

{$R *.dfm}

{ TformPrintVenda }

procedure TformPrint.Print(Print: TStringList);
var
  I: Integer;
  vLINE: string;
  vTOPH,
  vTOPF: Integer;
begin
  vTOPH:= 0;
  vTOPF:= 0;
  fdmt_data.Open();
  fdmt_data.DisableControls;
  fdmt_data.EmptyDataSet;
  for I := 0 to Pred(Print.Count) do
  begin
    vLINE:= Print[I];
    case AnsiIndexStr(THelper.DevolveConteudoDelimitado('|', vLINE), ['H', 'D','F']) of
      0: begin
        with TRLLabel.Create(rlb_header) do
        begin
          Parent:= rlb_header;
          ParentFont:= True;
          Alignment:= taLeftJustify;
          Caption:= vLINE;
          Align:= faNone;
          Left:= 0;
          Top:= vTOPH;
        end;
        vTOPH:= vTOPH + 19;
      end;
      1: begin
        fdmt_data.Append();
        fdmt_dataLINHA.AsString:= vLINE;
        fdmt_data.Post;
      end;
      2: begin
        with TRLLabel.Create(rlb_footer) do
        begin
          Parent:= rlb_footer;
          ParentFont:= True;
          Alignment:= taLeftJustify;
          Caption:= vLINE;
          Align:= faNone;
          Left:= 0;
          Top:= vTOPF;
        end;
        vTOPF:= vTOPF + 19;
      end;
    end;
  end;
  fdmt_data.First;
  fdmt_data.EnableControls;

  RLReport.Prepare;
  RLReport.Preview();
end;

end.
