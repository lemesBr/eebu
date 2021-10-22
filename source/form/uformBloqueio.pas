unit uformBloqueio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uformBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  User, System.StrUtils, System.DateUtils, System.Actions, Vcl.ActnList,
  IPPeerClient, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  Winapi.ShellAPI, Vcl.Imaging.pngimage;

type
  TformBloqueio = class(TformBase)
    pnl_principal: TPanel;
    bvl_1: TBevel;
    bvl_2: TBevel;
    pnl_header: TPanel;
    pnl_footer: TPanel;
    pnl_body: TPanel;
    lbe_documento: TLabeledEdit;
    lbe_chave: TLabeledEdit;
    btn_rollback: TButton;
    btn_confirmar: TButton;
    act_bloqueio: TActionList;
    act_rollback: TAction;
    act_continuar: TAction;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    act_consulta: TAction;
    btn_consulta: TButton;
    act_contratar: TAction;
    btn_pagamento: TButton;
    pnl_anual: TPanel;
    rdb_anual: TRadioButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    pnl_trimestral: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    rdb_trimestral: TRadioButton;
    pnl_mensal: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    rdb_mensal: TRadioButton;
    Bevel1: TBevel;
    RESTCliTeste: TRESTClient;
    RESTReqTeste: TRESTRequest;
    RESTRespTeste: TRESTResponse;
    pnl_teste: TPanel;
    rdb_teste: TRadioButton;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Image1: TImage;
    Label5: TLabel;
    Image2: TImage;
    Image3: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure act_rollbackExecute(Sender: TObject);
    procedure act_continuarExecute(Sender: TObject);
    procedure act_consultaExecute(Sender: TObject);
    procedure act_contratarExecute(Sender: TObject);
    procedure rdb_anualClick(Sender: TObject);
    procedure act_bloqueioUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
    vUser: TUser;
    procedure testewt();
  public
    { Public declarations }
  end;

var
  formBloqueio: TformBloqueio;

implementation

uses
  AuthService, Helper, Wt, udmRepository;

{$R *.dfm}

procedure TformBloqueio.act_rollbackExecute(Sender: TObject);
begin
  lbe_chave.SetFocus;
  if THelper.Mensagem('Deseja realmente sair?', 1) then
    Close;
end;

procedure TformBloqueio.act_continuarExecute(Sender: TObject);
begin
  lbe_chave.SetFocus;
  try
    if TWt.setKey(lbe_chave.Text) then
    begin
      THelper.Mensagem('Nova licença inserida com sucesso.');
      Close;
    end;
  except on e: exception do
    THelper.Mensagem(e.Message);
  end;
end;

procedure TformBloqueio.act_bloqueioUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  act_continuar.Enabled:= (Trim(lbe_chave.Text).Length = 32);
end;

procedure TformBloqueio.act_consultaExecute(Sender: TObject);
begin
  lbe_chave.SetFocus;
  try
    RESTRequest.Params.ParameterByName('documento').Value:= vUser.Empresa.Documento;
    RESTRequest.Execute;
    lbe_chave.Text:= RESTResponse.JSONValue.GetValue('key','');
    if (Trim(lbe_chave.Text) = EmptyStr) then
    begin
      THelper.Mensagem('Chave inexistente ou expirada. ' +
        'É necessário efetuar o pagamento para gerar uma nova chave de acesso!');
    end;
  except on e: exception do
    begin
      lbe_chave.Text:= '';
      THelper.Mensagem('Não foi possivel consultar uma chave, ' +
        'verifique sua conexão com a internet. Caso o problema continue, ' +
        'entre em contato com o suporte!');
    end;
  end;
end;

procedure TformBloqueio.act_contratarExecute(Sender: TObject);
begin
  lbe_chave.SetFocus;
  if rdb_anual.Checked then
    ShellExecute(Handle, 'OPEN', 'https://pay.hotmart.com/I7182180F?off=cnyu3lcl', nil, nil, SW_SHOWNORMAL)
  else if rdb_trimestral.Checked then
    ShellExecute(Handle, 'OPEN', 'https://pay.hotmart.com/I7182180F?off=z7l14h9w', nil, nil, SW_SHOWNORMAL)
  else if rdb_mensal.Checked then
    ShellExecute(Handle, 'OPEN', 'https://pay.hotmart.com/I7182180F?off=86wpt551', nil, nil, SW_SHOWNORMAL)
  else if rdb_teste.Checked then
    testewt();
end;

procedure TformBloqueio.FormCreate(Sender: TObject);
begin
  inherited;
  vUser:= TUser.find(TAuthService.getAuthenticatedUserId);
  lbe_documento.Text:= IfThen(
    vUser.Empresa.Documento.Length = 11,
    THelper.CPFMask(vUser.Empresa.Documento),
    THelper.CNPJMask(vUser.Empresa.Documento)
    );

  if Assigned(TAuthService.License) then
  begin
    pnl_header.Caption:= 'WT - SYSTEM COM CHAVE VERIFICADA. VALIDADE ' +
      FormatDateTime('dd/mm/yyyy', TAuthService.License.Expiracao);
    pnl_header.Font.Color:= clGreen;
  end
  else
  begin
    pnl_header.Caption:= 'WT - SYSTEM COM CHAVE INEXISTENTE OU EXPIRADA';
    pnl_header.Font.Color:= clRed;
  end;
end;

procedure TformBloqueio.FormDestroy(Sender: TObject);
begin
  FreeAndNil(vUser);
end;

procedure TformBloqueio.rdb_anualClick(Sender: TObject);
begin
  pnl_anual.BevelInner:= bvNone;
  pnl_anual.BevelKind:= bkNone;
  pnl_anual.BevelOuter:= bvNone;

  pnl_trimestral.BevelInner:= bvNone;
  pnl_trimestral.BevelKind:= bkNone;
  pnl_trimestral.BevelOuter:= bvNone;

  pnl_mensal.BevelInner:= bvNone;
  pnl_mensal.BevelKind:= bkNone;
  pnl_mensal.BevelOuter:= bvNone;

  pnl_teste.BevelInner:= bvNone;
  pnl_teste.BevelKind:= bkNone;
  pnl_teste.BevelOuter:= bvNone;

  case AnsiIndexStr(TRadioButton(Sender).Name, ['rdb_anual',
                                                'rdb_trimestral',
                                                'rdb_mensal',
                                                'rdb_teste']) of
    0: begin
      pnl_anual.BevelInner:= bvLowered;
      pnl_anual.BevelKind:= bkSoft;
      pnl_anual.BevelOuter:= bvSpace;

      rdb_trimestral.Checked:= False;
      rdb_mensal.Checked:= False;
      rdb_teste.Checked:= False;
    end;
    1: begin
      pnl_trimestral.BevelInner:= bvLowered;
      pnl_trimestral.BevelKind:= bkSoft;
      pnl_trimestral.BevelOuter:= bvSpace;

      rdb_anual.Checked:= False;
      rdb_mensal.Checked:= False;
      rdb_teste.Checked:= False;
    end;
    2: begin
      pnl_mensal.BevelInner:= bvLowered;
      pnl_mensal.BevelKind:= bkSoft;
      pnl_mensal.BevelOuter:= bvSpace;

      rdb_anual.Checked:= False;
      rdb_trimestral.Checked:= False;
      rdb_teste.Checked:= False;
    end;
    3: begin
      pnl_teste.BevelInner:= bvLowered;
      pnl_teste.BevelKind:= bkSoft;
      pnl_teste.BevelOuter:= bvSpace;

      rdb_anual.Checked:= False;
      rdb_trimestral.Checked:= False;
      rdb_mensal.Checked:= False;
    end;
  end;
end;

procedure TformBloqueio.testewt;
begin
  try
    RESTReqTeste.Params.ParameterByName('documento').Value:= vUser.Empresa.Documento;
    RESTReqTeste.Execute;
    if (RESTRespTeste.JSONValue.GetValue('deferred','') = 'true') then
    begin
      lbe_chave.Text:= RESTRespTeste.JSONValue.GetValue('key','');
      act_continuarExecute(Self);
    end
    else
      THelper.Mensagem(RESTRespTeste.JSONValue.GetValue('message',''));
  except on e: exception do
  begin
    THelper.Mensagem('Não foi possivel processar seu pedido, ' +
      'verifique sua conexão com a internet. Caso o problema continue, ' +
      'entre em contato com o suporte!');
  end;
  end;
end;

end.
