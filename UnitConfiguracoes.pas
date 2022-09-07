unit UnitConfiguracoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmConfiguracoes = class(TForm)
    pnlDadosEmpresa: TPanel;
    imgDadosEmpresa: TImage;
    pnlSuporte: TPanel;
    imgSuporte: TImage;
    pnlConfigLogo: TPanel;
    imgConfigLogo: TImage;
    procedure pnlSuporteClick(Sender: TObject);
    procedure imgSuporteClick(Sender: TObject);
    procedure pnlSuporteMouseLeave(Sender: TObject);
    procedure imgSuporteMouseLeave(Sender: TObject);
    procedure pnlSuporteMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgSuporteMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlDadosEmpresaMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgDadosEmpresaMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgDadosEmpresaMouseLeave(Sender: TObject);
    procedure pnlDadosEmpresaMouseLeave(Sender: TObject);
    procedure imgDadosEmpresaClick(Sender: TObject);
    procedure pnlDadosEmpresaClick(Sender: TObject);
    procedure imgConfigLogoClick(Sender: TObject);
    procedure pnlConfigLogoClick(Sender: TObject);
    procedure pnlConfigLogoMouseLeave(Sender: TObject);
    procedure imgConfigLogoMouseLeave(Sender: TObject);
    procedure imgConfigLogoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlConfigLogoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfiguracoes: TfrmConfiguracoes;

implementation

{$R *.dfm}

uses UnitSuporte, UnitDadosEmp, UnitConfigurarLogo, UnitAcessarDadosEmp;

procedure TfrmConfiguracoes.imgConfigLogoClick(Sender: TObject);
begin
  frmConfigurarLogo.ShowModal;
end;

procedure TfrmConfiguracoes.imgConfigLogoMouseLeave(Sender: TObject);
begin
  pnlConfigLogo.Color := clCream;
end;

procedure TfrmConfiguracoes.imgConfigLogoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlConfigLogo.Color := clGradientActiveCaption;
end;

procedure TfrmConfiguracoes.imgDadosEmpresaClick(Sender: TObject);
begin
  frmAcessarDadosEmp.ShowModal;
end;

procedure TfrmConfiguracoes.imgDadosEmpresaMouseLeave(Sender: TObject);
begin
  pnlDadosEmpresa.Color := clCream;
end;

procedure TfrmConfiguracoes.imgDadosEmpresaMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlDadosEmpresa.Color := clGradientActiveCaption;
end;

procedure TfrmConfiguracoes.imgSuporteClick(Sender: TObject);
begin
  frmSuporte.ShowModal;
end;

procedure TfrmConfiguracoes.imgSuporteMouseLeave(Sender: TObject);
begin
  pnlSuporte.Color := clCream;
end;

procedure TfrmConfiguracoes.imgSuporteMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlSuporte.Color := clGradientActiveCaption;
end;

procedure TfrmConfiguracoes.pnlConfigLogoClick(Sender: TObject);
begin
  frmConfigurarLogo.ShowModal;
end;

procedure TfrmConfiguracoes.pnlConfigLogoMouseLeave(Sender: TObject);
begin
  pnlConfigLogo.Color := clCream;
end;

procedure TfrmConfiguracoes.pnlConfigLogoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlConfigLogo.Color := clGradientActiveCaption;
end;

procedure TfrmConfiguracoes.pnlDadosEmpresaClick(Sender: TObject);
begin
  frmAcessarDadosEmp.ShowModal;
end;

procedure TfrmConfiguracoes.pnlDadosEmpresaMouseLeave(Sender: TObject);
begin
  pnlDadosEmpresa.Color := clCream;
end;

procedure TfrmConfiguracoes.pnlDadosEmpresaMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlDadosEmpresa.Color := clGradientActiveCaption;
end;

procedure TfrmConfiguracoes.pnlSuporteClick(Sender: TObject);
begin
  frmSuporte.ShowModal;
end;

procedure TfrmConfiguracoes.pnlSuporteMouseLeave(Sender: TObject);
begin
  pnlSuporte.Color := clCream;
end;

procedure TfrmConfiguracoes.pnlSuporteMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlSuporte.Color := clGradientActiveCaption;
end;

end.
