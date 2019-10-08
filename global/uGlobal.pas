unit uGlobal;

interface

uses Windows, sysutils;

type TGlobal = class
  private
  public
    function GetMonthNumber(AstrMonthName: string):Integer;
    function IAmIn64Bits(): Boolean;
end;

  type
    WinIsWow64 = function( Handle: THandle; var Iret: BOOL ): Windows.BOOL; stdcall;

implementation

{ TGlobal }

function TGlobal.GetMonthNumber(AstrMonthName: string): Integer;
begin
  if AstrMonthName = 'January' then
    Result := 1
  else if AstrMonthName = 'February' then
    Result := 2
  else if AstrMonthName = 'March' then
    result := 3
  else if AstrMonthName = 'April' then
    result := 4
  else if AstrMonthName = 'May' then
    result := 5
  else if AstrMonthName = 'June' then
    result := 6
  else if AstrMonthName = 'July' then
    result := 7
  else if AstrMonthName = 'August' then
    result := 8
  else if AstrMonthName = 'September' then
    result := 9
  else if AstrMonthName = 'October' then
    result := 10
  else if AstrMonthName = 'November' then
    result := 11
  else if AstrMonthName = 'December' then
    result := 12
  else Result := 0;
end;


function TGlobal.IAmIn64Bits: Boolean;
var
  HandleTo64BitsProcess: WinIsWow64;
  Iret                 : Windows.BOOL;
begin
  Result := False;
  HandleTo64BitsProcess := GetProcAddress(GetModuleHandle('kernel32.dll'), 'IsWow64Process');
  if Assigned(HandleTo64BitsProcess) then
  begin
    if not HandleTo64BitsProcess(GetCurrentProcess, Iret) then
    Raise Exception.Create('Invalid handle');
    Result := Iret;
  end;
end;

end.
