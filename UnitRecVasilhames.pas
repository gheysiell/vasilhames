unit UnitRecVasilhames;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmRecVasilhames = class(TForm)
    Label1: TLabel;
    cmbCliente: TComboBox;
    dbgrdVasComCli: TDBGrid;
    Label2: TLabel;
    Label3: TLabel;
    pnlFinalizar: TPanel;
    imgFinalizar: TImage;
    Label4: TLabel;
    grdVasaEnt: TStringGrid;
    btnLancarMais: TSpeedButton;
    Label5: TLabel;
    Shape1: TShape;
    lbl_id_Nome: TLabel;
    txtQuantidade: TEdit;
    btnConfEdiQtd: TSpeedButton;
    btnCancEdiQtd: TSpeedButton;
    btnVasExtras: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure btnEmitirClick(Sender: TObject);
    procedure txtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbClienteSelect(Sender: TObject);
    procedure pnlFinalizarClick(Sender: TObject);
    procedure imgFinalizarClick(Sender: TObject);
    procedure pnlFinalizarMouseLeave(Sender: TObject);
    procedure imgFinalizarMouseLeave(Sender: TObject);
    procedure imgFinalizarMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure pnlFinalizarMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure dbgrdVasComCliDblClick(Sender: TObject);
    procedure btnLancarMaisClick(Sender: TObject);
    procedure grdVasaEntDblClick(Sender: TObject);
    procedure btnCancEdiQtdClick(Sender: TObject);
    procedure btnConfEdiQtdClick(Sender: TObject);
    procedure btnVasExtrasClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRecVasilhames: TfrmRecVasilhames;
  qtdRec: Integer;
  qtdRecCli: Integer;
  lenArrays: Integer;
  linha: Integer;
  quantidade: String;
  totaisRecebimentos: Array [1 .. 200, 1 .. 3] of String;
  qtdInicial: Array [1 .. 200, 1 .. 2] of String;

implementation

{$R *.dfm}

uses UnitDM, UnitMenu, UnitVasBonus;

procedure TfrmRecVasilhames.btnCancEdiQtdClick(Sender: TObject);
begin
  txtQuantidade.Visible := False;
  lbl_id_Nome.Visible := False;
  btnConfEdiQtd.Visible := False;
  btnCancEdiQtd.Visible := False;
end;

procedure TfrmRecVasilhames.btnConfEdiQtdClick(Sender: TObject);
var
  i, quantidade, ttQtdVasComCli : Integer;
begin
  if Trim(txtQuantidade.Text) = '' then
  begin
    Application.MessageBox('Informe um Valor !', 'Atenção',
      MB_ICONEXCLAMATION + MB_OK);
    Abort;
  end
  else if strToInt(txtQuantidade.Text) > strToInt(qtdInicial[linha, 2]) then
  begin
    Application.MessageBox('Quantidade Maior Que Disponível !', 'Atenção', MB_ICONEXCLAMATION+MB_OK);
    Abort;
  end
  else if strToInt(txtQuantidade.Text) < 1 then
  begin
    Application.MessageBox('Informe uma Quantidade Válida !', 'Atenção',
      MB_ICONEXCLAMATION + MB_OK);
    Abort;
  end
  else
  begin
    totaisRecebimentos[linha, 3] := txtQuantidade.Text;

    grdVasaEnt.Cells[2, linha] := totaisRecebimentos[linha, 3];

    txtQuantidade.Visible := False;
    lbl_id_Nome.Visible := False;
    btnConfEdiQtd.Visible := False;
    btnCancEdiQtd.Visible := False;
  end;
end;

procedure TfrmRecVasilhames.btnEmitirClick(Sender: TObject);
var
  vasDesc, cliNome, temLogo: String;
  qtdVasCliente, qtdVasilhames, qtdAntVas: Integer;
begin
  if (cmbCliente.Text = '') then
  begin
    Application.MessageBox('Selecione o Cliente !', 'Atenção',
      MB_ICONEXCLAMATION + MB_OK);
    Abort;
  end
  else
  begin
    temLogo := 'N';

    if FileExists(logo) then
    begin
      temLogo := 'ss';
    end;

    // Abre Relatório
    DM.termoRecebimento.LoadFromFile('Relatorios\reciboRecebimento.fr3');
    DM.termoRecebimento.Variables['temLogo'] := QuotedStr(temLogo);
    DM.termoRecebimento.Variables['razaoSoc'] := QuotedStr(razaoSoc);
    DM.termoRecebimento.Variables['fantasia'] := QuotedStr(fantasia);
    DM.termoRecebimento.Variables['cnpj'] := QuotedStr(cnpj);
    DM.termoRecebimento.Variables['inscEst'] := QuotedStr(inscEst);
    DM.termoRecebimento.Variables['endereco'] := QuotedStr(endereco);
    DM.termoRecebimento.Variables['cidade_emp'] := QuotedStr(cidade);
    DM.termoRecebimento.Variables['uf'] := QuotedStr(uf);
    DM.termoRecebimento.Variables['telefone'] := QuotedStr(telefone);
    DM.termoRecebimento.Variables['email'] := QuotedStr(email);
    DM.termoRecebimento.Variables['nome'] := QuotedStr(DM.qrClientes.FieldByName('nome_razao').AsString);
    DM.termoRecebimento.Variables['cpf'] := QuotedStr(DM.qrClientes.FieldByName('documento').AsString);
    DM.termoRecebimento.Variables['enderecoCli'] := QuotedStr(DM.qrClientes.FieldByName('rua').AsString);
    DM.termoRecebimento.Variables['bairro'] := QuotedStr(DM.qrClientes.FieldByName('bairro').AsString);
    DM.termoRecebimento.Variables['numero'] := QuotedStr(DM.qrClientes.FieldByName('numero').AsString);
    DM.termoRecebimento.Variables['cidade'] := QuotedStr(DM.qrClientes.FieldByName('cidade').AsString);
    DM.termoRecebimento.Variables['estado'] := QuotedStr(DM.qrClientes.FieldByName('uf').AsString);
    DM.termoRecebimento.Variables['capacidade'] := QuotedStr(DM.qrVasilhames.FieldByName('capacidade').AsString);
    DM.termoRecebimento.ShowReport;

    frmRecVasilhames.Close;
  end;
end;

procedure TfrmRecVasilhames.cmbClienteSelect(Sender: TObject);
var
  i, j: Integer;
begin
  dbgrdVasComCli.Enabled := True;
  pnlFinalizar.Enabled := False;

  DM.qrEntRec.Close;
  DM.qrEntRec.SQL.Clear;
  DM.qrEntRec.SQL.Add('SELECT id, vasilhame, cliente, quantidade_debito FROM ent_rec WHERE cliente = :cliente AND quantidade_debito <> 0 AND bonus = :bonus');
  DM.qrEntRec.ParamByName('cliente').AsString := cmbCliente.Text;
  DM.qrEntRec.ParamByName('bonus').AsString := 'N';
  DM.qrEntRec.Open;

  dbgrdVasComCli.DataSource := DM.dsQrEntRec;

  if totaisRecebimentos[1, 1] <> '' then
  begin
    for i := 1 to 200 do
    begin
      for j := 1 to 3 do
      begin
        totaisRecebimentos[i, j] := '';
      end;
    end;
  end;

  grdVasaEnt.RowCount := 0;
  lenArrays := 1;
  dbgrdVasComCli.Enabled := True;
  btnLancarMais.Enabled := True;
  btnVasExtras.Visible := False;
end;

procedure TfrmRecVasilhames.dbgrdVasComCliDblClick(Sender: TObject);
var
  i, Y: Integer;
begin
  pnlFinalizar.Enabled := True;
  grdVasaEnt.Enabled := True;

  totaisRecebimentos[lenArrays, 1] := dbgrdVasComCli.Fields[0].Value;
  totaisRecebimentos[lenArrays, 2] := dbgrdVasComCli.Fields[1].Value;
  totaisRecebimentos[lenArrays, 3] := dbgrdVasComCli.Fields[2].Value;

  qtdInicial[lenArrays, 1] := dbgrdVasComCli.Fields[0].Value;
  qtdInicial[lenArrays, 2] := dbgrdVasComCli.Fields[2].Value;

  if totaisRecebimentos[2, 1] <> '' then
  begin
    Y := lenArrays - 1;
    for i := Y downto 1 do
    begin
      if totaisRecebimentos[lenArrays, 1] = totaisRecebimentos[i, 1] then
      begin
        Application.MessageBox('Você já Selecionou Esse Vasilhame !', 'Atenção',
          MB_ICONEXCLAMATION + MB_OK);
        Abort;
      end;
    end;
  end;

  grdVasaEnt.ColCount := 3;
  grdVasaEnt.RowCount := lenArrays + 1;

  grdVasaEnt.Cells[0, 0] := 'ID';
  grdVasaEnt.Cells[1, 0] := 'VASILHAME';
  grdVasaEnt.Cells[2, 0] := 'QUANTIDADE';

  grdVasaEnt.Cells[0, lenArrays] := totaisRecebimentos[lenArrays, 1];
  grdVasaEnt.Cells[1, lenArrays] := totaisRecebimentos[lenArrays, 2];
  grdVasaEnt.Cells[2, lenArrays] := totaisRecebimentos[lenArrays, 3];

  grdVasaEnt.ColAlignments[0] := taCenter;
  grdVasaEnt.ColAlignments[2] := taCenter;

  grdVasaEnt.ColWidths[0] := 50;
  grdVasaEnt.ColWidths[1] := 245;
  grdVasaEnt.ColWidths[2] := 80;

  lenArrays := lenArrays + 1;
end;

procedure TfrmRecVasilhames.FormActivate(Sender: TObject);
var
  cont, i, j: Integer;
begin
  cmbCliente.Enabled := True;
  cmbCliente.SetFocus;

  grdVasaEnt.Enabled := False;
  btnLancarMais.Enabled := False;
  dbgrdVasComCli.Enabled := False;
  pnlFinalizar.Enabled := False;

  dbgrdVasComCli.DataSource := Nil;

  Top := (frmMenu.Height - Height) div 2;

  txtQuantidade.Visible := False;
  lbl_id_Nome.Visible := False;
  btnConfEdiQtd.Visible := False;
  btnCancEdiQtd.Visible := False;
  btnVasExtras.Visible := True;

  cont := 0;
  lenArrays := 1;

  cmbCliente.Items.Clear;
  cmbCliente.Items.Add('');

  DM.qrEntRec.Close;
  DM.qrEntRec.SQL.Clear;
  DM.qrEntRec.SQL.Add('SELECT cliente FROM ent_rec WHERE quantidade_entregue <> quantidade_recebida AND bonus = :bonus GROUP BY cliente');
  DM.qrEntRec.ParamByName('bonus').AsString := 'N';
  DM.qrEntRec.Open;
  DM.qrEntRec.First;

  while not DM.qrEntRec.Eof do
  begin
    cmbCliente.Items[cont] := DM.qrEntRec.FieldByName('cliente').AsString;
    cont := cont + 1;
    DM.qrEntRec.Next;
  end;

  if cont = 0 then
  begin
    cmbCliente.Items.Clear;
  end;

  if totaisRecebimentos[1, 1] <> '' then
  begin
    for i := 1 to 200 do
    begin
      for j := 1 to 3 do
      begin
        totaisRecebimentos[i, j] := '';
      end;
    end;
  end;

  grdVasaEnt.ColCount := 3;
  grdVasaEnt.RowCount := 1;

  grdVasaEnt.Cells[0, 0] := 'ID';
  grdVasaEnt.Cells[1, 0] := 'VASILHAME';
  grdVasaEnt.Cells[2, 0] := 'QUANTIDADE';

  grdVasaEnt.ColWidths[0] := 50;
  grdVasaEnt.ColWidths[1] := 245;
  grdVasaEnt.ColWidths[2] := 80;
end;

procedure TfrmRecVasilhames.grdVasaEntDblClick(Sender: TObject);
var
  idVasilhame: String;
begin
  txtQuantidade.Visible := True;
  lbl_id_Nome.Visible := True;
  btnConfEdiQtd.Visible := True;
  btnCancEdiQtd.Visible := True;

  lbl_id_Nome.Width := 150;
  txtQuantidade.Height := 27;

  linha := grdVasaEnt.Row;
  idVasilhame := grdVasaEnt.Cells[0, linha] + ' - ' + grdVasaEnt.Cells[1, linha];
  quantidade := grdVasaEnt.Cells[2, linha];
  lbl_id_Nome.Caption := idVasilhame;
  txtQuantidade.Text := quantidade;
  txtQuantidade.SetFocus;
end;

procedure TfrmRecVasilhames.imgFinalizarClick(Sender: TObject);
var
  temLogo, vasilhame : String;
  i, quantidade_dbt, qtdVasilhames, qtdVasqrVas, quantidade_rec : Integer;
begin
  for i := 1 to lenArrays - 1 do
  begin
    DM.qrEntRec.Close;
    DM.qrEntRec.SQL.Clear;
    DM.qrEntRec.SQL.Add('SELECT quantidade_recebida, quantidade_debito FROM ent_rec WHERE id = :id');
    DM.qrEntRec.ParamByName('id').AsString := totaisRecebimentos[i, 1];
    DM.qrEntRec.Open;

    quantidade_dbt := DM.qrEntRec.FieldByName('quantidade_debito').AsInteger;
    quantidade_rec := DM.qrEntRec.FieldByName('quantidade_recebida').AsInteger;

    DM.qrEntRec.Close;
    DM.qrEntRec.SQL.Clear;
    DM.qrEntRec.SQL.Add('UPDATE ent_rec SET quantidade_recebida = :quantidade_recebida, quantidade_debito = :quantidade_debito WHERE id = :id');
    DM.qrEntRec.ParamByName('quantidade_recebida').AsInteger := quantidade_rec + strToInt(totaisRecebimentos[i, 3]);
    DM.qrEntRec.ParamByName('quantidade_debito').AsInteger := quantidade_dbt - strToInt(totaisRecebimentos[i, 3]);
    DM.qrEntRec.ParamByName('id').AsString := totaisRecebimentos[i, 1];
    DM.qrEntRec.ExecSQL;

    DM.qrVasilhames.Close;
    DM.qrVasilhames.SQL.Clear;
    DM.qrVasilhames.SQL.Add('SELECT quantidade_a_rec FROM vasilhames WHERE descricao = :descricao');
    DM.qrVasilhames.ParamByName('descricao').AsString := totaisRecebimentos[i, 2];
    DM.qrVasilhames.Open;

    qtdVasqrVas := DM.qrVasilhames.FieldByName('quantidade_a_rec').AsInteger;

    DM.qrVasilhames.Close;
    DM.qrVasilhames.SQL.Clear;
    DM.qrVasilhames.SQL.Add('UPDATE vasilhames SET quantidade_a_rec = :quantidade_a_rec WHERE descricao = :descricao');
    DM.qrVasilhames.ParamByName('quantidade_a_rec').AsInteger := qtdVasqrVas - strToInt(totaisRecebimentos[i, 3]);
    DM.qrVasilhames.ParamByName('descricao').AsString := totaisRecebimentos[i, 2];
    DM.qrVasilhames.ExecSQL;

    DM.qrRecebimentoVas.Close;
    DM.qrRecebimentoVas.SQL.Clear;
    DM.qrRecebimentoVas.SQL.Add('INSERT INTO recebimento_vasilhames (cliente, vasilhame, quantidade) VALUES (:cliente, :vasilhame, :quantidade)');
    DM.qrRecebimentoVas.ParamByName('cliente').AsString := cmbCliente.Text;
    DM.qrRecebimentoVas.ParamByName('vasilhame').AsString := totaisRecebimentos[i, 2];
    DM.qrRecebimentoVas.ParamByName('quantidade').AsInteger := strToInt(totaisRecebimentos[i, 3]);
    DM.qrRecebimentoVas.ExecSQL;
  end;

  DM.qrRecebimentoVas.Close;
  DM.qrRecebimentoVas.SQL.Clear;
  DM.qrRecebimentoVas.SQL.Add('SELECT cliente, vasilhame, quantidade FROM recebimento_vasilhames WHERE cliente = :cliente ORDER BY id DESC LIMIT :limit');
  DM.qrRecebimentoVas.ParamByName('cliente').AsString := cmbCliente.Text;
  DM.qrRecebimentoVas.ParamByName('limit').AsString := IntToStr(lenArrays - 1);
  DM.qrRecebimentoVas.Open;

  DM.qrClientes.Close;
  DM.qrClientes.SQL.Clear;
  DM.qrClientes.SQL.Add('SELECT * FROM clientes WHERE nome_razao = :nome_razao');
  DM.qrClientes.ParamByName('nome_razao').AsString := cmbCliente.Text;
  DM.qrClientes.Open;

  DM.qrVasilhames.Close;
  DM.qrVasilhames.SQL.Clear;
  DM.qrVasilhames.SQL.Add('SELECT * FROM vasilhames');
  DM.qrVasilhames.Open;

  temLogo := 'N';

  if FileExists(logo) then
  begin
    temLogo := 'ss';
  end;

  // Abre Relatório
  DM.termoRecebimento.LoadFromFile('relatorios\termoRecebimento.fr3');
  DM.termoRecebimento.Variables['temLogo'] := QuotedStr(temLogo);
  DM.termoRecebimento.Variables['razaoSoc'] := QuotedStr(razaoSoc);
  DM.termoRecebimento.Variables['fantasia'] := QuotedStr(fantasia);
  DM.termoRecebimento.Variables['cnpj'] := QuotedStr(cnpj);
  DM.termoRecebimento.Variables['inscEst'] := QuotedStr(inscEst);
  DM.termoRecebimento.Variables['endereco'] := QuotedStr(endereco);
  DM.termoRecebimento.Variables['cidade_emp'] := QuotedStr(cidade);
  DM.termoRecebimento.Variables['uf'] := QuotedStr(uf);
  DM.termoRecebimento.Variables['telefone'] := QuotedStr(telefone);
  DM.termoRecebimento.Variables['email'] := QuotedStr(email);
  DM.termoRecebimento.Variables['nome'] := QuotedStr(DM.qrClientes.FieldByName('nome_razao').AsString);
  DM.termoRecebimento.Variables['cpf'] := QuotedStr(DM.qrClientes.FieldByName('documento').AsString);
  DM.termoRecebimento.Variables['enderecoCli'] := QuotedStr(DM.qrClientes.FieldByName('rua').AsString);
  DM.termoRecebimento.Variables['bairro'] := QuotedStr(DM.qrClientes.FieldByName('bairro').AsString);
  DM.termoRecebimento.Variables['numero'] := QuotedStr(DM.qrClientes.FieldByName('numero').AsString);
  DM.termoRecebimento.Variables['cidade'] := QuotedStr(DM.qrClientes.FieldByName('cidade').AsString);
  DM.termoRecebimento.Variables['estado'] := QuotedStr(DM.qrClientes.FieldByName('uf').AsString);
  DM.termoRecebimento.Variables['capacidade'] := QuotedStr(DM.qrVasilhames.FieldByName('capacidade').AsString);
  DM.termoRecebimento.ShowReport;

  frmRecVasilhames.Close;
end;

procedure TfrmRecVasilhames.imgFinalizarMouseLeave(Sender: TObject);
begin
  pnlFinalizar.Color := clCream;
end;

procedure TfrmRecVasilhames.imgFinalizarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if pnlFinalizar.Enabled = True then
    pnlFinalizar.Color := clGradientActiveCaption;
end;

procedure TfrmRecVasilhames.pnlFinalizarClick(Sender: TObject);
var
  temLogo, vasilhame : String;
  i, qtdVasilhames, qtdVasqrVas, quantidade_dbt, quantidade_rec : Integer;
begin
  for i := 1 to lenArrays - 1 do
  begin
    DM.qrEntRec.Close;
    DM.qrEntRec.SQL.Clear;
    DM.qrEntRec.SQL.Add('SELECT quantidade_recebida, quantidade_debito FROM ent_rec WHERE id = :id');
    DM.qrEntRec.ParamByName('id').AsString := totaisRecebimentos[i, 1];
    DM.qrEntRec.Open;

    quantidade_dbt := DM.qrEntRec.FieldByName('quantidade_debito').AsInteger;
    quantidade_rec := DM.qrEntRec.FieldByName('quantidade_recebida').AsInteger;

    DM.qrEntRec.Close;
    DM.qrEntRec.SQL.Clear;
    DM.qrEntRec.SQL.Add('UPDATE ent_rec SET quantidade_recebida = :quantidade_recebida, quantidade_debito = :quantidade_debito WHERE id = :id');
    DM.qrEntRec.ParamByName('quantidade_recebida').AsInteger := quantidade_rec + strToInt(totaisRecebimentos[i, 3]);
    DM.qrEntRec.ParamByName('quantidade_debito').AsInteger := quantidade_dbt - strToInt(totaisRecebimentos[i, 3]);
    DM.qrEntRec.ParamByName('id').AsString := totaisRecebimentos[i, 1];
    DM.qrEntRec.ExecSQL;

    DM.qrVasilhames.Close;
    DM.qrVasilhames.SQL.Clear;
    DM.qrVasilhames.SQL.Add('SELECT quantidade_a_rec FROM vasilhames WHERE descricao = :descricao');
    DM.qrVasilhames.ParamByName('descricao').AsString := totaisRecebimentos[i, 2];
    DM.qrVasilhames.Open;

    qtdVasqrVas := DM.qrVasilhames.FieldByName('quantidade_a_rec').AsInteger;

    DM.qrVasilhames.Close;
    DM.qrVasilhames.SQL.Clear;
    DM.qrVasilhames.SQL.Add('UPDATE vasilhames SET quantidade_a_rec = :quantidade_a_rec WHERE descricao = :descricao');
    DM.qrVasilhames.ParamByName('quantidade_a_rec').AsInteger := qtdVasqrVas - strToInt(totaisRecebimentos[i, 3]);
    DM.qrVasilhames.ParamByName('descricao').AsString := totaisRecebimentos[i, 2];
    DM.qrVasilhames.ExecSQL;

    DM.qrRecebimentoVas.Close;
    DM.qrRecebimentoVas.SQL.Clear;
    DM.qrRecebimentoVas.SQL.Add('INSERT INTO recebimento_vasilhames (cliente, vasilhame, quantidade) VALUES (:cliente, :vasilhame, :quantidade)');
    DM.qrRecebimentoVas.ParamByName('cliente').AsString := cmbCliente.Text;
    DM.qrRecebimentoVas.ParamByName('vasilhame').AsString := totaisRecebimentos[i, 2];
    DM.qrRecebimentoVas.ParamByName('quantidade').AsInteger := strToInt(totaisRecebimentos[i, 3]);
    DM.qrRecebimentoVas.ExecSQL;
  end;

  DM.qrRecebimentoVas.Close;
  DM.qrRecebimentoVas.SQL.Clear;
  DM.qrRecebimentoVas.SQL.Add('SELECT cliente, vasilhame, quantidade FROM recebimento_vasilhames WHERE cliente = :cliente ORDER BY id DESC LIMIT :limit');
  DM.qrRecebimentoVas.ParamByName('cliente').AsString := cmbCliente.Text;
  DM.qrRecebimentoVas.ParamByName('limit').AsString := IntToStr(lenArrays - 1);
  DM.qrRecebimentoVas.Open;

  DM.qrClientes.Close;
  DM.qrClientes.SQL.Clear;
  DM.qrClientes.SQL.Add('SELECT * FROM clientes WHERE nome_razao = :nome_razao');
  DM.qrClientes.ParamByName('nome_razao').AsString := cmbCliente.Text;
  DM.qrClientes.Open;

  DM.qrVasilhames.Close;
  DM.qrVasilhames.SQL.Clear;
  DM.qrVasilhames.SQL.Add('SELECT * FROM vasilhames');
  DM.qrVasilhames.Open;

  temLogo := 'N';

  if FileExists(logo) then
  begin
    temLogo := 'ss';
  end;

  // Abre Relatório
  DM.termoRecebimento.LoadFromFile('relatorios\termoRecebimento.fr3');
  DM.termoRecebimento.Variables['temLogo'] := QuotedStr(temLogo);
  DM.termoRecebimento.Variables['razaoSoc'] := QuotedStr(razaoSoc);
  DM.termoRecebimento.Variables['fantasia'] := QuotedStr(fantasia);
  DM.termoRecebimento.Variables['cnpj'] := QuotedStr(cnpj);
  DM.termoRecebimento.Variables['inscEst'] := QuotedStr(inscEst);
  DM.termoRecebimento.Variables['endereco'] := QuotedStr(endereco);
  DM.termoRecebimento.Variables['cidade_emp'] := QuotedStr(cidade);
  DM.termoRecebimento.Variables['uf'] := QuotedStr(uf);
  DM.termoRecebimento.Variables['telefone'] := QuotedStr(telefone);
  DM.termoRecebimento.Variables['email'] := QuotedStr(email);
  DM.termoRecebimento.Variables['nome'] := QuotedStr(DM.qrClientes.FieldByName('nome_razao').AsString);
  DM.termoRecebimento.Variables['cpf'] := QuotedStr(DM.qrClientes.FieldByName('documento').AsString);
  DM.termoRecebimento.Variables['enderecoCli'] := QuotedStr(DM.qrClientes.FieldByName('rua').AsString);
  DM.termoRecebimento.Variables['bairro'] := QuotedStr(DM.qrClientes.FieldByName('bairro').AsString);
  DM.termoRecebimento.Variables['numero'] := QuotedStr(DM.qrClientes.FieldByName('numero').AsString);
  DM.termoRecebimento.Variables['cidade'] := QuotedStr(DM.qrClientes.FieldByName('cidade').AsString);
  DM.termoRecebimento.Variables['estado'] := QuotedStr(DM.qrClientes.FieldByName('uf').AsString);
  DM.termoRecebimento.Variables['capacidade'] := QuotedStr(DM.qrVasilhames.FieldByName('capacidade').AsString);
  DM.termoRecebimento.ShowReport;

  frmRecVasilhames.Close;
end;

procedure TfrmRecVasilhames.pnlFinalizarMouseLeave(Sender: TObject);
begin
  pnlFinalizar.Color := clCream;
end;

procedure TfrmRecVasilhames.pnlFinalizarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if pnlFinalizar.Enabled = True then
    pnlFinalizar.Color := clGradientActiveCaption;
end;

procedure TfrmRecVasilhames.btnLancarMaisClick(Sender: TObject);
var
  i: Integer;
begin
  pnlFinalizar.Enabled := True;
  grdVasaEnt.Enabled := True;

  i := 0;
  DM.qrEntRec.First;
  lenArrays := 1;

  while not DM.qrEntRec.Eof do
  begin
    i := i + 1;

    grdVasaEnt.RowCount := i;

    totaisRecebimentos[i, 1] := DM.qrEntRec.FieldByName('ID').AsString;
    totaisRecebimentos[i, 2] := DM.qrEntRec.FieldByName('vasilhame').AsString;
    totaisRecebimentos[i, 3] := DM.qrEntRec.FieldByName('quantidade_debito').AsString;

    qtdInicial[i, 1] := DM.qrEntRec.FieldByName('ID').AsString;
    qtdInicial[i, 2] := DM.qrEntRec.FieldByName('quantidade_debito').AsString;

    grdVasaEnt.Cells[0, i] := totaisRecebimentos[i, 1];
    grdVasaEnt.Cells[1, i] := totaisRecebimentos[i, 2];
    grdVasaEnt.Cells[2, i] := totaisRecebimentos[i, 3];

    DM.qrEntRec.Next;

    lenArrays := lenArrays + 1;
  end;

  i := i + 1;
  lenArrays := lenArrays - 1;

  grdVasaEnt.RowCount := i;

  totaisRecebimentos[i, 1] := DM.qrEntRec.FieldByName('ID').AsString;
  totaisRecebimentos[i, 2] := DM.qrEntRec.FieldByName('vasilhame').AsString;
  totaisRecebimentos[i, 3] := DM.qrEntRec.FieldByName('quantidade_debito').AsString;

  grdVasaEnt.Cells[0, i] := totaisRecebimentos[i, 1];
  grdVasaEnt.Cells[1, i] := totaisRecebimentos[i, 2];
  grdVasaEnt.Cells[2, i] := totaisRecebimentos[i, 3];

  grdVasaEnt.ColWidths[0] := 50;
  grdVasaEnt.ColWidths[1] := 245;
  grdVasaEnt.ColWidths[2] := 80;

  grdVasaEnt.ColAlignments[0] := taCenter;
  grdVasaEnt.ColAlignments[2] := taCenter;

  lenArrays := lenArrays + 1;
  dbgrdVasComCli.SelectedField := Nil;
  dbgrdVasComCli.Enabled := False;
end;

procedure TfrmRecVasilhames.btnVasExtrasClick(Sender: TObject);
begin
  frmVasExtras.ShowModal;
end;

procedure TfrmRecVasilhames.txtQuantidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not CharInSet(Key, ['0' .. '9', #8, ^V, ^C, ^X]) then
  begin
    Key := #0;
  end;
end;

end.
