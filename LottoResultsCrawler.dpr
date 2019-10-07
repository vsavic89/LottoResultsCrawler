program LottoResultsCrawler;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  uThreadLottoResultsCrawler in 'threads\uThreadLottoResultsCrawler.pas',
  uGlobal in 'global\uGlobal.pas',
  uDataModule in 'uDataModule.pas' {DataModule1: TDataModule},
  uLottoInfo in 'classes\uLottoInfo.pas',
  uLottoResults in 'classes\uLottoResults.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
