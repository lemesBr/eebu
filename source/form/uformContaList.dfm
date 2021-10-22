inherited formContaList: TformContaList
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formContaList'
  ClientHeight = 740
  ClientWidth = 1024
  Color = 3618615
  KeyPreview = True
  Position = poDefaultSizeOnly
  WindowState = wsMaximized
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
    object pnl_header: TPanel
      Left = 21
      Top = 1
      Width = 976
      Height = 80
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'CONTAS'
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
    object pnl_body: TPanel
      Left = 21
      Top = 83
      Width = 976
      Height = 556
      Align = alClient
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object bvl_2: TBevel
        Left = 0
        Top = 554
        Width = 976
        Height = 2
        Align = alBottom
        ExplicitTop = 88
      end
      object pnl_contas: TPanel
        Left = 0
        Top = 0
        Width = 318
        Height = 554
        Align = alLeft
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object dbg_contas: TDBGrid
          Left = 0
          Top = 0
          Width = 318
          Height = 479
          Cursor = crHandPoint
          TabStop = False
          Align = alClient
          BorderStyle = bsNone
          Color = clWhite
          Ctl3D = False
          DataSource = ds_contas
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
          OnDrawColumnCell = dbg_contasDrawColumnCell
          OnDblClick = dbg_contasDblClick
          Columns = <
            item
              Expanded = False
              FieldName = 'NOME'
              Width = 200
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SALDO'
              Title.Alignment = taRightJustify
              Width = 100
              Visible = True
            end>
        end
        object pnl_contas_totais: TPanel
          Left = 0
          Top = 479
          Width = 318
          Height = 75
          Align = alBottom
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object bvl_4: TBevel
            Left = 0
            Top = 0
            Width = 318
            Height = 2
            Align = alTop
            ExplicitTop = 88
            ExplicitWidth = 976
          end
          object pnl_totais_right: TPanel
            Left = 168
            Top = 2
            Width = 150
            Height = 73
            Align = alRight
            BevelOuter = bvNone
            Padding.Top = 15
            Padding.Right = 20
            ParentColor = True
            TabOrder = 0
            object lb_saldo_total: TLabel
              AlignWithMargins = True
              Left = 0
              Top = 20
              Width = 130
              Height = 26
              Margins.Left = 0
              Margins.Top = 5
              Margins.Right = 0
              Margins.Bottom = 5
              Align = alTop
              Alignment = taRightJustify
              Caption = '0,00'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -24
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitLeft = 89
              ExplicitWidth = 41
            end
          end
          object pnl_totais_left: TPanel
            Left = 0
            Top = 2
            Width = 168
            Height = 73
            Align = alClient
            BevelOuter = bvNone
            Padding.Top = 15
            ParentColor = True
            TabOrder = 1
            object lb_total: TLabel
              AlignWithMargins = True
              Left = 0
              Top = 20
              Width = 168
              Height = 26
              Margins.Left = 0
              Margins.Top = 5
              Margins.Right = 0
              Margins.Bottom = 5
              Align = alTop
              Caption = 'Total:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -24
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 53
            end
          end
        end
      end
      object pnl_extrato: TPanel
        Left = 318
        Top = 0
        Width = 658
        Height = 554
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object dbg_extrato: TDBGrid
          Left = 0
          Top = 80
          Width = 658
          Height = 474
          Cursor = crHandPoint
          Align = alClient
          BorderStyle = bsNone
          Color = clWhite
          Ctl3D = False
          DataSource = ds_extrato
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
          OnDrawColumnCell = dbg_extratoDrawColumnCell
          Columns = <
            item
              Expanded = False
              FieldName = 'DATA_VIEW'
              Title.Caption = 'DATA'
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CATEGORIA'
              Width = 120
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PESSOA'
              Width = 145
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'REFERENTE'
              Width = 170
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VALOR_VIEW'
              Title.Alignment = taRightJustify
              Title.Caption = 'VALOR'
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SALDO'
              Title.Alignment = taRightJustify
              Width = 70
              Visible = True
            end>
        end
        object pnl_search_extrato: TPanel
          Left = 0
          Top = 0
          Width = 658
          Height = 80
          Align = alTop
          BevelOuter = bvNone
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          TabOrder = 1
          object lb_start: TLabel
            Left = 150
            Top = 14
            Width = 39
            Height = 18
            Caption = 'INICIAL'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Bombardier'
            Font.Style = []
            ParentFont = False
          end
          object lb_end: TLabel
            Left = 310
            Top = 14
            Width = 33
            Height = 18
            Caption = 'FINAL'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Bombardier'
            Font.Style = []
            ParentFont = False
          end
          object bvl_5: TBevel
            Left = 0
            Top = 78
            Width = 658
            Height = 2
            Align = alBottom
            ExplicitTop = 88
            ExplicitWidth = 976
          end
          object dtp_end: TDateTimePicker
            Left = 310
            Top = 32
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
            TabStop = False
          end
          object dtp_start: TDateTimePicker
            Left = 150
            Top = 32
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
            TabOrder = 0
            TabStop = False
          end
          object btn_extrato: TButton
            Left = 468
            Top = 24
            Width = 40
            Height = 40
            Cursor = crHandPoint
            ImageAlignment = iaCenter
            ImageIndex = 20
            Images = dmRepository.iml_principal_32
            TabOrder = 2
            TabStop = False
            OnClick = btn_extratoClick
          end
        end
      end
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
      TabOrder = 2
      object btn_conta_export: TButton
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
        Action = act_conta_export
        Align = alRight
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Bombardier'
        Font.Style = [fsUnderline]
        Images = dmRepository.iml_32
        ParentFont = False
        TabOrder = 0
        WordWrap = True
      end
      object btn_rollback: TButton
        AlignWithMargins = True
        Left = 46
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
      object btn_conta_store: TButton
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
        Action = act_conta_store
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
      object btn_conta_update: TButton
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
        Action = act_conta_update
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
      object btn_conta_destroy: TButton
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
        Action = act_conta_destroy
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
      object btn_boleto: TButton
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
        Align = alRight
        Caption = 'CONTA'
        DropDownMenu = ppm_boleto
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Bombardier'
        Font.Style = [fsUnderline]
        Images = dmRepository.iml_32
        ParentFont = False
        Style = bsSplitButton
        TabOrder = 5
        WordWrap = True
      end
    end
  end
  object fdmt_contas: TFDMemTable
    AfterScroll = fdmt_contasAfterScroll
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 67
    Top = 273
    object fdmt_contasID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_contasNOME: TStringField
      FieldName = 'NOME'
      Size = 255
    end
    object fdmt_contasSALDO: TFloatField
      FieldName = 'SALDO'
      DisplayFormat = '###,##0.00'
    end
  end
  object ds_contas: TDataSource
    DataSet = fdmt_contas
    Left = 67
    Top = 322
  end
  object tmr_focus: TTimer
    Enabled = False
    Left = 731
    Top = 29
  end
  object acl_contas: TActionList
    Images = dmRepository.iml_32
    OnUpdate = acl_contasUpdate
    Left = 608
    Top = 29
    object act_rollback: TAction
      Caption = 'ESC - RETORNAR'
      ImageIndex = 0
      ShortCut = 27
      OnExecute = act_rollbackExecute
    end
    object act_conta_store: TAction
      Caption = 'F2 - NOVO'
      ImageIndex = 1
      ShortCut = 113
      OnExecute = act_conta_storeExecute
    end
    object act_conta_update: TAction
      Caption = 'F3 - EDITAR'
      ImageIndex = 2
      ShortCut = 114
      OnExecute = act_conta_updateExecute
    end
    object act_conta_destroy: TAction
      Caption = 'F4 - REMOVER'
      ImageIndex = 3
      ShortCut = 114
      OnExecute = act_conta_destroyExecute
    end
    object act_conta_export: TAction
      Caption = 'F12 - EXPORTAR'
      ImageIndex = 5
      ShortCut = 115
      OnExecute = act_conta_exportExecute
    end
    object act_cedente: TAction
      Caption = 'CEDENTE'
      ImageIndex = 2
      ShortCut = 116
      OnExecute = act_cedenteExecute
    end
    object act_boleto: TAction
      Caption = 'CONFIGURAR BOLETO'
      ImageIndex = 4
      ShortCut = 117
      OnExecute = act_boletoExecute
    end
    object act_imprimir_extrato: TAction
      Caption = 'IMPRIMIR EXTRATO'
      ImageIndex = 8
      ShortCut = 118
      OnExecute = act_imprimir_extratoExecute
    end
  end
  object ppm_boleto: TPopupMenu
    AutoPopup = False
    Images = dmRepository.iml_32
    Left = 672
    Top = 29
    object CEDENTE1: TMenuItem
      Action = act_cedente
    end
    object BOLETO: TMenuItem
      Action = act_boleto
    end
    object IMPRIMIREXTRATO1: TMenuItem
      Action = act_imprimir_extrato
    end
  end
  object fdmt_extrato: TFDMemTable
    IndexFieldNames = 'DATA'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 403
    Top = 273
    object StringField1: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_extratoDATA: TDateField
      FieldName = 'DATA'
      DisplayFormat = 'dd/mm/yy'
    end
    object fdmt_extratoDATA_VIEW: TStringField
      FieldName = 'DATA_VIEW'
      Size = 60
    end
    object fdmt_extratoCATEGORIA: TStringField
      FieldName = 'CATEGORIA'
      Size = 60
    end
    object fdmt_extratoPESSOA: TStringField
      FieldName = 'PESSOA'
      Size = 255
    end
    object fdmt_extratoREFERENTE: TStringField
      FieldName = 'REFERENTE'
      Size = 255
    end
    object fdmt_extratoVALOR: TFloatField
      FieldName = 'VALOR'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_extratoVALOR_VIEW: TStringField
      Alignment = taRightJustify
      FieldName = 'VALOR_VIEW'
      Size = 60
    end
    object fdmt_extratoSALDO: TStringField
      Alignment = taRightJustify
      FieldName = 'SALDO'
      Size = 60
    end
    object fdmt_extratoTIPO: TStringField
      FieldName = 'TIPO'
      Size = 1
    end
  end
  object ds_extrato: TDataSource
    DataSet = fdmt_extrato
    Left = 403
    Top = 322
  end
end
