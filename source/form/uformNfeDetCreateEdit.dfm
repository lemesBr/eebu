inherited formNfeDetCreateEdit: TformNfeDetCreateEdit
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formNfeDetCreateEdit'
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
    object bvl_2: TBevel
      Left = 21
      Top = 637
      Width = 976
      Height = 2
      Align = alBottom
      ExplicitLeft = 0
      ExplicitTop = 88
    end
    object bvl_1: TBevel
      Left = 21
      Top = 98
      Width = 976
      Height = 2
      Align = alTop
      ExplicitLeft = 0
      ExplicitTop = 88
    end
    object scb_main: TScrollBox
      Left = 21
      Top = 100
      Width = 976
      Height = 537
      HorzScrollBar.Visible = False
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 4
    end
    object pnl_header: TPanel
      Left = 21
      Top = 1
      Width = 976
      Height = 80
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'ITEM'
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
    object ntb_nfe_det: TNotebook
      Left = 21
      Top = 100
      Width = 976
      Height = 537
      Align = alClient
      PageIndex = 1
      TabOrder = 2
      object TPage
        Left = 0
        Top = 0
        Caption = 'DADOS'
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pnl_dados_body: TPanel
          Left = 0
          Top = 0
          Width = 976
          Height = 537
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object pnl_det: TPanel
            Left = 0
            Top = 0
            Width = 976
            Height = 537
            Align = alClient
            BevelOuter = bvNone
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Calibri'
            Font.Style = []
            ParentColor = True
            ParentFont = False
            TabOrder = 0
            object lbe_det_cean: TLabeledEdit
              Left = 642
              Top = 32
              Width = 150
              Height = 23
              CharCase = ecUpperCase
              EditLabel.Width = 23
              EditLabel.Height = 15
              EditLabel.Caption = 'EAN'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              MaxLength = 14
              TabOrder = 3
            end
            object lbe_det_ceantrib: TLabeledEdit
              Left = 802
              Top = 88
              Width = 133
              Height = 23
              CharCase = ecUpperCase
              EditLabel.Width = 61
              EditLabel.Height = 15
              EditLabel.Caption = '* EAN. Trib.'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              MaxLength = 14
              TabOrder = 11
            end
            object lbe_det_cest: TLabeledEdit
              Left = 32
              Top = 200
              Width = 120
              Height = 23
              CharCase = ecUpperCase
              EditLabel.Width = 34
              EditLabel.Height = 15
              EditLabel.Caption = '* CEST'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              MaxLength = 7
              TabOrder = 19
            end
            object lbe_det_cfop: TLabeledEdit
              Left = 142
              Top = 88
              Width = 100
              Height = 23
              CharCase = ecUpperCase
              EditLabel.Width = 38
              EditLabel.Height = 15
              EditLabel.Caption = '* CFOP'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              MaxLength = 4
              TabOrder = 6
            end
            object lbe_det_cprod: TLabeledEdit
              Left = 442
              Top = 32
              Width = 100
              Height = 23
              TabStop = False
              CharCase = ecUpperCase
              EditLabel.Width = 46
              EditLabel.Height = 15
              EditLabel.Caption = '* C'#243'digo'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              MaxLength = 60
              ReadOnly = True
              TabOrder = 1
            end
            object lbe_det_extipi: TLabeledEdit
              Left = 32
              Top = 88
              Width = 100
              Height = 23
              CharCase = ecUpperCase
              EditLabel.Width = 35
              EditLabel.Height = 15
              EditLabel.Caption = 'EX TIPI'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              MaxLength = 3
              TabOrder = 5
            end
            object lbe_det_infadprod: TLabeledEdit
              Left = 32
              Top = 256
              Width = 903
              Height = 23
              CharCase = ecUpperCase
              EditLabel.Width = 122
              EditLabel.Height = 15
              EditLabel.Caption = 'Informa'#231#245'es adicionais'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              MaxLength = 255
              TabOrder = 24
            end
            object lbe_det_ncm: TLabeledEdit
              Left = 802
              Top = 32
              Width = 133
              Height = 23
              CharCase = ecUpperCase
              EditLabel.Width = 36
              EditLabel.Height = 15
              EditLabel.Caption = '* NCM'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              MaxLength = 8
              TabOrder = 4
            end
            object lbe_det_nfci: TLabeledEdit
              Left = 552
              Top = 200
              Width = 240
              Height = 23
              CharCase = ecUpperCase
              EditLabel.Width = 147
              EditLabel.Height = 15
              EditLabel.Caption = 'N'#250'mero de controle da FCI'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              MaxLength = 36
              TabOrder = 23
            end
            object lbe_det_nitem: TLabeledEdit
              Left = 552
              Top = 32
              Width = 80
              Height = 23
              TabStop = False
              CharCase = ecUpperCase
              EditLabel.Width = 41
              EditLabel.Height = 15
              EditLabel.Caption = 'N. Item'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              MaxLength = 3
              ReadOnly = True
              TabOrder = 2
            end
            object lbe_det_nitemped: TLabeledEdit
              Left = 292
              Top = 200
              Width = 120
              Height = 23
              CharCase = ecUpperCase
              EditLabel.Width = 84
              EditLabel.Height = 15
              EditLabel.Caption = 'Item do pedido'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              MaxLength = 6
              TabOrder = 21
            end
            object lbe_det_nrecopi: TLabeledEdit
              Left = 422
              Top = 200
              Width = 120
              Height = 23
              CharCase = ecUpperCase
              EditLabel.Width = 48
              EditLabel.Height = 15
              EditLabel.Caption = 'NRECOPI'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              MaxLength = 20
              TabOrder = 22
            end
            object lbe_det_qcom: TLabeledEdit
              Left = 382
              Top = 88
              Width = 120
              Height = 23
              CharCase = ecUpperCase
              EditLabel.Width = 90
              EditLabel.Height = 15
              EditLabel.Caption = '* Qtd. Comercial'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              TabOrder = 8
            end
            object lbe_det_qtrib: TLabeledEdit
              Left = 162
              Top = 144
              Width = 120
              Height = 23
              CharCase = ecUpperCase
              EditLabel.Width = 59
              EditLabel.Height = 15
              EditLabel.Caption = '* Qtd. Trib.'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              TabOrder = 13
            end
            object lbe_det_ucom: TLabeledEdit
              Left = 252
              Top = 88
              Width = 120
              Height = 23
              CharCase = ecUpperCase
              EditLabel.Width = 84
              EditLabel.Height = 15
              EditLabel.Caption = '* Un. Comercial'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              MaxLength = 6
              TabOrder = 7
            end
            object lbe_det_utrib: TLabeledEdit
              Left = 32
              Top = 144
              Width = 120
              Height = 23
              CharCase = ecUpperCase
              EditLabel.Width = 53
              EditLabel.Height = 15
              EditLabel.Caption = '* Un. Trib.'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              MaxLength = 6
              TabOrder = 12
            end
            object lbe_det_vdesc: TLabeledEdit
              Left = 682
              Top = 144
              Width = 110
              Height = 23
              CharCase = ecUpperCase
              EditLabel.Width = 51
              EditLabel.Height = 15
              EditLabel.Caption = 'Desconto'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              TabOrder = 17
            end
            object lbe_det_vfrete: TLabeledEdit
              Left = 422
              Top = 144
              Width = 120
              Height = 23
              CharCase = ecUpperCase
              EditLabel.Width = 53
              EditLabel.Height = 15
              EditLabel.Caption = 'Tot. Frete'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              TabOrder = 15
            end
            object lbe_det_voutro: TLabeledEdit
              Left = 802
              Top = 144
              Width = 133
              Height = 23
              CharCase = ecUpperCase
              EditLabel.Width = 70
              EditLabel.Height = 15
              EditLabel.Caption = 'Outras Desp.'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              TabOrder = 18
            end
            object lbe_det_vprod: TLabeledEdit
              Left = 662
              Top = 88
              Width = 130
              Height = 23
              TabStop = False
              CharCase = ecUpperCase
              EditLabel.Width = 66
              EditLabel.Height = 15
              EditLabel.Caption = '* Valor Total'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              ReadOnly = True
              TabOrder = 10
            end
            object lbe_det_vseg: TLabeledEdit
              Left = 552
              Top = 144
              Width = 120
              Height = 23
              CharCase = ecUpperCase
              EditLabel.Width = 61
              EditLabel.Height = 15
              EditLabel.Caption = 'Tot. Seguro'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              TabOrder = 16
            end
            object lbe_det_vuncom: TLabeledEdit
              Left = 512
              Top = 88
              Width = 140
              Height = 23
              CharCase = ecUpperCase
              EditLabel.Width = 123
              EditLabel.Height = 15
              EditLabel.Caption = '* Valor Unit. Comercial'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              TabOrder = 9
            end
            object lbe_det_vuntrib: TLabeledEdit
              Left = 292
              Top = 144
              Width = 120
              Height = 23
              CharCase = ecUpperCase
              EditLabel.Width = 92
              EditLabel.Height = 15
              EditLabel.Caption = '* Valor Unit. Trib.'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              TabOrder = 14
            end
            object lbe_det_xped: TLabeledEdit
              Left = 162
              Top = 200
              Width = 120
              Height = 23
              CharCase = ecUpperCase
              EditLabel.Width = 99
              EditLabel.Height = 15
              EditLabel.Caption = 'Pedido de compra'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              MaxLength = 15
              TabOrder = 20
            end
            object lbe_item: TLabeledEdit
              Left = 32
              Top = 32
              Width = 400
              Height = 23
              CharCase = ecUpperCase
              EditLabel.Width = 72
              EditLabel.Height = 15
              EditLabel.Caption = '* Item - ( F1 )'
              EditLabel.Font.Charset = ANSI_CHARSET
              EditLabel.Font.Color = clWindowText
              EditLabel.Font.Height = -13
              EditLabel.Font.Name = 'Calibri'
              EditLabel.Font.Style = [fsBold]
              EditLabel.ParentFont = False
              MaxLength = 120
              ReadOnly = True
              TabOrder = 0
              OnKeyDown = lbe_itemKeyDown
            end
            object ckb_det_indtot: TCheckBox
              Left = 32
              Top = 312
              Width = 100
              Height = 17
              TabStop = False
              Caption = 'Total da nota'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Calibri'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 25
            end
          end
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'TRIBUTOS'
        object pnl_tributos_body: TPanel
          Left = 0
          Top = 0
          Width = 976
          Height = 537
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          TabOrder = 0
          object lbe_det_vtottrib: TLabeledEdit
            Left = 160
            Top = 32
            Width = 150
            Height = 23
            CharCase = ecUpperCase
            EditLabel.Width = 126
            EditLabel.Height = 15
            EditLabel.Caption = 'Valor Total dos Tributos'
            EditLabel.Font.Charset = ANSI_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -13
            EditLabel.Font.Name = 'Calibri'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            LabelPosition = lpLeft
            TabOrder = 0
          end
          object pnl_tributos: TPanel
            Left = 32
            Top = 88
            Width = 900
            Height = 440
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 1
            object bvl_3: TBevel
              Left = 0
              Top = 17
              Width = 900
              Height = 2
              Align = alTop
              ExplicitTop = 70
            end
            object ts_tributos: TTabSet
              Left = 0
              Top = 0
              Width = 900
              Height = 17
              Cursor = crHandPoint
              Align = alTop
              BackgroundColor = clWhite
              DoubleBuffered = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Courier New'
              Font.Style = [fsUnderline]
              ParentBackground = True
              ParentDoubleBuffered = False
              Tabs.Strings = (
                'ICMS'
                'IPI'
                'PIS'
                'COFINS'
                'IMPOSTO IMPORTACAO'
                'IPI DEVOLVIDO'
                'ICMS INTERESTADUAL')
              TabIndex = 0
            end
            object ntb_tributos: TNotebook
              Left = 0
              Top = 19
              Width = 900
              Height = 421
              Align = alClient
              TabOrder = 1
              object TPage
                Left = 0
                Top = 0
                Caption = 'ICMS'
                object pnl_tributos_icms: TPanel
                  Left = 0
                  Top = 0
                  Width = 900
                  Height = 421
                  Align = alClient
                  BevelOuter = bvNone
                  ParentColor = True
                  TabOrder = 0
                  object lb_icms_cst_csosn: TLabel
                    Left = 51
                    Top = 67
                    Width = 46
                    Height = 15
                    Caption = '* CSOSN'
                    Font.Charset = ANSI_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Calibri'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object lb_icms_orig: TLabel
                    Left = 47
                    Top = 35
                    Width = 50
                    Height = 15
                    Caption = '* Origem'
                    Font.Charset = ANSI_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Calibri'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object lb_icms_modbc: TLabel
                    Left = 55
                    Top = 99
                    Width = 42
                    Height = 15
                    Caption = 'MODBC'
                    Font.Charset = ANSI_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Calibri'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object lb_icms_modbcst: TLabel
                    Left = 243
                    Top = 35
                    Width = 54
                    Height = 15
                    Caption = 'MODBCST'
                    Font.Charset = ANSI_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Calibri'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object lb_icms_ufst: TLabel
                    Left = 271
                    Top = 227
                    Width = 26
                    Height = 15
                    Caption = 'UFST'
                    Font.Charset = ANSI_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Calibri'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object lb_icms_motdesicms: TLabel
                    Left = 224
                    Top = 355
                    Width = 73
                    Height = 15
                    Caption = 'MOTDESICMS'
                    Font.Charset = ANSI_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Calibri'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object lbe_icms_pbcop: TLabeledEdit
                    Left = 300
                    Top = 256
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 37
                    EditLabel.Height = 15
                    EditLabel.Caption = 'PBCOP'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 15
                  end
                  object lbe_icms_pcredsn: TLabeledEdit
                    Left = 300
                    Top = 384
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 50
                    EditLabel.Height = 15
                    EditLabel.Caption = 'PCREDSN'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 19
                  end
                  object lbe_icms_pdif: TLabeledEdit
                    Left = 486
                    Top = 192
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 24
                    EditLabel.Height = 15
                    EditLabel.Caption = 'PDIF'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 25
                  end
                  object lbe_icms_pfcp: TLabeledEdit
                    Left = 486
                    Top = 288
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 27
                    EditLabel.Height = 15
                    EditLabel.Caption = 'PFCP'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 28
                  end
                  object lbe_icms_pfcpst: TLabeledEdit
                    Left = 486
                    Top = 384
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 39
                    EditLabel.Height = 15
                    EditLabel.Caption = 'PFCPST'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 31
                  end
                  object lbe_icms_pfcpstret: TLabeledEdit
                    Left = 700
                    Top = 96
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 58
                    EditLabel.Height = 15
                    EditLabel.Caption = 'PFCPSTRET'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 34
                  end
                  object lbe_icms_picms: TLabeledEdit
                    Left = 100
                    Top = 192
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 34
                    EditLabel.Height = 15
                    EditLabel.Caption = 'PICMS'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 6
                  end
                  object lbe_icms_picmsst: TLabeledEdit
                    Left = 300
                    Top = 160
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 46
                    EditLabel.Height = 15
                    EditLabel.Caption = 'PICMSST'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 12
                  end
                  object lbe_icms_pmvast: TLabeledEdit
                    Left = 300
                    Top = 64
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 45
                    EditLabel.Height = 15
                    EditLabel.Caption = 'PMVAST'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 9
                  end
                  object lbe_icms_predbc: TLabeledEdit
                    Left = 100
                    Top = 128
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 42
                    EditLabel.Height = 15
                    EditLabel.Caption = 'PREDBC'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 4
                  end
                  object lbe_icms_predbcst: TLabeledEdit
                    Left = 300
                    Top = 96
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 54
                    EditLabel.Height = 15
                    EditLabel.Caption = 'PREDBCST'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 10
                  end
                  object lbe_icms_pst: TLabeledEdit
                    Left = 700
                    Top = 160
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 19
                    EditLabel.Height = 15
                    EditLabel.Caption = 'PST'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 36
                  end
                  object lbe_icms_vbc: TLabeledEdit
                    Left = 100
                    Top = 160
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 22
                    EditLabel.Height = 15
                    EditLabel.Caption = 'VBC'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 5
                  end
                  object lbe_icms_vbcfcp: TLabeledEdit
                    Left = 486
                    Top = 256
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 42
                    EditLabel.Height = 15
                    EditLabel.Caption = 'VBCFCP'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 27
                  end
                  object lbe_icms_vbcfcpst: TLabeledEdit
                    Left = 486
                    Top = 352
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 54
                    EditLabel.Height = 15
                    EditLabel.Caption = 'VBCFCPST'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 30
                  end
                  object lbe_icms_vbcfcpstret: TLabeledEdit
                    Left = 700
                    Top = 64
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 73
                    EditLabel.Height = 15
                    EditLabel.Caption = 'VBCFCPSTRET'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 33
                  end
                  object lbe_icms_vbcst: TLabeledEdit
                    Left = 300
                    Top = 128
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 34
                    EditLabel.Height = 15
                    EditLabel.Caption = 'VBCST'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 11
                  end
                  object lbe_icms_vbcstdest: TLabeledEdit
                    Left = 486
                    Top = 64
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 60
                    EditLabel.Height = 15
                    EditLabel.Caption = 'VBCSTDEST'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 21
                  end
                  object lbe_icms_vbcstret: TLabeledEdit
                    Left = 300
                    Top = 288
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 53
                    EditLabel.Height = 15
                    EditLabel.Caption = 'VBCSTRET'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 16
                  end
                  object lbe_icms_vcredicmssn: TLabeledEdit
                    Left = 486
                    Top = 32
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 78
                    EditLabel.Height = 15
                    EditLabel.Caption = 'VCREDICMSSN'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 20
                  end
                  object lbe_icms_vfcp: TLabeledEdit
                    Left = 486
                    Top = 320
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 28
                    EditLabel.Height = 15
                    EditLabel.Caption = 'VFCP'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 29
                  end
                  object lbe_icms_vfcpst: TLabeledEdit
                    Left = 700
                    Top = 32
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 40
                    EditLabel.Height = 15
                    EditLabel.Caption = 'VFCPST'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 32
                  end
                  object lbe_icms_vfcpstret: TLabeledEdit
                    Left = 700
                    Top = 128
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 59
                    EditLabel.Height = 15
                    EditLabel.Caption = 'VFCPSTRET'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 35
                  end
                  object lbe_icms_vicms: TLabeledEdit
                    Left = 100
                    Top = 224
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 35
                    EditLabel.Height = 15
                    EditLabel.Caption = 'VICMS'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 7
                  end
                  object lbe_icms_vicmsdeson: TLabeledEdit
                    Left = 486
                    Top = 128
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 73
                    EditLabel.Height = 15
                    EditLabel.Caption = 'VICMSDESON'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 23
                  end
                  object lbe_icms_vicmsdif: TLabeledEdit
                    Left = 486
                    Top = 224
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 52
                    EditLabel.Height = 15
                    EditLabel.Caption = 'VICMSDIF'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 26
                  end
                  object lbe_icms_vicmsop: TLabeledEdit
                    Left = 486
                    Top = 160
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 51
                    EditLabel.Height = 15
                    EditLabel.Caption = 'VICMSOP'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 24
                  end
                  object lbe_icms_vicmsst: TLabeledEdit
                    Left = 300
                    Top = 192
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 47
                    EditLabel.Height = 15
                    EditLabel.Caption = 'VICMSST'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 13
                  end
                  object lbe_icms_vicmsstdest: TLabeledEdit
                    Left = 486
                    Top = 96
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 73
                    EditLabel.Height = 15
                    EditLabel.Caption = 'VICMSSTDEST'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 22
                  end
                  object lbe_icms_vicmsstret: TLabeledEdit
                    Left = 300
                    Top = 320
                    Width = 100
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 66
                    EditLabel.Height = 15
                    EditLabel.Caption = 'VICMSSTRET'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 17
                  end
                  object cbx_icms_cst: TComboBox
                    Left = 100
                    Top = 64
                    Width = 100
                    Height = 23
                    ItemIndex = 0
                    TabOrder = 1
                    Text = '00'
                    Items.Strings = (
                      '00'
                      '10'
                      '20'
                      '30'
                      '40'
                      '41'
                      '45'
                      '50'
                      '51'
                      '60'
                      '70'
                      '80'
                      '81'
                      '90'
                      '90'
                      '90')
                  end
                  object cbx_icms_csosn: TComboBox
                    Left = 100
                    Top = 64
                    Width = 100
                    Height = 23
                    ItemIndex = 0
                    TabOrder = 2
                    Text = '101'
                    Items.Strings = (
                      '101'
                      '102'
                      '103'
                      '201'
                      '202'
                      '203'
                      '300'
                      '400'
                      '500'
                      '900')
                  end
                  object cbx_icms_orig: TComboBox
                    Left = 100
                    Top = 32
                    Width = 100
                    Height = 23
                    ItemIndex = 0
                    TabOrder = 0
                    Text = '0'
                    Items.Strings = (
                      '0'
                      '1'
                      '2'
                      '3'
                      '4'
                      '5'
                      '6'
                      '7'
                      '8')
                  end
                  object cbx_icms_modbc: TComboBox
                    Left = 100
                    Top = 96
                    Width = 100
                    Height = 23
                    ItemIndex = 0
                    TabOrder = 3
                    Text = '0'
                    Items.Strings = (
                      '0'
                      '1'
                      '2'
                      '3')
                  end
                  object cbx_icms_modbcst: TComboBox
                    Left = 300
                    Top = 32
                    Width = 100
                    Height = 23
                    ItemIndex = 0
                    TabOrder = 8
                    Text = '0'
                    Items.Strings = (
                      '0'
                      '1'
                      '2'
                      '3'
                      '4'
                      '5')
                  end
                  object cbx_icms_ufst: TComboBox
                    Left = 300
                    Top = 224
                    Width = 100
                    Height = 23
                    ItemIndex = 12
                    TabOrder = 14
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
                  object cbx_icms_motdesicms: TComboBox
                    Left = 300
                    Top = 352
                    Width = 100
                    Height = 23
                    ItemIndex = 0
                    TabOrder = 18
                    Text = '1'
                    Items.Strings = (
                      '1'
                      '2'
                      '3'
                      '4'
                      '5'
                      '6'
                      '7'
                      '8'
                      '9'
                      '10'
                      '11'
                      '12'
                      '16')
                  end
                end
              end
              object TPage
                Left = 0
                Top = 0
                Caption = 'IPI'
                ExplicitWidth = 0
                ExplicitHeight = 401
                object pnl_tributos_ipi: TPanel
                  Left = 0
                  Top = 0
                  Width = 900
                  Height = 421
                  Align = alClient
                  BevelOuter = bvNone
                  ParentColor = True
                  TabOrder = 0
                  ExplicitHeight = 401
                  object Label1: TLabel
                    Left = 260
                    Top = 193
                    Width = 19
                    Height = 15
                    Caption = 'CST'
                    Font.Charset = ANSI_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Calibri'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object lbe_ipi_cenq: TLabeledEdit
                    Left = 282
                    Top = 64
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 146
                    EditLabel.Height = 15
                    EditLabel.Caption = 'C'#243'digo de enquadramento'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    MaxLength = 3
                    TabOrder = 1
                  end
                  object lbe_ipi_clenq: TLabeledEdit
                    Left = 282
                    Top = 32
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 142
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Classe de enquadramento'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    MaxLength = 5
                    TabOrder = 0
                  end
                  object lbe_ipi_cnpjprod: TLabeledEdit
                    Left = 282
                    Top = 97
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 96
                    EditLabel.Height = 15
                    EditLabel.Caption = 'CNPJ do Produtor'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    MaxLength = 14
                    TabOrder = 2
                  end
                  object lbe_ipi_cselo: TLabeledEdit
                    Left = 282
                    Top = 128
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 145
                    EditLabel.Height = 15
                    EditLabel.Caption = 'C'#243'digo do selo de controle'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    MaxLength = 60
                    TabOrder = 3
                  end
                  object lbe_ipi_pipi: TLabeledEdit
                    Left = 282
                    Top = 320
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 46
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Al'#237'quota'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 9
                  end
                  object lbe_ipi_qselo: TLabeledEdit
                    Left = 282
                    Top = 161
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 132
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Qtd. do selo de controle'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    MaxLength = 12
                    TabOrder = 4
                  end
                  object lbe_ipi_qunid: TLabeledEdit
                    Left = 282
                    Top = 256
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 141
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Qtd. total unidade padr'#227'o'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 7
                  end
                  object lbe_ipi_vbc: TLabeledEdit
                    Left = 282
                    Top = 224
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 128
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor da base de c'#225'lculo'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 6
                  end
                  object lbe_ipi_vipi: TLabeledEdit
                    Left = 282
                    Top = 352
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 61
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor do IPI'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 10
                  end
                  object lbe_ipi_vunid: TLabeledEdit
                    Left = 282
                    Top = 288
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 97
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor por unidade'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 8
                  end
                  object cbx_ipi_cst: TComboBox
                    Left = 282
                    Top = 192
                    Width = 150
                    Height = 23
                    ItemIndex = 0
                    TabOrder = 5
                    Text = '00'
                    Items.Strings = (
                      '00'
                      '01'
                      '02'
                      '03'
                      '04'
                      '05'
                      '49'
                      '50'
                      '51'
                      '52'
                      '53'
                      '54'
                      '55'
                      '99')
                  end
                end
              end
              object TPage
                Left = 0
                Top = 0
                Caption = 'PIS'
                ExplicitWidth = 0
                ExplicitHeight = 401
                object pnl_tributos_pis: TPanel
                  Left = 0
                  Top = 0
                  Width = 900
                  Height = 421
                  Align = alClient
                  BevelOuter = bvNone
                  Padding.Top = 20
                  ParentColor = True
                  TabOrder = 0
                  ExplicitTop = 4
                  ExplicitHeight = 401
                  object lb_pis_cst: TLabel
                    Left = 260
                    Top = 35
                    Width = 19
                    Height = 15
                    Caption = 'CST'
                    Font.Charset = ANSI_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Calibri'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object lbe_pis_ppis: TLabeledEdit
                    Left = 282
                    Top = 96
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 116
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Al'#237'quota (percentual)'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 0
                  end
                  object lbe_pis_qbcprod: TLabeledEdit
                    Left = 282
                    Top = 128
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 110
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Quantidade vendida'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 1
                  end
                  object lbe_pis_valiqprod: TLabeledEdit
                    Left = 282
                    Top = 160
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 104
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Al'#237'quota (em reais)'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 2
                  end
                  object lbe_pis_vbc: TLabeledEdit
                    Left = 282
                    Top = 64
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 128
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor da base de c'#225'lculo'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 3
                  end
                  object lbe_pis_vpis: TLabeledEdit
                    Left = 282
                    Top = 192
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 64
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor do PIS'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 4
                  end
                  object lbe_pisst_ppis: TLabeledEdit
                    Left = 282
                    Top = 256
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 131
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Al'#237'quota ST (percentual)'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 5
                  end
                  object lbe_pisst_qbcprod: TLabeledEdit
                    Left = 282
                    Top = 288
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 191
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor da base de c'#225'lculo ST produto'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 6
                  end
                  object lbe_pisst_valiqprod: TLabeledEdit
                    Left = 282
                    Top = 320
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 119
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Al'#237'quota ST (em reais)'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 7
                  end
                  object lbe_pisst_vbc: TLabeledEdit
                    Left = 282
                    Top = 224
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 143
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor da base de c'#225'lculo ST'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 8
                  end
                  object lbe_pisst_vpis: TLabeledEdit
                    Left = 282
                    Top = 352
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 79
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor do PIS ST'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 9
                  end
                  object cbx_pis_cst: TComboBox
                    Left = 282
                    Top = 32
                    Width = 150
                    Height = 23
                    ItemIndex = 0
                    TabOrder = 10
                    Text = '01'
                    Items.Strings = (
                      '01'
                      '02'
                      '03'
                      '04'
                      '05'
                      '06'
                      '07'
                      '08'
                      '09'
                      '49'
                      '50'
                      '51'
                      '52'
                      '53'
                      '54'
                      '55'
                      '56'
                      '60'
                      '61'
                      '62'
                      '63'
                      '64'
                      '65'
                      '66'
                      '67'
                      '70'
                      '71'
                      '72'
                      '73'
                      '74'
                      '75'
                      '98'
                      '99')
                  end
                end
              end
              object TPage
                Left = 0
                Top = 0
                Caption = 'COFINS'
                ExplicitWidth = 0
                ExplicitHeight = 401
                object pnl_tributos_cofins: TPanel
                  Left = 0
                  Top = 0
                  Width = 900
                  Height = 421
                  Align = alClient
                  BevelOuter = bvNone
                  Padding.Top = 20
                  ParentColor = True
                  TabOrder = 0
                  ExplicitTop = 4
                  ExplicitHeight = 401
                  object lb_cofins_cst: TLabel
                    Left = 260
                    Top = 35
                    Width = 19
                    Height = 15
                    Caption = 'CST'
                    Font.Charset = ANSI_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Calibri'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object lbe_cofins_pcofins: TLabeledEdit
                    Left = 282
                    Top = 96
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 116
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Al'#237'quota (percentual)'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 2
                  end
                  object lbe_cofins_qbcprod: TLabeledEdit
                    Left = 282
                    Top = 128
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 110
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Quantidade vendida'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 3
                  end
                  object lbe_cofins_valiqprod: TLabeledEdit
                    Left = 282
                    Top = 192
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 104
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Al'#237'quota (em reais)'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 5
                  end
                  object lbe_cofins_vbc: TLabeledEdit
                    Left = 282
                    Top = 64
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 128
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor da base de c'#225'lculo'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 1
                  end
                  object lbe_cofins_vbcprod: TLabeledEdit
                    Left = 282
                    Top = 160
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 176
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor da base de c'#225'lculo produto'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 4
                  end
                  object lbe_cofins_vcofins: TLabeledEdit
                    Left = 282
                    Top = 224
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 88
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor do COFINS'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 6
                  end
                  object lbe_cofinsst_pcofins: TLabeledEdit
                    Left = 282
                    Top = 288
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 131
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Al'#237'quota ST (percentual)'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 8
                  end
                  object lbe_cofinsst_qbcprod: TLabeledEdit
                    Left = 282
                    Top = 320
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 191
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor da base de c'#225'lculo ST produto'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 9
                  end
                  object lbe_cofinsst_valiqprod: TLabeledEdit
                    Left = 282
                    Top = 352
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 119
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Al'#237'quota ST (em reais)'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 10
                  end
                  object lbe_cofinsst_vbc: TLabeledEdit
                    Left = 282
                    Top = 256
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 143
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor da base de c'#225'lculo ST'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 7
                  end
                  object lbe_cofinsst_vcofins: TLabeledEdit
                    Left = 282
                    Top = 384
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 103
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor do COFINS ST'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 11
                  end
                  object cbx_cofins_cst: TComboBox
                    Left = 282
                    Top = 32
                    Width = 150
                    Height = 23
                    Style = csDropDownList
                    ItemIndex = 0
                    TabOrder = 0
                    Text = '01'
                    Items.Strings = (
                      '01'
                      '02'
                      '03'
                      '04'
                      '05'
                      '06'
                      '07'
                      '08'
                      '09'
                      '49'
                      '50'
                      '51'
                      '52'
                      '53'
                      '54'
                      '55'
                      '56'
                      '60'
                      '61'
                      '62'
                      '63'
                      '64'
                      '65'
                      '66'
                      '67'
                      '70'
                      '71'
                      '72'
                      '73'
                      '74'
                      '75'
                      '98'
                      '99')
                  end
                end
              end
              object TPage
                Left = 0
                Top = 0
                Caption = 'II'
                ExplicitWidth = 0
                ExplicitHeight = 401
                object pnl_tributos_imposto_importacao: TPanel
                  Left = 0
                  Top = 0
                  Width = 900
                  Height = 421
                  Align = alClient
                  BevelOuter = bvNone
                  ParentColor = True
                  TabOrder = 0
                  ExplicitHeight = 401
                  object lbe_ii_vbc: TLabeledEdit
                    Left = 282
                    Top = 32
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 112
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor base de c'#225'lculo'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 0
                  end
                  object lbe_ii_vdespadu: TLabeledEdit
                    Left = 282
                    Top = 64
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 142
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor despesas aduaneiras'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 1
                  end
                  object lbe_ii_vii: TLabeledEdit
                    Left = 282
                    Top = 128
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 158
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor imposto de importa'#231#227'o'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 2
                  end
                  object lbe_ii_viof: TLabeledEdit
                    Left = 282
                    Top = 96
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 66
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor do IOF'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 3
                  end
                end
              end
              object TPage
                Left = 0
                Top = 0
                Caption = 'IPI DEVOLVIDO'
                ExplicitWidth = 0
                ExplicitHeight = 401
                object pnl_tributos_ipi_devolvido: TPanel
                  Left = 0
                  Top = 0
                  Width = 900
                  Height = 421
                  Align = alClient
                  BevelOuter = bvNone
                  ParentColor = True
                  TabOrder = 0
                  ExplicitHeight = 401
                  object lbe_det_pdevol: TLabeledEdit
                    Left = 282
                    Top = 32
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 195
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Percentual da mercadoria devolvida'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 0
                  end
                  object lbe_det_vipidevol: TLabeledEdit
                    Left = 282
                    Top = 64
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 117
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor do IPI devolvido'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 1
                  end
                end
              end
              object TPage
                Left = 0
                Top = 0
                Caption = 'ICMS INTERESTADUAL'
                ExplicitWidth = 0
                ExplicitHeight = 401
                object pnl_tributos_icms_interestadual: TPanel
                  Left = 0
                  Top = 0
                  Width = 900
                  Height = 421
                  Align = alClient
                  BevelOuter = bvNone
                  ParentColor = True
                  TabOrder = 0
                  ExplicitTop = 4
                  ExplicitHeight = 401
                  object lbe_icms_uf_dest_pfcpufdest: TLabeledEdit
                    Left = 282
                    Top = 96
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 193
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Percentual do FCP da UF de destino'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 2
                  end
                  object lbe_icms_uf_dest_picmsinter: TLabeledEdit
                    Left = 282
                    Top = 160
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 122
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Al'#237'quota interestadual'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 4
                  end
                  object lbe_icms_uf_dest_picmsinterpart: TLabeledEdit
                    Left = 282
                    Top = 192
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 179
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Percentual provis'#243'rio de partilha'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 5
                  end
                  object lbe_icms_uf_dest_picmsufdest: TLabeledEdit
                    Left = 282
                    Top = 128
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 167
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Al'#237'quota interna UF de destino'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 3
                  end
                  object lbe_icms_uf_dest_vbcfcpufdest: TLabeledEdit
                    Left = 282
                    Top = 64
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 262
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor da base de c'#225'lculo do FCP na UF de destino'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 1
                  end
                  object lbe_icms_uf_dest_vbcufdest: TLabeledEdit
                    Left = 282
                    Top = 32
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 222
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor da base de c'#225'lculo na UF de destino'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 0
                  end
                  object lbe_icms_uf_dest_vfcpufdest: TLabeledEdit
                    Left = 282
                    Top = 256
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 236
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor ICMS relativo ao FCP da UF de destino'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 7
                  end
                  object lbe_icms_uf_dest_vicmsufdest: TLabeledEdit
                    Left = 282
                    Top = 224
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 250
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor ICMS de partilha para UF do destinat'#225'rio'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 6
                  end
                  object lbe_icms_uf_dest_vicmsufremet: TLabeledEdit
                    Left = 282
                    Top = 288
                    Width = 150
                    Height = 23
                    CharCase = ecUpperCase
                    EditLabel.Width = 245
                    EditLabel.Height = 15
                    EditLabel.Caption = 'Valor ICMS de partilha para UF do remetente'
                    EditLabel.Font.Charset = ANSI_CHARSET
                    EditLabel.Font.Color = clWindowText
                    EditLabel.Font.Height = -13
                    EditLabel.Font.Name = 'Calibri'
                    EditLabel.Font.Style = [fsBold]
                    EditLabel.ParentFont = False
                    LabelPosition = lpLeft
                    TabOrder = 8
                  end
                end
              end
            end
          end
        end
      end
    end
    object ts_nfe_det: TTabSet
      Left = 21
      Top = 81
      Width = 976
      Height = 17
      Cursor = crHandPoint
      Align = alTop
      BackgroundColor = clWhite
      DoubleBuffered = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = [fsUnderline]
      ParentBackground = True
      ParentDoubleBuffered = False
      Tabs.Strings = (
        'DADOS'
        'TRIBUTOS')
      TabIndex = 0
    end
  end
  object acl_nfe_det: TActionList
    Images = dmRepository.iml_32
    OnUpdate = acl_nfe_detUpdate
    Left = 584
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
