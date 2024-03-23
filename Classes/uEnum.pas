unit uEnum;

interface

type

  {
    Modo de pesquisa
      - mpCEP -> Efetua a pesaquisa pelo CEP (01001000)
      - mpCompleta -> Efetua a pesquisa pelo endere�o
  }
  TModoPesquisa = (mpCEP, mpCompleta);

  {
    Site para pesquisa
      - spJson -> Ir� efetuar a pesquisa utilizando a URL da ViaCEP em formato Json
      - spXml -> Ir� efetuar a pesquisa utilizando a URL da ViaCEP em formato Xml
  }
  TSitePesquisa = (spJson, spXml);

implementation

end.
