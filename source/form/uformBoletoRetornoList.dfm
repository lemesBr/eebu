inherited formBoletoRetornoList: TformBoletoRetornoList
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formBoletoRetornoList'
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
    object pnl_boletos_header: TPanel
      Left = 21
      Top = 1
      Width = 976
      Height = 80
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'RETORNO'
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
    object pnl_boletos_footer: TPanel
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
        Left = 506
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
      object btn_read_retorno: TButton
        AlignWithMargins = True
        Left = 661
        Top = 10
        Width = 150
        Height = 60
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 0
        Action = act_importar_retorno
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
      object btn_confirm_retorno: TButton
        AlignWithMargins = True
        Left = 816
        Top = 10
        Width = 150
        Height = 60
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 0
        Action = act_confirmar_retorno
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
    end
    object pnl_boletos_body: TPanel
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
        ExplicitTop = 88
      end
      object dbg_boletos: TDBGrid
        Left = 0
        Top = 97
        Width = 976
        Height = 457
        TabStop = False
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DataSource = ds_boletos
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
        OnDrawColumnCell = dbg_boletosDrawColumnCell
        Columns = <
          item
            Expanded = False
            FieldName = 'BOLETO'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PESSOA'
            Width = 300
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'REFERENTE'
            Width = 350
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALOR_RECEBIDO'
            Title.Alignment = taRightJustify
            Title.Caption = 'RECEBIDO'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATA_CREDITO'
            Title.Alignment = taRightJustify
            Title.Caption = 'REPASSE'
            Width = 105
            Visible = True
          end>
      end
      object pnl_boletos_conta: TPanel
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
        object lbe_boletos_conta: TLabeledEdit
          Left = 238
          Top = 28
          Width = 500
          Height = 24
          CharCase = ecUpperCase
          Ctl3D = False
          EditLabel.Width = 71
          EditLabel.Height = 18
          EditLabel.Caption = 'CONTA ( F1 )'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Bombardier'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnKeyDown = lbe_boletos_contaKeyDown
        end
      end
    end
  end
  object fdmt_boletos: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 331
    Top = 297
    object fdmt_boletosID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_boletosBOLETO: TStringField
      FieldName = 'BOLETO'
      Size = 255
    end
    object fdmt_boletosPESSOA: TStringField
      FieldName = 'PESSOA'
      Size = 255
    end
    object fdmt_boletosREFERENTE: TStringField
      FieldName = 'REFERENTE'
      Size = 255
    end
    object fdmt_boletosVALOR_RECEBIDO: TFloatField
      FieldName = 'VALOR_RECEBIDO'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_boletosDATA_CREDITO: TDateField
      Alignment = taRightJustify
      FieldName = 'DATA_CREDITO'
      DisplayFormat = 'dd/mm/yyyy'
    end
  end
  object ds_boletos: TDataSource
    DataSet = fdmt_boletos
    Left = 331
    Top = 353
  end
  object acl_boletos: TActionList
    Images = dmRepository.iml_32
    OnUpdate = acl_boletosUpdate
    Left = 424
    Top = 347
    object act_rollback: TAction
      Caption = 'ESC - RETORNAR'
      ImageIndex = 0
      ShortCut = 27
      OnExecute = act_rollbackExecute
    end
    object act_importar_retorno: TAction
      Caption = 'F5 - IMPORTAR'
      ImageIndex = 5
      ShortCut = 116
      OnExecute = act_importar_retornoExecute
    end
    object act_confirmar_retorno: TAction
      Caption = 'F10 - CONCILIAR'
      ImageIndex = 6
      ShortCut = 121
      OnExecute = act_confirmar_retornoExecute
    end
  end
  object opd_retorno: TOpenDialog
    Left = 552
    Top = 349
  end
  object tmr_focus: TTimer
    Enabled = False
    OnTimer = tmr_focusTimer
    Left = 328
    Top = 421
  end
end
