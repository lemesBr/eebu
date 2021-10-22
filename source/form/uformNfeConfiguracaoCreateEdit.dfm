inherited formNfeConfiguracaoCreateEdit: TformNfeConfiguracaoCreateEdit
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formNfeConfiguracaoCreateEdit'
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
      Caption = 'NFE CONFIGURA'#199#213'ES'
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
      object lb_uf: TLabel
        Left = 522
        Top = 14
        Width = 14
        Height = 15
        Caption = 'UF'
      end
      object lb_versao_df: TLabel
        Left = 32
        Top = 14
        Width = 24
        Height = 15
        Caption = 'NF-e'
      end
      object lb_forma_emissao_codigo: TLabel
        Left = 302
        Top = 14
        Width = 100
        Height = 15
        Caption = 'Forma de emiss'#227'o'
      end
      object lb_ambiente_codigo: TLabel
        Left = 142
        Top = 14
        Width = 51
        Height = 15
        Caption = 'Ambiente'
      end
      object lb_numero_serie: TLabel
        Left = 32
        Top = 70
        Width = 59
        Height = 15
        Caption = 'Certificado'
      end
      object bvl_3: TBevel
        Left = 0
        Top = 130
        Width = 976
        Height = 2
        Align = alCustom
      end
      object lb_logo: TLabel
        Left = 32
        Top = 144
        Width = 25
        Height = 15
        Caption = 'Logo'
      end
      object lb_path_nfe: TLabel
        Left = 332
        Top = 144
        Width = 52
        Height = 15
        Caption = 'Path NF-e'
      end
      object lb_path_inu: TLabel
        Left = 632
        Top = 144
        Width = 114
        Height = 15
        Caption = 'Path NF-e Inutilizada'
      end
      object lb_path_evento: TLabel
        Left = 32
        Top = 200
        Width = 91
        Height = 15
        Caption = 'Path NF-e Evento'
      end
      object lb_path_salvar: TLabel
        Left = 332
        Top = 200
        Width = 90
        Height = 15
        Caption = 'Path NF-e Salvar'
      end
      object lb_path_schemas: TLabel
        Left = 632
        Top = 200
        Width = 103
        Height = 15
        Caption = 'Path Schemas NF-e'
      end
      object lb_arquivo_pfx: TLabel
        Left = 632
        Top = 70
        Width = 94
        Height = 15
        Caption = 'Path Arquivo PFX'
      end
      object lb_path_pdf: TLabel
        Left = 32
        Top = 256
        Width = 76
        Height = 15
        Caption = 'Path NF-e PDF'
      end
      object bvl_4: TBevel
        Left = 0
        Top = 320
        Width = 976
        Height = 2
        Align = alCustom
      end
      object lb_ssllib: TLabel
        Left = 32
        Top = 334
        Width = 33
        Height = 15
        Alignment = taRightJustify
        Caption = 'SSLLib'
      end
      object lbe_id_csc: TLabeledEdit
        Left = 582
        Top = 32
        Width = 90
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 61
        EditLabel.Height = 15
        EditLabel.Caption = 'Id do token'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        MaxLength = 6
        NumbersOnly = True
        TabOrder = 4
      end
      object lbe_csc: TLabeledEdit
        Left = 682
        Top = 32
        Width = 250
        Height = 23
        CharCase = ecLowerCase
        EditLabel.Width = 31
        EditLabel.Height = 15
        EditLabel.Caption = 'Token'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        MaxLength = 36
        TabOrder = 5
      end
      object lbe_senha: TLabeledEdit
        Left = 302
        Top = 88
        Width = 100
        Height = 23
        EditLabel.Width = 33
        EditLabel.Height = 15
        EditLabel.Caption = 'Senha'
        MaxLength = 255
        TabOrder = 7
      end
      object lbe_serie_nfe: TLabeledEdit
        Left = 412
        Top = 88
        Width = 100
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 54
        EditLabel.Height = 15
        EditLabel.Caption = 'S'#233'rie NF-e'
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 8
      end
      object lbe_serie_nfce: TLabeledEdit
        Left = 522
        Top = 88
        Width = 100
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 61
        EditLabel.Height = 15
        EditLabel.Caption = 'S'#233'rie NFC-e'
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 9
      end
      object cbx_uf: TComboBox
        Left = 522
        Top = 32
        Width = 50
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 3
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
      object cbx_versao_df: TComboBox
        Left = 32
        Top = 32
        Width = 100
        Height = 23
        Style = csDropDownList
        TabOrder = 0
        Items.Strings = (
          'NF-e 2.00'
          'NF-e 3.00'
          'NF-e 3.10'
          'NF-e 4.00')
      end
      object cbx_ambiente_codigo: TComboBox
        Left = 142
        Top = 32
        Width = 150
        Height = 23
        Style = csDropDownList
        TabOrder = 1
        Items.Strings = (
          '1 - Produ'#231#227'o'
          '2 - Homologa'#231#227'o')
      end
      object cbx_forma_emissao_codigo: TComboBox
        Left = 302
        Top = 32
        Width = 210
        Height = 23
        Hint = 'Tipo de Emiss'#227'o da NF-e / tpEmis'
        Style = csDropDownList
        TabOrder = 2
        TextHint = 'Tipo de Emiss'#227'o da NF-e / tpEmis'
        Items.Strings = (
          '1 - Normal'
          '2 - Conting'#234'ncia')
      end
      object bed_numero_serie: TButtonedEdit
        Left = 32
        Top = 88
        Width = 260
        Height = 23
        Images = dmRepository.iml_16
        LeftButton.DisabledImageIndex = 24
        LeftButton.HotImageIndex = 24
        LeftButton.ImageIndex = 24
        LeftButton.PressedImageIndex = 24
        LeftButton.Visible = True
        MaxLength = 255
        ReadOnly = True
        RightButton.DisabledImageIndex = 23
        RightButton.HotImageIndex = 23
        RightButton.ImageIndex = 23
        RightButton.PressedImageIndex = 23
        TabOrder = 6
        OnChange = bed_numero_serieChange
        OnLeftButtonClick = bed_numero_serieLeftButtonClick
        OnRightButtonClick = bed_numero_serieRightButtonClick
      end
      object bed_logo: TButtonedEdit
        Left = 32
        Top = 162
        Width = 290
        Height = 23
        CharCase = ecLowerCase
        Images = dmRepository.iml_16
        LeftButton.DisabledImageIndex = 24
        LeftButton.HotImageIndex = 24
        LeftButton.ImageIndex = 24
        LeftButton.PressedImageIndex = 24
        LeftButton.Visible = True
        MaxLength = 255
        ReadOnly = True
        RightButton.DisabledImageIndex = 23
        RightButton.HotImageIndex = 23
        RightButton.ImageIndex = 23
        RightButton.PressedImageIndex = 23
        TabOrder = 11
        OnChange = bed_numero_serieChange
        OnLeftButtonClick = bed_logoLeftButtonClick
        OnRightButtonClick = bed_numero_serieRightButtonClick
      end
      object bed_path_nfe: TButtonedEdit
        Left = 332
        Top = 162
        Width = 290
        Height = 23
        CharCase = ecLowerCase
        Images = dmRepository.iml_16
        LeftButton.DisabledImageIndex = 24
        LeftButton.HotImageIndex = 24
        LeftButton.ImageIndex = 24
        LeftButton.PressedImageIndex = 24
        LeftButton.Visible = True
        MaxLength = 255
        ReadOnly = True
        RightButton.DisabledImageIndex = 23
        RightButton.HotImageIndex = 23
        RightButton.ImageIndex = 23
        RightButton.PressedImageIndex = 23
        TabOrder = 12
        OnChange = bed_numero_serieChange
        OnLeftButtonClick = bed_path_nfeLeftButtonClick
        OnRightButtonClick = bed_numero_serieRightButtonClick
      end
      object bed_path_inu: TButtonedEdit
        Left = 632
        Top = 162
        Width = 300
        Height = 23
        CharCase = ecLowerCase
        Images = dmRepository.iml_16
        LeftButton.DisabledImageIndex = 24
        LeftButton.HotImageIndex = 24
        LeftButton.ImageIndex = 24
        LeftButton.PressedImageIndex = 24
        LeftButton.Visible = True
        MaxLength = 255
        ReadOnly = True
        RightButton.DisabledImageIndex = 23
        RightButton.HotImageIndex = 23
        RightButton.ImageIndex = 23
        RightButton.PressedImageIndex = 23
        TabOrder = 13
        OnChange = bed_numero_serieChange
        OnLeftButtonClick = bed_path_nfeLeftButtonClick
        OnRightButtonClick = bed_numero_serieRightButtonClick
      end
      object bed_path_evento: TButtonedEdit
        Left = 32
        Top = 218
        Width = 290
        Height = 23
        CharCase = ecLowerCase
        Images = dmRepository.iml_16
        LeftButton.DisabledImageIndex = 24
        LeftButton.HotImageIndex = 24
        LeftButton.ImageIndex = 24
        LeftButton.PressedImageIndex = 24
        LeftButton.Visible = True
        MaxLength = 255
        ReadOnly = True
        RightButton.DisabledImageIndex = 23
        RightButton.HotImageIndex = 23
        RightButton.ImageIndex = 23
        RightButton.PressedImageIndex = 23
        TabOrder = 14
        OnChange = bed_numero_serieChange
        OnLeftButtonClick = bed_path_nfeLeftButtonClick
        OnRightButtonClick = bed_numero_serieRightButtonClick
      end
      object bed_path_salvar: TButtonedEdit
        Left = 332
        Top = 218
        Width = 290
        Height = 23
        CharCase = ecLowerCase
        Images = dmRepository.iml_16
        LeftButton.DisabledImageIndex = 24
        LeftButton.HotImageIndex = 24
        LeftButton.ImageIndex = 24
        LeftButton.PressedImageIndex = 24
        LeftButton.Visible = True
        MaxLength = 255
        ReadOnly = True
        RightButton.DisabledImageIndex = 23
        RightButton.HotImageIndex = 23
        RightButton.ImageIndex = 23
        RightButton.PressedImageIndex = 23
        TabOrder = 15
        OnChange = bed_numero_serieChange
        OnLeftButtonClick = bed_path_nfeLeftButtonClick
        OnRightButtonClick = bed_numero_serieRightButtonClick
      end
      object bed_path_schemas: TButtonedEdit
        Left = 632
        Top = 218
        Width = 300
        Height = 23
        CharCase = ecLowerCase
        Images = dmRepository.iml_16
        LeftButton.DisabledImageIndex = 24
        LeftButton.HotImageIndex = 24
        LeftButton.ImageIndex = 24
        LeftButton.PressedImageIndex = 24
        LeftButton.Visible = True
        MaxLength = 255
        ReadOnly = True
        RightButton.DisabledImageIndex = 23
        RightButton.HotImageIndex = 23
        RightButton.ImageIndex = 23
        RightButton.PressedImageIndex = 23
        TabOrder = 16
        OnChange = bed_numero_serieChange
        OnLeftButtonClick = bed_path_nfeLeftButtonClick
        OnRightButtonClick = bed_numero_serieRightButtonClick
      end
      object bed_arquivo_pfx: TButtonedEdit
        Left = 632
        Top = 88
        Width = 300
        Height = 23
        CharCase = ecLowerCase
        Images = dmRepository.iml_16
        LeftButton.DisabledImageIndex = 24
        LeftButton.HotImageIndex = 24
        LeftButton.ImageIndex = 24
        LeftButton.PressedImageIndex = 24
        LeftButton.Visible = True
        MaxLength = 255
        ReadOnly = True
        RightButton.DisabledImageIndex = 23
        RightButton.HotImageIndex = 23
        RightButton.ImageIndex = 23
        RightButton.PressedImageIndex = 23
        TabOrder = 10
        OnChange = bed_numero_serieChange
        OnLeftButtonClick = bed_path_nfeLeftButtonClick
        OnRightButtonClick = bed_numero_serieRightButtonClick
      end
      object bed_path_pdf: TButtonedEdit
        Left = 32
        Top = 274
        Width = 290
        Height = 23
        CharCase = ecLowerCase
        Images = dmRepository.iml_16
        LeftButton.DisabledImageIndex = 24
        LeftButton.HotImageIndex = 24
        LeftButton.ImageIndex = 24
        LeftButton.PressedImageIndex = 24
        LeftButton.Visible = True
        MaxLength = 255
        ReadOnly = True
        RightButton.DisabledImageIndex = 23
        RightButton.HotImageIndex = 23
        RightButton.ImageIndex = 23
        RightButton.PressedImageIndex = 23
        TabOrder = 17
        OnChange = bed_numero_serieChange
        OnLeftButtonClick = bed_path_nfeLeftButtonClick
        OnRightButtonClick = bed_numero_serieRightButtonClick
      end
      object cbx_ssllib: TComboBox
        Left = 32
        Top = 352
        Width = 200
        Height = 23
        Style = csDropDownList
        TabOrder = 18
      end
      object lbe_aguardar_consulta_ret: TLabeledEdit
        Left = 242
        Top = 352
        Width = 100
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 51
        EditLabel.Height = 15
        EditLabel.Caption = 'Aguardar'
        NumbersOnly = True
        TabOrder = 19
      end
      object lbe_intervalo_tentativas: TLabeledEdit
        Left = 352
        Top = 352
        Width = 100
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 50
        EditLabel.Height = 15
        EditLabel.Caption = 'Intervalo'
        NumbersOnly = True
        TabOrder = 20
      end
      object lbe_tentativas: TLabeledEdit
        Left = 462
        Top = 352
        Width = 100
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 55
        EditLabel.Height = 15
        EditLabel.Caption = 'Tentativas'
        NumbersOnly = True
        TabOrder = 21
      end
      object ckb_ajusta_aguarda_consulta_ret: TCheckBox
        Left = 572
        Top = 355
        Width = 120
        Height = 17
        Caption = 'Usar par'#226'metros'
        TabOrder = 22
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
  object open_picture: TOpenPictureDialog
    Left = 726
    Top = 37
  end
  object ACBrNFe: TACBrNFe
    Configuracoes.Geral.SSLLib = libCapicom
    Configuracoes.Geral.SSLCryptLib = cryCapicom
    Configuracoes.Geral.SSLHttpLib = httpWinINet
    Configuracoes.Geral.SSLXmlSignLib = xsMsXmlCapicom
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Left = 664
    Top = 37
  end
end
