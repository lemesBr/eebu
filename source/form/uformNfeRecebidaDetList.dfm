inherited formNfeRecebidaDetList: TformNfeRecebidaDetList
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formNfeRecebidaDetList'
  ClientHeight = 740
  ClientWidth = 1024
  Color = 3618615
  Position = poDefaultSizeOnly
  WindowState = wsMaximized
  OnDestroy = FormDestroy
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
      Caption = 'ITENS DA NOTA - '
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
      object btn_categoria_store_receita: TButton
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
        Action = act_ajustar_item
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
      object btn_rollback: TButton
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
        Action = act_rollback
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
        Top = 382
        Width = 976
        Height = 2
        Align = alBottom
        ExplicitLeft = 16
        ExplicitTop = 416
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
        TabOrder = 0
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
          MaxLength = 30
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          OnKeyDown = lbe_searchKeyDown
        end
      end
      object dbg_itens: TDBGrid
        Left = 0
        Top = 97
        Width = 976
        Height = 285
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
        OnDrawColumnCell = dbg_itensDrawColumnCell
        Columns = <
          item
            Expanded = False
            FieldName = 'CPROD'
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'XPROD'
            Width = 390
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CFOP'
            Width = 35
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UCOM'
            Width = 35
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'QCOM'
            Title.Alignment = taRightJustify
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VUNCOM'
            Title.Alignment = taRightJustify
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VPROD'
            Title.Alignment = taRightJustify
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VFRETE'
            Title.Alignment = taRightJustify
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VSEG'
            Title.Alignment = taRightJustify
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VDESC'
            Title.Alignment = taRightJustify
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VOUTRO'
            Title.Alignment = taRightJustify
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VTOTAL'
            Title.Alignment = taRightJustify
            Width = 67
            Visible = True
          end>
      end
      object pnl_detalhe: TPanel
        Left = 0
        Top = 384
        Width = 976
        Height = 170
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
        ExplicitTop = 380
        object lbe_item: TLabeledEdit
          Left = 232
          Top = 26
          Width = 500
          Height = 23
          TabStop = False
          EditLabel.Width = 91
          EditLabel.Height = 15
          EditLabel.Caption = 'Item no estoque'
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'Calibri'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          LabelPosition = lpLeft
          MaxLength = 120
          ReadOnly = True
          TabOrder = 0
        end
        object lbe_item_unidade: TLabeledEdit
          Left = 232
          Top = 58
          Width = 150
          Height = 23
          TabStop = False
          EditLabel.Width = 171
          EditLabel.Height = 15
          EditLabel.Caption = 'Unidade de medida no estoque'
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'Calibri'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          LabelPosition = lpLeft
          ReadOnly = True
          TabOrder = 1
        end
        object lbe_conversor: TLabeledEdit
          Left = 232
          Top = 90
          Width = 150
          Height = 23
          TabStop = False
          EditLabel.Width = 120
          EditLabel.Height = 15
          EditLabel.Caption = 'Conversor de unidade'
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'Calibri'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          LabelPosition = lpLeft
          ReadOnly = True
          TabOrder = 2
        end
        object lbe_qtd_convertida: TLabeledEdit
          Left = 232
          Top = 122
          Width = 150
          Height = 23
          TabStop = False
          EditLabel.Width = 192
          EditLabel.Height = 15
          EditLabel.Caption = 'Qtd. do item que entra no estoque'
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'Calibri'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          LabelPosition = lpLeft
          ReadOnly = True
          TabOrder = 3
        end
      end
    end
  end
  object acl_itens: TActionList
    Images = dmRepository.iml_32
    OnUpdate = acl_itensUpdate
    Left = 424
    Top = 355
    object act_rollback: TAction
      Caption = 'ESC - RETORNAR'
      ImageIndex = 0
      ShortCut = 27
      OnExecute = act_rollbackExecute
    end
    object act_ajustar_item: TAction
      Caption = 'F2 - AJUSTAR'
      ImageIndex = 2
      ShortCut = 113
      OnExecute = act_ajustar_itemExecute
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
    Left = 331
    Top = 297
    object fdmt_itensID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_itensCPROD: TStringField
      FieldName = 'CPROD'
      Size = 60
    end
    object fdmt_itensXPROD: TStringField
      FieldName = 'XPROD'
      Size = 120
    end
    object fdmt_itensCFOP: TStringField
      FieldName = 'CFOP'
      Size = 4
    end
    object fdmt_itensUCOM: TStringField
      FieldName = 'UCOM'
      Size = 6
    end
    object fdmt_itensQCOM: TFloatField
      FieldName = 'QCOM'
      DisplayFormat = '###,###0.000'
    end
    object fdmt_itensVUNCOM: TFloatField
      FieldName = 'VUNCOM'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_itensVPROD: TFloatField
      FieldName = 'VPROD'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_itensVFRETE: TFloatField
      FieldName = 'VFRETE'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_itensVSEG: TFloatField
      FieldName = 'VSEG'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_itensVDESC: TFloatField
      FieldName = 'VDESC'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_itensVOUTRO: TFloatField
      FieldName = 'VOUTRO'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_itensVTOTAL: TFloatField
      FieldName = 'VTOTAL'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_itensITEM_ID: TStringField
      FieldName = 'ITEM_ID'
      Size = 32
    end
    object fdmt_itensUNIDADE_CONVERSAO_ID: TStringField
      FieldName = 'UNIDADE_CONVERSAO_ID'
      Size = 32
    end
  end
  object ds_itens: TDataSource
    DataSet = fdmt_itens
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
