object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 228
  Width = 367
  object MyConnection1: TMyConnection
    Database = 'lottoresultscrawler'
    Username = 'root'
    Server = 'localhost'
    LoginPrompt = False
    Left = 23
    Top = 14
    EncryptedPassword = '8DFF90FF90FF8BFF'
  end
  object MyStoredProc1: TMyStoredProc
    Connection = MyConnection1
    Left = 24
    Top = 56
  end
end
