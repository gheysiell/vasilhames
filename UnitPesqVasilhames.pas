unit UnitPesqVasilhames;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmPesqVasilhames = class(TForm)
    GroupBox2: TGroupBox;
    btnBuscar: TSpeedButton;
    txtBuscaVasilhames: TEdit;
    dbgridPesqVas: TDBGrid;
    procedure btnBuscarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesqVasilhames: TfrmPesqVasilhames;

implementation

{$R *.dfm}

uses UnitDM;

procedure TfrmPesqVasilhames.btnBuscarClick(Sender: TObject);
begin
  DM.qrVasilhames.Close;
  DM.qrVasilhames.SQL.Clear;
  DM.qrVasilhames.SQL.Add('SELECT * FROM vasilhames WHERE descricao LIKE :descricao OR marca LIKE :descricao OR quantidade LIKE :descricao OR capacidade LIKE :descricao OR u_data LIKE :descricao');
  DM.qrVasilhames.Params.ParamByName('descricao').AsString := '%'+txtBuscaVasilhames.Text+'%';
  DM.qrVasilhames.Open;
  DM.qrVasilhames.Active := True;
  dbgridPesqVas.Refresh;
  txtBuscaVasilhames.SetFocus;
end;

procedure TfrmPesqVasilhames.FormActivate(Sender: TObject);
begin
  txtBuscaVasilhames.SetFocus;
  txtBuscaVasilhames.Text := '';
  dbgridPesqVas.ReadOnly := True;

  DM.qrVasilhames.Close;
  DM.qrVasilhames.SQL.Clear;
  DM.qrVasilhames.SQL.Add('SELECT * FROM vasilhames');
  DM.qrVasilhames.Open;
  DM.qrVasilhames.Active := True;
end;

end.
