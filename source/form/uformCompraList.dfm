inherited formCompraList: TformCompraList
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formCompraList'
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
      Top = 717
      Width = 976
      Height = 2
      Align = alBottom
      ExplicitLeft = 0
      ExplicitTop = 88
    end
    object pnl_compras_head: TPanel
      Left = 21
      Top = 1
      Width = 976
      Height = 80
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'COMPRAS'
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
    object pnl_body: TPanel
      Left = 21
      Top = 83
      Width = 976
      Height = 554
      Align = alClient
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object bvl_3: TBevel
        Left = 0
        Top = 552
        Width = 976
        Height = 2
        Align = alBottom
        ExplicitTop = 88
      end
      object bvl_4: TBevel
        Left = 0
        Top = 77
        Width = 976
        Height = 2
        Align = alTop
        ExplicitTop = 103
      end
      object dbg_compras: TDBGrid
        Left = 0
        Top = 79
        Width = 976
        Height = 380
        Cursor = crHandPoint
        TabStop = False
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DataSource = ds_compras
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
        OnDrawColumnCell = dbg_comprasDrawColumnCell
        OnDblClick = dbg_comprasDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'CHECK'
            Title.Alignment = taCenter
            Title.Caption = '_'
            Width = 32
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'REFERENCIA'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COMPETENCIA'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PESSOA'
            Width = 543
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TOTAL'
            Title.Alignment = taRightJustify
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NFE_ID'
            Title.Alignment = taCenter
            Title.Caption = '_'
            Width = 30
            Visible = True
          end>
      end
      object pnl_totais: TPanel
        Left = 0
        Top = 459
        Width = 976
        Height = 93
        Align = alBottom
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object bvl_5: TBevel
          Left = 0
          Top = 0
          Width = 976
          Height = 2
          Align = alTop
          ExplicitTop = 88
        end
        object bvl_6: TBevel
          Left = 487
          Top = 2
          Width = 2
          Height = 91
          Align = alLeft
          ExplicitLeft = 488
          ExplicitHeight = 113
        end
        object pnl_totais_left: TPanel
          Left = 0
          Top = 2
          Width = 487
          Height = 91
          Align = alLeft
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object Panel1: TPanel
            Left = 307
            Top = 0
            Width = 180
            Height = 91
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
              Font.Color = clBlack
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
              Font.Color = clRed
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
              Font.Color = clGreen
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitLeft = 139
              ExplicitWidth = 31
            end
          end
          object Panel2: TPanel
            Left = 0
            Top = 0
            Width = 307
            Height = 91
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
              Caption = 'Total de Notas Emitidas (R$)'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 178
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
              Caption = 'Total de Notas a Emitir (R$)'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 173
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
              Caption = 'Total de Compras (R$)'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 140
            end
          end
        end
        object pnl_totais_right: TPanel
          Left = 489
          Top = 2
          Width = 487
          Height = 91
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object Panel3: TPanel
            Left = 307
            Top = 0
            Width = 180
            Height = 91
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
            Height = 91
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
              Caption = 'N'#250'mero de Compras'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 130
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
              Caption = 'N'#250'mero de Compras Selecionadas'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 218
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
              Caption = 'Total de Compras Selecionadas (R$)'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 228
            end
          end
        end
      end
      object pnl_search: TPanel
        Left = 0
        Top = 0
        Width = 976
        Height = 77
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
        TabOrder = 2
        object lb_start: TLabel
          Left = 32
          Top = 14
          Width = 92
          Height = 15
          Caption = 'PER'#205'ODO INICIAL'
        end
        object lb_end: TLabel
          Left = 172
          Top = 14
          Width = 83
          Height = 15
          Caption = 'PER'#205'ODO FINAL'
        end
        object lb_user: TLabel
          Left = 312
          Top = 14
          Width = 72
          Height = 15
          Caption = 'COMPRADOR'
        end
        object lb_pessoa: TLabel
          Left = 472
          Top = 14
          Width = 41
          Height = 15
          Caption = 'PESSOA'
        end
        object lbe_search: TLabeledEdit
          Left = 782
          Top = 32
          Width = 160
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
          TabOrder = 0
          OnKeyDown = lbe_searchKeyDown
        end
        object dtp_end: TDateTimePicker
          Left = 172
          Top = 32
          Width = 130
          Height = 23
          BiDiMode = bdLeftToRight
          Date = 42977.435999409720000000
          Time = 42977.435999409720000000
          ParentBiDiMode = False
          TabOrder = 2
        end
        object dtp_start: TDateTimePicker
          Left = 32
          Top = 32
          Width = 130
          Height = 23
          BiDiMode = bdLeftToRight
          Date = 42977.435999409720000000
          Time = 42977.435999409720000000
          ParentBiDiMode = False
          TabOrder = 1
        end
        object edb_pessoa: TButtonedEdit
          Left = 472
          Top = 32
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
          TabOrder = 4
          OnChange = edb_userChange
          OnLeftButtonClick = edb_pessoaLeftButtonClick
          OnRightButtonClick = edb_pessoaRightButtonClick
        end
        object edb_user: TButtonedEdit
          Left = 312
          Top = 32
          Width = 150
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
          TabOrder = 3
          OnChange = edb_userChange
          OnLeftButtonClick = edb_userLeftButtonClick
          OnRightButtonClick = edb_userRightButtonClick
        end
      end
    end
    object pnl_footer: TPanel
      Left = 21
      Top = 637
      Width = 976
      Height = 80
      Align = alBottom
      BevelOuter = bvNone
      Padding.Top = 10
      Padding.Bottom = 10
      ParentColor = True
      TabOrder = 2
      object btn_store: TButton
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
        Action = act_store
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
      object btn_destroy: TButton
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
        Action = act_destroy
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
      object btn_update: TButton
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
        Action = act_update
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
      object btn_compra: TButton
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
        Caption = 'COMPRA'
        DropDownMenu = ppm_compra
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Bombardier'
        Font.Style = [fsUnderline]
        ImageIndex = 12
        Images = dmRepository.iml_32
        ParentFont = False
        Style = bsSplitButton
        TabOrder = 4
        TabStop = False
        WordWrap = True
      end
    end
  end
  object acl_compras: TActionList
    Images = dmRepository.iml_32
    OnUpdate = acl_comprasUpdate
    Left = 400
    Top = 348
    object act_rollback: TAction
      Caption = 'ESC - RETORNAR'
      ImageIndex = 0
      ShortCut = 27
      OnExecute = act_rollbackExecute
    end
    object act_store: TAction
      Caption = 'F2 - NOVO'
      ImageIndex = 1
      ShortCut = 113
      OnExecute = act_storeExecute
    end
    object act_update: TAction
      Caption = 'F3 - EDITAR'
      ImageIndex = 2
      ShortCut = 114
      OnExecute = act_updateExecute
    end
    object act_destroy: TAction
      Caption = 'F4 - REMOVER'
      ImageIndex = 3
      ShortCut = 115
      OnExecute = act_destroyExecute
    end
    object act_reimprimir_comprovante: TAction
      Caption = 'REIMPRIMIR COMPROVANTE'
      ImageIndex = 8
      ShortCut = 116
      OnExecute = act_reimprimir_comprovanteExecute
    end
    object act_compra_nf: TAction
      Caption = 'GERAR NOTA FISCAL'
      ImageIndex = 6
      ShortCut = 117
      OnExecute = act_compra_nfExecute
    end
    object act_imprimir: TAction
      Caption = 'IMPRIMIR'
      ImageIndex = 8
      ShortCut = 121
      OnExecute = act_imprimirExecute
    end
  end
  object fdmt_compras: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 331
    Top = 297
    object fdmt_comprasID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_comprasREFERENCIA: TIntegerField
      FieldName = 'REFERENCIA'
    end
    object fdmt_comprasCOMPETENCIA: TDateField
      FieldName = 'COMPETENCIA'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object fdmt_comprasSUBTOTAL: TCurrencyField
      FieldName = 'SUBTOTAL'
      DisplayFormat = '###,##0.00'
      currency = False
    end
    object fdmt_comprasACRESCIMO: TCurrencyField
      FieldName = 'ACRESCIMO'
      DisplayFormat = '###,##0.00'
      currency = False
    end
    object fdmt_comprasDESCONTO: TCurrencyField
      FieldName = 'DESCONTO'
      DisplayFormat = '###,##0.00'
      currency = False
    end
    object fdmt_comprasTOTAL: TCurrencyField
      FieldName = 'TOTAL'
      DisplayFormat = '###,##0.00'
      currency = False
    end
    object fdmt_comprasPESSOA: TStringField
      FieldName = 'PESSOA'
      Size = 255
    end
    object fdmt_comprasUSER: TStringField
      FieldName = 'USER'
      Size = 255
    end
    object fdmt_comprasNFE_ID: TStringField
      FieldName = 'NFE_ID'
      Size = 32
    end
    object fdmt_comprasCHECK: TIntegerField
      FieldName = 'CHECK'
    end
  end
  object tmr_focus: TTimer
    Enabled = False
    OnTimer = tmr_focusTimer
    Left = 328
    Top = 404
  end
  object ds_compras: TDataSource
    DataSet = fdmt_compras
    Left = 331
    Top = 349
  end
  object ppm_compra: TPopupMenu
    AutoPopup = False
    Images = dmRepository.iml_32
    Left = 400
    Top = 405
    object REIMPRIMIRCOMPROVANTE: TMenuItem
      Action = act_reimprimir_comprovante
    end
    object GERARNOTAFISCAL: TMenuItem
      Action = act_compra_nf
    end
    object IMPRIMIR: TMenuItem
      Action = act_imprimir
    end
  end
end
