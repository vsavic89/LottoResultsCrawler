unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, Data.DB, DBAccess, MyAccess, MemDS, DADump,
  MyDump;

type
  TDataModule1 = class(TDataModule)
    MyConnection1: TMyConnection;
    MyStoredProc1: TMyStoredProc;
    MyDump1: TMyDump;
  private
    { Private declarations }
  public
    { Public declarations }
    function ConnectToDB(): string;
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TDataModule1.ConnectToDB : string;
var sl : TStringList;
begin
  Result := EmptyStr;
  if FileExists(ExtractFileDir(ParamStr(0))+'\settings.ini') then
  begin
    sl := TStringList.Create;
    try
      sl.LoadFromFile(ExtractFileDir(ParamStr(0))+'\settings.ini');
      DataModule1.MyConnection1.Close;
      DataModule1.MyConnection1.ConnectString := 'User ID='+copy(sl[2], pos('=', sl[2])+1, Length(sl[2]))+';Password='+copy(sl[3], pos('=', sl[3])+1, Length(sl[3]))+';Data Source='+copy(sl[0], pos('=', sl[0])+1, Length(sl[0]))+';Port='+copy(sl[1], pos('=', sl[1])+1, Length(sl[1]))+';Database=lottoresultscrawler;Login Prompt=False';
      try
        DataModule1.MyConnection1.Open;
      except on e:Exception do
        Result := e.Message;
      end;
    finally
      FreeAndNil(sl);
    end;
  end else Result := 'Can''t connect to db. File settings not found!';
end;

end.
