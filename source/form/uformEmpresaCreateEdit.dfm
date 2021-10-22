inherited formEmpresaCreateEdit: TformEmpresaCreateEdit
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formEmpresaCreateEdit'
  ClientHeight = 740
  ClientWidth = 1024
  Color = 3618615
  Position = poDefaultSizeOnly
  WindowState = wsMaximized
  StyleElements = []
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
      Caption = 'EMPRESA'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Bombardier'
      Font.Style = []
      Padding.Top = 15
      Padding.Bottom = 15
      ParentBackground = False
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
      Color = clWhite
      Padding.Top = 10
      Padding.Bottom = 10
      ParentBackground = False
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
    object pnl_body: TPanel
      Left = 21
      Top = 83
      Width = 976
      Height = 554
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      object lb_crt: TLabel
        Left = 612
        Top = 70
        Width = 20
        Height = 15
        Caption = 'CRT'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
      end
      object bvl_3: TBevel
        Left = 0
        Top = 130
        Width = 971
        Height = 2
      end
      object lb_fone: TLabel
        Left = 452
        Top = 204
        Width = 91
        Height = 15
        Caption = '* Fone comercial'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_celular: TLabel
        Left = 582
        Top = 204
        Width = 75
        Height = 15
        Caption = '* Fone celular'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_cep: TLabel
        Left = 32
        Top = 146
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
      object lb_uf: TLabel
        Left = 32
        Top = 204
        Width = 23
        Height = 15
        Caption = '* UF'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_tipo_pessoa: TLabel
        Left = 32
        Top = 14
        Width = 39
        Height = 15
        Caption = 'Pessoa'
      end
      object lb_documento: TLabel
        Left = 761
        Top = 14
        Width = 35
        Height = 15
        Caption = '* CNPJ'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object bvl_4: TBevel
        Left = 0
        Top = 270
        Width = 971
        Height = 2
      end
      object lb_controle_consulta: TLabel
        Left = 32
        Top = 286
        Width = 70
        Height = 15
        Caption = 'Receber NF-e'
      end
      object lbe_iest: TLabeledEdit
        Left = 182
        Top = 88
        Width = 150
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 118
        EditLabel.Height = 15
        EditLabel.Caption = 'Inscri'#231#227'o estadual ST'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        MaxLength = 14
        NumbersOnly = True
        ParentFont = False
        TabOrder = 5
      end
      object lbe_cnae: TLabeledEdit
        Left = 502
        Top = 88
        Width = 100
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 28
        EditLabel.Height = 15
        EditLabel.Caption = 'CNAE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        MaxLength = 7
        NumbersOnly = True
        ParentFont = False
        TabOrder = 7
      end
      object cbx_crt: TComboBox
        Left = 612
        Top = 88
        Width = 330
        Height = 23
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        Items.Strings = (
          'SIMPLES NACIONAL'
          'SIMPLES NACIONAL, EXCESSO SUBLIMITE DE RECEITA BRUTA'
          'REGIME NORMAL')
      end
      object lbe_logradouro: TLabeledEdit
        Tag = 1
        Left = 141
        Top = 164
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
        TabOrder = 10
      end
      object lbe_numero: TLabeledEdit
        Tag = 1
        Left = 452
        Top = 164
        Width = 70
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
        TabOrder = 11
      end
      object lbe_complemento: TLabeledEdit
        Left = 532
        Top = 164
        Width = 220
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
        TabOrder = 12
      end
      object lbe_bairro: TLabeledEdit
        Tag = 1
        Left = 762
        Top = 164
        Width = 180
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
        TabOrder = 13
      end
      object lbe_codigo_municipio: TLabeledEdit
        Tag = 1
        Left = 292
        Top = 222
        Width = 150
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 119
        EditLabel.Height = 15
        EditLabel.Caption = '* C'#243'digo do munic'#237'pio'
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
        MaxLength = 7
        NumbersOnly = True
        ParentFont = False
        TabOrder = 16
      end
      object lbe_nome_municipio: TLabeledEdit
        Tag = 1
        Left = 92
        Top = 222
        Width = 190
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
        TabOrder = 15
      end
      object lbe_email: TLabeledEdit
        Tag = 1
        Left = 712
        Top = 222
        Width = 230
        Height = 23
        CharCase = ecLowerCase
        EditLabel.Width = 42
        EditLabel.Height = 15
        EditLabel.Caption = '* E-mail'
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
        TabOrder = 19
      end
      object mke_cep: TMaskEdit
        Tag = 1
        Left = 32
        Top = 164
        Width = 100
        Height = 23
        EditMask = '#####-###;0;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        MaxLength = 9
        ParentFont = False
        TabOrder = 9
        Text = ''
        OnExit = mke_cepExit
      end
      object mke_fone: TMaskEdit
        Tag = 1
        Left = 452
        Top = 222
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
        TabOrder = 17
        Text = ''
      end
      object mke_celular: TMaskEdit
        Tag = 1
        Left = 582
        Top = 222
        Width = 120
        Height = 23
        EditMask = '(##)#####-####;0;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        MaxLength = 14
        ParentFont = False
        TabOrder = 18
        Text = ''
      end
      object cbx_uf: TComboBox
        Tag = 1
        Left = 32
        Top = 222
        Width = 50
        Height = 23
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
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
      object cbx_tipo_pessoa: TComboBox
        Left = 32
        Top = 32
        Width = 100
        Height = 23
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = cbx_tipo_pessoaChange
        Items.Strings = (
          'F'#237'sica'
          'Jur'#237'dica')
      end
      object lbe_nome: TLabeledEdit
        Tag = 1
        Left = 142
        Top = 32
        Width = 300
        Height = 23
        CharCase = ecUpperCase
        Color = clWhite
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
        MaxLength = 60
        ParentFont = False
        TabOrder = 1
      end
      object lbe_razao_social: TLabeledEdit
        Left = 452
        Top = 32
        Width = 300
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 72
        EditLabel.Height = 15
        EditLabel.Caption = '* Raz'#227'o social'
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
      object mke_documento: TMaskEdit
        Tag = 1
        Left = 762
        Top = 32
        Width = 180
        Height = 23
        Color = clWhite
        EditMask = '##.###.###/####-##;0;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        MaxLength = 18
        ParentFont = False
        TabOrder = 3
        Text = ''
      end
      object lbe_ie: TLabeledEdit
        Left = 32
        Top = 88
        Width = 140
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 103
        EditLabel.Height = 15
        EditLabel.Caption = 'Inscri'#231#227'o estadual'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        MaxLength = 14
        NumbersOnly = True
        ParentFont = False
        TabOrder = 4
      end
      object lbe_im: TLabeledEdit
        Left = 342
        Top = 88
        Width = 150
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 111
        EditLabel.Height = 15
        EditLabel.Caption = 'Inscri'#231#227'o municipal'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        MaxLength = 15
        NumbersOnly = True
        ParentFont = False
        TabOrder = 6
      end
      object dtp_controle_consulta: TDateTimePicker
        Left = 32
        Top = 304
        Width = 150
        Height = 23
        Date = 43137.332613483800000000
        Time = 43137.332613483800000000
        TabOrder = 20
      end
    end
  end
  object acl_empresa: TActionList
    Images = dmRepository.iml_32
    Left = 728
    Top = 35
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
    Top = 33
  end
  object RESTResponse: TRESTResponse
    Left = 640
    Top = 34
  end
  object RESTCliEmpresa: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    BaseURL = 'http://siace.itecsoftware.com.br/clientewt'
    ContentType = 'application/x-www-form-urlencoded'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 48
    Top = 568
  end
  object RESTReqEmpresa: TRESTRequest
    Client = RESTCliEmpresa
    Method = rmPOST
    Params = <
      item
        name = 'sistema_id'
      end
      item
        name = 'cidade_id'
      end
      item
        name = 'representante_id'
      end
      item
        name = 'nome'
      end
      item
        name = 'documento'
      end
      item
        name = 'ie'
      end
      item
        name = 'iest'
      end
      item
        name = 'im'
      end
      item
        name = 'cnae'
      end
      item
        name = 'crt'
      end
      item
        name = 'cep'
      end
      item
        name = 'logradouro'
      end
      item
        name = 'numero'
      end
      item
        name = 'complemento'
      end
      item
        name = 'uf'
      end
      item
        name = 'bairro'
      end
      item
        name = 'codigo_municipio'
      end
      item
        name = 'nome_municipio'
      end
      item
        name = 'fone'
      end
      item
        name = 'celular'
      end
      item
        name = 'email'
      end
      item
        name = 'mensalidade'
      end>
    Response = RESTRespEmpresa
    SynchronizedEvents = False
    Left = 134
    Top = 568
  end
  object RESTRespEmpresa: TRESTResponse
    ContentType = 'text/html'
    Left = 225
    Top = 568
  end
end
