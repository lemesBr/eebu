inherited formItemMovimentoList: TformItemMovimentoList
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formItemMovimentoList'
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
      Caption = 'MOVIMENTO DO ITEM'
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
        ExplicitLeft = 565
        ExplicitTop = 18
      end
      object btn_movimento_imprimir: TButton
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
        Action = act_movimento_imprimir
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
      Padding.Top = 15
      ParentColor = True
      TabOrder = 2
      object bvl_4: TBevel
        Left = 0
        Top = 95
        Width = 976
        Height = 2
        Align = alTop
        ExplicitTop = 88
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
        TabOrder = 0
        object lbe_item: TLabeledEdit
          Left = 128
          Top = 28
          Width = 400
          Height = 24
          CharCase = ecUpperCase
          Ctl3D = False
          EditLabel.Width = 70
          EditLabel.Height = 18
          EditLabel.Caption = 'ITEM - ( F1 )'
          EditLabel.Font.Charset = ANSI_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -16
          EditLabel.Font.Name = 'Bombardier'
          EditLabel.Font.Style = []
          EditLabel.ParentFont = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnKeyDown = lbe_itemKeyDown
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
      object dbg_movimento: TDBGrid
        Left = 0
        Top = 97
        Width = 976
        Height = 357
        Cursor = crHandPoint
        TabStop = False
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DataSource = ds_movimento
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
        OnDrawColumnCell = dbg_movimentoDrawColumnCell
        Columns = <
          item
            Expanded = False
            FieldName = 'MOVIMENTO'
            Width = 150
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
            FieldName = 'USUARIO'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ANTERIOR'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MOVIMENTADO'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ATUAL'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TIPO'
            Title.Caption = '_'
            Width = 30
            Visible = True
          end>
      end
      object pnl_totais: TPanel
        Left = 0
        Top = 454
        Width = 976
        Height = 100
        Align = alBottom
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Bombardier'
        Font.Style = []
        ParentColor = True
        ParentFont = False
        TabOrder = 2
        object bvl_3: TBevel
          Left = 0
          Top = 0
          Width = 976
          Height = 2
          Align = alTop
          ExplicitTop = 88
        end
        object dbt_descricao: TDBText
          Left = 0
          Top = 41
          Width = 976
          Height = 17
          Align = alCustom
          Alignment = taCenter
          DataField = 'DESCRICAO'
          DataSource = ds_movimento
        end
      end
    end
  end
  object fdmt_movimento: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 331
    Top = 297
    object fdmt_movimentoMOVIMENTO: TDateTimeField
      FieldName = 'MOVIMENTO'
    end
    object fdmt_movimentoPESSOA: TStringField
      FieldName = 'PESSOA'
      Size = 255
    end
    object fdmt_movimentoUSUARIO: TStringField
      FieldName = 'USUARIO'
      Size = 255
    end
    object fdmt_movimentoANTERIOR: TFloatField
      FieldName = 'ANTERIOR'
      DisplayFormat = '###,###0.000'
    end
    object fdmt_movimentoMOVIMENTADO: TFloatField
      FieldName = 'MOVIMENTADO'
      DisplayFormat = '###,###0.000'
    end
    object fdmt_movimentoATUAL: TFloatField
      FieldName = 'ATUAL'
      DisplayFormat = '###,###0.000'
    end
    object fdmt_movimentoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 255
    end
    object fdmt_movimentoTIPO: TIntegerField
      FieldName = 'TIPO'
    end
  end
  object ds_movimento: TDataSource
    DataSet = fdmt_movimento
    Left = 331
    Top = 353
  end
  object tmr_focus: TTimer
    Enabled = False
    OnTimer = tmr_focusTimer
    Left = 328
    Top = 421
  end
  object acl_movimento: TActionList
    Images = dmRepository.iml_32
    OnUpdate = acl_movimentoUpdate
    Left = 424
    Top = 355
    object act_rollback: TAction
      Caption = 'ESC - RETORNAR'
      ImageIndex = 0
      ShortCut = 27
      OnExecute = act_rollbackExecute
    end
    object act_movimento_imprimir: TAction
      Caption = 'F2 - IMPRIMIR'
      ImageIndex = 8
      ShortCut = 115
      OnExecute = act_movimento_imprimirExecute
    end
  end
end
