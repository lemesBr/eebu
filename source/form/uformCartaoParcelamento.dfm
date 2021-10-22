inherited formCartaoParcelamento: TformCartaoParcelamento
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formCartaoParcelamento'
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
      Caption = 'MODELO'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Bombardier'
      Font.Style = []
      Padding.Top = 15
      Padding.Bottom = 15
      ParentColor = True
      ParentFont = False
      TabOrder = 1
    end
    object pnl_footer: TPanel
      Left = 21
      Top = 639
      Width = 976
      Height = 80
      Align = alBottom
      BevelOuter = bvNone
      Color = clWhite
      Padding.Top = 10
      Padding.Bottom = 10
      ParentBackground = False
      TabOrder = 2
      object btn_cancelar: TButton
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
        Action = act_cancelar
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
      object btn_confirmar: TButton
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
        Action = act_confirmar
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
        OnKeyDown = btn_confirmarKeyDown
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
      TabOrder = 0
      object bvl_3: TBevel
        Left = 400
        Top = 0
        Width = 2
        Height = 554
        Align = alLeft
        ExplicitLeft = 560
        ExplicitTop = 72
      end
      object pnl_cartao: TPanel
        Left = 0
        Top = 0
        Width = 400
        Height = 554
        Align = alLeft
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object dbg_cartao: TDBGrid
          Left = 0
          Top = 0
          Width = 400
          Height = 554
          Align = alClient
          BorderStyle = bsNone
          Color = clWhite
          Ctl3D = False
          DataSource = ds_cartoes
          DrawingStyle = gdsClassic
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Courier New'
          TitleFont.Style = [fsUnderline]
          OnDrawColumnCell = dbg_cartaoDrawColumnCell
          OnKeyDown = dbg_cartaoKeyDown
          Columns = <
            item
              Expanded = False
              FieldName = 'NOME'
              Title.Caption = 'BANDEIRA'
              Width = 383
              Visible = True
            end>
        end
      end
      object pnl_parcelamento: TPanel
        Left = 402
        Top = 0
        Width = 574
        Height = 554
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object dbg_parcelamento: TDBGrid
          Left = 0
          Top = 0
          Width = 574
          Height = 554
          Align = alClient
          BorderStyle = bsNone
          Color = clWhite
          Ctl3D = False
          DataSource = ds_parcelamento
          DrawingStyle = gdsClassic
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Courier New'
          TitleFont.Style = [fsUnderline]
          OnDrawColumnCell = dbg_cartaoDrawColumnCell
          OnKeyDown = dbg_parcelamentoKeyDown
          Columns = <
            item
              Expanded = False
              FieldName = 'NOME'
              Title.Caption = 'PARCELAMENTO'
              Width = 557
              Visible = True
            end>
        end
      end
    end
  end
  object acl_cartao: TActionList
    Images = dmRepository.iml_32
    Left = 624
    Top = 37
    object act_cancelar: TAction
      Caption = 'CANCELAR'
      ImageIndex = 0
      OnExecute = act_cancelarExecute
    end
    object act_confirmar: TAction
      Caption = 'CONFIRMAR'
      ImageIndex = 6
      OnExecute = act_confirmarExecute
    end
  end
  object fdmt_cartoes: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 67
    Top = 193
    object fdmt_cartoesID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_cartoesNOME: TStringField
      FieldName = 'NOME'
      Size = 255
    end
  end
  object ds_cartoes: TDataSource
    DataSet = fdmt_cartoes
    Left = 67
    Top = 249
  end
  object fdmt_parcelamento: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 507
    Top = 161
    object fdmt_parcelamentoPARCELAMENTO: TIntegerField
      FieldName = 'PARCELAMENTO'
    end
    object fdmt_parcelamentoNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
  end
  object ds_parcelamento: TDataSource
    DataSet = fdmt_parcelamento
    Left = 507
    Top = 217
  end
end
