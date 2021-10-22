inherited formNcmIBPTax: TformNcmIBPTax
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = ''
  ClientHeight = 740
  ClientWidth = 1024
  Color = 3618615
  Position = poDefaultSizeOnly
  WindowState = wsMaximized
  StyleElements = []
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
      Caption = 'NCM'
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
      object btn_export: TButton
        AlignWithMargins = True
        Left = 816
        Top = 10
        Width = 150
        Height = 60
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 0
        Action = act_ncm_export
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
        ExplicitLeft = 766
      end
      object btn_rollback: TButton
        AlignWithMargins = True
        Left = 506
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
        ExplicitLeft = 356
      end
      object btn_update: TButton
        AlignWithMargins = True
        Left = 661
        Top = 10
        Width = 150
        Height = 60
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 0
        Action = act_ncm_update
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
        ExplicitLeft = 561
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
        ExplicitTop = 503
      end
      object bvl_4: TBevel
        Left = 0
        Top = 439
        Width = 976
        Height = 2
        Align = alBottom
        ExplicitLeft = -8
        ExplicitTop = 460
      end
      object dbg_ncms: TDBGrid
        Left = 0
        Top = 97
        Width = 976
        Height = 342
        TabStop = False
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DataSource = ds_impostos
        DrawingStyle = gdsClassic
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Courier New'
        TitleFont.Style = [fsUnderline]
        OnDrawColumnCell = dbg_ncmsDrawColumnCell
        Columns = <
          item
            Expanded = False
            FieldName = 'NCM'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NACIONAL'
            Title.Alignment = taRightJustify
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IMPORTADO'
            Title.Alignment = taRightJustify
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ESTADUAL'
            Title.Alignment = taRightJustify
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MUNICIPAL'
            Title.Alignment = taRightJustify
            Width = 120
            Visible = True
          end>
      end
      object dbm_descricao: TDBMemo
        Left = 0
        Top = 441
        Width = 976
        Height = 113
        Align = alBottom
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        DataField = 'DESCRICAO'
        DataSource = ds_impostos
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        ExplicitTop = 454
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
        TabOrder = 2
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
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          OnKeyDown = lbe_searchKeyDown
        end
      end
    end
  end
  object ACBrIBPTax: TACBrIBPTax
    ProxyPort = '8080'
    Left = 856
    Top = 221
  end
  object fdmt_impostos: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 355
    Top = 305
    object fdmt_impostosNCM: TStringField
      FieldName = 'NCM'
      Size = 8
    end
    object fdmt_impostosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 255
    end
    object fdmt_impostosNACIONAL: TFloatField
      FieldName = 'NACIONAL'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_impostosIMPORTADO: TFloatField
      FieldName = 'IMPORTADO'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_impostosESTADUAL: TFloatField
      FieldName = 'ESTADUAL'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_impostosMUNICIPAL: TFloatField
      FieldName = 'MUNICIPAL'
      DisplayFormat = '###,##0.00'
    end
  end
  object ds_impostos: TDataSource
    DataSet = fdmt_impostos
    Left = 355
    Top = 361
  end
  object opd_csv: TOpenDialog
    Filter = 'Arquivo .csv|*.csv'
    Left = 856
    Top = 285
  end
  object acl_categorias: TActionList
    Images = dmRepository.iml_32
    OnUpdate = acl_categoriasUpdate
    Left = 472
    Top = 339
    object act_rollback: TAction
      Caption = 'ESC - RETORNAR'
      ImageIndex = 0
      ShortCut = 27
      OnExecute = act_rollbackExecute
    end
    object act_ncm_update: TAction
      Caption = 'F2 - ATUALIZAR'
      ImageIndex = 2
      ShortCut = 113
      OnExecute = act_ncm_updateExecute
    end
    object act_ncm_export: TAction
      Caption = 'F12 - EXPORTAR'
      ImageIndex = 5
      ShortCut = 123
      OnExecute = act_ncm_exportExecute
    end
  end
  object tmr_focus: TTimer
    Enabled = False
    OnTimer = tmr_focusTimer
    Left = 352
    Top = 429
  end
end
