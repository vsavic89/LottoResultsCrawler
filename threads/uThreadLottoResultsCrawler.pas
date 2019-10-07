unit uThreadLottoResultsCrawler;

interface

uses
  System.Classes;

type
  TthreadLottoResultsCrawler = class(TThread)
  private
    { Private declarations }
    FintHours, FintSecondsElapsed, FintTotalSeconds: Integer;
  protected
    procedure Execute; override;
 private
    const URL = 'https://www.ozlotteries.com/lotto-results';
    procedure GetLottoResults();
    procedure SetHours(const Value: integer);
  public
    constructor Create(AintHours: integer);
  end;

implementation

uses
  sysutils, Vcl.OleCtrls, Vcl.StdCtrls, System.Variants,
  Winapi.Windows, MSHTML, ActiveX, System.DateUtils,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  Vcl.ComCtrls, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, uglobal, umain, ulottoresults;

{ TthreadLottoResultsCrawler }

constructor TthreadLottoResultsCrawler.Create(AintHours: integer);
begin
  inherited Create(True);
  SetHours(AintHours);
end;

procedure TthreadLottoResultsCrawler.Execute;
var LintHours: integer;
begin
  CoInitialize(nil);
  try
    while not Terminated do
    begin
      LintHours := frmMain.seHours.Value;
      if (LintHours > 0) and (LintHours <> FintHours)
      then
      begin
        SetHours(LintHours);
        waitforSingleObject(Handle, 1000);
        Inc(FintSecondsElapsed);
      end;
      if FintSecondsElapsed <= FintTotalSeconds then
      begin
        if FintSecondsElapsed = 0 then
        begin
          frmMain.StatusMessage := 'Getting results...';
          Synchronize(
            procedure
            begin
              frmMain.RefreshStatusMessage;
            end
          );
          frmMain.mmErrors.Lines.Clear;
          GetLottoResults();
          frmMain.FillDataSet;
        end;
        waitforSingleObject(Handle, 1000);
        Inc(FintSecondsElapsed);
        frmMain.StatusMessage := 'Waiting...' + inttostr(FintTotalSeconds-FintSecondsElapsed) + ' second/s.';
        Synchronize(
            procedure
            begin
               frmMain.RefreshStatusMessage()
            end

          );

      end else begin
        FintSecondsElapsed := 0;
      end;
    end;
  finally
    CoUninitialize;
  end;
end;

procedure TthreadLottoResultsCrawler.GetLottoResults();
var
  doc:IHTMLDocument2;
  body: IHTMLElement2;
  element: IHTMLElement2;
  tagContainerE, tagLottoNameE, LDivE, LDiv3e, LDiv5e, LTagE: IHTMLElement;
  el:OleVariant;
  i:integer;
  v,v1,v2, vContent, vContext, vHTML: olevariant;
  cache: string;
  sl: TStringList;
  TagsC, tagsContainerC, divsc, LDiv1c, LDiv2c, LDiv4c, LDiv5c, LTagsC, LTagsC1: IHTMLElementCollection;
  ms: TMemoryStream;
  slMS: TStringList;
  s: string;
  j: Integer;
  LstrLottoName: string;
  k,l: Integer;
  o: Integer;
  p: Integer;
  LstrDate: string;
  LstrDrawNumber: string;
  LstrMonth: string;
  ss: TStrings;
  LdtDate: tdatetime;
  LintDrawNumber: Integer;
  q: Integer;
  LTagsC2: IHTMLElementCollection;
  r: Integer;
  LstrNS1: string;
  LstrNS2: string;
  IdHTTP1: TIdHTTP;
  LGlobal: TGlobal;
  IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
  lr: tlottoresults;
  LstrMessage: string;
begin
    ms := TMemoryStream.Create;
    slMS := TStringList.Create;
    IdHTTP1 := TIdHTTP.Create(nil);
    IdSSLIOHandlerSocketOpenSSL1 := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    try
      IdHTTP1.IOHandler := IdSSLIOHandlerSocketOpenSSL1;
      IdSSLIOHandlerSocketOpenSSL1.SSLOptions.Method := sslvSSLv23;
      IdSSLIOHandlerSocketOpenSSL1.SSLOptions.Mode := sslmUnassigned;
      ms.Position := 0;
      IdHTTP1.Get(URL, ms);
      ms.Position := 0;
      slMS.LoadFromStream(ms);
      s:=slms.Text;
    finally
      FreeAndNil(IdSSLIOHandlerSocketOpenSSL1);
      FreeAndNil(IdHTTP1);
      FreeAndNil(ms);
      FreeAndNil(slMS);
    end;

    Doc := coHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance

    doc.designMode := 'On';

    vContext := VarArrayCreate([0, 0], varVariant);

    vContext[0] := s;

    doc.Write(PSafeArray(TVarData(vContext).VArray)); //use ActiveX

    doc.Close;

    lr := TLottoResults.Create;
    try
      if not Supports(doc.body, IHTMLElement2, Body) then
        raise Exception.Create('Can''t find <body> element');
      TagsC := body.getElementsByTagName('div');
      for I := 0 to Pred(TagsC.length) do
      begin
        TagContainerE := TagsC.item(I, EmptyParam) as IHTMLElement;
        if (tagContainerE.tagName = 'DIV') and (AnsiPos('e1iv5k4l0', TagContainerE._className)>0)  then  //results container... (css-7gdf5m e1iv5k4l0)
        begin
            divsC := tagContainerE.children as IHTMLElementCollection;
            for j := 0 to Pred(divsC.length) do
            begin
              LdivE := divsC.item(j, EmptyParam) as IHTMLElement;
              if (LDivE.tagName = 'DIV') and (ansipos('e1iv5k4l1', LDivE._className)>0) then    //lotto name... (css-89joz8 e1iv5k4l1)
              begin
                LDiv1C := LDivE.children as IHTMLElementCollection;
                for k := 0 to Pred(LDiv1C.length) do
                begin
                  LDivE := ldiv1C.item(k, EmptyParam) as IHTMLElement;
                  if ansipos('is-', LDivE._className) > 0 then
                    LstrLottoName := Copy(LDivE._className, 4, Pos(' ', LDivE._className) - 4);
                end;
              end else if (LDivE.tagName = 'DIV') and (ansipos('e1iv5k4l2', LDivE._className)>0) then  //lotto results... (css-6zozyn e1iv5k4l2)
              begin
                LDiv1C := LDivE.children as IHTMLElementCollection;
                for k := 0 to Pred(LDiv1C.length) do
                begin
                  LDivE := ldiv1C.item(k, EmptyParam) as IHTMLElement;
                  if (LDivE.tagName = 'DIV') and (ansipos('e1iv5k4l3', LDivE._className)>0) then //'css-1lwvz2g e1iv5k4l3'
                  begin
                    LDiv2C := LDivE.children as IHTMLElementCollection;
                    for l := 0 to Pred(LDiv2C.length) do
                    begin
                      LDiv3e := ldiv2C.item(l, EmptyParam) as IHTMLElement;
                      if (LDiv3e.tagName = 'DIV') and (AnsiPos('e1iv5k4l4', LDiv3e._className)>0) then //'css-6nufti e1iv5k4l4'
                      begin
                        Ldiv4C := LDiv3e.children as IHTMLElementCollection;
                        LDiv5e := ldiv4c.item(0, EmptyParam) as IHTMLElement;
                        LDiv5C := ldiv5e.children as IHTMLElementCollection;
                        for o := 0 to Pred(LDiv5c.length) do
                        begin
                          LTagE := ldiv5c.item(o, EmptyParam) as IHTMLElement;
                          if LTagE.tagName = 'H4' then
                          begin
                            LstrDate := Copy(LTagE.innerText, 1, ansiPos('Draw', LTagE.innerText)-1);
                            LintDrawNumber := StrToInt(Copy(LTagE.innerText, ansiPos('Draw', LTagE.innerText) + 5, length(LTagE.innerText)));
                            ss := TStringList.Create;
                            LGlobal := TGlobal.Create;
                            try
                              ExtractStrings([' '], [], pchar(lstrdate), ss);
                              LdtDate := EncodeDate(strtoint(ss[2]), (LGlobal.GetMonthNumber(ss[1])), strtoint(ss[0]));
                            finally
                              FreeAndNil(ss);
                              FreeAndNil(LGlobal);
                            end;
                          end else if (LTagE.tagName = 'DIV') and (ansipos('e1l90eyg1', LTagE._className)>0) then //'css-c7lkui e1l90eyg1'
                          begin
                             LTagsC := ltage.children as IHTMLElementCollection;
                             for p := 0 to Pred(LTagsC.length) do
                             begin
                               LTagE := ltagsC.item(p, EmptyParam) as IHTMLElement;
                               if (LTagE.tagName = 'DIV') and (ansipos('e1l90eyg2', LTagE._className)>0) then //'css-1ff4wwl e1l90eyg2'
                               begin
                                 LTagsC1 := ltage.children as IHTMLElementCollection;
                                 LstrNS1 := EmptyStr;
                                 LstrNS2 := EmptyStr;
                                 for q := 0 to Pred(LTagsC1.length) do
                                 begin
                                   LTagE := ltagsc1.item(q, EmptyParam) as ihtmlelement;
                                   if(LTagE.tagName = 'DIV') and (ansipos('e1lkqx200', LTagE._className)>0) then
                                   begin
                                       LTagsC2 := ltage.children as IHTMLElementCollection;
                                       for r := 0 to Pred(LTagsC2.length) do
                                       begin
                                         LTagE := ltagsc2.item(r, EmptyParam) as ihtmlelement;
                                         if(LTagE.tagName = 'DIV') and
                                          (AnsiPos('results-number-set__number--ns1', LTagE._className)>0) // '_17bdnfnm _2PcuSnGf results-number-set__number--ns1'
                                          //1st number set...
                                         then
                                         begin
                                           if LstrNS1 = EmptyStr then
                                            LstrNS1 := LTagE.innerText
                                           else
                                            LstrNS1 := LstrNS1 + ', ' + LTagE.innerText;
                                         end else if(LTagE.tagName = 'DIV') and
                                          (AnsiPos('results-number-set__number--ns2', LTagE._className)>0) //'_17bdnfnm _2PcuSnGf _2uPwrDMR results-number-set__number--ns2'
                                          //2nd number set...
                                         then
                                         begin
                                           if LstrNS2 = EmptyStr then
                                            LstrNS2 := LTagE.innerText
                                           else
                                            LstrNS2 := LstrNS2 + ', ' + LTagE.innerText;
                                         end
                                       end;
                                   end;
                                 end;
                                 LstrMessage := (lr.insertLottoResult(LstrLottoName, LintDrawNumber, LstrNS1, LstrNS2, LdtDate));
                                 if LstrMessage <> ''  then
                                 begin
                                   frmMain.AppendMemo(LstrMessage);
                                 end;
                               end;
                             end;
                          end;
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
        end;
      end;
    finally
      FreeAndNil(lr);
    end;
end;

procedure TthreadLottoResultsCrawler.SetHours(const Value: integer);
begin
  FintHours := Value;
  FintTotalSeconds := FintHours * 60 * 60;
  FintSecondsElapsed := 0;
end;

end.
