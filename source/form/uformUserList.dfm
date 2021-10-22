inherited formUserList: TformUserList
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formUserList'
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
      Caption = 'USU'#193'RIOS'
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
    object ts_users: TTabSet
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
        'PAP'#201'IS DE USU'#193'RIO')
      TabIndex = 0
      OnChange = ts_usersChange
    end
    object ntb_users: TNotebook
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
        object pnl_users_body: TPanel
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
            ExplicitTop = 23
          end
          object pnl_users_footer: TPanel
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
            object btn_user_export: TButton
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
              Action = act_user_export
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
            object btn_user_store: TButton
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
              Action = act_user_store
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
            object btn_user_update: TButton
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
              Action = act_user_update
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
            object btn_pessoa_destroy: TButton
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
              Action = act_user_destroy
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
          object dbg_users: TDBGrid
            Left = 0
            Top = 97
            Width = 976
            Height = 440
            TabStop = False
            Align = alClient
            BorderStyle = bsNone
            Color = clWhite
            Ctl3D = False
            DataSource = ds_users
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
            OnDrawColumnCell = dbg_usersDrawColumnCell
            OnDblClick = dbg_usersDblClick
            Columns = <
              item
                Expanded = False
                FieldName = 'NOME'
                Width = 350
                Visible = True
              end>
          end
          object pnl_users_search: TPanel
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
            object lbe_users_search: TLabeledEdit
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
              OnKeyDown = lbe_users_searchKeyDown
            end
          end
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'PERMISSIONS'
        object pnl_roles_body: TPanel
          Left = 0
          Top = 0
          Width = 976
          Height = 619
          Align = alClient
          BevelOuter = bvNone
          Caption = 'pnl_roles_body'
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
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Courier New'
            TitleFont.Style = [fsUnderline]
            Columns = <
              item
                Expanded = False
                FieldName = 'NOME'
                Width = 350
                Visible = True
              end>
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
            TabOrder = 1
            object btn_role_remove: TButton
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
              Action = act_role_remove
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
            object btn_role_include: TButton
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
              Action = act_role_include
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
            end
          end
        end
      end
    end
  end
  object acl_users: TActionList
    Images = dmRepository.iml_32
    OnUpdate = acl_usersUpdate
    Left = 424
    Top = 355
    object act_rollback: TAction
      Caption = 'ESC - RETORNAR'
      ImageIndex = 0
      ShortCut = 27
      OnExecute = act_rollbackExecute
    end
    object act_user_store: TAction
      Caption = 'F2 - NOVO'
      ImageIndex = 1
      ShortCut = 113
      OnExecute = act_user_storeExecute
    end
    object act_user_update: TAction
      Caption = 'F3 - EDITAR'
      ImageIndex = 2
      ShortCut = 114
      OnExecute = act_user_updateExecute
    end
    object act_user_export: TAction
      Caption = 'F12 - EXPORTAR'
      ImageIndex = 5
      ShortCut = 123
      OnExecute = act_user_exportExecute
    end
    object act_role_include: TAction
      Caption = 'F5 - ADICIONAR'
      ImageIndex = 1
      ShortCut = 116
      OnExecute = act_role_includeExecute
    end
    object act_role_remove: TAction
      Caption = 'F6 - REMOVER'
      ImageIndex = 3
      ShortCut = 117
      OnExecute = act_role_removeExecute
    end
    object act_user_destroy: TAction
      Caption = 'F4 - REMOVER'
      ImageIndex = 3
      ShortCut = 115
      OnExecute = act_user_destroyExecute
    end
  end
  object fdmt_users: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 331
    Top = 297
    object fdmt_usersID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_usersNOME: TStringField
      FieldName = 'NOME'
      Size = 255
    end
    object fdmt_usersEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 255
    end
  end
  object tmr_focus: TTimer
    Enabled = False
    OnTimer = tmr_focusTimer
    Left = 328
    Top = 421
  end
  object ds_users: TDataSource
    DataSet = fdmt_users
    Left = 331
    Top = 353
  end
  object fdmt_roles: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 531
    Top = 305
    object fdmt_rolesID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_rolesNOME: TStringField
      FieldName = 'NOME'
      Size = 255
    end
  end
  object ds_roles: TDataSource
    DataSet = fdmt_roles
    Left = 531
    Top = 361
  end
end
