inherited formItemInventarioCreate: TformItemInventarioCreate
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formItemInventarioCreate'
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
      Caption = 'INVENT'#193'RIO'
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
        Left = 511
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
        ExplicitTop = 3
      end
      object btn_remover_item: TButton
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
        Action = act_remover_item
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
        ExplicitLeft = 511
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
      ExplicitTop = 61
      ExplicitHeight = 576
      object bvl_3: TBevel
        Left = 0
        Top = 173
        Width = 976
        Height = 2
        Align = alTop
        ExplicitTop = 185
      end
      object Bevel2: TBevel
        Left = 0
        Top = 91
        Width = 976
        Height = 2
        Align = alTop
        ExplicitTop = 87
      end
      object pnl_categorias_search: TPanel
        Left = 0
        Top = 15
        Width = 976
        Height = 76
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        object lbe_user: TLabeledEdit
          Tag = 1
          Left = 258
          Top = 27
          Width = 300
          Height = 23
          TabStop = False
          EditLabel.Width = 41
          EditLabel.Height = 15
          EditLabel.Caption = 'Usu'#225'rio'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
        object lbe_competencia: TLabeledEdit
          Left = 568
          Top = 27
          Width = 150
          Height = 23
          TabStop = False
          EditLabel.Width = 72
          EditLabel.Height = 15
          EditLabel.Caption = 'Compet'#234'ncia'
          ReadOnly = True
          TabOrder = 1
        end
      end
      object dbg_itens: TDBGrid
        Left = 0
        Top = 175
        Width = 976
        Height = 379
        TabStop = False
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = False
        DataSource = ds_itens
        DrawingStyle = gdsClassic
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 2
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Courier New'
        TitleFont.Style = [fsUnderline]
        OnDrawColumnCell = dbg_itensDrawColumnCell
        Columns = <
          item
            Expanded = False
            FieldName = 'ITEM_REFERENCIA'
            Title.Caption = 'REFERENCIA'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ITEM_NOME'
            Title.Caption = 'ITEM'
            Width = 352
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UNIDADE'
            Title.Alignment = taCenter
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRECO_COMPRA'
            Title.Alignment = taRightJustify
            Title.Caption = 'CUSTO'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ESTOQUE_ATUAL'
            Title.Alignment = taRightJustify
            Title.Caption = 'ESTOQUE'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ESTOQUE_INFORMADO'
            Title.Alignment = taRightJustify
            Title.Caption = 'INFORMADO'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DIFERENCA'
            Title.Alignment = taRightJustify
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
      object Panel2: TPanel
        Left = 0
        Top = 93
        Width = 976
        Height = 80
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 1
        object lbe_item: TLabeledEdit
          Left = 32
          Top = 32
          Width = 100
          Height = 23
          EditLabel.Width = 63
          EditLabel.Height = 15
          EditLabel.Caption = 'Item - ( F1 )'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 0
          OnKeyDown = lbe_itemKeyDown
        end
        object edt_item_nome: TEdit
          Left = 132
          Top = 32
          Width = 250
          Height = 23
          TabStop = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object lbe_item_preco: TLabeledEdit
          Left = 502
          Top = 32
          Width = 100
          Height = 23
          EditLabel.Width = 31
          EditLabel.Height = 15
          EditLabel.Caption = 'Custo'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          OnKeyDown = lbe_item_precoKeyDown
        end
        object lbe_estoque_informado: TLabeledEdit
          Left = 722
          Top = 32
          Width = 100
          Height = 23
          EditLabel.Width = 76
          EditLabel.Height = 15
          EditLabel.Caption = 'Novo Estoque'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          OnKeyDown = lbe_estoque_informadoKeyDown
        end
        object lbe_diferenca: TLabeledEdit
          Left = 832
          Top = 32
          Width = 112
          Height = 23
          TabStop = False
          EditLabel.Width = 52
          EditLabel.Height = 15
          EditLabel.Caption = 'Diferen'#231'a'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
        end
        object lbe_item_unidade: TLabeledEdit
          Left = 392
          Top = 32
          Width = 100
          Height = 23
          EditLabel.Width = 82
          EditLabel.Height = 15
          EditLabel.Caption = 'Unidade - ( F1 )'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          OnKeyDown = lbe_item_unidadeKeyDown
        end
        object lbe_estoque_atual: TLabeledEdit
          Left = 612
          Top = 32
          Width = 100
          Height = 23
          TabStop = False
          EditLabel.Width = 64
          EditLabel.Height = 15
          EditLabel.Caption = 'Qt. Estoque'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
        end
      end
    end
  end
  object acl_inventario: TActionList
    Images = dmRepository.iml_32
    OnUpdate = acl_inventarioUpdate
    Left = 432
    Top = 395
    object act_cancelar: TAction
      Caption = 'CANCELAR'
      ImageIndex = 0
      OnExecute = act_cancelarExecute
    end
    object act_remover_item: TAction
      Caption = 'REMOVER ITEM'
      ImageIndex = 3
      OnExecute = act_remover_itemExecute
    end
    object act_confirmar: TAction
      Caption = 'CONFIRMAR'
      ImageIndex = 6
      OnExecute = act_confirmarExecute
    end
  end
  object fdmt_itens: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 339
    Top = 337
    object fdmt_itensITEM_ID: TStringField
      FieldName = 'ITEM_ID'
      Size = 32
    end
    object fdmt_itensITEM_REFERENCIA: TIntegerField
      FieldName = 'ITEM_REFERENCIA'
    end
    object fdmt_itensITEM_NOME: TStringField
      FieldName = 'ITEM_NOME'
      Size = 120
    end
    object fdmt_itensUNIDADE_ID: TStringField
      FieldName = 'UNIDADE_ID'
      Size = 32
    end
    object fdmt_itensUNIDADE: TStringField
      Alignment = taCenter
      FieldName = 'UNIDADE'
      Size = 6
    end
    object fdmt_itensPRECO_COMPRA: TFloatField
      FieldName = 'PRECO_COMPRA'
      DisplayFormat = '###,##0.00'
    end
    object fdmt_itensESTOQUE_ATUAL: TFloatField
      FieldName = 'ESTOQUE_ATUAL'
      DisplayFormat = '###,###0.000'
    end
    object fdmt_itensESTOQUE_INFORMADO: TFloatField
      FieldName = 'ESTOQUE_INFORMADO'
      DisplayFormat = '###,###0.000'
    end
    object fdmt_itensDIFERENCA: TFloatField
      FieldName = 'DIFERENCA'
      DisplayFormat = '###,###0.000'
    end
    object fdmt_itensTIPO: TIntegerField
      FieldName = 'TIPO'
    end
  end
  object ds_itens: TDataSource
    DataSet = fdmt_itens
    Left = 339
    Top = 393
  end
end
