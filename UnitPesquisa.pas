unit UnitPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TfrmPesquisa = class(TForm)
    pnlPesqVasilhames: TPanel;
    pnlPesqClientes: TPanel;
    pnlPesqVasilhamesaRec: TPanel;
    A: TImage;
    imgClientes: TImage;
    imgVasilhamesaRec: TImage;
    procedure pnlPesqVasilhamesMouseLeave(Sender: TObject);
    procedure AMouseLeave(Sender: TObject);
    procedure pnlPesqClientesMouseLeave(Sender: TObject);
    procedure imgClientesMouseLeave(Sender: TObject);
    procedure pnlPesqVasilhamesaRecMouseLeave(Sender: TObject);
    procedure imgVasilhamesaRecMouseLeave(Sender: TObject);
    procedure pnlPesqVasilhamesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure AMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure imgClientesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlPesqClientesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgVasilhamesaRecMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlPesqVasilhamesaRecMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure imgClientesClick(Sender: TObject);
    procedure pnlPesqClientesClick(Sender: TObject);
    procedure pnlPesqVasilhamesClick(Sender: TObject);
    procedure AClick(Sender: TObject);
    procedure imgVasilhamesaRecClick(Sender: TObject);
    procedure pnlPesqVasilhamesaRecClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesquisa: TfrmPesquisa;

implementation

{$R *.dfm}

uses UnitPesqClientes, UnitPesqVasilhames, UnitPesqVasilhamesaRec;

procedure TfrmPesquisa.AClick(Sender: TObject);
begin
  frmPesqVasilhames.ShowModal;
end;

procedure TfrmPesquisa.AMouseLeave(Sender: TObject);
begin
  pnlPesqVasilhames.Color := clCream;
end;

procedure TfrmPesquisa.AMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  pnlPesqVasilhames.Color := clGradientActiveCaption;
end;

procedure TfrmPesquisa.imgClientesClick(Sender: TObject);
begin
  frmPesqClientes.ShowModal;
end;

procedure TfrmPesquisa.imgClientesMouseLeave(Sender: TObject);
begin
  pnlPesqClientes.Color := clCream;
end;

procedure TfrmPesquisa.imgClientesMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  pnlPesqClientes.Color := clGradientActiveCaption;
end;

procedure TfrmPesquisa.imgVasilhamesaRecClick(Sender: TObject);
begin
  frmPesqVasilhamesaRec.ShowModal;
end;

procedure TfrmPesquisa.imgVasilhamesaRecMouseLeave(Sender: TObject);
begin
  pnlPesqVasilhamesaRec.Color := clCream;
end;

procedure TfrmPesquisa.imgVasilhamesaRecMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlPesqVasilhamesaRec.Color := clGradientActiveCaption;
end;

procedure TfrmPesquisa.pnlPesqClientesClick(Sender: TObject);
begin
  frmPesqClientes.ShowModal;
end;

procedure TfrmPesquisa.pnlPesqClientesMouseLeave(Sender: TObject);
begin
  pnlPesqClientes.Color := clCream;
end;

procedure TfrmPesquisa.pnlPesqClientesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlPesqClientes.Color := clGradientActiveCaption;
end;

procedure TfrmPesquisa.pnlPesqVasilhamesaRecClick(Sender: TObject);
begin
  frmPesqVasilhamesaRec.ShowModal;
end;

procedure TfrmPesquisa.pnlPesqVasilhamesaRecMouseLeave(Sender: TObject);
begin
  pnlPesqVasilhamesaRec.Color := clCream;
end;

procedure TfrmPesquisa.pnlPesqVasilhamesaRecMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlPesqVasilhamesaRec.Color := clGradientActiveCaption;
end;

procedure TfrmPesquisa.pnlPesqVasilhamesClick(Sender: TObject);
begin
  frmPesqVasilhames.ShowModal;
end;

procedure TfrmPesquisa.pnlPesqVasilhamesMouseLeave(Sender: TObject);
begin
  pnlPesqVasilhames.Color := clCream;
end;

procedure TfrmPesquisa.pnlPesqVasilhamesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlPesqVasilhames.Color := clGradientActiveCaption;
end;

end.
