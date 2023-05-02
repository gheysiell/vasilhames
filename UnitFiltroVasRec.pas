unit UnitFiltroVasRec;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TfrmFiltroVasRecebidos = class(TForm)
    perDataIni: TDateTimePicker;
    perDataFim: TDateTimePicker;
    pnlPeriodo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    DBGrid1: TDBGrid;
    btnFiltrar: TSpeedButton;
    btnImprimir: TSpeedButton;
    procedure btnFiltrarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFiltroVasRecebidos: TfrmFiltroVasRecebidos;

implementation

{$R *.dfm}

uses UnitDM, UnitMenu;

procedure TfrmFiltroVasRecebidos.btnImprimirClick(Sender: TObject);
var
  temLogo : String;
begin
  temLogo := 'N';
  frmFiltroVasRecebidos.Close;

  if FileExists(logo) then
  begin
    temLogo := 'ss';
  end;

//  DM.relVasRecebidos.LoadFromFile('relatorios\relVasilhamesRecebidos.fr3');
//    DM.relVasRecebidos.Variables['temLogo']     := QuotedStr(temLogo);
//    DM.relVasRecebidos.Variables['razaoSoc']    := QuotedStr(razaoSoc);
//    DM.relVasRecebidos.Variables['fantasia']    := QuotedStr(fantasia);
//    DM.relVasRecebidos.Variables['cnpj']        := QuotedStr(cnpj);
//    DM.relVasRecebidos.Variables['inscEst']     := QuotedStr(inscEst);
//    DM.relVasRecebidos.Variables['endereco']    := QuotedStr(endereco);
//    DM.relVasRecebidos.Variables['cidade_emp']  := QuotedStr(cidade);
//    DM.relVasRecebidos.Variables['telefone']    := QuotedStr(telefone);
//    DM.relVasRecebidos.Variables['email']       := QuotedStr(email);
//  DM.relVasRecebidos.ShowReport;
end;

procedure TfrmFiltroVasRecebidos.FormActivate(Sender: TObject);
begin
  perDataIni.Date := Date() - 10;
  perDataFim.Date := Date();
  DBGrid1.ReadOnly := True;
  perDataIni.SetFocus;
  btnImprimir.Enabled := False;

  DM.qrRecebimentoVas.Close;
  DM.qrRecebimentoVas.SQL.Clear;
  DM.qrRecebimentoVas.SQL.Add('SELECT * FROM recebimento_vasilhames');
  DM.qrRecebimentoVas.Open;
end;

procedure TfrmFiltroVasRecebidos.btnFiltrarClick(Sender: TObject);
begin
  if perDataIni.Date > perDataFim.Date then
  begin
    Application.MessageBox('Data Inicial maior que Data Final !', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end;

  DM.qrRecebimentoVas.Close;
  DM.qrRecebimentoVas.SQL.Clear;
  DM.qrRecebimentoVas.SQL.Add('SELECT * FROM recebimento_vasilhames WHERE u_data >= :DataIni AND u_data <= :DataFim');
  DM.qrRecebimentoVas.ParamByName('DataIni').AsDate := perDataIni.Date;
  DM.qrRecebimentoVas.ParamByName('DataFim').AsDate := perDataFim.Date + 1;
  DM.qrRecebimentoVas.Open;

  if DM.qrRecebimentoVas.RecordCount < 1 then
  begin
    btnImprimir.Enabled := False;
  end
  else
  begin
    btnImprimir.Enabled := True;
  end;
end;

end.
