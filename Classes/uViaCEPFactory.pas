unit uViaCEPFactory;

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
