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

  //��װ
  TThreadDeskAssembly = class(TDeskPruductionFactory)
  protected
    procedure DoWork; override;
  end;
  //��������
  TThreadDesktopPruduction = class(TDeskPruductionFactory)
  protected
    procedure DoWork; override;
  end;
  //��������
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

//�����������
procedure TThreadDesktopPruduction.DoWork;
begin
  FDesktopOutputCount^ := FDesktopOutputCount^ + 1;
  FMemo.Lines.Add('�����߳�ID:  ' + IntToStr(FThreadId) + '   ����x1    ' + ' ʱ��: '
    + FormatDateTime('mm-dd hh:nn:ss', Now));
end;

//�����������
procedure TThreadLegsPruduction.DoWork;
begin
  FLegsOutputCount^ := FLegsOutputCount^ + 1;
  FMemo.Lines.Add('�����߳�ID��' + IntToStr(FThreadId) + '   ����x1    ' + ' ʱ��: '
    + FormatDateTime('mm-dd hh:nn:ss', Now));
end;

//��װ���
procedure TThreadDeskAssembly.DoWork;
begin
  FDesktopOutputCount^ := FDesktopOutputCount^ - 1;
  FLegsOutputCount^ := FLegsOutputCount^ - 3;
  FDeskOutputCount^ := FDeskOutputCount^ + 1;

  FMemo.Lines.Add('�����߳�ID��' + IntToStr(FThreadId) + '   �칫��x1   ' + 'ʱ��: '
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