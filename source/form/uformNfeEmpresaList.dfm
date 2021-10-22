inherited formNfeEmpresaList: TformNfeEmpresaList
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formNfeEmpresaList'
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
      Caption = 'NOTAS FISCAIS'
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
        TabOrder = 0
        TabStop = False
        WordWrap = True
      end
      object btn_enviar_email: TButton
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
        Action = act_enviar_email
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
      object btn_exportar: TButton
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
        Action = act_exportar
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
      object btn_consultar: TButton
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
        Action = act_consultar
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
        ExplicitTop = 23
      end
      object dbg_nfes: TDBGrid
        Left = 0
        Top = 97
        Width = 976
        Height = 382
        Cursor = crHandPoint
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
            FieldName = 'TPNF'
            Title.Alignment = taCenter
            Title.Caption = '_'
            Width = 30
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MODELO'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SERIE'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NNF'
            Title.Caption = 'NUMERO'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DEMI'
            Title.Caption = 'EMISSAO'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DSAIENT'
            Title.Caption = 'ENTRADA'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CHNFE'
            Title.Caption = 'CHAVE'
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
            FieldName = 'CSTAT'
            Title.Alignment = taCenter
            Title.Caption = '_'
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
        object lb_start: TLabel
          Left = 333
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
          Left = 493
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
        object dtp_start: TDateTimePicker
          Left = 333
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
        object dtp_end: TDateTimePicker
          Left = 493
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
      end
      object pnl_totais: TPanel
        Left = 0
        Top = 479
        Width = 976
        Height = 75
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
          Height = 73
          Align = alLeft
          ExplicitLeft = 488
          ExplicitHeight = 113
        end
        object pnl_totais_left: TPanel
          Left = 0
          Top = 2
          Width = 487
          Height = 73
          Align = alLeft
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object Panel1: TPanel
            Left = 307
            Top = 0
            Width = 180
            Height = 73
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
              Font.Color = clRed
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitLeft = 143
              ExplicitWidth = 27
            end
            object lbl_total_enviadas: TLabel
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
          end
          object Panel2: TPanel
            Left = 0
            Top = 0
            Width = 307
            Height = 73
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
            object lbl_enviadas: TLabel
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
              Caption = 'Enviadas (R$)'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 86
            end
          end
        end
        object pnl_totais_right: TPanel
          Left = 489
          Top = 2
          Width = 487
          Height = 73
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object Panel3: TPanel
            Left = 307
            Top = 0
            Width = 180
            Height = 73
            Align = alRight
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 0
            object lbl_numero_canceladas: TLabel
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
            object lbl_numero_inutilizadas: TLabel
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
          end
          object Panel4: TPanel
            Left = 0
            Top = 0
            Width = 307
            Height = 73
            Align = alClient
            BevelOuter = bvNone
            Padding.Left = 10
            ParentColor = True
            TabOrder = 1
            object lbl_canceladas: TLabel
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
              Caption = 'Canceladas'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 72
            end
            object lbl_inutilizadas: TLabel
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
              Caption = 'Inutilizadas'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Bombardier'
              Font.Style = []
              ParentFont = False
              ExplicitWidth = 71
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
    object fdmt_nfesTPNF: TIntegerField
      FieldName = 'TPNF'
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
    object fdmt_nfesDSAIENT: TDateField
      FieldName = 'DSAIENT'
    end
    object fdmt_nfesCHNFE: TStringField
      FieldName = 'CHNFE'
      Size = 44
    end
    object fdmt_nfesVNF: TCurrencyField
      FieldName = 'VNF'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_nfesCSTAT: TIntegerField
      FieldName = 'CSTAT'
    end
  end
  object ds_nfes: TDataSource
    DataSet = fdmt_nfes
    Left = 328
    Top = 349
  end
  object acl_empresa: TActionList
    Images = dmRepository.iml_32
    OnUpdate = acl_empresaUpdate
    Left = 400
    Top = 299
    object act_rollback: TAction
      Caption = 'ESC - RETORNAR'
      ImageIndex = 0
      ShortCut = 27
      OnExecute = act_rollbackExecute
    end
    object act_consultar: TAction
      Caption = 'F2 - CONSULTAR'
      ImageIndex = 7
      ShortCut = 113
      OnExecute = act_consultarExecute
    end
    object act_exportar: TAction
      Caption = 'F3 - EXPORTAR'
      ImageIndex = 5
      ShortCut = 114
      OnExecute = act_exportarExecute
    end
    object act_enviar_email: TAction
      Caption = 'F4 - ENVIAR EMAIL'
      ImageIndex = 6
      ShortCut = 115
      OnExecute = act_enviar_emailExecute
    end
  end
end
