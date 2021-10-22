inherited formEstoqueList: TformEstoqueList
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formEstoqueList'
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
      Caption = 'ESTOQUE'
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
      object btn_estoque_imprimir: TButton
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
        Action = act_estoque_imprimir
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
        ExplicitLeft = 771
      end
      object btn_estoque_item_movimento: TButton
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
        Action = act_estoque_item_movimento
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
        ExplicitLeft = 616
      end
      object btn_estoque_inventario: TButton
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
        Action = act_estoque_inventario
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
        ExplicitLeft = 461
      end
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
      object bvl_4: TBevel
        Left = 0
        Top = 95
        Width = 976
        Height = 2
        Align = alTop
        ExplicitTop = 88
      end
      object pnl_estoque_search: TPanel
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
        object lbe_estoque_search: TLabeledEdit
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
          Font.Name = 'Courier New'
          Font.Style = []
          MaxLength = 14
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          OnKeyDown = lbe_estoque_searchKeyDown
        end
      end
      object dbg_estoque: TDBGrid
        Left = 0
        Top = 97
        Width = 976
        Height = 357
        Cursor = crHandPoint
        TabStop = False
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DataSource = ds_estoque
        DrawingStyle = gdsClassic
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Courier New'
        TitleFont.Style = [fsUnderline]
        OnDrawColumnCell = dbg_estoqueDrawColumnCell
        Columns = <
          item
            Expanded = False
            FieldName = 'REFERENCIA'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME'
            Width = 355
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UNIDADE'
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRECO_COMPRA'
            Title.Alignment = taRightJustify
            Title.Caption = 'CUSTO'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRECO_VENDA'
            Title.Alignment = taRightJustify
            Title.Caption = 'VENDA'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ESTOQUE'
            Title.Alignment = taRightJustify
            Title.Caption = 'QTD'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CUSTO_TOTAL'
            Title.Alignment = taRightJustify
            Title.Caption = 'CUSTO TOTAL'
            Width = 128
            Visible = True
          end>
      end
      object pnl_totais: TPanel
        Left = 0
        Top = 454
        Width = 976
        Height = 100
        Align = alBottom
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Bombardier'
        Font.Style = []
        ParentColor = True
        ParentFont = False
        TabOrder = 2
        object bvl_3: TBevel
          Left = 0
          Top = 0
          Width = 976
          Height = 2
          Align = alTop
          ExplicitTop = 88
        end
        object lb_qtd_estoque: TLabel
          Left = 743
          Top = 41
          Width = 228
          Height = 18
          Alignment = taRightJustify
          Caption = 'Quantidade total em estoque: 0,000'
        end
        object lb_custo_estoque: TLabel
          Left = 788
          Top = 61
          Width = 183
          Height = 18
          Alignment = taRightJustify
          Caption = 'Custo total em estoque: 0,00'
        end
        object lb_qtd_itens: TLabel
          Left = 924
          Top = 21
          Width = 47
          Height = 18
          Alignment = taRightJustify
          Caption = 'Itens: 0'
        end
      end
    end
  end
  object acl_estoque: TActionList
    Images = dmRepository.iml_32
    OnUpdate = acl_estoqueUpdate
    Left = 424
    Top = 355
    object act_rollback: TAction
      Caption = 'ESC - RETORNAR'
      ImageIndex = 0
      ShortCut = 27
      OnExecute = act_rollbackExecute
    end
    object act_estoque_inventario: TAction
      Caption = 'F2 - INVENT'#193'RIO'
      ImageIndex = 1
      ShortCut = 113
      OnExecute = act_estoque_inventarioExecute
    end
    object act_estoque_item_movimento: TAction
      Caption = 'F3 - MOVIMENTO'
      ImageIndex = 8
      ShortCut = 114
      OnExecute = act_estoque_item_movimentoExecute
    end
    object act_estoque_imprimir: TAction
      Caption = 'F4 - IMPRIMIR'
      ImageIndex = 8
      ShortCut = 115
      OnExecute = act_estoque_imprimirExecute
    end
  end
  object fdmt_estoque: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 331
    Top = 297
    object fdmt_estoqueID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_estoqueREFERENCIA: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'REFERENCIA'
    end
    object fdmt_estoqueNOME: TStringField
      FieldName = 'NOME'
      Size = 120
    end
    object fdmt_estoqueUNIDADE: TStringField
      Alignment = taCenter
      FieldName = 'UNIDADE'
      Size = 6
    end
    object fdmt_estoquePRECO_COMPRA: TFloatField
      FieldName = 'PRECO_COMPRA'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_estoquePRECO_VENDA: TFloatField
      FieldName = 'PRECO_VENDA'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_estoqueESTOQUE: TFloatField
      FieldName = 'ESTOQUE'
      DisplayFormat = '###,###0.000'
    end
    object fdmt_estoqueCUSTO_TOTAL: TFloatField
      FieldName = 'CUSTO_TOTAL'
      DisplayFormat = '###,##0.00'
    end
  end
  object ds_estoque: TDataSource
    DataSet = fdmt_estoque
    Left = 331
    Top = 353
  end
  object tmr_focus: TTimer
    Enabled = False
    OnTimer = tmr_focusTimer
    Left = 328
    Top = 421
  end
end
