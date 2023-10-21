unit PruductionFactory;

interface

uses
  Classes, StdCtrls, ComCtrls, Dialogs, SyncObjs, Windows, SysUtils, Forms;

type
  TDeskPruductionFactory = class(TThread)
  private
    { Private declarations }
    FDeskOutputCount: ^Integer;
    FDesktopOutputCount: ^Integer;
    FLegsOutputCount: ^Integer;

    FThreadId: Integer;
    FTime: Integer;
    FMemo: TMemo;
  protected
    procedure Execute; override;
    procedure DoWork; virtual; abstract;
  public
    constructor Create(ProductionTime: Integer; Memo: TMemo;
      var DeskOutputCount: Integer; var DesktopOutputCount: Integer; var LegsOutputCount: Integer);
  end;

  //组装
  TThreadDeskAssembly = class(TDeskPruductionFactory)
  protected
    procedure DoWork; override;
  end;
  //桌面生产
  TThreadDesktopPruduction = class(TDeskPruductionFactory)
  protected
    procedure DoWork; override;
  end;
  //桌腿生产
  TThreadLegsPruduction = class(TDeskPruductionFactory)
  protected
    procedure DoWork; override;
  end;

implementation

var
  FactoryThreadLock: TRTLCriticalSection;

constructor TDeskPruductionFactory.Create(ProductionTime: Integer; Memo: TMemo;
  var DeskOutputCount: Integer; var DesktopOutputCount: Integer; var LegsOutputCount: Integer);
begin
  Ftime := ProductionTime;
  FMemo := Memo;

  FDeskOutputCount := @DeskOutputCount;
  FDesktopOutputCount := @DesktopOutputCount;
  FLegsOutputCount := @LegsOutputCount;

  inherited Create(True);
end;

procedure TDeskPruductionFactory.Execute;
begin
  while not Terminated do
  begin
    Sleep(Ftime);
    EnterCriticalSection(FactoryThreadLock);
    try
      FThreadId := Integer(GetCurrentThreadId);
      Synchronize(DoWork);
    finally
      LeaveCriticalSection(FactoryThreadLock);
    end;
  end;
end;

//桌面生产相关
procedure TThreadDesktopPruduction.DoWork;
begin
  FDesktopOutputCount^ := FDesktopOutputCount^ + 1;
  FMemo.Lines.Add('产线线程ID:  ' + IntToStr(FThreadId) + '   桌面x1    ' + ' 时间: '
    + FormatDateTime('mm-dd hh:nn:ss', Now));
end;

//桌腿生产相关
procedure TThreadLegsPruduction.DoWork;
begin
  FLegsOutputCount^ := FLegsOutputCount^ + 1;
  FMemo.Lines.Add('产线线程ID：' + IntToStr(FThreadId) + '   桌腿x1    ' + ' 时间: '
    + FormatDateTime('mm-dd hh:nn:ss', Now));
end;

//组装相关
procedure TThreadDeskAssembly.DoWork;
begin
  FDesktopOutputCount^ := FDesktopOutputCount^ - 1;
  FLegsOutputCount^ := FLegsOutputCount^ - 3;
  FDeskOutputCount^ := FDeskOutputCount^ + 1;

  FMemo.Lines.Add('产线线程ID：' + IntToStr(FThreadId) + '   办公桌x1   ' + '时间: '
    + FormatDateTime('mm-dd hh:nn:ss', Now));

  if (FDesktopOutputCount^ < 1) or (FLegsOutputCount^ < 3) then
  begin
    SuspendThread(Handle);
  end;
end;

initialization
  InitializeCriticalSection(FactoryThreadLock);

finalization
  DeleteCriticalSection(FactoryThreadLock);

end.