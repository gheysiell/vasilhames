unit UnitPesqVasilhamesaRec;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids;

type
  TfrmPesqVasilhamesaRec = class(TForm)
    dbgridPesqVasaRec: TDBGrid;
    GroupBox3: TGroupBox;
    SpeedButton2: TSpeedButton;
    txtBuscaVasilhamesaRec: TEdit;
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesqVasilhamesaRec: TfrmPesqVasilhamesaRec;

implementation

{$R *.dfm}

uses UnitDM;

procedure TfrmPesqVasilhamesaRec.FormActivate(Sender: TObject);
begin
  txtBuscaVasilhamesaRec.SetFocus;
  txtBuscaVasilhamesaRec.Text := '';
  dbgridPesqVasaRec.ReadOnly := True;

  DM.qrEntRec.Close;
  DM.qrEntRec.SQL.Clear;
  DM.qrEntRec.SQL.Add('SELECT * FROM ent_rec WHERE quantidade_atual <> 0');
  DM.qrEntRec.Open;
  DM.qrEntRec.Active := True;
end;

procedure TfrmPesqVasilhamesaRec.SpeedButton2Click(Sender: TObject);
begin
  DM.qrEntRec.Close;
  DM.qrEntRec.SQL.Clear;
  DM.qrEntRec.SQL.Add('SELECT * FROM ent_rec WHERE (quantidade_atual <> 0) AND (vasilhame LIKE :vasilhame OR cliente LIKE :vasilhame OR quantidade_atual LIKE :vasilhame)');
  DM.qrEntRec.Params.ParamByName('vasilhame').AsString := '%'+txtBuscaVasilhamesaRec.Text+'%';
  DM.qrEntRec.Open;

  dbgridPesqVasaRec.Refresh;
  txtBuscaVasilhamesaRec.SetFocus;
end;

end.
