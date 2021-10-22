object formPrint: TformPrint
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 768
  ClientWidth = 1024
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RLReport: TRLReport
    Left = 115
    Top = 0
    Width = 794
    Height = 1123
    DataSource = ds_data
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Consolas'
    Font.Style = []
    object rlb_header: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 18
      AutoSize = True
      BandType = btTitle
    end
    object rlb_detail: TRLBand
      Left = 38
      Top = 56
      Width = 718
      Height = 18
      AutoSize = True
      object rldb_text: TRLDBText
        Left = 0
        Top = 0
        Width = 718
        Height = 18
        Align = faTop
        DataField = 'LINHA'
        DataSource = ds_data
        Text = ''
      end
    end
    object rlb_footer: TRLBand
      Left = 38
      Top = 74
      Width = 718
      Height = 18
      AutoSize = True
      BandType = btSummary
    end
    object rlb_ffooter: TRLBand
      Left = 38
      Top = 92
      Width = 718
      Height = 36
      AutoSize = True
      BandType = btFooter
      object rls_ffooter: TRLSystemInfo
        Left = 0
        Top = 18
        Width = 718
        Height = 18
        Align = faTop
        Alignment = taRightJustify
        Info = itPageNumber
        Text = ''
      end
      object rll_ffooter: TRLLabel
        Left = 0
        Top = 0
        Width = 718
        Height = 18
        Align = faTop
        Caption = 
          '----------------------------------------------------------------' +
          '------------------------'
      end
    end
  end
  object RLPreviewSetup: TRLPreviewSetup
    ShowModal = True
    Left = 40
    Top = 16
  end
  object RLHTMLFilter: TRLHTMLFilter
    DocumentStyle = dsCSS2
    DisplayName = 'P'#225'gina da Web'
    Left = 40
    Top = 72
  end
  object RLPDFFilter: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0 \251 Copyright '#169' 1999-2016 F' +
      'ortes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 40
    Top = 128
  end
  object RLXLSFilter: TRLXLSFilter
    DisplayName = 'Planilha Excel 97-2013'
    Left = 40
    Top = 184
  end
  object fdmt_data: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 40
    Top = 240
    object fdmt_dataLINHA: TStringField
      FieldName = 'LINHA'
      Size = 88
    end
  end
  object ds_data: TDataSource
    DataSet = fdmt_data
    Left = 40
    Top = 296
  end
end
