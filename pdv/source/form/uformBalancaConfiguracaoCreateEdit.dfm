inherited formBalancaConfiguracaoCreateEdit: TformBalancaConfiguracaoCreateEdit
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formBalancaConfiguracaoCreateEdit'
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
      Caption = 'CONFIG'
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
      object lb_modelo: TLabel
        Left = 32
        Top = 14
        Width = 45
        Height = 15
        Caption = 'Balanca'
      end
      object lb_handshake: TLabel
        Left = 192
        Top = 14
        Width = 72
        Height = 15
        Caption = 'Handshaking'
      end
      object lb_parity: TLabel
        Left = 302
        Top = 14
        Width = 33
        Height = 15
        Caption = 'Parity'
      end
      object lb_stop: TLabel
        Left = 412
        Top = 14
        Width = 48
        Height = 15
        Caption = 'Stop Bits'
      end
      object lb_data: TLabel
        Left = 522
        Top = 14
        Width = 50
        Height = 15
        Caption = 'Data Bits'
      end
      object lb_baud: TLabel
        Left = 632
        Top = 14
        Width = 53
        Height = 15
        Caption = 'Baud rate'
      end
      object lb_porta: TLabel
        Left = 742
        Top = 14
        Width = 65
        Height = 15
        Caption = 'Porta Serial'
      end
      object Bevel1: TBevel
        Left = 0
        Top = 88
        Width = 976
        Height = 2
        Align = alCustom
      end
      object lb_peso: TLabel
        Left = 310
        Top = 326
        Width = 137
        Height = 15
        Caption = 'C'#243'digo de barras contem'
      end
      object cbx_modelo: TComboBox
        Left = 32
        Top = 32
        Width = 150
        Height = 23
        Style = csDropDownList
        TabOrder = 0
      end
      object cbx_handshake: TComboBox
        Left = 192
        Top = 32
        Width = 100
        Height = 23
        Style = csDropDownList
        TabOrder = 1
      end
      object cbx_parity: TComboBox
        Left = 302
        Top = 32
        Width = 100
        Height = 23
        Style = csDropDownList
        TabOrder = 2
      end
      object cbx_stop: TComboBox
        Left = 412
        Top = 32
        Width = 100
        Height = 23
        Style = csDropDownList
        TabOrder = 3
      end
      object cbx_data: TComboBox
        Left = 522
        Top = 32
        Width = 100
        Height = 23
        Style = csDropDownList
        ItemIndex = 3
        TabOrder = 4
        Text = '8'
        Items.Strings = (
          '5'
          '6'
          '7'
          '8')
      end
      object cbx_baud: TComboBox
        Left = 632
        Top = 32
        Width = 100
        Height = 23
        Style = csDropDownList
        ItemIndex = 6
        TabOrder = 5
        Text = '9600'
        Items.Strings = (
          '110'
          '300'
          '600'
          '1200'
          '2400'
          '4800'
          '9600'
          '14400'
          '19200'
          '38400'
          '56000'
          '57600')
      end
      object cbx_porta: TComboBox
        Left = 742
        Top = 32
        Width = 100
        Height = 23
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 6
        Text = 'COM1'
        Items.Strings = (
          'COM1'
          'COM2'
          'COM3'
          'COM4'
          'COM5'
          'COM6'
          'COM7'
          'COM8')
      end
      object lbe_time_out: TLabeledEdit
        Left = 852
        Top = 32
        Width = 85
        Height = 23
        EditLabel.Width = 46
        EditLabel.Height = 15
        EditLabel.Caption = 'TimeOut'
        NumbersOnly = True
        TabOrder = 7
        Text = '2000'
      end
      object lbe_digito_inicial: TLabeledEdit
        Left = 450
        Top = 149
        Width = 80
        Height = 23
        EditLabel.Width = 380
        EditLabel.Height = 15
        EditLabel.Caption = 
          'D'#237'gito inicial que identifica um c'#243'digo de barras gerado pela ba' +
          'lan'#231'a'
        LabelPosition = lpLeft
        MaxLength = 2
        NumbersOnly = True
        TabOrder = 9
        Text = '2'
      end
      object lbe_digitos: TLabeledEdit
        Left = 450
        Top = 120
        Width = 80
        Height = 23
        EditLabel.Width = 308
        EditLabel.Height = 15
        EditLabel.Caption = 'Tamanho total do c'#243'digo de barras gerado pela balan'#231'a'
        LabelPosition = lpLeft
        MaxLength = 2
        NumbersOnly = True
        TabOrder = 8
        Text = '13'
      end
      object lbe_produto_digito_inicial: TLabeledEdit
        Left = 450
        Top = 178
        Width = 80
        Height = 23
        EditLabel.Width = 192
        EditLabel.Height = 15
        EditLabel.Caption = 'D'#237'gito inicial do c'#243'digo do produto'
        LabelPosition = lpLeft
        MaxLength = 2
        NumbersOnly = True
        TabOrder = 10
        Text = '2'
      end
      object lbe_produto_digito_final: TLabeledEdit
        Left = 450
        Top = 207
        Width = 80
        Height = 23
        EditLabel.Width = 181
        EditLabel.Height = 15
        EditLabel.Caption = 'D'#237'gito final do c'#243'digo do produto'
        LabelPosition = lpLeft
        MaxLength = 2
        NumbersOnly = True
        TabOrder = 11
        Text = '6'
      end
      object lbe_peso_digito_inicial: TLabeledEdit
        Left = 450
        Top = 236
        Width = 80
        Height = 23
        EditLabel.Width = 230
        EditLabel.Height = 15
        EditLabel.Caption = 'D'#237'gito inicial do Peso ou Valor do produto'
        LabelPosition = lpLeft
        MaxLength = 2
        NumbersOnly = True
        TabOrder = 12
        Text = '7'
      end
      object lbe_peso_digito_final: TLabeledEdit
        Left = 450
        Top = 265
        Width = 80
        Height = 23
        EditLabel.Width = 223
        EditLabel.Height = 15
        EditLabel.Caption = 'D'#237'gito finall do Peso ou Valor do produto'
        LabelPosition = lpLeft
        MaxLength = 2
        NumbersOnly = True
        TabOrder = 13
        Text = '13'
      end
      object lbe_peso_digitos_decimal: TLabeledEdit
        Left = 450
        Top = 294
        Width = 80
        Height = 23
        EditLabel.Width = 238
        EditLabel.Height = 15
        EditLabel.Caption = 'Total de casas decimais para Peso ou Valor'
        LabelPosition = lpLeft
        MaxLength = 2
        NumbersOnly = True
        TabOrder = 14
        Text = '3'
      end
      object cbx_peso: TComboBox
        Left = 450
        Top = 323
        Width = 80
        Height = 23
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 15
        Text = 'Valor'
        Items.Strings = (
          'Peso'
          'Valor')
      end
    end
  end
  object acl_config: TActionList
    Images = dmRepository.iml_32
    Left = 608
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
end
