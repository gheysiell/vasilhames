unit UnitFiltroHistClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmFiltroHistClientes = class(TForm)
    btnImprimir: TSpeedButton;
    pnlPeriodo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    btnFiltrar: TSpeedButton;
    perDataFim: TDateTimePicker;
    perDataIni: TDateTimePicker;
    DBGrid1: TDBGrid;
    procedure FormActivate(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFiltroHistClientes: TfrmFiltroHistClientes;

implementation

{$R *.dfm}

uses UnitDM, UnitMenu;

procedure TfrmFiltroHistClientes.btnFiltrarClick(Sender: TObject);
begin
  if perDataIni.Date > perDataFim.Date then
  begin
    Application.MessageBox('Data Inicial maior que Data Final !', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end;

  DM.qrEntRec.Close;
  DM.qrEntRec.SQL.Clear;
  DM.qrEntRec.SQL.Add('SELECT id, cliente, vasilhame, ');
  DM.qrEntRec.SQL.Add('SUM(quantidade_entregue) as qtd_ent, SUM(quantidade_recebida) as qtd_rec, SUM(quantidade_debito) as qtd_deb ');
  DM.qrEntRec.SQL.Add('FROM ent_rec WHERE u_data >= :DataIni AND u_data <= :DataFim GROUP BY vasilhame, cliente ORDER BY cliente');
  DM.qrEntRec.ParamByName('DataIni').AsDate := perDataIni.Date;
  DM.qrEntRec.ParamByName('DataFim').AsDate := perDataFim.Date + 1;
  DM.qrEntRec.Open;

  if DM.qrEntRec.RecordCount < 1 then
  begin
    btnImprimir.Enabled := False;
  end
  else
  begin
    btnImprimir.Enabled := True;
  end;
end;

procedure TfrmFiltroHistClientes.btnImprimirClick(Sender: TObject);
var
  temLogo : String;
begin
  temLogo := 'N';
  frmFiltroHistClientes.Close;

  if FileExists(logo) then
  begin
    temLogo := 'ss';
  end;

  DM.relHistClientes.LoadFromFile('relatorios\relHistClientes.fr3');
    DM.relHistClientes.Variables['temLogo']     := QuotedStr(temLogo);
    DM.relHistClientes.Variables['razaoSoc']    := QuotedStr(razaoSoc);
    DM.relHistClientes.Variables['fantasia']    := QuotedStr(fantasia);
    DM.relHistClientes.Variables['cnpj']        := QuotedStr(cnpj);
    DM.relHistClientes.Variables['inscEst']     := QuotedStr(inscEst);
    DM.relHistClientes.Variables['endereco']    := QuotedStr(endereco);
    DM.relHistClientes.Variables['cidade_emp']  := QuotedStr(cidade);
    DM.relHistClientes.Variables['telefone']    := QuotedStr(telefone);
    DM.relHistClientes.Variables['email']       := QuotedStr(email);
  DM.relHistClientes.ShowReport;
end;

procedure TfrmFiltroHistClientes.FormActivate(Sender: TObject);
begin
  perDataIni.Date := Date() - 10;
  DBGrid1.ReadOnly := True;
  perDataFim.Date := Date();
  perDataIni.SetFocus;
  btnImprimir.Enabled := False;

  DM.qrEntRec.Close;
  DM.qrEntRec.SQL.Clear;
  DM.qrEntRec.SQL.Add('SELECT id, cliente, vasilhame, SUM(quantidade_recebida) as quantidade_recebida, SUM(quantidade_debito) as quantidade_debito FROM ent_rec GROUP BY vasilhame, cliente ORDER BY cliente');
  DM.qrEntRec.Open;

  DBGrid1.Columns[2].Width := 080;
  DBGrid1.Columns[3].Width := 068;
end;

end.
