unit UnitCadClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmCadClientes = class(TForm)
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    lblNomeRzSoc: TLabel;
    dbnavCadClientes: TDBNavigator;
    txtID: TDBEdit;
    txtNomeRzSoc: TDBEdit;
    Label1: TLabel;
    txtCpf: TDBEdit;
    lblCpfCnpj: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    txtRua: TDBEdit;
    txtBairro: TDBEdit;
    txtCidade: TDBEdit;
    txtCep: TDBEdit;
    txtNumero: TDBEdit;
    cmbUF: TDBComboBox;
    Label9: TLabel;
    btnPesquisar: TSpeedButton;
    txtApelidoFantasia: TDBEdit;
    lblApelidoFant: TLabel;
    Label12: TLabel;
    txtTelefone: TDBEdit;
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtNomeRzSocKeyPress(Sender: TObject; var Key: Char);
    procedure txtCpfKeyPress(Sender: TObject; var Key: Char);
    procedure txtRuaKeyPress(Sender: TObject; var Key: Char);
    procedure txtNumeroKeyPress(Sender: TObject; var Key: Char);
    procedure txtBairroKeyPress(Sender: TObject; var Key: Char);
    procedure txtCidadeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbUFKeyPress(Sender: TObject; var Key: Char);
    procedure txtCepKeyPress(Sender: TObject; var Key: Char);
    procedure txtIDKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisarClick(Sender: TObject);
    procedure txtApelidoFantasiaKeyPress(Sender: TObject; var Key: Char);
    procedure txtTelefoneKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadClientes : TfrmCadClientes;
  Editar : Boolean;

implementation

{$R *.dfm}

uses UnitDM, UnitPesqClientes;

procedure TfrmCadClientes.btnCancelarClick(Sender: TObject);
begin
  btnNovo.Enabled := True;
  btnEditar.Enabled := True;
  btnExcluir.Enabled := True;
  btnSalvar.Enabled := False;
  btnCancelar.Enabled := False;
  dbnavCadClientes.Enabled := True;

  txtNomeRzSoc.ReadOnly := True;
  txtApelidoFantasia.ReadOnly := True;
  txtCpf.ReadOnly := True;
  txtRua.ReadOnly := True;
  txtNumero.ReadOnly := True;
  txtBairro.ReadOnly := True;
  txtCidade.ReadOnly := True;
  txtCep.ReadOnly := True;
  txtTelefone.ReadOnly := True;
  cmbUF.ReadOnly := True;

  DM.tbClientes.Cancel;
  dbnavCadClientes.SetFocus;
end;

procedure TfrmCadClientes.btnEditarClick(Sender: TObject);
begin
  btnNovo.Enabled := False;
  btnEditar.Enabled := False;
  btnExcluir.Enabled := False;
  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;

  txtNomeRzSoc.ReadOnly := False;
  txtApelidoFantasia.ReadOnly := False;
  txtCpf.ReadOnly := False;
  txtRua.ReadOnly := False;
  txtNumero.ReadOnly := False;
  txtBairro.ReadOnly := False;
  txtCidade.ReadOnly := False;
  txtCep.ReadOnly := False;
  txtTelefone.ReadOnly := False;
  cmbUF.ReadOnly := False;

  dbnavCadClientes.Enabled := False;
  Editar := True;
  DM.tbClientes.Edit;
  txtNomeRzSoc.SetFocus;
end;

procedure TfrmCadClientes.btnExcluirClick(Sender: TObject);
begin
  DM.qrEntRec.Close;
  DM.qrEntRec.SQL.Clear;
  DM.qrEntRec.SQL.Add('SELECT cliente FROM ent_rec WHERE cliente = :cliente');
  DM.qrEntRec.Params.ParamByName('cliente').AsString := txtNomeRzSoc.Text;
  DM.qrEntRec.Open;
  DM.qrEntRec.Active := True;

  if not DM.qrEntRec.IsEmpty then
  begin
    Application.MessageBox('Não é Possível Excluir Esse Cliente, Pois Existem Vasilhames a Receber do Mesmo !', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end;

  if (Application.MessageBox('Deseja Realmente Exluir Esse Registro ?', 'Atenção', MB_ICONEXCLAMATION+MB_YESNO)) = mrYes then
  begin
    DM.tbClientes.Delete;
    dbnavCadClientes.SetFocus;
  end;
end;

procedure TfrmCadClientes.btnNovoClick(Sender: TObject);
begin
  dbnavCadClientes.Enabled := False;
  btnNovo.Enabled := False;
  btnEditar.Enabled := False;
  btnExcluir.Enabled := False;
  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;

  txtNomeRzSoc.ReadOnly := False;
  txtApelidoFantasia.ReadOnly := False;
  txtCpf.ReadOnly := False;
  txtRua.ReadOnly := False;
  txtNumero.ReadOnly := False;
  txtBairro.ReadOnly := False;
  txtCidade.ReadOnly := False;
  txtCep.ReadOnly := False;
  txtTelefone.ReadOnly := False;
  cmbUF.ReadOnly := False;

  txtNomeRzSoc.SetFocus;
  DM.tbClientes.Append;
  Editar := False;
end;

procedure TfrmCadClientes.btnPesquisarClick(Sender: TObject);
begin
  frmPesqClientes.ShowModal;
end;

procedure TfrmCadClientes.btnSalvarClick(Sender: TObject);
begin
  if (trim(txtNomeRzSoc.Text) = '') or (trim(txtApelidoFantasia.Text) = '') or (trim(txtCpf.Text) = '') or (trim(txtCpf.Text) = '') or (trim(txtRua.Text) = '') or (trim(txtNumero.Text) = '') or (trim(txtBairro.Text) = '') or (trim(txtCidade.Text) = '') or (trim(txtCep.Text) = '') or (trim(txtTelefone.Text) = '') or (trim(cmbUF.Text) = '') then
  begin
    Application.MessageBox('Preencha Todos os Campos !', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end;

  if (Length(txtCpf.Text) < 11) or (Length(txtCpf.Text) > 14) then
  begin
    Application.MessageBox('Documento Incorreto !', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end;

  if (Length(txtCep.Text) < 8) then
  begin
    Application.MessageBox('CEP Incorreto !', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end;

  if not Editar then
  begin
    DM.qrClientes.Close;
    DM.qrClientes.SQL.Clear;
    DM.qrClientes.SQL.Add('SELECT * FROM clientes WHERE documento = :documento');
    DM.qrClientes.Params.ParamByName('documento').AsString := txtCpf.Text;
    DM.qrClientes.Open;
    DM.qrClientes.Active := True;

    if not DM.qrClientes.IsEmpty then
    begin
      Application.MessageBox('O CPF Informado Já Está Cadastrado !', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
      Abort;
    end;

    DM.qrClientes.Close;
    DM.qrClientes.SQL.Clear;
    DM.qrClientes.SQL.Add('SELECT * FROM clientes WHERE nome_razao = :nome_razao');
    DM.qrClientes.Params.ParamByName('nome_razao').AsString := txtNomeRzSoc.Text;
    DM.qrClientes.Open;
    DM.qrClientes.Active := True;

    if not DM.qrClientes.IsEmpty then
    begin
      Application.MessageBox('Já Existe um Cliente Com Esse Nome/Razão Social !', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
      Abort;
    end;
  end
  else
  begin
    DM.qrClientes.Close;
    DM.qrClientes.SQL.Clear;
    DM.qrClientes.SQL.Add('SELECT * FROM clientes WHERE nome_razao = :nome_razao and id <> :id');
    DM.qrClientes.Params.ParamByName('nome_razao').AsString := txtNomeRzSoc.Text;
    DM.qrClientes.Params.ParamByName('id').AsString := txtID.Text;
    DM.qrClientes.Open;
    DM.qrClientes.Active := True;

    if DM.qrClientes.RecordCount > 0 then
    begin
      Application.MessageBox('O Nome/Razão Social Informado Já Está Cadastrado !', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
      Abort;
    end;

    DM.qrClientes.Close;
    DM.qrClientes.SQL.Clear;
    DM.qrClientes.SQL.Add('SELECT * FROM clientes WHERE documento = :documento and id <> :id');
    DM.qrClientes.Params.ParamByName('documento').AsString := txtCpf.Text;
    DM.qrClientes.Params.ParamByName('id').AsString := txtID.Text;
    DM.qrClientes.Open;
    DM.qrClientes.Active := True;

    if DM.qrClientes.RecordCount > 0 then
    begin
      Application.MessageBox('O Documento Informado Já Está Cadastrado !', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
      Abort;
    end;
  end;

  if Editar then
  begin
    DM.tbClientes.Post;
    Application.MessageBox('Cliente Editado Com Sucesso!', 'Olá', MB_ICONINFORMATION+MB_OK);
  end
  else
  begin
    DM.tbClientes.Post;
    Application.MessageBox('Cliente Cadastrado Com Sucesso!', 'Olá', MB_ICONINFORMATION+MB_OK);
  end;

  btnNovo.Enabled     := True;
  btnEditar.Enabled   := True;
  btnExcluir.Enabled  := True;
  btnSalvar.Enabled   := False;
  btnCancelar.Enabled := False;

  txtNomeRzSoc.ReadOnly := True;
  txtApelidoFantasia.ReadOnly := True;
  txtCpf.ReadOnly := True;
  txtRua.ReadOnly := True;
  txtNumero.ReadOnly := True;
  txtBairro.ReadOnly := True;
  txtCidade.ReadOnly := True;
  txtCep.ReadOnly := True;
  txtTelefone.ReadOnly := True;
  cmbUF.ReadOnly := True;

  dbnavCadClientes.Enabled := True;
  dbnavCadClientes.SetFocus;
end;

procedure TfrmCadClientes.cmbUFKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    Perform(WM_nextdlgctl,0,0);
  end;
end;

procedure TfrmCadClientes.FormActivate(Sender: TObject);
begin
  DM.tbClientes.Active := True;
  DM.tbClientes.Refresh;
  DM.tbClientes.Last;

  btnNovo.Enabled := True;
  btnSalvar.Enabled := False;
  btnCancelar.Enabled := False;
  btnEditar.Enabled := True;
  btnExcluir.Enabled := True;

  txtNomeRzSoc.ReadOnly := True;
  txtApelidoFantasia.ReadOnly := True;
  txtCpf.ReadOnly := True;
  txtRua.ReadOnly := True;
  txtNumero.ReadOnly := True;
  txtBairro.ReadOnly := True;
  txtCidade.ReadOnly := True;
  txtCep.ReadOnly := True;
  txtTelefone.ReadOnly := True;
  cmbUF.ReadOnly := True;

  dbnavCadClientes.Enabled := True;
  dbnavCadClientes.SetFocus;
end;

procedure TfrmCadClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM.tbClientes.Cancel;
end;

procedure TfrmCadClientes.txtApelidoFantasiaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
  begin
    Perform(WM_nextdlgctl,0,0);
  end;
end;

procedure TfrmCadClientes.txtBairroKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    Perform(WM_nextdlgctl,0,0);
  end;
end;

procedure TfrmCadClientes.txtCepKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    Perform(WM_nextdlgctl,0,0);
  end;
end;

procedure TfrmCadClientes.txtCidadeKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    Perform(WM_nextdlgctl,0,0);
  end;
end;

procedure TfrmCadClientes.txtCpfKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    Perform(WM_nextdlgctl,0,0);
  end;
end;

procedure TfrmCadClientes.txtIDKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    Perform(WM_nextdlgctl,0,0);
  end;
end;

procedure TfrmCadClientes.txtNomeRzSocKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    Perform(WM_nextdlgctl,0,0);
  end;
end;

procedure TfrmCadClientes.txtNumeroKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    Perform(WM_nextdlgctl,0,0);
  end;
end;

procedure TfrmCadClientes.txtRuaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    Perform(WM_nextdlgctl,0,0);
  end;
end;

procedure TfrmCadClientes.txtTelefoneKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    Perform(WM_nextdlgctl,0,0);
  end;
end;

end.
