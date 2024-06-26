unit uViaCEP;

{
  Componente de acesso a API da ViaCEP, onde � definido pela propriedade
  ModoPesquisa se ser� utilizado a consulta via JSON ou XML.
}

interface

uses
  System.SysUtils, System.Classes, uEnum;

type
  TViaCEP = class(TComponent)
  private
    FoModoPesquisa : TSitePesquisa;
  public
    function Pesquisar(AcDadosPesquisa : String) : String;
  published
    property ModoPesquisa : TSitePesquisa read FoModoPesquisa write FoModoPesquisa default spJson;
  end;

procedure Register;

implementation

uses
  uViaCEPFactory;

procedure Register;
begin
  RegisterComponents('ConsultaCEP', [TViaCEP]);
end;

{ TViaCEP }

function TViaCEP.Pesquisar(AcDadosPesquisa : String) : String;
begin
  Result := TViaCEPFactory
              .ViaCEPSite(FoModoPesquisa)
                .SetDadosPesquisa(AcDadosPesquisa)
                  .Consultar;
end;

end.
