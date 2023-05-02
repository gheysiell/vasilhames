unit UnitDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet; // frxClass, frxExportBaseDialog, frxExportPDF, frxDBSet

type
  TDM = class(TDataModule)
    Conn: TFDConnection;
    qrVasilhames: TFDQuery;
    dsTbVasilhames: TDataSource;
    tbVasilhames: TFDTable;
    dsQrVasilhames: TDataSource;
    //termoComodato: TfrxReport;
    //termoRecebimento: TfrxReport;
    tbClientes: TFDTable;
    qrClientes: TFDQuery;
    dsTbClientes: TDataSource;
    dsQrClientes: TDataSource;
    //expPdf: TfrxPDFExport;
    qrEntRec: TFDQuery;
    tbEntRec: TFDTable;
    qrDadosEmp: TFDQuery;
    dsQrDadosEmp: TDataSource;
    //dsDadosEmp: TfrxDBDataset;
    dsQrEntRec: TDataSource;
//    relVasEstoque: TfrxReport;
//    relVasaRec: TfrxReport;
//    dsVasEstoque: TfrxDBDataset;
//    dsVasaRec: TfrxDBDataset;
    qrRecebimentoVas: TFDQuery;
    //dsRecVas: TfrxDBDataset;
    dsRecVasilhames: TDataSource;
//    relVasilhames: TfrxReport;
//    relClientes: TfrxReport;
//    dsRelVasilhames: TfrxDBDataset;
//    dsRelClientes: TfrxDBDataset;
    tbVasilhamesid: TFDAutoIncField;
    tbVasilhamesdescricao: TStringField;
    tbVasilhamesmarca: TStringField;
    tbVasilhamesquantidade: TIntegerField;
    tbVasilhamesquantidade_a_rec: TIntegerField;
    tbVasilhamescapacidade: TIntegerField;
    tbVasilhamesu_data: TSQLTimeStampField;
    tbClientesid: TFDAutoIncField;
    tbClientesnome_razao: TStringField;
    tbClientesapelido_fantasia: TStringField;
    tbClientesdocumento: TStringField;
    tbClientesrua: TStringField;
    tbClientesnumero: TStringField;
    tbClientesbairro: TStringField;
    tbClientescidade: TStringField;
    tbClientesuf: TStringField;
    tbClientescep: TStringField;
    tbClientestelefone: TStringField;
    tbClientesu_data: TSQLTimeStampField;
//    relVasRecebidos: TfrxReport;
//    relVasEntregues: TfrxReport;
//    dsVasEntregues: TfrxDBDataset;
//    dsEntVasilhames: TDataSource;
//    relHistClientes: TfrxReport;
//    relHistClientesDet: TfrxReport;
//    dsEntRec: TfrxDBDataset;
    tbEntRecid: TFDAutoIncField;
    tbEntRecvasilhame: TStringField;
    tbEntReccliente: TStringField;
    tbEntRecquantidade_entregue: TIntegerField;
    tbEntRecquantidade_recebida: TIntegerField;
    tbEntRecquantidade_debito: TIntegerField;
    tbEntRecbonus: TStringField;
    tbEntRecu_data: TSQLTimeStampField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
