inherited formSPEDCreateEdit: TformSPEDCreateEdit
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'formSPEDCreateEdit'
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
  object pnl_body: TPanel
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
      Caption = 'SPED'
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
      object btn_cancelar: TButton
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
        Action = act_cancelar
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
        TabOrder = 1
        TabStop = False
        WordWrap = True
      end
    end
    object pnl_main: TPanel
      Left = 21
      Top = 83
      Width = 976
      Height = 554
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 2
      object lb_cod_ver: TLabel
        Left = 32
        Top = 14
        Width = 37
        Height = 15
        Caption = 'Layout'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_cod_fin: TLabel
        Left = 142
        Top = 14
        Width = 58
        Height = 15
        Caption = 'Finalidade '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_dt_ini: TLabel
        Left = 362
        Top = 14
        Width = 58
        Height = 15
        Caption = 'Data inicial'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_dt_fin: TLabel
        Left = 482
        Top = 14
        Width = 51
        Height = 15
        Caption = 'Data final'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_ind_perfil: TLabel
        Left = 602
        Top = 14
        Width = 29
        Height = 15
        Caption = 'Perfil'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb_ind_ativ: TLabel
        Left = 682
        Top = 14
        Width = 52
        Height = 15
        Caption = 'Atividade'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cbx_cod_ver: TComboBox
        Left = 32
        Top = 32
        Width = 100
        Height = 23
        ItemIndex = 0
        TabOrder = 0
        Text = '2018'
        Items.Strings = (
          '2018')
      end
      object cbx_cod_fin: TComboBox
        Left = 142
        Top = 32
        Width = 210
        Height = 23
        TabOrder = 1
        Text = '0 - Remessa do arquivo original'
        Items.Strings = (
          '0 - Remessa do arquivo original'
          '1 - Remessa do arquivo substituto')
      end
      object dtp_dt_ini: TDateTimePicker
        Left = 362
        Top = 32
        Width = 110
        Height = 23
        Date = 43144.598107939810000000
        Time = 43144.598107939810000000
        TabOrder = 2
      end
      object dtp_dt_fin: TDateTimePicker
        Left = 482
        Top = 32
        Width = 110
        Height = 23
        Date = 43144.598656689810000000
        Time = 43144.598656689810000000
        TabOrder = 3
      end
      object cbx_ind_perfil: TComboBox
        Left = 602
        Top = 32
        Width = 70
        Height = 23
        TabOrder = 4
        Text = 'Perfil A'
        Items.Strings = (
          'Perfil A'
          'Perfil B'
          'Perfil C')
      end
      object cbx_ind_ativ: TComboBox
        Left = 682
        Top = 32
        Width = 270
        Height = 23
        TabOrder = 5
        Text = '0 '#8211' Industrial ou equiparado a industrial'
        Items.Strings = (
          '0 '#8211' Industrial ou equiparado a industrial'
          '1 '#8211' Outros')
      end
    end
  end
  object acl_sped: TActionList
    Images = dmRepository.iml_32
    Left = 460
    Top = 23
    object act_cancelar: TAction
      Caption = 'CANCELAR'
      ImageIndex = 0
      OnExecute = act_cancelarExecute
    end
    object act_confirmar: TAction
      Caption = 'CONFIRMAR'
      ImageIndex = 6
      OnExecute = act_confirmarExecute
    end
  end
end
