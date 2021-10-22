inherited formSPEDList: TformSPEDList
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formSPEDList'
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
      Caption = 'SPED'
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
        TabOrder = 0
        TabStop = False
        WordWrap = True
      end
      object btn_store: TButton
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
        Action = act_store
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
      object btn_update: TButton
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
        Action = act_update
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
      object btn_destroy: TButton
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
        Action = act_destroy
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
      object btn_sped: TButton
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
        Caption = 'SPED'
        DropDownMenu = ppm_sped
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Bombardier'
        Font.Style = [fsUnderline]
        Images = dmRepository.iml_32
        ParentFont = False
        Style = bsSplitButton
        TabOrder = 4
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
      ParentColor = True
      TabOrder = 2
      object dbg_sped: TDBGrid
        Left = 0
        Top = 0
        Width = 976
        Height = 554
        Cursor = crHandPoint
        TabStop = False
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DataSource = ds_sped
        DrawingStyle = gdsClassic
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
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
        OnDrawColumnCell = dbg_spedDrawColumnCell
        Columns = <
          item
            Expanded = False
            FieldName = 'DT_INI'
            Title.Caption = 'REFERENTE'
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SPED_STATUS'
            Title.Alignment = taCenter
            Title.Caption = '_'
            Width = 30
            Visible = True
          end>
      end
    end
  end
  object acl_sped: TActionList
    Images = dmRepository.iml_32
    OnUpdate = acl_spedUpdate
    Left = 408
    Top = 299
    object act_rollback: TAction
      Caption = 'ESC - RETORNAR'
      ImageIndex = 0
      ShortCut = 27
      OnExecute = act_rollbackExecute
    end
    object act_store: TAction
      Caption = 'F2 - NOVO'
      ImageIndex = 1
      ShortCut = 113
      OnExecute = act_storeExecute
    end
    object act_update: TAction
      Caption = 'F3 - EDITAR'
      ImageIndex = 2
      OnExecute = act_updateExecute
    end
    object act_destroy: TAction
      Caption = 'F3 - REMOVER'
      ImageIndex = 3
      OnExecute = act_destroyExecute
    end
    object act_sped_gerar: TAction
      Caption = 'GERAR SPED'
      ImageIndex = 6
      ShortCut = 115
      OnExecute = act_sped_gerarExecute
    end
    object act_sped_enviar: TAction
      Caption = 'ENVIAR EMAIL'
      ImageIndex = 5
      ShortCut = 116
      OnExecute = act_sped_enviarExecute
    end
  end
  object fdmt_sped: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 331
    Top = 297
    object fdmt_spedID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_spedDT_INI: TDateField
      FieldName = 'DT_INI'
      DisplayFormat = 'yyyymm'
    end
    object fdmt_spedSPED_STATUS: TIntegerField
      FieldName = 'SPED_STATUS'
    end
  end
  object ds_sped: TDataSource
    DataSet = fdmt_sped
    Left = 331
    Top = 353
  end
  object ppm_sped: TPopupMenu
    AutoPopup = False
    Images = dmRepository.iml_32
    Left = 408
    Top = 354
    object GERARSPED: TMenuItem
      Action = act_sped_gerar
    end
    object ENVIAREMAIL: TMenuItem
      Action = act_sped_enviar
    end
  end
end
