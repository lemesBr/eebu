inherited formRecebimentoList: TformRecebimentoList
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formRecebimentoList'
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
      Caption = 'CONTAS A RECEBER'
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
      object btn_recebimento: TButton
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
        Caption = 'RECEBIMENTO'
        DropDownMenu = ppm_recebimento
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Bombardier'
        Font.Style = [fsUnderline]
        Images = dmRepository.iml_32
        ParentFont = False
        Style = bsSplitButton
        TabOrder = 0
        TabStop = False
        WordWrap = True
      end
      object btn_rollback: TButton
        AlignWithMargins = True
        Left = 201
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
        TabOrder = 1
        TabStop = False
        WordWrap = True
      end
      object btn_recebimento_store: TButton
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
        Action = act_recebimento_store
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
      object btn_recebimento_update: TButton
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
        Action = act_recebimento_update
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
      object btn_recebimento_destroy: TButton
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
        Action = act_recebimento_destroy
        Align = alRight
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Bombardier'
        Font.Style = [fsUnderline]
        Images = dmRepository.iml_32
        ParentFont = False
        TabOrder = 4
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
      ParentColor = True
      TabOrder = 2
      object bvl_3: TBevel
        Left = 0
        Top = 132
        Width = 976
        Height = 2
        Align = alTop
        ExplicitTop = 88
      end
      object pnl_search: TPanel
        Left = 0
        Top = 0
        Width = 976
        Height = 132
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object lb_filtro: TLabel
          Left = 32
          Top = 14
          Width = 26
          Height = 15
          Caption = 'DATA'
        end
        object lb_start: TLabel
          Left = 217
          Top = 14
          Width = 92
          Height = 15
          Caption = 'PER'#205'ODO INICIAL'
        end
        object lb_end: TLabel
          Left = 402
          Top = 14
          Width = 83
          Height = 15
          Caption = 'PER'#205'ODO FINAL'
        end
        object lb_situacao: TLabel
          Left = 587
          Top = 14
          Width = 37
          Height = 15
          Caption = 'STATUS'
        end
        object lb_conta: TLabel
          Left = 32
          Top = 70
          Width = 36
          Height = 15
          Caption = 'CONTA'
        end
        object lb_categoria: TLabel
          Left = 217
          Top = 70
          Width = 60
          Height = 15
          Caption = 'CATEGORIA'
        end
        object lb_pessoa: TLabel
          Left = 402
          Top = 70
          Width = 41
          Height = 15
          Caption = 'PESSOA'
        end
        object lb_boleto: TLabel
          Left = 772
          Top = 14
          Width = 42
          Height = 15
          Caption = 'BOLETO'
        end
        object lbe_search: TLabeledEdit
          Left = 712
          Top = 88
          Width = 235
          Height = 21
          CharCase = ecUpperCase
          Ctl3D = False
          EditLabel.Width = 60
          EditLabel.Height = 15
          EditLabel.Caption = 'PESQUISAR'
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'Calibri'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          MaxLength = 30
          ParentCtl3D = False
          TabOrder = 8
          OnKeyDown = lbe_searchKeyDown
        end
        object dtp_end: TDateTimePicker
          Left = 402
          Top = 32
          Width = 175
          Height = 23
          BiDiMode = bdLeftToRight
          Date = 42977.435999409720000000
          Time = 42977.435999409720000000
          ParentBiDiMode = False
          TabOrder = 2
        end
        object dtp_start: TDateTimePicker
          Left = 217
          Top = 32
          Width = 175
          Height = 23
          BiDiMode = bdLeftToRight
          Date = 42977.435999409720000000
          Time = 42977.435999409720000000
          ParentBiDiMode = False
          TabOrder = 1
        end
        object cbx_filtro: TComboBox
          Left = 32
          Top = 32
          Width = 175
          Height = 23
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 0
          Text = 'TODOS'
          Items.Strings = (
            'TODOS'
            'REFERENCIA'
            'VENCIMENTO'
            'RECEBIMENTO')
        end
        object edb_pessoa: TButtonedEdit
          Left = 402
          Top = 88
          Width = 300
          Height = 21
          Cursor = crHandPoint
          CharCase = ecUpperCase
          Ctl3D = False
          Images = dmRepository.iml_16
          LeftButton.DisabledImageIndex = 24
          LeftButton.HotImageIndex = 24
          LeftButton.ImageIndex = 24
          LeftButton.PressedImageIndex = 24
          LeftButton.Visible = True
          ParentCtl3D = False
          ReadOnly = True
          RightButton.DisabledImageIndex = 23
          RightButton.HotImageIndex = 23
          RightButton.ImageIndex = 23
          RightButton.PressedImageIndex = 23
          TabOrder = 7
          OnChange = edb_pessoaChange
          OnLeftButtonClick = edb_pessoaLeftButtonClick
          OnRightButtonClick = edb_pessoaRightButtonClick
        end
        object edb_categoria: TButtonedEdit
          Left = 217
          Top = 88
          Width = 175
          Height = 21
          Cursor = crHandPoint
          CharCase = ecUpperCase
          Ctl3D = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = []
          Images = dmRepository.iml_16
          LeftButton.DisabledImageIndex = 24
          LeftButton.HotImageIndex = 24
          LeftButton.ImageIndex = 24
          LeftButton.PressedImageIndex = 24
          LeftButton.Visible = True
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          RightButton.DisabledImageIndex = 23
          RightButton.HotImageIndex = 23
          RightButton.ImageIndex = 23
          RightButton.PressedImageIndex = 23
          TabOrder = 6
          OnChange = edb_pessoaChange
          OnLeftButtonClick = edb_categoriaLeftButtonClick
          OnRightButtonClick = edb_categoriaRightButtonClick
        end
        object cbx_situacao: TComboBox
          Left = 587
          Top = 32
          Width = 175
          Height = 23
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 3
          Text = 'TODOS'
          Items.Strings = (
            'TODOS'
            'A RECEBER'
            'RECEBIDOS')
        end
        object edb_conta: TButtonedEdit
          Left = 32
          Top = 88
          Width = 175
          Height = 21
          Cursor = crHandPoint
          CharCase = ecUpperCase
          Ctl3D = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = []
          Images = dmRepository.iml_16
          LeftButton.DisabledImageIndex = 24
          LeftButton.HotImageIndex = 24
          LeftButton.ImageIndex = 24
          LeftButton.PressedImageIndex = 24
          LeftButton.Visible = True
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          RightButton.DisabledImageIndex = 23
          RightButton.HotImageIndex = 23
          RightButton.ImageIndex = 23
          RightButton.PressedImageIndex = 23
          TabOrder = 5
          OnChange = edb_pessoaChange
          OnLeftButtonClick = edb_contaLeftButtonClick
          OnRightButtonClick = edb_contaRightButtonClick
        end
        object cbx_boleto: TComboBox
          Left = 772
          Top = 32
          Width = 175
          Height = 23
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 4
          Text = 'TODOS'
          Items.Strings = (
            'TODOS'
            'SEM BOLETO'
            'COM BOLETO')
        end
      end
      object dbg_recebimentos: TDBGrid
        Left = 0
        Top = 134
        Width = 976
        Height = 305
        Cursor = crHandPoint
        TabStop = False
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DataSource = ds_recebimentos
        DrawingStyle = gdsClassic
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Courier New'
        TitleFont.Style = [fsUnderline]
        OnDrawColumnCell = dbg_recebimentosDrawColumnCell
        OnDblClick = dbg_recebimentosDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'SELECIONADO'
            Title.Alignment = taCenter
            Title.Caption = '_'
            Width = 35
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATA'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CATEGORIA'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Width = 250
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PESSOA'
            Width = 270
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALOR'
            Title.Alignment = taRightJustify
            Width = 113
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SITUACAO'
            Title.Alignment = taCenter
            Title.Caption = '_'
            Width = 35
            Visible = True
          end>
      end
      object pnl_totais: TPanel
        Left = 0
        Top = 439
        Width = 976
        Height = 115
        Align = alBottom
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 2
        object bvl_4: TBevel
          Left = 0
          Top = 0
          Width = 976
          Height = 2
          Align = alTop
          ExplicitTop = 88
        end
        object Bevel1: TBevel
          Left = 487
          Top = 2
          Width = 2
          Height = 113
          Align = alLeft
          ExplicitLeft = 488
        end
        object pnl_totais_left: TPanel
          Left = 0
          Top = 2
          Width = 487
          Height = 113
          Align = alLeft
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object Panel1: TPanel
            Left = 307
            Top = 0
            Width = 180
            Height = 113
            Align = alRight
            BevelOuter = bvNone
            Padding.Right = 10
            ParentColor = True
            TabOrder = 0
            object lbl_total_recebidas: TLabel
              AlignWithMargins = True
              Left = 0
              Top = 5
              Width = 170
              Height = 18
              Margins.Left = 0
              Margins.Top = 5
              Margins.Right = 0
              Margins.Bottom = 5
              Align = alTop
              Alignment = taRightJustify
              Caption = '0,00'
              Font.Charset = ANSI_CHARSET
              Font.Color = clGreen
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitLeft = 143
              ExplicitWidth = 27
            end
            object lbl_total_receber: TLabel
              AlignWithMargins = True
              Left = 0
              Top = 33
              Width = 170
              Height = 18
              Margins.Left = 0
              Margins.Top = 5
              Margins.Right = 0
              Margins.Bottom = 5
              Align = alTop
              Alignment = taRightJustify
              Caption = '0,00'
              Font.Charset = ANSI_CHARSET
              Font.Color = clGreen
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitLeft = 143
              ExplicitWidth = 27
            end
            object lbl_total_vencidas: TLabel
              AlignWithMargins = True
              Left = 0
              Top = 61
              Width = 170
              Height = 18
              Margins.Left = 0
              Margins.Top = 5
              Margins.Right = 0
              Margins.Bottom = 5
              Align = alTop
              Alignment = taRightJustify
              Caption = '0,00'
              Font.Charset = ANSI_CHARSET
              Font.Color = clRed
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitLeft = 143
              ExplicitWidth = 27
            end
            object lbl_total_recebimentos: TLabel
              AlignWithMargins = True
              Left = 0
              Top = 89
              Width = 170
              Height = 18
              Margins.Left = 0
              Margins.Top = 5
              Margins.Right = 0
              Margins.Bottom = 5
              Align = alTop
              Alignment = taRightJustify
              Caption = '0,00'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitLeft = 143
              ExplicitWidth = 27
            end
          end
          object Panel2: TPanel
            Left = 0
            Top = 0
            Width = 307
            Height = 113
            Align = alClient
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 1
            object lbl_recebidas: TLabel
              AlignWithMargins = True
              Left = 0
              Top = 5
              Width = 307
              Height = 18
              Margins.Left = 0
              Margins.Top = 5
              Margins.Right = 0
              Margins.Bottom = 5
              Align = alTop
              Caption = 'Recebidas (R$)'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 94
            end
            object lbl_receber: TLabel
              AlignWithMargins = True
              Left = 0
              Top = 33
              Width = 307
              Height = 18
              Margins.Left = 0
              Margins.Top = 5
              Margins.Right = 0
              Margins.Bottom = 5
              Align = alTop
              Caption = 'A receber (R$)'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 92
            end
            object lbl_vencidas: TLabel
              AlignWithMargins = True
              Left = 0
              Top = 61
              Width = 307
              Height = 18
              Margins.Left = 0
              Margins.Top = 5
              Margins.Right = 0
              Margins.Bottom = 5
              Align = alTop
              Caption = 'Vencidas (R$)'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 85
            end
            object lbl_recebimentos: TLabel
              AlignWithMargins = True
              Left = 0
              Top = 89
              Width = 307
              Height = 18
              Margins.Left = 0
              Margins.Top = 5
              Margins.Right = 0
              Margins.Bottom = 5
              Align = alTop
              Caption = 'Total de Recebimentos (R$)'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 174
            end
          end
        end
        object pnl_totais_right: TPanel
          Left = 489
          Top = 2
          Width = 487
          Height = 113
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object Panel3: TPanel
            Left = 307
            Top = 0
            Width = 180
            Height = 113
            Align = alRight
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 0
            object lbl_numero_lancamentos: TLabel
              AlignWithMargins = True
              Left = 0
              Top = 5
              Width = 180
              Height = 18
              Margins.Left = 0
              Margins.Top = 5
              Margins.Right = 0
              Margins.Bottom = 5
              Align = alTop
              Alignment = taRightJustify
              Caption = '0'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitLeft = 172
              ExplicitWidth = 8
            end
            object lbl_numero_lancamentos_selecionados: TLabel
              AlignWithMargins = True
              Left = 0
              Top = 33
              Width = 180
              Height = 18
              Margins.Left = 0
              Margins.Top = 5
              Margins.Right = 0
              Margins.Bottom = 5
              Align = alTop
              Alignment = taRightJustify
              Caption = '0'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitLeft = 172
              ExplicitWidth = 8
            end
            object lbl_total_lancamentos_selecionados: TLabel
              AlignWithMargins = True
              Left = 0
              Top = 61
              Width = 180
              Height = 18
              Margins.Left = 0
              Margins.Top = 5
              Margins.Right = 0
              Margins.Bottom = 5
              Align = alTop
              Alignment = taRightJustify
              Caption = '0,00'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitLeft = 149
              ExplicitWidth = 31
            end
          end
          object Panel4: TPanel
            Left = 0
            Top = 0
            Width = 307
            Height = 113
            Align = alClient
            BevelOuter = bvNone
            Padding.Left = 10
            ParentColor = True
            TabOrder = 1
            object lbl_lancamentos: TLabel
              AlignWithMargins = True
              Left = 10
              Top = 5
              Width = 297
              Height = 18
              Margins.Left = 0
              Margins.Top = 5
              Margins.Right = 0
              Margins.Bottom = 5
              Align = alTop
              Caption = 'N'#250'mero de Lan'#231'amentos'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 161
            end
            object lbl_lancamentos_selecionados: TLabel
              AlignWithMargins = True
              Left = 10
              Top = 33
              Width = 297
              Height = 18
              Margins.Left = 0
              Margins.Top = 5
              Margins.Right = 0
              Margins.Bottom = 5
              Align = alTop
              Caption = 'N'#250'mero de Lan'#231'amentos Selecionados'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 249
            end
            object lbl_lancamentos_selecionados_total: TLabel
              AlignWithMargins = True
              Left = 10
              Top = 61
              Width = 297
              Height = 18
              Margins.Left = 0
              Margins.Top = 5
              Margins.Right = 0
              Margins.Bottom = 5
              Align = alTop
              Caption = 'Total de Lan'#231'amentos Selecionados (R$)'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 259
            end
          end
        end
      end
    end
  end
  object acl_recebimentos: TActionList
    Images = dmRepository.iml_32
    OnUpdate = acl_recebimentosUpdate
    Left = 432
    Top = 349
    object act_rollback: TAction
      Caption = 'ESC - RETORNAR'
      ImageIndex = 0
      ShortCut = 27
      OnExecute = act_rollbackExecute
    end
    object act_recebimento_store: TAction
      Caption = 'F2 - NOVO'
      ImageIndex = 1
      OnExecute = act_recebimento_storeExecute
    end
    object act_recebimento_update: TAction
      Caption = 'F3 -EDITAR'
      ImageIndex = 2
      OnExecute = act_recebimento_updateExecute
    end
    object act_recebimento_destroy: TAction
      Caption = 'F4 - REMOVER'
      ImageIndex = 3
      OnExecute = act_recebimento_destroyExecute
    end
    object act_recebimento_recebido: TAction
      Caption = 'DEFINIR COMO RECEBIDO'
      ImageIndex = 6
      ShortCut = 116
      OnExecute = act_recebimento_recebidoExecute
    end
    object act_recebimento_recibo: TAction
      Caption = 'EMITIR RECIBO'
      ImageIndex = 1
      ShortCut = 117
      OnExecute = act_recebimento_reciboExecute
    end
    object act_recebimento_boleto: TAction
      Caption = 'IMPRIMIR BOLETO  '
      ImageIndex = 8
      ShortCut = 118
      OnExecute = act_recebimento_boletoExecute
    end
    object act_recebimento_boleto_email: TAction
      Caption = 'ENVIAR BOLETO NO EMAIL'
      ImageIndex = 1
      ShortCut = 119
      OnExecute = act_recebimento_boleto_emailExecute
    end
    object act_recebimento_boleto_remover: TAction
      Caption = 'REMOVER BOLETO'
      ImageIndex = 9
      ShortCut = 120
      OnExecute = act_recebimento_boleto_removerExecute
    end
    object act_imprimir: TAction
      Caption = 'IMPRIMIR'
      ShortCut = 121
      OnExecute = act_imprimirExecute
    end
  end
  object fdmt_recebimentos: TFDMemTable
    IndexFieldNames = 'DATA'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 331
    Top = 349
    object fdmt_recebimentosID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_recebimentosDATA: TDateField
      FieldName = 'DATA'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object fdmt_recebimentosCATEGORIA: TStringField
      FieldName = 'CATEGORIA'
      Size = 255
    end
    object fdmt_recebimentosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 255
    end
    object fdmt_recebimentosPESSOA: TStringField
      FieldName = 'PESSOA'
      Size = 255
    end
    object fdmt_recebimentosVALOR: TFloatField
      FieldName = 'VALOR'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_recebimentosSITUACAO: TStringField
      FieldName = 'SITUACAO'
      Size = 1
    end
    object fdmt_recebimentosBOLETO: TStringField
      FieldName = 'BOLETO'
      Size = 255
    end
    object fdmt_recebimentosSELECIONADO: TStringField
      FieldName = 'SELECIONADO'
      Size = 1
    end
    object fdmt_recebimentosEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 1
    end
  end
  object ds_recebimentos: TDataSource
    DataSet = fdmt_recebimentos
    Left = 331
    Top = 405
  end
  object tmr_focus: TTimer
    Enabled = False
    OnTimer = tmr_focusTimer
    Left = 328
    Top = 473
  end
  object ppm_recebimento: TPopupMenu
    AutoPopup = False
    Images = dmRepository.iml_32
    Left = 435
    Top = 406
    object DEFINIRCOMORECEBIDO: TMenuItem
      Action = act_recebimento_recebido
    end
    object EMITIRRECIBO: TMenuItem
      Action = act_recebimento_recibo
    end
    object IMPRIMIRBOLETO: TMenuItem
      Action = act_recebimento_boleto
    end
    object ENVIARBOLETONOEMAIL: TMenuItem
      Action = act_recebimento_boleto_email
    end
    object REMOVERBOLETO: TMenuItem
      Action = act_recebimento_boleto_remover
    end
  end
end
