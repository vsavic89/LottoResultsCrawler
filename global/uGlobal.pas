unit uGlobal;

interface

type TGlobal = class
  private
  public
    function GetMonthNumber(AstrMonthName: string):Integer;
end;

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

end.
