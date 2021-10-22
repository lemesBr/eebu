inherited formFormaRecebimentoList: TformFormaRecebimentoList
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formFormaRecebimentoList'
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
    object pnl_formas_recebimentos_header: TPanel
      Left = 21
      Top = 1
      Width = 976
      Height = 80
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'FORMAS DE RECEBIMENTOS'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Bombardier'
      Font.Style = []
      Padding.Top = 15
      Padding.Bottom = 15
      ParentFont = False
      TabOrder = 0
    end
    object pnl_formas_recebimentos_footer: TPanel
      Left = 21
      Top = 639
      Width = 976
      Height = 80
      Align = alBottom
      BevelOuter = bvNone
      Padding.Top = 10
      Padding.Bottom = 10
      TabOrder = 1
      object btn_rollback: TButton
        AlignWithMargins = True
        Left = 201
        Top = 10
        Width = 190
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
        ParentFont = False
        TabOrder = 0
        TabStop = False
        WordWrap = True
        ExplicitLeft = 45
        ExplicitTop = 1
      end
      object btn_forma_recebimento_store: TButton
        AlignWithMargins = True
        Left = 396
        Top = 10
        Width = 190
        Height = 60
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 0
        Action = act_forma_recebimento_store
        Align = alRight
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Bombardier'
        Font.Style = [fsUnderline]
        ParentFont = False
        TabOrder = 1
        TabStop = False
        WordWrap = True
        ExplicitTop = 3
      end
      object btn_forma_recebimento_update: TButton
        AlignWithMargins = True
        Left = 591
        Top = 10
        Width = 190
        Height = 60
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 0
        Action = act_forma_recebimento_update
        Align = alRight
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Bombardier'
        Font.Style = [fsUnderline]
        ParentFont = False
        TabOrder = 2
        TabStop = False
        WordWrap = True
      end
      object btn_forma_recebimento_export: TButton
        AlignWithMargins = True
        Left = 786
        Top = 10
        Width = 190
        Height = 60
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = act_forma_recebimento_export
        Align = alRight
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Bombardier'
        Font.Style = [fsUnderline]
        ParentFont = False
        TabOrder = 3
        TabStop = False
        WordWrap = True
        ExplicitTop = 3
      end
    end
    object pnl_formas_recebimentos_body: TPanel
      Left = 21
      Top = 83
      Width = 976
      Height = 554
      Align = alClient
      BevelOuter = bvNone
      Padding.Top = 15
      TabOrder = 2
      object bvl_3: TBevel
        Left = 0
        Top = 95
        Width = 976
        Height = 2
        Align = alTop
        ExplicitTop = 88
      end
      object pnl_formas_recebimentos_search: TPanel
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
        ParentFont = False
        TabOrder = 0
        object lbe_formas_recebimentos_search: TLabeledEdit
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
          OnKeyDown = lbe_formas_recebimentos_searchKeyDown
        end
      end
      object dbg_formas_recebimentos: TDBGrid
        Left = 0
        Top = 97
        Width = 976
        Height = 457
        TabStop = False
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DataSource = ds_formas_recebimentos
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
        OnDrawColumnCell = dbg_formas_recebimentosDrawColumnCell
        Columns = <
          item
            Expanded = False
            FieldName = 'NOME'
            Width = 400
            Visible = True
          end>
      end
    end
  end
  object fdmt_formas_recebimentos: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 331
    Top = 297
    object fdmt_formas_recebimentosID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_formas_recebimentosTPAG: TStringField
      FieldName = 'TPAG'
      Size = 2
    end
    object fdmt_formas_recebimentosNOME: TStringField
      FieldName = 'NOME'
      Size = 255
    end
  end
  object ds_formas_recebimentos: TDataSource
    DataSet = fdmt_formas_recebimentos
    Left = 331
    Top = 353
  end
  object tmr_focus: TTimer
    Enabled = False
    OnTimer = tmr_focusTimer
    Left = 328
    Top = 421
  end
  object acl_formas_recebimentos: TActionList
    OnUpdate = acl_formas_recebimentosUpdate
    Left = 480
    Top = 363
    object act_rollback: TAction
      Caption = 'ESC - RETORNAR A JANELA ANTERIOR'
      ImageIndex = 13
      ShortCut = 27
      OnExecute = act_rollbackExecute
    end
    object act_forma_recebimento_store: TAction
      Caption = 'F2 - CADASTRAR NOVA'
      ImageIndex = 9
      ShortCut = 113
      OnExecute = act_forma_recebimento_storeExecute
    end
    object act_forma_recebimento_update: TAction
      Caption = 'F3 - EDITAR SELECIONADA'
      ImageIndex = 8
      ShortCut = 114
      OnExecute = act_forma_recebimento_updateExecute
    end
    object act_forma_recebimento_export: TAction
      Caption = 'F12 - EXPORTAR SELECIONADA'
      ImageIndex = 20
      ShortCut = 123
      OnExecute = act_forma_recebimento_exportExecute
    end
  end
end
