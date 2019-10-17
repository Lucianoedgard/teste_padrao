unit uEndereco;

interface

uses
  SysUtils, xmldom, XMLIntf, XMLDoc, msxmldom;

type
  TEndereco = class (TObject)
  strict private
    Fcep : string;
    Flogradouro : string;
    Fcomplemento : string;
    Fbairro : string;
    Flocalidade : string;
    Fuf : string;
    Funidade : string;
    Fibge : string;
    Fgia : string;

  private
    procedure proLocalizaCep;
  public
    constructor Create(const Cep: string); overload;
    property cep : string read Fcep;
    property logradouro : string read Flogradouro;
    property complemento : string read Fcomplemento;
    property bairro : string read Fbairro;
    property localidade : string read Flocalidade;
    property uf : string read Fuf;
    property unidade : string read Funidade;
    property ibge : string read Fibge;
    property gia : string read Fgia;
  end;

implementation

{ TEndereco }

constructor TEndereco.Create(const Cep: string);
begin
  FCep := Cep;
  proLocalizaCep;
end;

procedure TEndereco.proLocalizaCep;
resourcestring
  __rINFORME_NR_CEP = 'Informe o número do cep.';
  __rCEP_INVALIDO = 'O número do CEP deve ser composto por 8 bytes.';
  __rCEP_NAO_ENCONTRADO = 'Cep não encontrado.';
const
  _rcep = 'cep';
  _rlogradouro = 'logradouro';
  _rcomplemento = 'complemento';
  _rbairro = 'bairro';
  _rlocalidade = 'localidade';
  _ruf = 'uf';
  _runidade = 'unidade';
  _ribge = 'ibge';
  _rgia = 'gia';
  _rWS = 'https://viacep.com.br/ws/';
  _rXML = '/xml/';
  _rERRO = 'erro';
  _rTrue = 'true';
var
  _rDXML: IXMLDocument;
begin
  FCep := StringReplace(Cep, '-', '', [rfReplaceAll]);
  if Cep = EmptyStr then
    raise Exception.Create(__rINFORME_NR_CEP);

  if Length(Cep) <> 8 then
    raise Exception.Create(__rCEP_INVALIDO);


  _rDXML := TXMLDocument.Create(nil);
  try
    _rDXML.FileName := _rWS + Cep + _rXML;
    _rDXML.Active := True;
    { Quando consultado um CEP de formato válido, porém inexistente, }
    { por exemplo: "99999999", o retorno conterá um valor de "erro"  }
    { igual a "true". Isso significa que o CEP consultado não foi    }
    { encontrado na base de dados. https://viacep.com.br/            }

    if _rDXML.DocumentElement.ChildValues[0] = _rTrue then
      raise Exception.Create(__rCEP_NAO_ENCONTRADO);

    FCep := _rDXML.DocumentElement.ChildNodes[_rCep].Text;
    flogradouro := _rDXML.DocumentElement.ChildNodes[_rlogradouro].Text;
    fcomplemento := _rDXML.DocumentElement.ChildNodes[_rcomplemento].Text;
    fbairro := _rDXML.DocumentElement.ChildNodes[_rbairro].Text;
    flocalidade := _rDXML.DocumentElement.ChildNodes[_rlocalidade].Text;
    fuf := _rDXML.DocumentElement.ChildNodes[_ruf].Text;
    funidade := _rDXML.DocumentElement.ChildNodes[_runidade].Text;
    fibge := _rDXML.DocumentElement.ChildNodes[_ribge].Text;
    fgia := _rDXML.DocumentElement.ChildNodes[_rgia].Text;
  finally
    _rDXML := nil;
  end;
end;

end.
