program LottoResultsCrawler;

{$R *.dres}

uses
  Vcl.Forms,
  System.SysUtils,
  dialogs,
  classes,
  windows,
  uMain in 'uMain.pas' {frmMain},
  uThreadLottoResultsCrawler in 'threads\uThreadLottoResultsCrawler.pas',
  uGlobal in 'global\uGlobal.pas',
  uDataModule in 'uDataModule.pas' {DataModule1: TDataModule},
  uLottoInfo in 'classes\uLottoInfo.pas',
  uLottoResults in 'classes\uLottoResults.pas',
  uDBAuth in 'uDBAuth.pas' {frmDBAuth};

{$R *.res}
var
  LstrExePath, LstrResponse: string;
  LGlobal: tglobal;
  ResStream: TResourceStream;
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  LstrExePath := ExtractFileDir(ParamStr(0));
  if not fileexists(LstrExePath+'\settings.ini') then
  begin
    LGlobal := TGlobal.Create;
    try
      if (LGlobal.IAmIn64Bits) then
      begin
        //copy 32bit dlls to C:\Windows\SysWOW64...
        if not FileExists('c:\windows\SysWOW64\ssleay32.dll') then
        begin
          ResStream := TResourceStream.Create(HInstance, 'ssleay32_32bit', RT_RCDATA);
          try
            ResStream.Position := 0;
            ResStream.SaveToFile('c:\windows\SysWOW64\ssleay32.dll');
          finally
            ResStream.Free;
          end;
        end;
        if not FileExists('c:\windows\SysWOW64\libeay32.dll') then
        begin
          ResStream := TResourceStream.Create(HInstance, 'libeay32_32bit', RT_RCDATA);
          try
            ResStream.Position := 0;
            ResStream.SaveToFile('c:\windows\SysWOW64\libeay32.dll');
          finally
            ResStream.Free;
          end;
        end;
        //copy 64bit dlls to C:\Windows\System32...
        if not FileExists('c:\windows\System32\ssleay32.dll') then
        begin
          ResStream := TResourceStream.Create(HInstance, 'ssleay32_64bit', RT_RCDATA);
          try
            ResStream.Position := 0;
            ResStream.SaveToFile('c:\windows\System32\ssleay32.dll');
          finally
            ResStream.Free;
          end;
        end;
        if not FileExists('c:\windows\System32\libeay32.dll') then
        begin
          ResStream := TResourceStream.Create(HInstance, 'libeay32_64bit', RT_RCDATA);
          try
            ResStream.Position := 0;
            ResStream.SaveToFile('c:\windows\System32\libeay32.dll');
          finally
            ResStream.Free;
          end;
        end;
      end else begin
        //copy 32bit dlls to C:\Windows\System32...
        if not FileExists('c:\windows\System32\ssleay32.dll') then
        begin
          ResStream := TResourceStream.Create(HInstance, 'ssleay32_32bit', RT_RCDATA);
          try
            ResStream.Position := 0;
            ResStream.SaveToFile('c:\windows\System32\ssleay32.dll');
          finally
            ResStream.Free;
          end;
        end;
        if not FileExists('c:\windows\System32\libeay32.dll') then
        begin
          ResStream := TResourceStream.Create(HInstance, 'libeay32_32bit', RT_RCDATA);
          try
            ResStream.Position := 0;
            ResStream.SaveToFile('c:\windows\System32\libeay32.dll');
          finally
            ResStream.Free;
          end;
        end;
      end;
    finally
      FreeAndNil(LGlobal);
    end;
    Application.CreateForm(TfrmDBAuth, frmDBAuth);
    Application.CreateForm(TDataModule1, DataModule1);
    Application.CreateForm(TfrmMain, frmMain);
    Application.Run;
  end
  else
  begin
    Application.CreateForm(TDataModule1, DataModule1);
    LstrResponse := DataModule1.ConnectToDB;
    if LstrResponse = EmptyStr then
    begin
      Application.CreateForm(TfrmMain, frmMain);
      Application.Run;
    end else begin
      ShowMessage(LstrResponse);
      Application.Terminate;
    end;
  end;
end.
