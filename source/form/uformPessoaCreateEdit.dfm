inherited formPessoaCreateEdit: TformPessoaCreateEdit
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formPessoaCreateEdit'
  ClientHeight = 740
  ClientWidth = 1024
  Color = 3618615
  Position = poDefaultSizeOnly
  WindowState = wsMaximized
  StyleElements = []
  OnDestroy = FormDestroy
  OnShow = FormShow
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
    object pnl_pessoa_header: TPanel
      Left = 21
      Top = 1
      Width = 976
      Height = 80
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'PESSOA'
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
    object pnl_pessoa_footer: TPanel
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
    object pnl_pessoa_body: TPanel
      Left = 21
      Top = 83
      Width = 976
      Height = 556
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 2
      object Bevel1: TBevel
        Left = 0
        Top = 139
        Width = 976
        Height = 2
      end
      object bvl_2: TBevel
        Left = 0
        Top = 554
        Width = 976
        Height = 2
        Align = alBottom
        ExplicitTop = 88
      end
      object Label1: TLabel
        Left = 784
        Top = 70
        Width = 79
        Height = 15
        Caption = '* Contribuinte'
      end
      object Bevel2: TBevel
        Left = 0
        Top = 289
        Width = 976
        Height = 2
      end
      object lbe_Document_label: TLabel
        Left = 761
        Top = 15
        Width = 26
        Height = 15
        Caption = 'CNPJ'
      end
      object lbe_Nascimento_fundacao_lbe: TLabel
        Left = 677
        Top = 70
        Width = 28
        Height = 15
        Caption = 'DATA'
      end
      object Label2: TLabel
        Left = 32
        Top = 165
        Width = 29
        Height = 15
        Caption = '* CEP'
      end
      object Label3: TLabel
        Left = 451
        Top = 221
        Width = 82
        Height = 15
        Caption = 'Fone comercial'
      end
      object Label4: TLabel
        Left = 587
        Top = 221
        Width = 66
        Height = 15
        Caption = 'Fone celular'
      end
      object Label5: TLabel
        Left = 32
        Top = 310
        Width = 63
        Height = 15
        Caption = 'Observa'#231#227'o'
      end
      object Label6: TLabel
        Left = 32
        Top = 220
        Width = 23
        Height = 15
        Caption = '* UF'
      end
      object Label7: TLabel
        Left = 32
        Top = 14
        Width = 63
        Height = 15
        Caption = 'Tipo Pessoa'
      end
      object lbe_nome: TLabeledEdit
        Tag = 1
        Left = 141
        Top = 32
        Width = 300
        Height = 23
        CharCase = ecUpperCase
        Color = clWhite
        EditLabel.Width = 43
        EditLabel.Height = 15
        EditLabel.Caption = '* Nome'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object lbe_razao_social: TLabeledEdit
        Left = 451
        Top = 32
        Width = 300
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 72
        EditLabel.Height = 15
        EditLabel.Caption = '* Raz'#227'o social'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object lbe_idestrangeiro: TLabeledEdit
        Left = 32
        Top = 88
        Width = 100
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 75
        EditLabel.Height = 15
        EditLabel.Caption = 'Id Estrangeiro'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        MaxLength = 20
        ParentFont = False
        TabOrder = 3
      end
      object lbe_im: TLabeledEdit
        Left = 291
        Top = 88
        Width = 150
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 101
        EditLabel.Height = 15
        EditLabel.Caption = 'Inscri'#231#227'o municipal'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        MaxLength = 15
        ParentFont = False
        TabOrder = 5
      end
      object lbe_isuf: TLabeledEdit
        Left = 451
        Top = 88
        Width = 140
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 103
        EditLabel.Height = 15
        EditLabel.Caption = 'Inscri'#231#227'o SUFRAMA'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        MaxLength = 9
        ParentFont = False
        TabOrder = 6
      end
      object ckb_simples: TCheckBox
        Left = 601
        Top = 91
        Width = 70
        Height = 17
        Caption = 'SIMPLES'
        TabOrder = 7
      end
      object lbe_ie: TLabeledEdit
        Left = 141
        Top = 88
        Width = 140
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 95
        EditLabel.Height = 15
        EditLabel.Caption = 'Inscri'#231#227'o estadual'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        MaxLength = 14
        ParentFont = False
        TabOrder = 4
      end
      object lbe_logradouro: TLabeledEdit
        Left = 141
        Top = 182
        Width = 300
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 72
        EditLabel.Height = 15
        EditLabel.Caption = '* Logradouro'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        MaxLength = 60
        ParentFont = False
        TabOrder = 11
      end
      object lbe_numero: TLabeledEdit
        Left = 451
        Top = 182
        Width = 70
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 55
        EditLabel.Height = 15
        EditLabel.Caption = '* N'#250'mero'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        MaxLength = 8
        ParentFont = False
        TabOrder = 12
      end
      object lbe_complemento: TLabeledEdit
        Left = 531
        Top = 182
        Width = 220
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 79
        EditLabel.Height = 15
        EditLabel.Caption = 'Complemento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        MaxLength = 60
        ParentFont = False
        TabOrder = 13
      end
      object lbe_bairro: TLabeledEdit
        Left = 761
        Top = 182
        Width = 176
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 42
        EditLabel.Height = 15
        EditLabel.Caption = '* Bairro'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        MaxLength = 60
        ParentFont = False
        TabOrder = 14
      end
      object lbe_codigo_municipio: TLabeledEdit
        Left = 292
        Top = 238
        Width = 149
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 119
        EditLabel.Height = 15
        EditLabel.Caption = '* C'#243'digo do munic'#237'pio'
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
        Left = 92
        Top = 238
        Width = 190
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 46
        EditLabel.Height = 15
        EditLabel.Caption = '* Cidade'
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
        Left = 723
        Top = 238
        Width = 214
        Height = 23
        CharCase = ecLowerCase
        EditLabel.Width = 29
        EditLabel.Height = 15
        EditLabel.Caption = 'Email'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        MaxLength = 60
        ParentFont = False
        TabOrder = 19
      end
      object cbx_indiedest: TComboBox
        Left = 784
        Top = 88
        Width = 153
        Height = 23
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        Items.Strings = (
          'Contribuinte de ICMS'
          'Contribuinte ISENTO'
          'N'#227'o contribuinte')
      end
      object mke_documento: TMaskEdit
        Tag = 1
        Left = 761
        Top = 32
        Width = 176
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
        TabOrder = 2
        Text = ''
      end
      object dtp_data_fundacao_nascimento: TDateTimePicker
        Left = 677
        Top = 88
        Width = 97
        Height = 23
        Date = 43084.383408159720000000
        Time = 43084.383408159720000000
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object mke_cep: TMaskEdit
        Left = 32
        Top = 182
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
        TabOrder = 10
        Text = ''
        OnExit = mke_cepExit
      end
      object mke_fone: TMaskEdit
        Left = 451
        Top = 238
        Width = 118
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
        Left = 587
        Top = 238
        Width = 122
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
      object mm_observacao: TMemo
        Left = 32
        Top = 329
        Width = 905
        Height = 89
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 20
      end
      object cbx_uf: TComboBox
        Left = 32
        Top = 238
        Width = 50
        Height = 23
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 21
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
      object cbx_TipoPessoa: TComboBox
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
        ItemIndex = 0
        ParentFont = False
        TabOrder = 22
        Text = 'F'#237'sica'
        OnChange = cbx_TipoPessoaChange
        Items.Strings = (
          'F'#237'sica'
          'Jur'#237'dica')
      end
    end
  end
  object acl_pessoa: TActionList
    Images = dmRepository.iml_32
    Left = 968
    Top = 605
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
