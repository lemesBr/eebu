inherited formOperacaoFiscalCreateEdit: TformOperacaoFiscalCreateEdit
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formOperacaoFiscalCreateEdit'
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
  object lb_iddest: TLabel
    Left = 406
    Top = 190
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
      Caption = 'OPERA'#199#195'O FISCAL'
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
        Left = 552
        Top = 14
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
      object lb_finnfe: TLabel
        Left = 692
        Top = 14
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
      object lb_tpimp: TLabel
        Left = 32
        Top = 70
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
      object lb_indfinal: TLabel
        Left = 242
        Top = 70
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
      object Label1: TLabel
        Left = 402
        Top = 70
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
      object lb_indpres: TLabel
        Left = 592
        Top = 70
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
      object lbe_nome: TLabeledEdit
        Left = 32
        Top = 32
        Width = 400
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
        MaxLength = 60
        TabOrder = 0
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
        Items.Strings = (
          '01'
          '1B'
          '04'
          '55'
          '65')
      end
      object cbx_tpnf: TComboBox
        Left = 552
        Top = 32
        Width = 130
        Height = 23
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 2
        Text = '1 - Sa'#237'da'
        Items.Strings = (
          '0 - Entrada'
          '1 - Sa'#237'da')
      end
      object cbx_finnfe: TComboBox
        Left = 692
        Top = 32
        Width = 200
        Height = 23
        Hint = 'Finalidade de emiss'#227'o da NF-e / finNFe'
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 3
        Text = '1 - NF-e normal'
        TextHint = 'Finalidade de emiss'#227'o da NF-e / finNFe'
        Items.Strings = (
          '1 - NF-e normal'
          '2 - NF-e complementar'
          '3 - NF-e de ajuste'
          '4 - Devolu'#231#227'o de mercadoria')
      end
      object cbx_tpimp: TComboBox
        Left = 32
        Top = 88
        Width = 200
        Height = 23
        Hint = 'Formato de Impress'#227'o do DANFE / tpImp'
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 4
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
      object cbx_indfinal: TComboBox
        Left = 242
        Top = 88
        Width = 150
        Height = 23
        Hint = 'Indica opera'#231#227'o com Consumidor final  / indFinal'
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 5
        Text = '0 - Normal'
        TextHint = 'Indica opera'#231#227'o com Consumidor final  / indFinal'
        Items.Strings = (
          '0 - Normal'
          '1 - Consumidor final')
      end
      object cbx_iddest: TComboBox
        Left = 402
        Top = 88
        Width = 180
        Height = 23
        Hint = 'Identificador de local de destino da opera'#231#227'o / idDest'
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 6
        Text = '1 - Opera'#231#227'o interna'
        TextHint = 'Identificador de local de destino da opera'#231#227'o / idDest'
        Items.Strings = (
          '1 - Opera'#231#227'o interna'
          '2 - Opera'#231#227'o interestadual'
          '3 - Opera'#231#227'o com exterior')
      end
      object cbx_indpres: TComboBox
        Left = 592
        Top = 88
        Width = 300
        Height = 23
        Hint = 
          'Indicador de presen'#231'a do comprador no estabelecimento comercial ' +
          'no momento da opera'#231#227'o'#13' / indPres'
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 7
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
      object lbe_natop: TLabeledEdit
        Left = 32
        Top = 144
        Width = 400
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 128
        EditLabel.Height = 15
        EditLabel.Caption = '* Natureza da opera'#231#227'o'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        MaxLength = 60
        TabOrder = 8
      end
    end
  end
  object acl_operacao_fiscal: TActionList
    Images = dmRepository.iml_32
    Left = 408
    Top = 309
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
