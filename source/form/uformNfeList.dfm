inherited formNfeList: TformNfeList
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formNfeList'
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
      Caption = 'NFES'
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
    object ts_nfes: TTabSet
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
        'NFE'
        'EMITENTE'
        'DESTINATARIO'
        'ITENS'
        'TOTAIS'
        'TRANSPORTE'
        'COBRANCA'
        'RECEBIMENTO'
        'REFERENCIAS'
        'INFO ADICIONAIS')
      TabIndex = 0
      OnChange = ts_nfesChange
    end
    object ntb_nfes: TNotebook
      Left = 21
      Top = 100
      Width = 976
      Height = 619
      Align = alClient
      TabOrder = 2
      object TPage
        Left = 0
        Top = 0
        Caption = 'NFES'
        object pnl_nfes_body: TPanel
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
            ExplicitTop = 23
          end
          object bvl_2: TBevel
            Left = 0
            Top = 537
            Width = 976
            Height = 2
            Align = alBottom
            ExplicitLeft = -21
            ExplicitTop = 465
          end
          object dbg_nfes: TDBGrid
            Left = 0
            Top = 97
            Width = 976
            Height = 440
            Cursor = crHandPoint
            TabStop = False
            Align = alClient
            BorderStyle = bsNone
            Color = clWhite
            Ctl3D = False
            DataSource = ds_nfes
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
            OnDrawColumnCell = dbg_nfesDrawColumnCell
            Columns = <
              item
                Expanded = False
                FieldName = 'MODELO'
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SERIE'
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'NNF'
                Title.Caption = 'NUMERO'
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DEMI'
                Title.Caption = 'EMISSAO'
                Width = 120
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PARTICIPANTE'
                Width = 350
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'VNF'
                Title.Alignment = taRightJustify
                Title.Caption = 'TOTAL'
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SITUACAO'
                Title.Alignment = taRightJustify
                Width = 84
                Visible = True
              end>
          end
          object pnl_nfes_footer: TPanel
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
            object btn_nfe_store: TButton
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
              Action = act_nfe_store
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
            object btn_nfe_update: TButton
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
              Action = act_nfe_update
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
            object btn_nota_fiscal: TButton
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
              Align = alRight
              Caption = 'NOTA FISCAL'
              DropDownMenu = ppm_nfe
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = [fsUnderline]
              Images = dmRepository.iml_32
              ParentFont = False
              Style = bsSplitButton
              TabOrder = 3
              TabStop = False
              WordWrap = True
            end
          end
          object pnl_nfes_search: TPanel
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
            object lbe_nfes_search: TLabeledEdit
              Left = 128
              Top = 28
              Width = 400
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
              OnKeyDown = lbe_nfes_searchKeyDown
            end
            object dtp_start: TDateTimePicker
              Left = 538
              Top = 28
              Width = 150
              Height = 26
              BiDiMode = bdLeftToRight
              Date = 42977.435999409720000000
              Time = 42977.435999409720000000
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Courier New'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 1
            end
            object dtp_end: TDateTimePicker
              Left = 698
              Top = 28
              Width = 150
              Height = 26
              BiDiMode = bdLeftToRight
              Date = 42977.435999409720000000
              Time = 42977.435999409720000000
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Courier New'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 2
            end
          end
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'EMITENTE'
        object pnl_emitente_body: TPanel
          Left = 0
          Top = 0
          Width = 976
          Height = 619
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object bvl_5: TBevel
            Left = 0
            Top = 537
            Width = 976
            Height = 2
            Align = alBottom
            ExplicitTop = 543
          end
          object pnl_emitente_footer: TPanel
            Left = 0
            Top = 539
            Width = 976
            Height = 80
            Align = alBottom
            BevelOuter = bvNone
            Padding.Top = 10
            Padding.Bottom = 10
            ParentColor = True
            TabOrder = 18
            object btn_emitente_confirmar: TButton
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
              Visible = False
              WordWrap = True
            end
            object btn_emitente_rollback: TButton
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
              Action = act_rollback_listagem
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
          object lbe_emit_cep: TLabeledEdit
            Left = 672
            Top = 176
            Width = 100
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 19
            EditLabel.Height = 13
            EditLabel.Caption = 'CEP'
            MaxLength = 8
            ReadOnly = True
            TabOrder = 14
          end
          object lbe_emit_cmun: TLabeledEdit
            Left = 32
            Top = 176
            Width = 140
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 29
            EditLabel.Height = 13
            EditLabel.Caption = 'CMUN'
            MaxLength = 7
            ReadOnly = True
            TabOrder = 11
          end
          object lbe_emit_cnae: TLabeledEdit
            Left = 182
            Top = 80
            Width = 140
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 27
            EditLabel.Height = 13
            EditLabel.Caption = 'CNAE'
            MaxLength = 7
            ReadOnly = True
            TabOrder = 5
          end
          object lbe_emit_cnpjcpf: TLabeledEdit
            Left = 442
            Top = 32
            Width = 140
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 44
            EditLabel.Height = 13
            EditLabel.Caption = 'CNPJCPF'
            MaxLength = 14
            ReadOnly = True
            TabOrder = 1
          end
          object lbe_emit_cpais: TLabeledEdit
            Left = 782
            Top = 176
            Width = 100
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 30
            EditLabel.Height = 13
            EditLabel.Caption = 'CPAIS'
            MaxLength = 4
            ReadOnly = True
            TabOrder = 15
          end
          object lbe_emit_crt: TLabeledEdit
            Left = 332
            Top = 80
            Width = 140
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 20
            EditLabel.Height = 13
            EditLabel.Caption = 'CRT'
            MaxLength = 1
            ReadOnly = True
            TabOrder = 6
          end
          object lbe_emit_fone: TLabeledEdit
            Left = 442
            Top = 224
            Width = 140
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 27
            EditLabel.Height = 13
            EditLabel.Caption = 'FONE'
            MaxLength = 14
            ReadOnly = True
            TabOrder = 17
          end
          object lbe_emit_ie: TLabeledEdit
            Left = 592
            Top = 32
            Width = 140
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 10
            EditLabel.Height = 13
            EditLabel.Caption = 'IE'
            MaxLength = 14
            ReadOnly = True
            TabOrder = 2
          end
          object lbe_emit_iest: TLabeledEdit
            Left = 742
            Top = 32
            Width = 140
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 22
            EditLabel.Height = 13
            EditLabel.Caption = 'IEST'
            MaxLength = 14
            ReadOnly = True
            TabOrder = 3
          end
          object lbe_emit_im: TLabeledEdit
            Left = 32
            Top = 80
            Width = 140
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 12
            EditLabel.Height = 13
            EditLabel.Caption = 'IM'
            MaxLength = 15
            ReadOnly = True
            TabOrder = 4
          end
          object lbe_emit_nro: TLabeledEdit
            Left = 32
            Top = 128
            Width = 140
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 22
            EditLabel.Height = 13
            EditLabel.Caption = 'NRO'
            MaxLength = 60
            ReadOnly = True
            TabOrder = 8
          end
          object lbe_emit_uf: TLabeledEdit
            Left = 592
            Top = 176
            Width = 70
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 13
            EditLabel.Height = 13
            EditLabel.Caption = 'UF'
            MaxLength = 2
            ReadOnly = True
            TabOrder = 13
          end
          object lbe_emit_xbairro: TLabeledEdit
            Left = 592
            Top = 128
            Width = 290
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 45
            EditLabel.Height = 13
            EditLabel.Caption = 'XBAIRRO'
            MaxLength = 60
            ReadOnly = True
            TabOrder = 10
          end
          object lbe_emit_xcpl: TLabeledEdit
            Left = 182
            Top = 128
            Width = 400
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 24
            EditLabel.Height = 13
            EditLabel.Caption = 'XCPL'
            MaxLength = 60
            ReadOnly = True
            TabOrder = 9
          end
          object lbe_emit_xlgr: TLabeledEdit
            Left = 482
            Top = 80
            Width = 400
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 25
            EditLabel.Height = 13
            EditLabel.Caption = 'XLGR'
            MaxLength = 60
            ReadOnly = True
            TabOrder = 7
          end
          object lbe_emit_xmun: TLabeledEdit
            Left = 182
            Top = 176
            Width = 400
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 28
            EditLabel.Height = 13
            EditLabel.Caption = 'XMUN'
            MaxLength = 60
            ReadOnly = True
            TabOrder = 12
          end
          object lbe_emit_xnome: TLabeledEdit
            Left = 32
            Top = 32
            Width = 400
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 35
            EditLabel.Height = 13
            EditLabel.Caption = 'XNOME'
            MaxLength = 60
            ReadOnly = True
            TabOrder = 0
          end
          object lbe_emit_xpais: TLabeledEdit
            Left = 32
            Top = 224
            Width = 400
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 29
            EditLabel.Height = 13
            EditLabel.Caption = 'XPAIS'
            MaxLength = 60
            ReadOnly = True
            TabOrder = 16
          end
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'DESTINATARIO'
        object pnl_destinatario_body: TPanel
          Left = 0
          Top = 0
          Width = 976
          Height = 619
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object bvl_7: TBevel
            Left = 0
            Top = 537
            Width = 976
            Height = 2
            Align = alBottom
            ExplicitTop = 543
          end
          object pnl_destinatario_footer: TPanel
            Left = 0
            Top = 539
            Width = 976
            Height = 80
            Align = alBottom
            BevelOuter = bvNone
            Padding.Top = 10
            Padding.Bottom = 10
            ParentColor = True
            TabOrder = 19
            object btn_destinatario_confirmar: TButton
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
              Action = act_destinatario_confirmar
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
            object btn_destinatario_rollback: TButton
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
              Action = act_rollback_listagem
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
          object lbe_dest_cep: TLabeledEdit
            Left = 672
            Top = 176
            Width = 100
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 19
            EditLabel.Height = 13
            EditLabel.Caption = 'CEP'
            MaxLength = 8
            ReadOnly = True
            TabOrder = 14
          end
          object lbe_dest_cmun: TLabeledEdit
            Left = 32
            Top = 176
            Width = 140
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 29
            EditLabel.Height = 13
            EditLabel.Caption = 'CMUN'
            MaxLength = 7
            ReadOnly = True
            TabOrder = 11
          end
          object lbe_dest_isuf: TLabeledEdit
            Left = 182
            Top = 80
            Width = 140
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 23
            EditLabel.Height = 13
            EditLabel.Caption = 'ISUF'
            MaxLength = 9
            ReadOnly = True
            TabOrder = 5
          end
          object lbe_dest_cnpjcpf: TLabeledEdit
            Left = 442
            Top = 32
            Width = 140
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 44
            EditLabel.Height = 13
            EditLabel.Caption = 'CNPJCPF'
            MaxLength = 14
            ReadOnly = True
            TabOrder = 1
          end
          object lbe_dest_cpais: TLabeledEdit
            Left = 782
            Top = 176
            Width = 100
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 30
            EditLabel.Height = 13
            EditLabel.Caption = 'CPAIS'
            MaxLength = 4
            ReadOnly = True
            TabOrder = 15
          end
          object lbe_dest_im: TLabeledEdit
            Left = 332
            Top = 80
            Width = 140
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 12
            EditLabel.Height = 13
            EditLabel.Caption = 'IM'
            MaxLength = 15
            ReadOnly = True
            TabOrder = 6
          end
          object lbe_dest_fone: TLabeledEdit
            Left = 442
            Top = 224
            Width = 140
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 27
            EditLabel.Height = 13
            EditLabel.Caption = 'FONE'
            MaxLength = 14
            ReadOnly = True
            TabOrder = 17
          end
          object lbe_dest_idestrangeiro: TLabeledEdit
            Left = 592
            Top = 32
            Width = 140
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 82
            EditLabel.Height = 13
            EditLabel.Caption = 'IDESTRANGEIRO'
            MaxLength = 20
            ReadOnly = True
            TabOrder = 2
          end
          object lbe_dest_indiedest: TLabeledEdit
            Left = 742
            Top = 32
            Width = 140
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 53
            EditLabel.Height = 13
            EditLabel.Caption = 'INDIEDEST'
            MaxLength = 1
            ReadOnly = True
            TabOrder = 3
          end
          object lbe_dest_ie: TLabeledEdit
            Left = 32
            Top = 80
            Width = 140
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 10
            EditLabel.Height = 13
            EditLabel.Caption = 'IE'
            MaxLength = 14
            ReadOnly = True
            TabOrder = 4
          end
          object lbe_dest_nro: TLabeledEdit
            Left = 32
            Top = 128
            Width = 140
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 22
            EditLabel.Height = 13
            EditLabel.Caption = 'NRO'
            MaxLength = 60
            ReadOnly = True
            TabOrder = 8
          end
          object lbe_dest_uf: TLabeledEdit
            Left = 592
            Top = 176
            Width = 70
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 13
            EditLabel.Height = 13
            EditLabel.Caption = 'UF'
            MaxLength = 2
            ReadOnly = True
            TabOrder = 13
          end
          object lbe_dest_xbairro: TLabeledEdit
            Left = 592
            Top = 128
            Width = 290
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 45
            EditLabel.Height = 13
            EditLabel.Caption = 'XBAIRRO'
            MaxLength = 60
            ReadOnly = True
            TabOrder = 10
          end
          object lbe_dest_xcpl: TLabeledEdit
            Left = 182
            Top = 128
            Width = 400
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 24
            EditLabel.Height = 13
            EditLabel.Caption = 'XCPL'
            MaxLength = 60
            ReadOnly = True
            TabOrder = 9
          end
          object lbe_dest_xlgr: TLabeledEdit
            Left = 482
            Top = 80
            Width = 400
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 25
            EditLabel.Height = 13
            EditLabel.Caption = 'XLGR'
            MaxLength = 60
            ReadOnly = True
            TabOrder = 7
          end
          object lbe_dest_xmun: TLabeledEdit
            Left = 182
            Top = 176
            Width = 400
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 28
            EditLabel.Height = 13
            EditLabel.Caption = 'XMUN'
            MaxLength = 60
            ReadOnly = True
            TabOrder = 12
          end
          object lbe_dest_xnome: TLabeledEdit
            Left = 32
            Top = 32
            Width = 400
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 71
            EditLabel.Height = 13
            EditLabel.Caption = 'XNOME - ( F1 )'
            MaxLength = 60
            ReadOnly = True
            TabOrder = 0
            OnKeyDown = lbe_dest_xnomeKeyDown
          end
          object lbe_dest_xpais: TLabeledEdit
            Left = 32
            Top = 224
            Width = 400
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 29
            EditLabel.Height = 13
            EditLabel.Caption = 'XPAIS'
            MaxLength = 60
            ReadOnly = True
            TabOrder = 16
          end
          object lbe_dest_email: TLabeledEdit
            Left = 592
            Top = 224
            Width = 290
            Height = 21
            CharCase = ecLowerCase
            EditLabel.Width = 30
            EditLabel.Height = 13
            EditLabel.Caption = 'EMAIL'
            MaxLength = 60
            ReadOnly = True
            TabOrder = 18
          end
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'ITENS'
        object pnl_itens_body: TPanel
          Left = 0
          Top = 0
          Width = 976
          Height = 619
          Align = alClient
          BevelOuter = bvNone
          Padding.Top = 15
          ParentColor = True
          TabOrder = 0
          object bvl_4: TBevel
            Left = 0
            Top = 95
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
          object dbg_itens: TDBGrid
            Left = 0
            Top = 97
            Width = 976
            Height = 440
            TabStop = False
            Align = alClient
            BorderStyle = bsNone
            Color = clWhite
            Ctl3D = False
            DataSource = ds_dets
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
            OnDrawColumnCell = dbg_nfesDrawColumnCell
            Columns = <
              item
                Expanded = False
                FieldName = 'CPROD'
                Title.Caption = 'CODIGO'
                Width = 60
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'XPROD'
                Title.Caption = 'NOME'
                Width = 250
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'NCM'
                Width = 70
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CST'
                Width = 50
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CSOSN'
                Width = 60
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CFOP'
                Width = 60
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'UCOM'
                Title.Caption = 'UND'
                Width = 60
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'QCOM'
                Title.Alignment = taRightJustify
                Title.Caption = 'QTDE'
                Width = 80
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'VUNCOM'
                Title.Alignment = taRightJustify
                Title.Caption = 'UNITARIO'
                Width = 80
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'VDESC'
                Title.Alignment = taRightJustify
                Title.Caption = 'DESCONTO'
                Width = 80
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'VPROD'
                Title.Alignment = taRightJustify
                Title.Caption = 'TOTAL'
                Width = 100
                Visible = True
              end>
          end
          object pnl_itens_footer: TPanel
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
            object btn_item_update: TButton
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
              Action = act_item_update
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
            object btn_item_store: TButton
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
              Action = act_item_store
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
            object btn_item_rollback: TButton
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
              Action = act_rollback_listagem
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
            object btn_item_destroy: TButton
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
              Action = act_item_destroy
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
          object pnl_itens_search: TPanel
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
            object lbe_itens_search: TLabeledEdit
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
            end
          end
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'TOTAIS'
        object pnl_totais_body: TPanel
          Left = 0
          Top = 0
          Width = 976
          Height = 619
          Align = alClient
          BevelOuter = bvSpace
          ParentColor = True
          TabOrder = 0
          object bvl_9: TBevel
            Left = 1
            Top = 536
            Width = 974
            Height = 2
            Align = alBottom
            ExplicitLeft = 0
            ExplicitTop = 543
            ExplicitWidth = 976
          end
          object pnl_totais_footer: TPanel
            Left = 1
            Top = 538
            Width = 974
            Height = 80
            Align = alBottom
            BevelOuter = bvNone
            Padding.Top = 10
            Padding.Bottom = 10
            ParentColor = True
            TabOrder = 0
            object btn_totais_confirmar: TButton
              AlignWithMargins = True
              Left = 819
              Top = 10
              Width = 150
              Height = 60
              Cursor = crHandPoint
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 5
              Margins.Bottom = 0
              Action = act_totais_confirmar
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
            object btn_totais_rollback: TButton
              AlignWithMargins = True
              Left = 664
              Top = 10
              Width = 150
              Height = 60
              Cursor = crHandPoint
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 5
              Margins.Bottom = 0
              Action = act_rollback_listagem
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
          object lbe_icmstot_vbc: TLabeledEdit
            Left = 32
            Top = 32
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 19
            EditLabel.Height = 13
            EditLabel.Caption = 'VBC'
            ReadOnly = True
            TabOrder = 1
          end
          object lbe_icmstot_vicms: TLabeledEdit
            Left = 162
            Top = 32
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 31
            EditLabel.Height = 13
            EditLabel.Caption = 'VICMS'
            ReadOnly = True
            TabOrder = 2
          end
          object lbe_icmstot_vicmsdeson: TLabeledEdit
            Left = 292
            Top = 32
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 65
            EditLabel.Height = 13
            EditLabel.Caption = 'VICMSDESON'
            ReadOnly = True
            TabOrder = 3
          end
          object lbe_icmstot_vfcpufdest: TLabeledEdit
            Left = 422
            Top = 32
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 63
            EditLabel.Height = 13
            EditLabel.Caption = 'VFCPUFDEST'
            ReadOnly = True
            TabOrder = 4
          end
          object lbe_icmstot_vicmsufdest: TLabeledEdit
            Left = 552
            Top = 32
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 69
            EditLabel.Height = 13
            EditLabel.Caption = 'VICMSUFDEST'
            ReadOnly = True
            TabOrder = 5
          end
          object lbe_icmstot_vicmsufremet: TLabeledEdit
            Left = 682
            Top = 32
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 77
            EditLabel.Height = 13
            EditLabel.Caption = 'VICMSUFREMET'
            ReadOnly = True
            TabOrder = 6
          end
          object lbe_icmstot_vfcp: TLabeledEdit
            Left = 812
            Top = 32
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 25
            EditLabel.Height = 13
            EditLabel.Caption = 'VFCP'
            ReadOnly = True
            TabOrder = 7
          end
          object lbe_icmstot_vbcst: TLabeledEdit
            Left = 32
            Top = 80
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 31
            EditLabel.Height = 13
            EditLabel.Caption = 'VBCST'
            ReadOnly = True
            TabOrder = 8
          end
          object lbe_icmstot_vst: TLabeledEdit
            Left = 162
            Top = 80
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 18
            EditLabel.Height = 13
            EditLabel.Caption = 'VST'
            ReadOnly = True
            TabOrder = 9
          end
          object lbe_icmstot_vfcpst: TLabeledEdit
            Left = 292
            Top = 80
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 37
            EditLabel.Height = 13
            EditLabel.Caption = 'VFCPST'
            ReadOnly = True
            TabOrder = 10
          end
          object lbe_icmstot_vfcpstret: TLabeledEdit
            Left = 422
            Top = 80
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 56
            EditLabel.Height = 13
            EditLabel.Caption = 'VFCPSTRET'
            ReadOnly = True
            TabOrder = 11
          end
          object lbe_icmstot_vprod: TLabeledEdit
            Left = 552
            Top = 80
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 34
            EditLabel.Height = 13
            EditLabel.Caption = 'VPROD'
            ReadOnly = True
            TabOrder = 12
          end
          object lbe_icmstot_vfrete: TLabeledEdit
            Left = 682
            Top = 80
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 37
            EditLabel.Height = 13
            EditLabel.Caption = 'VFRETE'
            TabOrder = 13
            OnChange = lbe_icmstot_vfreteChange
          end
          object lbe_icmstot_vseg: TLabeledEdit
            Left = 812
            Top = 80
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 25
            EditLabel.Height = 13
            EditLabel.Caption = 'VSEG'
            TabOrder = 14
            OnChange = lbe_icmstot_vfreteChange
          end
          object lbe_icmstot_vdesc: TLabeledEdit
            Left = 32
            Top = 128
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 32
            EditLabel.Height = 13
            EditLabel.Caption = 'VDESC'
            TabOrder = 15
            OnChange = lbe_icmstot_vfreteChange
          end
          object lbe_icmstot_vii: TLabeledEdit
            Left = 162
            Top = 128
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 14
            EditLabel.Height = 13
            EditLabel.Caption = 'VII'
            ReadOnly = True
            TabOrder = 16
          end
          object lbe_icmstot_vipi: TLabeledEdit
            Left = 292
            Top = 128
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 20
            EditLabel.Height = 13
            EditLabel.Caption = 'VIPI'
            ReadOnly = True
            TabOrder = 17
          end
          object lbe_icmstot_vipidevol: TLabeledEdit
            Left = 422
            Top = 128
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 52
            EditLabel.Height = 13
            EditLabel.Caption = 'VIPIDEVOL'
            ReadOnly = True
            TabOrder = 18
          end
          object lbe_icmstot_vpis: TLabeledEdit
            Left = 552
            Top = 128
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 22
            EditLabel.Height = 13
            EditLabel.Caption = 'VPIS'
            ReadOnly = True
            TabOrder = 19
          end
          object lbe_icmstot_vcofins: TLabeledEdit
            Left = 682
            Top = 128
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 44
            EditLabel.Height = 13
            EditLabel.Caption = 'VCOFINS'
            ReadOnly = True
            TabOrder = 20
          end
          object lbe_icmstot_voutro: TLabeledEdit
            Left = 812
            Top = 128
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 42
            EditLabel.Height = 13
            EditLabel.Caption = 'VOUTRO'
            TabOrder = 21
            OnChange = lbe_icmstot_vfreteChange
          end
          object lbe_icmstot_vnf: TLabeledEdit
            Left = 32
            Top = 176
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 19
            EditLabel.Height = 13
            EditLabel.Caption = 'VNF'
            ReadOnly = True
            TabOrder = 22
          end
          object lbe_icmstot_vtottrib: TLabeledEdit
            Left = 162
            Top = 176
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 49
            EditLabel.Height = 13
            EditLabel.Caption = 'VTOTTRIB'
            ReadOnly = True
            TabOrder = 23
          end
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'TRANSPORTE'
        object pnl_transporte_body: TPanel
          Left = 0
          Top = 0
          Width = 976
          Height = 619
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object bvl_8: TBevel
            Left = 0
            Top = 537
            Width = 976
            Height = 2
            Align = alBottom
            ExplicitTop = 543
          end
          object lb_transp_modfrete: TLabel
            Left = 32
            Top = 16
            Width = 118
            Height = 13
            Caption = 'MODALIDADE DO FRETE'
          end
          object pnl_transporte_footer: TPanel
            Left = 0
            Top = 539
            Width = 976
            Height = 80
            Align = alBottom
            BevelOuter = bvNone
            Padding.Top = 10
            Padding.Bottom = 10
            ParentColor = True
            TabOrder = 3
            object btn_transporte_confirmar: TButton
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
              Action = act_transporte_confirmar
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
            object btn_transporte_rollback: TButton
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
              Action = act_rollback_listagem
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
          object lbe_transp_xnome: TLabeledEdit
            Left = 262
            Top = 32
            Width = 400
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 132
            EditLabel.Height = 13
            EditLabel.Caption = 'TRANSPORTADORA - ( F1 )'
            MaxLength = 60
            ReadOnly = True
            TabOrder = 0
            OnKeyDown = lbe_transp_xnomeKeyDown
          end
          object lbe_transp_cnpjcpf: TLabeledEdit
            Left = 672
            Top = 32
            Width = 140
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 44
            EditLabel.Height = 13
            EditLabel.Caption = 'CNPJCPF'
            MaxLength = 14
            ReadOnly = True
            TabOrder = 1
          end
          object lbe_transp_ie: TLabeledEdit
            Left = 822
            Top = 32
            Width = 120
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 10
            EditLabel.Height = 13
            EditLabel.Caption = 'IE'
            MaxLength = 14
            ReadOnly = True
            TabOrder = 2
          end
          object lbe_transp_xender: TLabeledEdit
            Left = 32
            Top = 80
            Width = 500
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 46
            EditLabel.Height = 13
            EditLabel.Caption = 'ADDRESS'
            MaxLength = 60
            ReadOnly = True
            TabOrder = 4
          end
          object lbe_transp_xmun: TLabeledEdit
            Left = 542
            Top = 80
            Width = 400
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 55
            EditLabel.Height = 13
            EditLabel.Caption = 'MUNIC'#205'PIO'
            MaxLength = 60
            ReadOnly = True
            TabOrder = 5
          end
          object lbe_transp_uf: TLabeledEdit
            Left = 32
            Top = 128
            Width = 100
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 13
            EditLabel.Height = 13
            EditLabel.Caption = 'UF'
            MaxLength = 2
            ReadOnly = True
            TabOrder = 6
          end
          object lbe_transp_vagao: TLabeledEdit
            Left = 142
            Top = 128
            Width = 200
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 35
            EditLabel.Height = 13
            EditLabel.Caption = 'VAGAO'
            MaxLength = 20
            TabOrder = 7
          end
          object lbe_transp_balsa: TLabeledEdit
            Left = 352
            Top = 128
            Width = 200
            Height = 21
            CharCase = ecUpperCase
            EditLabel.Width = 31
            EditLabel.Height = 13
            EditLabel.Caption = 'BALSA'
            MaxLength = 20
            TabOrder = 8
          end
          object cbx_transp_modfrete: TComboBox
            Left = 32
            Top = 32
            Width = 220
            Height = 21
            Style = csDropDownList
            TabOrder = 9
            Items.Strings = (
              '0 - EMITENTE'
              '1 - DEST/REM'
              '2 - TERCEIROS'
              '3 - PROP/REMT'
              '4 - PROP/DEST'
              '9 - SEM FRETE')
          end
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'COBRANCA'
        object pnl_cobranca_body: TPanel
          Left = 0
          Top = 0
          Width = 976
          Height = 619
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object bvl_10: TBevel
            Left = 0
            Top = 537
            Width = 976
            Height = 2
            Align = alBottom
            ExplicitTop = 543
          end
          object pnl_cobranca_footer: TPanel
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
            object btn_cobranca_confirmar: TButton
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
              Action = act_cobranca_confirmar
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
            object btn_cobranca_rollback: TButton
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
              Action = act_rollback_listagem
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
          object lbe_cobranca_nfat: TLabeledEdit
            Left = 32
            Top = 32
            Width = 120
            Height = 21
            EditLabel.Width = 26
            EditLabel.Height = 13
            EditLabel.Caption = 'NFAT'
            MaxLength = 60
            TabOrder = 1
          end
          object lbe_cobranca_vorig: TLabeledEdit
            Left = 162
            Top = 32
            Width = 120
            Height = 21
            EditLabel.Width = 32
            EditLabel.Height = 13
            EditLabel.Caption = 'VORIG'
            TabOrder = 2
            OnChange = lbe_cobranca_vorigChange
          end
          object lbe_cobranca_vdesc: TLabeledEdit
            Left = 292
            Top = 32
            Width = 120
            Height = 21
            EditLabel.Width = 32
            EditLabel.Height = 13
            EditLabel.Caption = 'VDESC'
            TabOrder = 3
            OnChange = lbe_cobranca_vorigChange
          end
          object lbe_cobranca_vliq: TLabeledEdit
            Left = 422
            Top = 32
            Width = 120
            Height = 21
            TabStop = False
            EditLabel.Width = 23
            EditLabel.Height = 13
            EditLabel.Caption = 'VLIQ'
            ReadOnly = True
            TabOrder = 4
          end
          object gpb_duplicatas: TGroupBox
            Left = 32
            Top = 128
            Width = 510
            Height = 385
            Caption = 'DUP'
            TabOrder = 5
            object DBGrid1: TDBGrid
              Left = 2
              Top = 15
              Width = 506
              Height = 368
              TabStop = False
              Align = alClient
              BorderStyle = bsNone
              Color = clWhite
              Ctl3D = False
              DataSource = ds_dups
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
              OnDrawColumnCell = dbg_nfesDrawColumnCell
              Columns = <
                item
                  Expanded = False
                  FieldName = 'NDUP'
                  Width = 120
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DVENC'
                  Width = 120
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'VDUP'
                  Title.Alignment = taRightJustify
                  Width = 100
                  Visible = True
                end>
            end
          end
          object lbe_cobranca_first_venc: TLabeledEdit
            Left = 32
            Top = 80
            Width = 120
            Height = 21
            TabStop = False
            EditLabel.Width = 78
            EditLabel.Height = 13
            EditLabel.Caption = 'P. VENCIMENTO'
            MaxLength = 10
            TabOrder = 6
          end
          object lbe_cobranca_parcelas: TLabeledEdit
            Left = 162
            Top = 80
            Width = 120
            Height = 21
            TabStop = False
            EditLabel.Width = 65
            EditLabel.Height = 13
            EditLabel.Caption = 'N. PARCELAS'
            MaxLength = 2
            TabOrder = 7
          end
          object btn_gera_duplicatas: TButton
            Left = 292
            Top = 78
            Width = 120
            Height = 25
            Caption = 'GERAR DUPLICATAS'
            TabOrder = 8
            OnClick = btn_gera_duplicatasClick
          end
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'PAGAMENTO'
        object pnl_pagamento_body: TPanel
          Left = 0
          Top = 0
          Width = 976
          Height = 619
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object bvl_11: TBevel
            Left = 0
            Top = 537
            Width = 976
            Height = 2
            Align = alBottom
            ExplicitTop = 545
          end
          object lb_pagamento_total_nfe: TLabel
            Left = 252
            Top = 34
            Width = 134
            Height = 15
            Caption = 'lb_pagamento_total_nfe'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Calibri'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lb_pagamento_total: TLabel
            Left = 252
            Top = 366
            Width = 134
            Height = 15
            Caption = 'lb_pagamento_total_nfe'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Calibri'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lb_pagamento_tpag: TLabel
            Left = 32
            Top = 16
            Width = 114
            Height = 13
            Caption = 'TIPO DE RECEBIMENTO'
          end
          object lb_pagamento_tband: TLabel
            Left = 32
            Top = 256
            Width = 51
            Height = 13
            Caption = 'BANDEIRA'
          end
          object pnl_pagamento_footer: TPanel
            Left = 0
            Top = 539
            Width = 976
            Height = 80
            Align = alBottom
            BevelOuter = bvNone
            Padding.Top = 10
            Padding.Bottom = 10
            ParentColor = True
            TabOrder = 10
            object btn_pagamento_confirmar: TButton
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
              Action = act_pagamento_confirmar
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
            object btn_pagamento_rollback: TButton
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
              Action = act_rollback_listagem
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
          object lbe_pagamento_vpag: TLabeledEdit
            Left = 32
            Top = 80
            Width = 180
            Height = 21
            EditLabel.Width = 51
            EditLabel.Height = 13
            EditLabel.Caption = 'RECEBIDO'
            TabOrder = 1
          end
          object lbe_pagamento_cnpj: TLabeledEdit
            Left = 32
            Top = 224
            Width = 180
            Height = 21
            EditLabel.Width = 25
            EditLabel.Height = 13
            EditLabel.Caption = 'CNPJ'
            MaxLength = 14
            NumbersOnly = True
            TabOrder = 4
          end
          object lbe_pagamento_caut: TLabeledEdit
            Left = 32
            Top = 320
            Width = 180
            Height = 21
            EditLabel.Width = 27
            EditLabel.Height = 13
            EditLabel.Caption = 'CAUT'
            MaxLength = 20
            TabOrder = 6
          end
          object lbe_pagamento_vtroco: TLabeledEdit
            Left = 32
            Top = 128
            Width = 180
            Height = 21
            EditLabel.Width = 36
            EditLabel.Height = 13
            EditLabel.Caption = 'TROCO'
            TabOrder = 2
          end
          object gpb_pagamento: TGroupBox
            Left = 252
            Top = 80
            Width = 690
            Height = 261
            Caption = 'RECEBIMENTOS'
            TabOrder = 9
            object dbg_pagamento: TDBGrid
              Left = 2
              Top = 15
              Width = 686
              Height = 244
              TabStop = False
              Align = alClient
              BorderStyle = bsNone
              Color = clWhite
              Ctl3D = False
              DataSource = ds_pag
              DrawingStyle = gdsClassic
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Courier New'
              Font.Style = [fsBold]
              Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              TitleFont.Charset = ANSI_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'Courier New'
              TitleFont.Style = [fsUnderline]
              OnDrawColumnCell = dbg_nfesDrawColumnCell
              Columns = <
                item
                  Expanded = False
                  FieldName = 'TPAG'
                  Title.Caption = 'RECEBIMENTO'
                  Width = 100
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'VPAG'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'RECEBIDO'
                  Width = 100
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'VTROCO'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'TROCO'
                  Width = 100
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'TPINTEGRA'
                  Title.Caption = 'INTEGRADO'
                  Width = 100
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CNPJ'
                  Width = 130
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'TBAND'
                  Title.Caption = 'BANDEIRA'
                  Width = 100
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CAUT'
                  Width = 150
                  Visible = True
                end>
            end
          end
          object btn_pagamento_adicionar: TButton
            Left = 32
            Top = 362
            Width = 180
            Height = 25
            Caption = 'ADICIONAR RECEBIMENTO'
            TabOrder = 7
            TabStop = False
            OnClick = btn_pagamento_adicionarClick
          end
          object btn_pagamento_limpar: TButton
            Left = 762
            Top = 28
            Width = 180
            Height = 25
            Caption = 'REMOVER RECEBIMENTOS'
            TabOrder = 8
            TabStop = False
            OnClick = btn_pagamento_limparClick
          end
          object cbx_pagamento_tpag: TComboBox
            Left = 32
            Top = 32
            Width = 180
            Height = 21
            Style = csDropDownList
            TabOrder = 0
            Items.Strings = (
              '01 - DINHEIRO'
              '02 - CHEQUE'
              '03 - CARTAO DE CREDITO'
              '04 - CARTAO DE DEBITO'
              '05 - CREDITO LOJA'
              '10 - VALE ALIMENTACAO'
              '11 - VALE REFEICAO'
              '12 - VALE PRESENTE'
              '13 - VALE COMBUSTIVEL'
              '14 - DUPLICATA MERCANTIL'
              '15 - BOLETO BANCARIO'
              '90 - SEM PAGAMENTO'
              '99 - OUTRO')
          end
          object ckb_pagamento_tpintegra: TCheckBox
            Left = 32
            Top = 176
            Width = 180
            Height = 17
            Caption = 'RECEBIMENTO INTEGRADO'
            TabOrder = 3
          end
          object cbx_pagamento_tband: TComboBox
            Left = 32
            Top = 272
            Width = 180
            Height = 21
            Style = csDropDownList
            TabOrder = 5
            Items.Strings = (
              '01 - VISA'
              '02 - MASTERCARD'
              '03 - AMERICAN EXPRESS'
              '04 - SOROCRED'
              '05 - DINERS CLUB'
              '06 - ELO'
              '07 - HIPERCARD'
              '08 - AURA'
              '09 - CABAL'
              '99 - OUTROS')
          end
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'REFERENCIAS'
        object pnl_referencias: TPanel
          Left = 0
          Top = 0
          Width = 976
          Height = 619
          Align = alClient
          BevelOuter = bvNone
          Padding.Top = 15
          ParentColor = True
          TabOrder = 0
          object gpb_refcte: TGroupBox
            Left = 0
            Top = 15
            Width = 976
            Height = 120
            Align = alTop
            Caption = 'CTE'
            TabOrder = 0
            object btn_referencias_refcte_remover: TButton
              Left = 498
              Top = 16
              Width = 150
              Height = 25
              Cursor = crHandPoint
              Action = act_referencias_refcte_remover
              Images = dmRepository.iml_32
              TabOrder = 0
            end
            object btn_referencias_refcte_adicionar: TButton
              Left = 654
              Top = 16
              Width = 150
              Height = 25
              Cursor = crHandPoint
              Action = act_referencias_refcte_adicionar
              Images = dmRepository.iml_32
              TabOrder = 1
            end
            object lbe_refcte_chnfe: TLabeledEdit
              Left = 498
              Top = 64
              Width = 465
              Height = 21
              EditLabel.Width = 33
              EditLabel.Height = 13
              EditLabel.Caption = 'CHAVE'
              MaxLength = 44
              NumbersOnly = True
              TabOrder = 2
            end
            object dbg_refcte: TDBGrid
              Left = 2
              Top = 15
              Width = 488
              Height = 103
              Cursor = crHandPoint
              TabStop = False
              Align = alLeft
              BorderStyle = bsNone
              Color = clWhite
              Ctl3D = False
              DataSource = ds_refcte
              DrawingStyle = gdsClassic
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Courier New'
              Font.Style = [fsBold]
              Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 3
              TitleFont.Charset = ANSI_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'Courier New'
              TitleFont.Style = [fsUnderline]
              OnDrawColumnCell = dbg_nfesDrawColumnCell
              Columns = <
                item
                  Expanded = False
                  FieldName = 'CHNFE'
                  Title.Caption = 'CHAVE'
                  Width = 460
                  Visible = True
                end>
            end
          end
          object gpb_refecf: TGroupBox
            Left = 0
            Top = 135
            Width = 976
            Height = 120
            Align = alTop
            Caption = 'ECF'
            TabOrder = 1
            object dbg_refecf: TDBGrid
              Left = 2
              Top = 15
              Width = 488
              Height = 103
              Cursor = crHandPoint
              TabStop = False
              Align = alLeft
              BorderStyle = bsNone
              Color = clWhite
              Ctl3D = False
              DataSource = ds_refecf
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
              OnDrawColumnCell = dbg_nfesDrawColumnCell
              Columns = <
                item
                  Expanded = False
                  FieldName = 'MODELO'
                  Width = 100
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'NECF'
                  Width = 100
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'NCOO'
                  Width = 100
                  Visible = True
                end>
            end
            object btn_referencias_refecf_remover: TButton
              Left = 498
              Top = 16
              Width = 150
              Height = 25
              Cursor = crHandPoint
              Action = act_referencias_refecf_remover
              Images = dmRepository.iml_32
              TabOrder = 1
            end
            object btn_referencias_refecf_adicionar: TButton
              Left = 654
              Top = 16
              Width = 150
              Height = 25
              Cursor = crHandPoint
              Action = act_referencias_refecf_adicionar
              Images = dmRepository.iml_32
              TabOrder = 2
            end
            object lbe_refecf_modelo: TLabeledEdit
              Left = 498
              Top = 64
              Width = 150
              Height = 21
              EditLabel.Width = 42
              EditLabel.Height = 13
              EditLabel.Caption = 'MODELO'
              MaxLength = 2
              TabOrder = 3
            end
            object lbe_refecf_necf: TLabeledEdit
              Left = 654
              Top = 64
              Width = 150
              Height = 21
              EditLabel.Width = 26
              EditLabel.Height = 13
              EditLabel.Caption = 'NECF'
              MaxLength = 3
              TabOrder = 4
            end
            object lbe_refecf_ncoo: TLabeledEdit
              Left = 810
              Top = 63
              Width = 153
              Height = 21
              EditLabel.Width = 30
              EditLabel.Height = 13
              EditLabel.Caption = 'NCOO'
              MaxLength = 6
              TabOrder = 5
            end
          end
          object gpb_refnf: TGroupBox
            Left = 0
            Top = 255
            Width = 976
            Height = 120
            Align = alTop
            Caption = 'NF'
            TabOrder = 2
            object dbg_refnf: TDBGrid
              Left = 2
              Top = 15
              Width = 488
              Height = 103
              Cursor = crHandPoint
              TabStop = False
              Align = alLeft
              BorderStyle = bsNone
              Color = clWhite
              Ctl3D = False
              DataSource = ds_refnf
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
              OnDrawColumnCell = dbg_nfesDrawColumnCell
              Columns = <
                item
                  Expanded = False
                  FieldName = 'CUF'
                  Width = 60
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'AAMM'
                  Width = 75
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CNPJ'
                  Width = 120
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'MODELO'
                  Width = 60
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'SERIE'
                  Width = 60
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'NNF'
                  Width = 75
                  Visible = True
                end>
            end
            object btn_referencias_refnf_remover: TButton
              Left = 498
              Top = 16
              Width = 150
              Height = 25
              Cursor = crHandPoint
              Action = act_referencias_refnf_remover
              Images = dmRepository.iml_32
              TabOrder = 1
            end
            object btn_referencias_refnf_adicionar: TButton
              Left = 654
              Top = 16
              Width = 150
              Height = 25
              Cursor = crHandPoint
              Action = act_referencias_refnf_adicionar
              Images = dmRepository.iml_32
              TabOrder = 2
            end
            object lbe_refnf_cuf: TLabeledEdit
              Left = 498
              Top = 64
              Width = 40
              Height = 21
              EditLabel.Width = 20
              EditLabel.Height = 13
              EditLabel.Caption = 'CUF'
              MaxLength = 2
              NumbersOnly = True
              TabOrder = 3
            end
            object lbe_refnf_aamm: TLabeledEdit
              Left = 544
              Top = 64
              Width = 60
              Height = 21
              EditLabel.Width = 30
              EditLabel.Height = 13
              EditLabel.Caption = 'AAMM'
              MaxLength = 4
              NumbersOnly = True
              TabOrder = 4
            end
            object lbe_refnf_cnpj: TLabeledEdit
              Left = 610
              Top = 64
              Width = 100
              Height = 21
              EditLabel.Width = 25
              EditLabel.Height = 13
              EditLabel.Caption = 'CNPJ'
              MaxLength = 14
              NumbersOnly = True
              TabOrder = 5
            end
            object lbe_refnf_modelo: TLabeledEdit
              Left = 716
              Top = 64
              Width = 50
              Height = 21
              EditLabel.Width = 42
              EditLabel.Height = 13
              EditLabel.Caption = 'MODELO'
              TabOrder = 6
            end
            object lbe_refnf_serie: TLabeledEdit
              Left = 772
              Top = 64
              Width = 50
              Height = 21
              EditLabel.Width = 29
              EditLabel.Height = 13
              EditLabel.Caption = 'SERIE'
              TabOrder = 7
            end
            object lbe_refnf_nnf: TLabeledEdit
              Left = 829
              Top = 64
              Width = 80
              Height = 21
              EditLabel.Width = 20
              EditLabel.Height = 13
              EditLabel.Caption = 'NNF'
              TabOrder = 8
            end
          end
          object gpb_refnfe: TGroupBox
            Left = 0
            Top = 375
            Width = 976
            Height = 120
            Align = alTop
            Caption = 'NFE'
            TabOrder = 3
            object dbg_refnfe: TDBGrid
              Left = 2
              Top = 15
              Width = 488
              Height = 103
              Cursor = crHandPoint
              TabStop = False
              Align = alLeft
              BorderStyle = bsNone
              Color = clWhite
              Ctl3D = False
              DataSource = ds_refnfe
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
              OnDrawColumnCell = dbg_nfesDrawColumnCell
              Columns = <
                item
                  Expanded = False
                  FieldName = 'CHNFE'
                  Title.Caption = 'CHAVE'
                  Width = 460
                  Visible = True
                end>
            end
            object lbe_refnfe_chnfe: TLabeledEdit
              Left = 498
              Top = 64
              Width = 465
              Height = 21
              EditLabel.Width = 33
              EditLabel.Height = 13
              EditLabel.Caption = 'CHAVE'
              MaxLength = 44
              NumbersOnly = True
              TabOrder = 1
            end
            object btn_referencias_refnfe_remover: TButton
              Left = 498
              Top = 16
              Width = 150
              Height = 25
              Cursor = crHandPoint
              Action = act_referencias_refnfe_remover
              Images = dmRepository.iml_32
              TabOrder = 2
            end
            object btn_referencias_refnfe_adicionar: TButton
              Left = 654
              Top = 16
              Width = 150
              Height = 25
              Cursor = crHandPoint
              Action = act_referencias_refnfe_adicionar
              Images = dmRepository.iml_32
              TabOrder = 3
            end
          end
          object gpb_refnfp: TGroupBox
            Left = 0
            Top = 495
            Width = 976
            Height = 120
            Align = alTop
            Caption = 'NFP'
            TabOrder = 4
            object dbg_refnfp: TDBGrid
              Left = 2
              Top = 15
              Width = 488
              Height = 103
              Cursor = crHandPoint
              TabStop = False
              Align = alLeft
              BorderStyle = bsNone
              Color = clWhite
              Ctl3D = False
              DataSource = ds_refnfp
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
              OnDrawColumnCell = dbg_nfesDrawColumnCell
              Columns = <
                item
                  Expanded = False
                  FieldName = 'CUF'
                  Width = 50
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'AAMM'
                  Width = 50
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CNPJCPF'
                  Width = 110
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'IE'
                  Width = 70
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'MODELO'
                  Width = 50
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'SERIE'
                  Width = 50
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'NNF'
                  Width = 80
                  Visible = True
                end>
            end
            object btn_referencias_refnfp_remover: TButton
              Left = 498
              Top = 16
              Width = 150
              Height = 25
              Cursor = crHandPoint
              Action = act_referencias_refnfp_remover
              Images = dmRepository.iml_32
              TabOrder = 1
            end
            object btn_referencias_refnfp_adicionar: TButton
              Left = 654
              Top = 16
              Width = 150
              Height = 25
              Cursor = crHandPoint
              Action = act_referencias_refnfp_adicionar
              Images = dmRepository.iml_32
              TabOrder = 2
            end
            object lbe_refnfp_cuf: TLabeledEdit
              Left = 498
              Top = 64
              Width = 40
              Height = 21
              EditLabel.Width = 20
              EditLabel.Height = 13
              EditLabel.Caption = 'CUF'
              MaxLength = 2
              NumbersOnly = True
              TabOrder = 3
            end
            object lbe_refnfp_aamm: TLabeledEdit
              Left = 544
              Top = 64
              Width = 60
              Height = 21
              EditLabel.Width = 30
              EditLabel.Height = 13
              EditLabel.Caption = 'AAMM'
              MaxLength = 4
              NumbersOnly = True
              TabOrder = 4
            end
            object lbe_refnfp_cnpjcpf: TLabeledEdit
              Left = 610
              Top = 64
              Width = 100
              Height = 21
              EditLabel.Width = 48
              EditLabel.Height = 13
              EditLabel.Caption = 'CNPJ/CPF'
              MaxLength = 14
              NumbersOnly = True
              TabOrder = 5
            end
            object lbe_refnfp_modelo: TLabeledEdit
              Left = 776
              Top = 64
              Width = 50
              Height = 21
              EditLabel.Width = 42
              EditLabel.Height = 13
              EditLabel.Caption = 'MODELO'
              MaxLength = 2
              TabOrder = 6
            end
            object lbe_refnfp_serie: TLabeledEdit
              Left = 832
              Top = 64
              Width = 50
              Height = 21
              EditLabel.Width = 29
              EditLabel.Height = 13
              EditLabel.Caption = 'SERIE'
              TabOrder = 7
            end
            object lbe_refnfp_nnf: TLabeledEdit
              Left = 891
              Top = 64
              Width = 72
              Height = 21
              EditLabel.Width = 20
              EditLabel.Height = 13
              EditLabel.Caption = 'NNF'
              TabOrder = 8
            end
            object lbe_refnfp_ie: TLabeledEdit
              Left = 716
              Top = 64
              Width = 52
              Height = 21
              EditLabel.Width = 10
              EditLabel.Height = 13
              EditLabel.Caption = 'IE'
              MaxLength = 14
              NumbersOnly = True
              TabOrder = 9
            end
          end
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'INFO ADICIONAIS'
        object pnl_info_adicionais: TPanel
          Left = 0
          Top = 0
          Width = 976
          Height = 619
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object bvl_12: TBevel
            Left = 0
            Top = 537
            Width = 976
            Height = 2
            Align = alBottom
            ExplicitTop = 545
          end
          object pnl_info_adicionais_footer: TPanel
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
            object btn_info_adicionais_rollback: TButton
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
              Action = act_rollback_listagem
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
            object btn_info_adicionais_confirmar: TButton
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
              Action = act_info_adicionais_confirmar
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
          object gpb_infcpl: TGroupBox
            Left = 32
            Top = 32
            Width = 913
            Height = 225
            Caption = 'INFO COMPLEMENTAR AO CONTRIBUINTE - ( F1 )'
            TabOrder = 1
            object mm_infcpl: TMemo
              Left = 2
              Top = 15
              Width = 909
              Height = 208
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              Color = clWhite
              ReadOnly = True
              ScrollBars = ssVertical
              TabOrder = 0
              OnKeyDown = mm_infcplKeyDown
            end
          end
          object gpb_infadfisco: TGroupBox
            Left = 32
            Top = 276
            Width = 913
            Height = 225
            Caption = 'INFO COMPLEMENTAR AO FISCO - ( F1 )'
            TabOrder = 2
            object mm_infadfisco: TMemo
              Left = 2
              Top = 15
              Width = 909
              Height = 208
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              Color = clWhite
              ReadOnly = True
              ScrollBars = ssVertical
              TabOrder = 0
              OnKeyDown = mm_infadfiscoKeyDown
            end
          end
        end
      end
    end
  end
  object fdmt_nfes: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 331
    Top = 297
    object fdmt_nfesID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_nfesMODELO: TStringField
      Alignment = taRightJustify
      FieldName = 'MODELO'
      Size = 2
    end
    object fdmt_nfesSERIE: TIntegerField
      FieldName = 'SERIE'
    end
    object fdmt_nfesNNF: TIntegerField
      FieldName = 'NNF'
    end
    object fdmt_nfesDEMI: TDateField
      FieldName = 'DEMI'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object fdmt_nfesPARTICIPANTE: TStringField
      FieldName = 'PARTICIPANTE'
      Size = 60
    end
    object fdmt_nfesVNF: TCurrencyField
      FieldName = 'VNF'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_nfesCHNFE: TStringField
      FieldName = 'CHNFE'
      Size = 44
    end
    object fdmt_nfesCSTAT: TIntegerField
      FieldName = 'CSTAT'
    end
    object fdmt_nfesNSEQEVENTO: TIntegerField
      FieldName = 'NSEQEVENTO'
    end
    object fdmt_nfesSITUACAO: TStringField
      Alignment = taRightJustify
      FieldName = 'SITUACAO'
      Size = 15
    end
  end
  object ds_nfes: TDataSource
    DataSet = fdmt_nfes
    Left = 331
    Top = 353
  end
  object acl_nfes: TActionList
    Images = dmRepository.iml_32
    OnUpdate = acl_nfesUpdate
    Left = 424
    Top = 355
    object act_rollback: TAction
      Caption = 'ESC - RETORNAR'
      ImageIndex = 0
      OnExecute = act_rollbackExecute
    end
    object act_rollback_listagem: TAction
      Caption = 'ESC - RETORNAR'
      ImageIndex = 0
      OnExecute = act_rollback_listagemExecute
    end
    object act_nfe_store: TAction
      Caption = 'F2 - NOVO'
      ImageIndex = 1
      OnExecute = act_nfe_storeExecute
    end
    object act_nfe_update: TAction
      Caption = 'F3 - EDITAR'
      ImageIndex = 2
      OnExecute = act_nfe_updateExecute
    end
    object act_nfe_enviar: TAction
      Caption = 'ENVIAR NOTA FISCAL'
      ImageIndex = 6
      ShortCut = 115
      OnExecute = act_nfe_enviarExecute
    end
    object act_nfe_imprimir: TAction
      Caption = 'IMPRIMIR NOTA FISCAL'
      ImageIndex = 8
      ShortCut = 116
      OnExecute = act_nfe_imprimirExecute
    end
    object act_nfe_cancelar: TAction
      Caption = 'CANCELAR NOTA FISCAL'
      ImageIndex = 3
      ShortCut = 117
      OnExecute = act_nfe_cancelarExecute
    end
    object act_nfe_inutilizar: TAction
      Caption = 'INUTILIZAR NOTA FISCAL'
      ImageIndex = 7
      ShortCut = 118
      OnExecute = act_nfe_inutilizarExecute
    end
    object act_nfe_corrigir: TAction
      Caption = 'CORRIGIR  NOTA FISCAL'
      ImageIndex = 2
      ShortCut = 119
      OnExecute = act_nfe_corrigirExecute
    end
    object act_nfe_imprimir_carta: TAction
      Caption = 'IMPRIMIR CARTA'
      ImageIndex = 8
      ShortCut = 120
      OnExecute = act_nfe_imprimir_cartaExecute
    end
    object act_nfe_exportar_xml: TAction
      Caption = 'EXPORTAR XML'
      ImageIndex = 5
      ShortCut = 121
      OnExecute = act_nfe_exportar_xmlExecute
    end
    object act_nfe_email: TAction
      Caption = 'ENVIAR EMAIL'
      ImageIndex = 5
      ShortCut = 122
      OnExecute = act_nfe_emailExecute
    end
    object act_nfe_atualizar: TAction
      Caption = 'ATUALIZAR'
      ImageIndex = 5
      ShortCut = 123
      OnExecute = act_nfe_atualizarExecute
    end
    object act_destinatario_confirmar: TAction
      Caption = 'CONFIRMAR'
      ImageIndex = 6
      OnExecute = act_destinatario_confirmarExecute
    end
    object act_item_store: TAction
      Caption = 'F2 - NOVO'
      ImageIndex = 1
      OnExecute = act_item_storeExecute
    end
    object act_item_update: TAction
      Caption = 'F3 - EDITAR'
      ImageIndex = 2
      OnExecute = act_item_updateExecute
    end
    object act_item_destroy: TAction
      Caption = 'F4 - REMOVER'
      ImageIndex = 3
      OnExecute = act_item_destroyExecute
    end
    object act_totais_confirmar: TAction
      Caption = 'CONFIRMAR'
      ImageIndex = 6
      OnExecute = act_totais_confirmarExecute
    end
    object act_transporte_confirmar: TAction
      Caption = 'CONFIRMAR'
      ImageIndex = 6
      OnExecute = act_transporte_confirmarExecute
    end
    object act_cobranca_confirmar: TAction
      Caption = 'CONFIRMAR'
      ImageIndex = 6
      OnExecute = act_cobranca_confirmarExecute
    end
    object act_pagamento_confirmar: TAction
      Caption = 'CONFIRMAR'
      ImageIndex = 6
      OnExecute = act_pagamento_confirmarExecute
    end
    object act_referencias_refcte_remover: TAction
      Caption = 'REMOVER'
      ImageIndex = 3
      OnExecute = act_referencias_refcte_removerExecute
    end
    object act_referencias_refcte_adicionar: TAction
      Caption = 'ADICIONAR'
      ImageIndex = 6
      OnExecute = act_referencias_refcte_adicionarExecute
    end
    object act_referencias_refecf_remover: TAction
      Caption = 'REMOVER'
      ImageIndex = 3
      OnExecute = act_referencias_refecf_removerExecute
    end
    object act_referencias_refecf_adicionar: TAction
      Caption = 'ADICIONAR'
      ImageIndex = 6
      OnExecute = act_referencias_refecf_adicionarExecute
    end
    object act_referencias_refnf_remover: TAction
      Caption = 'REMOVER'
      ImageIndex = 3
      OnExecute = act_referencias_refnf_removerExecute
    end
    object act_referencias_refnf_adicionar: TAction
      Caption = 'ADICIONAR'
      ImageIndex = 6
      OnExecute = act_referencias_refnf_adicionarExecute
    end
    object act_referencias_refnfe_remover: TAction
      Caption = 'REMOVER'
      ImageIndex = 3
      OnExecute = act_referencias_refnfe_removerExecute
    end
    object act_referencias_refnfe_adicionar: TAction
      Caption = 'ADICIONAR'
      ImageIndex = 6
      OnExecute = act_referencias_refnfe_adicionarExecute
    end
    object act_referencias_refnfp_remover: TAction
      Caption = 'REMOVER'
      ImageIndex = 3
      OnExecute = act_referencias_refnfp_removerExecute
    end
    object act_referencias_refnfp_adicionar: TAction
      Caption = 'ADICIONAR'
      ImageIndex = 6
      OnExecute = act_referencias_refnfp_adicionarExecute
    end
    object act_info_adicionais_confirmar: TAction
      Caption = 'CONFIRMAR'
      ImageIndex = 6
      OnExecute = act_info_adicionais_confirmarExecute
    end
  end
  object tmr_focus: TTimer
    Enabled = False
    OnTimer = tmr_focusTimer
    Left = 328
    Top = 421
  end
  object fdmt_dets: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 379
    Top = 473
    object fdmt_detsID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_detsCPROD: TStringField
      FieldName = 'CPROD'
      Size = 60
    end
    object fdmt_detsXPROD: TStringField
      FieldName = 'XPROD'
      Size = 120
    end
    object fdmt_detsNCM: TStringField
      FieldName = 'NCM'
      Size = 8
    end
    object fdmt_detsCST: TStringField
      FieldName = 'CST'
      Size = 2
    end
    object fdmt_detsCSOSN: TStringField
      FieldName = 'CSOSN'
      Size = 3
    end
    object fdmt_detsCFOP: TStringField
      FieldName = 'CFOP'
      Size = 4
    end
    object fdmt_detsUCOM: TStringField
      FieldName = 'UCOM'
      Size = 6
    end
    object fdmt_detsQCOM: TFloatField
      FieldName = 'QCOM'
      DisplayFormat = '###,###0.000'
    end
    object fdmt_detsVUNCOM: TFloatField
      FieldName = 'VUNCOM'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_detsVDESC: TFloatField
      FieldName = 'VDESC'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_detsVPROD: TFloatField
      FieldName = 'VPROD'
      DisplayFormat = '###,##0.00'
    end
  end
  object ds_dets: TDataSource
    DataSet = fdmt_dets
    Left = 379
    Top = 529
  end
  object fdmt_dups: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 323
    Top = 473
    object fdmt_dupsNDUP: TStringField
      FieldName = 'NDUP'
      Size = 60
    end
    object fdmt_dupsDVENC: TDateField
      FieldName = 'DVENC'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object fdmt_dupsVDUP: TFloatField
      FieldName = 'VDUP'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_dupsID: TStringField
      FieldName = 'ID'
      Size = 32
    end
  end
  object ds_dups: TDataSource
    DataSet = fdmt_dups
    Left = 323
    Top = 529
  end
  object ppm_nfe: TPopupMenu
    Images = dmRepository.iml_32
    Left = 424
    Top = 414
    object F4EMITIRNOTAFISCAL: TMenuItem
      Action = act_nfe_enviar
    end
    object F5IMPRIMIRNOTAFISCAL: TMenuItem
      Action = act_nfe_imprimir
    end
    object F6CANCELARNOTAFISCAL: TMenuItem
      Action = act_nfe_cancelar
    end
    object F7INUTILIZARNOTAFISCAL: TMenuItem
      Action = act_nfe_inutilizar
    end
    object F8CORRIGIRNOTAFISCAL: TMenuItem
      Action = act_nfe_corrigir
    end
    object F5IMPRIMIRCARTA1: TMenuItem
      Action = act_nfe_imprimir_carta
    end
    object F10EXPORTARXML: TMenuItem
      Action = act_nfe_exportar_xml
    end
    object ENVIAREMAIL: TMenuItem
      Action = act_nfe_email
    end
    object ATUALIZAR: TMenuItem
      Action = act_nfe_atualizar
    end
  end
  object fdmt_pag: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 448
    Top = 478
    object fdmt_pagTPAG: TStringField
      FieldName = 'TPAG'
      Size = 2
    end
    object fdmt_pagVPAG: TFloatField
      FieldName = 'VPAG'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_pagTPINTEGRA: TStringField
      FieldName = 'TPINTEGRA'
      Size = 1
    end
    object fdmt_pagCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 14
    end
    object fdmt_pagTBAND: TStringField
      FieldName = 'TBAND'
      Size = 2
    end
    object fdmt_pagCAUT: TStringField
      FieldName = 'CAUT'
    end
    object fdmt_pagVTROCO: TFloatField
      FieldName = 'VTROCO'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_pagID: TStringField
      FieldName = 'ID'
      Size = 32
    end
  end
  object ds_pag: TDataSource
    DataSet = fdmt_pag
    Left = 448
    Top = 534
  end
  object fdmt_refcte: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 320
    Top = 589
    object fdmt_refcteID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_refcteCHNFE: TStringField
      FieldName = 'CHNFE'
      Size = 44
    end
  end
  object ds_refcte: TDataSource
    DataSet = fdmt_refcte
    Left = 320
    Top = 645
  end
  object fdmt_refecf: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 392
    Top = 589
    object fdmt_refecfID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_refecfMODELO: TStringField
      FieldName = 'MODELO'
      Size = 2
    end
    object fdmt_refecfNECF: TStringField
      FieldName = 'NECF'
      Size = 3
    end
    object fdmt_refecfNCOO: TStringField
      FieldName = 'NCOO'
      Size = 6
    end
  end
  object ds_refecf: TDataSource
    DataSet = fdmt_refecf
    Left = 392
    Top = 645
  end
  object fdmt_refnfe: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 488
    Top = 589
    object fdmt_refnfeID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_refnfeCHNFE: TStringField
      FieldName = 'CHNFE'
      Size = 44
    end
  end
  object ds_refnfe: TDataSource
    DataSet = fdmt_refnfe
    Left = 488
    Top = 645
  end
  object fdmt_refnf: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 568
    Top = 589
    object fdmt_refnfID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_refnfCUF: TIntegerField
      FieldName = 'CUF'
    end
    object fdmt_refnfAAMM: TStringField
      FieldName = 'AAMM'
      Size = 4
    end
    object fdmt_refnfCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 14
    end
    object fdmt_refnfMODELO: TIntegerField
      FieldName = 'MODELO'
    end
    object fdmt_refnfSERIE: TIntegerField
      FieldName = 'SERIE'
    end
    object fdmt_refnfNNF: TIntegerField
      FieldName = 'NNF'
    end
  end
  object ds_refnf: TDataSource
    DataSet = fdmt_refnf
    Left = 568
    Top = 653
  end
  object fdmt_refnfp: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 640
    Top = 589
    object fdmt_refnfpID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_refnfpCUF: TIntegerField
      FieldName = 'CUF'
    end
    object fdmt_refnfpAAMM: TStringField
      FieldName = 'AAMM'
      Size = 4
    end
    object fdmt_refnfpCNPJCPF: TStringField
      FieldName = 'CNPJCPF'
      Size = 14
    end
    object fdmt_refnfpIE: TStringField
      FieldName = 'IE'
      Size = 14
    end
    object fdmt_refnfpMODELO: TStringField
      FieldName = 'MODELO'
      Size = 2
    end
    object fdmt_refnfpSERIE: TIntegerField
      FieldName = 'SERIE'
    end
    object fdmt_refnfpNNF: TIntegerField
      FieldName = 'NNF'
    end
  end
  object ds_refnfp: TDataSource
    DataSet = fdmt_refnfp
    Left = 640
    Top = 653
  end
end
