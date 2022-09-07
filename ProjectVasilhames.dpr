program ProjectVasilhames;

uses
  Vcl.Forms,
  UnitMenu in 'UnitMenu.pas' {frmMenu},
  UnitDM in 'UnitDM.pas' {DM: TDataModule},
  UnitCadastroVas in 'UnitCadastroVas.pas' {frmCadVasilhames},
  UnitEntVasilhames in 'UnitEntVasilhames.pas' {frmEntVasilhames},
  UnitRecVasilhames in 'UnitRecVasilhames.pas' {frmRecVasilhames},
  UnitCadastros in 'UnitCadastros.pas' {frmCadastros},
  UnitCadClientes in 'UnitCadClientes.pas' {frmCadClientes},
  UnitConfiguracoes in 'UnitConfiguracoes.pas' {frmConfiguracoes},
  UnitSuporte in 'UnitSuporte.pas' {frmSuporte},
  UnitDadosEmp in 'UnitDadosEmp.pas' {frmDadosEmpresa},
  UnitConfigurarLogo in 'UnitConfigurarLogo.pas' {frmConfigurarLogo},
  UnitAcessarDadosEmp in 'UnitAcessarDadosEmp.pas' {frmAcessarDadosEmp},
  UnitPesquisa in 'UnitPesquisa.pas' {frmPesquisa},
  UnitPesqVasilhames in 'UnitPesqVasilhames.pas' {frmPesqVasilhames},
  UnitPesqClientes in 'UnitPesqClientes.pas' {frmPesqClientes},
  UnitPesqVasilhamesaRec in 'UnitPesqVasilhamesaRec.pas' {frmPesqVasilhamesaRec},
  UnitRelatorios in 'UnitRelatorios.pas' {frmRelatorios},
  UnitFiltroVasRec in 'UnitFiltroVasRec.pas' {frmFiltroVasRecebidos},
  UnitFiltroVasEntregues in 'UnitFiltroVasEntregues.pas' {frmFiltroVasEntregues},
  UnitFiltroHistClientes in 'UnitFiltroHistClientes.pas' {frmFiltroHistClientes},
  UnitFiltroHistCliDetalhado in 'UnitFiltroHistCliDetalhado.pas' {frmFiltroHistCliDetalhado},
  UnitVasBonus in 'UnitVasBonus.pas' {frmVasExtras};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmCadVasilhames, frmCadVasilhames);
  Application.CreateForm(TfrmPesqVasilhames, frmPesqVasilhames);
  Application.CreateForm(TfrmEntVasilhames, frmEntVasilhames);
  Application.CreateForm(TfrmRecVasilhames, frmRecVasilhames);
  Application.CreateForm(TfrmCadastros, frmCadastros);
  Application.CreateForm(TfrmCadClientes, frmCadClientes);
  Application.CreateForm(TfrmConfiguracoes, frmConfiguracoes);
  Application.CreateForm(TfrmSuporte, frmSuporte);
  Application.CreateForm(TfrmDadosEmpresa, frmDadosEmpresa);
  Application.CreateForm(TfrmConfigurarLogo, frmConfigurarLogo);
  Application.CreateForm(TfrmAcessarDadosEmp, frmAcessarDadosEmp);
  Application.CreateForm(TfrmPesquisa, frmPesquisa);
  Application.CreateForm(TfrmPesqVasilhames, frmPesqVasilhames);
  Application.CreateForm(TfrmPesqClientes, frmPesqClientes);
  Application.CreateForm(TfrmPesqVasilhamesaRec, frmPesqVasilhamesaRec);
  Application.CreateForm(TfrmRelatorios, frmRelatorios);
  Application.CreateForm(TfrmFiltroVasRecebidos, frmFiltroVasRecebidos);
  Application.CreateForm(TfrmFiltroVasEntregues, frmFiltroVasEntregues);
  Application.CreateForm(TfrmFiltroHistClientes, frmFiltroHistClientes);
  Application.CreateForm(TfrmFiltroHistCliDetalhado, frmFiltroHistCliDetalhado);
  Application.CreateForm(TfrmVasExtras, frmVasExtras);
  Application.Run;
end.
