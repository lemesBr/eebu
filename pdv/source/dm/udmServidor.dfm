object dmServidor: TdmServidor
  OldCreateOrder = False
  Height = 773
  Width = 674
  object fdc_server: TFDConnection
    LoginPrompt = False
    Left = 64
    Top = 24
  end
  object fdq_terminais: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'SELECT * FROM VIEW_TERMINAIS T WHERE T.AUTHENTICATION IS NULL')
    Left = 64
    Top = 80
  end
  object fdq_empresas: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'SELECT * FROM EMPRESAS E WHERE E.ID = :ID')
    Left = 64
    Top = 136
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end>
  end
  object fdq_pessoas: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'SELECT * FROM PESSOAS P WHERE P.EMPRESA_ID = :EMPRESA_ID')
    Left = 64
    Top = 192
    ParamData = <
      item
        Name = 'EMPRESA_ID'
        ParamType = ptInput
      end>
  end
  object fdq_itens: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      
        'SELECT * FROM VIEW_TERMINAL_ITENS I WHERE I.EMPRESA_ID = :EMPRES' +
        'A_ID')
    Left = 64
    Top = 248
    ParamData = <
      item
        Name = 'EMPRESA_ID'
        ParamType = ptInput
      end>
  end
  object fdq_cartoes: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'SELECT * FROM CARTOES C WHERE C.EMPRESA_ID = :EMPRESA_ID')
    Left = 64
    Top = 304
    ParamData = <
      item
        Name = 'EMPRESA_ID'
        ParamType = ptInput
      end>
  end
  object fdq_users: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'SELECT * FROM USERS U WHERE U.EMPRESA_ID = :EMPRESA_ID')
    Left = 64
    Top = 360
    ParamData = <
      item
        Name = 'EMPRESA_ID'
        ParamType = ptInput
      end>
  end
  object fdq_ncms: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'SELECT * FROM NCM')
    Left = 64
    Top = 416
  end
  object fdq_turnos: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'SELECT * FROM TURNOS T WHERE T.EMPRESA_ID = :EMPRESA_ID')
    Left = 64
    Top = 472
    ParamData = <
      item
        Name = 'EMPRESA_ID'
        ParamType = ptInput
      end>
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 168
    Top = 88
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 168
    Top = 144
  end
  object fdq_movimento_create: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'INSERT INTO MOVIMENTOS ('
      '    ID,'
      '    EMPRESA_ID,'
      '    TERMINAL_ID,'
      '    TURNO_ID,'
      '    OPERADOR_ID,'
      '    GERENTE_ID,'
      '    REFERENCIA,'
      '    ABERTURA,'
      '    FECHAMENTO,'
      '    SUPRIMENTO,'
      '    SANGRIA,'
      '    SUBTOTAL,'
      '    ACRESCIMO,'
      '    DESCONTO,'
      '    TOTAL,'
      '    RECEBIDO,'
      '    TROCO,'
      '    SITUACAO,'
      '    CREATED_AT,'
      '    UPDATED_AT)'
      '  VALUES ('
      '    :ID,'
      '    :EMPRESA_ID,'
      '    :TERMINAL_ID,'
      '    :TURNO_ID,'
      '    :OPERADOR_ID,'
      '    :GERENTE_ID,'
      '    :REFERENCIA,'
      '    :ABERTURA,'
      '    :FECHAMENTO,'
      '    :SUPRIMENTO,'
      '    :SANGRIA,'
      '    :SUBTOTAL,'
      '    :ACRESCIMO,'
      '    :DESCONTO,'
      '    :TOTAL,'
      '    :RECEBIDO,'
      '    :TROCO,'
      '    :SITUACAO,'
      '    :CREATED_AT,'
      '    :UPDATED_AT);')
    Left = 168
    Top = 200
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end
      item
        Name = 'EMPRESA_ID'
        ParamType = ptInput
      end
      item
        Name = 'TERMINAL_ID'
        ParamType = ptInput
      end
      item
        Name = 'TURNO_ID'
        ParamType = ptInput
      end
      item
        Name = 'OPERADOR_ID'
        ParamType = ptInput
      end
      item
        Name = 'GERENTE_ID'
        ParamType = ptInput
      end
      item
        Name = 'REFERENCIA'
        ParamType = ptInput
      end
      item
        Name = 'ABERTURA'
        ParamType = ptInput
      end
      item
        Name = 'FECHAMENTO'
        ParamType = ptInput
      end
      item
        Name = 'SUPRIMENTO'
        ParamType = ptInput
      end
      item
        Name = 'SANGRIA'
        ParamType = ptInput
      end
      item
        Name = 'SUBTOTAL'
        ParamType = ptInput
      end
      item
        Name = 'ACRESCIMO'
        ParamType = ptInput
      end
      item
        Name = 'DESCONTO'
        ParamType = ptInput
      end
      item
        Name = 'TOTAL'
        ParamType = ptInput
      end
      item
        Name = 'RECEBIDO'
        ParamType = ptInput
      end
      item
        Name = 'TROCO'
        ParamType = ptInput
      end
      item
        Name = 'SITUACAO'
        ParamType = ptInput
      end
      item
        Name = 'CREATED_AT'
        ParamType = ptInput
      end
      item
        Name = 'UPDATED_AT'
        ParamType = ptInput
      end>
  end
  object fdq_suprimento_create: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'INSERT INTO SUPRIMENTOS ('
      '    ID,'
      '    EMPRESA_ID,'
      '    MOVIMENTO_ID,'
      '    VALOR,'
      '    CREATED_AT,'
      '    UPDATED_AT)'
      '  VALUES ('
      '    :ID,'
      '    :EMPRESA_ID,'
      '    :MOVIMENTO_ID,'
      '    :VALOR,'
      '    :CREATED_AT,'
      '    :UPDATED_AT);')
    Left = 168
    Top = 256
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end
      item
        Name = 'EMPRESA_ID'
        ParamType = ptInput
      end
      item
        Name = 'MOVIMENTO_ID'
        ParamType = ptInput
      end
      item
        Name = 'VALOR'
        ParamType = ptInput
      end
      item
        Name = 'CREATED_AT'
        ParamType = ptInput
      end
      item
        Name = 'UPDATED_AT'
        ParamType = ptInput
      end>
  end
  object fdq_sangria_create: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'INSERT INTO SANGRIAS ('
      '    ID,'
      '    EMPRESA_ID,'
      '    MOVIMENTO_ID,'
      '    VALOR,'
      '    MOTIVO,'
      '    CREATED_AT,'
      '    UPDATED_AT)'
      '  VALUES ('
      '    :ID,'
      '    :EMPRESA_ID,'
      '    :MOVIMENTO_ID,'
      '    :VALOR,'
      '    :MOTIVO,'
      '    :CREATED_AT,'
      '    :UPDATED_AT);')
    Left = 168
    Top = 312
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end
      item
        Name = 'EMPRESA_ID'
        ParamType = ptInput
      end
      item
        Name = 'MOVIMENTO_ID'
        ParamType = ptInput
      end
      item
        Name = 'VALOR'
        ParamType = ptInput
      end
      item
        Name = 'MOTIVO'
        ParamType = ptInput
      end
      item
        Name = 'CREATED_AT'
        ParamType = ptInput
      end
      item
        Name = 'UPDATED_AT'
        ParamType = ptInput
      end>
  end
  object fdq_venda_create: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'INSERT INTO VENDAS ('
      '    ID,'
      '    EMPRESA_ID,'
      '    PESSOA_ID,'
      '    USER_ID,'
      '    MOVIMENTO_ID,'
      '    REFERENCIA,'
      '    COMPETENCIA,'
      '    SUBTOTAL,'
      '    ACRESCIMO,'
      '    DESCONTO,'
      '    TOTAL,'
      '    SITUACAO,'
      '    CREATED_AT,'
      '    UPDATED_AT)'
      '  VALUES ('
      '    :ID,'
      '    :EMPRESA_ID,'
      '    :PESSOA_ID,'
      '    :USER_ID,'
      '    :MOVIMENTO_ID,'
      '    :REFERENCIA,'
      '    :COMPETENCIA,'
      '    :SUBTOTAL,'
      '    :ACRESCIMO,'
      '    :DESCONTO,'
      '    :TOTAL,'
      '    :SITUACAO,'
      '    :CREATED_AT,'
      '    :UPDATED_AT);')
    Left = 168
    Top = 368
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end
      item
        Name = 'EMPRESA_ID'
        ParamType = ptInput
      end
      item
        Name = 'PESSOA_ID'
        ParamType = ptInput
      end
      item
        Name = 'USER_ID'
        ParamType = ptInput
      end
      item
        Name = 'MOVIMENTO_ID'
        ParamType = ptInput
      end
      item
        Name = 'REFERENCIA'
        ParamType = ptInput
      end
      item
        Name = 'COMPETENCIA'
        ParamType = ptInput
      end
      item
        Name = 'SUBTOTAL'
        ParamType = ptInput
      end
      item
        Name = 'ACRESCIMO'
        ParamType = ptInput
      end
      item
        Name = 'DESCONTO'
        ParamType = ptInput
      end
      item
        Name = 'TOTAL'
        ParamType = ptInput
      end
      item
        Name = 'SITUACAO'
        ParamType = ptInput
      end
      item
        Name = 'CREATED_AT'
        ParamType = ptInput
      end
      item
        Name = 'UPDATED_AT'
        ParamType = ptInput
      end>
  end
  object fdq_venda_item_create: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'INSERT INTO VENDA_ITENS ('
      '    ID,'
      '    EMPRESA_ID,'
      '    USER_ID,'
      '    VENDA_ID,'
      '    ITEM_ID,'
      '    UNITARIO,'
      '    QTDE,'
      '    SUBTOTAL,'
      '    ACRESCIMO,'
      '    DESCONTO,'
      '    TOTAL,'
      '    CREATED_AT,'
      '    UPDATED_AT)'
      '  VALUES ('
      '    :ID,'
      '    :EMPRESA_ID,'
      '    :USER_ID,'
      '    :VENDA_ID,'
      '    :ITEM_ID,'
      '    :UNITARIO,'
      '    :QTDE,'
      '    :SUBTOTAL,'
      '    :ACRESCIMO,'
      '    :DESCONTO,'
      '    :TOTAL,'
      '    :CREATED_AT,'
      '    :UPDATED_AT);')
    Left = 168
    Top = 426
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end
      item
        Name = 'EMPRESA_ID'
        ParamType = ptInput
      end
      item
        Name = 'USER_ID'
        ParamType = ptInput
      end
      item
        Name = 'VENDA_ID'
        ParamType = ptInput
      end
      item
        Name = 'ITEM_ID'
        ParamType = ptInput
      end
      item
        Name = 'UNITARIO'
        ParamType = ptInput
      end
      item
        Name = 'QTDE'
        ParamType = ptInput
      end
      item
        Name = 'SUBTOTAL'
        ParamType = ptInput
      end
      item
        Name = 'ACRESCIMO'
        ParamType = ptInput
      end
      item
        Name = 'DESCONTO'
        ParamType = ptInput
      end
      item
        Name = 'TOTAL'
        ParamType = ptInput
      end
      item
        Name = 'CREATED_AT'
        ParamType = ptInput
      end
      item
        Name = 'UPDATED_AT'
        ParamType = ptInput
      end>
  end
  object fdq_venda_recebimento_create: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'INSERT INTO VENDA_RECEBIMENTOS ('
      '    ID,'
      '    EMPRESA_ID,'
      '    VENDA_ID,'
      '    TPAG,'
      '    RECEBIDO,'
      '    TROCO,'
      '    CREATED_AT,'
      '    UPDATED_AT)'
      '  VALUES ('
      '    :ID,'
      '    :EMPRESA_ID,'
      '    :VENDA_ID,'
      '    :TPAG,'
      '    :RECEBIDO,'
      '    :TROCO,'
      '    :CREATED_AT,'
      '    :UPDATED_AT);')
    Left = 359
    Top = 146
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end
      item
        Name = 'EMPRESA_ID'
        ParamType = ptInput
      end
      item
        Name = 'VENDA_ID'
        ParamType = ptInput
      end
      item
        Name = 'TPAG'
        ParamType = ptInput
      end
      item
        Name = 'RECEBIDO'
        ParamType = ptInput
      end
      item
        Name = 'TROCO'
        ParamType = ptInput
      end
      item
        Name = 'CREATED_AT'
        ParamType = ptInput
      end
      item
        Name = 'UPDATED_AT'
        ParamType = ptInput
      end>
  end
  object fdq_recebimento_create: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'INSERT INTO RECEBIMENTOS ('
      '    ID,'
      '    EMPRESA_ID,'
      '    CONTA_ID,'
      '    PESSOA_ID,'
      '    CATEGORIA_ID,'
      '    VENDA_ID,'
      '    CARTAO_ID,'
      '    MODALIDADE,'
      '    PARCELA,'
      '    QTDE_PARCELAS,'
      '    REFERENCIA,'
      '    DESCRICAO,'
      '    COMPETENCIA,'
      '    VALOR,'
      '    DESCONTOS_TAXAS,'
      '    JUROS_MULTA,'
      '    VALOR_RECEBIDO,'
      '    VENCIMENTO,'
      '    RECEBIMENTO,'
      '    SITUACAO,'
      '    CREATED_AT,'
      '    UPDATED_AT)'
      '  VALUES ('
      '    :ID,'
      '    :EMPRESA_ID,'
      '    :CONTA_ID,'
      '    :PESSOA_ID,'
      '    :CATEGORIA_ID,'
      '    :VENDA_ID,'
      '    :CARTAO_ID,'
      '    :MODALIDADE,'
      '    :PARCELA,'
      '    :QTDE_PARCELAS,'
      '    :REFERENCIA,'
      '    :DESCRICAO,'
      '    :COMPETENCIA,'
      '    :VALOR,'
      '    :DESCONTOS_TAXAS,'
      '    :JUROS_MULTA,'
      '    :VALOR_RECEBIDO,'
      '    :VENCIMENTO,'
      '    :RECEBIMENTO,'
      '    :SITUACAO,'
      '    :CREATED_AT,'
      '    :UPDATED_AT);')
    Left = 359
    Top = 210
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end
      item
        Name = 'EMPRESA_ID'
        ParamType = ptInput
      end
      item
        Name = 'CONTA_ID'
        ParamType = ptInput
      end
      item
        Name = 'PESSOA_ID'
        ParamType = ptInput
      end
      item
        Name = 'CATEGORIA_ID'
        ParamType = ptInput
      end
      item
        Name = 'VENDA_ID'
        ParamType = ptInput
      end
      item
        Name = 'CARTAO_ID'
        ParamType = ptInput
      end
      item
        Name = 'MODALIDADE'
        ParamType = ptInput
      end
      item
        Name = 'PARCELA'
        ParamType = ptInput
      end
      item
        Name = 'QTDE_PARCELAS'
        ParamType = ptInput
      end
      item
        Name = 'REFERENCIA'
        ParamType = ptInput
      end
      item
        Name = 'DESCRICAO'
        ParamType = ptInput
      end
      item
        Name = 'COMPETENCIA'
        ParamType = ptInput
      end
      item
        Name = 'VALOR'
        ParamType = ptInput
      end
      item
        Name = 'DESCONTOS_TAXAS'
        ParamType = ptInput
      end
      item
        Name = 'JUROS_MULTA'
        ParamType = ptInput
      end
      item
        Name = 'VALOR_RECEBIDO'
        ParamType = ptInput
      end
      item
        Name = 'VENCIMENTO'
        ParamType = ptInput
      end
      item
        Name = 'RECEBIMENTO'
        ParamType = ptInput
      end
      item
        Name = 'SITUACAO'
        ParamType = ptInput
      end
      item
        Name = 'CREATED_AT'
        ParamType = ptInput
      end
      item
        Name = 'UPDATED_AT'
        ParamType = ptInput
      end>
  end
  object fdq_movimento_fechamento_create: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'INSERT INTO MOVIMENTO_FECHAMENTOS ('
      '    ID,'
      '    EMPRESA_ID,'
      '    MOVIMENTO_ID,'
      '    TPAG,'
      '    DECLARADO,'
      '    CREATED_AT,'
      '    UPDATED_AT)'
      '  VALUES ('
      '    :ID,'
      '    :EMPRESA_ID,'
      '    :MOVIMENTO_ID,'
      '    :TPAG,'
      '    :DECLARADO,'
      '    :CREATED_AT,'
      '    :UPDATED_AT);')
    Left = 359
    Top = 274
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end
      item
        Name = 'EMPRESA_ID'
        ParamType = ptInput
      end
      item
        Name = 'MOVIMENTO_ID'
        ParamType = ptInput
      end
      item
        Name = 'TPAG'
        ParamType = ptInput
      end
      item
        Name = 'DECLARADO'
        ParamType = ptInput
      end
      item
        Name = 'CREATED_AT'
        ParamType = ptInput
      end
      item
        Name = 'UPDATED_AT'
        ParamType = ptInput
      end>
  end
  object fdq_nfe_create: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'INSERT INTO NFES ('
      '    ID,'
      '    EMPRESA_ID,'
      '    PARTICIPANTE_ID,'
      '    OPERACAO_FISCAL_ID,'
      '    CUF,'
      '    CNF,'
      '    NATOP,'
      '    INDPAG,'
      '    MODELO,'
      '    SERIE,'
      '    NNF,'
      '    DEMI,'
      '    TPNF,'
      '    TPNF_WT,'
      '    IDDEST,'
      '    CMUNFG,'
      '    TPIMP,'
      '    TPEMIS,'
      '    CDV,'
      '    TPAMB,'
      '    FINNFE,'
      '    INDFINAL,'
      '    INDPRES,'
      '    PROCEMI,'
      '    DHCONT,'
      '    XJUST,'
      '    CHNFE,'
      '    NPROT,'
      '    CSTAT,'
      '    XML,'
      '    NFERECEBIDA,'
      '    NUNLOTE,'
      '    AUTO_CALCULO,'
      '    CREATED_AT,'
      '    UPDATED_AT)'
      '  VALUES ('
      '    :ID,'
      '    :EMPRESA_ID,'
      '    :PARTICIPANTE_ID,'
      '    :OPERACAO_FISCAL_ID,'
      '    :CUF,'
      '    :CNF,'
      '    :NATOP,'
      '    :INDPAG,'
      '    :MODELO,'
      '    :SERIE,'
      '    :NNF,'
      '    :DEMI,'
      '    :TPNF,'
      '    :TPNF_WT,'
      '    :IDDEST,'
      '    :CMUNFG,'
      '    :TPIMP,'
      '    :TPEMIS,'
      '    :CDV,'
      '    :TPAMB,'
      '    :FINNFE,'
      '    :INDFINAL,'
      '    :INDPRES,'
      '    :PROCEMI,'
      '    :DHCONT,'
      '    :XJUST,'
      '    :CHNFE,'
      '    :NPROT,'
      '    :CSTAT,'
      '    :XML,'
      '    :NFERECEBIDA,'
      '    :NUNLOTE,'
      '    :AUTO_CALCULO,'
      '    :CREATED_AT,'
      '    :UPDATED_AT);')
    Left = 359
    Top = 330
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end
      item
        Name = 'EMPRESA_ID'
        ParamType = ptInput
      end
      item
        Name = 'PARTICIPANTE_ID'
        ParamType = ptInput
      end
      item
        Name = 'OPERACAO_FISCAL_ID'
        ParamType = ptInput
      end
      item
        Name = 'CUF'
        ParamType = ptInput
      end
      item
        Name = 'CNF'
        ParamType = ptInput
      end
      item
        Name = 'NATOP'
        ParamType = ptInput
      end
      item
        Name = 'INDPAG'
        ParamType = ptInput
      end
      item
        Name = 'MODELO'
        ParamType = ptInput
      end
      item
        Name = 'SERIE'
        ParamType = ptInput
      end
      item
        Name = 'NNF'
        ParamType = ptInput
      end
      item
        Name = 'DEMI'
        ParamType = ptInput
      end
      item
        Name = 'TPNF'
        ParamType = ptInput
      end
      item
        Name = 'TPNF_WT'
        ParamType = ptInput
      end
      item
        Name = 'IDDEST'
        ParamType = ptInput
      end
      item
        Name = 'CMUNFG'
        ParamType = ptInput
      end
      item
        Name = 'TPIMP'
        ParamType = ptInput
      end
      item
        Name = 'TPEMIS'
        ParamType = ptInput
      end
      item
        Name = 'CDV'
        ParamType = ptInput
      end
      item
        Name = 'TPAMB'
        ParamType = ptInput
      end
      item
        Name = 'FINNFE'
        ParamType = ptInput
      end
      item
        Name = 'INDFINAL'
        ParamType = ptInput
      end
      item
        Name = 'INDPRES'
        ParamType = ptInput
      end
      item
        Name = 'PROCEMI'
        ParamType = ptInput
      end
      item
        Name = 'DHCONT'
        ParamType = ptInput
      end
      item
        Name = 'XJUST'
        ParamType = ptInput
      end
      item
        Name = 'CHNFE'
        ParamType = ptInput
      end
      item
        Name = 'NPROT'
        ParamType = ptInput
      end
      item
        Name = 'CSTAT'
        ParamType = ptInput
      end
      item
        Name = 'XML'
        ParamType = ptInput
      end
      item
        Name = 'NFERECEBIDA'
        ParamType = ptInput
      end
      item
        Name = 'NUNLOTE'
        ParamType = ptInput
      end
      item
        Name = 'AUTO_CALCULO'
        ParamType = ptInput
      end
      item
        Name = 'CREATED_AT'
        ParamType = ptInput
      end
      item
        Name = 'UPDATED_AT'
        ParamType = ptInput
      end>
  end
  object fdq_nfe_pag_create: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'INSERT INTO NFE_PAG ('
      '    ID,'
      '    EMPRESA_ID,'
      '    NFE_ID,'
      '    TPAG,'
      '    VPAG,'
      '    TPINTEGRA,'
      '    CNPJ,'
      '    TBAND,'
      '    CAUT,'
      '    VTROCO,'
      '    CREATED_AT,'
      '    UPDATED_AT)'
      '  VALUES ('
      '    :ID,'
      '    :EMPRESA_ID,'
      '    :NFE_ID,'
      '    :TPAG,'
      '    :VPAG,'
      '    :TPINTEGRA,'
      '    :CNPJ,'
      '    :TBAND,'
      '    :CAUT,'
      '    :VTROCO,'
      '    :CREATED_AT,'
      '    :UPDATED_AT);')
    Left = 361
    Top = 665
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end
      item
        Name = 'EMPRESA_ID'
        ParamType = ptInput
      end
      item
        Name = 'NFE_ID'
        ParamType = ptInput
      end
      item
        Name = 'TPAG'
        ParamType = ptInput
      end
      item
        Name = 'VPAG'
        ParamType = ptInput
      end
      item
        Name = 'TPINTEGRA'
        ParamType = ptInput
      end
      item
        Name = 'CNPJ'
        ParamType = ptInput
      end
      item
        Name = 'TBAND'
        ParamType = ptInput
      end
      item
        Name = 'CAUT'
        ParamType = ptInput
      end
      item
        Name = 'VTROCO'
        ParamType = ptInput
      end
      item
        Name = 'CREATED_AT'
        ParamType = ptInput
      end
      item
        Name = 'UPDATED_AT'
        ParamType = ptInput
      end>
  end
  object fdq_nfe_total_icms_create: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'INSERT INTO NFE_TOTAL_ICMS ('
      '    ID,'
      '    EMPRESA_ID,'
      '    NFE_ID,'
      '    VBC,'
      '    VICMS,'
      '    VICMSDESON,'
      '    VFCPUFDEST,'
      '    VICMSUFDEST,'
      '    VICMSUFREMET,'
      '    VFCP,'
      '    VBCST,'
      '    VST,'
      '    VFCPST,'
      '    VFCPSTRET,'
      '    VPROD,'
      '    VFRETE,'
      '    VSEG,'
      '    VDESC,'
      '    VII,'
      '    VIPI,'
      '    VIPIDEVOL,'
      '    VPIS,'
      '    VCOFINS,'
      '    VOUTRO,'
      '    VNF,'
      '    VTOTTRIB,'
      '    CREATED_AT,'
      '    UPDATED_AT)'
      '  VALUES ('
      '    :ID,'
      '    :EMPRESA_ID,'
      '    :NFE_ID,'
      '    :VBC,'
      '    :VICMS,'
      '    :VICMSDESON,'
      '    :VFCPUFDEST,'
      '    :VICMSUFDEST,'
      '    :VICMSUFREMET,'
      '    :VFCP,'
      '    :VBCST,'
      '    :VST,'
      '    :VFCPST,'
      '    :VFCPSTRET,'
      '    :VPROD,'
      '    :VFRETE,'
      '    :VSEG,'
      '    :VDESC,'
      '    :VII,'
      '    :VIPI,'
      '    :VIPIDEVOL,'
      '    :VPIS,'
      '    :VCOFINS,'
      '    :VOUTRO,'
      '    :VNF,'
      '    :VTOTTRIB,'
      '    :CREATED_AT,'
      '    :UPDATED_AT);')
    Left = 361
    Top = 713
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end
      item
        Name = 'EMPRESA_ID'
        ParamType = ptInput
      end
      item
        Name = 'NFE_ID'
        ParamType = ptInput
      end
      item
        Name = 'VBC'
        ParamType = ptInput
      end
      item
        Name = 'VICMS'
        ParamType = ptInput
      end
      item
        Name = 'VICMSDESON'
        ParamType = ptInput
      end
      item
        Name = 'VFCPUFDEST'
        ParamType = ptInput
      end
      item
        Name = 'VICMSUFDEST'
        ParamType = ptInput
      end
      item
        Name = 'VICMSUFREMET'
        ParamType = ptInput
      end
      item
        Name = 'VFCP'
        ParamType = ptInput
      end
      item
        Name = 'VBCST'
        ParamType = ptInput
      end
      item
        Name = 'VST'
        ParamType = ptInput
      end
      item
        Name = 'VFCPST'
        ParamType = ptInput
      end
      item
        Name = 'VFCPSTRET'
        ParamType = ptInput
      end
      item
        Name = 'VPROD'
        ParamType = ptInput
      end
      item
        Name = 'VFRETE'
        ParamType = ptInput
      end
      item
        Name = 'VSEG'
        ParamType = ptInput
      end
      item
        Name = 'VDESC'
        ParamType = ptInput
      end
      item
        Name = 'VII'
        ParamType = ptInput
      end
      item
        Name = 'VIPI'
        ParamType = ptInput
      end
      item
        Name = 'VIPIDEVOL'
        ParamType = ptInput
      end
      item
        Name = 'VPIS'
        ParamType = ptInput
      end
      item
        Name = 'VCOFINS'
        ParamType = ptInput
      end
      item
        Name = 'VOUTRO'
        ParamType = ptInput
      end
      item
        Name = 'VNF'
        ParamType = ptInput
      end
      item
        Name = 'VTOTTRIB'
        ParamType = ptInput
      end
      item
        Name = 'CREATED_AT'
        ParamType = ptInput
      end
      item
        Name = 'UPDATED_AT'
        ParamType = ptInput
      end>
  end
  object fdq_nfe_det_create: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'INSERT INTO NFE_DET ('
      '    ID,'
      '    EMPRESA_ID,'
      '    NFE_ID,'
      '    ITEM_ID,'
      '    CPROD,'
      '    NITEM,'
      '    CEAN,'
      '    XPROD,'
      '    NCM,'
      '    EXTIPI,'
      '    CFOP,'
      '    UCOM,'
      '    QCOM,'
      '    VUNCOM,'
      '    VPROD,'
      '    CEANTRIB,'
      '    UTRIB,'
      '    QTRIB,'
      '    VUNTRIB,'
      '    VFRETE,'
      '    VSEG,'
      '    VDESC,'
      '    VOUTRO,'
      '    INDTOT,'
      '    XPED,'
      '    NITEMPED,'
      '    NRECOPI,'
      '    NFCI,'
      '    CEST,'
      '    VTOTTRIB,'
      '    PDEVOL,'
      '    VIPIDEVOL,'
      '    INFADPROD,'
      '    CREATED_AT,'
      '    UPDATED_AT)'
      '  VALUES ('
      '    :ID,'
      '    :EMPRESA_ID,'
      '    :NFE_ID,'
      '    :ITEM_ID,'
      '    :CPROD,'
      '    :NITEM,'
      '    :CEAN,'
      '    :XPROD,'
      '    :NCM,'
      '    :EXTIPI,'
      '    :CFOP,'
      '    :UCOM,'
      '    :QCOM,'
      '    :VUNCOM,'
      '    :VPROD,'
      '    :CEANTRIB,'
      '    :UTRIB,'
      '    :QTRIB,'
      '    :VUNTRIB,'
      '    :VFRETE,'
      '    :VSEG,'
      '    :VDESC,'
      '    :VOUTRO,'
      '    :INDTOT,'
      '    :XPED,'
      '    :NITEMPED,'
      '    :NRECOPI,'
      '    :NFCI,'
      '    :CEST,'
      '    :VTOTTRIB,'
      '    :PDEVOL,'
      '    :VIPIDEVOL,'
      '    :INFADPROD,'
      '    :CREATED_AT,'
      '    :UPDATED_AT);')
    Left = 359
    Top = 394
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end
      item
        Name = 'EMPRESA_ID'
        ParamType = ptInput
      end
      item
        Name = 'NFE_ID'
        ParamType = ptInput
      end
      item
        Name = 'ITEM_ID'
        ParamType = ptInput
      end
      item
        Name = 'CPROD'
        ParamType = ptInput
      end
      item
        Name = 'NITEM'
        ParamType = ptInput
      end
      item
        Name = 'CEAN'
        ParamType = ptInput
      end
      item
        Name = 'XPROD'
        ParamType = ptInput
      end
      item
        Name = 'NCM'
        ParamType = ptInput
      end
      item
        Name = 'EXTIPI'
        ParamType = ptInput
      end
      item
        Name = 'CFOP'
        ParamType = ptInput
      end
      item
        Name = 'UCOM'
        ParamType = ptInput
      end
      item
        Name = 'QCOM'
        ParamType = ptInput
      end
      item
        Name = 'VUNCOM'
        ParamType = ptInput
      end
      item
        Name = 'VPROD'
        ParamType = ptInput
      end
      item
        Name = 'CEANTRIB'
        ParamType = ptInput
      end
      item
        Name = 'UTRIB'
        ParamType = ptInput
      end
      item
        Name = 'QTRIB'
        ParamType = ptInput
      end
      item
        Name = 'VUNTRIB'
        ParamType = ptInput
      end
      item
        Name = 'VFRETE'
        ParamType = ptInput
      end
      item
        Name = 'VSEG'
        ParamType = ptInput
      end
      item
        Name = 'VDESC'
        ParamType = ptInput
      end
      item
        Name = 'VOUTRO'
        ParamType = ptInput
      end
      item
        Name = 'INDTOT'
        ParamType = ptInput
      end
      item
        Name = 'XPED'
        ParamType = ptInput
      end
      item
        Name = 'NITEMPED'
        ParamType = ptInput
      end
      item
        Name = 'NRECOPI'
        ParamType = ptInput
      end
      item
        Name = 'NFCI'
        ParamType = ptInput
      end
      item
        Name = 'CEST'
        ParamType = ptInput
      end
      item
        Name = 'VTOTTRIB'
        ParamType = ptInput
      end
      item
        Name = 'PDEVOL'
        ParamType = ptInput
      end
      item
        Name = 'VIPIDEVOL'
        ParamType = ptInput
      end
      item
        Name = 'INFADPROD'
        ParamType = ptInput
      end
      item
        Name = 'CREATED_AT'
        ParamType = ptInput
      end
      item
        Name = 'UPDATED_AT'
        ParamType = ptInput
      end>
  end
  object fdq_nfe_det_icms_create: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'INSERT INTO NFE_DET_ICMS ('
      '    ID,'
      '    EMPRESA_ID,'
      '    NFE_DET_ID,'
      '    ORIG,'
      '    CST,'
      '    CSOSN,'
      '    MODBC,'
      '    PREDBC,'
      '    VBC,'
      '    PICMS,'
      '    VICMS,'
      '    MODBCST,'
      '    PMVAST,'
      '    PREDBCST,'
      '    VBCST,'
      '    PICMSST,'
      '    VICMSST,'
      '    UFST,'
      '    PBCOP,'
      '    VBCSTRET,'
      '    VICMSSTRET,'
      '    MOTDESICMS,'
      '    PCREDSN,'
      '    VCREDICMSSN,'
      '    VBCSTDEST,'
      '    VICMSSTDEST,'
      '    VICMSDESON,'
      '    VICMSOP,'
      '    PDIF,'
      '    VICMSDIF,'
      '    VBCFCP,'
      '    PFCP,'
      '    VFCP,'
      '    VBCFCPST,'
      '    PFCPST,'
      '    VFCPST,'
      '    VBCFCPSTRET,'
      '    PFCPSTRET,'
      '    VFCPSTRET,'
      '    PST,'
      '    CREATED_AT,'
      '    UPDATED_AT)'
      '  VALUES ('
      '    :ID,'
      '    :EMPRESA_ID,'
      '    :NFE_DET_ID,'
      '    :ORIG,'
      '    :CST,'
      '    :CSOSN,'
      '    :MODBC,'
      '    :PREDBC,'
      '    :VBC,'
      '    :PICMS,'
      '    :VICMS,'
      '    :MODBCST,'
      '    :PMVAST,'
      '    :PREDBCST,'
      '    :VBCST,'
      '    :PICMSST,'
      '    :VICMSST,'
      '    :UFST,'
      '    :PBCOP,'
      '    :VBCSTRET,'
      '    :VICMSSTRET,'
      '    :MOTDESICMS,'
      '    :PCREDSN,'
      '    :VCREDICMSSN,'
      '    :VBCSTDEST,'
      '    :VICMSSTDEST,'
      '    :VICMSDESON,'
      '    :VICMSOP,'
      '    :PDIF,'
      '    :VICMSDIF,'
      '    :VBCFCP,'
      '    :PFCP,'
      '    :VFCP,'
      '    :VBCFCPST,'
      '    :PFCPST,'
      '    :VFCPST,'
      '    :VBCFCPSTRET,'
      '    :PFCPSTRET,'
      '    :VFCPSTRET,'
      '    :PST,'
      '    :CREATED_AT,'
      '    :UPDATED_AT);')
    Left = 359
    Top = 450
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end
      item
        Name = 'EMPRESA_ID'
        ParamType = ptInput
      end
      item
        Name = 'NFE_DET_ID'
        ParamType = ptInput
      end
      item
        Name = 'ORIG'
        ParamType = ptInput
      end
      item
        Name = 'CST'
        ParamType = ptInput
      end
      item
        Name = 'CSOSN'
        ParamType = ptInput
      end
      item
        Name = 'MODBC'
        ParamType = ptInput
      end
      item
        Name = 'PREDBC'
        ParamType = ptInput
      end
      item
        Name = 'VBC'
        ParamType = ptInput
      end
      item
        Name = 'PICMS'
        ParamType = ptInput
      end
      item
        Name = 'VICMS'
        ParamType = ptInput
      end
      item
        Name = 'MODBCST'
        ParamType = ptInput
      end
      item
        Name = 'PMVAST'
        ParamType = ptInput
      end
      item
        Name = 'PREDBCST'
        ParamType = ptInput
      end
      item
        Name = 'VBCST'
        ParamType = ptInput
      end
      item
        Name = 'PICMSST'
        ParamType = ptInput
      end
      item
        Name = 'VICMSST'
        ParamType = ptInput
      end
      item
        Name = 'UFST'
        ParamType = ptInput
      end
      item
        Name = 'PBCOP'
        ParamType = ptInput
      end
      item
        Name = 'VBCSTRET'
        ParamType = ptInput
      end
      item
        Name = 'VICMSSTRET'
        ParamType = ptInput
      end
      item
        Name = 'MOTDESICMS'
        ParamType = ptInput
      end
      item
        Name = 'PCREDSN'
        ParamType = ptInput
      end
      item
        Name = 'VCREDICMSSN'
        ParamType = ptInput
      end
      item
        Name = 'VBCSTDEST'
        ParamType = ptInput
      end
      item
        Name = 'VICMSSTDEST'
        ParamType = ptInput
      end
      item
        Name = 'VICMSDESON'
        ParamType = ptInput
      end
      item
        Name = 'VICMSOP'
        ParamType = ptInput
      end
      item
        Name = 'PDIF'
        ParamType = ptInput
      end
      item
        Name = 'VICMSDIF'
        ParamType = ptInput
      end
      item
        Name = 'VBCFCP'
        ParamType = ptInput
      end
      item
        Name = 'PFCP'
        ParamType = ptInput
      end
      item
        Name = 'VFCP'
        ParamType = ptInput
      end
      item
        Name = 'VBCFCPST'
        ParamType = ptInput
      end
      item
        Name = 'PFCPST'
        ParamType = ptInput
      end
      item
        Name = 'VFCPST'
        ParamType = ptInput
      end
      item
        Name = 'VBCFCPSTRET'
        ParamType = ptInput
      end
      item
        Name = 'PFCPSTRET'
        ParamType = ptInput
      end
      item
        Name = 'VFCPSTRET'
        ParamType = ptInput
      end
      item
        Name = 'PST'
        ParamType = ptInput
      end
      item
        Name = 'CREATED_AT'
        ParamType = ptInput
      end
      item
        Name = 'UPDATED_AT'
        ParamType = ptInput
      end>
  end
  object fdq_nfe_det_ipi_create: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'INSERT INTO NFE_DET_IPI ('
      '    ID,'
      '    EMPRESA_ID,'
      '    NFE_DET_ID,'
      '    CLENQ,'
      '    CNPJPROD,'
      '    CSELO,'
      '    QSELO,'
      '    CENQ,'
      '    CST,'
      '    VBC,'
      '    QUNID,'
      '    VUNID,'
      '    PIPI,'
      '    VIPI,'
      '    CREATED_AT,'
      '    UPDATED_AT)'
      '  VALUES ('
      '    :ID,'
      '    :EMPRESA_ID,'
      '    :NFE_DET_ID,'
      '    :CLENQ,'
      '    :CNPJPROD,'
      '    :CSELO,'
      '    :QSELO,'
      '    :CENQ,'
      '    :CST,'
      '    :VBC,'
      '    :QUNID,'
      '    :VUNID,'
      '    :PIPI,'
      '    :VIPI,'
      '    :CREATED_AT,'
      '    :UPDATED_AT);')
    Left = 359
    Top = 506
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end
      item
        Name = 'EMPRESA_ID'
        ParamType = ptInput
      end
      item
        Name = 'NFE_DET_ID'
        ParamType = ptInput
      end
      item
        Name = 'CLENQ'
        ParamType = ptInput
      end
      item
        Name = 'CNPJPROD'
        ParamType = ptInput
      end
      item
        Name = 'CSELO'
        ParamType = ptInput
      end
      item
        Name = 'QSELO'
        ParamType = ptInput
      end
      item
        Name = 'CENQ'
        ParamType = ptInput
      end
      item
        Name = 'CST'
        ParamType = ptInput
      end
      item
        Name = 'VBC'
        ParamType = ptInput
      end
      item
        Name = 'QUNID'
        ParamType = ptInput
      end
      item
        Name = 'VUNID'
        ParamType = ptInput
      end
      item
        Name = 'PIPI'
        ParamType = ptInput
      end
      item
        Name = 'VIPI'
        ParamType = ptInput
      end
      item
        Name = 'CREATED_AT'
        ParamType = ptInput
      end
      item
        Name = 'UPDATED_AT'
        ParamType = ptInput
      end>
  end
  object fdq_nfe_det_pis_create: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'INSERT INTO NFE_DET_PIS ('
      '    ID,'
      '    EMPRESA_ID,'
      '    NFE_DET_ID,'
      '    CST,'
      '    VBC,'
      '    PPIS,'
      '    QBCPROD,'
      '    VALIQPROD,'
      '    VPIS,'
      '    CREATED_AT,'
      '    UPDATED_AT)'
      '  VALUES ('
      '    :ID,'
      '    :EMPRESA_ID,'
      '    :NFE_DET_ID,'
      '    :CST,'
      '    :VBC,'
      '    :PPIS,'
      '    :QBCPROD,'
      '    :VALIQPROD,'
      '    :VPIS,'
      '    :CREATED_AT,'
      '    :UPDATED_AT);')
    Left = 359
    Top = 562
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end
      item
        Name = 'EMPRESA_ID'
        ParamType = ptInput
      end
      item
        Name = 'NFE_DET_ID'
        ParamType = ptInput
      end
      item
        Name = 'CST'
        ParamType = ptInput
      end
      item
        Name = 'VBC'
        ParamType = ptInput
      end
      item
        Name = 'PPIS'
        ParamType = ptInput
      end
      item
        Name = 'QBCPROD'
        ParamType = ptInput
      end
      item
        Name = 'VALIQPROD'
        ParamType = ptInput
      end
      item
        Name = 'VPIS'
        ParamType = ptInput
      end
      item
        Name = 'CREATED_AT'
        ParamType = ptInput
      end
      item
        Name = 'UPDATED_AT'
        ParamType = ptInput
      end>
  end
  object fdq_nfe_det_cofins: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'INSERT INTO NFE_DET_COFINS ('
      '    ID,'
      '    EMPRESA_ID,'
      '    NFE_DET_ID,'
      '    CST,'
      '    VBC,'
      '    PCOFINS,'
      '    QBCPROD,'
      '    VBCPROD,'
      '    VALIQPROD,'
      '    VCOFINS,'
      '    CREATED_AT,'
      '    UPDATED_AT)'
      '  VALUES ('
      '    :ID,'
      '    :EMPRESA_ID,'
      '    :NFE_DET_ID,'
      '    :CST,'
      '    :VBC,'
      '    :PCOFINS,'
      '    :QBCPROD,'
      '    :VBCPROD,'
      '    :VALIQPROD,'
      '    :VCOFINS,'
      '    :CREATED_AT,'
      '    :UPDATED_AT);')
    Left = 360
    Top = 616
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end
      item
        Name = 'EMPRESA_ID'
        ParamType = ptInput
      end
      item
        Name = 'NFE_DET_ID'
        ParamType = ptInput
      end
      item
        Name = 'CST'
        ParamType = ptInput
      end
      item
        Name = 'VBC'
        ParamType = ptInput
      end
      item
        Name = 'PCOFINS'
        ParamType = ptInput
      end
      item
        Name = 'QBCPROD'
        ParamType = ptInput
      end
      item
        Name = 'VBCPROD'
        ParamType = ptInput
      end
      item
        Name = 'VALIQPROD'
        ParamType = ptInput
      end
      item
        Name = 'VCOFINS'
        ParamType = ptInput
      end
      item
        Name = 'CREATED_AT'
        ParamType = ptInput
      end
      item
        Name = 'UPDATED_AT'
        ParamType = ptInput
      end>
  end
  object fdq_nfe_venda_create: TFDQuery
    Connection = fdc_server
    SQL.Strings = (
      'INSERT INTO NFE_VENDAS ('
      '    NFE_ID,'
      '    VENDA_ID)'
      '  VALUES ('
      '    :NFE_ID,'
      '    :VENDA_ID);')
    Left = 520
    Top = 704
    ParamData = <
      item
        Name = 'NFE_ID'
        ParamType = ptInput
      end
      item
        Name = 'VENDA_ID'
        ParamType = ptInput
      end>
  end
end
