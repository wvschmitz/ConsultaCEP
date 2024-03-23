unit uEnum;

interface

type

  {
    Modo de pesquisa
      - mpCEP -> Efetua a pesaquisa pelo CEP (01001000)
      - mpCompleta -> Efetua a pesquisa pelo endereço
  }
  TModoPesquisa = (mpCEP, mpCompleta);

  {
    Site para pesquisa
      - spJson -> Irá efetuar a pesquisa utilizando a URL da ViaCEP em formato Json
      - spXml -> Irá efetuar a pesquisa utilizando a URL da ViaCEP em formato Xml
  }
  TSitePesquisa = (spJson, spXml);

implementation

end.
