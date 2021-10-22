inherited formCartaoCreateEdit: TformCartaoCreateEdit
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formCartaoCreateEdit'
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
      Caption = 'MODELO'
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
      ExplicitTop = 643
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
        ExplicitLeft = 469
        ExplicitTop = -14
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
        ExplicitTop = 3
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
      object lb_modalidade: TLabel
        Left = 292
        Top = 14
        Width = 67
        Height = 15
        Caption = 'Modalidade'
      end
      object lbe_nome: TLabeledEdit
        Left = 32
        Top = 32
        Width = 250
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
        MaxLength = 255
        TabOrder = 0
      end
      object cbx_modalidade: TComboBox
        Left = 292
        Top = 32
        Width = 150
        Height = 23
        Style = csDropDownList
        ItemIndex = 6
        TabOrder = 1
        Text = 'CREDITO E DEBITO'
        Items.Strings = (
          'CREDITO'
          'DEBITO'
          'VALE ALIMENTACAO'
          'VALE REFEICAO'
          'VALE PRESENTE'
          'VALE COMBUSTIVEL'
          'CREDITO E DEBITO')
      end
      object lbe_compensa_credito: TLabeledEdit
        Left = 452
        Top = 32
        Width = 130
        Height = 23
        EditLabel.Width = 99
        EditLabel.Height = 15
        EditLabel.Caption = 'Compensa cr'#233'dito'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        NumbersOnly = True
        TabOrder = 2
      end
      object lbe_taxa_credito: TLabeledEdit
        Left = 592
        Top = 32
        Width = 100
        Height = 23
        EditLabel.Width = 67
        EditLabel.Height = 15
        EditLabel.Caption = 'Taxa cr'#233'dito'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        TabOrder = 3
      end
      object lbe_compensa_debito: TLabeledEdit
        Left = 702
        Top = 32
        Width = 130
        Height = 23
        EditLabel.Width = 88
        EditLabel.Height = 15
        EditLabel.Caption = 'Compesa d'#233'bito'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        NumbersOnly = True
        TabOrder = 4
      end
      object lbe_taxa_debito: TLabeledEdit
        Left = 842
        Top = 32
        Width = 100
        Height = 23
        EditLabel.Width = 63
        EditLabel.Height = 15
        EditLabel.Caption = 'Taxa d'#233'bito'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        TabOrder = 5
      end
      object lbe_pessoa: TLabeledEdit
        Left = 32
        Top = 88
        Width = 410
        Height = 23
        CharCase = ecUpperCase
        EditLabel.Width = 83
        EditLabel.Height = 15
        EditLabel.Caption = '* Pessoa - ( F1 )'
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Calibri'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        ReadOnly = True
        TabOrder = 6
        OnKeyDown = lbe_pessoaKeyDown
      end
    end
  end
  object acl_cartao: TActionList
    Images = dmRepository.iml_32
    Left = 656
    Top = 269
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
