inherited formBoletoCreateEdit: TformBoletoCreateEdit
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formBoletoCreateEdit'
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
  object pnl_body: TPanel
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
      Caption = 'BOLETO'
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
      end
    end
    object pnl_main: TPanel
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
      object lb_tipo_cobranca: TLabel
        Left = 32
        Top = 14
        Width = 91
        Height = 15
        Caption = 'Tipo de cobran'#231'a'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object spb_path: TSpeedButton
        Left = 482
        Top = 88
        Width = 20
        Height = 23
        Cursor = crHandPoint
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = spb_pathClick
      end
      object lb_mensagem: TLabel
        Left = 32
        Top = 126
        Width = 59
        Height = 15
        Caption = 'Mensagem'
      end
      object lb_layout_remessa: TLabel
        Left = 32
        Top = 248
        Width = 102
        Height = 15
        Caption = 'Layout da remessa'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbe_carteira: TLabeledEdit
        Tag = 1
        Left = 192
        Top = 32
        Width = 150
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 53
        EditLabel.Height = 15
        EditLabel.Caption = '* Carteira'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object lbe_tarifa_cobranca: TLabeledEdit
        Left = 352
        Top = 32
        Width = 150
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 81
        EditLabel.Height = 15
        EditLabel.Caption = 'Tarifa cobrada'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object lbe_multa: TLabeledEdit
        Left = 512
        Top = 32
        Width = 150
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 33
        EditLabel.Height = 15
        EditLabel.Caption = 'Multa'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object lbe_juros: TLabeledEdit
        Left = 672
        Top = 32
        Width = 150
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 29
        EditLabel.Height = 15
        EditLabel.Caption = 'Juros'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object lbe_local_pagamento: TLabeledEdit
        Left = 512
        Top = 88
        Width = 430
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 109
        EditLabel.Height = 15
        EditLabel.Caption = 'Local de pagamento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
      end
      object lbe_nosso_numero: TLabeledEdit
        Tag = 1
        Left = 832
        Top = 32
        Width = 110
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 89
        EditLabel.Height = 15
        EditLabel.Caption = '* Nosso n'#250'mero'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        NumbersOnly = True
        ParentFont = False
        TabOrder = 7
      end
      object ckb_multa_percentual: TCheckBox
        Left = 512
        Top = 14
        Width = 39
        Height = 17
        TabStop = False
        Caption = '%'
        TabOrder = 4
      end
      object ckb_juros_percentual: TCheckBox
        Left = 672
        Top = 15
        Width = 37
        Height = 17
        TabStop = False
        Caption = '%'
        TabOrder = 6
      end
      object lbe_dir_arq_remessa: TLabeledEdit
        Tag = 1
        Left = 192
        Top = 88
        Width = 290
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 161
        EditLabel.Height = 15
        EditLabel.Caption = '* Path de arquivo de remessa'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 9
      end
      object lbe_numero_remessa: TLabeledEdit
        Tag = 1
        Left = 32
        Top = 88
        Width = 150
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 120
        EditLabel.Height = 15
        EditLabel.Caption = '* N'#250'mero da remessa'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        NumbersOnly = True
        ParentFont = False
        TabOrder = 8
      end
      object cbx_tipo_cobranca: TComboBox
        Tag = 1
        Left = 32
        Top = 32
        Width = 150
        Height = 23
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Items.Strings = (
          '00 - Banco Do Brasil'
          '01 - Santander'
          '02 - Banestes'
          '03 - Banrisul'
          '04 - Caixa Economica'
          '05 - Bradesco'
          '06 - Itau'
          '07 - Banco Mercantil'
          '08 - Sicred'
          '09 - Bancoob'
          '10 - HSBC'
          '11 - Safra Bradesco'
          '12 - Banco CECRED')
      end
      object mm_mensagem: TMemo
        Left = 32
        Top = 144
        Width = 910
        Height = 89
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 11
      end
      object cbx_layout_remessa: TComboBox
        Left = 32
        Top = 266
        Width = 150
        Height = 23
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 12
        Text = 'C400'
        Items.Strings = (
          'C400'
          'C240')
      end
    end
  end
  object acl_boleto: TActionList
    Images = dmRepository.iml_32
    Left = 584
    Top = 669
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
end
