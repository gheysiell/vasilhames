unit UnitVasBonus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmVasExtras = class(TForm)
    Label1: TLabel;
    lblCliente: TLabel;
    cmbVasilhames: TComboBox;
    Label3: TLabel;
    btnConfirmar: TSpeedButton;
    lblAdvertencia: TLabel;
    cmbClientes: TComboBox;
    Label2: TLabel;
    txtQuantidade: TEdit;
    btnDevVasExtras: TSpeedButton;
    lblMsg: TLabel;
    lblVasilhames: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure cmbVasilhamesSelect(Sender: TObject);
    procedure cmbClientesSelect(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnDevVasExtrasClick(Sender: TObject);
    procedure txtQuantidadeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVasExtras: TfrmVasExtras;
  entOuRec : Boolean;
  qtdARec, PosId : Integer;
  p_id : String;

implementation

{$R *.dfm}

uses UnitDM, UnitRecVasilhames, UnitMenu;

procedure TfrmVasExtras.btnConfirmarClick(Sender: TObject);
var
  id, vasilhame : String;
  qtdVasEst, qtdVasEnt, varQtdd, qtdVasDbt : Integer;
begin
  if cmbClientes.Text = '' then
  begin
    Application.MessageBox('Informe o Cliente!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if cmbVasilhames.Text = '' then
  begin
    Application.MessageBox('Informe o Vasilhame!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if txtQuantidade.Text = '' then
  begin
    Application.MessageBox('Informe a Quantidade!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if lblAdvertencia.Visible = True then
  begin
    Application.MessageBox('Não foi Possível Realizar a Operação!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if (StrToInt(txtQuantidade.Text) > qtdARec) and (entOuRec = False) then
  begin
    Application.MessageBox('Quantidade a Devolver Maior Que Quantidade de Vasilhames!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if StrToInt(txtQuantidade.Text) <= 0 then
  begin
    Application.MessageBox('Quantidade Inválida!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if entOuRec then
  begin
    DM.qrEntRec.Close;
    DM.qrEntRec.SQL.Clear;
    DM.qrEntRec.SQL.Add('INSERT INTO ent_rec (vasilhame, cliente, quantidade_recebida, quantidade_debito, bonus) VALUES (:vasilhame, :cliente, :quantidade_recebida, :quantidade_debito, :bonus)');
    DM.qrEntRec.ParamByName('vasilhame').AsString := cmbVasilhames.Text;
    DM.qrEntRec.ParamByName('cliente').AsString := cmbClientes.Text;
    DM.qrEntRec.ParamByName('quantidade_recebida').AsInteger := StrToInt(txtQuantidade.Text);
    DM.qrEntRec.ParamByName('quantidade_debito').AsInteger := StrToInt(txtQuantidade.Text) * -1;
    DM.qrEntRec.ParamByName('bonus').AsString := 'S';
    DM.qrEntRec.ExecSQL;

    //*************************

    DM.qrVasilhames.Close;
    DM.qrVasilhames.SQL.Clear;
    DM.qrVasilhames.SQL.Add('SELECT quantidade FROM vasilhames WHERE descricao = :descricao');
    DM.qrVasilhames.ParamByName('descricao').AsString := cmbVasilhames.Text;
    DM.qrVasilhames.Open;

    qtdVasEst := DM.qrVasilhames.FieldByName('quantidade').AsInteger;

    DM.qrVasilhames.Close;
    DM.qrVasilhames.SQL.Clear;
    DM.qrVasilhames.SQL.Add('UPDATE vasilhames SET quantidade = :quantidade WHERE descricao = :descricao');
    DM.qrVasilhames.ParamByName('descricao').AsString := cmbVasilhames.Text;
    DM.qrVasilhames.ParamByName('quantidade').AsInteger := qtdVasEst + strToInt(txtQuantidade.Text);
    DM.qrVasilhames.ExecSQL;

    Application.MessageBox('Vasilhames extras Recebidos com Sucesso!', 'Olá', MB_ICONINFORMATION+MB_OK);
    frmVasExtras.Close;
  end
  else
  begin
    DM.qrEntRec.Close;
    DM.qrEntRec.SQL.Clear;
    DM.qrEntRec.SQL.Add('SELECT vasilhame, quantidade_recebida, quantidade_debito FROM ent_rec WHERE id = :id');
    DM.qrEntRec.ParamByName('id').AsString := p_id;
    DM.qrEntRec.Open;

    qtdVasEnt := DM.qrEntRec.FieldByName('quantidade_recebida').AsInteger;
    qtdVasDbt := DM.qrEntRec.FieldByName('quantidade_debito').AsInteger;
    vasilhame := DM.qrEntRec.FieldByName('vasilhame').AsString;

    DM.qrEntRec.Close;
    DM.qrEntRec.SQL.Clear;
    DM.qrEntRec.SQl.Add('UPDATE ent_rec SET quantidade_recebida = :quantidade_recebida, quantidade_debito = :quantidade_debito WHERE id = :id');
    DM.qrEntRec.ParamByName('id').AsString := p_id;
    DM.qrEntRec.ParamByName('quantidade_recebida').AsInteger := qtdVasEnt - StrToInt(txtQuantidade.Text);
    DM.qrEntRec.ParamByName('quantidade_debito').AsInteger := qtdVasDbt + StrToInt(txtQuantidade.Text);
    DM.qrEntRec.ExecSQL;

    //*************************

    DM.qrVasilhames.Close;
    DM.qrVasilhames.SQL.Clear;
    DM.qrVasilhames.SQL.Add('SELECT quantidade FROM vasilhames WHERE descricao = :descricao');
    DM.qrVasilhames.ParamByName('descricao').AsString := vasilhame;
    DM.qrVasilhames.Open;

    qtdVasEst := DM.qrVasilhames.FieldByName('quantidade').AsInteger;

    DM.qrVasilhames.Close;
    DM.qrVasilhames.SQL.Clear;
    DM.qrVasilhames.SQL.Add('UPDATE vasilhames SET quantidade = :quantidade WHERE descricao = :descricao');
    DM.qrVasilhames.ParamByName('descricao').AsString := vasilhame;
    DM.qrVasilhames.ParamByName('quantidade').AsInteger := qtdVasEst - StrToInt(txtQuantidade.Text);
    DM.qrVasilhames.ExecSQL;

    Application.MessageBox('Vasilhames extras devolvidos com Sucesso!', 'Olá', MB_ICONINFORMATION+MB_OK);
    frmVasExtras.Close;
  end;
end;

procedure TfrmVasExtras.btnDevVasExtrasClick(Sender: TObject);
var
  cont : Integer;
begin
  cmbClientes.Items.Clear;
  cmbClientes.Items.Add('');
  cmbVasilhames.Items.Clear;
  cmbVasilhames.Items.Add('');
  lblAdvertencia.Visible := False;

  entOuRec := False;
  txtQuantidade.Text := '';

  cont := 0;

  DM.qrEntRec.Close;
  DM.qrEntRec.SQL.Clear;
  DM.qrEntRec.SQL.Add('SELECT cliente FROM ent_rec WHERE bonus = :bonus GROUP BY cliente');
  DM.qrEntRec.ParamByName('bonus').AsString := 'S';
  DM.qrEntRec.Open;
  DM.qrEntRec.First;

  while not DM.qrEntRec.Eof do
  begin
    cmbClientes.Items[cont] := DM.qrEntRec.FieldByName('cliente').AsString;
    cont := cont + 1;
    DM.qrEntRec.Next;
  end;

  cmbVasilhames.Enabled := False;
  txtQuantidade.Enabled := False;
  btnDevVasExtras.Enabled := False;
  lblMsg.Visible := True;
end;

procedure TfrmVasExtras.cmbClientesSelect(Sender: TObject);
var
  cont : Integer;
begin
  if entOuRec = False then
  begin
    cont := 0;

    DM.qrEntRec.Close;
    DM.qrEntRec.SQL.Clear;
    DM.qrEntRec.SQL.Add('SELECT id, vasilhame FROM ent_rec WHERE cliente = :cliente AND bonus = :bonus AND quantidade_debito <> 0');
    DM.qrEntRec.ParamByName('cliente').AsString := cmbClientes.Text;
    DM.qrEntRec.ParamByName('bonus').AsString := 'S';
    DM.qrEntRec.Open;

    while not DM.qrEntRec.Eof do
    begin
      cmbVasilhames.Items[cont] := DM.qrEntRec.FieldByName('id').AsString +' -- '+ DM.qrEntRec.FieldByName('vasilhame').AsString;
      cont := cont + 1;
      DM.qrEntRec.Next;
    end;

    cmbVasilhames.Enabled := True;
  end
  else
  begin
    if cmbVasilhames.Text <> '' then
    begin
      DM.qrEntRec.Close;
      DM.qrEntRec.SQL.Clear;
      DM.qrEntRec.SQL.Add('SELECT id, SUM(quantidade_debito) as quantidade_debito FROM ent_rec WHERE cliente = :cliente AND vasilhame = :vasilhame AND bonus = :bonus');
      DM.qrEntRec.ParamByName('cliente').AsString := cmbClientes.Text;
      DM.qrEntRec.ParamByName('vasilhame').AsString := cmbVasilhames.Text;
      DM.qrEntRec.ParamByName('bonus').AsString := 'N';
      DM.qrEntRec.Open;

      if DM.qrEntRec.FieldByName('quantidade_debito').AsInteger < 1 then
      begin
        lblAdvertencia.Visible := False;

        DM.qrEntRec.Close;
        DM.qrEntRec.SQL.Clear;
        DM.qrEntRec.SQL.Add('SELECT vasilhame FROM ent_rec WHERE cliente = :cliente AND bonus = :bonus');
        DM.qrEntRec.ParamByName('cliente').AsString := cmbClientes.Text;
        DM.qrEntRec.ParamByName('bonus').AsString := 'S';
        DM.qrEntRec.Open;

        cont := 0;

        while not DM.qrEntRec.Eof do
        begin
          cmbVasilhames.Items[cont] := DM.qrEntRec.FieldByName('vasilhame').AsString;
          cont := cont + 1;
          DM.qrEntRec.Next;
        end;
      end
      else
      begin
        lblAdvertencia.Visible := True;
        lblAdvertencia.Caption := 'Falha: Primeiro, entregue os vasilhames desse cliente: ('+ DM.qrEntRec.FieldByName('quantidade_debito').AsString+ ')';
      end;
    end;
  end;
end;

procedure TfrmVasExtras.cmbVasilhamesSelect(Sender: TObject);
var
  id : String;
begin
  if entOuRec then
  begin
    DM.qrEntRec.Close;
    DM.qrEntRec.SQL.Clear;
    DM.qrEntRec.SQL.Add('SELECT id, SUM(quantidade_debito) as quantidade_debito FROM ent_rec WHERE cliente = :cliente AND vasilhame = :vasilhame AND bonus = :bonus');
    DM.qrEntRec.ParamByName('cliente').AsString := cmbClientes.Text;
    DM.qrEntRec.ParamByName('vasilhame').AsString := cmbVasilhames.Text;
    DM.qrEntRec.ParamByName('bonus').AsString := 'N';
    DM.qrEntRec.Open;

    if DM.qrEntRec.FieldByName('quantidade_debito').AsInteger < 1 then
    begin
      lblAdvertencia.Visible := False;
    end
    else
    begin
      lblAdvertencia.Visible := True;
      lblAdvertencia.Caption := 'Falha: Primeiro, entregue os vasilhames desse cliente: ('+ DM.qrEntRec.FieldByName('quantidade_debito').AsString+ ')';
    end;
  end
  else
  begin
    PosId := Pos(' -- ', Trim(cmbVasilhames.Text));

    id := Trim(cmbVasilhames.Text);

    id := Copy(id, 1, PosId);

    p_id := id;

    DM.qrEntRec.Close;
    DM.qrEntRec.SQL.Clear;
    DM.qrEntRec.SQL.Add('SELECT quantidade_recebida FROM ent_rec WHERE id = :id');
    DM.qrEntRec.ParamByName('id').AsString := id;
    DM.qrEntRec.Open;

    qtdARec := DM.qrEntRec.FieldByName('quantidade_recebida').AsInteger;

    lblVasilhames.Visible := True;
    lblVasilhames.Caption := 'Vas. Extras a Devolver: ' + IntToStr(qtdARec);
    txtQuantidade.Enabled := True;
  end;
end;

procedure TfrmVasExtras.FormActivate(Sender: TObject);
var
  cont : Integer;
begin
  cmbClientes.SetFocus;
  lblAdvertencia.Visible := False;
  txtQuantidade.Text := '';
  lblMsg.Visible := False;
  cmbVasilhames.Enabled := True;
  txtQuantidade.Enabled := True;
  btnDevVasExtras.Enabled := True;
  lblVasilhames.Visible := False;
  qtdARec := 0;

  entOuRec := True;
  cont := 0;

  DM.qrVasilhames.Close;
  DM.qrVasilhames.SQL.Clear;
  DM.qrVasilhames.SQL.Add('SELECT descricao FROM vasilhames');
  DM.qrVasilhames.Open;
  DM.qrVasilhames.First;

  while not DM.qrVasilhames.Eof do
  begin
    cmbVasilhames.Items[cont] := DM.qrVasilhames.FieldByName('descricao').AsString;
    cont := cont + 1;
    DM.qrVasilhames.Next;
  end;

  cont := 0;

  DM.qrClientes.Close;
  DM.qrClientes.SQL.Clear;
  DM.qrClientes.SQL.Add('SELECT id, nome_razao FROM clientes');
  DM.qrClientes.Open;
  DM.qrClientes.First;

  while not DM.qrClientes.Eof do
  begin
    cmbClientes.Items[cont] := DM.qrClientes.FieldByName('nome_razao').AsString;
    cont := cont + 1;
    DM.qrClientes.Next;
  end;
end;

procedure TfrmVasExtras.txtQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0' .. '9', #8, ^V, ^C, ^X]) then
  begin
    Key := #0;
  end;
end;

end.
