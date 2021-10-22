inherited formCedenteCreateEdit: TformCedenteCreateEdit
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formCedenteCreateEdit'
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
      Caption = 'CEDENTE'
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
      object lbl1: TLabel
        Left = 32
        Top = 126
        Width = 85
        Height = 15
        Caption = 'Tipo de carteira'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 743
        Top = 70
        Width = 106
        Height = 15
        Caption = 'Tipo de documento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 192
        Top = 126
        Width = 87
        Height = 15
        Caption = 'Respon emiss'#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 352
        Top = 126
        Width = 62
        Height = 15
        Caption = 'Carac t'#237'tulo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Bevel2: TBevel
        Left = 0
        Top = 190
        Width = 967
        Height = 2
      end
      object lb_cep: TLabel
        Left = 32
        Top = 204
        Width = 29
        Height = 15
        Caption = '* CEP'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_fone: TLabel
        Left = 312
        Top = 260
        Width = 36
        Height = 15
        Caption = '* Fone'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_uf: TLabel
        Left = 32
        Top = 260
        Width = 27
        Height = 15
        Caption = '* UF:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbe_codigo_cedente: TLabeledEdit
        Tag = 1
        Left = 32
        Top = 32
        Width = 150
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 111
        EditLabel.Height = 15
        EditLabel.Caption = '* C'#243'digo do cedente'
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
        TabOrder = 0
      end
      object lbe_codigo_transmissao: TLabeledEdit
        Tag = 1
        Left = 192
        Top = 32
        Width = 150
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 126
        EditLabel.Height = 15
        EditLabel.Caption = 'C'#243'digo de transmiss'#227'o'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object lbe_agencia: TLabeledEdit
        Tag = 1
        Left = 822
        Top = 32
        Width = 120
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 51
        EditLabel.Height = 15
        EditLabel.Caption = '* Ag'#234'ncia'
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
        TabOrder = 4
      end
      object lbe_agencia_digito: TLabeledEdit
        Tag = 1
        Left = 32
        Top = 88
        Width = 120
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 85
        EditLabel.Height = 15
        EditLabel.Caption = '* Ag'#234'ncia digito'
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
        TabOrder = 5
      end
      object lbe_conta: TLabeledEdit
        Tag = 1
        Left = 162
        Top = 88
        Width = 120
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 41
        EditLabel.Height = 15
        EditLabel.Caption = '* Conta'
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
        TabOrder = 6
      end
      object lbe_conta_digito: TLabeledEdit
        Tag = 1
        Left = 292
        Top = 88
        Width = 120
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 75
        EditLabel.Height = 15
        EditLabel.Caption = '* Conta digito'
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
        TabOrder = 7
      end
      object lbe_modalidade: TLabeledEdit
        Tag = 1
        Left = 422
        Top = 88
        Width = 150
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 73
        EditLabel.Height = 15
        EditLabel.Caption = '* Modalidade'
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
        TabOrder = 8
      end
      object lbe_convenio: TLabeledEdit
        Left = 582
        Top = 88
        Width = 150
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 51
        EditLabel.Height = 15
        EditLabel.Caption = 'Conv'#234'nio'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
      end
      object lbe_nome: TLabeledEdit
        Tag = 1
        Left = 352
        Top = 32
        Width = 300
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 43
        EditLabel.Height = 15
        EditLabel.Caption = '* Nome'
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
        TabOrder = 2
      end
      object cbx_tipo_cateira: TComboBox
        Left = 32
        Top = 144
        Width = 150
        Height = 23
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 11
        Text = '0 - Eletr'#244'nica'
        Items.Strings = (
          '0 - Eletr'#244'nica'
          '1 - Registrada'
          '2 - Simples')
      end
      object cbx_tipo_documento: TComboBox
        Left = 742
        Top = 88
        Width = 200
        Height = 23
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 10
        Text = '1 - Tradicional'
        Items.Strings = (
          '1 - Tradicional'
          '2 - Escritural')
      end
      object cbx_respon_emissao: TComboBox
        Left = 192
        Top = 144
        Width = 150
        Height = 23
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 12
        Text = '0 - Banco Emite'
        Items.Strings = (
          '0 - Banco Emite'
          '1 - Banco n'#227'o Reemite'
          '2 - Banco Reemite'
          '3 - Cliente Emite')
      end
      object cbx_carac_titulo: TComboBox
        Left = 352
        Top = 144
        Width = 150
        Height = 23
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 13
        Text = '0 - Caucionada'
        Items.Strings = (
          '0 - Caucionada'
          '1 - Descontada'
          '2 - Simples'
          '3 - Vendor'
          '4 - Vinculada')
      end
      object lbe_logradouro: TLabeledEdit
        Tag = 1
        Left = 162
        Top = 222
        Width = 300
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 72
        EditLabel.Height = 15
        EditLabel.Caption = '* Logradouro'
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
        MaxLength = 60
        ParentFont = False
        TabOrder = 15
      end
      object lbe_numero: TLabeledEdit
        Tag = 1
        Left = 472
        Top = 222
        Width = 100
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 55
        EditLabel.Height = 15
        EditLabel.Caption = '* N'#250'mero'
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
        MaxLength = 8
        ParentFont = False
        TabOrder = 16
      end
      object lbe_complemento: TLabeledEdit
        Left = 582
        Top = 222
        Width = 200
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 75
        EditLabel.Height = 15
        EditLabel.Caption = 'Complemento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        MaxLength = 60
        ParentFont = False
        TabOrder = 17
      end
      object lbe_bairro: TLabeledEdit
        Tag = 1
        Left = 792
        Top = 222
        Width = 150
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 42
        EditLabel.Height = 15
        EditLabel.Caption = '* Bairro'
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
        MaxLength = 60
        ParentFont = False
        TabOrder = 18
      end
      object lbe_nome_municipio: TLabeledEdit
        Tag = 1
        Left = 102
        Top = 278
        Width = 200
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 46
        EditLabel.Height = 15
        EditLabel.Caption = '* Cidade'
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
        MaxLength = 60
        ParentFont = False
        TabOrder = 20
      end
      object mke_cep: TMaskEdit
        Tag = 1
        Left = 32
        Top = 222
        Width = 120
        Height = 23
        EditMask = '#####-###;0;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        MaxLength = 9
        ParentFont = False
        TabOrder = 14
        Text = ''
        OnExit = mke_cepExit
      end
      object mke_fone: TMaskEdit
        Tag = 1
        Left = 312
        Top = 277
        Width = 120
        Height = 23
        EditMask = '(##)####-####;0;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        MaxLength = 13
        ParentFont = False
        TabOrder = 21
        Text = ''
      end
      object cbx_uf: TComboBox
        Tag = 1
        Left = 32
        Top = 278
        Width = 60
        Height = 23
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ItemIndex = 12
        ParentFont = False
        TabOrder = 19
        Text = 'MT'
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
      object lbe_cnpjcpf: TLabeledEdit
        Tag = 1
        Left = 662
        Top = 32
        Width = 150
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 61
        EditLabel.Height = 15
        EditLabel.Caption = '* CPF/CNPJ'
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
        MaxLength = 14
        ParentFont = False
        TabOrder = 3
      end
    end
  end
  object acl_cedente: TActionList
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
  object RESTClient: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    BaseURL = 'https://viacep.com.br/ws/78048258/json'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 488
    Top = 32
  end
  object RESTRequest: TRESTRequest
    Client = RESTClient
    Params = <>
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 560
    Top = 32
  end
  object RESTResponse: TRESTResponse
    ContentType = 'application/json'
    Left = 640
    Top = 32
  end
end
