unit UnitFiltroVasEntregues;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmFiltroVasEntregues = class(TForm)
    pnlPeriodo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    btnFiltrar: TSpeedButton;
    perDataFim: TDateTimePicker;
    perDataIni: TDateTimePicker;
    DBGrid1: TDBGrid;
    btnImprimir: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFiltroVasEntregues: TfrmFiltroVasEntregues;

implementation

{$R *.dfm}

uses UnitDM, UnitMenu;

procedure TfrmFiltroVasEntregues.btnFiltrarClick(Sender: TObject);
begin
  if perDataIni.Date > perDataFim.Date then
  begin
    Application.MessageBox('Data Inicial maior que Data Final !', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end;
  DM.qrEntRec.Close;
  DM.qrEntRec.SQL.Clear;
  DM.qrEntRec.SQL.Add('SELECT id, cliente, vasilhame, quantidade_entregue, u_data FROM ent_rec WHERE u_data >= :DataIni AND u_data <= :DataFim AND bonus = :bonus');
  DM.qrEntRec.ParamByName('DataIni').AsDate := perDataIni.Date;
  DM.qrEntRec.ParamByName('DataFim').AsDate := perDataFim.Date + 1;
  DM.qrEntRec.ParamByName('bonus').AsString := 'N';
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

procedure TfrmFiltroVasEntregues.btnImprimirClick(Sender: TObject);
var
  temLogo : String;
begin
  temLogo := 'N';
  frmFiltroVasEntregues.Close;

  if FileExists(logo) then
  begin
    temLogo := 'ss';
  end;

  DM.relVasEntregues.LoadFromFile('relatorios\relVasEntregues.fr3');
    DM.relVasEntregues.Variables['temLogo']     := QuotedStr(temLogo);
    DM.relVasEntregues.Variables['razaoSoc']    := QuotedStr(razaoSoc);
    DM.relVasEntregues.Variables['fantasia']    := QuotedStr(fantasia);
    DM.relVasEntregues.Variables['cnpj']        := QuotedStr(cnpj);
    DM.relVasEntregues.Variables['inscEst']     := QuotedStr(inscEst);
    DM.relVasEntregues.Variables['endereco']    := QuotedStr(endereco);
    DM.relVasEntregues.Variables['cidade_emp']  := QuotedStr(cidade);
    DM.relVasEntregues.Variables['telefone']    := QuotedStr(telefone);
    DM.relVasEntregues.Variables['email']       := QuotedStr(email);
  DM.relVasEntregues.ShowReport;
end;

procedure TfrmFiltroVasEntregues.FormActivate(Sender: TObject);
begin
  perDataIni.Date := Date() - 10;
  DBGrid1.ReadOnly := True;
  perDataFim.Date := Date();
  perDataIni.SetFocus;
  btnImprimir.Enabled := False;

  DM.qrEntRec.Close;
  DM.qrEntRec.SQL.Clear;
  DM.qrEntRec.SQL.Add('SELECT * FROM ent_rec WHERE bonus = :bonus');
  DM.qrEntRec.ParamByName('bonus').AsString := 'N';
  DM.qrEntRec.Open;
end;

end.
