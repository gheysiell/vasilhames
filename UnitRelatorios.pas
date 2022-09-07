unit UnitRelatorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TfrmRelatorios = class(TForm)
    pnlVasEstoque: TPanel;
    pnlVasaReceber: TPanel;
    imgVasEstoque: TImage;
    imgVasaReceber: TImage;
    pnlRelVasilhames: TPanel;
    imgRelVasilhames: TImage;
    pnlRelClientes: TPanel;
    imgRelClientes: TImage;
    pnlVasRecebidos: TPanel;
    imgVasRecebidos: TImage;
    pnlVasEntregues: TPanel;
    imgVasEntregues: TImage;
    pnlHistCliente: TPanel;
    Image1: TImage;
    pnlHistClienteDet: TPanel;
    Image2: TImage;
    procedure pnlVasEstoqueMouseLeave(Sender: TObject);
    procedure imgVasEstoqueMouseLeave(Sender: TObject);
    procedure imgVasaReceberMouseLeave(Sender: TObject);
    procedure pnlVasaReceberMouseLeave(Sender: TObject);
    procedure pnlVasEstoqueMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgVasEstoqueMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlVasaReceberMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgVasaReceberMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgVasEstoqueClick(Sender: TObject);
    procedure pnlVasEstoqueClick(Sender: TObject);
    procedure imgVasaReceberClick(Sender: TObject);
    procedure pnlVasaReceberClick(Sender: TObject);
    procedure pnlRelVasilhamesMouseLeave(Sender: TObject);
    procedure imgRelVasilhamesMouseLeave(Sender: TObject);
    procedure pnlRelVasilhamesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgRelVasilhamesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlRelClientesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgRelClientesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgRelClientesMouseLeave(Sender: TObject);
    procedure pnlRelClientesMouseLeave(Sender: TObject);
    procedure imgRelVasilhamesClick(Sender: TObject);
    procedure pnlRelVasilhamesClick(Sender: TObject);
    procedure imgRelClientesClick(Sender: TObject);
    procedure pnlRelClientesClick(Sender: TObject);
    procedure pnlVasRecebidosMouseLeave(Sender: TObject);
    procedure imgVasRecebidosMouseLeave(Sender: TObject);
    procedure imgVasRecebidosMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlVasRecebidosMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlVasEntreguesMouseLeave(Sender: TObject);
    procedure imgVasEntreguesMouseLeave(Sender: TObject);
    procedure imgVasEntreguesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlVasEntreguesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgVasRecebidosClick(Sender: TObject);
    procedure pnlVasRecebidosClick(Sender: TObject);
    procedure imgVasEntreguesClick(Sender: TObject);
    procedure pnlVasEntreuesClick(Sender: TObject);
    procedure pnlHistClienteMouseLeave(Sender: TObject);
    procedure Image1MouseLeave(Sender: TObject);
    procedure pnlHistClienteDetMouseLeave(Sender: TObject);
    procedure Image2MouseLeave(Sender: TObject);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlHistClienteDetMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlHistClienteMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1Click(Sender: TObject);
    procedure pnlHistClienteClick(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure pnlHistClienteDetClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorios: TfrmRelatorios;

implementation

{$R *.dfm}

uses UnitDM, UnitMenu, UnitFiltroVasRec, UnitFiltroVasEntregues,
  UnitFiltroHistClientes, UnitFiltroHistCliDetalhado;

procedure TfrmRelatorios.Image1Click(Sender: TObject);
begin
  frmFiltroHistClientes.ShowModal;
end;

procedure TfrmRelatorios.Image1MouseLeave(Sender: TObject);
begin
  pnlHistCliente.Color := clCream;
end;

procedure TfrmRelatorios.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  pnlHistCliente.Color := clGradientActiveCaption;
end;

procedure TfrmRelatorios.Image2Click(Sender: TObject);
begin
  frmFiltroHistCliDetalhado.ShowModal;
end;

procedure TfrmRelatorios.Image2MouseLeave(Sender: TObject);
begin
  pnlHistClienteDet.Color := clCream;
end;

procedure TfrmRelatorios.Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  pnlHistClienteDet.Color := clGradientActiveCaption;
end;

procedure TfrmRelatorios.imgRelClientesClick(Sender: TObject);
var
  temLogo : String;
begin
  temLogo := 'N';

  if FileExists(logo) then
  begin
    temLogo := 'ss';
  end;

  DM.qrClientes.Close;
  DM.qrClientes.SQL.Clear;
  DM.qrClientes.SQL.Add('SELECT * FROM clientes');
  DM.qrClientes.Open;
  DM.qrClientes.Active := true;

  DM.relClientes.LoadFromFile('relatorios\relClientes.fr3');
    DM.relClientes.Variables['temLogo']     := QuotedStr(temLogo);
    DM.relClientes.Variables['razaoSoc']    := QuotedStr(razaoSoc);
    DM.relClientes.Variables['fantasia']    := QuotedStr(fantasia);
    DM.relClientes.Variables['cnpj']        := QuotedStr(cnpj);
    DM.relClientes.Variables['inscEst']     := QuotedStr(inscEst);
    DM.relClientes.Variables['endereco']    := QuotedStr(endereco);
    DM.relClientes.Variables['cidade_emp']  := QuotedStr(cidade);
    DM.relClientes.Variables['telefone']    := QuotedStr(telefone);
    DM.relClientes.Variables['email']       := QuotedStr(email);
  DM.relClientes.ShowReport;
end;

procedure TfrmRelatorios.imgRelClientesMouseLeave(Sender: TObject);
begin
  pnlRelClientes.Color := clCream;
end;

procedure TfrmRelatorios.imgRelClientesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlRelClientes.Color := clGradientActiveCaption;
end;

procedure TfrmRelatorios.imgRelVasilhamesClick(Sender: TObject);
var
  temLogo : String;
begin
  temLogo := 'N';

  if FileExists(logo) then
  begin
    temLogo := 'ss';
  end;

  DM.qrVasilhames.Close;
  DM.qrVasilhames.SQL.Clear;
  DM.qrVasilhames.SQL.Add('SELECT * FROM vasilhames');
  DM.qrVasilhames.Open;

  DM.relVasilhames.LoadFromFile('relatorios\relVasilhames.fr3');
    DM.relVasilhames.Variables['temLogo']     := QuotedStr(temLogo);
    DM.relVasilhames.Variables['razaoSoc']    := QuotedStr(razaoSoc);
    DM.relVasilhames.Variables['fantasia']    := QuotedStr(fantasia);
    DM.relVasilhames.Variables['cnpj']        := QuotedStr(cnpj);
    DM.relVasilhames.Variables['inscEst']     := QuotedStr(inscEst);
    DM.relVasilhames.Variables['endereco']    := QuotedStr(endereco);
    DM.relVasilhames.Variables['cidade_emp']  := QuotedStr(cidade);
    DM.relVasilhames.Variables['telefone']    := QuotedStr(telefone);
    DM.relVasilhames.Variables['email']       := QuotedStr(email);
  DM.relVasilhames.ShowReport;
end;

procedure TfrmRelatorios.imgRelVasilhamesMouseLeave(Sender: TObject);
begin
  pnlRelVasilhames.Color := clCream;
end;

procedure TfrmRelatorios.imgRelVasilhamesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlRelVasilhames.Color := clGradientActiveCaption;
end;

procedure TfrmRelatorios.imgVasaReceberClick(Sender: TObject);
var
  temLogo : String;
begin
  temLogo := 'N';

  DM.qrDadosEmp.Close;
  DM.qrDadosEmp.SQL.Clear;
  DM.qrDadosEmp.SQL.Add('SELECT * FROM dados_empresa');
  DM.qrDadosEmp.Close;

  if FileExists(logo) then
  begin
    temLogo := 'ss';
  end;

  DM.qrEntRec.Close;
  DM.qrEntRec.SQL.Clear;
  DM.qrEntRec.SQL.Add('SELECT * FROM ent_rec WHERE quantidade_debito <> 0');
  DM.qrEntRec.Open;
  DM.qrEntRec.Active := true;

  DM.relVasaRec.LoadFromFile('relatorios\relVasilhamesaReceber.fr3');
    DM.relVasaRec.Variables['temLogo']     := QuotedStr(temLogo);
    DM.relVasaRec.Variables['razaoSoc']    := QuotedStr(razaoSoc);
    DM.relVasaRec.Variables['fantasia']    := QuotedStr(fantasia);
    DM.relVasaRec.Variables['cnpj']        := QuotedStr(cnpj);
    DM.relVasaRec.Variables['inscEst']     := QuotedStr(inscEst);
    DM.relVasaRec.Variables['endereco']    := QuotedStr(endereco);
    DM.relVasaRec.Variables['cidade_emp']  := QuotedStr(cidade);
    DM.relVasaRec.Variables['telefone']    := QuotedStr(telefone);
    DM.relVasaRec.Variables['email']       := QuotedStr(email);
  DM.relVasaRec.ShowReport;
end;

procedure TfrmRelatorios.imgVasaReceberMouseLeave(Sender: TObject);
begin
  pnlVasaReceber.Color := clCream;
end;

procedure TfrmRelatorios.imgVasaReceberMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlVasaReceber.Color := clGradientActiveCaption;
end;

procedure TfrmRelatorios.imgVasEntreguesClick(Sender: TObject);
begin
  frmFiltroVasEntregues.ShowModal;
end;

procedure TfrmRelatorios.imgVasEntreguesMouseLeave(Sender: TObject);
begin
  pnlVasEntregues.Color := clCream;
end;

procedure TfrmRelatorios.imgVasEntreguesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlVasEntregues.Color := clGradientActiveCaption;
end;

procedure TfrmRelatorios.imgVasEstoqueClick(Sender: TObject);
var
  temLogo : String;
begin
  temLogo := 'N';

  if FileExists(logo) then
  begin
    temLogo := 'ss';
  end;

  DM.qrVasilhames.Close;
  DM.qrVasilhames.SQL.Clear;
  DM.qrVasilhames.SQL.Add('SELECT id, descricao, marca, (quantidade - quantidade_a_rec) as quantidade, u_data FROM vasilhames');
  DM.qrVasilhames.Open;

  DM.relVasEstoque.LoadFromFile('relatorios\relVasilhamesnoEstoque.fr3');
    DM.relVasEstoque.Variables['temLogo']     := QuotedStr(temLogo);
    DM.relVasEstoque.Variables['razaoSoc']    := QuotedStr(razaoSoc);
    DM.relVasEstoque.Variables['fantasia']    := QuotedStr(fantasia);
    DM.relVasEstoque.Variables['cnpj']        := QuotedStr(cnpj);
    DM.relVasEstoque.Variables['inscEst']     := QuotedStr(inscEst);
    DM.relVasEstoque.Variables['endereco']    := QuotedStr(endereco);
    DM.relVasEstoque.Variables['cidade_emp']  := QuotedStr(cidade);
    DM.relVasEstoque.Variables['telefone']    := QuotedStr(telefone);
    DM.relVasEstoque.Variables['email']       := QuotedStr(email);
  DM.relVasEstoque.ShowReport;
end;

procedure TfrmRelatorios.imgVasEstoqueMouseLeave(Sender: TObject);
begin
  pnlVasEstoque.Color := clCream;
end;

procedure TfrmRelatorios.imgVasEstoqueMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlVasEstoque.Color := clGradientActiveCaption;
end;

procedure TfrmRelatorios.imgVasRecebidosClick(Sender: TObject);
begin
  frmFiltroVasRecebidos.ShowModal;
end;

procedure TfrmRelatorios.imgVasRecebidosMouseLeave(Sender: TObject);
begin
  pnlVasRecebidos.Color := clCream;
end;

procedure TfrmRelatorios.imgVasRecebidosMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlVasRecebidos.Color := clGradientActiveCaption;
end;

procedure TfrmRelatorios.pnlHistClienteClick(Sender: TObject);
begin
  frmFiltroHistClientes.ShowModal;
end;

procedure TfrmRelatorios.pnlHistClienteDetClick(Sender: TObject);
begin
  frmFiltroHistCliDetalhado.ShowModal;
end;

procedure TfrmRelatorios.pnlHistClienteDetMouseLeave(Sender: TObject);
begin
  pnlHistClienteDet.Color := clCream;
end;

procedure TfrmRelatorios.pnlHistClienteDetMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlHistClienteDet.Color := clGradientActiveCaption;
end;

procedure TfrmRelatorios.pnlHistClienteMouseLeave(Sender: TObject);
begin
  pnlHistCliente.Color := clCream;
end;

procedure TfrmRelatorios.pnlHistClienteMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlHistCliente.Color := clGradientActiveCaption;
end;

procedure TfrmRelatorios.pnlRelClientesClick(Sender: TObject);
var
  temLogo : String;
begin
  temLogo := 'N';

  if FileExists(logo) then
  begin
    temLogo := 'ss';
  end;

  DM.qrClientes.Close;
  DM.qrClientes.SQL.Clear;
  DM.qrClientes.SQL.Add('SELECT * FROM clientes');
  DM.qrClientes.Open;

  DM.relClientes.LoadFromFile('relatorios\relClientes.fr3');
    DM.relClientes.Variables['temLogo']     := QuotedStr(temLogo);
    DM.relClientes.Variables['razaoSoc']    := QuotedStr(razaoSoc);
    DM.relClientes.Variables['fantasia']    := QuotedStr(fantasia);
    DM.relClientes.Variables['cnpj']        := QuotedStr(cnpj);
    DM.relClientes.Variables['inscEst']     := QuotedStr(inscEst);
    DM.relClientes.Variables['endereco']    := QuotedStr(endereco);
    DM.relClientes.Variables['cidade_emp']  := QuotedStr(cidade);
    DM.relClientes.Variables['telefone']    := QuotedStr(telefone);
    DM.relClientes.Variables['email']       := QuotedStr(email);
  DM.relClientes.ShowReport;
end;

procedure TfrmRelatorios.pnlRelClientesMouseLeave(Sender: TObject);
begin
  pnlRelClientes.Color := clCream;
end;

procedure TfrmRelatorios.pnlRelClientesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlRelClientes.Color := clGradientActiveCaption;
end;

procedure TfrmRelatorios.pnlRelVasilhamesClick(Sender: TObject);
var
  temLogo : String;
begin
  temLogo := 'N';

  if FileExists(logo) then
  begin
    temLogo := 'ss';
  end;

  DM.qrVasilhames.Close;
  DM.qrVasilhames.SQL.Clear;
  DM.qrVasilhames.SQL.Add('SELECT * FROM vasilhames');
  DM.qrVasilhames.Open;

  DM.relVasilhames.LoadFromFile('relatorios\relVasilhames.fr3');
    DM.relVasilhames.Variables['temLogo']     := QuotedStr(temLogo);
    DM.relVasilhames.Variables['razaoSoc']    := QuotedStr(razaoSoc);
    DM.relVasilhames.Variables['fantasia']    := QuotedStr(fantasia);
    DM.relVasilhames.Variables['cnpj']        := QuotedStr(cnpj);
    DM.relVasilhames.Variables['inscEst']     := QuotedStr(inscEst);
    DM.relVasilhames.Variables['endereco']    := QuotedStr(endereco);
    DM.relVasilhames.Variables['cidade_emp']  := QuotedStr(cidade);
    DM.relVasilhames.Variables['telefone']    := QuotedStr(telefone);
    DM.relVasilhames.Variables['email']       := QuotedStr(email);
  DM.relVasilhames.ShowReport;
end;

procedure TfrmRelatorios.pnlRelVasilhamesMouseLeave(Sender: TObject);
begin
  pnlRelVasilhames.Color := clCream;
end;

procedure TfrmRelatorios.pnlRelVasilhamesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlRelVasilhames.Color := clGradientActiveCaption;
end;

procedure TfrmRelatorios.pnlVasaReceberClick(Sender: TObject);
var
  temLogo : String;
begin
  temLogo := 'N';

  DM.qrDadosEmp.Close;
  DM.qrDadosEmp.SQL.Clear;
  DM.qrDadosEmp.SQL.Add('SELECT * FROM dados_empresa');
  DM.qrDadosEmp.Close;

  if FileExists(logo) then
  begin
    temLogo := 'ss';
  end;

  DM.qrEntRec.Close;
  DM.qrEntRec.SQL.Clear;
  DM.qrEntRec.SQL.Add('SELECT * FROM ent_rec WHERE quantidade <> 0');
  DM.qrEntRec.Open;

  DM.relVasaRec.LoadFromFile('relatorios\relVasilhamesaReceber.fr3');
    DM.relVasaRec.Variables['temLogo']     := QuotedStr(temLogo);
    DM.relVasaRec.Variables['razaoSoc']    := QuotedStr(razaoSoc);
    DM.relVasaRec.Variables['fantasia']    := QuotedStr(fantasia);
    DM.relVasaRec.Variables['cnpj']        := QuotedStr(cnpj);
    DM.relVasaRec.Variables['inscEst']     := QuotedStr(inscEst);
    DM.relVasaRec.Variables['endereco']    := QuotedStr(endereco);
    DM.relVasaRec.Variables['cidade_emp']  := QuotedStr(cidade);
    DM.relVasaRec.Variables['telefone']    := QuotedStr(telefone);
    DM.relVasaRec.Variables['email']       := QuotedStr(email);
  DM.relVasaRec.ShowReport;
end;

procedure TfrmRelatorios.pnlVasaReceberMouseLeave(Sender: TObject);
begin
  pnlVasaReceber.Color := clCream;
end;

procedure TfrmRelatorios.pnlVasaReceberMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlVasaReceber.Color := clGradientActiveCaption;
end;

procedure TfrmRelatorios.pnlVasEntreuesClick(Sender: TObject);
begin
  frmFiltroVasEntregues.ShowModal;
end;

procedure TfrmRelatorios.pnlVasEntreguesMouseLeave(Sender: TObject);
begin
  pnlVasEntregues.Color := clCream;
end;

procedure TfrmRelatorios.pnlVasEntreguesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlVasEntregues.Color := clGradientActiveCaption;
end;

procedure TfrmRelatorios.pnlVasEstoqueClick(Sender: TObject);
var
  temLogo : String;
begin
  temLogo := 'N';

  if FileExists(logo) then
  begin
    temLogo := 'ss';
  end;

  DM.qrVasilhames.Close;
  DM.qrVasilhames.SQL.Clear;
  DM.qrVasilhames.SQL.Add('SELECT id, descricao, marca, (quantidade - quantidade_a_rec) as quantidade, u_data FROM vasilhames');
  DM.qrVasilhames.Open;

  DM.relVasEstoque.LoadFromFile('relatorios\relVasilhamesnoEstoque.fr3');
    DM.relVasEstoque.Variables['temLogo']     := QuotedStr(temLogo);
    DM.relVasEstoque.Variables['razaoSoc']    := QuotedStr(razaoSoc);
    DM.relVasEstoque.Variables['fantasia']    := QuotedStr(fantasia);
    DM.relVasEstoque.Variables['cnpj']        := QuotedStr(cnpj);
    DM.relVasEstoque.Variables['inscEst']     := QuotedStr(inscEst);
    DM.relVasEstoque.Variables['endereco']    := QuotedStr(endereco);
    DM.relVasEstoque.Variables['cidade_emp']  := QuotedStr(cidade);
    DM.relVasEstoque.Variables['telefone']    := QuotedStr(telefone);
    DM.relVasEstoque.Variables['email']       := QuotedStr(email);
  DM.relVasEstoque.ShowReport;
end;

procedure TfrmRelatorios.pnlVasEstoqueMouseLeave(Sender: TObject);
begin
  pnlVasEstoque.Color := clCream;
end;

procedure TfrmRelatorios.pnlVasEstoqueMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlVasEstoque.Color := clGradientActiveCaption;
end;

procedure TfrmRelatorios.pnlVasRecebidosClick(Sender: TObject);
begin
  frmFiltroVasRecebidos.ShowModal;
end;

procedure TfrmRelatorios.pnlVasRecebidosMouseLeave(Sender: TObject);
begin
  pnlVasRecebidos.Color := clCream;
end;

procedure TfrmRelatorios.pnlVasRecebidosMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlVasRecebidos.Color := clGradientActiveCaption;
end;

end.
