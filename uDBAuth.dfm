object frmDBAuth: TfrmDBAuth
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'DB Auth '
  ClientHeight = 165
  ClientWidth = 309
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 309
    Height = 165
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 16
      Width = 57
      Height = 13
      Caption = 'host name: '
    end
    object Label2: TLabel
      Left = 24
      Top = 45
      Width = 27
      Height = 13
      Caption = 'port: '
    end
    object Label3: TLabel
      Left = 24
      Top = 70
      Width = 54
      Height = 13
      Caption = 'username: '
    end
    object Label4: TLabel
      Left = 24
      Top = 97
      Width = 53
      Height = 13
      Caption = 'password: '
    end
    object edtHostName: TEdit
      Left = 87
      Top = 13
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'localhost'
    end
    object edtPort: TEdit
      Left = 87
      Top = 40
      Width = 66
      Height = 21
      TabOrder = 1
      Text = '3306'
    end
    object edtUsername: TEdit
      Left = 87
      Top = 67
      Width = 121
      Height = 21
      TabOrder = 2
      Text = 'root'
    end
    object edtPassword: TEdit
      Left = 87
      Top = 94
      Width = 121
      Height = 21
      PasswordChar = '*'
      TabOrder = 3
    end
    object btnOK: TButton
      Left = 87
      Top = 121
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 4
      OnClick = btnOKClick
    end
  end
end
