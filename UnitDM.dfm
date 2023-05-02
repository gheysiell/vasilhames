object DM: TDM
  Height = 683
  Width = 509
  PixelsPerInch = 120
  object Conn: TFDConnection
    Params.Strings = (
      'Database=vasilhames'
      'User_Name=root'
      'Password=root'
      'Server=localhost'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 20
    Top = 10
  end
  object qrVasilhames: TFDQuery
    Connection = Conn
    UpdateOptions.AssignedValues = [uvUpdateMode]
    UpdateOptions.UpdateMode = upWhereChanged
    SQL.Strings = (
      'SELECT * FROM vasilhames')
    Left = 210
    Top = 10
  end
  object dsTbVasilhames: TDataSource
    DataSet = tbVasilhames
    Left = 310
    Top = 10
  end
  object tbVasilhames: TFDTable
    IndexFieldNames = 'id'
    Connection = Conn
    UpdateOptions.AssignedValues = [uvUpdateMode]
    UpdateOptions.UpdateMode = upWhereChanged
    TableName = 'vasilhames'
    Left = 120
    Top = 10
    object tbVasilhamesid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ReadOnly = True
    end
    object tbVasilhamesdescricao: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'descricao'
      Origin = 'descricao'
      Size = 128
    end
    object tbVasilhamesmarca: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'marca'
      Origin = 'marca'
      Size = 50
    end
    object tbVasilhamesquantidade: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'quantidade'
      Origin = 'quantidade'
    end
    object tbVasilhamesquantidade_a_rec: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'quantidade_a_rec'
      Origin = 'quantidade_a_rec'
    end
    object tbVasilhamescapacidade: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'capacidade'
      Origin = 'capacidade'
    end
    object tbVasilhamesu_data: TSQLTimeStampField
      AutoGenerateValue = arDefault
      FieldName = 'u_data'
      Origin = 'u_data'
    end
  end
  object dsQrVasilhames: TDataSource
    DataSet = qrVasilhames
    Left = 420
    Top = 10
  end
  object tbClientes: TFDTable
    IndexFieldNames = 'id'
    Connection = Conn
    UpdateOptions.AssignedValues = [uvUpdateMode]
    UpdateOptions.UpdateMode = upWhereChanged
    UpdateOptions.UpdateTableName = 'vasilhames.clientes'
    UpdateOptions.KeyFields = 'id'
    TableName = 'clientes'
    Left = 120
    Top = 80
    object tbClientesid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object tbClientesnome_razao: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome_razao'
      Origin = 'nome_razao'
      Size = 128
    end
    object tbClientesapelido_fantasia: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'apelido_fantasia'
      Origin = 'apelido_fantasia'
      Size = 128
    end
    object tbClientesdocumento: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'documento'
      Origin = 'documento'
      Size = 14
    end
    object tbClientesrua: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'rua'
      Origin = 'rua'
      Size = 128
    end
    object tbClientesnumero: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'numero'
      Origin = 'numero'
      Size = 15
    end
    object tbClientesbairro: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'bairro'
      Origin = 'bairro'
      Size = 64
    end
    object tbClientescidade: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cidade'
      Origin = 'cidade'
      Size = 30
    end
    object tbClientesuf: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'uf'
      Origin = 'uf'
      FixedChar = True
      Size = 2
    end
    object tbClientescep: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cep'
      Origin = 'cep'
      Size = 9
    end
    object tbClientestelefone: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'telefone'
      Origin = 'telefone'
    end
    object tbClientesu_data: TSQLTimeStampField
      AutoGenerateValue = arDefault
      FieldName = 'u_data'
      Origin = 'u_data'
    end
  end
  object qrClientes: TFDQuery
    IndexFieldNames = 'id'
    Connection = Conn
    UpdateOptions.AssignedValues = [uvUpdateMode, uvCountUpdatedRecords]
    UpdateOptions.UpdateMode = upWhereChanged
    SQL.Strings = (
      'SELECT * FROM clientes')
    Left = 210
    Top = 80
  end
  object dsTbClientes: TDataSource
    DataSet = tbClientes
    Left = 310
    Top = 80
  end
  object dsQrClientes: TDataSource
    DataSet = qrClientes
    Left = 420
    Top = 80
  end
  object qrEntRec: TFDQuery
    Connection = Conn
    UpdateOptions.AssignedValues = [uvUpdateMode]
    UpdateOptions.UpdateMode = upWhereChanged
    UpdateOptions.UpdateTableName = 'vasilhames.ent_rec'
    SQL.Strings = (
      'SELECT * FROM ent_rec')
    Left = 210
    Top = 156
  end
  object tbEntRec: TFDTable
    IndexFieldNames = 'id'
    Connection = Conn
    TableName = 'vasilhames.ent_rec'
    Left = 120
    Top = 156
    object tbEntRecid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object tbEntRecvasilhame: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'vasilhame'
      Origin = 'vasilhame'
      Size = 128
    end
    object tbEntReccliente: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cliente'
      Origin = 'cliente'
      Size = 128
    end
    object tbEntRecquantidade_entregue: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'quantidade_entregue'
      Origin = 'quantidade_entregue'
    end
    object tbEntRecquantidade_recebida: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'quantidade_recebida'
      Origin = 'quantidade_recebida'
    end
    object tbEntRecquantidade_debito: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'quantidade_debito'
      Origin = 'quantidade_debito'
    end
    object tbEntRecbonus: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'bonus'
      Origin = 'bonus'
      FixedChar = True
      Size = 1
    end
    object tbEntRecu_data: TSQLTimeStampField
      AutoGenerateValue = arDefault
      FieldName = 'u_data'
      Origin = 'u_data'
    end
  end
  object qrDadosEmp: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'SELECT * FROM dados_empresa')
    Left = 26
    Top = 236
  end
  object dsQrDadosEmp: TDataSource
    DataSet = qrDadosEmp
    Left = 123
    Top = 236
  end
  object dsQrEntRec: TDataSource
    DataSet = qrEntRec
    Left = 310
    Top = 156
  end
  object qrRecebimentoVas: TFDQuery
    Connection = Conn
    UpdateOptions.AssignedValues = [uvUpdateMode]
    UpdateOptions.UpdateMode = upWhereChanged
    SQL.Strings = (
      'SELECT * FROM recebimento_vasilhames')
    Left = 48
    Top = 310
  end
  object dsRecVasilhames: TDataSource
    DataSet = qrRecebimentoVas
    Left = 164
    Top = 310
  end
  object dsEntVasilhames: TDataSource
    DataSet = qrEntRec
    Left = 40
    Top = 460
  end
end
