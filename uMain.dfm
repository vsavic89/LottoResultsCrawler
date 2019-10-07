object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'LottoResultsCrawler'
  ClientHeight = 577
  ClientWidth = 767
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 767
    Height = 287
    Align = alClient
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'name'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'draw'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'date'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'numberset1'
        Title.Caption = 'number set 1'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'numberset2'
        Title.Caption = 'number set 2'
        Width = 80
        Visible = True
      end>
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 558
    Width = 767
    Height = 19
    Panels = <>
    SimplePanel = True
    ExplicitLeft = 8
    ExplicitTop = 468
    ExplicitWidth = 706
  end
  object pnlHours: TPanel
    Left = 0
    Top = 0
    Width = 767
    Height = 41
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    ExplicitTop = -6
    object Label1: TLabel
      Left = 8
      Top = 12
      Width = 154
      Height = 16
      Caption = 'Refresh results every...'
    end
    object Label2: TLabel
      Left = 231
      Top = 12
      Width = 45
      Height = 16
      Caption = 'hour/s'
    end
    object seHours: TSpinEdit
      Left = 168
      Top = 9
      Width = 57
      Height = 26
      MaxValue = 24
      MinValue = 1
      TabOrder = 0
      Value = 1
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 328
    Width = 767
    Height = 230
    Align = alBottom
    Caption = 'Errors'
    TabOrder = 3
    object mmErrors: TMemo
      Left = 2
      Top = 15
      Width = 763
      Height = 213
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 72
      ExplicitTop = 40
      ExplicitWidth = 185
      ExplicitHeight = 89
    end
  end
  object DataSource1: TDataSource
    DataSet = VirtualTable1
    Left = 376
    Top = 216
  end
  object VirtualTable1: TVirtualTable
    Left = 432
    Top = 224
    Data = {04000000000000000000}
  end
end
