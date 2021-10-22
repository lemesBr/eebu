inherited formNfeRecebidasList: TformNfeRecebidasList
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formNfeRecebidasList'
  ClientHeight = 740
  ClientWidth = 1024
  Color = 3618615
  Position = poDefaultSizeOnly
  WindowState = wsMaximized
  ExplicitWidth = 1024
  ExplicitHeight = 740
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_principal: TPanel
    Left = 3
    Top = 10
    Width = 1018
    Height = 720
    Align = alCustom
    Anchors = []
    Color = clWhite
    Padding.Left = 20
    Padding.Right = 20
    ParentBackground = False
    TabOrder = 0
    object bvl_1: TBevel
      Left = 21
      Top = 81
      Width = 976
      Height = 2
      Align = alTop
      ExplicitLeft = 0
      ExplicitTop = 88
    end
    object bvl_2: TBevel
      Left = 21
      Top = 637
      Width = 976
      Height = 2
      Align = alBottom
      ExplicitTop = 631
    end
    object pnl_header: TPanel
      Left = 21
      Top = 1
      Width = 976
      Height = 80
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'NFE RECEBIDAS'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Bombardier'
      Font.Style = []
      Padding.Top = 15
      Padding.Bottom = 15
      ParentColor = True
      ParentFont = False
      TabOrder = 0
    end
    object pnl_footer: TPanel
      Left = 21
      Top = 639
      Width = 976
      Height = 80
      Align = alBottom
      BevelOuter = bvNone
      Padding.Top = 10
      Padding.Bottom = 10
      ParentColor = True
      TabOrder = 1
      object btn_rollback: TButton
        AlignWithMargins = True
        Left = 356
        Top = 10
        Width = 150
        Height = 60
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 0
        Action = act_rollback
        Align = alRight
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Bombardier'
        Font.Style = [fsUnderline]
        Images = dmRepository.iml_32
        ParentFont = False
        TabOrder = 0
        TabStop = False
        WordWrap = True
      end
      object btn_consultar: TButton
        AlignWithMargins = True
        Left = 511
        Top = 10
        Width = 150
        Height = 60
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 0
        Action = act_nfe_consultar
        Align = alRight
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Bombardier'
        Font.Style = [fsUnderline]
        Images = dmRepository.iml_32
        ParentFont = False
        TabOrder = 1
        TabStop = False
        WordWrap = True
      end
      object btn_nfe: TButton
        AlignWithMargins = True
        Left = 821
        Top = 10
        Width = 150
        Height = 60
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 0
        Align = alRight
        Caption = 'NOTA FISCAL'
        DropDownMenu = ppm_nfe
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Bombardier'
        Font.Style = [fsUnderline]
        Images = dmRepository.iml_32
        ParentFont = False
        Style = bsSplitButton
        TabOrder = 2
        TabStop = False
        WordWrap = True
      end
      object btn_importar: TButton
        AlignWithMargins = True
        Left = 666
        Top = 10
        Width = 150
        Height = 60
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 0
        Action = act_nfe_importar
        Align = alRight
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Bombardier'
        Font.Style = [fsUnderline]
        Images = dmRepository.iml_32
        ParentFont = False
        TabOrder = 3
        TabStop = False
        WordWrap = True
      end
    end
    object pnl_body: TPanel
      Left = 21
      Top = 83
      Width = 976
      Height = 554
      Align = alClient
      BevelOuter = bvNone
      Padding.Top = 15
      ParentColor = True
      TabOrder = 2
      object bvl_3: TBevel
        Left = 0
        Top = 95
        Width = 976
        Height = 2
        Align = alTop
        ExplicitTop = 88
      end
      object bvl_4: TBevel
        Left = 0
        Top = 458
        Width = 976
        Height = 2
        Align = alBottom
        ExplicitTop = 88
      end
      object pnl_nfes_search: TPanel
        Left = 0
        Top = 15
        Width = 976
        Height = 80
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Bombardier'
        Font.Style = []
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        object lbe_nfes_search: TLabeledEdit
          Left = 128
          Top = 28
          Width = 400
          Height = 24
          CharCase = ecUpperCase
          Ctl3D = False
          EditLabel.Width = 67
          EditLabel.Height = 18
          EditLabel.Caption = 'PESQUISAR'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Bombardier'
          Font.Style = []
          MaxLength = 44
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          OnKeyDown = lbe_nfes_searchKeyDown
        end
        object dtp_start: TDateTimePicker
          Left = 538
          Top = 28
          Width = 150
          Height = 26
          BiDiMode = bdLeftToRight
          Date = 42977.435999409720000000
          Time = 42977.435999409720000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 1
        end
        object dtp_end: TDateTimePicker
          Left = 698
          Top = 28
          Width = 150
          Height = 26
          BiDiMode = bdLeftToRight
          Date = 42977.435999409720000000
          Time = 42977.435999409720000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 2
        end
      end
      object dbg_nfes: TDBGrid
        Left = 0
        Top = 97
        Width = 976
        Height = 361
        Cursor = crHandPoint
        TabStop = False
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DataSource = ds_nfe_recebidas
        DrawingStyle = gdsClassic
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Courier New'
        TitleFont.Style = [fsUnderline]
        OnDrawColumnCell = dbg_nfesDrawColumnCell
        Columns = <
          item
            Expanded = False
            FieldName = 'MODELO'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SERIE'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NNF'
            Title.Caption = 'NUMERO'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DEMI'
            Title.Caption = 'EMISSAO'
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PARTICIPANTE'
            Title.Caption = 'EMITENTE'
            Width = 383
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VNF'
            Title.Alignment = taRightJustify
            Title.Caption = 'TOTAL'
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NFERECEBIDA'
            Title.Caption = '_'
            Width = 30
            Visible = True
          end>
      end
      object pnl_chave: TPanel
        Left = 0
        Top = 460
        Width = 976
        Height = 94
        Align = alBottom
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Bombardier'
        Font.Style = []
        ParentColor = True
        ParentFont = False
        TabOrder = 2
        object dbl_chave: TDBText
          Left = 0
          Top = 70
          Width = 976
          Height = 24
          Align = alBottom
          AutoSize = True
          DataField = 'CHNFE'
          DataSource = ds_nfe_recebidas
          Visible = False
          ExplicitWidth = 85
        end
      end
    end
  end
  object ds_nfe_recebidas: TDataSource
    DataSet = fdmt_nfe_recebidas
    Left = 331
    Top = 353
  end
  object tmr_focus: TTimer
    Enabled = False
    OnTimer = tmr_focusTimer
    Left = 328
    Top = 421
  end
  object acl_nfe_recebidas: TActionList
    Images = dmRepository.iml_32
    OnUpdate = acl_nfe_recebidasUpdate
    Left = 424
    Top = 355
    object act_rollback: TAction
      Caption = 'ESC - RETORNAR'
      ImageIndex = 0
      ShortCut = 27
      OnExecute = act_rollbackExecute
    end
    object act_nfe_consultar: TAction
      Caption = 'F2 - CONSULTAR'
      ImageIndex = 1
      ShortCut = 113
      OnExecute = act_nfe_consultarExecute
    end
    object act_nfe_importar: TAction
      Caption = 'F3 - IMPORTAR'
      ImageIndex = 5
      ShortCut = 114
      OnExecute = act_nfe_importarExecute
    end
    object act_nfe_conhecimento: TAction
      Caption = 'MANIFESTAR CONHECIMENTO'
      ImageIndex = 6
      ShortCut = 115
      OnExecute = act_nfe_conhecimentoExecute
    end
    object act_nfe_desconhecimento: TAction
      Caption = 'MANIFESTAR DESCONHECIMENTO'
      ImageIndex = 3
      ShortCut = 116
      OnExecute = act_nfe_desconhecimentoExecute
    end
    object act_nfe_imprimir: TAction
      Caption = 'IMPRIMIR'
      ImageIndex = 8
      ShortCut = 117
      OnExecute = act_nfe_imprimirExecute
    end
    object act_nfe_itens: TAction
      Caption = 'ITENS'
      ImageIndex = 1
      ShortCut = 118
      OnExecute = act_nfe_itensExecute
    end
    object act_nfe_confirmar: TAction
      Caption = 'CONFIRMAR ENTRADA'
      ImageIndex = 5
      ShortCut = 119
      OnExecute = act_nfe_confirmarExecute
    end
    object act_nfe_sped: TAction
      Caption = 'AJUSTAR PARA O SPED'
      ImageIndex = 6
      ShortCut = 120
      OnExecute = act_nfe_spedExecute
    end
  end
  object fdmt_nfe_recebidas: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 331
    Top = 297
    object fdmt_nfe_recebidasID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_nfe_recebidasMODELO: TStringField
      Alignment = taRightJustify
      FieldName = 'MODELO'
      Size = 2
    end
    object fdmt_nfe_recebidasSERIE: TIntegerField
      FieldName = 'SERIE'
    end
    object fdmt_nfe_recebidasNNF: TIntegerField
      FieldName = 'NNF'
    end
    object fdmt_nfe_recebidasDEMI: TDateField
      FieldName = 'DEMI'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object fdmt_nfe_recebidasPARTICIPANTE: TStringField
      FieldName = 'PARTICIPANTE'
      Size = 60
    end
    object fdmt_nfe_recebidasVNF: TCurrencyField
      FieldName = 'VNF'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_nfe_recebidasCHNFE: TStringField
      FieldName = 'CHNFE'
      EditMask = '##-####-##.###.###/####-##-##-###-###.###.###-###.###.###-#;0;_'
      Size = 44
    end
    object fdmt_nfe_recebidasNFERECEBIDA: TIntegerField
      FieldName = 'NFERECEBIDA'
    end
  end
  object ppm_nfe: TPopupMenu
    Images = dmRepository.iml_32
    Left = 424
    Top = 414
    object MANIFESTARCONHECIMENTO: TMenuItem
      Action = act_nfe_conhecimento
    end
    object MANIFESTARDESCONHECIMENTO: TMenuItem
      Action = act_nfe_desconhecimento
    end
    object IMPRIMIR: TMenuItem
      Action = act_nfe_imprimir
    end
    object ITENS: TMenuItem
      Action = act_nfe_itens
    end
    object CONFIRMARENTRADA: TMenuItem
      Action = act_nfe_confirmar
    end
    object AJUSTARPARAOSPED: TMenuItem
      Action = act_nfe_sped
    end
  end
  object OpenDialog: TOpenDialog
    Left = 424
    Top = 301
  end
end
