unit uViaCEPSiteXml;

interface

uses
  System.SysUtils, Xml.XMLDoc, Xml.XMLIntf,
  uViaCEPSitePadrao, uIViaCEPSite, uIDadosPesquisa, uEndereco;

type
  TViaCEPSiteXml = class(TViaCEPPadrao, IViaCEPSite)
  private
    procedure PesquisarModoCEP;
    procedure PesquisarModoCompleto;
    function CriarEndereco(AoXml : IXMLNodeList): TEndereco;
  public
    function SetDadosPesquisa(AcDadosPesquisa : String): IViaCEPSite;
    function Consultar: String;
  end;

implementation

uses
  uDadosPesquisa, uEnum;

const
  _Url_CEP = 'https://viacep.com.br/ws/%s/xml/';
  _Url_Completa = 'https://viacep.com.br/ws/%s/%s/%s/xml/';

{ TViaCEPSiteXml }

function TViaCEPSiteXml.Consultar: String;
begin
  try
    if FoDadosPesquisa.GetModoPesquisa = mpCEP then
      PesquisarModoCEP
    else
      PesquisarModoCompleto;
  except
    on E: Exception do
      begin
        FoDadosResultado.SetErro(True);
        FoDadosResultado.SetMensagem(E.Message);
      end;
  end;

  Result := FoDadosResultado.ToJson;
end;

function TViaCEPSiteXml.CriarEndereco(AoXml: IXMLNodeList): TEndereco;
begin
  Result := TEndereco.Create;
  Result.SetCep(AoXml['cep'].Text);
  Result.SetLogradouro(AoXml['logradouro'].Text);
  Result.SetComplemento(AoXml['complemento'].Text);
  Result.SetBairro(AoXml['bairro'].Text);
  Result.SetCidade(AoXml['localidade'].Text);
  Result.SetUf(AoXml['uf'].Text);
end;

procedure TViaCEPSiteXml.PesquisarModoCEP;
var
  cRetorno : String;
  oXml : IXMLDocument;
begin
  cRetorno := AcessarSite(Format(_Url_CEP, [FoDadosPesquisa.GetCEP]));

  oXml := LoadXMLData(cRetorno);

  if oXml.DocumentElement.ChildNodes['erro'] <> nil then
    begin
      FoDadosResultado.SetErro(True);
      FoDadosResultado.SetMensagem('CEP não localizado na API!');
    end
  else
    begin
      FoDadosResultado
        .AddEndereco(CriarEndereco(oXml.DocumentElement.ChildNodes));
    end;
end;

procedure TViaCEPSiteXml.PesquisarModoCompleto;
var
  cRetorno : String;
  oXml : IXMLDocument;
  oEnderecos : IXMLNode;
  i: Integer;
begin
  cRetorno := AcessarSite(Format(_Url_Completa, [FoDadosPesquisa.GetUF, FoDadosPesquisa.GetCidade, FoDadosPesquisa.GetLogradouro]));

  oXml := LoadXMLData(cRetorno);

  //cRetorno := oXml.DocumentElement.ChildNodes[0].LocalName;
  oEnderecos := oXml.DocumentElement.ChildNodes.FindNode('enderecos');

  if oEnderecos.ChildNodes.Count = 0 then
    begin
      FoDadosResultado.SetErro(True);
      FoDadosResultado.SetMensagem('Nenhum endereço localizado!');
      Exit;
    end;

  for i := 0 to oEnderecos.ChildNodes.Count -1 do
    begin
      FoDadosResultado
        .AddEndereco(CriarEndereco(oEnderecos.ChildNodes[i].ChildNodes));
    end;
end;

function TViaCEPSiteXml.SetDadosPesquisa(AcDadosPesquisa : String): IViaCEPSite;
begin
  Result := Self;
  FoDadosPesquisa := TDadosPesquisa.FromJson(AcDadosPesquisa);
end;

end.
