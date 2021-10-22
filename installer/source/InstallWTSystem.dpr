program InstallWTSystem;





{$R *.dres}

uses
  Vcl.Forms,
  ufrmPrincipal in 'form\ufrmPrincipal.pas' {frmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Instalador do WT - SYSTEM';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
