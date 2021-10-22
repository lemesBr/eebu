inherited formUserCreateEdit: TformUserCreateEdit
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formAuthCreate'
  ClientHeight = 740
  ClientWidth = 1024
  Color = 3618615
  Position = poDefaultSizeOnly
  ShowHint = True
  WindowState = wsMaximized
  StyleElements = []
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
      Caption = 'USU'#193'RIO'
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
      object bvl_4: TBevel
        Left = 820
        Top = 10
        Width = 6
        Height = 60
        Align = alRight
        Shape = bsSpacer
        ExplicitLeft = 794
        ExplicitTop = 18
      end
      object btn_1: TButton
        Left = 826
        Top = 10
        Width = 150
        Height = 60
        Cursor = crHandPoint
        Hint = 'Confirmar opera'#231#227'o e salvar!'
        Action = act_confirmar
        Align = alRight
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Bombardier'
        Font.Style = [fsUnderline]
        HotImageIndex = 6
        Images = dmRepository.iml_32
        ParentFont = False
        TabOrder = 0
        TabStop = False
        WordWrap = True
      end
      object Button1: TButton
        Left = 670
        Top = 10
        Width = 150
        Height = 60
        Cursor = crHandPoint
        Hint = 'Cancelar opera'#231#227'o do formul'#225'rio e sair!'
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
    object pnl_main: TPanel
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
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      ExplicitTop = 79
      object lbe_nome: TLabeledEdit
        Tag = 1
        Left = 32
        Top = 32
        Width = 245
        Height = 23
        Hint = 'Nome completo do Usu'#225'rio!'
        CharCase = ecUpperCase
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
        TextHint = 'Nome completo do Usu'#225'rio!'
      end
      object lbe_email: TLabeledEdit
        Tag = 1
        Left = 287
        Top = 32
        Width = 225
        Height = 23
        Hint = 'Email de acesso ao sistema!'
        CharCase = ecLowerCase
        EditLabel.Width = 38
        EditLabel.Height = 15
        EditLabel.Caption = '* Email'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TextHint = 'Email de acesso ao sistema!'
      end
      object lbe_senha: TLabeledEdit
        Tag = 1
        Left = 522
        Top = 32
        Width = 200
        Height = 23
        Hint = 'Senha para acesso ao sistema!'
        CharCase = ecUpperCase
        EditLabel.Width = 42
        EditLabel.Height = 15
        EditLabel.Caption = '* Senha'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        PasswordChar = '#'
        TabOrder = 2
        TextHint = 'Senha para acesso ao sistema!'
      end
      object lbe_confirma_senha: TLabeledEdit
        Tag = 1
        Left = 732
        Top = 32
        Width = 200
        Height = 23
        Hint = 'Confirma'#231#227'o da senha de acesso!'
        CharCase = ecUpperCase
        EditLabel.Width = 103
        EditLabel.Height = 15
        EditLabel.Caption = '* Confirmar senha:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        PasswordChar = '#'
        TabOrder = 3
        TextHint = 'Confirma'#231#227'o da senha de acesso!'
      end
    end
  end
  object acl_usuario: TActionList
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
