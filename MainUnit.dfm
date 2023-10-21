object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #21150#20844#26700#20135#32447' - Made By Liyao'
  ClientHeight = 469
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormCreate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object btnGetInfo: TButton
    Left = 8
    Top = 14
    Width = 193
    Height = 38
    Caption = #21047#26032#36827#24230
    TabOrder = 0
    OnClick = btnGetInfoClick
  end
  object btnPauseDesktops: TButton
    Left = 431
    Top = 14
    Width = 89
    Height = 38
    Caption = #26242#20572#26700#38754#29983#20135
    TabOrder = 1
    OnClick = btnPauseDesktopsClick
  end
  object btnResumeDesktops: TButton
    Left = 535
    Top = 14
    Width = 89
    Height = 38
    Caption = #32487#32493#26700#38754#29983#20135
    TabOrder = 2
    OnClick = btnResumeDesktopsClick
  end
  object btnPauseLegs: TButton
    Left = 216
    Top = 14
    Width = 89
    Height = 38
    Caption = #26242#20572#26700#33151#29983#20135
    TabOrder = 3
    OnClick = btnPauseLegsClick
  end
  object btnResumeLegs: TButton
    Left = 320
    Top = 14
    Width = 89
    Height = 38
    Caption = #32487#32493#26700#33151#29983#20135
    TabOrder = 4
    OnClick = btnResumeLegsClick
  end
  object btnConfirmAssemblySpeed: TButton
    Left = 103
    Top = 71
    Width = 98
    Height = 38
    Caption = #30830#35748#32452#35013#36895#24230
    TabOrder = 5
    OnClick = btnConfirmAssemblySpeedClick
  end
  object edtAssemblySpeed: TEdit
    Left = 8
    Top = 73
    Width = 89
    Height = 36
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    Text = '1000'
    TextHint = '1000'
  end
  object btnStartLegs: TButton
    Left = 216
    Top = 71
    Width = 193
    Height = 38
    Caption = #24320#22987#26700#33151#29983#20135
    TabOrder = 7
    OnClick = btnStartLegsClick
  end
  object btnStartDesktops: TButton
    Left = 431
    Top = 71
    Width = 193
    Height = 38
    Caption = #24320#22987#26700#38754#29983#20135
    TabOrder = 8
    OnClick = btnStartDesktopsClick
  end
  object mmoAssemblyLog: TMemo
    Left = 8
    Top = 296
    Width = 193
    Height = 161
    Lines.Strings = (
      'mmoAssemblyLog')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 9
  end
  object mmoDesktopProductionLog: TMemo
    Left = 431
    Top = 136
    Width = 193
    Height = 321
    Lines.Strings = (
      'mmoDesktopProductionLog')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 10
  end
  object mmoLegsProductionLog: TMemo
    Left = 216
    Top = 136
    Width = 193
    Height = 321
    Lines.Strings = (
      'mmoLegsProductionLog')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 11
  end
  object mmoMonitorStatus: TMemo
    Left = 8
    Top = 136
    Width = 193
    Height = 154
    ImeMode = imDisable
    Lines.Strings = (
      'mmoMonitorStatus')
    ParentShowHint = False
    ReadOnly = True
    ScrollBars = ssVertical
    ShowHint = False
    TabOrder = 12
  end
  object tmrProduction: TTimer
    OnTimer = tmrProductionCount
    Left = 896
    Top = 528
  end
end
