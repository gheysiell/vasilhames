unit UnitFiltroHistCliDetalhado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmFiltroHistCliDetalhado = class(TForm)
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
  frmFiltroHistCliDetalhado: TfrmFiltroHistCliDetalhado;

implementation

{$R *.dfm}

uses UnitDM, UnitMenu;

procedure TfrmFiltroHistCliDetalhado.btnFiltrarClick(Sender: TObject);
begin
  if perDataIni.Date > perDataFim.Date then
  begin
    Application.MessageBox('Data Inicial maior que Data Final !', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end;

  DM.qrEntRec.Close;
  DM.qrEntRec.SQL.Clear;
  DM.qrEntRec.SQL.Add('SELECT id, cliente, vasilhame, quantidade_entregue, quantidade_recebida, quantidade_debito, u_data FROM ent_rec WHERE u_data >= :DataIni AND u_data <= :DataFim ORDER BY cliente, vasilhame');
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

procedure TfrmFiltroHistCliDetalhado.btnImprimirClick(Sender: TObject);
var
  temLogo : String;
begin
  temLogo := 'N';
  frmFiltroHistCliDetalhado.Close;

  if FileExists(logo) then
  begin
    temLogo := 'ss';
  end;

  DM.relHistClientesDet.LoadFromFile('relatorios\relHistClientesDetalhado.fr3');
    DM.relHistClientesDet.Variables['temLogo']     := QuotedStr(temLogo);
    DM.relHistClientesDet.Variables['razaoSoc']    := QuotedStr(razaoSoc);
    DM.relHistClientesDet.Variables['fantasia']    := QuotedStr(fantasia);
    DM.relHistClientesDet.Variables['cnpj']        := QuotedStr(cnpj);
    DM.relHistClientesDet.Variables['inscEst']     := QuotedStr(inscEst);
    DM.relHistClientesDet.Variables['endereco']    := QuotedStr(endereco);
    DM.relHistClientesDet.Variables['cidade_emp']  := QuotedStr(cidade);
    DM.relHistClientesDet.Variables['telefone']    := QuotedStr(telefone);
    DM.relHistClientesDet.Variables['email']       := QuotedStr(email);
  DM.relHistClientesDet.ShowReport;
end;

procedure TfrmFiltroHistCliDetalhado.FormActivate(Sender: TObject);
begin
  perDataIni.Date := Date() - 10;
  DBGrid1.ReadOnly := True;
  perDataFim.Date := Date();
  perDataIni.SetFocus;
  btnImprimir.Enabled := False;

  DM.qrEntRec.Close;
  DM.qrEntRec.SQL.Clear;
  DM.qrEntRec.SQL.Add('SELECT id, cliente, vasilhame, quantidade_debito, quantidade_recebida FROM ent_rec ORDER BY cliente, vasilhame');
  DM.qrEntRec.Open;

  DBGrid1.Columns[2].Width := 080;
  DBGrid1.Columns[3].Width := 068;
end;

end.
