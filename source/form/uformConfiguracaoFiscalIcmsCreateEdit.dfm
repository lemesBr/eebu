inherited formConfiguracaoFiscalIcmsCreateEdit: TformConfiguracaoFiscalIcmsCreateEdit
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formConfiguracaoFiscalIcmsCreateEdit'
  ClientHeight = 740
  ClientWidth = 1024
  Color = 3618615
  Font.Charset = ANSI_CHARSET
  Font.Height = -13
  Font.Name = 'Calibri'
  Position = poDefaultSizeOnly
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 740
  PixelsPerInch = 96
  TextHeight = 15
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
      Caption = 'ICMS UF'
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
      ExplicitTop = 79
      object lb_icms_ufst: TLabel
        Left = 212
        Top = 35
        Width = 68
        Height = 15
        Caption = '* UF Destino'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_icms_cst_csosn: TLabel
        Left = 234
        Top = 99
        Width = 46
        Height = 15
        Caption = '* CSOSN'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_icms_modbc: TLabel
        Left = 238
        Top = 131
        Width = 42
        Height = 15
        Caption = 'MODBC'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_icms_modbcst: TLabel
        Left = 226
        Top = 227
        Width = 54
        Height = 15
        Caption = 'MODBCST'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_icms_motdesicms: TLabel
        Left = 207
        Top = 355
        Width = 73
        Height = 15
        Caption = 'MOTDESICMS'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_hint: TLabel
        Left = 0
        Top = 535
        Width = 976
        Height = 19
        Align = alBottom
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 4
      end
      object cbx_cst: TComboBox
        Left = 282
        Top = 96
        Width = 120
        Height = 23
        Hint = 'Situa'#231#227'o tribut'#225'ria'
        ItemIndex = 0
        TabOrder = 2
        Text = '00'
        OnEnter = cbx_uf_destinoEnter
        Items.Strings = (
          '00'
          '10'
          '20'
          '30'
          '40'
          '41'
          '45'
          '50'
          '51'
          '60'
          '70'
          '80'
          '81'
          '90'
          '90'
          '90')
      end
      object lbe_cfop: TLabeledEdit
        Left = 282
        Top = 64
        Width = 120
        Height = 23
        Hint = 'C'#243'digo Fiscal de Opera'#231#245'es e Presta'#231#245'es'
        CharCase = ecUpperCase
        EditLabel.Width = 38
        EditLabel.Height = 13
        EditLabel.Caption = '* CFOP'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'Tahoma'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        LabelPosition = lpLeft
        MaxLength = 4
        NumbersOnly = True
        TabOrder = 1
        OnEnter = cbx_uf_destinoEnter
      end
      object lbe_picms: TLabeledEdit
        Left = 282
        Top = 192
        Width = 120
        Height = 23
        Hint = 'Al'#237'quota do imposto'
        CharCase = ecUpperCase
        EditLabel.Width = 34
        EditLabel.Height = 15
        EditLabel.Caption = 'PICMS'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        LabelPosition = lpLeft
        TabOrder = 6
        OnEnter = cbx_uf_destinoEnter
      end
      object lbe_pmvast: TLabeledEdit
        Left = 282
        Top = 256
        Width = 120
        Height = 23
        Hint = 'Percentual da margem de valor Adicionado do ICMS ST'
        CharCase = ecUpperCase
        EditLabel.Width = 45
        EditLabel.Height = 15
        EditLabel.Caption = 'PMVAST'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        LabelPosition = lpLeft
        TabOrder = 8
        OnEnter = cbx_uf_destinoEnter
      end
      object lbe_predbcst: TLabeledEdit
        Left = 282
        Top = 288
        Width = 120
        Height = 23
        Hint = 'Percentual da Redu'#231#227'o de BC do ICMS ST'
        CharCase = ecUpperCase
        EditLabel.Width = 54
        EditLabel.Height = 15
        EditLabel.Caption = 'PREDBCST'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        LabelPosition = lpLeft
        TabOrder = 9
        OnEnter = cbx_uf_destinoEnter
      end
      object lbe_picmsst: TLabeledEdit
        Left = 282
        Top = 320
        Width = 120
        Height = 23
        Hint = 'Al'#237'quota do imposto do ICMS ST'
        CharCase = ecUpperCase
        EditLabel.Width = 46
        EditLabel.Height = 15
        EditLabel.Caption = 'PICMSST'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        LabelPosition = lpLeft
        TabOrder = 10
        OnEnter = cbx_uf_destinoEnter
      end
      object lbe_pcredsn: TLabeledEdit
        Left = 282
        Top = 384
        Width = 120
        Height = 23
        Hint = 'Al'#237'quota aplic'#225'vel de c'#225'lculo do cr'#233'dito (Simples Nacional)'
        CharCase = ecUpperCase
        EditLabel.Width = 50
        EditLabel.Height = 15
        EditLabel.Caption = 'PCREDSN'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        LabelPosition = lpLeft
        TabOrder = 12
        OnEnter = cbx_uf_destinoEnter
      end
      object lbe_pdif: TLabeledEdit
        Left = 282
        Top = 416
        Width = 120
        Height = 23
        Hint = 'Percentual do diferimento'
        CharCase = ecUpperCase
        EditLabel.Width = 24
        EditLabel.Height = 15
        EditLabel.Caption = 'PDIF'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        LabelPosition = lpLeft
        TabOrder = 13
        OnEnter = cbx_uf_destinoEnter
      end
      object lbe_pfcp: TLabeledEdit
        Left = 282
        Top = 448
        Width = 120
        Height = 23
        Hint = 'Al'#237'quota do FCP'
        CharCase = ecUpperCase
        EditLabel.Width = 27
        EditLabel.Height = 15
        EditLabel.Caption = 'PFCP'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        LabelPosition = lpLeft
        TabOrder = 14
        OnEnter = cbx_uf_destinoEnter
      end
      object lbe_pfcpst: TLabeledEdit
        Left = 282
        Top = 480
        Width = 120
        Height = 23
        Hint = 'Percentual do FCP retido por Substitui'#231#227'o Tribut'#225'ria'
        CharCase = ecUpperCase
        EditLabel.Width = 39
        EditLabel.Height = 15
        EditLabel.Caption = 'PFCPST'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        LabelPosition = lpLeft
        TabOrder = 15
        OnEnter = cbx_uf_destinoEnter
      end
      object lbe_pfcpstret: TLabeledEdit
        Left = 532
        Top = 32
        Width = 120
        Height = 23
        Hint = 
          'Percentual do FCP retido anteriormente por Substitui'#231#227'o Tribut'#225'r' +
          'ia'
        CharCase = ecUpperCase
        EditLabel.Width = 58
        EditLabel.Height = 15
        EditLabel.Caption = 'PFCPSTRET'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        LabelPosition = lpLeft
        TabOrder = 16
        OnEnter = cbx_uf_destinoEnter
      end
      object lbe_pfcpufdest: TLabeledEdit
        Left = 532
        Top = 64
        Width = 120
        Height = 23
        Hint = 
          'Percentual do ICMS relativo ao Fundo de Combate '#224' Pobreza (FCP) ' +
          'na UF de destino'
        CharCase = ecUpperCase
        EditLabel.Width = 67
        EditLabel.Height = 15
        EditLabel.Caption = 'PFCPUFDEST'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        LabelPosition = lpLeft
        TabOrder = 17
        OnEnter = cbx_uf_destinoEnter
      end
      object lbe_picmsufdest: TLabeledEdit
        Left = 532
        Top = 96
        Width = 120
        Height = 23
        Hint = 'Al'#237'quota interna da UF de destino'
        CharCase = ecUpperCase
        EditLabel.Width = 74
        EditLabel.Height = 15
        EditLabel.Caption = 'PICMSUFDEST'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        LabelPosition = lpLeft
        TabOrder = 18
        OnEnter = cbx_uf_destinoEnter
      end
      object lbe_picmsinter: TLabeledEdit
        Left = 532
        Top = 128
        Width = 120
        Height = 23
        Hint = 'Al'#237'quota interestadual das UF envolvidas'
        CharCase = ecUpperCase
        EditLabel.Width = 65
        EditLabel.Height = 15
        EditLabel.Caption = 'PICMSINTER'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        LabelPosition = lpLeft
        TabOrder = 19
        OnEnter = cbx_uf_destinoEnter
      end
      object lbe_picmsinterpart: TLabeledEdit
        Left = 532
        Top = 160
        Width = 120
        Height = 23
        Hint = 'Percentual provis'#243'rio de partilha do ICMS Interestadual'
        CharCase = ecUpperCase
        EditLabel.Width = 92
        EditLabel.Height = 15
        EditLabel.Caption = 'PICMSINTERPART'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        LabelPosition = lpLeft
        TabOrder = 20
        OnEnter = cbx_uf_destinoEnter
      end
      object lbe_predbc: TLabeledEdit
        Left = 282
        Top = 160
        Width = 120
        Height = 23
        Hint = 'Percentual da Redu'#231#227'o de BC do ICMS ST'
        CharCase = ecUpperCase
        EditLabel.Width = 42
        EditLabel.Height = 15
        EditLabel.Caption = 'PREDBC'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        LabelPosition = lpLeft
        TabOrder = 5
        OnEnter = cbx_uf_destinoEnter
      end
      object cbx_uf_destino: TComboBox
        Left = 282
        Top = 32
        Width = 120
        Height = 23
        Hint = 'UF de destino da mercadoria'
        ItemIndex = 12
        TabOrder = 0
        Text = 'MT'
        OnEnter = cbx_uf_destinoEnter
        Items.Strings = (
          'AC'
          'AL'
          'AM'
          'AP'
          'BA'
          'CE'
          'DF'
          'ES'
          'GO'
          'MA'
          'MG'
          'MS'
          'MT'
          'PA'
          'PB'
          'PE'
          'PI'
          'PR'
          'RJ'
          'RN'
          'RO'
          'RR'
          'RS'
          'SC'
          'SE'
          'SP'
          'TO')
      end
      object cbx_csosn: TComboBox
        Left = 282
        Top = 96
        Width = 120
        Height = 23
        Hint = 'Situa'#231#227'o tribut'#225'ria'
        ItemIndex = 0
        TabOrder = 3
        Text = '101'
        OnEnter = cbx_uf_destinoEnter
        Items.Strings = (
          '101'
          '102'
          '103'
          '201'
          '202'
          '203'
          '300'
          '400'
          '500'
          '900')
      end
      object cbx_modbc: TComboBox
        Left = 282
        Top = 128
        Width = 120
        Height = 23
        Hint = 'Modalidade de determina'#231#227'o da BC do ICMS'
        ItemIndex = 0
        TabOrder = 4
        Text = '0'
        OnEnter = cbx_uf_destinoEnter
        Items.Strings = (
          '0'
          '1'
          '2'
          '3')
      end
      object cbx_modbcst: TComboBox
        Left = 282
        Top = 224
        Width = 120
        Height = 23
        Hint = 'Modalidade de determina'#231#227'o da BC do ICMS ST'
        ItemIndex = 0
        TabOrder = 7
        Text = '0'
        OnEnter = cbx_uf_destinoEnter
        Items.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '5')
      end
      object cbx_motdesicms: TComboBox
        Left = 282
        Top = 352
        Width = 120
        Height = 23
        Hint = 'Motivo da desonera'#231#227'o do ICMS'
        ItemIndex = 0
        TabOrder = 11
        Text = '1'
        OnEnter = cbx_uf_destinoEnter
        Items.Strings = (
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10'
          '11'
          '12'
          '16')
      end
    end
  end
  object acl_icms_uf: TActionList
    Images = dmRepository.iml_32
    Left = 952
    Top = 589
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
