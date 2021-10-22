inherited formCompraItensAjuste: TformCompraItensAjuste
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formCompraItensAjuste'
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
      ExplicitLeft = 0
      ExplicitTop = 88
    end
    object pnl_header: TPanel
      Left = 21
      Top = 1
      Width = 976
      Height = 80
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'AJUSTE'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Bombardier'
      Font.Style = []
      Padding.Top = 15
      Padding.Bottom = 15
      ParentBackground = False
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
      object btn_retornar: TButton
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
        Action = act_retornar
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
      object btn_prosseguir: TButton
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
        Action = act_prosseguir
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
      object btn_salvar: TButton
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
        Action = act_salvar
        Align = alRight
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Bombardier'
        Font.Style = [fsUnderline]
        Images = dmRepository.iml_32
        ParentFont = False
        TabOrder = 2
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
      object dbg_itens: TDBGrid
        Left = 0
        Top = 97
        Width = 976
        Height = 275
        Cursor = crHandPoint
        TabStop = False
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DataSource = ds_itens
        DrawingStyle = gdsClassic
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Courier New'
        TitleFont.Style = []
        OnDrawColumnCell = dbg_itensDrawColumnCell
        Columns = <
          item
            Expanded = False
            FieldName = 'NOME'
            Title.Caption = 'ITEM'
            Width = 355
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRECO_COMPRA'
            Title.Alignment = taRightJustify
            Title.Caption = 'VL. COMPRA'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRECO_VENDA'
            Title.Alignment = taRightJustify
            Title.Caption = 'VL. VENDA'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRECO_ULTIMA_COMPRA'
            Title.Alignment = taRightJustify
            Title.Caption = 'VL. ULTIMA COMPRA'
            Width = 150
            Visible = True
          end>
      end
      object pnl_search: TPanel
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
        TabOrder = 1
        object lbe_search: TLabeledEdit
          Left = 238
          Top = 28
          Width = 500
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
          MaxLength = 14
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          OnKeyDown = lbe_searchKeyDown
        end
      end
      object pnl_totais: TPanel
        Left = 0
        Top = 372
        Width = 976
        Height = 182
        Align = alBottom
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentColor = True
        ParentFont = False
        TabOrder = 2
        object Bevel1: TBevel
          Left = 0
          Top = 0
          Width = 976
          Height = 2
          Align = alTop
          ExplicitTop = 88
        end
        object lbe_preco_compra: TLabeledEdit
          Left = 232
          Top = 32
          Width = 100
          Height = 23
          CharCase = ecUpperCase
          EditLabel.Width = 75
          EditLabel.Height = 15
          EditLabel.Caption = 'Vl. de compra'
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'Calibri'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          Enabled = False
          LabelPosition = lpLeft
          ReadOnly = True
          TabOrder = 0
        end
        object lbe_preco_ultima_compra: TLabeledEdit
          Left = 232
          Top = 64
          Width = 100
          Height = 23
          CharCase = ecUpperCase
          EditLabel.Width = 115
          EditLabel.Height = 15
          EditLabel.Caption = 'Ultimo Vl. de compra'
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'Calibri'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          Enabled = False
          LabelPosition = lpLeft
          ReadOnly = True
          TabOrder = 1
        end
        object lbe_diferenca_percentual: TLabeledEdit
          Left = 232
          Top = 96
          Width = 100
          Height = 23
          CharCase = ecUpperCase
          EditLabel.Width = 130
          EditLabel.Height = 15
          EditLabel.Caption = 'Percentual de diferen'#231'a'
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'Calibri'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          Enabled = False
          LabelPosition = lpLeft
          ReadOnly = True
          TabOrder = 2
        end
        object lbe_diferenca: TLabeledEdit
          Left = 232
          Top = 128
          Width = 100
          Height = 23
          CharCase = ecUpperCase
          EditLabel.Width = 98
          EditLabel.Height = 15
          EditLabel.Caption = 'Valor da diferen'#231'a'
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'Calibri'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          Enabled = False
          LabelPosition = lpLeft
          ReadOnly = True
          TabOrder = 3
        end
        object lbe_preco_ultima_compra_01: TLabeledEdit
          Left = 532
          Top = 32
          Width = 100
          Height = 23
          CharCase = ecUpperCase
          EditLabel.Width = 115
          EditLabel.Height = 15
          EditLabel.Caption = 'Ultimo Vl. de compra'
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'Calibri'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          Enabled = False
          LabelPosition = lpLeft
          ReadOnly = True
          TabOrder = 4
        end
        object lbe_preco_venda: TLabeledEdit
          Left = 532
          Top = 64
          Width = 100
          Height = 23
          CharCase = ecUpperCase
          EditLabel.Width = 67
          EditLabel.Height = 15
          EditLabel.Caption = 'Vl. de venda'
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'Calibri'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          LabelPosition = lpLeft
          TabOrder = 5
        end
        object lbe_margem_percentual: TLabeledEdit
          Left = 532
          Top = 96
          Width = 100
          Height = 23
          CharCase = ecUpperCase
          EditLabel.Width = 106
          EditLabel.Height = 15
          EditLabel.Caption = 'Percentual de lucro'
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'Calibri'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          LabelPosition = lpLeft
          TabOrder = 6
        end
        object lbe_margem: TLabeledEdit
          Left = 532
          Top = 128
          Width = 100
          Height = 23
          CharCase = ecUpperCase
          EditLabel.Width = 75
          EditLabel.Height = 15
          EditLabel.Caption = 'Valor de lucro'
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'Calibri'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          LabelPosition = lpLeft
          TabOrder = 7
        end
      end
    end
  end
  object fdmt_itens: TFDMemTable
    AfterScroll = fdmt_itensAfterScroll
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 339
    Top = 337
    object fdmt_itensITEM_ID: TStringField
      FieldName = 'ITEM_ID'
      Size = 32
    end
    object fdmt_itensREFERENCIA: TIntegerField
      FieldName = 'REFERENCIA'
    end
    object fdmt_itensNOME: TStringField
      FieldName = 'NOME'
      Size = 120
    end
    object fdmt_itensUNIDADE: TStringField
      FieldName = 'UNIDADE'
      Size = 6
    end
    object fdmt_itensPRECO_COMPRA: TFloatField
      FieldName = 'PRECO_COMPRA'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_itensPRECO_VENDA: TFloatField
      FieldName = 'PRECO_VENDA'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_itensPRECO_ULTIMA_COMPRA: TFloatField
      FieldName = 'PRECO_ULTIMA_COMPRA'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_itensDIFERENCA_PERCENTUAL: TFloatField
      FieldName = 'DIFERENCA_PERCENTUAL'
    end
    object fdmt_itensDIFERENCA: TFloatField
      FieldName = 'DIFERENCA'
    end
    object fdmt_itensMARGEM_PERCENTUAL: TFloatField
      FieldName = 'MARGEM_PERCENTUAL'
    end
    object fdmt_itensMARGEM: TFloatField
      FieldName = 'MARGEM'
    end
  end
  object ds_itens: TDataSource
    DataSet = fdmt_itens
    Left = 339
    Top = 393
  end
  object acl_ajuste: TActionList
    Images = dmRepository.iml_32
    OnUpdate = acl_ajusteUpdate
    Left = 340
    Top = 285
    object act_retornar: TAction
      Caption = 'RETORNAR'
      ImageIndex = 0
      OnExecute = act_retornarExecute
    end
    object act_salvar: TAction
      Caption = 'SALVAR'
      ImageIndex = 6
      OnExecute = act_salvarExecute
    end
    object act_prosseguir: TAction
      Caption = 'PROSSEGUIR'
      ImageIndex = 16
      OnExecute = act_prosseguirExecute
    end
  end
end
