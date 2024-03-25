unit uViaCEPSitePadrao;

interface

{
  Classe padr�o de acesso a API da ViaCEP que disponibiliza um m�todo que ir�
  efetuar a requisi��o e devolver o retorno da API utilizando o componente
  THTTPClient nativo do Delphi.
}

uses
  System.SysUtils, uDadosPesquisa, uDadosResultado;

type
  TViaCEPPadrao = class(TInterfacedObject)
  protected
    FoDadosPesquisa : TDadosPesquisa;
    FoDadosResultado : TDadosResultado;

    function AcessarSite(AcUrl : String): String;
  public
    constructor Create; reintroduce;
  end;

implementation

uses
  System.Net.HttpClient;

{ TViaCEPPadrao }

function TViaCEPPadrao.AcessarSite(AcUrl: String): String;
var
  oHttp : THTTPClient;
  oRespose : IHTTPResponse;
begin
  oHttp := THTTPClient.Create;
  try
    oRespose := oHttp.Get(AcUrl);
    if oRespose.StatusCode = 200 then
      Result := oRespose.ContentAsString
    else
      begin
        raise Exception.Create('Ocorreu um problema ao acessar a API da ViaCEP, C�digo de retorno ' + oRespose.StatusText);
      end;
  finally
    FreeAndNil(oHttp);
  end;
end;

constructor TViaCEPPadrao.Create;
begin
  FoDadosResultado := TDadosResultado.Create;
end;

end.
