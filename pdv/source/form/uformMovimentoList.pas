unit uformMovimentoList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, System.Actions, Vcl.ActnList, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TformMovimentoList = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    btn_rollback: TButton;
    btn_reimprimir: TButton;
    btn_sincronizar: TButton;
    pnl_body: TPanel;
    dbg_movimentos: TDBGrid;
    pnl_search: TPanel;
    lbe_search: TLabeledEdit;
    fdmt_movimentos: TFDMemTable;
    fdmt_movimentosID: TStringField;
    fdmt_movimentosREFERENCIA: TIntegerField;
    ds_movimentos: TDataSource;
    acl_movimentos: TActionList;
    act_rollback: TAction;
    act_reimprimir: TAction;
    act_sincronizar: TAction;
    bvl_3: TBevel;
    fdmt_movimentosABERTURA: TDateTimeField;
    fdmt_movimentosFECHAMENTO: TDateTimeField;
    fdmt_movimentosTOTAL: TFloatField;
    fdmt_movimentosSYNCHRONIZED: TStringField;
    tmr_focus: TTimer;
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_reimprimirExecute(Sender: TObject);
    procedure act_sincronizarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbg_movimentosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure tmr_focusTimer(Sender: TObject);
    procedure lbe_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure acl_movimentosUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
    procedure list(pReferencia: string);
  public
    { Public declarations }
  end;

var
  formMovimentoList: TformMovimentoList;

implementation

{$R *.dfm}

uses udmRepository, Movimento, udmServidor, AuthService, Helper, Nfe;

procedure TformMovimentoList.acl_movimentosUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_reimprimir.Enabled:= (fdmt_movimentos.RecordCount >= 1);
  act_sincronizar.Enabled:= (fdmt_movimentos.RecordCount >= 1) and (fdmt_movimentosSYNCHRONIZED.AsString = 'N');
  tmr_focus.Enabled:= (not lbe_search.Focused);
end;

procedure TformMovimentoList.act_reimprimirExecute(Sender: TObject);
begin
  TMovimento.imprimirFechamento(fdmt_movimentosID.AsString);
end;

procedure TformMovimentoList.act_rollbackExecute(Sender: TObject);
begin
  Close();
end;

procedure TformMovimentoList.act_sincronizarExecute(Sender: TObject);
var
  vServer,
  vDatabase,
  vUser,
  vPassword,
  vEmpresaId: string;
  vMovimento: TMovimento;
  I: Integer;
  J: Integer;
begin
  try
    vMovimento:= nil;
    try
      with dmServidor do
      begin
        vServer:= TAuthService.Terminal.ServerAddress;
        vDatabase:= TAuthService.Terminal.ServerDatabase;
        vUser:= TAuthService.Terminal.ServerUserName;
        vPassword:= TAuthService.Terminal.ServerUserPassword;
        vEmpresaId:= TAuthService.Terminal.EmpresaId;

        fdc_server.Close();
        if (fdc_server.Params.Count = 0) then
        begin
          fdc_server.Params.Append('protocol=TCPIP');
          fdc_server.Params.Append('server=' + vServer);
          fdc_server.Params.Append('database=' + vDatabase);
          fdc_server.Params.Append('user_name=' + vUser);
          fdc_server.Params.Append('password=' + vPassword);
          fdc_server.Params.Append('characterset=UTF8');
          fdc_server.Params.Append('driverid=FB');
        end;
        fdc_server.Open();
        fdc_server.StartTransaction();

        vMovimento:= TMovimento.find(fdmt_movimentosID.AsString);
        if not Assigned(vMovimento) then
          raise Exception.Create('Falha ao consultar dados do movimento.');

        fdq_movimento_create.Close();
        fdq_movimento_create.Params.ParamByName('ID').DataType:= ftString;
        fdq_movimento_create.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
        fdq_movimento_create.Params.ParamByName('TERMINAL_ID').DataType:= ftString;
        fdq_movimento_create.Params.ParamByName('TURNO_ID').DataType:= ftString;
        fdq_movimento_create.Params.ParamByName('OPERADOR_ID').DataType:= ftString;
        fdq_movimento_create.Params.ParamByName('GERENTE_ID').DataType:= ftString;
        fdq_movimento_create.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
        fdq_movimento_create.Params.ParamByName('ABERTURA').DataType:= ftDateTime;
        fdq_movimento_create.Params.ParamByName('FECHAMENTO').DataType:= ftDateTime;
        fdq_movimento_create.Params.ParamByName('SUPRIMENTO').DataType:= ftExtended;
        fdq_movimento_create.Params.ParamByName('SANGRIA').DataType:= ftExtended;
        fdq_movimento_create.Params.ParamByName('SUBTOTAL').DataType:= ftExtended;
        fdq_movimento_create.Params.ParamByName('ACRESCIMO').DataType:= ftExtended;
        fdq_movimento_create.Params.ParamByName('DESCONTO').DataType:= ftExtended;
        fdq_movimento_create.Params.ParamByName('TOTAL').DataType:= ftExtended;
        fdq_movimento_create.Params.ParamByName('RECEBIDO').DataType:= ftExtended;
        fdq_movimento_create.Params.ParamByName('TROCO').DataType:= ftExtended;
        fdq_movimento_create.Params.ParamByName('SITUACAO').DataType:= ftString;
        fdq_movimento_create.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
        fdq_movimento_create.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
        fdq_movimento_create.Prepare();
        fdq_movimento_create.Params.ParamByName('ID').AsString:= vMovimento.Id;
        fdq_movimento_create.Params.ParamByName('EMPRESA_ID').AsString:= vMovimento.EmpresaId;
        fdq_movimento_create.Params.ParamByName('TERMINAL_ID').AsString:= vMovimento.TerminalId;
        fdq_movimento_create.Params.ParamByName('TURNO_ID').AsString:= vMovimento.TurnoId;
        fdq_movimento_create.Params.ParamByName('OPERADOR_ID').AsString:= vMovimento.OperadorId;
        fdq_movimento_create.Params.ParamByName('GERENTE_ID').AsString:= vMovimento.GerenteId;
        fdq_movimento_create.Params.ParamByName('REFERENCIA').AsInteger:= vMovimento.Referencia;
        fdq_movimento_create.Params.ParamByName('ABERTURA').AsDateTime:= vMovimento.Abertura;
        fdq_movimento_create.Params.ParamByName('FECHAMENTO').AsDateTime:= vMovimento.Fechamento;
        fdq_movimento_create.Params.ParamByName('SUPRIMENTO').AsExtended:= vMovimento.Suprimento;
        fdq_movimento_create.Params.ParamByName('SANGRIA').AsExtended:= vMovimento.Sangria;
        fdq_movimento_create.Params.ParamByName('SUBTOTAL').AsExtended:= vMovimento.Subtotal;
        fdq_movimento_create.Params.ParamByName('ACRESCIMO').AsExtended:= vMovimento.Acrescimo;
        fdq_movimento_create.Params.ParamByName('DESCONTO').AsExtended:= vMovimento.Desconto;
        fdq_movimento_create.Params.ParamByName('TOTAL').AsExtended:= vMovimento.Total;
        fdq_movimento_create.Params.ParamByName('RECEBIDO').AsExtended:= vMovimento.Recebido;
        fdq_movimento_create.Params.ParamByName('TROCO').AsExtended:= vMovimento.Troco;
        fdq_movimento_create.Params.ParamByName('SITUACAO').AsString:= vMovimento.Situacao;
        fdq_movimento_create.Params.ParamByName('CREATED_AT').AsDateTime:= vMovimento.CreatedAt;
        fdq_movimento_create.Params.ParamByName('UPDATED_AT').AsDateTime:= vMovimento.UpdatedAt;
        fdq_movimento_create.ExecSQL();

        fdq_suprimento_create.Close();
        fdq_suprimento_create.Params.ParamByName('ID').DataType:= ftString;
        fdq_suprimento_create.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
        fdq_suprimento_create.Params.ParamByName('MOVIMENTO_ID').DataType:= ftString;
        fdq_suprimento_create.Params.ParamByName('VALOR').DataType:= ftExtended;
        fdq_suprimento_create.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
        fdq_suprimento_create.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
        fdq_suprimento_create.Prepare();
        for I:= 0 to Pred(vMovimento.Suprimentos.Count) do
        begin
          fdq_suprimento_create.Params.ParamByName('ID').AsString:= vMovimento.Suprimentos.Items[I].Id;
          fdq_suprimento_create.Params.ParamByName('EMPRESA_ID').AsString:= vMovimento.Suprimentos.Items[I].EmpresaId;
          fdq_suprimento_create.Params.ParamByName('MOVIMENTO_ID').AsString:= vMovimento.Suprimentos.Items[I].MovimentoId;
          fdq_suprimento_create.Params.ParamByName('VALOR').AsExtended:= vMovimento.Suprimentos.Items[I].Valor;
          fdq_suprimento_create.Params.ParamByName('CREATED_AT').AsDateTime:= vMovimento.Suprimentos.Items[I].CreatedAt;
          fdq_suprimento_create.Params.ParamByName('UPDATED_AT').AsDateTime:= vMovimento.Suprimentos.Items[I].UpdatedAt;
          fdq_suprimento_create.ExecSQL();
        end;

        fdq_sangria_create.Close();
        fdq_sangria_create.Params.ParamByName('ID').DataType:= ftString;
        fdq_sangria_create.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
        fdq_sangria_create.Params.ParamByName('MOVIMENTO_ID').DataType:= ftString;
        fdq_sangria_create.Params.ParamByName('VALOR').DataType:= ftExtended;
        fdq_sangria_create.Params.ParamByName('MOTIVO').DataType:= ftString;
        fdq_sangria_create.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
        fdq_sangria_create.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
        fdq_sangria_create.Prepare();
        for I:= 0 to Pred(vMovimento.Sangrias.Count) do
        begin
          fdq_sangria_create.Params.ParamByName('ID').AsString:= vMovimento.Sangrias.Items[I].Id;
          fdq_sangria_create.Params.ParamByName('EMPRESA_ID').AsString:= vMovimento.Sangrias.Items[I].EmpresaId;
          fdq_sangria_create.Params.ParamByName('MOVIMENTO_ID').AsString:= vMovimento.Sangrias.Items[I].MovimentoId;
          fdq_sangria_create.Params.ParamByName('VALOR').AsExtended:= vMovimento.Sangrias.Items[I].Valor;
          fdq_sangria_create.Params.ParamByName('MOTIVO').AsString:= vMovimento.Sangrias.Items[I].Motivo;
          fdq_sangria_create.Params.ParamByName('CREATED_AT').AsDateTime:= vMovimento.Suprimentos.Items[I].CreatedAt;
          fdq_sangria_create.Params.ParamByName('UPDATED_AT').AsDateTime:= vMovimento.Suprimentos.Items[I].UpdatedAt;
          fdq_sangria_create.ExecSQL();
        end;

        fdq_venda_create.Close();
        fdq_venda_create.Params.ParamByName('ID').DataType:= ftString;
        fdq_venda_create.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
        fdq_venda_create.Params.ParamByName('PESSOA_ID').DataType:= ftString;
        fdq_venda_create.Params.ParamByName('USER_ID').DataType:= ftString;
        fdq_venda_create.Params.ParamByName('MOVIMENTO_ID').DataType:= ftString;
        fdq_venda_create.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
        fdq_venda_create.Params.ParamByName('COMPETENCIA').DataType:= ftDate;
        fdq_venda_create.Params.ParamByName('SUBTOTAL').DataType:= ftExtended;
        fdq_venda_create.Params.ParamByName('ACRESCIMO').DataType:= ftExtended;
        fdq_venda_create.Params.ParamByName('DESCONTO').DataType:= ftExtended;
        fdq_venda_create.Params.ParamByName('TOTAL').DataType:= ftExtended;
        fdq_venda_create.Params.ParamByName('SITUACAO').DataType:= ftString;
        fdq_venda_create.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
        fdq_venda_create.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
        fdq_venda_create.Prepare();
        for I:= 0 to Pred(vMovimento.Vendas.Count) do
        begin
          fdq_venda_create.Params.ParamByName('ID').AsString:= vMovimento.Vendas.Items[I].Id;
          fdq_venda_create.Params.ParamByName('EMPRESA_ID').AsString:= vMovimento.Vendas.Items[I].EmpresaId;
          fdq_venda_create.Params.ParamByName('PESSOA_ID').AsString:= vMovimento.Vendas.Items[I].PessoaId;
          fdq_venda_create.Params.ParamByName('USER_ID').AsString:= vMovimento.Vendas.Items[I].UserId;
          fdq_venda_create.Params.ParamByName('MOVIMENTO_ID').AsString:= vMovimento.Vendas.Items[I].MovimentoId;
          fdq_venda_create.Params.ParamByName('REFERENCIA').AsInteger:= vMovimento.Vendas.Items[I].Referencia;
          fdq_venda_create.Params.ParamByName('COMPETENCIA').AsDate:= vMovimento.Vendas.Items[I].Competencia;
          fdq_venda_create.Params.ParamByName('SUBTOTAL').AsExtended:= vMovimento.Vendas.Items[I].Subtotal;
          fdq_venda_create.Params.ParamByName('ACRESCIMO').AsExtended:= vMovimento.Vendas.Items[I].Acrescimo;
          fdq_venda_create.Params.ParamByName('DESCONTO').AsExtended:= vMovimento.Vendas.Items[I].Desconto;
          fdq_venda_create.Params.ParamByName('TOTAL').AsExtended:= vMovimento.Vendas.Items[I].Total;
          fdq_venda_create.Params.ParamByName('SITUACAO').AsString:= vMovimento.Vendas.Items[I].Situacao;
          fdq_venda_create.Params.ParamByName('CREATED_AT').AsDateTime:= vMovimento.Vendas.Items[I].CreatedAt;
          fdq_venda_create.Params.ParamByName('UPDATED_AT').AsDateTime:= vMovimento.Vendas.Items[I].UpdatedAt;
          fdq_venda_create.ExecSQL();

          fdq_venda_item_create.Close();
          fdq_venda_item_create.Params.ParamByName('ID').DataType:= ftString;
          fdq_venda_item_create.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
          fdq_venda_item_create.Params.ParamByName('USER_ID').DataType:= ftString;
          fdq_venda_item_create.Params.ParamByName('VENDA_ID').DataType:= ftString;
          fdq_venda_item_create.Params.ParamByName('ITEM_ID').DataType:= ftString;
          fdq_venda_item_create.Params.ParamByName('UNITARIO').DataType:= ftExtended;
          fdq_venda_item_create.Params.ParamByName('QTDE').DataType:= ftExtended;
          fdq_venda_item_create.Params.ParamByName('SUBTOTAL').DataType:= ftExtended;
          fdq_venda_item_create.Params.ParamByName('ACRESCIMO').DataType:= ftExtended;
          fdq_venda_item_create.Params.ParamByName('DESCONTO').DataType:= ftExtended;
          fdq_venda_item_create.Params.ParamByName('TOTAL').DataType:= ftExtended;
          fdq_venda_item_create.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
          fdq_venda_item_create.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
          fdq_venda_item_create.Prepare();
          for J:= 0 to Pred(vMovimento.Vendas.Items[I].Itens.Count) do
          begin
            fdq_venda_item_create.Params.ParamByName('ID').AsString:= vMovimento.Vendas.Items[I].Itens.Items[J].Id;
            fdq_venda_item_create.Params.ParamByName('EMPRESA_ID').AsString:= vMovimento.Vendas.Items[I].Itens.Items[J].EmpresaId;
            fdq_venda_item_create.Params.ParamByName('USER_ID').AsString:= vMovimento.Vendas.Items[I].Itens.Items[J].UserId;
            fdq_venda_item_create.Params.ParamByName('VENDA_ID').AsString:= vMovimento.Vendas.Items[I].Itens.Items[J].VendaId;
            fdq_venda_item_create.Params.ParamByName('ITEM_ID').AsString:= vMovimento.Vendas.Items[I].Itens.Items[J].ItemId;
            fdq_venda_item_create.Params.ParamByName('UNITARIO').AsExtended:= vMovimento.Vendas.Items[I].Itens.Items[J].Unitario;
            fdq_venda_item_create.Params.ParamByName('QTDE').AsExtended:= vMovimento.Vendas.Items[I].Itens.Items[J].Qtde;
            fdq_venda_item_create.Params.ParamByName('SUBTOTAL').AsExtended:= vMovimento.Vendas.Items[I].Itens.Items[J].Subtotal;
            fdq_venda_item_create.Params.ParamByName('ACRESCIMO').AsExtended:= vMovimento.Vendas.Items[I].Itens.Items[J].Acrescimo;
            fdq_venda_item_create.Params.ParamByName('DESCONTO').AsExtended:= vMovimento.Vendas.Items[I].Itens.Items[J].Desconto;
            fdq_venda_item_create.Params.ParamByName('TOTAL').AsExtended:= vMovimento.Vendas.Items[I].Itens.Items[J].Total;
            fdq_venda_item_create.Params.ParamByName('CREATED_AT').AsDateTime:= vMovimento.Vendas.Items[I].Itens.Items[J].CreatedAt;
            fdq_venda_item_create.Params.ParamByName('UPDATED_AT').AsDateTime:= vMovimento.Vendas.Items[I].Itens.Items[J].UpdatedAt;
            fdq_venda_item_create.ExecSQL();
          end;

          fdq_venda_recebimento_create.Close();
          fdq_venda_recebimento_create.Params.ParamByName('ID').DataType:= ftString;
          fdq_venda_recebimento_create.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
          fdq_venda_recebimento_create.Params.ParamByName('VENDA_ID').DataType:= ftString;
          fdq_venda_recebimento_create.Params.ParamByName('TPAG').DataType:= ftString;
          fdq_venda_recebimento_create.Params.ParamByName('RECEBIDO').DataType:= ftExtended;
          fdq_venda_recebimento_create.Params.ParamByName('TROCO').DataType:= ftExtended;
          fdq_venda_recebimento_create.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
          fdq_venda_recebimento_create.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
          fdq_venda_recebimento_create.Prepare();
          for J:= 0 to Pred(vMovimento.Vendas.Items[I].Recebimentos.Count) do
          begin
            fdq_venda_recebimento_create.Params.ParamByName('ID').AsString:= vMovimento.Vendas.Items[I].Recebimentos[J].Id;
            fdq_venda_recebimento_create.Params.ParamByName('EMPRESA_ID').AsString:= vMovimento.Vendas.Items[I].Recebimentos[J].EmpresaId;
            fdq_venda_recebimento_create.Params.ParamByName('VENDA_ID').AsString:= vMovimento.Vendas.Items[I].Recebimentos[J].VendaId;
            fdq_venda_recebimento_create.Params.ParamByName('TPAG').AsString:= vMovimento.Vendas.Items[I].Recebimentos[J].Tpag;
            fdq_venda_recebimento_create.Params.ParamByName('RECEBIDO').AsExtended:= vMovimento.Vendas.Items[I].Recebimentos[J].Recebido;
            fdq_venda_recebimento_create.Params.ParamByName('TROCO').AsExtended:= vMovimento.Vendas.Items[I].Recebimentos[J].Troco;
            fdq_venda_recebimento_create.Params.ParamByName('CREATED_AT').AsDateTime:= vMovimento.Vendas.Items[I].Recebimentos[J].CreatedAt;
            fdq_venda_recebimento_create.Params.ParamByName('UPDATED_AT').AsDateTime:= vMovimento.Vendas.Items[I].Recebimentos[J].UpdatedAt;
            fdq_venda_recebimento_create.ExecSQL();
          end;

          fdq_recebimento_create.Close();
          fdq_recebimento_create.Params.ParamByName('ID').DataType:= ftString;
          fdq_recebimento_create.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
          fdq_recebimento_create.Params.ParamByName('CONTA_ID').DataType:= ftString;
          fdq_recebimento_create.Params.ParamByName('PESSOA_ID').DataType:= ftString;
          fdq_recebimento_create.Params.ParamByName('CATEGORIA_ID').DataType:= ftString;
          fdq_recebimento_create.Params.ParamByName('VENDA_ID').DataType:= ftString;
          fdq_recebimento_create.Params.ParamByName('CARTAO_ID').DataType:= ftString;
          fdq_recebimento_create.Params.ParamByName('MODALIDADE').DataType:= ftString;
          fdq_recebimento_create.Params.ParamByName('PARCELA').DataType:= ftInteger;
          fdq_recebimento_create.Params.ParamByName('QTDE_PARCELAS').DataType:= ftInteger;
          fdq_recebimento_create.Params.ParamByName('REFERENCIA').DataType:= ftInteger;
          fdq_recebimento_create.Params.ParamByName('DESCRICAO').DataType:= ftString;
          fdq_recebimento_create.Params.ParamByName('COMPETENCIA').DataType:= ftDate;
          fdq_recebimento_create.Params.ParamByName('VALOR').DataType:= ftExtended;
          fdq_recebimento_create.Params.ParamByName('DESCONTOS_TAXAS').DataType:= ftExtended;
          fdq_recebimento_create.Params.ParamByName('JUROS_MULTA').DataType:= ftExtended;
          fdq_recebimento_create.Params.ParamByName('VALOR_RECEBIDO').DataType:= ftExtended;
          fdq_recebimento_create.Params.ParamByName('VENCIMENTO').DataType:= ftDate;
          fdq_recebimento_create.Params.ParamByName('RECEBIMENTO').DataType:= ftDate;
          fdq_recebimento_create.Params.ParamByName('SITUACAO').DataType:= ftString;
          fdq_recebimento_create.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
          fdq_recebimento_create.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
          fdq_recebimento_create.Prepare();
          for J:= 0 to Pred(vMovimento.Vendas.Items[I].ContaReceber.Count) do
          begin
            fdq_recebimento_create.Params.ParamByName('ID').AsString:= vMovimento.Vendas.Items[I].ContaReceber.Items[J].Id;
            fdq_recebimento_create.Params.ParamByName('EMPRESA_ID').AsString:= vMovimento.Vendas.Items[I].ContaReceber.Items[J].EmpresaId;
            fdq_recebimento_create.Params.ParamByName('CONTA_ID').AsString:= vMovimento.Vendas.Items[I].ContaReceber.Items[J].ContaId;
            fdq_recebimento_create.Params.ParamByName('PESSOA_ID').AsString:= vMovimento.Vendas.Items[I].ContaReceber.Items[J].PessoaId;
            fdq_recebimento_create.Params.ParamByName('CATEGORIA_ID').AsString:= vMovimento.Vendas.Items[I].ContaReceber.Items[J].CategoriaId;
            fdq_recebimento_create.Params.ParamByName('VENDA_ID').AsString:= vMovimento.Vendas.Items[I].ContaReceber.Items[J].VendaId;
            if (vMovimento.Vendas.Items[I].ContaReceber.Items[J].CartaoId <> EmptyStr) then
            fdq_recebimento_create.Params.ParamByName('CARTAO_ID').AsString:= vMovimento.Vendas.Items[I].ContaReceber.Items[J].CartaoId;
            if (vMovimento.Vendas.Items[I].ContaReceber.Items[J].Modalidade <> EmptyStr) then
            fdq_recebimento_create.Params.ParamByName('MODALIDADE').AsString:= vMovimento.Vendas.Items[I].ContaReceber.Items[J].Modalidade;
            if (vMovimento.Vendas.Items[I].ContaReceber.Items[J].Parcela >= 1) then
            fdq_recebimento_create.Params.ParamByName('PARCELA').AsInteger:= vMovimento.Vendas.Items[I].ContaReceber.Items[J].Parcela;
            if (vMovimento.Vendas.Items[I].ContaReceber.Items[J].QtdeParcelas >= 1) then
            fdq_recebimento_create.Params.ParamByName('QTDE_PARCELAS').AsInteger:= vMovimento.Vendas.Items[I].ContaReceber.Items[J].QtdeParcelas;
            fdq_recebimento_create.Params.ParamByName('REFERENCIA').AsInteger:= vMovimento.Vendas.Items[I].ContaReceber.Items[J].Referencia;
            fdq_recebimento_create.Params.ParamByName('DESCRICAO').AsString:= vMovimento.Vendas.Items[I].ContaReceber.Items[J].Descricao;
            fdq_recebimento_create.Params.ParamByName('COMPETENCIA').AsDate:= vMovimento.Vendas.Items[I].ContaReceber.Items[J].Competencia;
            fdq_recebimento_create.Params.ParamByName('VALOR').AsExtended:= vMovimento.Vendas.Items[I].ContaReceber.Items[J].Valor;
            fdq_recebimento_create.Params.ParamByName('DESCONTOS_TAXAS').AsExtended:= vMovimento.Vendas.Items[I].ContaReceber.Items[J].DescontosTaxas;
            fdq_recebimento_create.Params.ParamByName('JUROS_MULTA').AsExtended:= vMovimento.Vendas.Items[I].ContaReceber.Items[J].JurosMulta;
            fdq_recebimento_create.Params.ParamByName('VALOR_RECEBIDO').AsExtended:= vMovimento.Vendas.Items[I].ContaReceber.Items[J].ValorRecebido;
            fdq_recebimento_create.Params.ParamByName('VENCIMENTO').AsDate:= vMovimento.Vendas.Items[I].ContaReceber.Items[J].Vencimento;
            if (vMovimento.Vendas.Items[I].ContaReceber.Items[J].Situacao = 'F') then
            fdq_recebimento_create.Params.ParamByName('RECEBIMENTO').AsDate:= vMovimento.Vendas.Items[I].ContaReceber.Items[J].Recebimento;
            fdq_recebimento_create.Params.ParamByName('SITUACAO').AsString:= vMovimento.Vendas.Items[I].ContaReceber.Items[J].Situacao;
            fdq_recebimento_create.Params.ParamByName('CREATED_AT').AsDateTime:= vMovimento.Vendas.Items[I].ContaReceber.Items[J].CreatedAt;
            fdq_recebimento_create.Params.ParamByName('UPDATED_AT').AsDateTime:= vMovimento.Vendas.Items[I].ContaReceber.Items[J].UpdatedAt;
            fdq_recebimento_create.ExecSQL();
          end;
        end;

        fdq_movimento_fechamento_create.Close();
        fdq_movimento_fechamento_create.Params.ParamByName('ID').DataType:= ftString;
        fdq_movimento_fechamento_create.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
        fdq_movimento_fechamento_create.Params.ParamByName('MOVIMENTO_ID').DataType:= ftString;
        fdq_movimento_fechamento_create.Params.ParamByName('TPAG').DataType:= ftString;
        fdq_movimento_fechamento_create.Params.ParamByName('DECLARADO').DataType:= ftExtended;
        fdq_movimento_fechamento_create.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
        fdq_movimento_fechamento_create.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
        fdq_movimento_fechamento_create.Prepare();
        for I:= 0 to Pred(vMovimento.Fechamentos.Count) do
        begin
          fdq_movimento_fechamento_create.Params.ParamByName('ID').AsString:= vMovimento.Fechamentos.Items[I].Id;
          fdq_movimento_fechamento_create.Params.ParamByName('EMPRESA_ID').AsString:= vMovimento.Fechamentos.Items[I].EmpresaId;
          fdq_movimento_fechamento_create.Params.ParamByName('MOVIMENTO_ID').AsString:= vMovimento.Fechamentos.Items[I].MovimentoId;
          fdq_movimento_fechamento_create.Params.ParamByName('TPAG').AsString:= vMovimento.Fechamentos.Items[I].Tpag;
          fdq_movimento_fechamento_create.Params.ParamByName('DECLARADO').AsExtended:= vMovimento.Fechamentos.Items[I].Declarado;
          fdq_movimento_fechamento_create.Params.ParamByName('CREATED_AT').AsDateTime:= vMovimento.Fechamentos.Items[I].CreatedAt;
          fdq_movimento_fechamento_create.Params.ParamByName('UPDATED_AT').AsDateTime:= vMovimento.Fechamentos.Items[I].UpdatedAt;
          fdq_movimento_fechamento_create.ExecSQL();
        end;

        {$REGION 'NFC-e'}
        fdq_nfe_create.Close();
        fdq_nfe_create.Params.ParamByName('ID').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('PARTICIPANTE_ID').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('OPERACAO_FISCAL_ID').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('CUF').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('CNF').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('NATOP').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('INDPAG').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('MODELO').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('SERIE').DataType:= ftInteger;
        fdq_nfe_create.Params.ParamByName('NNF').DataType:= ftInteger;
        fdq_nfe_create.Params.ParamByName('DEMI').DataType:= ftDate;
        fdq_nfe_create.Params.ParamByName('TPNF').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('TPNF_WT').DataType:= ftInteger;
        fdq_nfe_create.Params.ParamByName('IDDEST').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('CMUNFG').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('TPIMP').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('TPEMIS').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('CDV').DataType:= ftInteger;
        fdq_nfe_create.Params.ParamByName('TPAMB').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('FINNFE').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('INDFINAL').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('INDPRES').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('PROCEMI').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('DHCONT').DataType:= ftDate;
        fdq_nfe_create.Params.ParamByName('XJUST').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('CHNFE').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('NPROT').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('CSTAT').DataType:= ftInteger;
        fdq_nfe_create.Params.ParamByName('XML').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('NFERECEBIDA').DataType:= ftInteger;
        fdq_nfe_create.Params.ParamByName('NUNLOTE').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('AUTO_CALCULO').DataType:= ftString;
        fdq_nfe_create.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
        fdq_nfe_create.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
        fdq_nfe_create.Prepare();

        for I:= 0 to Pred(vMovimento.Notas.Count) do
        begin
          fdq_nfe_create.Params.ParamByName('DHCONT').Value:= Null;
          fdq_nfe_create.Params.ParamByName('XJUST').Value:= Null;
          fdq_nfe_create.Params.ParamByName('NPROT').Value:= Null;

          fdq_nfe_create.Params.ParamByName('ID').AsString:= vMovimento.Notas.Items[I].Id;
          fdq_nfe_create.Params.ParamByName('EMPRESA_ID').AsString:= vMovimento.Notas.Items[I].EmpresaId;
          fdq_nfe_create.Params.ParamByName('PARTICIPANTE_ID').AsString:= vMovimento.Notas.Items[I].ParticipanteId;
          fdq_nfe_create.Params.ParamByName('OPERACAO_FISCAL_ID').AsString:= vMovimento.Notas.Items[I].OperacaoFiscalId;
          fdq_nfe_create.Params.ParamByName('CUF').AsString:= vMovimento.Notas.Items[I].Cuf;
          fdq_nfe_create.Params.ParamByName('CNF').AsString:= vMovimento.Notas.Items[I].Cnf;
          fdq_nfe_create.Params.ParamByName('NATOP').AsString:= vMovimento.Notas.Items[I].Natop;
          fdq_nfe_create.Params.ParamByName('INDPAG').AsString:= vMovimento.Notas.Items[I].Indpag;
          fdq_nfe_create.Params.ParamByName('MODELO').AsString:= vMovimento.Notas.Items[I].Modelo;
          fdq_nfe_create.Params.ParamByName('SERIE').AsInteger:= vMovimento.Notas.Items[I].Serie;
          fdq_nfe_create.Params.ParamByName('NNF').AsInteger:= vMovimento.Notas.Items[I].Nnf;
          fdq_nfe_create.Params.ParamByName('DEMI').AsDate:= vMovimento.Notas.Items[I].Demi;
          fdq_nfe_create.Params.ParamByName('TPNF').AsString:= vMovimento.Notas.Items[I].Tpnf;
          fdq_nfe_create.Params.ParamByName('TPNF_WT').AsInteger:= vMovimento.Notas.Items[I].TpnfWt;
          fdq_nfe_create.Params.ParamByName('IDDEST').AsString:= vMovimento.Notas.Items[I].Iddest;
          fdq_nfe_create.Params.ParamByName('CMUNFG').AsString:= vMovimento.Notas.Items[I].Cmunfg;
          fdq_nfe_create.Params.ParamByName('TPIMP').AsString:= vMovimento.Notas.Items[I].Tpimp;
          fdq_nfe_create.Params.ParamByName('TPEMIS').AsString:= vMovimento.Notas.Items[I].Tpemis;
          fdq_nfe_create.Params.ParamByName('CDV').AsInteger:= vMovimento.Notas.Items[I].Cdv;
          fdq_nfe_create.Params.ParamByName('TPAMB').AsString:= vMovimento.Notas.Items[I].Tpamb;
          fdq_nfe_create.Params.ParamByName('FINNFE').AsString:= vMovimento.Notas.Items[I].Finnfe;
          fdq_nfe_create.Params.ParamByName('INDFINAL').AsString:= vMovimento.Notas.Items[I].Indfinal;
          fdq_nfe_create.Params.ParamByName('INDPRES').AsString:= vMovimento.Notas.Items[I].Indpres;
          fdq_nfe_create.Params.ParamByName('PROCEMI').AsString:= vMovimento.Notas.Items[I].Procemi;

          if (vMovimento.Notas.Items[I].Tpemis = '9') then
          begin
            fdq_nfe_create.Params.ParamByName('DHCONT').AsDate:= vMovimento.Notas.Items[I].Dhcont;
            fdq_nfe_create.Params.ParamByName('XJUST').AsString:= vMovimento.Notas.Items[I].Xjust;
          end;

          fdq_nfe_create.Params.ParamByName('CHNFE').AsString:= vMovimento.Notas.Items[I].Chnfe;

          if (vMovimento.Notas.Items[I].Nprot <> EmptyStr) then
            fdq_nfe_create.Params.ParamByName('NPROT').AsString:= vMovimento.Notas.Items[I].Nprot;

          fdq_nfe_create.Params.ParamByName('CSTAT').AsInteger:= vMovimento.Notas.Items[I].Cstat;
          fdq_nfe_create.Params.ParamByName('XML').AsString:= TNfe.consultaXML(vMovimento.Notas.Items[I].Id);
          fdq_nfe_create.Params.ParamByName('NFERECEBIDA').AsInteger:= vMovimento.Notas.Items[I].Nferecebida;
          fdq_nfe_create.Params.ParamByName('NUNLOTE').AsString:= vMovimento.Notas.Items[I].Nunlote;
          fdq_nfe_create.Params.ParamByName('AUTO_CALCULO').AsString:= vMovimento.Notas.Items[I].AutoCalculo;
          fdq_nfe_create.Params.ParamByName('CREATED_AT').AsDateTime:= vMovimento.Notas.Items[I].CreatedAt;
          fdq_nfe_create.Params.ParamByName('UPDATED_AT').AsDateTime:= vMovimento.Notas.Items[I].UpdatedAt;
          fdq_nfe_create.ExecSQL();

          {$REGION 'Det'}
          fdq_nfe_det_create.Close();
          fdq_nfe_det_create.Params.ParamByName('ID').DataType:= ftString;
          fdq_nfe_det_create.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
          fdq_nfe_det_create.Params.ParamByName('NFE_ID').DataType:= ftString;
          fdq_nfe_det_create.Params.ParamByName('ITEM_ID').DataType:= ftString;
          fdq_nfe_det_create.Params.ParamByName('CPROD').DataType:= ftString;
          fdq_nfe_det_create.Params.ParamByName('NITEM').DataType:= ftInteger;
          fdq_nfe_det_create.Params.ParamByName('CEAN').DataType:= ftString;
          fdq_nfe_det_create.Params.ParamByName('XPROD').DataType:= ftString;
          fdq_nfe_det_create.Params.ParamByName('NCM').DataType:= ftString;
          fdq_nfe_det_create.Params.ParamByName('EXTIPI').DataType:= ftString;
          fdq_nfe_det_create.Params.ParamByName('CFOP').DataType:= ftString;
          fdq_nfe_det_create.Params.ParamByName('UCOM').DataType:= ftString;
          fdq_nfe_det_create.Params.ParamByName('QCOM').DataType:= ftExtended;
          fdq_nfe_det_create.Params.ParamByName('VUNCOM').DataType:= ftExtended;
          fdq_nfe_det_create.Params.ParamByName('VPROD').DataType:= ftExtended;
          fdq_nfe_det_create.Params.ParamByName('CEANTRIB').DataType:= ftString;
          fdq_nfe_det_create.Params.ParamByName('UTRIB').DataType:= ftString;
          fdq_nfe_det_create.Params.ParamByName('QTRIB').DataType:= ftExtended;
          fdq_nfe_det_create.Params.ParamByName('VUNTRIB').DataType:= ftExtended;
          fdq_nfe_det_create.Params.ParamByName('VFRETE').DataType:= ftExtended;
          fdq_nfe_det_create.Params.ParamByName('VSEG').DataType:= ftExtended;
          fdq_nfe_det_create.Params.ParamByName('VDESC').DataType:= ftExtended;
          fdq_nfe_det_create.Params.ParamByName('VOUTRO').DataType:= ftExtended;
          fdq_nfe_det_create.Params.ParamByName('INDTOT').DataType:= ftString;
          fdq_nfe_det_create.Params.ParamByName('XPED').DataType:= ftString;
          fdq_nfe_det_create.Params.ParamByName('NITEMPED').DataType:= ftString;
          fdq_nfe_det_create.Params.ParamByName('NRECOPI').DataType:= ftString;
          fdq_nfe_det_create.Params.ParamByName('NFCI').DataType:= ftString;
          fdq_nfe_det_create.Params.ParamByName('CEST').DataType:= ftString;
          fdq_nfe_det_create.Params.ParamByName('VTOTTRIB').DataType:= ftExtended;
          fdq_nfe_det_create.Params.ParamByName('PDEVOL').DataType:= ftExtended;
          fdq_nfe_det_create.Params.ParamByName('VIPIDEVOL').DataType:= ftExtended;
          fdq_nfe_det_create.Params.ParamByName('INFADPROD').DataType:= ftString;
          fdq_nfe_det_create.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
          fdq_nfe_det_create.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
          fdq_nfe_det_create.Prepare();

          for J:= 0 to Pred(vMovimento.Notas.Items[I].Det.Count) do
          begin
            fdq_nfe_det_create.Params.ParamByName('EXTIPI').Value:= Null;
            fdq_nfe_det_create.Params.ParamByName('XPED').Value:= Null;
            fdq_nfe_det_create.Params.ParamByName('NITEMPED').Value:= Null;
            fdq_nfe_det_create.Params.ParamByName('NRECOPI').Value:= Null;
            fdq_nfe_det_create.Params.ParamByName('NFCI').Value:= Null;
            fdq_nfe_det_create.Params.ParamByName('INFADPROD').Value:= Null;

            fdq_nfe_det_create.Params.ParamByName('ID').AsString:= vMovimento.Notas.Items[I].Det.Items[J].Id;
            fdq_nfe_det_create.Params.ParamByName('EMPRESA_ID').AsString:= vMovimento.Notas.Items[I].Det.Items[J].EmpresaId;
            fdq_nfe_det_create.Params.ParamByName('NFE_ID').AsString:= vMovimento.Notas.Items[I].Det.Items[J].NfeId;
            fdq_nfe_det_create.Params.ParamByName('ITEM_ID').AsString:= vMovimento.Notas.Items[I].Det.Items[J].ItemId;
            fdq_nfe_det_create.Params.ParamByName('CPROD').AsString:= vMovimento.Notas.Items[I].Det.Items[J].Cprod;
            fdq_nfe_det_create.Params.ParamByName('NITEM').AsInteger:= vMovimento.Notas.Items[I].Det.Items[J].Nitem;
            fdq_nfe_det_create.Params.ParamByName('CEAN').AsString:= vMovimento.Notas.Items[I].Det.Items[J].Cean;
            fdq_nfe_det_create.Params.ParamByName('XPROD').AsString:= vMovimento.Notas.Items[I].Det.Items[J].Xprod;
            fdq_nfe_det_create.Params.ParamByName('NCM').AsString:= vMovimento.Notas.Items[I].Det.Items[J].Ncm;
            if (vMovimento.Notas.Items[I].Det.Items[J].Extipi <> EmptyStr) then
            fdq_nfe_det_create.Params.ParamByName('EXTIPI').AsString:= vMovimento.Notas.Items[I].Det.Items[J].Extipi;
            fdq_nfe_det_create.Params.ParamByName('CFOP').AsString:= vMovimento.Notas.Items[I].Det.Items[J].Cfop;
            fdq_nfe_det_create.Params.ParamByName('UCOM').AsString:= vMovimento.Notas.Items[I].Det.Items[J].Ucom;
            fdq_nfe_det_create.Params.ParamByName('QCOM').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].Qcom;
            fdq_nfe_det_create.Params.ParamByName('VUNCOM').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].Vuncom;
            fdq_nfe_det_create.Params.ParamByName('VPROD').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].Vprod;
            fdq_nfe_det_create.Params.ParamByName('CEANTRIB').AsString:= vMovimento.Notas.Items[I].Det.Items[J].Ceantrib;
            fdq_nfe_det_create.Params.ParamByName('UTRIB').AsString:= vMovimento.Notas.Items[I].Det.Items[J].Utrib;
            fdq_nfe_det_create.Params.ParamByName('QTRIB').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].Qtrib;
            fdq_nfe_det_create.Params.ParamByName('VUNTRIB').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].Vuntrib;
            fdq_nfe_det_create.Params.ParamByName('VFRETE').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].Vfrete;
            fdq_nfe_det_create.Params.ParamByName('VSEG').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].Vseg;
            fdq_nfe_det_create.Params.ParamByName('VDESC').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].Vdesc;
            fdq_nfe_det_create.Params.ParamByName('VOUTRO').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].Voutro;
            fdq_nfe_det_create.Params.ParamByName('INDTOT').AsString:= vMovimento.Notas.Items[I].Det.Items[J].Indtot;
            if (vMovimento.Notas.Items[I].Det.Items[J].Xped <> EmptyStr) then
            fdq_nfe_det_create.Params.ParamByName('XPED').AsString:= vMovimento.Notas.Items[I].Det.Items[J].Xped;
            if (vMovimento.Notas.Items[I].Det.Items[J].Nitemped <> EmptyStr) then
            fdq_nfe_det_create.Params.ParamByName('NITEMPED').AsString:= vMovimento.Notas.Items[I].Det.Items[J].Nitemped;
            if (vMovimento.Notas.Items[I].Det.Items[J].Nrecopi <> EmptyStr) then
            fdq_nfe_det_create.Params.ParamByName('NRECOPI').AsString:= vMovimento.Notas.Items[I].Det.Items[J].Nrecopi;
            if (vMovimento.Notas.Items[I].Det.Items[J].Nfci <> EmptyStr) then
            fdq_nfe_det_create.Params.ParamByName('NFCI').AsString:= vMovimento.Notas.Items[I].Det.Items[J].Nfci;
            fdq_nfe_det_create.Params.ParamByName('CEST').AsString:= vMovimento.Notas.Items[I].Det.Items[J].Cest;
            fdq_nfe_det_create.Params.ParamByName('VTOTTRIB').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].Vtottrib;
            fdq_nfe_det_create.Params.ParamByName('PDEVOL').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].Pdevol;
            fdq_nfe_det_create.Params.ParamByName('VIPIDEVOL').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].Vipidevol;
            if (vMovimento.Notas.Items[I].Det.Items[J].Infadprod <> EmptyStr) then
            fdq_nfe_det_create.Params.ParamByName('INFADPROD').AsString:= vMovimento.Notas.Items[I].Det.Items[J].Infadprod;
            fdq_nfe_det_create.Params.ParamByName('CREATED_AT').AsDateTime:= vMovimento.Notas.Items[I].Det.Items[J].CreatedAt;
            fdq_nfe_det_create.Params.ParamByName('UPDATED_AT').AsDateTime:= vMovimento.Notas.Items[I].Det.Items[J].UpdatedAt;
            fdq_nfe_det_create.ExecSQL();

            fdq_nfe_det_icms_create.Close();
            fdq_nfe_det_icms_create.Params.ParamByName('ID').DataType:= ftString;
            fdq_nfe_det_icms_create.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
            fdq_nfe_det_icms_create.Params.ParamByName('NFE_DET_ID').DataType:= ftString;
            fdq_nfe_det_icms_create.Params.ParamByName('ORIG').DataType:= ftString;
            fdq_nfe_det_icms_create.Params.ParamByName('CST').DataType:= ftString;
            fdq_nfe_det_icms_create.Params.ParamByName('CSOSN').DataType:= ftString;
            fdq_nfe_det_icms_create.Params.ParamByName('MODBC').DataType:= ftString;
            fdq_nfe_det_icms_create.Params.ParamByName('PREDBC').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('VBC').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('PICMS').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('VICMS').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('MODBCST').DataType:= ftString;
            fdq_nfe_det_icms_create.Params.ParamByName('PMVAST').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('PREDBCST').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('VBCST').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('PICMSST').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('VICMSST').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('UFST').DataType:= ftString;
            fdq_nfe_det_icms_create.Params.ParamByName('PBCOP').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('VBCSTRET').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('VICMSSTRET').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('MOTDESICMS').DataType:= ftString;
            fdq_nfe_det_icms_create.Params.ParamByName('PCREDSN').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('VCREDICMSSN').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('VBCSTDEST').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('VICMSSTDEST').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('VICMSDESON').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('VICMSOP').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('PDIF').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('VICMSDIF').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('VBCFCP').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('PFCP').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('VFCP').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('VBCFCPST').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('PFCPST').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('VFCPST').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('VBCFCPSTRET').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('PFCPSTRET').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('VFCPSTRET').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('PST').DataType:= ftExtended;
            fdq_nfe_det_icms_create.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
            fdq_nfe_det_icms_create.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
            fdq_nfe_det_icms_create.Prepare();

            fdq_nfe_det_icms_create.Params.ParamByName('MODBC').Value:= Null;
            fdq_nfe_det_icms_create.Params.ParamByName('MODBCST').Value:= Null;
            fdq_nfe_det_icms_create.Params.ParamByName('UFST').Value:= Null;
            fdq_nfe_det_icms_create.Params.ParamByName('MOTDESICMS').Value:= Null;

            fdq_nfe_det_icms_create.Params.ParamByName('ID').AsString:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Id;
            fdq_nfe_det_icms_create.Params.ParamByName('EMPRESA_ID').AsString:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.EmpresaId;
            fdq_nfe_det_icms_create.Params.ParamByName('NFE_DET_ID').AsString:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.NfeDetId;
            fdq_nfe_det_icms_create.Params.ParamByName('ORIG').AsString:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Orig;
            fdq_nfe_det_icms_create.Params.ParamByName('CST').AsString:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Cst;
            fdq_nfe_det_icms_create.Params.ParamByName('CSOSN').AsString:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Csosn;
            if (vMovimento.Notas.Items[I].Det.Items[J].ICMS.Modbc <> EmptyStr) then
              fdq_nfe_det_icms_create.Params.ParamByName('MODBC').AsString:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Modbc;
            fdq_nfe_det_icms_create.Params.ParamByName('PREDBC').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Predbc;
            fdq_nfe_det_icms_create.Params.ParamByName('VBC').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Vbc;
            fdq_nfe_det_icms_create.Params.ParamByName('PICMS').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Picms;
            fdq_nfe_det_icms_create.Params.ParamByName('VICMS').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Vicms;
            if (vMovimento.Notas.Items[I].Det.Items[J].ICMS.Modbcst <> EmptyStr) then
              fdq_nfe_det_icms_create.Params.ParamByName('MODBCST').AsString:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Modbcst;
            fdq_nfe_det_icms_create.Params.ParamByName('PMVAST').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Pmvast;
            fdq_nfe_det_icms_create.Params.ParamByName('PREDBCST').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Predbcst;
            fdq_nfe_det_icms_create.Params.ParamByName('VBCST').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Vbcst;
            fdq_nfe_det_icms_create.Params.ParamByName('PICMSST').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Picmsst;
            fdq_nfe_det_icms_create.Params.ParamByName('VICMSST').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Vicmsst;
            if (vMovimento.Notas.Items[I].Det.Items[J].ICMS.Ufst <> EmptyStr) then
              fdq_nfe_det_icms_create.Params.ParamByName('UFST').AsString:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Ufst;
            fdq_nfe_det_icms_create.Params.ParamByName('PBCOP').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Pbcop;
            fdq_nfe_det_icms_create.Params.ParamByName('VBCSTRET').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Vbcstret;
            fdq_nfe_det_icms_create.Params.ParamByName('VICMSSTRET').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Vicmsstret;
            if (vMovimento.Notas.Items[I].Det.Items[J].ICMS.Motdesicms <> EmptyStr) then
              fdq_nfe_det_icms_create.Params.ParamByName('MOTDESICMS').AsString:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Motdesicms;
            fdq_nfe_det_icms_create.Params.ParamByName('PCREDSN').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Pcredsn;
            fdq_nfe_det_icms_create.Params.ParamByName('VCREDICMSSN').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Vcredicmssn;
            fdq_nfe_det_icms_create.Params.ParamByName('VBCSTDEST').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Vbcstdest;
            fdq_nfe_det_icms_create.Params.ParamByName('VICMSSTDEST').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Vicmsstdest;
            fdq_nfe_det_icms_create.Params.ParamByName('VICMSDESON').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Vicmsdeson;
            fdq_nfe_det_icms_create.Params.ParamByName('VICMSOP').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Vicmsop;
            fdq_nfe_det_icms_create.Params.ParamByName('PDIF').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Pdif;
            fdq_nfe_det_icms_create.Params.ParamByName('VICMSDIF').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Vicmsdif;
            fdq_nfe_det_icms_create.Params.ParamByName('VBCFCP').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Vbcfcp;
            fdq_nfe_det_icms_create.Params.ParamByName('PFCP').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Pfcp;
            fdq_nfe_det_icms_create.Params.ParamByName('VFCP').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Vfcp;
            fdq_nfe_det_icms_create.Params.ParamByName('VBCFCPST').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Vbcfcpst;
            fdq_nfe_det_icms_create.Params.ParamByName('PFCPST').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Pfcpst;
            fdq_nfe_det_icms_create.Params.ParamByName('VFCPST').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Vfcpst;
            fdq_nfe_det_icms_create.Params.ParamByName('VBCFCPSTRET').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Vbcfcpstret;
            fdq_nfe_det_icms_create.Params.ParamByName('PFCPSTRET').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Pfcpstret;
            fdq_nfe_det_icms_create.Params.ParamByName('VFCPSTRET').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Vfcpstret;
            fdq_nfe_det_icms_create.Params.ParamByName('PST').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.Pst;
            fdq_nfe_det_icms_create.Params.ParamByName('CREATED_AT').AsDateTime:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.CreatedAt;
            fdq_nfe_det_icms_create.Params.ParamByName('UPDATED_AT').AsDateTime:= vMovimento.Notas.Items[I].Det.Items[J].ICMS.UpdatedAt;
            fdq_nfe_det_icms_create.ExecSQL();

            {$REGION 'Det IPI'}
            fdq_nfe_det_ipi_create.Close();
            fdq_nfe_det_ipi_create.Params.ParamByName('ID').DataType:= ftString;
            fdq_nfe_det_ipi_create.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
            fdq_nfe_det_ipi_create.Params.ParamByName('NFE_DET_ID').DataType:= ftString;
            fdq_nfe_det_ipi_create.Params.ParamByName('CLENQ').DataType:= ftString;
            fdq_nfe_det_ipi_create.Params.ParamByName('CNPJPROD').DataType:= ftString;
            fdq_nfe_det_ipi_create.Params.ParamByName('CSELO').DataType:= ftString;
            fdq_nfe_det_ipi_create.Params.ParamByName('QSELO').DataType:= ftInteger;
            fdq_nfe_det_ipi_create.Params.ParamByName('CENQ').DataType:= ftString;
            fdq_nfe_det_ipi_create.Params.ParamByName('CST').DataType:= ftString;
            fdq_nfe_det_ipi_create.Params.ParamByName('VBC').DataType:= ftExtended;
            fdq_nfe_det_ipi_create.Params.ParamByName('QUNID').DataType:= ftExtended;
            fdq_nfe_det_ipi_create.Params.ParamByName('VUNID').DataType:= ftExtended;
            fdq_nfe_det_ipi_create.Params.ParamByName('PIPI').DataType:= ftExtended;
            fdq_nfe_det_ipi_create.Params.ParamByName('VIPI').DataType:= ftExtended;
            fdq_nfe_det_ipi_create.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
            fdq_nfe_det_ipi_create.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
            fdq_nfe_det_ipi_create.Prepare();

            fdq_nfe_det_ipi_create.Params.ParamByName('CLENQ').Value:= Null;
            fdq_nfe_det_ipi_create.Params.ParamByName('CNPJPROD').Value:= Null;
            fdq_nfe_det_ipi_create.Params.ParamByName('CSELO').Value:= Null;
            fdq_nfe_det_ipi_create.Params.ParamByName('QSELO').Value:= Null;
            fdq_nfe_det_ipi_create.Params.ParamByName('CENQ').Value:= Null;
            fdq_nfe_det_ipi_create.Params.ParamByName('CST').Value:= Null;

            fdq_nfe_det_ipi_create.Params.ParamByName('ID').AsString:= vMovimento.Notas.Items[I].Det.Items[J].IPI.Id;
            fdq_nfe_det_ipi_create.Params.ParamByName('EMPRESA_ID').AsString:= vMovimento.Notas.Items[I].Det.Items[J].IPI.EmpresaId;
            fdq_nfe_det_ipi_create.Params.ParamByName('NFE_DET_ID').AsString:= vMovimento.Notas.Items[I].Det.Items[J].IPI.NfeDetId;
            if (vMovimento.Notas.Items[I].Det.Items[J].IPI.Clenq <> EmptyStr) then
              fdq_nfe_det_ipi_create.Params.ParamByName('CLENQ').AsString:= vMovimento.Notas.Items[I].Det.Items[J].IPI.Clenq;
            if (vMovimento.Notas.Items[I].Det.Items[J].IPI.Cnpjprod <> EmptyStr) then
              fdq_nfe_det_ipi_create.Params.ParamByName('CNPJPROD').AsString:= vMovimento.Notas.Items[I].Det.Items[J].IPI.Cnpjprod;
            if (vMovimento.Notas.Items[I].Det.Items[J].IPI.Cselo <> EmptyStr) then
              fdq_nfe_det_ipi_create.Params.ParamByName('CSELO').AsString:= vMovimento.Notas.Items[I].Det.Items[J].IPI.Cselo;
            if (vMovimento.Notas.Items[I].Det.Items[J].IPI.Qselo > 0) then
              fdq_nfe_det_ipi_create.Params.ParamByName('QSELO').AsInteger:= vMovimento.Notas.Items[I].Det.Items[J].IPI.Qselo;
            if (vMovimento.Notas.Items[I].Det.Items[J].IPI.Cenq <> EmptyStr) then
              fdq_nfe_det_ipi_create.Params.ParamByName('CENQ').AsString:= vMovimento.Notas.Items[I].Det.Items[J].IPI.Cenq;
            if (vMovimento.Notas.Items[I].Det.Items[J].IPI.Cst <> EmptyStr) then
              fdq_nfe_det_ipi_create.Params.ParamByName('CST').AsString:= vMovimento.Notas.Items[I].Det.Items[J].IPI.Cst;
            fdq_nfe_det_ipi_create.Params.ParamByName('VBC').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].IPI.Vbc;
            fdq_nfe_det_ipi_create.Params.ParamByName('QUNID').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].IPI.Qunid;
            fdq_nfe_det_ipi_create.Params.ParamByName('VUNID').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].IPI.Vunid;
            fdq_nfe_det_ipi_create.Params.ParamByName('PIPI').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].IPI.Pipi;
            fdq_nfe_det_ipi_create.Params.ParamByName('VIPI').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].IPI.Vipi;
            fdq_nfe_det_ipi_create.Params.ParamByName('CREATED_AT').AsDateTime:= vMovimento.Notas.Items[I].Det.Items[J].IPI.CreatedAt;
            fdq_nfe_det_ipi_create.Params.ParamByName('UPDATED_AT').AsDateTime:= vMovimento.Notas.Items[I].Det.Items[J].IPI.UpdatedAt;
            fdq_nfe_det_ipi_create.ExecSQL();
            {$ENDREGION}

            {$REGION 'Det PIS'}
            fdq_nfe_det_pis_create.Close();
            fdq_nfe_det_pis_create.Params.ParamByName('ID').DataType:= ftString;
            fdq_nfe_det_pis_create.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
            fdq_nfe_det_pis_create.Params.ParamByName('NFE_DET_ID').DataType:= ftString;
            fdq_nfe_det_pis_create.Params.ParamByName('CST').DataType:= ftString;
            fdq_nfe_det_pis_create.Params.ParamByName('VBC').DataType:= ftExtended;
            fdq_nfe_det_pis_create.Params.ParamByName('PPIS').DataType:= ftExtended;
            fdq_nfe_det_pis_create.Params.ParamByName('QBCPROD').DataType:= ftExtended;
            fdq_nfe_det_pis_create.Params.ParamByName('VALIQPROD').DataType:= ftExtended;
            fdq_nfe_det_pis_create.Params.ParamByName('VPIS').DataType:= ftExtended;
            fdq_nfe_det_pis_create.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
            fdq_nfe_det_pis_create.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
            fdq_nfe_det_pis_create.Prepare();

            fdq_nfe_det_pis_create.Params.ParamByName('CST').Value:= Null;

            fdq_nfe_det_pis_create.Params.ParamByName('ID').AsString:= vMovimento.Notas.Items[I].Det.Items[J].PIS.Id;
            fdq_nfe_det_pis_create.Params.ParamByName('EMPRESA_ID').AsString:= vMovimento.Notas.Items[I].Det.Items[J].PIS.EmpresaId;
            fdq_nfe_det_pis_create.Params.ParamByName('NFE_DET_ID').AsString:= vMovimento.Notas.Items[I].Det.Items[J].PIS.NfeDetId;
            if (vMovimento.Notas.Items[I].Det.Items[J].PIS.Cst <> EmptyStr) then
              fdq_nfe_det_pis_create.Params.ParamByName('CST').AsString:= vMovimento.Notas.Items[I].Det.Items[J].PIS.Cst;
            fdq_nfe_det_pis_create.Params.ParamByName('VBC').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].PIS.Vbc;
            fdq_nfe_det_pis_create.Params.ParamByName('PPIS').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].PIS.Ppis;
            fdq_nfe_det_pis_create.Params.ParamByName('QBCPROD').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].PIS.Qbcprod;
            fdq_nfe_det_pis_create.Params.ParamByName('VALIQPROD').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].PIS.Valiqprod;
            fdq_nfe_det_pis_create.Params.ParamByName('VPIS').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].PIS.Vpis;
            fdq_nfe_det_pis_create.Params.ParamByName('CREATED_AT').AsDateTime:= vMovimento.Notas.Items[I].Det.Items[J].PIS.CreatedAt;
            fdq_nfe_det_pis_create.Params.ParamByName('UPDATED_AT').AsDateTime:= vMovimento.Notas.Items[I].Det.Items[J].PIS.UpdatedAt;
            fdq_nfe_det_pis_create.ExecSQL();
            {$ENDREGION}

            {$REGION 'Det COFINS'}
            fdq_nfe_det_cofins.Close();
            fdq_nfe_det_cofins.Params.ParamByName('ID').DataType:= ftString;
            fdq_nfe_det_cofins.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
            fdq_nfe_det_cofins.Params.ParamByName('NFE_DET_ID').DataType:= ftString;
            fdq_nfe_det_cofins.Params.ParamByName('CST').DataType:= ftString;
            fdq_nfe_det_cofins.Params.ParamByName('VBC').DataType:= ftExtended;
            fdq_nfe_det_cofins.Params.ParamByName('PCOFINS').DataType:= ftExtended;
            fdq_nfe_det_cofins.Params.ParamByName('QBCPROD').DataType:= ftExtended;
            fdq_nfe_det_cofins.Params.ParamByName('VBCPROD').DataType:= ftExtended;
            fdq_nfe_det_cofins.Params.ParamByName('VALIQPROD').DataType:= ftExtended;
            fdq_nfe_det_cofins.Params.ParamByName('VCOFINS').DataType:= ftExtended;
            fdq_nfe_det_cofins.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
            fdq_nfe_det_cofins.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
            fdq_nfe_det_cofins.Prepare();

            fdq_nfe_det_cofins.Params.ParamByName('CST').Value:= Null;

            fdq_nfe_det_cofins.Params.ParamByName('ID').AsString:= vMovimento.Notas.Items[I].Det.Items[J].COFINS.Id;
            fdq_nfe_det_cofins.Params.ParamByName('EMPRESA_ID').AsString:= vMovimento.Notas.Items[I].Det.Items[J].COFINS.EmpresaId;
            fdq_nfe_det_cofins.Params.ParamByName('NFE_DET_ID').AsString:= vMovimento.Notas.Items[I].Det.Items[J].COFINS.NfeDetId;
            if (vMovimento.Notas.Items[I].Det.Items[J].COFINS.Cst <> EmptyStr) then
              fdq_nfe_det_cofins.Params.ParamByName('CST').AsString:= vMovimento.Notas.Items[I].Det.Items[J].COFINS.Cst;
            fdq_nfe_det_cofins.Params.ParamByName('VBC').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].COFINS.Vbc;
            fdq_nfe_det_cofins.Params.ParamByName('PCOFINS').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].COFINS.Pcofins;
            fdq_nfe_det_cofins.Params.ParamByName('QBCPROD').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].COFINS.Qbcprod;
            fdq_nfe_det_cofins.Params.ParamByName('VBCPROD').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].COFINS.Vbcprod;
            fdq_nfe_det_cofins.Params.ParamByName('VALIQPROD').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].COFINS.Valiqprod;
            fdq_nfe_det_cofins.Params.ParamByName('VCOFINS').AsExtended:= vMovimento.Notas.Items[I].Det.Items[J].COFINS.Vcofins;
            fdq_nfe_det_cofins.Params.ParamByName('CREATED_AT').AsDateTime:= vMovimento.Notas.Items[I].Det.Items[J].COFINS.CreatedAt;
            fdq_nfe_det_cofins.Params.ParamByName('UPDATED_AT').AsDateTime:= vMovimento.Notas.Items[I].Det.Items[J].COFINS.UpdatedAt;
            fdq_nfe_det_cofins.ExecSQL();
            {$ENDREGION}
          end;
          {$ENDREGION}

          {$REGION 'Pag'}
          fdq_nfe_pag_create.Close();
          fdq_nfe_pag_create.Params.ParamByName('ID').DataType:= ftString;
          fdq_nfe_pag_create.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
          fdq_nfe_pag_create.Params.ParamByName('NFE_ID').DataType:= ftString;
          fdq_nfe_pag_create.Params.ParamByName('TPAG').DataType:= ftString;
          fdq_nfe_pag_create.Params.ParamByName('VPAG').DataType:= ftExtended;
          fdq_nfe_pag_create.Params.ParamByName('TPINTEGRA').DataType:= ftString;
          fdq_nfe_pag_create.Params.ParamByName('CNPJ').DataType:= ftString;
          fdq_nfe_pag_create.Params.ParamByName('TBAND').DataType:= ftString;
          fdq_nfe_pag_create.Params.ParamByName('CAUT').DataType:= ftString;
          fdq_nfe_pag_create.Params.ParamByName('VTROCO').DataType:= ftExtended;
          fdq_nfe_pag_create.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
          fdq_nfe_pag_create.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
          fdq_nfe_pag_create.Prepare();

          for J:= 0 to Pred(vMovimento.Notas.Items[I].Pag.Count) do
          begin
            fdq_nfe_pag_create.Params.ParamByName('CNPJ').Value:= Null;
            fdq_nfe_pag_create.Params.ParamByName('TBAND').Value:= Null;
            fdq_nfe_pag_create.Params.ParamByName('CAUT').Value:= Null;

            fdq_nfe_pag_create.Params.ParamByName('ID').AsString:= vMovimento.Notas.Items[I].Pag.Items[J].Id;
            fdq_nfe_pag_create.Params.ParamByName('EMPRESA_ID').AsString:= vMovimento.Notas.Items[I].Pag.Items[J].EmpresaId;
            fdq_nfe_pag_create.Params.ParamByName('NFE_ID').AsString:= vMovimento.Notas.Items[I].Pag.Items[J].NfeId;
            fdq_nfe_pag_create.Params.ParamByName('TPAG').AsString:= vMovimento.Notas.Items[I].Pag.Items[J].Tpag;
            fdq_nfe_pag_create.Params.ParamByName('VPAG').AsExtended:= vMovimento.Notas.Items[I].Pag.Items[J].Vpag;
            fdq_nfe_pag_create.Params.ParamByName('TPINTEGRA').AsString:= vMovimento.Notas.Items[I].Pag.Items[J].Tpintegra;
            if (vMovimento.Notas.Items[I].Pag.Items[J].Cnpj <> EmptyStr) then
            fdq_nfe_pag_create.Params.ParamByName('CNPJ').AsString:= vMovimento.Notas.Items[I].Pag.Items[J].Cnpj;
            if (vMovimento.Notas.Items[I].Pag.Items[J].Tband <> EmptyStr) then
            fdq_nfe_pag_create.Params.ParamByName('TBAND').AsString:= vMovimento.Notas.Items[I].Pag.Items[J].Tband;
            if (vMovimento.Notas.Items[I].Pag.Items[J].Caut <> EmptyStr) then
            fdq_nfe_pag_create.Params.ParamByName('CAUT').AsString:= vMovimento.Notas.Items[I].Pag.Items[J].Caut;
            fdq_nfe_pag_create.Params.ParamByName('VTROCO').AsExtended:= vMovimento.Notas.Items[I].Pag.Items[J].Vtroco;
            fdq_nfe_pag_create.Params.ParamByName('CREATED_AT').AsDateTime:= vMovimento.Notas.Items[I].Pag.Items[J].CreatedAt;
            fdq_nfe_pag_create.Params.ParamByName('UPDATED_AT').AsDateTime:= vMovimento.Notas.Items[I].Pag.Items[J].UpdatedAt;
            fdq_nfe_pag_create.ExecSQL();
          end;
          {$ENDREGION}

          {$REGION 'ICMSTot'}
          fdq_nfe_total_icms_create.Close();
          fdq_nfe_total_icms_create.Params.ParamByName('ID').DataType:= ftString;
          fdq_nfe_total_icms_create.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
          fdq_nfe_total_icms_create.Params.ParamByName('NFE_ID').DataType:= ftString;
          fdq_nfe_total_icms_create.Params.ParamByName('VBC').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('VICMS').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('VICMSDESON').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('VFCPUFDEST').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('VICMSUFDEST').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('VICMSUFREMET').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('VFCP').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('VBCST').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('VST').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('VFCPST').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('VFCPSTRET').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('VPROD').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('VFRETE').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('VSEG').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('VDESC').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('VII').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('VIPI').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('VIPIDEVOL').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('VPIS').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('VCOFINS').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('VOUTRO').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('VNF').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('VTOTTRIB').DataType:= ftExtended;
          fdq_nfe_total_icms_create.Params.ParamByName('CREATED_AT').DataType:= ftDateTime;
          fdq_nfe_total_icms_create.Params.ParamByName('UPDATED_AT').DataType:= ftDateTime;
          fdq_nfe_total_icms_create.Prepare();

          fdq_nfe_total_icms_create.Params.ParamByName('ID').AsString:= vMovimento.Notas.Items[I].ICMSTot.Id;
          fdq_nfe_total_icms_create.Params.ParamByName('EMPRESA_ID').AsString:= vMovimento.Notas.Items[I].ICMSTot.EmpresaId;
          fdq_nfe_total_icms_create.Params.ParamByName('NFE_ID').AsString:= vMovimento.Notas.Items[I].ICMSTot.NfeId;
          fdq_nfe_total_icms_create.Params.ParamByName('VBC').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Vbc;
          fdq_nfe_total_icms_create.Params.ParamByName('VICMS').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Vicms;
          fdq_nfe_total_icms_create.Params.ParamByName('VICMSDESON').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Vicmsdeson;
          fdq_nfe_total_icms_create.Params.ParamByName('VFCPUFDEST').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Vfcpufdest;
          fdq_nfe_total_icms_create.Params.ParamByName('VICMSUFDEST').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Vicmsufdest;
          fdq_nfe_total_icms_create.Params.ParamByName('VICMSUFREMET').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Vicmsufremet;
          fdq_nfe_total_icms_create.Params.ParamByName('VFCP').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Vfcp;
          fdq_nfe_total_icms_create.Params.ParamByName('VBCST').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Vbcst;
          fdq_nfe_total_icms_create.Params.ParamByName('VST').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Vst;
          fdq_nfe_total_icms_create.Params.ParamByName('VFCPST').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Vfcpst;
          fdq_nfe_total_icms_create.Params.ParamByName('VFCPSTRET').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Vfcpstret;
          fdq_nfe_total_icms_create.Params.ParamByName('VPROD').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Vprod;
          fdq_nfe_total_icms_create.Params.ParamByName('VFRETE').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Vfrete;
          fdq_nfe_total_icms_create.Params.ParamByName('VSEG').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Vseg;
          fdq_nfe_total_icms_create.Params.ParamByName('VDESC').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Vdesc;
          fdq_nfe_total_icms_create.Params.ParamByName('VII').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Vii;
          fdq_nfe_total_icms_create.Params.ParamByName('VIPI').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Vipi;
          fdq_nfe_total_icms_create.Params.ParamByName('VIPIDEVOL').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Vipidevol;
          fdq_nfe_total_icms_create.Params.ParamByName('VPIS').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Vpis;
          fdq_nfe_total_icms_create.Params.ParamByName('VCOFINS').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Vcofins;
          fdq_nfe_total_icms_create.Params.ParamByName('VOUTRO').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Voutro;
          fdq_nfe_total_icms_create.Params.ParamByName('VNF').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Vnf;
          fdq_nfe_total_icms_create.Params.ParamByName('VTOTTRIB').AsExtended:= vMovimento.Notas.Items[I].ICMSTot.Vtottrib;
          fdq_nfe_total_icms_create.Params.ParamByName('CREATED_AT').AsDateTime:= vMovimento.Notas.Items[I].ICMSTot.CreatedAt;
          fdq_nfe_total_icms_create.Params.ParamByName('UPDATED_AT').AsDateTime:= vMovimento.Notas.Items[I].ICMSTot.UpdatedAt;
          fdq_nfe_total_icms_create.ExecSQL();
          {$ENDREGION}

          if (vMovimento.Notas.Items[I].vendaId <> '') then
          begin
            fdq_nfe_venda_create.Close();
            fdq_nfe_venda_create.ParamByName('NFE_ID').DataType:= ftString;
            fdq_nfe_venda_create.ParamByName('VENDA_ID').DataType:= ftString;
            fdq_nfe_venda_create.Prepare();
            fdq_nfe_venda_create.ParamByName('NFE_ID').AsString:= vMovimento.Notas.Items[I].Id;
            fdq_nfe_venda_create.ParamByName('VENDA_ID').AsString:= vMovimento.Notas.Items[I].vendaId;
            fdq_nfe_venda_create.ExecSQL();
          end;
        end;
        {$ENDREGION}

        vMovimento.sincronizado();
        fdc_server.Commit();
        THelper.Mensagem('Sincronizado com sucesso.');

        list(Trim(lbe_search.Text));
      end;
    except
      on e: Exception do
      begin
        dmServidor.fdc_server.Rollback();
        THelper.Mensagem('Falha ao sincronizar. Erro ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(vMovimento);
  end;
end;

procedure TformMovimentoList.dbg_movimentosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
  TDBGrid(Sender).Canvas.Font.Style:= [];
  TDBGrid(Sender).Canvas.Font.Color:= clBlack;

  if (gdSelected in State) then
  begin
    TDBGrid(Sender).Canvas.Font.Style:= [fsBold];
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFCF9F;
  end;

  if not Odd(TDBGrid(Sender).DataSource.DataSet.RecNo) then
  begin
    if not (gdSelected in State) then
    begin
      TDBGrid(Sender).Canvas.Brush.Color:= $00E2E2E2;
      TDBGrid(Sender).Canvas.FillRect(Rect);
      TDBGrid(Sender).DefaultDrawDataCell(Rect,Column.Field,State);
    end;
  end;

  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].Field, State);
end;

procedure TformMovimentoList.FormCreate(Sender: TObject);
begin
  inherited;
  list('');
end;

procedure TformMovimentoList.lbe_searchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    13: list(Trim(lbe_search.Text));
    38: begin
      fdmt_movimentos.Prior;
      Key:= 35;
    end;
    40: begin
      fdmt_movimentos.Next;
      Key:= 35;
    end;
  end;
end;

procedure TformMovimentoList.list(pReferencia: string);
var
  vReferencia: Integer;
begin
  vReferencia:= StrToIntDef(pReferencia, 0);
  TMovimento.listByTerminal(vReferencia, fdmt_movimentos);
end;

procedure TformMovimentoList.tmr_focusTimer(Sender: TObject);
begin
  try
    if not lbe_search.Focused then lbe_search.SetFocus;
  except
    TTimer(Sender).Enabled:= True;
  end;
end;

end.
