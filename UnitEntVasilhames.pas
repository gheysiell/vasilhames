unit UnitEntVasilhames;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.Imaging.pngimage;

type
  TfrmEntVasilhames = class(TForm)
    Label1: TLabel;
    cmbVasilhame: TComboBox;
    Label2: TLabel;
    txtQuantidade: TEdit;
    lblDisponiveis: TLabel;
    Label3: TLabel;
    cmbCliente: TComboBox;
    btnLancarMais: TSpeedButton;
    gridVasilhames: TStringGrid;
    btnFinalizarLanc: TSpeedButton;
    pnlFinalizar: TPanel;
    imgFinalizar: TImage;
    procedure FormActivate(Sender: TObject);
    procedure cmbVasilhameSelect(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure btnLancarMaisClick(Sender: TObject);
    procedure btnFinalizarLancClick(Sender: TObject);
    procedure pnlFinalizarClick(Sender: TObject);
    procedure imgFinalizarClick(Sender: TObject);
    procedure pnlFinalizarMouseLeave(Sender: TObject);
    procedure imgFinalizarMouseLeave(Sender: TObject);
    procedure imgFinalizarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlFinalizarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEntVasilhames : TfrmEntVasilhames;
  qtdDisp : Integer;
  ttLanc : Integer;
  compArr : Integer;
  lenArrays : Integer;
  totaisEntregas : Array [1..200, 1..3] of String;

implementation

{$R *.dfm}

uses UnitDM, UnitMenu;

procedure TfrmEntVasilhames.btnFinalizarLancClick(Sender: TObject);
begin
  if Trim(cmbVasilhame.Text) = '' then
  begin
    Application.MessageBox('Selecione o Vasilhame que Deseja Entregar!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if Trim(cmbCliente.Text) = '' then
  begin
    Application.MessageBox('Selecione o Cliente que Deseja Entregar!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if Trim(txtQuantidade.Text) = '' then
  begin
    Application.MessageBox('Selecione a Quantidade que Deseja Entregar!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if (StrToInt(txtQuantidade.Text) < 1) then
  begin
    Application.MessageBox('Digite uma Quantidade Válida!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if StrToInt(txtQuantidade.Text) <= qtdDisp then
  begin
    pnlFinalizar.Enabled := True;
    pnlFinalizar.SetFocus;
    pnlFInalizar.Color := clGradientActiveCaption;
    btnLancarMais.Enabled := False;
    btnFinalizarLanc.Enabled := False;
    lblDisponiveis.Visible := False;

    totaisEntregas[lenArrays, 1] := cmbVasilhame.Text;
    totaisEntregas[lenArrays, 2] := cmbCliente.Text;
    totaisEntregas[lenArrays, 3] := txtQuantidade.Text;

    gridVasilhames.ColCount := 2;
    gridVasilhames.RowCount := lenArrays + 1;
    gridVasilhames.FixedCols := 0;
    gridVasilhames.FixedRows := 1;

    gridVasilhames.Cells[0, 0] := 'VASILHAME';
    gridVasilhames.Cells[1, 0] := 'QUANTIDADE';

    gridVasilhames.Cells[0, lenArrays] := totaisEntregas[lenArrays, 1];
    gridVasilhames.Cells[1, lenArrays] := totaisEntregas[lenArrays, 3];

    gridVasilhames.ColAlignments[1] := taCenter;

    gridVasilhames.ColWidths[0] := 316;
    gridVasilhames.ColWidths[1] := 80;

    lenArrays := lenArrays + 1;
  end
  else
  begin
    Application.MessageBox('Quantidade a Entregar Maior do Que Quantidade Disponível !', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end;
end;

procedure TfrmEntVasilhames.btnLancarMaisClick(Sender: TObject);
begin
  if Trim(cmbVasilhame.Text) = '' then
  begin
    Application.MessageBox('Selecione o Vasilhame que Deseja Entregar!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if Trim(cmbCliente.Text) = '' then
  begin
    Application.MessageBox('Selecione o Cliente que Deseja Entregar!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if Trim(txtQuantidade.Text) = '' then
  begin
    Application.MessageBox('Selecione a Quantidade que Deseja Entregar!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if (StrToInt(txtQuantidade.Text) < 1) then
  begin
    Application.MessageBox('Digite uma Quantidade Válida!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if StrToInt(txtQuantidade.Text) <= qtdDisp then
  begin
    if cmbVasilhame.Items.Count = 2 then
      btnLancarMais.ENabled := False;

    gridVasilhames.Visible := True;
    cmbVasilhame.SetFocus;
    btnFinalizarLanc.Visible := True;
    btnFinalizarLanc.Enabled := True;
    pnlFinalizar.Enabled := False;
    pnlFinalizar.Top := 387;
    frmEntVasilhames.Height := 492;

    totaisEntregas[lenArrays, 1] := cmbVasilhame.Text;
    totaisEntregas[lenArrays, 2] := cmbCliente.Text;
    totaisEntregas[lenArrays, 3] := txtQuantidade.Text;

    cmbVasilhame.Items.Delete(cmbVasilhame.Items.IndexOf(cmbVasilhame.Text));
    cmbVasilhame.itemIndex := -1;
    lblDisponiveis.Visible := False;
    cmbCliente.Enabled := False;
    txtQuantidade.Text := '';

    Top := (frmMenu.Height - Height) div 2;

    gridVasilhames.ColCount := 2;
    gridVasilhames.RowCount := lenArrays + 1;
    gridVasilhames.FixedCols := 0;
    gridVasilhames.FixedRows := 1;

    gridVasilhames.Cells[0, 0] := 'VASILHAME';
    gridVasilhames.Cells[1, 0] := 'QUANTIDADE';

    gridVasilhames.Cells[0, lenArrays] := totaisEntregas[lenArrays, 1];
    gridVasilhames.Cells[1, lenArrays] := totaisEntregas[lenArrays, 3];

    gridVasilhames.ColAlignments[1] := taCenter;

    gridVasilhames.ColWidths[0] := 316;
    gridVasilhames.ColWidths[1] := 80;

    lenArrays := lenArrays + 1;
  end
  else
  begin
    Application.MessageBox('Quantidade a Entregar Maior do Que Quantidade Disponível !', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end;
end;

procedure TfrmEntVasilhames.cmbVasilhameSelect(Sender: TObject);
var
  vasilhame : String;
  qtdVasilhame : Integer;
  i : Integer;
begin
  qtdDisp := 0;
  lblDisponiveis.Visible := True;

  DM.qrVasilhames.Close;
  DM.qrVasilhames.SQl.Clear;
  DM.qrVasilhames.SQl.Add('SELECT (quantidade - quantidade_a_rec) as quantidade FROM vasilhames WHERE descricao = :descricao');
  DM.qrVasilhames.ParamByName('descricao').AsString := cmbVasilhame.Text;
  DM.qrVasilhames.Open;

  qtdDisp := DM.qrVasilhames.FieldByName('quantidade').Value;

  lblDisponiveis.Caption := 'Vasilhames Disponíveis: '+IntToStr(qtdDisp);
end;

procedure TfrmEntVasilhames.FormActivate(Sender: TObject);
var
  cont : Integer;
  i, j : Integer;
begin
  frmEntVasilhames.Height := 300;
  pnlFinalizar.Top := 196;
  cmbCliente.Enabled := True;
  cmbCliente.SetFocus;
  btnFinalizarLanc.Visible := False;
  gridVasilhames.Visible := False;
  btnLancarMais.Enabled := True;

  Top := (frmMenu.Height - Height) div 2;

  cont := 0;
  txtQuantidade.Text := '';
  ttLanc := 1;
  compArr := 1;
  lenArrays := 1;

  DM.qrVasilhames.Close;
  DM.qrVasilhames.SQL.Clear;
  DM.qrVasilhames.SQL.Add('SELECT id, descricao FROM vasilhames WHERE quantidade <> quantidade_a_rec');
  DM.qrVasilhames.Open;
  DM.qrVasilhames.First;

  cmbVasilhame.Items.Clear;
  cmbVasilhame.Items.Add('');

  while not DM.qrVasilhames.Eof do
  begin
    cmbVasilhame.Items[cont] := DM.qrVasilhames.FieldByName('descricao').AsString;
    cont := cont + 1;
    DM.qrVasilhames.Next;
  end;

  if cont = 0 then
  begin
    cmbVasilhame.Items.Clear;
  end;

  cont := 0;

  DM.qrClientes.Close;
  DM.qrClientes.SQL.Clear;
  DM.qrClientes.SQL.Add('SELECT id, nome_razao FROM clientes');
  DM.qrClientes.Open;
  DM.qrClientes.First;

  cmbCliente.Items.Clear;
  cmbCliente.Items.Add('');

  while not DM.qrClientes.Eof do
  begin
    cmbCliente.Items[cont] := DM.qrClientes.FieldByName('nome_razao').AsString;
    cont := cont + 1;
    DM.qrClientes.Next;
  end;

  if cont = 0 then
  begin
    cmbCliente.Items.Clear;
  end;

  if totaisEntregas[1, 1] <> '' then
  begin
    for i := 1 to 200 do
    begin
      for j := 1 to 3 do
      begin
        totaisEntregas[i, j] := '';
      end;
    end;
  end;

end;

procedure TfrmEntVasilhames.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  lblDisponiveis.Visible := False;
end;

procedure TfrmEntVasilhames.imgFinalizarClick(Sender: TObject);
var
  vasDesc, cliNome, temLogo : String;
  qtdVasCliente, qtdVasilhames, i, qtdTotalVas, qtdEstoqueVas, idMax, keyAleatoria, qtdVasqrVas : Integer;
begin

  qtdVasCliente := 0;
  qtdVasilhames := 0;
  qtdTotalVas   := 0;
  qtdEstoqueVas := 0;

  if Trim(cmbVasilhame.Text) = '' then
  begin
    Application.MessageBox('Selecione o Vasilhame que Deseja Entregar!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if Trim(cmbCliente.Text) = '' then
  begin
    Application.MessageBox('Selecione o Cliente que Deseja Entregar!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if Trim(txtQuantidade.Text) = '' then
  begin
    Application.MessageBox('Selecione a Quantidade que Deseja Entregar!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if (StrToInt(txtQuantidade.Text) < 1) then
  begin
    Application.MessageBox('Digite uma Quantidade Válida!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if StrToInt(txtQuantidade.Text) <= qtdDisp then
  begin
    totaisEntregas[lenArrays, 1] := cmbVasilhame.Text;
    totaisEntregas[lenArrays, 2] := cmbCliente.Text;
    totaisEntregas[lenArrays, 3] := txtQuantidade.Text;

    if totaisEntregas[2, 3] = '' then
    begin
      lenArrays := lenArrays + 1;
    end;

    for i := 1 to lenArrays - 1 do
    begin
      DM.qrEntRec.Close;
      DM.qrEntRec.SQL.Clear;
      DM.qrEntRec.SQL.Add('INSERT INTO ent_rec (vasilhame, cliente, quantidade_entregue, quantidade_debito) VALUES (:vasilhame, :cliente, :quantidade_entregue, :quantidade_debito)');
      DM.qrEntRec.Params.ParamByName('vasilhame').Value  := totaisEntregas[i, 1];
      DM.qrEntRec.Params.ParamByName('cliente').Value    := totaisEntregas[i, 2];
      DM.qrEntRec.Params.ParamByName('quantidade_entregue').Value := totaisEntregas[i, 3];
      DM.qrEntRec.Params.ParamByName('quantidade_debito').Value := totaisEntregas[i, 3];
      DM.qrEntRec.ExecSQL;

      DM.qrVasilhames.Close;
      DM.qrVasilhames.SQL.Clear;
      DM.qrVasilhames.SQL.Add('SELECT quantidade_a_rec FROM vasilhames WHERE descricao = :descricao');
      DM.qrVasilhames.ParamByName('descricao').AsString := totaisEntregas[i, 1];
      DM.qrVasilhames.Open;

      qtdVasqrVas := DM.qrVasilhames.FieldByName('quantidade_a_rec').AsInteger;

      DM.qrVasilhames.Close;
      DM.qrVasilhames.SQL.CLear;
      DM.qrVasilhames.SQL.Add('UPDATE vasilhames SET quantidade_a_rec = :quantidade_a_rec WHERE descricao = :descricao');
      DM.qrVasilhames.ParamByName('quantidade_a_rec').AsInteger := qtdVasqrVas + StrToInt(totaisEntregas[i, 3]);
      DM.qrVasilhames.ParamByName('descricao').AsString := totaisEntregas[i, 1];
      DM.qrVasilhames.ExecSQL;
    end;

    DM.qrEntRec.Close;
    DM.qrEntRec.SQL.Clear;
    DM.qrEntRec.SQL.Add('SELECT vasilhame, cliente, quantidade_entregue FROM ent_rec WHERE cliente = :cliente ORDER BY id DESC LIMIT :limit');
    DM.qrEntRec.ParamByName('cliente').AsString := cmbCliente.text;
    DM.qrEntRec.ParamByName('limit').AsString := IntToStr(lenArrays - 1);
    DM.qrEntRec.Open;
    DM.qrEntRec.First;

    DM.qrVasilhames.Close;
    DM.qrVasilhames.SQL.Clear;
    DM.qrVasilhames.SQL.Add('SELECT * FROM vasilhames WHERE descricao = :descricao');
    DM.qrVasilhames.Params.ParamByName('descricao').Value := cmbVasilhame.Text;
    DM.qrVasilhames.Open;
    DM.qrVasilhames.Active := true;

    DM.qrClientes.Close;
    DM.qrClientes.SQL.Clear;
    DM.qrClientes.SQL.Add('SELECT * FROM clientes WHERE nome_razao = :nome_razao');
    DM.qrClientes.Params.ParamByName('nome_razao').Value := cmbCliente.Text;
    DM.qrClientes.Open;
    DM.qrClientes.Active := true;

    temLogo := 'N';

    if FileExists(logo) then
    begin
      temLogo := 'ss';
    end;

    // Abre Relatório
    DM.termoComodato.LoadFromFile('relatorios\termoComodato.fr3');
      DM.termoComodato.Variables['temLogo']     := QuotedStr(temLogo);
      DM.termoComodato.Variables['razaoSoc']    := QuotedStr(razaoSoc);
      DM.termoComodato.Variables['fantasia']    := QuotedStr(fantasia);
      DM.termoComodato.Variables['cnpj']        := QuotedStr(cnpj);
      DM.termoComodato.Variables['inscEst']     := QuotedStr(inscEst);
      DM.termoComodato.Variables['endereco']    := QuotedStr(endereco);
      DM.termoComodato.Variables['cidade_emp']  := QuotedStr(cidade);
      DM.termoComodato.Variables['uf']          := QuotedStr(uf);
      DM.termoComodato.Variables['telefone']    := QuotedStr(telefone);
      DM.termoComodato.Variables['email']       := QuotedStr(email);
      DM.termoComodato.Variables['nome']        := QuotedStr(DM.qrClientes.FieldByName('nome_razao').AsString);
      DM.termoComodato.Variables['cpf']         := QuotedStr(DM.qrClientes.FieldByName('documento').AsString);
      DM.termoComodato.Variables['enderecoCli'] := QuotedStr(DM.qrClientes.FieldByName('rua').AsString);
      DM.termoComodato.Variables['bairro']      := QuotedStr(DM.qrClientes.FieldByName('bairro').AsString);
      DM.termoComodato.Variables['numero']      := QuotedStr(DM.qrClientes.FieldByName('numero').AsString);
      DM.termoComodato.Variables['cidade']      := QuotedStr(DM.qrClientes.FieldByName('cidade').AsString);
      DM.termoComodato.Variables['estado']      := QuotedStr(DM.qrClientes.FieldByName('uf').AsString);
      DM.termoComodato.Variables['vasilhame']   := QuotedStr(cmbVasilhame.Text);
      DM.termoComodato.Variables['quantidade']  := QuotedStr(txtQuantidade.Text);
      DM.termoComodato.Variables['capacidade']  := QuotedStr(DM.qrVasilhames.FieldByName('capacidade').AsString);
    DM.termoComodato.ShowReport;

    frmEntVasilhames.Close;
  end
  else
  begin
    Application.MessageBox('Quantidade a Entregar Maior do Que Quantidade Disponível !', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end;
end;

procedure TfrmEntVasilhames.imgFinalizarMouseLeave(Sender: TObject);
begin
  pnlFInalizar.Color := clCream;
end;

procedure TfrmEntVasilhames.imgFinalizarMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if pnlFinalizar.Enabled = True then
    pnlFInalizar.Color := clGradientActiveCaption;
end;

procedure TfrmEntVasilhames.pnlFinalizarClick(Sender: TObject);
var
  vasDesc, cliNome, temLogo : String;
  qtdVasCliente, qtdVasilhames, i, qtdTotalVas, qtdEstoqueVas, idMax, keyAleatoria, qtdVasqrVas : Integer;
begin

  qtdVasCliente := 0;
  qtdVasilhames := 0;
  qtdTotalVas   := 0;
  qtdEstoqueVas := 0;

  if Trim(cmbVasilhame.Text) = '' then
  begin
    Application.MessageBox('Selecione o Vasilhame que Deseja Entregar!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if Trim(cmbCliente.Text) = '' then
  begin
    Application.MessageBox('Selecione o Cliente que Deseja Entregar!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if Trim(txtQuantidade.Text) = '' then
  begin
    Application.MessageBox('Selecione a Quantidade que Deseja Entregar!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if (StrToInt(txtQuantidade.Text) < 1) then
  begin
    Application.MessageBox('Digite uma Quantidade Válida!', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if StrToInt(txtQuantidade.Text) <= qtdDisp then
  begin
    totaisEntregas[lenArrays, 1] := cmbVasilhame.Text;
    totaisEntregas[lenArrays, 2] := cmbCliente.Text;
    totaisEntregas[lenArrays, 3] := txtQuantidade.Text;

    if totaisEntregas[2, 3] = '' then
    begin
      lenArrays := lenArrays + 1;
    end;

    for i := 1 to lenArrays - 1 do
    begin
      DM.qrEntRec.Close;
      DM.qrEntRec.SQL.Clear;
      DM.qrEntRec.SQL.Add('INSERT INTO ent_rec (vasilhame, cliente, quantidade_entregue, quantidade_debito) VALUES (:vasilhame, :cliente, :quantidade_entregue, :quantidade_debito)');
      DM.qrEntRec.Params.ParamByName('vasilhame').Value  := totaisEntregas[i, 1];
      DM.qrEntRec.Params.ParamByName('cliente').Value    := totaisEntregas[i, 2];
      DM.qrEntRec.Params.ParamByName('quantidade_entregue').Value := totaisEntregas[i, 3];
      DM.qrEntRec.Params.ParamByName('quantidade_debito').Value := totaisEntregas[i, 3];
      DM.qrEntRec.ExecSQL;

      DM.qrVasilhames.Close;
      DM.qrVasilhames.SQL.Clear;
      DM.qrVasilhames.SQL.Add('SELECT quantidade_a_rec FROM vasilhames WHERE descricao = :descricao');
      DM.qrVasilhames.ParamByName('descricao').AsString := totaisEntregas[i, 1];
      DM.qrVasilhames.Open;

      qtdVasqrVas := DM.qrVasilhames.FieldByName('quantidade_a_rec').AsInteger;

      DM.qrVasilhames.Close;
      DM.qrVasilhames.SQL.CLear;
      DM.qrVasilhames.SQL.Add('UPDATE vasilhames SET quantidade_a_rec = :quantidade_a_rec WHERE descricao = :descricao');
      DM.qrVasilhames.ParamByName('quantidade_a_rec').AsInteger := qtdVasqrVas + StrToInt(totaisEntregas[i, 3]);
      DM.qrVasilhames.ParamByName('descricao').AsString := totaisEntregas[i, 1];
      DM.qrVasilhames.ExecSQL;
    end;

    DM.qrEntRec.Close;
    DM.qrEntRec.SQL.Clear;
    DM.qrEntRec.SQL.Add('SELECT vasilhame, cliente, quantidade_entregue FROM ent_rec WHERE cliente = :cliente ORDER BY id DESC LIMIT :limit');
    DM.qrEntRec.ParamByName('cliente').AsString := cmbCliente.text;
    DM.qrEntRec.ParamByName('limit').AsString := IntToStr(lenArrays - 1);
    DM.qrEntRec.Open;
    DM.qrEntRec.First;

    DM.qrVasilhames.Close;
    DM.qrVasilhames.SQL.Clear;
    DM.qrVasilhames.SQL.Add('SELECT * FROM vasilhames WHERE descricao = :descricao');
    DM.qrVasilhames.Params.ParamByName('descricao').Value := cmbVasilhame.Text;
    DM.qrVasilhames.Open;
    DM.qrVasilhames.Active := true;

    DM.qrClientes.Close;
    DM.qrClientes.SQL.Clear;
    DM.qrClientes.SQL.Add('SELECT * FROM clientes WHERE nome_razao = :nome_razao');
    DM.qrClientes.Params.ParamByName('nome_razao').Value := cmbCliente.Text;
    DM.qrClientes.Open;
    DM.qrClientes.Active := true;

    temLogo := 'N';

    if FileExists(logo) then
    begin
      temLogo := 'ss';
    end;

    // Abre Relatório
    DM.termoComodato.LoadFromFile('relatorios\termoComodato.fr3');
      DM.termoComodato.Variables['temLogo']     := QuotedStr(temLogo);
      DM.termoComodato.Variables['razaoSoc']    := QuotedStr(razaoSoc);
      DM.termoComodato.Variables['fantasia']    := QuotedStr(fantasia);
      DM.termoComodato.Variables['cnpj']        := QuotedStr(cnpj);
      DM.termoComodato.Variables['inscEst']     := QuotedStr(inscEst);
      DM.termoComodato.Variables['endereco']    := QuotedStr(endereco);
      DM.termoComodato.Variables['cidade_emp']  := QuotedStr(cidade);
      DM.termoComodato.Variables['uf']          := QuotedStr(uf);
      DM.termoComodato.Variables['telefone']    := QuotedStr(telefone);
      DM.termoComodato.Variables['email']       := QuotedStr(email);
      DM.termoComodato.Variables['nome']        := QuotedStr(DM.qrClientes.FieldByName('nome_razao').AsString);
      DM.termoComodato.Variables['cpf']         := QuotedStr(DM.qrClientes.FieldByName('documento').AsString);
      DM.termoComodato.Variables['enderecoCli'] := QuotedStr(DM.qrClientes.FieldByName('rua').AsString);
      DM.termoComodato.Variables['bairro']      := QuotedStr(DM.qrClientes.FieldByName('bairro').AsString);
      DM.termoComodato.Variables['numero']      := QuotedStr(DM.qrClientes.FieldByName('numero').AsString);
      DM.termoComodato.Variables['cidade']      := QuotedStr(DM.qrClientes.FieldByName('cidade').AsString);
      DM.termoComodato.Variables['estado']      := QuotedStr(DM.qrClientes.FieldByName('uf').AsString);
      DM.termoComodato.Variables['vasilhame']   := QuotedStr(cmbVasilhame.Text);
      DM.termoComodato.Variables['quantidade']  := QuotedStr(txtQuantidade.Text);
      DM.termoComodato.Variables['capacidade']  := QuotedStr(DM.qrVasilhames.FieldByName('capacidade').AsString);
    DM.termoComodato.ShowReport;

    frmEntVasilhames.Close;
  end
  else
  begin
    Application.MessageBox('Quantidade a Entregar Maior do Que Quantidade Disponível !', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end;
end;

procedure TfrmEntVasilhames.pnlFinalizarMouseLeave(Sender: TObject);
begin
  pnlFInalizar.Color := clCream;
end;

procedure TfrmEntVasilhames.pnlFinalizarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if pnlFinalizar.Enabled = True then
    pnlFInalizar.Color := clGradientActiveCaption;
end;

procedure TfrmEntVasilhames.txtQuantidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9',#8, ^V, ^C, ^X]) then
  begin
    Key := #0;
  end;
end;

end.
