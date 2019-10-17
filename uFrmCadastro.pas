unit uFrmCadastro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, Mask, DBCtrls, ExtCtrls, RxMemDS, ACBrBase, ACBrSocket,
  ACBrCEP, XMLDoc, XMLIntf, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, IdMessageClient, IdSMTP, IdMessage, IdSSLOpenSSL, Tabs,
  DockTabSet;

type
  TFrmCadastro = class(TForm)
    jvm1: TRxMemoryData;
    jvm1Nome: TStringField;
    jvm1Identidade: TStringField;
    jvm1CPF: TStringField;
    jvm1Email: TStringField;
    jvm1CEP: TStringField;
    jvm1Logradouro: TStringField;
    jvm1Numero: TIntegerField;
    jvm1Complemento: TStringField;
    jvm1Bairro: TStringField;
    jvm1Cidade: TStringField;
    jvm1Estado: TStringField;
    jvm1Pais: TStringField;
    pnl1: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    dbedtNome: TMaskEdit;
    dbedtIdentidade: TMaskEdit;
    dbedtCPF: TMaskEdit;
    dbedtEmail: TMaskEdit;
    grp1: TGroupBox;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    dbedtBairro: TMaskEdit;
    dbedtCEP: TMaskEdit;
    dbedtCidade: TMaskEdit;
    dbedtComplemento: TMaskEdit;
    dbedtEstado: TMaskEdit;
    dbedtLogradouro: TMaskEdit;
    dbedtNumero: TMaskEdit;
    dbedtPais: TMaskEdit;
    btnSalvar: TButton;
    btnEnvio: TButton;
    procedure dbedtCEPExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnEnvioClick(Sender: TObject);
  private
    function ValidaCampo: Boolean;
    procedure LimpaCampos;
    procedure EnviaEmail;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadastro: TFrmCadastro;

implementation

uses uLibAux, uEndereco;

{$R *.dfm}

procedure TFrmCadastro.LimpaCampos;
var
  j: Integer;
  oCampo: TComponent;
begin
  for j := 0 to ComponentCount -1 do
  begin
    if (Components[j] is TMaskEdit) then
    begin
      oCampo := FindComponent((Components[j] as TMaskEdit).Name);
      (oCampo as TMaskEdit).Clear;
    end;
  end;
end;

function TFrmCadastro.ValidaCampo: Boolean;
var
  j: Integer;
  oCampo: TComponent;
  sValue: string;
begin

  Result := True;
  for j := 0 to ComponentCount -1 do
  begin
    if (Components[j] is TMaskEdit) then
    begin
      oCampo := FindComponent((Components[j] as TMaskEdit).Name);
      sValue := Trim((oCampo as TMaskEdit).Text);
      if ((sValue = EmptyStr) and (StrToIntDef(sValue, 0) = 0)) or
         ((sValue = '_____-___') or (sValue = '___.___.___-__')) then
      begin
        ShowMessage('Valor inválido para o campo: ' + Copy((oCampo as TMaskEdit).Name, 6, Length((oCampo as TMaskEdit).Name)));
        (oCampo as TMaskEdit).SetFocus;
        Result := False;
        Break;
      end;
    end;
  end;
end;

procedure TFrmCadastro.btnEnvioClick(Sender: TObject);
var
  XMLDocument: TXMLDocument;
  NodeTbl,
  NodeRegistro: IXMLNode;
  I: Integer;
begin
  XMLDocument := TXMLDocument.Create(Self);
  try
    XMLDocument.Active := True;
    NodeTbl := XMLDocument.AddChild('Cadastro');
    jvm1.First;
    while not jvm1.Eof do
    begin
      NodeRegistro := NodeTbl.AddChild('Informacoes');
      for I := 1 To 11 do
      begin
        NodeRegistro.ChildValues[Copy(jvm1.Fields[i].Name, 5, Length(jvm1.Fields[i].Name))] := jvm1.Fields[i].Value;
      end;
      jvm1.Next;
    end;
    XMLDocument.SaveToFile(ExtractFileDir(ParamStr(0))+'\Cadastro.xml');
    EnviaEmail;
  finally
    XMLDocument.Free;
  end;
end;

procedure TFrmCadastro.btnSalvarClick(Sender: TObject);
var
  i,j: Integer;
  oCampo: TComponent;
begin
  if not ValidaCampo then
  begin
    Exit;
  end;

  jvm1.Append;
  for I := 0  To jvm1.Fields.Count -1 do
  begin
    for j := 0 to ComponentCount -1 do
    begin
      if (Components[j] is TMaskEdit) and (jvm1.Fields[i].Tag = i + 1) then
      begin
        oCampo := (FindComponent('dbedt'+jvm1.Fields[i].FieldName));
        jvm1.Fields[i].Value := (oCampo as TMaskEdit).Text;
        Break;
      end;
    end;
  end;
  jvm1.Post;
  LimpaCampos;
  dbedtNome.SetFocus;
end;

procedure TFrmCadastro.dbedtCEPExit(Sender: TObject);
var
  sCEP: string;
  _rEndereco: TEndereco;
begin
  //valida se esta diferente de vazio
  if (Trim(dbedtCEP.Text) <> EmptyStr) then
  begin
    sCEP := getnumero(dbedtCEP.Text);
    //valida se o tamanho esta correto sem os caracteres
    //especiais
    if (Length(sCEP) <> 8) then
    begin
      ShowMessage('CEP inválido.');
      dbedtCEP.SetFocus;
      Exit;
    end;

    _rEndereco := TEndereco.Create(sCEP);
    try
      dbedtLogradouro.Text  := _rEndereco.Logradouro;
      dbedtCidade.Text      := _rEndereco.localidade;
      dbedtComplemento.Text := _rEndereco.complemento;
      dbedtEstado.Text      := _rEndereco.uf;
    finally
      _rEndereco.Free;
    end;

  end;
end;

procedure TFrmCadastro.EnviaEmail;
var
  IdSSLIOHandlerSocket: TIdSSLIOHandlerSocket;
  IdSMTP: TIdSMTP;
  IdMessage: TIdMessage;
  CaminhoAnexo: string;
begin
  IdSSLIOHandlerSocket := TIdSSLIOHandlerSocket.Create(Self);
  IdSMTP := TIdSMTP.Create(Self);
  IdMessage := TIdMessage.Create(Self);

  try
    IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
    IdSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;

    IdSMTP.IOHandler := IdSSLIOHandlerSocket;
    IdSMTP.AuthenticationType := atLogin;
    IdSMTP.Port := 465;
    IdSMTP.Host := 'smtp.gmail.com';
    IdSMTP.Username := 'usuario';
    IdSMTP.Password := 'password';

    try
      IdSMTP.Connect;
      IdSMTP.Authenticate;
    except
      on E:Exception do
      begin
        MessageDlg('Erro na conexão e/ou autenticação: ' +
                    E.Message, mtWarning, [mbOK], 0);
        Exit;
      end;
    end;

    IdMessage.From.Address := 'send@gmail.com';
    IdMessage.From.Name := 'Meu Nome';
    IdMessage.ReplyTo.EMailAddresses := IdMessage.From.Address;
    IdMessage.Recipients.EMailAddresses := 'send@hotmail.com';
    IdMessage.Subject := 'Assunto do e-mail';
    IdMessage.Body.Text := 'Corpo do e-mail';

    CaminhoAnexo := ExtractFileDir(ParamStr(0))+'\Cadastro.xml';
    if FileExists(CaminhoAnexo) then
      TIdAttachment.Create(IdMessage.MessageParts, CaminhoAnexo);

    try
      IdSMTP.Send(IdMessage);
      MessageDlg('Mensagem enviada com sucesso.', mtInformation, [mbOK], 0);
    except
      On E:Exception do
        MessageDlg('Erro ao enviar a mensagem: ' + E.Message, mtWarning, [mbOK], 0);
    end;
  finally
    FreeAndNil(IdMessage);
    FreeAndNil(IdSSLIOHandlerSocket);
    FreeAndNil(IdSMTP);
  end;
end;

procedure TFrmCadastro.FormShow(Sender: TObject);
begin
  jvm1.Open;
  jvm1.Append;
end;

end.
