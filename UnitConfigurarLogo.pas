unit UnitConfigurarLogo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.Buttons, ShellAPI;

type
  TfrmConfigurarLogo = class(TForm)
    btnPreencher: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    Label8: TLabel;
    txtLogo: TDBEdit;
    procedure btnPreencherClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfigurarLogo: TfrmConfigurarLogo;

implementation

{$R *.dfm}

uses UnitDM, UnitMenu;

procedure TfrmConfigurarLogo.btnCancelarClick(Sender: TObject);
begin
  DM.qrDadosEmp.Cancel;
  btnSalvar.Enabled := False;
  btnCancelar.Enabled := False;
  btnPreencher.Enabled := True;
  ActiveControl := nil;

  txtLogo.ReadOnly := True;
end;

procedure TfrmConfigurarLogo.btnPreencherClick(Sender: TObject);
begin
  DM.qrDadosEmp.Edit;
  btnPreencher.Enabled := False;
  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;
  txtLogo.SetFocus;

  txtLogo.ReadOnly := False;
end;

procedure TfrmConfigurarLogo.btnSalvarClick(Sender: TObject);
begin
  DM.qrDadosEmp.Post;
  DM.qrDadosEmp.Open;
  btnSalvar.Enabled := False;
  btnCancelar.Enabled := False;
  btnPreencher.Enabled := True;
  ActiveControl := nil;

  Application.MessageBox('Dados Salvos Com Sucesso!', 'Olá', MB_ICONINFORMATION+MB_OK);

  logo := DM.qrDadosEmp.FieldByName('logo').AsString;

  txtLogo.ReadOnly := True;
end;

function ExecExplorer(OpenAtPath: string;
  OpenWithExplorer, OpenAsRoot: Boolean): Boolean;
var
  s : string;
begin
  if OpenWithExplorer then
  begin
    if OpenAsRoot then
      s := ' /e,/root,"' + OpenAtPath + '"'
    else
      s := ' /e,"' + OpenAtPath + '"';
  end
  else
    s := '"' + OpenAtPath + '"';

  Result := ShellExecute(Application.Handle, PChar('open'), PChar('explorer.exe'), PChar(s), nil, SW_NORMAL) > 32;
end;

procedure TfrmConfigurarLogo.Button1Click(Sender: TObject);
begin
  if (ExecExplorer('D:\Sistemas\', True, True)) then
  begin

  end
  else
  begin
    ShowMessage('Erro ao abrir o explorer!');
  end;
end;

procedure TfrmConfigurarLogo.FormActivate(Sender: TObject);
begin
  ActiveControl := nil;
end;

end.
