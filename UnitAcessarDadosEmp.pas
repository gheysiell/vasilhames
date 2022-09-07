unit UnitAcessarDadosEmp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls;

type
  TfrmAcessarDadosEmp = class(TForm)
    txtSenha: TEdit;
    Label1: TLabel;
    btnAcessar: TSpeedButton;
    procedure btnAcessarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAcessarDadosEmp: TfrmAcessarDadosEmp;

implementation

{$R *.dfm}

uses UnitDadosEmp;

procedure TfrmAcessarDadosEmp.btnAcessarClick(Sender: TObject);
begin
  if txtSenha.Text = 'adminerSicaf' then
  begin
    frmAcessarDadosEmp.Close;
    frmDadosEmpresa.ShowModal;
  end
  else
  begin
    Application.MessageBox('Senha Incorreta !', 'Atenção', MB_ICONERROR+MB_OK);
  end;
end;

procedure TfrmAcessarDadosEmp.FormActivate(Sender: TObject);
begin
  txtSenha.Text := '';
  txtSenha.SetFocus;
end;

end.
