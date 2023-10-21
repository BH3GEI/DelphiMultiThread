unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StrUtils, RzPanel, ExtCtrls, PruductionFactory;

type
   TForm1= class(TForm)

    tmrProduction: TTimer;

    btnGetInfo: TButton;
    btnConfirmAssemblySpeed: TButton;

    btnPauseDesktops: TButton;
    btnResumeDesktops: TButton;
    btnStartDesktops: TButton;

    btnPauseLegs: TButton;
    btnStartLegs: TButton;
    btnResumeLegs: TButton;

    edtAssemblySpeed: TEdit;
    mmoAssemblyLog: TMemo;
    mmoDesktopProductionLog: TMemo;
    mmoLegsProductionLog: TMemo;
    mmoMonitorStatus: TMemo;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure btnStartDesktopsClick(Sender: TObject);
    procedure btnPauseDesktopsClick(Sender: TObject);
    procedure btnResumeDesktopsClick(Sender: TObject);

    procedure btnStartLegsClick(Sender: TObject);
    procedure btnPauseLegsClick(Sender: TObject);
    procedure btnResumeLegsClick(Sender: TObject);

    procedure tmrProductionCount(Sender: TObject);
    procedure btnGetInfoClick(Sender: TObject);
    procedure btnConfirmAssemblySpeedClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  threadDesktopsProduction: TDeskPruductionFactory;
  threadLegsProduction: TDeskPruductionFactory;
  threadAssembly: TDeskPruductionFactory;
  
  DesktopOutputCount: Integer;
  LegsOutputCount: Integer;
  DeskOutputCount: Integer;


implementation
{$R *.dfm}

procedure TForm1.btnStartDesktopsClick(Sender: TObject);
begin
  tmrProduction.Enabled := True;
  btnStartDesktops.Enabled := False;
  threadDesktopsProduction := TThreadDesktopPruduction.Create(200, mmoDesktopProductionLog,DeskOutputCount, DesktopOutputCount, LegsOutputCount);
  ResumeThread(threadDesktopsProduction.Handle);
end;
procedure TForm1.btnPauseDesktopsClick(Sender: TObject);
begin
  if Assigned(threadDesktopsProduction) then
  begin
    SuspendThread(threadDesktopsProduction.Handle);
  end
  else
  begin
    ShowMessage('请先启动桌面生产线程');
  end;
end;

procedure TForm1.btnResumeDesktopsClick(Sender: TObject);
begin
  if Assigned(threadDesktopsProduction) then
  begin
    ResumeThread(threadDesktopsProduction.Handle);
  end
  else
  begin
    ShowMessage('请先启动桌面生产线程');
  end;
end;

procedure TForm1.btnStartLegsClick(Sender: TObject);
begin
  tmrProduction.Enabled := True;
  btnStartLegs.Enabled := False;
  threadLegsProduction := TThreadLegsPruduction.Create(100, mmoLegsProductionLog, DeskOutputCount,DesktopOutputCount, LegsOutputCount);
  ResumeThread(threadLegsProduction.Handle);
end;

procedure TForm1.btnPauseLegsClick(Sender: TObject);
begin
  if Assigned(threadLegsProduction) then
  begin
    SuspendThread(threadLegsProduction.Handle);
  end
  else
  begin
    ShowMessage('请先启动桌腿生产线程');
  end;
end;

procedure TForm1.btnResumeLegsClick(Sender: TObject);
begin
  if Assigned(threadLegsProduction) then
  begin
    ResumeThread(threadLegsProduction.Handle);
  end
  else
  begin
    ShowMessage('请先启动桌腿生产线程');
  end;
end;

procedure TForm1.tmrProductionCount(Sender: TObject);
begin
  if (DesktopOutputCount >= 1) and (LegsOutputCount >= 3) then
  begin
    if threadAssembly = nil then
    begin
	  edtAssemblySpeed.Enabled := False;
      threadAssembly := TThreadDeskAssembly.Create(StrToInt(edtAssemblySpeed.Text), mmoAssemblyLog,
          DeskOutputCount, DesktopOutputCount, LegsOutputCount);
      ResumeThread(threadAssembly.Handle);
    end
    else
    begin
      ResumeThread(threadAssembly.Handle);
    end;
  end;
end;

procedure TForm1.btnGetInfoClick(Sender: TObject);
var
  DeskTopTime: string;
  DeskLegTime: string;
begin
  mmoMonitorStatus.Clear;
  DeskTopTime := RightStr(mmoDesktopProductionLog.Lines[mmoDesktopProductionLog.Lines.Count - 1],13);
  DeskLegTime := RightStr(mmoLegsProductionLog.Lines[mmoLegsProductionLog.Lines.Count - 1],13);
  mmoMonitorStatus.Lines.Add('剩余成品桌面数量:  ' + IntToStr(DesktopOutputCount));
  mmoMonitorStatus.Lines.Add('最新桌面出厂时间:                     ' + DeskTopTime);
  mmoMonitorStatus.Lines.Add('剩余成品桌腿数量:  ' + IntToStr(LegsOutputCount));
  mmoMonitorStatus.Lines.Add('最新桌腿出厂时间:                     ' + DeskLegTime);
  mmoMonitorStatus.Lines.Add('办公桌成品数量:  ' + IntToStr(DeskOutputCount));
end;

procedure TForm1.btnConfirmAssemblySpeedClick(Sender: TObject);
var
  assemblySpeed: Integer;
begin
  if TryStrToInt(edtAssemblySpeed.Text, assemblySpeed) and (assemblySpeed >= 1) and (assemblySpeed <= 1000) then
  begin
    tmrProduction.Enabled := True;
  end
  else
  begin
    ShowMessage('非法输入，请输入1-1000之间的值');
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  tmrProduction.Enabled := False;
  mmoMonitorStatus.Clear;
  mmoLegsProductionLog.Clear;
  mmoDesktopProductionLog.Clear;
  mmoAssemblyLog.Clear;
  DesktopOutputCount := 0;
  LegsOutputCount := 0;
  DeskOutputCount := 0;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tmrProduction.Enabled := False;
  if Assigned(threadDesktopsProduction) then
  begin
    threadDesktopsProduction.Terminate;
    FreeAndNil(threadDesktopsProduction);
  end;
  if Assigned(threadLegsProduction) then
  begin
    threadLegsProduction.Terminate;
    FreeAndNil(threadLegsProduction);
  end;
  if Assigned(threadAssembly) then
  begin
    threadAssembly.Terminate;
    FreeAndNil(threadAssembly);
  end;
end;
end.
