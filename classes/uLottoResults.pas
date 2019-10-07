unit uLottoResults;

interface

uses VirtualTable;

type TLottoResults = class(tobject)
  private
  public
    constructor Create();
    procedure getLottoResults(var Avt: TVirtualTable);
    function insertLottoResult(AstrLottoName: string; AintDrawNumber: integer; AstrNumberSet1: string; AstrNumberSet2: string; AdtDate: tdatetime): string;
end;

implementation

uses uDataModule;

{ TLottoResults }

constructor TLottoResults.Create;
begin
  inherited Create;

end;

procedure TLottoResults.getLottoResults(var Avt: TVirtualTable);
begin
  with DataModule1 do
  begin
    MyStoredProc1.Close;
    MyStoredProc1.StoredProcName := 'getlottoresults';
    MyStoredProc1.Open;

    Avt.Close;
    Avt.Assign(MyStoredProc1);
    Avt.Open;
  end;
end;

function TLottoResults.insertLottoResult(AstrLottoName: string;
  AintDrawNumber: integer; AstrNumberSet1, AstrNumberSet2: string;
  AdtDate: tdatetime): string;
begin
  with DataModule1 do
  begin
    MyStoredProc1.Close;
    MyStoredProc1.StoredProcName := 'insertlottoresult';
    MyStoredProc1.PrepareSQL;
    MyStoredProc1.ParamByName('_name').Value := AstrLottoName;
    MyStoredProc1.ParamByName('_draw').Value := AintDrawNumber;
    MyStoredProc1.ParamByName('_numberset1').Value := AstrNumberSet1;
    MyStoredProc1.ParamByName('_numberset2').Value := AstrNumberSet2;
    MyStoredProc1.ParamByName('_date').Value := AdtDate;
    MyStoredProc1.ExecProc;
  end;
  result := DataModule1.MyStoredProc1.ParamByName('_msg').AsString;
end;

end.

