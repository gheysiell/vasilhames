unit UnitMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.Buttons, Vcl.StdCtrls, Vcl.Imaging.pngimage;

type
  TfrmMenu = class(TForm)
    pnlHeader: TPanel;
    pnl_menu_lateral: TPanel;
    pnlMenu: TPanel;
    imgMenu: TImage;
    pnlCadastro: TPanel;
    imgVendas: TImage;
    pnlPesquisa: TPanel;
    imgCaixa: TImage;
    pnlSair: TPanel;
    imgSair: TImage;
    imgCentral: TImage;
    pnlRecVasilhames: TPanel;
    Image1: TImage;
    pnlEntVasilhames: TPanel;
    Image2: TImage;
    pnlConfiguracoes: TPanel;
    imgConfiguracoes: TImage;
    pnlRelatorios: TPanel;
    imgRelatorios: TImage;
    procedure FormActivate(Sender: TObject);
    procedure pnlMenuClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
    procedure pnlSairClick(Sender: TObject);
    procedure imgSairClick(Sender: TObject);
    procedure pnlCadastroClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pnlPesquisaClick(Sender: TObject);
    procedure pnlSairMouseLeave(Sender: TObject);
    procedure imgSairMouseLeave(Sender: TObject);
    procedure imgSairMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlSairMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlPesquisaMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgCaixaMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgCaixaMouseLeave(Sender: TObject);
    procedure pnlPesquisaMouseLeave(Sender: TObject);
    procedure pnlCadastroMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgVendasMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgVendasMouseLeave(Sender: TObject);
    procedure pnlCadastroMouseLeave(Sender: TObject);
    procedure pnlRecVasilhamesMouseLeave(Sender: TObject);
    procedure Image1MouseLeave(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlRecVasilhamesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlEntVasilhamesMouseLeave(Sender: TObject);
    procedure Image2MouseLeave(Sender: TObject);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlEntVasilhamesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlEntVasilhamesClick(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure pnlRecVasilhamesClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure imgCaixaClick(Sender: TObject);
    procedure imgVendasClick(Sender: TObject);
    procedure pnlConfiguracoesMouseLeave(Sender: TObject);
    procedure imgConfiguracoesMouseLeave(Sender: TObject);
    procedure imgConfiguracoesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlConfiguracoesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlConfiguracoesClick(Sender: TObject);
    procedure imgConfiguracoesClick(Sender: TObject);
    procedure pnlRelatoriosMouseLeave(Sender: TObject);
    procedure imgRelatoriosMouseLeave(Sender: TObject);
    procedure imgRelatoriosMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlRelatoriosMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlRelatoriosClick(Sender: TObject);
    procedure imgRelatoriosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;
  menuExpandido : Boolean;
  razaoSoc, cnpj, inscEst, endereco, uf, cidade, telefone, email, fantasia, logo : String;

implementation

{$R *.dfm}

uses UnitCadastroVas, UnitDM, UnitPesquisa, UnitEntVasilhames,
  UnitRecVasilhames, UnitCadastros, UnitCadClientes, UnitConfiguracoes,
  UnitPesqVasilhames, UnitRelatorios;

procedure TfrmMenu.FormActivate(Sender: TObject);
begin
  pnl_menu_lateral.Width := 53;

  DM.qrDadosEmp.Close;
  DM.qrDadosEmp.SQL.Clear;
  DM.qrDadosEmp.SQL.Add('SELECT * FROM dados_empresa');
  DM.qrDadosEmp.Open;

  if DM.qrDadosEmp.RecordCount < 1 then
  begin
    DM.qrDadosEmp.Close;
    DM.qrDadosEmp.SQL.Clear;
    DM.qrDadosEmp.SQL.Add('INSERT INTO dados_empresa (cnpj, ie, endereco, cidade, uf, telefone, email, logo) VALUES (:cnpj, :ie, :endereco, :cidade, :uf, :telefone, :email, :logo)');
    DM.qrDadosEmp.Params.ParamByName('cnpj').AsString := '';
    DM.qrDadosEmp.Params.ParamByName('ie').AsString := '';
    DM.qrDadosEmp.Params.ParamByName('endereco').AsString := '';
    DM.qrDadosEmp.Params.ParamByName('cidade').AsString := '';
    DM.qrDadosEmp.Params.ParamByName('uf').AsString := '';
    DM.qrDadosEmp.Params.ParamByName('telefone').AsString := '';
    DM.qrDadosEmp.Params.ParamByName('email').AsString := '';
    DM.qrDadosEmp.Params.ParamByName('logo').AsString := '';
    DM.qrDadosEmp.ExecSQL;

    DM.qrDadosEmp.Close;
    DM.qrDadosEmp.SQL.Clear;
    DM.qrDadosEmp.SQL.Add('SELECT * FROM dados_empresa');
    DM.qrDadosEmp.Open;

    cnpj     := DM.qrDadosEmp.FieldByName('cnpj').AsString;
    fantasia := DM.qrDadosEmp.FieldByName('fantasia').AsString;
    razaoSoc := DM.qrDadosEmp.FieldByName('razao_social').AsString;
    inscEst  := DM.qrDadosEmp.FieldByName('ie').AsString;
    endereco := DM.qrDadosEmp.FieldByName('endereco').AsString;
    cidade   := DM.qrDadosEmp.FieldByName('cidade').AsString;
    uf       := DM.qrDadosEmp.FieldByName('uf').AsString;
    telefone := DM.qrDadosEmp.FieldByName('telefone').AsString;
    email    := DM.qrDadosEmp.FieldByName('email').AsString;
    logo     := DM.qrDadosEmp.FieldByName('logo').AsString;
  end
  else
  begin
    cnpj     := DM.qrDadosEmp.FieldByName('cnpj').AsString;
    fantasia := DM.qrDadosEmp.FieldByName('fantasia').AsString;
    razaoSoc := DM.qrDadosEmp.FieldByName('razao_social').AsString;
    inscEst  := DM.qrDadosEmp.FieldByName('ie').AsString;
    endereco := DM.qrDadosEmp.FieldByName('endereco').AsString;
    cidade   := DM.qrDadosEmp.FieldByName('cidade').AsString;
    uf       := DM.qrDadosEmp.FieldByName('uf').AsString;
    telefone := DM.qrDadosEmp.FieldByName('telefone').AsString;
    email    := DM.qrDadosEmp.FieldByName('email').AsString;
    logo     := DM.qrDadosEmp.FieldByName('logo').AsString;
  end;
end;

procedure TfrmMenu.FormCreate(Sender: TObject);
begin
  menuExpandido := True;
end;

procedure TfrmMenu.FormResize(Sender: TObject);
begin
  imgCentral.left := trunc((ClientWidth - imgCentral.width) / 2);
  imgCentral.top  := trunc((Clientheight - imgCentral.height) / 2);
end;

procedure TfrmMenu.Image1Click(Sender: TObject);
begin
  frmRecVasilhames.ShowModal;
end;

procedure TfrmMenu.Image1MouseLeave(Sender: TObject);
begin
  pnlRecVasilhames.Color := clMedGray;
end;

procedure TfrmMenu.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  pnlRecVasilhames.Color := clGradientActiveCaption;
end;

procedure TfrmMenu.Image2Click(Sender: TObject);
begin
  frmEntVasilhames.ShowModal;
end;

procedure TfrmMenu.Image2MouseLeave(Sender: TObject);
begin
  pnlEntVasilhames.Color := clMedGray;
end;

procedure TfrmMenu.Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  pnlEntVasilhames.Color := clGradientActiveCaption;
end;

procedure TfrmMenu.imgCaixaClick(Sender: TObject);
begin
  DM.qrVasilhames.Active := True;
  frmPesquisa.ShowModal;
end;

procedure TfrmMenu.imgCaixaMouseLeave(Sender: TObject);
begin
  pnlPesquisa.Color := clMedGray;
end;

procedure TfrmMenu.imgCaixaMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  pnlPesquisa.Color := clGradientActiveCaption;
end;

procedure TfrmMenu.imgConfiguracoesClick(Sender: TObject);
begin
  frmConfiguracoes.ShowModal;
end;

procedure TfrmMenu.imgConfiguracoesMouseLeave(Sender: TObject);
begin
  pnlConfiguracoes.Color := clMedGray;
end;

procedure TfrmMenu.imgConfiguracoesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlConfiguracoes.Color := clGradientActiveCaption;
end;

procedure TfrmMenu.imgMenuClick(Sender: TObject);
begin
  if menuExpandido then
  begin
    pnl_menu_lateral.Width := 230;
    pnlEntVasilhames.VIsible := True;
    pnlRecVasilhames.Visible := True;
    pnlCadastro.Visible := True;
    pnlPesquisa.Visible := True;
    pnlRelatorios.Visible := True;
    pnlConfiguracoes.Visible := True;
    pnlSair.Visible := True;
  end
  else
  begin
    pnl_menu_lateral.Width := 53;
    pnlSair.Visible := False;
    pnlConfiguracoes.Visible := False;
    pnlRelatorios.Visible := False;
    pnlPesquisa.Visible := False;
    pnlCadastro.Visible := False;
    pnlRecVasilhames.Visible := False;
    pnlEntVasilhames.VIsible := False;
  end;
  menuExpandido := not menuExpandido;
end;

procedure TfrmMenu.imgRelatoriosClick(Sender: TObject);
begin
  frmRelatorios.ShowModal;
end;

procedure TfrmMenu.imgRelatoriosMouseLeave(Sender: TObject);
begin
  pnlRelatorios.Color := clMedGray;
end;

procedure TfrmMenu.imgRelatoriosMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  pnlRelatorios.Color := clGradientActiveCaption;
end;

procedure TfrmMenu.imgSairClick(Sender: TObject);
begin
  frmMenu.Close;
end;

procedure TfrmMenu.imgSairMouseLeave(Sender: TObject);
begin
  pnlSair.Color := clMedGray;
end;

procedure TfrmMenu.imgSairMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  pnlSair.Color := clGradientActiveCaption;
end;

procedure TfrmMenu.imgVendasClick(Sender: TObject);
begin
  frmCadastros.ShowModal;
end;

procedure TfrmMenu.imgVendasMouseLeave(Sender: TObject);
begin
  pnlCadastro.Color := clMedGray;
end;

procedure TfrmMenu.imgVendasMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  pnlCadastro.Color := clGradientActiveCaption;
end;

procedure TfrmMenu.pnlCadastroClick(Sender: TObject);
begin
  frmCadastros.ShowModal;
end;

procedure TfrmMenu.pnlCadastroMouseLeave(Sender: TObject);
begin
  pnlCadastro.Color := clMedGray;
end;

procedure TfrmMenu.pnlCadastroMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  pnlCadastro.Color := clGradientActiveCaption;
end;

procedure TfrmMenu.pnlConfiguracoesClick(Sender: TObject);
begin
  frmConfiguracoes.ShowModal;
end;

procedure TfrmMenu.pnlConfiguracoesMouseLeave(Sender: TObject);
begin
  pnlConfiguracoes.Color := clMedGray;
end;

procedure TfrmMenu.pnlConfiguracoesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlConfiguracoes.Color := clGradientActiveCaption;
end;

procedure TfrmMenu.pnlEntVasilhamesClick(Sender: TObject);
begin
  frmEntVasilhames.ShowModal;
end;

procedure TfrmMenu.pnlEntVasilhamesMouseLeave(Sender: TObject);
begin
  pnlEntVasilhames.Color := clMedGray;
end;

procedure TfrmMenu.pnlEntVasilhamesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlEntVasilhames.Color := clGradientActiveCaption;
end;

procedure TfrmMenu.pnlMenuClick(Sender: TObject);
begin
  if menuExpandido then
  begin
    pnl_menu_lateral.Width := 230;
    pnlEntVasilhames.VIsible := True;
    pnlRecVasilhames.Visible := True;
    pnlCadastro.Visible := True;
    pnlPesquisa.Visible := True;
    pnlRelatorios.Visible := True;
    pnlConfiguracoes.Visible := True;
    pnlSair.Visible := True;
  end
  else
  begin
    pnl_menu_lateral.Width := 53;
    pnlSair.Visible := False;
    pnlConfiguracoes.Visible := False;
    pnlRelatorios.Visible := False;
    pnlPesquisa.Visible := False;
    pnlCadastro.Visible := False;
    pnlRecVasilhames.Visible := False;
    pnlEntVasilhames.VIsible := False;
  end;
  menuExpandido := not menuExpandido;
end;

procedure TfrmMenu.pnlPesquisaClick(Sender: TObject);
begin
  DM.qrVasilhames.Active := True;
  frmPesquisa.ShowModal;
end;

procedure TfrmMenu.pnlPesquisaMouseLeave(Sender: TObject);
begin
  pnlPesquisa.Color := clMedGray;
end;

procedure TfrmMenu.pnlPesquisaMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  pnlPesquisa.Color := clGradientActiveCaption;
end;

procedure TfrmMenu.pnlRecVasilhamesClick(Sender: TObject);
begin
  frmRecVasilhames.ShowModal;
end;

procedure TfrmMenu.pnlRecVasilhamesMouseLeave(Sender: TObject);
begin
  pnlRecVasilhames.Color := clMedGray;
end;

procedure TfrmMenu.pnlRecVasilhamesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlRecVasilhames.Color := clGradientActiveCaption;
end;

procedure TfrmMenu.pnlRelatoriosClick(Sender: TObject);
begin
  frmRelatorios.ShowModal;
end;

procedure TfrmMenu.pnlRelatoriosMouseLeave(Sender: TObject);
begin
  pnlRelatorios.Color := clMedGray;
end;

procedure TfrmMenu.pnlRelatoriosMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  pnlRelatorios.Color := clGradientActiveCaption;
end;

procedure TfrmMenu.pnlSairClick(Sender: TObject);
begin
  frmMenu.Close;
end;

procedure TfrmMenu.pnlSairMouseLeave(Sender: TObject);
begin
  pnlSair.Color := clMedGray;
end;

procedure TfrmMenu.pnlSairMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  pnlSair.Color := clGradientActiveCaption;
end;

end.
