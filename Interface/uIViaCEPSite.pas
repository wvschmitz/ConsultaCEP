unit uIViaCEPSite;

interface

uses
  uIDadosPesquisa;

type
  IViaCEPSite = interface
    ['{F9582308-B3B4-49FF-9DBC-8B12BAE521AA}']

    function SetDadosPesquisa(AcDadosPesquisa : String): IViaCEPSite;
    function Consultar: String;
  end;

implementation

end.
