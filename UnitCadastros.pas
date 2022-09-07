unit UnitCadastros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TfrmCadastros = class(TForm)
    pnlCadVasilhames: TPanel;
    imgCadVasilhames: TImage;
    pnlCadClientes: TPanel;
    imgCadClientes: TImage;
    procedure imgCadVasilhamesClick(Sender: TObject);
    procedure pnlCadVasilhamesClick(Sender: TObject);
    procedure pnlCadClientesClick(Sender: TObject);
    procedure imgCadClientesClick(Sender: TObject);
    procedure pnlCadClientesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgCadClientesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlCadClientesMouseLeave(Sender: TObject);
    procedure imgCadClientesMouseLeave(Sender: TObject);
    procedure imgCadVasilhamesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlCadVasilhamesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgCadVasilhamesMouseLeave(Sender: TObject);
    procedure pnlCadVasilhamesMouseLeave(Sender: TObject);
    procedure pnlEntVasilhamesMouseLeave(Sender: TObject);
    procedure pnlEntVasilhamesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseLeave(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastros: TfrmCadastros;

implementation

{$R *.dfm}

uses UnitEntVasilhames, UnitCadastroVas, UnitCadClientes;

procedure TfrmCadastros.imgCadClientesMouseLeave(Sender: TObject);
begin
  pnlCadClientes.Color := clCream;
end;

procedure TfrmCadastros.imgCadClientesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlCadClientes.Color := clGradientActiveCaption;
end;

procedure TfrmCadastros.imgCadVasilhamesClick(Sender: TObject);
begin
  frmCadastros.Close;
  frmCadVasilhames.ShowModal;
end;

procedure TfrmCadastros.imgCadVasilhamesMouseLeave(Sender: TObject);
begin
  pnlCadVasilhames.Color := clCream;
end;

procedure TfrmCadastros.imgCadVasilhamesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlCadVasilhames.Color := clGradientActiveCaption;
end;

procedure TfrmCadastros.Image1MouseLeave(Sender: TObject);
begin
  pnlCadVasilhames.Color := clMedGray;
end;

procedure TfrmCadastros.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  pnlCadClientes.Color := clGradientActiveCaption;
end;

procedure TfrmCadastros.imgCadClientesClick(Sender: TObject);
begin
  frmCadastros.Close;
  frmCadClientes.ShowModal;
end;

procedure TfrmCadastros.pnlCadVasilhamesClick(Sender: TObject);
begin
  frmCadastros.Close;
  frmCadVasilhames.ShowModal;
end;

procedure TfrmCadastros.pnlCadVasilhamesMouseLeave(Sender: TObject);
begin
  pnlCadVasilhames.Color := clBtnFace;
end;

procedure TfrmCadastros.pnlCadVasilhamesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlCadVasilhames.Color := clGradientActiveCaption;
end;

procedure TfrmCadastros.pnlEntVasilhamesMouseLeave(Sender: TObject);
begin
  pnlCadVasilhames.Color := clCream;
end;

procedure TfrmCadastros.pnlEntVasilhamesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlCadVasilhames.Color := clGradientActiveCaption;
end;

procedure TfrmCadastros.pnlCadClientesClick(Sender: TObject);
begin
  frmCadastros.Close;
  frmCadClientes.ShowModal;
end;

procedure TfrmCadastros.pnlCadClientesMouseLeave(Sender: TObject);
begin
  pnlCadClientes.Color := clCream;
end;

procedure TfrmCadastros.pnlCadClientesMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  pnlCadClientes.Color := clGradientActiveCaption;
end;

end.
