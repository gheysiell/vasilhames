unit UnitDadosEmp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls;

type
  TfrmDadosEmpresa = class(TForm)
    btnPreencher: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    txtCnpj: TDBEdit;
    txtIE: TDBEdit;
    txtEmail: TDBEdit;
    txtNomeFantasia: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    txtRazaoSocial: TDBEdit;
    Label6: TLabel;
    txtTelefone: TDBEdit;
    txtEndereco: TDBEdit;
    Label7: TLabel;
    Label9: TLabel;
    cmbUF: TDBComboBox;
    Label10: TLabel;
    txtCidade: TDBEdit;
    procedure btnPreencherClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDadosEmpresa: TfrmDadosEmpresa;

implementation

{$R *.dfm}

uses UnitDM, UnitMenu;

procedure TfrmDadosEmpresa.btnCancelarClick(Sender: TObject);
begin
  DM.qrDadosEmp.Cancel;
  btnSalvar.Enabled := False;
  btnCancelar.Enabled := False;
  btnPreencher.Enabled := True;
  ActiveControl := nil;

  txtCnpj.ReadOnly := True;
  txtIE.ReadOnly := True;
  txtTelefone.ReadOnly := True;
  txtNomeFantasia.ReadOnly := True;
  txtRazaoSocial.ReadOnly := True;
  txtEndereco.ReadOnly := True;
  txtCidade.ReadOnly := True;
  txtEmail.ReadOnly := True;
  cmbUF.ReadOnly := True;
end;

procedure TfrmDadosEmpresa.btnPreencherClick(Sender: TObject);
begin
  DM.qrDadosEmp.Edit;
  btnPreencher.Enabled := False;
  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;
  txtCnpj.SetFocus;

  txtCnpj.ReadOnly := False;
  txtIE.ReadOnly := False;
  txtTelefone.ReadOnly := False;
  txtNomeFantasia.ReadOnly := False;
  txtRazaoSocial.ReadOnly := False;
  txtEndereco.ReadOnly := False;
  txtCidade.ReadOnly := False;
  txtEmail.ReadOnly := False;
  cmbUF.ReadOnly := False;
end;

procedure TfrmDadosEmpresa.btnSalvarClick(Sender: TObject);
begin
  DM.qrDadosEmp.Post;
  DM.qrDadosEmp.Open;
  btnSalvar.Enabled := False;
  btnCancelar.Enabled := False;
  btnPreencher.Enabled := True;
  ActiveControl := nil;

  Application.MessageBox('Dados Salvos Com Sucesso!', 'Olá', MB_ICONINFORMATION+MB_OK);

  cnpj     := DM.qrDadosEmp.FieldByName('cnpj').AsString;
  fantasia := DM.qrDadosEmp.FieldByName('fantasia').AsString;
  razaoSoc := DM.qrDadosEmp.FieldByName('razao_social').AsString;
  inscEst  := DM.qrDadosEmp.FieldByName('ie').AsString;
  endereco := DM.qrDadosEmp.FieldByName('endereco').AsString;
  cidade   := DM.qrDadosEmp.FieldByName('cidade').AsString;
  uf       := DM.qrDadosEmp.FieldByName('uf').AsString;
  telefone := DM.qrDadosEmp.FieldByName('telefone').AsString;
  email    := DM.qrDadosEmp.FieldByName('email').AsString;

  txtCnpj.ReadOnly := True;
  txtIE.ReadOnly := True;
  txtTelefone.ReadOnly := True;
  txtNomeFantasia.ReadOnly := True;
  txtRazaoSocial.ReadOnly := True;
  txtEndereco.ReadOnly := True;
  txtCidade.ReadOnly := True;
  txtEmail.ReadOnly := True;
  cmbUF.ReadOnly := True;
end;

procedure TfrmDadosEmpresa.FormActivate(Sender: TObject);
begin
  DM.qrDadosEmp.Close;
  DM.qrDadosEmp.SQL.Clear;
  DM.qrDadosEmp.SQL.Add('SELECT * FROM dados_empresa');
  DM.qrDadosEmp.Open;
  DM.qrDadosEmp.Active := True;

  btnPreencher.Enabled := True;
  btnSalvar.Enabled := False;
  btnCancelar.Enabled := False;
  ActiveControl := nil;

  txtCnpj.ReadOnly := True;
  txtIE.ReadOnly := True;
  txtTelefone.ReadOnly := True;
  txtNomeFantasia.ReadOnly := True;
  txtRazaoSocial.ReadOnly := True;
  txtEndereco.ReadOnly := True;
  txtCidade.ReadOnly := True;
  txtEmail.ReadOnly := True;
  cmbUF.ReadOnly := True;
end;

end.
