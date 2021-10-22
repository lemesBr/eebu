inherited formStartConfig: TformStartConfig
  Caption = 'formStartConfig'
  ClientHeight = 535
  ClientWidth = 1016
  ExplicitWidth = 1024
  ExplicitHeight = 563
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1016
    Height = 535
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object lbe_authentication: TLabeledEdit
      Left = 32
      Top = 32
      Width = 300
      Height = 23
      CharCase = ecUpperCase
      EditLabel.Width = 93
      EditLabel.Height = 15
      EditLabel.Caption = 'AUTHENTICATION'
      ReadOnly = True
      TabOrder = 0
    end
    object lbe_server_address: TLabeledEdit
      Left = 342
      Top = 32
      Width = 150
      Height = 23
      CharCase = ecUpperCase
      EditLabel.Width = 93
      EditLabel.Height = 15
      EditLabel.Caption = 'SERVER_ADDRESS'
      TabOrder = 1
    end
    object lbe_server_database: TLabeledEdit
      Left = 502
      Top = 32
      Width = 300
      Height = 23
      CharCase = ecUpperCase
      EditLabel.Width = 97
      EditLabel.Height = 15
      EditLabel.Caption = 'SERVER_DATABASE'
      TabOrder = 2
    end
    object lbe_server_user_name: TLabeledEdit
      Left = 812
      Top = 32
      Width = 160
      Height = 23
      CharCase = ecLowerCase
      EditLabel.Width = 110
      EditLabel.Height = 15
      EditLabel.Caption = 'SERVER_USER_NAME'
      TabOrder = 3
    end
    object lbe_server_user_password: TLabeledEdit
      Left = 32
      Top = 88
      Width = 160
      Height = 23
      CharCase = ecLowerCase
      EditLabel.Width = 139
      EditLabel.Height = 15
      EditLabel.Caption = 'SERVER_USER_PASSWORD'
      TabOrder = 4
    end
    object Button1: TButton
      Left = 216
      Top = 87
      Width = 75
      Height = 25
      Caption = 'Conectar'
      TabOrder = 5
      OnClick = Button1Click
    end
    object DBGrid1: TDBGrid
      Left = 32
      Top = 176
      Width = 940
      Height = 217
      DataSource = ds_terminais
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 6
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Calibri'
      TitleFont.Style = []
    end
    object Button2: TButton
      Left = 897
      Top = 423
      Width = 75
      Height = 25
      Caption = 'Configurar'
      TabOrder = 7
      OnClick = Button2Click
    end
  end
  object ds_terminais: TDataSource
    DataSet = dmServidor.fdq_terminais
    Left = 416
    Top = 240
  end
end
