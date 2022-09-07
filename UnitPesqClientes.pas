unit UnitPesqClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids;

type
  TfrmPesqClientes = class(TForm)
    dbgridPesqCli: TDBGrid;
    GroupBox1: TGroupBox;
    SpeedButton1: TSpeedButton;
    txtBuscaClientes: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesqClientes: TfrmPesqClientes;

implementation

{$R *.dfm}

uses UnitDM;

procedure TfrmPesqClientes.FormActivate(Sender: TObject);
begin
  txtBuscaClientes.SetFocus;
  txtBuscaClientes.Text := '';
  dbgridPesqCli.ReadOnly := True;

  DM.qrClientes.Close;
  DM.qrClientes.SQL.Clear;
  DM.qrClientes.SQL.Add('SELECT * FROM clientes');
  DM.qrClientes.Open;
  DM.qrClientes.Active := True;
  dbgridPesqCli.Refresh;
end;

procedure TfrmPesqClientes.SpeedButton1Click(Sender: TObject);
begin
  DM.qrClientes.Close;
  DM.qrClientes.SQL.Clear;
  DM.qrClientes.SQL.Add('SELECT * FROM clientes WHERE nome_razao LIKE :nome OR documento LIKE :nome OR cidade LIKE :nome OR uf LIKE :nome OR u_data LIKE :nome');
  DM.qrClientes.Params.ParamByName('nome').AsString := '%'+txtBuscaClientes.Text+'%';
  DM.qrClientes.Open;
  DM.qrClientes.Active := True;
  dbgridPesqCli.Refresh;
  txtBuscaClientes.SetFocus;
end;

end.
