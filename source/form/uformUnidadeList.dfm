inherited formUnidadeList: TformUnidadeList
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formUnidadeList'
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
    object pnl_unidades_head: TPanel
      Left = 21
      Top = 1
      Width = 976
      Height = 80
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'UNIDADES'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Bombardier'
      Font.Style = []
      Padding.Top = 10
      Padding.Bottom = 10
      ParentColor = True
      ParentFont = False
      TabOrder = 0
    end
    object pnl_unidades_foooter: TPanel
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
      object btn_unidade_export: TButton
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
        Action = act_unidade_export
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
      object btn_unidade_store: TButton
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
        Action = act_unidade_store
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
      object btn_unidade_update: TButton
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
        Action = act_unidade_update
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
      object btn_rollback: TButton
        AlignWithMargins = True
        Left = 201
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
      object btn_unidade_destroy: TButton
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
        Action = act_unidade_destroy
        Align = alRight
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Bombardier'
        Font.Style = [fsUnderline]
        Images = dmRepository.iml_32
        ParentFont = False
        TabOrder = 4
        TabStop = False
        WordWrap = True
      end
    end
    object pnl_unidades_body: TPanel
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
      object pnl_unidades_search: TPanel
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
        object lbe_unidades_search: TLabeledEdit
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
          OnKeyDown = lbe_unidades_searchKeyDown
        end
      end
      object dbg_unidades: TDBGrid
        Left = 0
        Top = 97
        Width = 976
        Height = 457
        TabStop = False
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DataSource = ds_unidades
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
        OnDrawColumnCell = dbg_unidadesDrawColumnCell
        Columns = <
          item
            Expanded = False
            FieldName = 'NOME'
            Width = 300
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UNIDADE'
            Title.Caption = 'ABREVIATURA'
            Width = 100
            Visible = True
          end>
      end
    end
  end
  object acl_unidades: TActionList
    Images = dmRepository.iml_32
    OnUpdate = acl_unidadesUpdate
    Left = 424
    Top = 355
    object act_rollback: TAction
      Caption = 'ESC - RETORNAR'
      ImageIndex = 0
      ShortCut = 27
      OnExecute = act_rollbackExecute
    end
    object act_unidade_store: TAction
      Caption = 'F2 - NOVA'
      ImageIndex = 1
      ShortCut = 113
      OnExecute = act_unidade_storeExecute
    end
    object act_unidade_update: TAction
      Caption = 'F3 - EDITAR'
      ImageIndex = 2
      ShortCut = 114
      OnExecute = act_unidade_updateExecute
    end
    object act_unidade_destroy: TAction
      Caption = 'F4 - REMOVER'
      ImageIndex = 3
      ShortCut = 115
      OnExecute = act_unidade_destroyExecute
    end
    object act_unidade_export: TAction
      Caption = 'F12 - EXPORTAR'
      ImageIndex = 5
      ShortCut = 123
      OnExecute = act_unidade_exportExecute
    end
  end
  object fdmt_unidades: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 331
    Top = 297
    object fdmt_unidadesID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_unidadesNOME: TStringField
      FieldName = 'NOME'
      Size = 255
    end
    object fdmt_unidadesUNIDADE: TStringField
      FieldName = 'UNIDADE'
      Size = 6
    end
  end
  object tmr_focus: TTimer
    Enabled = False
    OnTimer = tmr_focusTimer
    Left = 328
    Top = 421
  end
  object ds_unidades: TDataSource
    DataSet = fdmt_unidades
    Left = 331
    Top = 353
  end
end
