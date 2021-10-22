inherited formCompraFinalizar: TformCompraFinalizar
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formCompraFinalizar'
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
      Caption = 'FINALIZANDO COMPRA'
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
      object btn_retornar: TButton
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
        Action = act_retornar
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
      ParentColor = True
      TabOrder = 2
      object dbg_parcelas: TDBGrid
        Left = 0
        Top = 100
        Width = 976
        Height = 454
        TabStop = False
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DataSource = ds_parcelas
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
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 976
        Height = 100
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentColor = True
        ParentFont = False
        TabOrder = 1
        object Bevel2: TBevel
          Left = 0
          Top = 98
          Width = 976
          Height = 2
          Align = alBottom
          ExplicitTop = 8
        end
        object lb_parcelas: TLabel
          Left = 712
          Top = 20
          Width = 121
          Height = 15
          Caption = '* Foma de pagamento'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lb_vencimento: TLabel
          Left = 552
          Top = 20
          Width = 75
          Height = 15
          Caption = '* Vencimento'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object cbx_parcelas: TComboBox
          Left = 712
          Top = 39
          Width = 150
          Height = 23
          TabOrder = 3
          OnSelect = cbx_parcelasSelect
        end
        object dtp_vencimento: TDateTimePicker
          Left = 552
          Top = 39
          Width = 150
          Height = 23
          Date = 43104.653521701390000000
          Time = 43104.653521701390000000
          TabOrder = 2
        end
        object lbe_conta: TLabeledEdit
          Left = 32
          Top = 39
          Width = 250
          Height = 23
          EditLabel.Width = 78
          EditLabel.Height = 15
          EditLabel.Caption = '* Conta - ( F1 )'
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'Calibri'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnKeyDown = lbe_contaKeyDown
        end
        object lbe_categoria: TLabeledEdit
          Left = 292
          Top = 39
          Width = 250
          Height = 23
          EditLabel.Width = 98
          EditLabel.Height = 15
          EditLabel.Caption = '* Categoria - ( F1 )'
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'Calibri'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          ReadOnly = True
          TabOrder = 1
          OnKeyDown = lbe_categoriaKeyDown
        end
      end
    end
  end
  object acl_compra_finalizar: TActionList
    Images = dmRepository.iml_32
    Left = 696
    Top = 261
    object act_retornar: TAction
      Caption = 'RETORNAR'
      ImageIndex = 0
      OnExecute = act_retornarExecute
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
    Left = 328
    Top = 405
  end
end
