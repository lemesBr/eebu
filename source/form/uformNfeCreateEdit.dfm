inherited formNfeCreateEdit: TformNfeCreateEdit
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formNfeCreateEdit'
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
      Caption = 'NFE'
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
      object lb_cuf: TLabel
        Left = 892
        Top = 126
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
      object lb_indpag: TLabel
        Left = 312
        Top = 70
        Width = 126
        Height = 15
        Caption = '* Forma de pagamento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_demi: TLabel
        Left = 812
        Top = 14
        Width = 98
        Height = 15
        Caption = '* Data de emiss'#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_dsaient: TLabel
        Left = 32
        Top = 70
        Width = 119
        Height = 15
        Caption = '* Data entrada / saida'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_iddest: TLabel
        Left = 402
        Top = 126
        Width = 120
        Height = 15
        Caption = '* Destino da opera'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_tpimp: TLabel
        Left = 32
        Top = 126
        Width = 131
        Height = 15
        Caption = '* Tipo impress'#227'o DANFE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_tpemis: TLabel
        Left = 552
        Top = 70
        Width = 108
        Height = 15
        Caption = '* Forma de emiss'#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_finnfe: TLabel
        Left = 772
        Top = 70
        Width = 128
        Height = 15
        Caption = '* Finalidade de emiss'#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_indfinal: TLabel
        Left = 242
        Top = 126
        Width = 75
        Height = 15
        Caption = '* Consumidor'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_indpres: TLabel
        Left = 592
        Top = 126
        Width = 107
        Height = 15
        Caption = '* Tipo atendimento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_procemi: TLabel
        Left = 192
        Top = 182
        Width = 52
        Height = 15
        Caption = '* Emiss'#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_dhcont: TLabel
        Left = 32
        Top = 238
        Width = 105
        Height = 15
        Caption = '* Data conting'#234'ncia'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_modelo: TLabel
        Left = 442
        Top = 14
        Width = 51
        Height = 15
        Caption = '* Modelo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_tpnf: TLabel
        Left = 172
        Top = 70
        Width = 115
        Height = 15
        Caption = '* Tipo do documento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbe_operacao_fiscal: TLabeledEdit
        Left = 32
        Top = 32
        Width = 400
        Height = 23
        Hint = 'natOp'
        CharCase = ecUpperCase
        EditLabel.Width = 165
        EditLabel.Height = 15
        EditLabel.Caption = '* Natureza da opera'#231#227'o - ( F1 )'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        MaxLength = 60
        ReadOnly = True
        TabOrder = 0
        OnKeyDown = lbe_operacao_fiscalKeyDown
      end
      object lbe_chnfe: TLabeledEdit
        Left = 592
        Top = 200
        Width = 350
        Height = 23
        Hint = 'C'#243'digo Num'#233'rico que comp'#245'e a Chave de Acesso / cNF'
        TabStop = False
        CharCase = ecUpperCase
        EditLabel.Width = 88
        EditLabel.Height = 15
        EditLabel.Caption = 'Chave de acesso'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        MaxLength = 44
        ReadOnly = True
        TabOrder = 18
        TextHint = 'C'#243'digo Num'#233'rico que comp'#245'e a Chave de Acesso / cNF'
      end
      object lbe_serie: TLabeledEdit
        Left = 552
        Top = 32
        Width = 100
        Height = 23
        Hint = 'S'#233'rie do Documento Fiscal / Serie'
        CharCase = ecUpperCase
        EditLabel.Width = 37
        EditLabel.Height = 15
        EditLabel.Caption = '* Serie'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        MaxLength = 3
        TabOrder = 2
        TextHint = 'S'#233'rie do Documento Fiscal / Serie'
      end
      object lbe_nnf: TLabeledEdit
        Left = 662
        Top = 32
        Width = 100
        Height = 23
        Hint = 'N'#250'mero do Documento Fiscal / nNF'
        TabStop = False
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
        MaxLength = 8
        ReadOnly = True
        TabOrder = 3
        TextHint = 'N'#250'mero do Documento Fiscal / nNF'
      end
      object lbe_cmunfg: TLabeledEdit
        Left = 32
        Top = 200
        Width = 150
        Height = 23
        Hint = 'C'#243'digo do Munic'#237'pio de Ocorr'#234'ncia do Fato Gerador / cMunFG'
        CharCase = ecUpperCase
        EditLabel.Width = 139
        EditLabel.Height = 15
        EditLabel.Caption = '* Munic'#237'pio de ocorr'#234'ncia'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        MaxLength = 7
        TabOrder = 16
        TextHint = 'C'#243'digo do Munic'#237'pio de Ocorr'#234'ncia do Fato Gerador / cMunFG'
      end
      object lbe_cdv: TLabeledEdit
        Left = 772
        Top = 32
        Width = 30
        Height = 23
        Hint = 'D'#237'gito Verificador da Chave de Acesso da NF-e / cDV'
        TabStop = False
        CharCase = ecUpperCase
        EditLabel.Width = 16
        EditLabel.Height = 15
        EditLabel.Caption = 'DV'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        MaxLength = 1
        ReadOnly = True
        TabOrder = 4
        TextHint = 'D'#237'gito Verificador da Chave de Acesso da NF-e / cDV'#13
      end
      object lbe_xjust: TLabeledEdit
        Left = 172
        Top = 256
        Width = 770
        Height = 23
        Hint = 'Justificativa da entrada em conting'#234'ncia / xJust'
        CharCase = ecUpperCase
        EditLabel.Width = 225
        EditLabel.Height = 15
        EditLabel.Caption = '* Justificativa da entrada em conting'#234'ncia'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        MaxLength = 255
        TabOrder = 20
        TextHint = 'Justificativa da entrada em conting'#234'ncia / xJust'
      end
      object cbx_cuf: TComboBox
        Left = 892
        Top = 144
        Width = 50
        Height = 22
        Hint = 'cUF'
        Style = csOwnerDrawFixed
        ItemIndex = 12
        TabOrder = 15
        Text = 'MT'
        TextHint = 'C'#243'digo da UF que atendeu a solicita'#231#227'o / cUF'
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
      object cbx_indpag: TComboBox
        Left = 312
        Top = 88
        Width = 230
        Height = 23
        Hint = 'Indicador da forma de pagamento / indPag'
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 8
        Text = '0 - Pagamento '#224' vista'
        TextHint = 'Indicador da forma de pagamento / indPag'
        Items.Strings = (
          '0 - Pagamento '#224' vista'
          '1 - Pagamento a prazo'
          '2 - Outros')
      end
      object dtp_demi: TDateTimePicker
        Left = 812
        Top = 32
        Width = 130
        Height = 23
        Hint = 'Data e hora de emiss'#227'o do Documento Fiscal / dhEmi'
        Date = 43089.466216296300000000
        Time = 43089.466216296300000000
        TabOrder = 5
      end
      object dtp_dsaient: TDateTimePicker
        Left = 32
        Top = 88
        Width = 130
        Height = 23
        Hint = 
          'Data e hora de Sa'#237'da ou da Entrada da Mercadoria/Produto'#13' / dhSa' +
          'iEnt'
        Date = 43089.466216296300000000
        Time = 43089.466216296300000000
        TabOrder = 6
      end
      object cbx_iddest: TComboBox
        Left = 402
        Top = 144
        Width = 180
        Height = 23
        Hint = 'Identificador de local de destino da opera'#231#227'o / idDest'
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 13
        Text = '1 - Opera'#231#227'o interna'
        TextHint = 'Identificador de local de destino da opera'#231#227'o / idDest'
        Items.Strings = (
          '1 - Opera'#231#227'o interna'
          '2 - Opera'#231#227'o interestadual'
          '3 - Opera'#231#227'o com exterior')
      end
      object cbx_tpimp: TComboBox
        Left = 32
        Top = 144
        Width = 200
        Height = 23
        Hint = 'Formato de Impress'#227'o do DANFE / tpImp'
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 11
        Text = '1 - DANFE normal, Retrato'
        TextHint = 'Formato de Impress'#227'o do DANFE / tpImp'
        Items.Strings = (
          '0 - Sem gera'#231#227'o de DANFE'
          '1 - DANFE normal, Retrato'
          '2 - DANFE normal, Paisagem'
          '3 - DANFE Simplificado'
          '4 - DANFE NFC-e'
          '5 - DANFE NFC-e em mensagem eletr'#244'nica')
      end
      object cbx_tpemis: TComboBox
        Left = 552
        Top = 88
        Width = 210
        Height = 23
        Hint = 'Tipo de Emiss'#227'o da NF-e / tpEmis'
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 9
        Text = '1 - Emiss'#227'o normal'
        TextHint = 'Tipo de Emiss'#227'o da NF-e / tpEmis'
        Items.Strings = (
          '1 - Emiss'#227'o normal'
          '2 - Conting'#234'ncia FS-IA'
          '3 - Conting'#234'ncia SCAN'
          '4 - Conting'#234'ncia DPEC'
          '5 - Conting'#234'ncia FS-DA'
          '6 - Conting'#234'ncia SVC-AN'
          '7 - Conting'#234'ncia SVC-RS'
          '9 - Conting'#234'ncia off-line da NFC-e')
      end
      object cbx_finnfe: TComboBox
        Left = 772
        Top = 88
        Width = 170
        Height = 23
        Hint = 'Finalidade de emiss'#227'o da NF-e / finNFe'
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 10
        Text = '1 - NF-e normal'
        TextHint = 'Finalidade de emiss'#227'o da NF-e / finNFe'
        Items.Strings = (
          '1 - NF-e normal'
          '2 - NF-e complementar'
          '3 - NF-e de ajuste'
          '4 - Devolu'#231#227'o de mercadoria')
      end
      object cbx_indfinal: TComboBox
        Left = 242
        Top = 144
        Width = 150
        Height = 23
        Hint = 'Indica opera'#231#227'o com Consumidor final  / indFinal'
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 12
        Text = '0 - Normal'
        TextHint = 'Indica opera'#231#227'o com Consumidor final  / indFinal'
        Items.Strings = (
          '0 - Normal'
          '1 - Consumidor final')
      end
      object cbx_indpres: TComboBox
        Left = 592
        Top = 144
        Width = 290
        Height = 23
        Hint = 
          'Indicador de presen'#231'a do comprador no estabelecimento comercial ' +
          'no momento da opera'#231#227'o'#13' / indPres'
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 14
        Text = '1 - Opera'#231#227'o presencial'
        TextHint = 
          'Indicador de presen'#231'a do comprador no estabelecimento comercial ' +
          'no momento da opera'#231#227'o'
        Items.Strings = (
          '0 - N'#227'o se aplica'
          '1 - Opera'#231#227'o presencial'
          '2 - Opera'#231#227'o n'#227'o presencial, pela Internet'
          '3 - Opera'#231#227'o n'#227'o presencial, Teleatendimento'
          '4 - NFC-e em opera'#231#227'o com entrega a domic'#237'lio'
          '9 - Opera'#231#227'o n'#227'o presencial, outros')
      end
      object cbx_procemi: TComboBox
        Left = 192
        Top = 200
        Width = 390
        Height = 23
        Hint = 'Processo de emiss'#227'o da NF-e / procEmi'
        Style = csDropDownList
        Enabled = False
        ItemIndex = 0
        TabOrder = 17
        TabStop = False
        Text = '0 - Emiss'#227'o de NF-e com aplicativo do contribuinte'
        TextHint = 'Processo de emiss'#227'o da NF-e / procEmi'
        Items.Strings = (
          '0 - Emiss'#227'o de NF-e com aplicativo do contribuinte'
          '1 - Emiss'#227'o de NF-e avulsa, pelo fisco'
          '2 - Emiss'#227'o de NF-e avulsa, pelo contribuinte'
          
            '3 - Emiss'#227'o de NF-e pelo contribuinte com aplicativo fornecido p' +
            'elo fisco')
      end
      object dtp_dhcont: TDateTimePicker
        Left = 32
        Top = 256
        Width = 130
        Height = 23
        Hint = 'Data e Hora da entrada em conting'#234'ncia  / dhCont'
        Date = 43089.466216296300000000
        Time = 43089.466216296300000000
        DoubleBuffered = False
        ParentDoubleBuffered = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 19
      end
      object cbx_modelo: TComboBox
        Left = 442
        Top = 32
        Width = 100
        Height = 23
        Style = csDropDownList
        ItemIndex = 3
        TabOrder = 1
        Text = '55'
        OnSelect = cbx_modeloSelect
        Items.Strings = (
          '01'
          '1B'
          '04'
          '55'
          '65')
      end
      object cbx_tpnf: TComboBox
        Left = 172
        Top = 88
        Width = 130
        Height = 23
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 7
        Text = '1 - Sa'#237'da'
        Items.Strings = (
          '0 - Entrada'
          '1 - Sa'#237'da')
      end
      object ckb_auto_calculo: TCheckBox
        Left = 32
        Top = 312
        Width = 910
        Height = 17
        Caption = 
          'Gerar c'#225'lculo dos impostos automaticamente. (Necess'#225'rio configur' +
          'ar o sistema)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 21
      end
    end
  end
  object act_nfe: TActionList
    Images = dmRepository.iml_32
    OnUpdate = act_nfeUpdate
    Left = 728
    Top = 32
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
