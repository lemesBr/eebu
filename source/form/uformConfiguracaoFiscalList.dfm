inherited formConfiguracaoFiscalList: TformConfiguracaoFiscalList
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formConfiguracaoFiscalList'
  ClientHeight = 740
  ClientWidth = 1024
  Color = 3618615
  KeyPreview = True
  Position = poDefaultSizeOnly
  WindowState = wsMaximized
  StyleElements = []
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
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
      Top = 98
      Width = 976
      Height = 2
      Align = alTop
      ExplicitLeft = 0
      ExplicitTop = 88
    end
    object pnl_head: TPanel
      Left = 21
      Top = 1
      Width = 976
      Height = 80
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'CONFIGURA'#199#213'ES FISCAIS'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Bombardier'
      Font.Style = []
      Padding.Top = 10
      Padding.Bottom = 10
      ParentColor = True
      ParentFont = False
      TabOrder = 0
    end
    object ts_configuracoes: TTabSet
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
      SoftTop = True
      Tabs.Strings = (
        'LISTA'
        'ICMS'
        'IPI'
        'PIS'
        'COFINS')
      TabIndex = 0
      OnChange = ts_configuracoesChange
    end
    object ntb_configuracoes: TNotebook
      Left = 21
      Top = 100
      Width = 976
      Height = 619
      Align = alClient
      PageIndex = 4
      TabOrder = 2
      object TPage
        Left = 0
        Top = 0
        Caption = 'CONFIGURACOES'
        object pnl_configuracoes_body: TPanel
          Left = 0
          Top = 0
          Width = 976
          Height = 619
          Align = alClient
          BevelOuter = bvNone
          Padding.Top = 15
          ParentColor = True
          TabOrder = 0
          object bvl_3: TBevel
            Left = 0
            Top = 95
            Width = 976
            Height = 2
            Align = alTop
            ExplicitTop = 88
          end
          object bvl_2: TBevel
            Left = 0
            Top = 537
            Width = 976
            Height = 2
            Align = alBottom
            ExplicitTop = 88
          end
          object pnl_configuracoes_footer: TPanel
            Left = 0
            Top = 539
            Width = 976
            Height = 80
            Align = alBottom
            BevelOuter = bvNone
            Padding.Top = 10
            Padding.Bottom = 10
            ParentColor = True
            TabOrder = 0
            object btn_configuracao_store: TButton
              AlignWithMargins = True
              Left = 511
              Top = 10
              Width = 150
              Height = 60
              Cursor = crHandPoint
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 5
              Margins.Bottom = 0
              Action = act_configuracao_store
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
            object btn_configuracao_update: TButton
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
              Action = act_configuracao_update
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
            object btn_rollback: TButton
              AlignWithMargins = True
              Left = 356
              Top = 10
              Width = 150
              Height = 60
              Cursor = crHandPoint
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 5
              Margins.Bottom = 0
              Action = act_rollback
              Align = alRight
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = [fsUnderline]
              Images = dmRepository.iml_32
              ParentFont = False
              TabOrder = 2
              TabStop = False
              WordWrap = True
            end
            object btn_configuracao_destroy: TButton
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
              Action = act_configuracao_destroy
              Align = alRight
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = [fsUnderline]
              Images = dmRepository.iml_32
              ParentFont = False
              TabOrder = 3
              TabStop = False
              WordWrap = True
            end
          end
          object dbg_configuracoes: TDBGrid
            Left = 0
            Top = 97
            Width = 976
            Height = 440
            TabStop = False
            Align = alClient
            BorderStyle = bsNone
            Color = clWhite
            Ctl3D = False
            DataSource = ds_configuracoes
            DrawingStyle = gdsClassic
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = [fsBold]
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 1
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Courier New'
            TitleFont.Style = [fsUnderline]
            OnDrawColumnCell = dbg_configuracoesDrawColumnCell
            Columns = <
              item
                Expanded = False
                FieldName = 'OPERACAO_FISCAL'
                Title.Caption = 'OPERA'#199#195'O FISCAL'
                Width = 500
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'GRUPO_TRIBUTARIO'
                Title.Caption = 'GRUPO TRIBUT'#193'RIO'
                Width = 400
                Visible = True
              end>
          end
          object pnl_configuracoes_search: TPanel
            Left = 0
            Top = 15
            Width = 976
            Height = 80
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Bombardier'
            Font.Style = []
            ParentColor = True
            ParentFont = False
            TabOrder = 2
            object lbe_configuracoes_search: TLabeledEdit
              Left = 238
              Top = 28
              Width = 500
              Height = 24
              CharCase = ecUpperCase
              Ctl3D = False
              EditLabel.Width = 67
              EditLabel.Height = 18
              EditLabel.Caption = 'PESQUISAR'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              MaxLength = 14
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              OnKeyDown = lbe_configuracoes_searchKeyDown
            end
          end
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'ICMS'
        object pnl_icms_body: TPanel
          Left = 0
          Top = 0
          Width = 976
          Height = 619
          Align = alClient
          BevelOuter = bvNone
          Padding.Top = 32
          ParentColor = True
          TabOrder = 0
          object bvl_4: TBevel
            Left = 0
            Top = 32
            Width = 976
            Height = 2
            Align = alTop
            ExplicitTop = 103
          end
          object bvl_6: TBevel
            Left = 0
            Top = 537
            Width = 976
            Height = 2
            Align = alBottom
            ExplicitTop = 23
          end
          object dbg_icms: TDBGrid
            Left = 0
            Top = 34
            Width = 976
            Height = 503
            TabStop = False
            Align = alClient
            BorderStyle = bsNone
            Color = clWhite
            Ctl3D = False
            DataSource = ds_icms
            DrawingStyle = gdsClassic
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = [fsBold]
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Courier New'
            TitleFont.Style = [fsUnderline]
            OnDrawColumnCell = dbg_configuracoesDrawColumnCell
            Columns = <
              item
                Expanded = False
                FieldName = 'UF_DESTINO'
                Title.Alignment = taRightJustify
                Title.Caption = 'UF DESTINO'
                Width = 150
                Visible = True
              end>
          end
          object pnl_icms_footer: TPanel
            Left = 0
            Top = 539
            Width = 976
            Height = 80
            Align = alBottom
            BevelOuter = bvNone
            Padding.Top = 10
            Padding.Bottom = 10
            ParentColor = True
            TabOrder = 1
            object btn_icms_update: TButton
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
              Action = act_icms_update
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
            object btn_icms_store: TButton
              AlignWithMargins = True
              Left = 511
              Top = 10
              Width = 150
              Height = 60
              Cursor = crHandPoint
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 5
              Margins.Bottom = 0
              Action = act_icms_store
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
            object btn_icms_rollback: TButton
              AlignWithMargins = True
              Left = 356
              Top = 10
              Width = 150
              Height = 60
              Cursor = crHandPoint
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 5
              Margins.Bottom = 0
              Action = act_icms_rollback
              Align = alRight
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = [fsUnderline]
              Images = dmRepository.iml_32
              ParentFont = False
              TabOrder = 2
              TabStop = False
              WordWrap = True
            end
            object btn_icms_destroy: TButton
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
              Action = act_icms_destroy
              Align = alRight
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = [fsUnderline]
              Images = dmRepository.iml_32
              ParentFont = False
              TabOrder = 3
              TabStop = False
              WordWrap = True
            end
          end
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'IPI'
        object pnl_ipi_body: TPanel
          Left = 0
          Top = 0
          Width = 976
          Height = 619
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
          object bvl_5: TBevel
            Left = 0
            Top = 537
            Width = 976
            Height = 2
            Align = alBottom
            ExplicitTop = 8
          end
          object lb_ipi_hint: TLabel
            Left = 0
            Top = 518
            Width = 976
            Height = 19
            Align = alBottom
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -16
            Font.Name = 'Calibri'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 4
          end
          object lb_ipi_cst: TLabel
            Left = 260
            Top = 195
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
          object pnl_ipi_footer: TPanel
            Left = 0
            Top = 539
            Width = 976
            Height = 80
            Align = alBottom
            BevelOuter = bvNone
            Padding.Top = 10
            Padding.Bottom = 10
            ParentColor = True
            TabOrder = 8
            object btn_ipi_confirmar: TButton
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
              Action = act_ipi_confirmar
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
            object btn_ipi_rollback: TButton
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
              Action = act_ipi_rollback
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
          object lbe_clenq: TLabeledEdit
            Left = 282
            Top = 32
            Width = 150
            Height = 23
            Hint = 'Classe de enquadramento do IPI para Cigarros e Bebidas'
            CharCase = ecUpperCase
            EditLabel.Width = 37
            EditLabel.Height = 15
            EditLabel.Caption = 'CLENQ'
            EditLabel.Font.Charset = ANSI_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -13
            EditLabel.Font.Name = 'Calibri'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            LabelPosition = lpLeft
            MaxLength = 5
            TabOrder = 0
            OnEnter = lbe_clenqEnter
          end
          object lbe_cnpjprod: TLabeledEdit
            Left = 282
            Top = 64
            Width = 150
            Height = 23
            Hint = 
              'CNPJ do produtor da mercadoria, quando diferente do emitente. So' +
              'mente para os casos de exporta'#231#227'o direta ou indireta.'
            CharCase = ecUpperCase
            EditLabel.Width = 57
            EditLabel.Height = 15
            EditLabel.Caption = 'CNPJPROD'
            EditLabel.Font.Charset = ANSI_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -13
            EditLabel.Font.Name = 'Calibri'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            LabelPosition = lpLeft
            MaxLength = 14
            TabOrder = 1
            OnEnter = lbe_clenqEnter
          end
          object lbe_cselo: TLabeledEdit
            Left = 282
            Top = 96
            Width = 150
            Height = 23
            Hint = 'C'#243'digo do selo de controle IPI'
            CharCase = ecUpperCase
            EditLabel.Width = 34
            EditLabel.Height = 15
            EditLabel.Caption = 'CSELO'
            EditLabel.Font.Charset = ANSI_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -13
            EditLabel.Font.Name = 'Calibri'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            LabelPosition = lpLeft
            MaxLength = 60
            TabOrder = 2
            OnEnter = lbe_clenqEnter
          end
          object lbe_qselo: TLabeledEdit
            Left = 282
            Top = 128
            Width = 150
            Height = 23
            Hint = 'Quantidade de selo de controle'
            CharCase = ecUpperCase
            EditLabel.Width = 36
            EditLabel.Height = 15
            EditLabel.Caption = 'QSELO'
            EditLabel.Font.Charset = ANSI_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -13
            EditLabel.Font.Name = 'Calibri'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            LabelPosition = lpLeft
            MaxLength = 6
            TabOrder = 3
            OnEnter = lbe_clenqEnter
          end
          object lbe_cenq: TLabeledEdit
            Left = 282
            Top = 160
            Width = 150
            Height = 23
            Hint = 'C'#243'digo de Enquadramento Legal do IP'
            CharCase = ecUpperCase
            EditLabel.Width = 31
            EditLabel.Height = 15
            EditLabel.Caption = 'CENQ'
            EditLabel.Font.Charset = ANSI_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -13
            EditLabel.Font.Name = 'Calibri'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            LabelPosition = lpLeft
            MaxLength = 3
            TabOrder = 4
            OnEnter = lbe_clenqEnter
          end
          object lbe_pipi: TLabeledEdit
            Left = 282
            Top = 224
            Width = 150
            Height = 23
            Hint = 'Al'#237'quota do IPI'
            CharCase = ecUpperCase
            EditLabel.Width = 20
            EditLabel.Height = 15
            EditLabel.Caption = 'PIPI'
            EditLabel.Font.Charset = ANSI_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -13
            EditLabel.Font.Name = 'Calibri'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            LabelPosition = lpLeft
            TabOrder = 6
            OnEnter = lbe_clenqEnter
          end
          object lbe_vunid: TLabeledEdit
            Left = 282
            Top = 256
            Width = 150
            Height = 23
            Hint = 'Valor por Unidade Tribut'#225'vel'
            CharCase = ecUpperCase
            EditLabel.Width = 36
            EditLabel.Height = 15
            EditLabel.Caption = 'VUNID'
            EditLabel.Font.Charset = ANSI_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -13
            EditLabel.Font.Name = 'Calibri'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            LabelPosition = lpLeft
            TabOrder = 7
            OnEnter = lbe_clenqEnter
          end
          object cbx_ipi_cst: TComboBox
            Left = 282
            Top = 192
            Width = 150
            Height = 23
            Hint = 'C'#243'digo da situa'#231#227'o tribut'#225'ria do IPI'
            ItemIndex = 0
            TabOrder = 5
            Text = '00'
            OnEnter = lbe_clenqEnter
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
        object pnl_pis_body: TPanel
          Left = 0
          Top = 0
          Width = 976
          Height = 619
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
          object bvl_7: TBevel
            Left = 0
            Top = 537
            Width = 976
            Height = 2
            Align = alBottom
            ExplicitTop = 8
          end
          object lb_pis_cst: TLabel
            Left = 261
            Top = 34
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
          object lb_pis_hint: TLabel
            Left = 0
            Top = 518
            Width = 976
            Height = 19
            Align = alBottom
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -16
            Font.Name = 'Calibri'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 4
          end
          object pnl_pis_footer: TPanel
            Left = 0
            Top = 539
            Width = 976
            Height = 80
            Align = alBottom
            BevelOuter = bvNone
            Padding.Top = 10
            Padding.Bottom = 10
            ParentColor = True
            TabOrder = 5
            object btn_pis_confirmar: TButton
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
              Action = act_pis_confirmar
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
            object btn_pis_rollback: TButton
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
              Action = act_pis_rollback
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
          object lbe_ppis: TLabeledEdit
            Left = 282
            Top = 64
            Width = 150
            Height = 23
            Hint = 'Al'#237'quota do PIS (em percentual)'
            CharCase = ecUpperCase
            EditLabel.Width = 26
            EditLabel.Height = 13
            EditLabel.Caption = 'PPIS'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Tahoma'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            LabelPosition = lpLeft
            TabOrder = 1
            OnEnter = cbx_pis_cstEnter
          end
          object lbe_valiqprod: TLabeledEdit
            Left = 282
            Top = 96
            Width = 150
            Height = 23
            Hint = 'Al'#237'quota do PIS (em reais)'
            CharCase = ecUpperCase
            EditLabel.Width = 65
            EditLabel.Height = 13
            EditLabel.Caption = 'VALIQPROD'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Tahoma'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            LabelPosition = lpLeft
            TabOrder = 2
            OnEnter = cbx_pis_cstEnter
          end
          object lbe_ppisst: TLabeledEdit
            Left = 282
            Top = 128
            Width = 150
            Height = 23
            Hint = 'Al'#237'quota do PIS ST (em percentual)'
            CharCase = ecUpperCase
            EditLabel.Width = 40
            EditLabel.Height = 13
            EditLabel.Caption = 'PPISST'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Tahoma'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            LabelPosition = lpLeft
            TabOrder = 3
            OnEnter = cbx_pis_cstEnter
          end
          object lbe_valiqprodst: TLabeledEdit
            Left = 282
            Top = 160
            Width = 150
            Height = 23
            Hint = 'Al'#237'quota do PIS ST (em reais)'
            CharCase = ecUpperCase
            EditLabel.Width = 79
            EditLabel.Height = 13
            EditLabel.Caption = 'VALIQPRODST'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Tahoma'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            LabelPosition = lpLeft
            TabOrder = 4
            OnEnter = cbx_pis_cstEnter
          end
          object cbx_pis_cst: TComboBox
            Left = 282
            Top = 32
            Width = 150
            Height = 23
            Hint = 'C'#243'digo de Situa'#231#227'o Tribut'#225'ria do PIS'
            ItemIndex = 0
            TabOrder = 0
            Text = '01'
            OnEnter = cbx_pis_cstEnter
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
        object pnl_cofins_body: TPanel
          Left = 0
          Top = 0
          Width = 976
          Height = 619
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
          object bvl_8: TBevel
            Left = 0
            Top = 537
            Width = 976
            Height = 2
            Align = alBottom
            ExplicitTop = 8
          end
          object lb_cofins_cst: TLabel
            Left = 260
            Top = 34
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
          object lb_cofins_hint: TLabel
            Left = 0
            Top = 518
            Width = 976
            Height = 19
            Align = alBottom
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -16
            Font.Name = 'Calibri'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 4
          end
          object lbe_pcofins: TLabeledEdit
            Left = 282
            Top = 64
            Width = 150
            Height = 23
            Hint = 'Al'#237'quota da COFINS (em percentual)'
            CharCase = ecUpperCase
            EditLabel.Width = 47
            EditLabel.Height = 13
            EditLabel.Caption = 'PCOFINS'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Tahoma'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            LabelPosition = lpLeft
            TabOrder = 1
            OnEnter = cbx_cofins_cstEnter
          end
          object lbe_cofins_valiqprod: TLabeledEdit
            Left = 282
            Top = 96
            Width = 150
            Height = 23
            Hint = 'Al'#237'quota do PIS (em reais)'
            CharCase = ecUpperCase
            EditLabel.Width = 65
            EditLabel.Height = 13
            EditLabel.Caption = 'VALIQPROD'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Tahoma'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            LabelPosition = lpLeft
            TabOrder = 2
            OnEnter = cbx_cofins_cstEnter
          end
          object lbe_pcofinsst: TLabeledEdit
            Left = 282
            Top = 128
            Width = 150
            Height = 23
            Hint = 'Al'#237'quota da COFINS ST (em percentual)'
            CharCase = ecUpperCase
            EditLabel.Width = 61
            EditLabel.Height = 13
            EditLabel.Caption = 'PCOFINSST'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Tahoma'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            LabelPosition = lpLeft
            TabOrder = 3
            OnEnter = cbx_cofins_cstEnter
          end
          object lbe_cofins_valiqprodst: TLabeledEdit
            Left = 282
            Top = 160
            Width = 150
            Height = 23
            Hint = 'Al'#237'quota do PIS ST (em reais)'
            CharCase = ecUpperCase
            EditLabel.Width = 79
            EditLabel.Height = 13
            EditLabel.Caption = 'VALIQPRODST'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Tahoma'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            LabelPosition = lpLeft
            TabOrder = 4
            OnEnter = cbx_cofins_cstEnter
          end
          object pnl_cofins_footer: TPanel
            Left = 0
            Top = 539
            Width = 976
            Height = 80
            Align = alBottom
            BevelOuter = bvNone
            Padding.Top = 10
            Padding.Bottom = 10
            ParentColor = True
            TabOrder = 5
            object btn_cofins_confirmar: TButton
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
              Action = act_cofins_confirmar
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
            object btn_cofins_rollback: TButton
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
              Action = act_cofins_rollback
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
          object cbx_cofins_cst: TComboBox
            Left = 282
            Top = 32
            Width = 150
            Height = 23
            Hint = 'C'#243'digo de Situa'#231#227'o Tribut'#225'ria da COFINS'
            ItemIndex = 0
            TabOrder = 0
            Text = '01'
            OnEnter = cbx_cofins_cstEnter
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
    end
  end
  object acl_configuracoes: TActionList
    Images = dmRepository.iml_32
    OnUpdate = acl_configuracoesUpdate
    Left = 568
    Top = 27
    object act_rollback: TAction
      Caption = 'ESC - RETORNAR'
      ImageIndex = 0
      OnExecute = act_rollbackExecute
    end
    object act_configuracao_store: TAction
      Caption = 'F2 - NOVO'
      ImageIndex = 1
      OnExecute = act_configuracao_storeExecute
    end
    object act_configuracao_update: TAction
      Caption = 'F3 - EDITAR'
      ImageIndex = 2
      OnExecute = act_configuracao_updateExecute
    end
    object act_configuracao_destroy: TAction
      Caption = 'F4 - REMOVE'
      ImageIndex = 3
      OnExecute = act_configuracao_destroyExecute
    end
    object act_icms_rollback: TAction
      Caption = 'ESC - RETORNAR'
      ImageIndex = 0
      OnExecute = act_icms_rollbackExecute
    end
    object act_icms_store: TAction
      Caption = 'F2 -NOVO'
      ImageIndex = 1
      OnExecute = act_icms_storeExecute
    end
    object act_icms_update: TAction
      Caption = 'F3 - EDITAR'
      ImageIndex = 2
      OnExecute = act_icms_updateExecute
    end
    object act_icms_destroy: TAction
      Caption = 'F4 - REMOVE'
      ImageIndex = 3
      OnExecute = act_icms_destroyExecute
    end
    object act_ipi_rollback: TAction
      Caption = 'ESC - RETORNAR'
      ImageIndex = 0
      OnExecute = act_ipi_rollbackExecute
    end
    object act_ipi_confirmar: TAction
      Caption = 'CONFIRMAR'
      ImageIndex = 6
      OnExecute = act_ipi_confirmarExecute
    end
    object act_pis_rollback: TAction
      Caption = 'ESC - RETORNAR'
      ImageIndex = 0
      OnExecute = act_pis_rollbackExecute
    end
    object act_pis_confirmar: TAction
      Caption = 'CONFIRMAR'
      ImageIndex = 6
      OnExecute = act_pis_confirmarExecute
    end
    object act_cofins_rollback: TAction
      Caption = 'ESC - RETORNAR'
      ImageIndex = 0
      OnExecute = act_cofins_rollbackExecute
    end
    object act_cofins_confirmar: TAction
      Caption = 'CONFIRMAR'
      ImageIndex = 6
      OnExecute = act_cofins_confirmarExecute
    end
  end
  object tmr_focus: TTimer
    Enabled = False
    OnTimer = tmr_focusTimer
    Left = 656
    Top = 29
  end
  object ds_configuracoes: TDataSource
    DataSet = fdmt_configuracoes
    Left = 339
    Top = 25
  end
  object fdmt_configuracoes: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 243
    Top = 25
    object fdmt_configuracoesID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_configuracoesOPERACAO_FISCAL: TStringField
      FieldName = 'OPERACAO_FISCAL'
      Size = 255
    end
    object fdmt_configuracoesGRUPO_TRIBUTARIO: TStringField
      FieldName = 'GRUPO_TRIBUTARIO'
      Size = 255
    end
  end
  object fdmt_icms: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 427
    Top = 25
    object fdmt_icmsID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_icmsUF_DESTINO: TStringField
      Alignment = taRightJustify
      FieldName = 'UF_DESTINO'
      Size = 2
    end
  end
  object ds_icms: TDataSource
    DataSet = fdmt_icms
    Left = 491
    Top = 25
  end
end
