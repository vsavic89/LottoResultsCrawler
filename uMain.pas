unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  Vcl.ComCtrls, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, Data.DB, Vcl.Grids, Vcl.DBGrids, MemDS, DBAccess, MyAccess,
  uThreadLottoResultsCrawler, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  Vcl.Samples.Spin, VirtualTable;

type
  TfrmMain = class(TForm)
    DBGrid1: TDBGrid;
    StatusBar1: TStatusBar;
    pnlHours: TPanel;
    Label1: TLabel;
    seHours: TSpinEdit;
    Label2: TLabel;
    DataSource1: TDataSource;
    VirtualTable1: TVirtualTable;
    GroupBox1: TGroupBox;
    mmErrors: TMemo;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FthreadLottoResultsCrawler : TthreadLottoResultsCrawler;
    FstrStatusMessage: string;
    procedure SetStatusMessage(const Value: string);
  public
    { Public declarations }
    property StatusMessage : string read FstrStatusMessage write SetStatusMessage;
    procedure RefreshStatusMessage();
    procedure FillDataSet();
    procedure AppendMemo(AstrMessage: string);
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses uDataModule, uLottoResults;

procedure TfrmMain.AppendMemo(AstrMessage: string);
begin
  mmErrors.Lines.Add(AstrMessage);
end;

procedure TfrmMain.FillDataSet;
var lr: TLottoResults;
begin
  lr := TLottoResults.Create;
  try
    lr.getLottoResults(VirtualTable1);
  finally
    FreeAndNil(lr);
  end;
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  FillDataSet;
  FthreadLottoResultsCrawler := TthreadLottoResultsCrawler.Create(seHours.Value);
  FthreadLottoResultsCrawler.Start;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FthreadLottoResultsCrawler) then
  begin
    FthreadLottoResultsCrawler.Terminate;
    FthreadLottoResultsCrawler.WaitFor;
    FthreadLottoResultsCrawler.Free;
    FthreadLottoResultsCrawler := nil;
  end;

  Application.Terminate;
end;

procedure TfrmMain.RefreshStatusMessage;
begin
  StatusBar1.SimpleText := FstrStatusMessage;
  Application.ProcessMessages;
end;

procedure TfrmMain.SetStatusMessage(const Value: string);
begin
  FstrStatusMessage := Value;
end;

end.
