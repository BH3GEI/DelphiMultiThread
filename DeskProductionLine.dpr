program DeskProductionLine;

uses
  Forms,
  PruductionFactory in 'PruductionFactory.pas',
  MainUnit in 'MainUnit.pas' {Form1};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
