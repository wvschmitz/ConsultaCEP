unit uViaCEPFactory;

{
  Classe utilizando o conceito do Pattern Factory onde irá criar o objeto
  concreto da interface IViaCEPSite com as regras de acesso a API com formato
  JSON ou o objeto com as regras de XML.
}

interface

uses
  uIViaCEPSite, uEnum;

type

  TViaCEPFactory = class
  public
    class function ViaCEPSite(AeTipo : TSitePesquisa): IViaCEPSite;
  end;

implementation

uses
  uViaCEPSiteJson, uViaCEPSiteXml;

{ TViaCEPFactory }

class function TViaCEPFactory.ViaCEPSite(AeTipo : TSitePesquisa): IViaCEPSite;
begin
  case AeTipo of
    spJson : Result := TViaCEPSiteJson.Create;
    spXml : Result := TViaCEPSiteXml.Create;
  end;
end;

end.
