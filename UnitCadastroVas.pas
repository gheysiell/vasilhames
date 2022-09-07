unit UnitCadastroVas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.Mask;

type
  TfrmCadVasilhames = class(TForm)
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    dbnavCadVasilhames: TDBNavigator;
    lblID: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    txtID: TDBEdit;
    txtCapacidade: TDBEdit;
    txtMarca: TDBEdit;
    txtQuantidade: TDBEdit;
    txtDescricao: TDBEdit;
    btnPesquisar: TSpeedButton;
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtDescricaoKeyPress(Sender: TObject; var Key: Char);
    procedure txtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure txtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure txtCapacidadeKeyPress(Sender: TObject; var Key: Char);
    procedure txtIDKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadVasilhames: TfrmCadVasilhames;
  Editar : Boolean;

implementation

{$R *.dfm}

uses UnitDM, UnitMenu, UnitPesqVasilhames;

procedure TfrmCadVasilhames.btnCancelarClick(Sender: TObject);
begin
  btnNovo.Enabled := True;
  btnEditar.Enabled := True;
  btnExcluir.Enabled := True;
  btnSalvar.Enabled := False;
  btnCancelar.Enabled := False;
  dbnavCadVasilhames.Enabled := True;

  txtDescricao.ReadOnly := True;
  txtQuantidade.ReadOnly := True;
  txtMarca.ReadOnly := True;
  txtCapacidade.ReadOnly := True;

  DM.tbVasilhames.Cancel;
  dbnavCadVasilhames.SetFocus;
end;

procedure TfrmCadVasilhames.btnEditarClick(Sender: TObject);
begin
  btnNovo.Enabled := False;
  btnEditar.Enabled := False;
  btnExcluir.Enabled := False;
  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;
  txtDescricao.ReadOnly := False;
  txtQuantidade.ReadOnly := False;
  txtMarca.ReadOnly := False;
  txtCapacidade.ReadOnly := False;
  dbnavCadVasilhames.Enabled := False;
  Editar := True;
  DM.tbVasilhames.Edit;
  txtdescricao.SetFocus;
end;

procedure TfrmCadVasilhames.btnExcluirClick(Sender: TObject);
begin
  DM.qrVasilhames.Close;
  DM.qrVasilhames.SQL.Clear;
  DM.qrVasilhames.SQL.Add('SELECT vasilhame FROM ent_rec WHERE vasilhame = :vasilhame');
  DM.qrVasilhames.Params.ParamByName('vasilhame').AsString := txtDescricao.Text;
  DM.qrVasilhames.Open;
  DM.qrVasilhames.Active := True;

  if not DM.qrVasilhames.IsEmpty then
  begin
    Application.MessageBox('Não é Possível Excluir Esse Vasilhame, Pois Existem Vasilhames a Receber !', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end;

  if (Application.MessageBox('Deseja Realmente Exluir Esse Registro ?', 'Atenção', MB_ICONEXCLAMATION+MB_YESNO)) = mrYes then
  begin
    DM.tbVasilhames.Delete;
    dbnavCadVasilhames.SetFocus;
  end;
end;

procedure TfrmCadVasilhames.btnNovoClick(Sender: TObject);
begin
  dbnavCadVasilhames.Enabled := False;
  btnNovo.Enabled := False;
  btnEditar.Enabled := False;
  btnExcluir.Enabled := False;
  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;
  txtDescricao.ReadOnly := False;
  txtQuantidade.ReadOnly := False;
  txtMarca.ReadOnly := False;
  txtCapacidade.ReadOnly := False;

  txtDescricao.SetFocus;
  DM.tbVasilhames.Append;
  Editar := False;
end;

procedure TfrmCadVasilhames.btnPesquisarClick(Sender: TObject);
begin
  frmPesqVasilhames.ShowModal;
end;

procedure TfrmCadVasilhames.btnSalvarClick(Sender: TObject);
begin
  if (trim(txtDescricao.Text) = '') or (trim(txtQuantidade.Text) = '') or (trim(txtMarca.Text) = '') or (trim(txtCapacidade.Text) = '') then
  begin
    Application.MessageBox('Preencha Todos os Campos !', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end;

  DM.qrVasilhames.Close;
  DM.qrVasilhames.SQL.Clear;
  DM.qrVasilhames.SQL.Add('SELECT * FROM vasilhames WHERE descricao = :descricao and id <> :id');
  DM.qrVasilhames.Params.ParamByName('descricao').AsString := txtDescricao.Text;
  DM.qrVasilhames.Params.ParamByName('id').AsString := txtID.Text;
  DM.qrVasilhames.Open;

  if not DM.qrVasilhames.IsEmpty then
  begin
    Application.MessageBox('A Descrição Informada já Existe!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end;

  if Editar then
  begin
    DM.tbVasilhames.Post;
    Application.MessageBox('Vasilhame Editado Com Sucesso!', 'Olá', MB_ICONINFORMATION+MB_OK);
  end
  else
  begin
    DM.tbVasilhames.Post;
    Application.MessageBox('Vasilhame Cadastrado Com Sucesso!', 'Olá', MB_ICONINFORMATION+MB_OK);
  end;

  btnNovo.Enabled     := True;
  btnEditar.Enabled   := True;
  btnExcluir.Enabled  := True;
  btnSalvar.Enabled   := False;
  btnCancelar.Enabled := False;

  txtDescricao.ReadOnly := True;
  txtQuantidade.ReadOnly := True;
  txtMarca.ReadOnly := True;
  txtCapacidade.ReadOnly := True;
  dbnavCadVasilhames.Enabled := True;
  dbnavCadVasilhames.SetFocus;
end;

procedure TfrmCadVasilhames.FormActivate(Sender: TObject);
begin
  DM.tbVasilhames.Active := True;
  DM.tbVasilhames.Refresh;
  DM.tbVasilhames.Last;
  btnNovo.Enabled := True;
  btnSalvar.Enabled := False;
  btnCancelar.Enabled := False;
  btnEditar.Enabled := True;
  btnExcluir.Enabled := True;
  txtDescricao.ReadOnly := True;
  txtQuantidade.ReadOnly := True;
  txtMarca.ReadOnly := True;
  txtCapacidade.ReadOnly := True;
  dbnavCadVasilhames.Enabled := True;
  dbnavCadVasilhames.SetFocus;
end;

procedure TfrmCadVasilhames.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DM.tbVasilhames.Cancel;
end;

procedure TfrmCadVasilhames.txtCapacidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
  begin
    Perform(WM_nextdlgctl,0,0);
  end;
end;

procedure TfrmCadVasilhames.txtDescricaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
  begin
    Perform(WM_nextdlgctl,0,0);
  end;
end;

procedure TfrmCadVasilhames.txtIDKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    Perform(WM_nextdlgctl,0,0);
  end;
end;

procedure TfrmCadVasilhames.txtMarcaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    Perform(WM_nextdlgctl,0,0);
  end;
end;

procedure TfrmCadVasilhames.txtQuantidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
  begin
    Perform(WM_nextdlgctl,0,0);
  end;
end;

end.
