inherited formManutencaoNFCe: TformManutencaoNFCe
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formManutencaoNFCe'
  ClientHeight = 740
  ClientWidth = 1024
  Color = 3618615
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
      Caption = 'GERENCIAR NFC-e'
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
      object btn_rollback: TButton
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
        Action = act_rollback
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
      object btn_nfce: TButton
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
        Caption = 'NFC-e'
        DropDownMenu = ppm_nfce
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Bombardier'
        Font.Style = [fsUnderline]
        ParentFont = False
        Style = bsSplitButton
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
      Padding.Top = 15
      ParentColor = True
      TabOrder = 2
      object bvl_3: TBevel
        Left = 0
        Top = 95
        Width = 976
        Height = 2
        Align = alTop
        ExplicitTop = 89
      end
      object dbg_nfce: TDBGrid
        Left = 0
        Top = 97
        Width = 976
        Height = 342
        Cursor = crHandPoint
        TabStop = False
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DataSource = ds_nfce
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
        OnDrawColumnCell = dbg_nfceDrawColumnCell
        OnDblClick = dbg_nfceDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'CHECK'
            Title.Alignment = taCenter
            Title.Caption = ' '
            Width = 30
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
            FieldName = 'CHNFE'
            Title.Caption = 'CHAVE'
            Width = 345
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PESSOA'
            Width = 350
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TOTAL'
            Title.Alignment = taRightJustify
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CSTAT'
            Title.Alignment = taCenter
            Title.Caption = ' '
            Width = 30
            Visible = True
          end>
      end
      object pnl_search: TPanel
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
        TabOrder = 1
        object lbe_search: TLabeledEdit
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
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          OnKeyDown = lbe_searchKeyDown
        end
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
        object bvl_5: TBevel
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
          object pnl_totais_left_valores: TPanel
            Left = 307
            Top = 0
            Width = 180
            Height = 113
            Align = alRight
            BevelOuter = bvNone
            Padding.Right = 10
            ParentColor = True
            TabOrder = 0
            object lb_nfce_geradas_valor: TLabel
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
            object lb_nfce_enviar_valor: TLabel
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
              Font.Color = clBlack
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitLeft = 143
              ExplicitWidth = 27
            end
            object lb_nfce_canceladas_valor: TLabel
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
            object lb_nfce_enviadas_valor: TLabel
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
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitLeft = 139
              ExplicitWidth = 31
            end
          end
          object pnl_totais_left_legendas: TPanel
            Left = 0
            Top = 0
            Width = 307
            Height = 113
            Align = alClient
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 1
            object lb_nfce_geradas_legenda: TLabel
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
              Caption = 'NFC-e geradas (R$) '
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 126
            end
            object lb_nfce_enviar_legenda: TLabel
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
              Caption = 'NFC-e enviar (R$)'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 109
            end
            object lb_nfce_canceladas_legenda: TLabel
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
              Caption = 'NFC-e canceladas (R$)'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 141
            end
            object lb_nfce_enviadas_legenda: TLabel
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
              Caption = 'NFC-e enviadas (R$)'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 126
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
          object pnl_totais_right_valores: TPanel
            Left = 307
            Top = 0
            Width = 180
            Height = 113
            Align = alRight
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 0
            object lb_numero_nfce_valor: TLabel
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
            object lb_numero_nfce_selecionadas_valor: TLabel
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
            object lb_total_nfce_selecionadas_valor: TLabel
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
          object pnl_totais_right_legendas: TPanel
            Left = 0
            Top = 0
            Width = 307
            Height = 113
            Align = alClient
            BevelOuter = bvNone
            Padding.Left = 10
            ParentColor = True
            TabOrder = 1
            object lb_numero_nfce_legenda: TLabel
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
              Caption = 'N'#250'mero de NFC-e'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 110
            end
            object lb_numero_nfce_selecionadas_legenda: TLabel
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
              Caption = 'N'#250'mero de NFC-e Selecionadas'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 198
            end
            object lb_total_nfce_selecionadas_legenda: TLabel
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
              Caption = 'Total de NFC-e Selecionadas (R$)'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 208
            end
          end
        end
      end
    end
  end
  object fdmt_nfce: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 331
    Top = 297
    object fdmt_nfceID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_nfceNNF: TIntegerField
      FieldName = 'NNF'
    end
    object fdmt_nfceCHNFE: TStringField
      FieldName = 'CHNFE'
      Size = 44
    end
    object fdmt_nfcePESSOA: TStringField
      FieldName = 'PESSOA'
      Size = 255
    end
    object fdmt_nfceTOTAL: TFloatField
      FieldName = 'TOTAL'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_nfceCSTAT: TIntegerField
      FieldName = 'CSTAT'
    end
    object fdmt_nfceCHECK: TIntegerField
      FieldName = 'CHECK'
    end
  end
  object ds_nfce: TDataSource
    DataSet = fdmt_nfce
    Left = 331
    Top = 353
  end
  object tmr_focus: TTimer
    Enabled = False
    OnTimer = tmr_focusTimer
    Left = 328
    Top = 421
  end
  object acl_nfce: TActionList
    Images = dmRepository.iml_32
    OnUpdate = acl_nfceUpdate
    Left = 424
    Top = 355
    object act_rollback: TAction
      Caption = 'ESC - RETORNAR'
      ImageIndex = 0
      ShortCut = 27
      OnExecute = act_rollbackExecute
    end
    object act_enviar: TAction
      Caption = 'ENVIAR'
      ImageIndex = 6
      ShortCut = 113
      OnExecute = act_enviarExecute
    end
    object act_imprimir: TAction
      Caption = 'IMPRIMIR'
      ImageIndex = 8
      ShortCut = 114
      OnExecute = act_imprimirExecute
    end
    object act_cancelar: TAction
      Caption = 'CANCELAR'
      ImageIndex = 3
      ShortCut = 115
      OnExecute = act_cancelarExecute
    end
    object act_enviar_pendentes: TAction
      Caption = 'ENVIAR TODAS'
      ImageIndex = 16
      ShortCut = 116
      OnExecute = act_enviar_pendentesExecute
    end
  end
  object ppm_nfce: TPopupMenu
    AutoPopup = False
    Images = dmRepository.iml_32
    Left = 426
    Top = 418
    object ENVIARNFCe1: TMenuItem
      Action = act_enviar
    end
    object IMPRIMIRNFCe1: TMenuItem
      Action = act_imprimir
    end
    object CANCELARNFCe1: TMenuItem
      Action = act_cancelar
    end
    object ENVIARPENDENTES1: TMenuItem
      Action = act_enviar_pendentes
    end
  end
end
