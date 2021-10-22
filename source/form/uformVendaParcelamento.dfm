inherited formVendaParcelamento: TformVendaParcelamento
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formVendaParcelamento'
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
      Caption = 'PARCELAMENTO'
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
        TabOrder = 0
        TabStop = False
        WordWrap = True
      end
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
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 2
      object lb_vencimento: TLabel
        Left = 162
        Top = 14
        Width = 87
        Height = 15
        Caption = '* P. Vencimento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_parcelamento: TLabel
        Left = 292
        Top = 14
        Width = 85
        Height = 15
        Caption = '* Parcelamento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Bevel1: TBevel
        Left = 0
        Top = 72
        Width = 976
        Height = 2
        Align = alBottom
        ExplicitLeft = 16
        ExplicitTop = 104
      end
      object lbe_valor: TLabeledEdit
        Left = 32
        Top = 32
        Width = 120
        Height = 23
        EditLabel.Width = 37
        EditLabel.Height = 15
        EditLabel.Caption = '* Valor'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object dtp_vencimento: TDateTimePicker
        Left = 162
        Top = 32
        Width = 120
        Height = 23
        Date = 43153.599167604170000000
        Time = 43153.599167604170000000
        TabOrder = 1
      end
      object cbx_parcelamento: TComboBox
        Left = 292
        Top = 32
        Width = 120
        Height = 23
        Style = csDropDownList
        TabOrder = 2
        OnSelect = cbx_parcelamentoSelect
      end
      object dbg_parcelas: TDBGrid
        Left = 0
        Top = 74
        Width = 976
        Height = 480
        Cursor = crHandPoint
        TabStop = False
        Align = alBottom
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DataSource = ds_parcelas
        DrawingStyle = gdsClassic
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 3
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Courier New'
        TitleFont.Style = [fsUnderline]
        OnDrawColumnCell = dbg_parcelasDrawColumnCell
        Columns = <
          item
            Expanded = False
            FieldName = 'NUMERO'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VENCIMENTO'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALOR'
            Title.Alignment = taRightJustify
            Width = 100
            Visible = True
          end>
      end
    end
  end
  object acl_venda_parcelamento: TActionList
    Images = dmRepository.iml_32
    OnUpdate = acl_venda_parcelamentoUpdate
    Left = 696
    Top = 261
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
  object fdmt_parcelas: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 331
    Top = 353
    object fdmt_parcelasVENCIMENTO: TDateField
      FieldName = 'VENCIMENTO'
    end
    object fdmt_parcelasVALOR: TCurrencyField
      FieldName = 'VALOR'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_parcelasNUMERO: TIntegerField
      FieldName = 'NUMERO'
    end
  end
  object ds_parcelas: TDataSource
    DataSet = fdmt_parcelas
    Left = 331
    Top = 409
  end
end
