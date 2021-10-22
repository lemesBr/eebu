inherited formPagamentoCreateEdit: TformPagamentoCreateEdit
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formPagamentoCreateEdit'
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
      Caption = 'PAGAMENTO'
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
      object pnl_left: TPanel
        Left = 0
        Top = 0
        Width = 650
        Height = 554
        Align = alLeft
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        Padding.Bottom = 40
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        object pnl_recebimento: TPanel
          Left = 0
          Top = 280
          Width = 650
          Height = 120
          Align = alTop
          BevelOuter = bvNone
          Padding.Right = 20
          ParentColor = True
          TabOrder = 2
          object bvl_5: TBevel
            Left = 0
            Top = 0
            Width = 630
            Height = 2
            Align = alTop
            ExplicitTop = 8
            ExplicitWidth = 185
          end
          object lb_pagamento: TLabel
            Left = 20
            Top = 52
            Width = 61
            Height = 15
            Caption = 'Pagamento'
          end
          object ckb_situacao: TCheckBox
            Left = 20
            Top = 20
            Width = 97
            Height = 17
            Cursor = crHandPoint
            Caption = 'Pago'
            TabOrder = 0
          end
          object lbe_descontos_taxas: TLabeledEdit
            Left = 180
            Top = 70
            Width = 140
            Height = 23
            CharCase = ecUpperCase
            EditLabel.Width = 99
            EditLabel.Height = 15
            EditLabel.Caption = 'Descontos / Taxas'
            TabOrder = 2
            OnChange = lbe_valorChange
          end
          object lbe_juros_multa: TLabeledEdit
            Left = 330
            Top = 70
            Width = 140
            Height = 23
            CharCase = ecUpperCase
            EditLabel.Width = 73
            EditLabel.Height = 15
            EditLabel.Caption = 'Juros / Multa'
            TabOrder = 3
            OnChange = lbe_valorChange
          end
          object lbe_valor_pago: TLabeledEdit
            Left = 480
            Top = 70
            Width = 150
            Height = 23
            CharCase = ecUpperCase
            EditLabel.Width = 59
            EditLabel.Height = 15
            EditLabel.Caption = 'Valor Pago'
            ReadOnly = True
            TabOrder = 4
          end
          object dtp_pagamento: TDateTimePicker
            Left = 20
            Top = 70
            Width = 150
            Height = 23
            Date = 43132.654467256940000000
            Time = 43132.654467256940000000
            TabOrder = 1
          end
        end
        object pnl_repetir: TPanel
          Left = 0
          Top = 160
          Width = 650
          Height = 120
          Align = alTop
          BevelOuter = bvNone
          Padding.Right = 20
          ParentColor = True
          TabOrder = 1
          object bvl_4: TBevel
            Left = 0
            Top = 0
            Width = 630
            Height = 2
            Align = alTop
            ExplicitTop = 8
            ExplicitWidth = 650
          end
          object ckb_repetir: TCheckBox
            Left = 20
            Top = 28
            Width = 97
            Height = 17
            Cursor = crHandPoint
            Caption = 'Repetir'
            TabOrder = 0
          end
          object cbx_ocorrencia: TComboBox
            Left = 20
            Top = 70
            Width = 150
            Height = 23
            ItemIndex = 2
            TabOrder = 1
            Text = 'Mensalmente'
            Items.Strings = (
              'Diariamente'
              'Semanalmente'
              'Mensalmente'
              'Bimestralmente'
              'Trimestralmente'
              'Semestralmente'
              'Anualmente')
          end
          object lbe_vezes: TLabeledEdit
            Left = 182
            Top = 70
            Width = 100
            Height = 23
            CharCase = ecUpperCase
            EditLabel.Width = 29
            EditLabel.Height = 15
            EditLabel.Caption = 'Vezes'
            NumbersOnly = True
            TabOrder = 2
          end
        end
        object pnl_edits: TPanel
          Left = 0
          Top = 0
          Width = 650
          Height = 160
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object lb_competencia: TLabel
            Left = 230
            Top = 87
            Width = 81
            Height = 15
            Caption = '* Compet'#234'ncia'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Calibri'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lb_vencimento: TLabel
            Left = 370
            Top = 87
            Width = 75
            Height = 15
            Caption = '* Vencimento'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Calibri'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbe_categoria: TLabeledEdit
            Tag = 1
            Left = 330
            Top = 50
            Width = 300
            Height = 23
            CharCase = ecUpperCase
            EditLabel.Width = 98
            EditLabel.Height = 15
            EditLabel.Caption = '* Categoria - ( F1 )'
            EditLabel.Font.Charset = ANSI_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -13
            EditLabel.Font.Name = 'Calibri'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            ParentShowHint = False
            ReadOnly = True
            ShowHint = False
            TabOrder = 1
            OnKeyDown = lbe_categoriaKeyDown
          end
          object lbe_conta: TLabeledEdit
            Tag = 1
            Left = 20
            Top = 105
            Width = 200
            Height = 23
            CharCase = ecUpperCase
            EditLabel.Width = 78
            EditLabel.Height = 15
            EditLabel.Caption = '* Conta - ( F1 )'
            EditLabel.Font.Charset = ANSI_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -13
            EditLabel.Font.Name = 'Calibri'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            ParentShowHint = False
            ReadOnly = True
            ShowHint = False
            TabOrder = 2
            OnKeyDown = lbe_contaKeyDown
          end
          object lbe_descricao: TLabeledEdit
            Tag = 1
            Left = 20
            Top = 50
            Width = 300
            Height = 23
            CharCase = ecUpperCase
            EditLabel.Width = 65
            EditLabel.Height = 15
            EditLabel.Caption = '* Referente'
            EditLabel.Font.Charset = ANSI_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -13
            EditLabel.Font.Name = 'Calibri'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            MaxLength = 255
            TabOrder = 0
          end
          object lbe_valor: TLabeledEdit
            Left = 512
            Top = 105
            Width = 118
            Height = 23
            CharCase = ecUpperCase
            EditLabel.Width = 37
            EditLabel.Height = 15
            EditLabel.Caption = '* Valor'
            EditLabel.Font.Charset = ANSI_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -13
            EditLabel.Font.Name = 'Calibri'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            TabOrder = 5
            OnChange = lbe_valorChange
          end
          object dtp_competencia: TDateTimePicker
            Left = 230
            Top = 105
            Width = 130
            Height = 23
            Date = 43132.654467256940000000
            Time = 43132.654467256940000000
            TabOrder = 3
          end
          object dtp_vencimento: TDateTimePicker
            Left = 370
            Top = 105
            Width = 130
            Height = 23
            Date = 43132.654467256940000000
            Time = 43132.654467256940000000
            TabOrder = 4
          end
        end
      end
      object pnl_right: TPanel
        Left = 650
        Top = 0
        Width = 326
        Height = 554
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        Padding.Top = 40
        Padding.Bottom = 40
        ParentColor = True
        ParentFont = False
        TabOrder = 1
        object bvl_3: TBevel
          Left = 0
          Top = 40
          Width = 2
          Height = 474
          Align = alLeft
          ExplicitTop = 552
          ExplicitHeight = 336
        end
        object lbe_pessoa: TLabeledEdit
          Tag = 1
          Left = 17
          Top = 50
          Width = 289
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
          ParentShowHint = False
          ReadOnly = True
          ShowHint = False
          TabOrder = 0
          OnKeyDown = lbe_pessoaKeyDown
        end
      end
    end
  end
  object acl_pagamento: TActionList
    Images = dmRepository.iml_32
    OnUpdate = acl_pagamentoUpdate
    Left = 624
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
