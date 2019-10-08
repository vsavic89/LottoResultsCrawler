unit uDBAuth;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmDBAuth = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtHostName: TEdit;
    edtPort: TEdit;
    edtUsername: TEdit;
    edtPassword: TEdit;
    btnOK: TButton;
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDBAuth: TfrmDBAuth;

implementation

{$R *.dfm}

uses uDataModule, uMain;

procedure TfrmDBAuth.btnOKClick(Sender: TObject);
var sl:TStringList;
    ResStream: TResourceStream;
  LstrResponse: string;
begin

  DataModule1.MyConnection1.Close;
  DataModule1.MyConnection1.ConnectString := 'User ID='+edtUsername.Text+';Password='+edtPassword.Text+';Data Source='+edtHostName.Text+';Port='+edtPort.Text+';Login Prompt=False';
  try
    DataModule1.MyConnection1.Open;
    sl := TStringList.Create;
    try
      sl.Add('host='+edtHostName.Text);
      sl.Add('port='+edtPort.Text);
      sl.Add('username='+edtUsername.Text);
      sl.Add('password='+edtPassword.Text);
      sl.SaveToFile(ExtractFileDir(ParamStr(0))+'\settings.ini');
    finally
      FreeAndNil(sl);
    end;

    hide;
    ResStream := TResourceStream.Create(HInstance, 'dump', RT_RCDATA);
    try
      ResStream.Position := 0;
      DataModule1.MyDump1.RestoreFromStream(ResStream);
      LstrResponse := DataModule1.ConnectToDB;
      if LstrResponse = EmptyStr then
        frmMain.Show
      else
        ShowMessage(LstrResponse);
    finally
      ResStream.Free;
    end;

  except on e:Exception do
    ShowMessage('Parameters are not valid!'+sLineBreak+'Error message: ' + e.Message);
  end;
end;

procedure TfrmDBAuth.FormShow(Sender: TObject);
begin
  edtPassword.SetFocus;
end;

end.
