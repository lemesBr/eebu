inherited formRoleList: TformRoleList
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formRoleList'
  ClientHeight = 740
  ClientWidth = 1024
  Color = 3618615
  Position = poDefaultSizeOnly
  WindowState = wsMaximized
  StyleElements = []
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
      Caption = 'PAP'#201'IS'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Bombardier'
      Font.Style = []
      Padding.Top = 10
      Padding.Bottom = 10
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
    end
    object ts_roles: TTabSet
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
        'LISTA'
        'PERMISS'#213'ES DE PAP'#201'IS')
      TabIndex = 0
      OnChange = ts_rolesChange
    end
    object ntb_roles: TNotebook
      Left = 21
      Top = 100
      Width = 976
      Height = 619
      Align = alClient
      PageIndex = 1
      TabOrder = 2
      object TPage
        Left = 0
        Top = 0
        Caption = 'ROLES'
        object pnl_roles_body: TPanel
          Left = 0
          Top = 0
          Width = 976
          Height = 619
          Align = alClient
          BevelOuter = bvNone
          Color = clWhite
          Padding.Top = 15
          ParentBackground = False
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
          object pnl_roles_footer: TPanel
            Left = 0
            Top = 539
            Width = 976
            Height = 80
            Align = alBottom
            BevelOuter = bvNone
            Color = clWhite
            Padding.Top = 10
            Padding.Bottom = 10
            ParentBackground = False
            TabOrder = 0
            object btn_role_export: TButton
              AlignWithMargins = True
              Left = 826
              Top = 10
              Width = 150
              Height = 60
              Cursor = crHandPoint
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              Action = act_role_export
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
            object btn_role_store: TButton
              AlignWithMargins = True
              Left = 361
              Top = 10
              Width = 150
              Height = 60
              Cursor = crHandPoint
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 5
              Margins.Bottom = 0
              Action = act_role_store
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
            object btn_role_update: TButton
              AlignWithMargins = True
              Left = 516
              Top = 10
              Width = 150
              Height = 60
              Cursor = crHandPoint
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 5
              Margins.Bottom = 0
              Action = act_role_update
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
            object btn_rollback: TButton
              AlignWithMargins = True
              Left = 206
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
              TabOrder = 3
              TabStop = False
              WordWrap = True
            end
            object Button1: TButton
              AlignWithMargins = True
              Left = 671
              Top = 10
              Width = 150
              Height = 60
              Cursor = crHandPoint
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 5
              Margins.Bottom = 0
              Action = act_role_destroy
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
          object dbg_roles: TDBGrid
            Left = 0
            Top = 97
            Width = 976
            Height = 440
            TabStop = False
            Align = alClient
            BorderStyle = bsNone
            Color = clWhite
            Ctl3D = False
            DataSource = ds_roles
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
            OnDrawColumnCell = dbg_rolesDrawColumnCell
            OnDblClick = dbg_rolesDblClick
            Columns = <
              item
                Expanded = False
                FieldName = 'NOME'
                Width = 350
                Visible = True
              end>
          end
          object pnl_roles_search: TPanel
            Left = 0
            Top = 15
            Width = 976
            Height = 80
            Align = alTop
            BevelOuter = bvNone
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Bombardier'
            Font.Style = []
            ParentBackground = False
            ParentFont = False
            TabOrder = 2
            object lbe_roles_search: TLabeledEdit
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
              OnKeyDown = lbe_roles_searchKeyDown
            end
          end
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'PERMISSIONS'
        object pnl_permissions_body: TPanel
          Left = 0
          Top = 0
          Width = 976
          Height = 619
          Align = alClient
          BevelOuter = bvNone
          Caption = 'pnl_permissions_body'
          Color = clWhite
          Padding.Top = 15
          ParentBackground = False
          TabOrder = 0
          object bvl_4: TBevel
            Left = 0
            Top = 95
            Width = 976
            Height = 2
            Align = alTop
            ExplicitTop = 103
          end
          object Bevel1: TBevel
            Left = 0
            Top = 537
            Width = 976
            Height = 2
            Align = alBottom
            ExplicitTop = 545
          end
          object dbg_permissions: TDBGrid
            Left = 0
            Top = 97
            Width = 976
            Height = 440
            TabStop = False
            Align = alClient
            BorderStyle = bsNone
            Color = clWhite
            Ctl3D = False
            DataSource = ds_permissions
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
            OnDrawColumnCell = dbg_rolesDrawColumnCell
            Columns = <
              item
                Expanded = False
                FieldName = 'NOME'
                Width = 350
                Visible = True
              end>
          end
          object pnl_permissions_footer: TPanel
            Left = 0
            Top = 539
            Width = 976
            Height = 80
            Align = alBottom
            BevelOuter = bvNone
            Color = clWhite
            Padding.Top = 10
            Padding.Bottom = 10
            ParentBackground = False
            TabOrder = 1
            object btn_permission_remove: TButton
              AlignWithMargins = True
              Left = 826
              Top = 10
              Width = 150
              Height = 60
              Cursor = crHandPoint
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              Action = act_permission_remove
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
            object btn_permission_include: TButton
              AlignWithMargins = True
              Left = 671
              Top = 10
              Width = 150
              Height = 60
              Cursor = crHandPoint
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 5
              Margins.Bottom = 0
              Action = act_permission_include
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
          object pnl_permissions_search: TPanel
            Left = 0
            Top = 15
            Width = 976
            Height = 80
            Align = alTop
            BevelOuter = bvNone
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Bombardier'
            Font.Style = []
            ParentBackground = False
            ParentFont = False
            TabOrder = 2
            object lbe_permissions_search: TLabeledEdit
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
              OnKeyDown = lbe_permissions_searchKeyDown
            end
          end
        end
      end
    end
  end
  object acl_roles: TActionList
    Images = dmRepository.iml_32
    OnUpdate = acl_rolesUpdate
    Left = 424
    Top = 355
    object act_rollback: TAction
      Caption = 'ESC - RETORNAR'
      ImageIndex = 0
      ShortCut = 27
      OnExecute = act_rollbackExecute
    end
    object act_role_store: TAction
      Caption = 'F2 - NOVO'
      ImageIndex = 1
      ShortCut = 113
      OnExecute = act_role_storeExecute
    end
    object act_role_update: TAction
      Caption = 'F3 - EDITAR'
      ImageIndex = 2
      ShortCut = 114
      OnExecute = act_role_updateExecute
    end
    object act_role_export: TAction
      Caption = 'F12 - EXPORTAR'
      ImageIndex = 5
      ShortCut = 123
      OnExecute = act_role_exportExecute
    end
    object act_permission_include: TAction
      Caption = 'F4 - ADICIONAR'
      ImageIndex = 1
      ShortCut = 115
      OnExecute = act_permission_includeExecute
    end
    object act_permission_remove: TAction
      Caption = 'F5 - REMOVER'
      ImageIndex = 3
      ShortCut = 116
      OnExecute = act_permission_removeExecute
    end
    object act_role_destroy: TAction
      Caption = 'F4 - REMOVER'
      ImageIndex = 3
      ShortCut = 115
      OnExecute = act_role_destroyExecute
    end
  end
  object fdmt_roles: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 331
    Top = 297
    object fdmt_rolesID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_rolesNOME: TStringField
      FieldName = 'NOME'
      Size = 255
    end
  end
  object tmr_focus: TTimer
    Enabled = False
    OnTimer = tmr_focusTimer
    Left = 328
    Top = 421
  end
  object ds_roles: TDataSource
    DataSet = fdmt_roles
    Left = 331
    Top = 353
  end
  object ds_permissions: TDataSource
    DataSet = fdmt_permissions
    Left = 611
    Top = 369
  end
  object fdmt_permissions: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 611
    Top = 313
    object StringField1: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object StringField2: TStringField
      FieldName = 'NOME'
      Size = 255
    end
  end
end
