# Projeto para Consulta de CEPs

Projeto desenvolvido utilizando o Delphi 11 Community Edition e integração com banco de dados MySQL 5.7.44 para consulta de CEPs utilizando a API da ViaCEP.

## Dependências

- MySQL 5.7.44
- Disponibilizado a libmysql.dll x86 na pasta **.\bin\** para acesso ao MySQL, caso seja necessária outra versão do MySQL deverá realizar a substituição da dll..

## Como executar

- Configure as definições de Host, Port, User e Pass de acesso ao banco MySQL no arquivo **.\bin\ConsultaCEP.ini**
- Abra o **.\ConsultaCEPGroup.groupproj**
- Compile e Instale o pacote **ConsultaCEPPkg** 
- Compile o projeto **ConsultaCEP**
- Execute o programa **.\bin\ConsultaCEP.exe**
- Caso não queira efetuar o Build já há o programa compilado na pasta **.\bin\ConsultaCEP.exe**

## Conceitos utilizadas

- MVC
- Orientação a Objetos
- Padrão Factory
- SOLID

## Documentação dos Fontes

### .\Componente\uEditEndereco.pas ###

Componente para validação de uma quantidade mínima de caracteres que é atribuída pela propriedade MinLength, quando não atendida a quantidade mínima de caracteres, irá apresentar a mensagem “A quantidade de caracteres informada deve ser superior a X” e não será permitido sair do mesmo até que seja informado corretamente.

### .\Componente\uEditEstados.pas ###

Componente para validar a digitação dos estados brasileiros, obrigando que seja informado um estado válido. O componente também é responsável por retornar a sigla do estado digitado pelo usuário.

### .\Componente\uMaskEditCep.pas ### 

Componente para validar a digitação de um CEP válido conforme a máscara "11111-111" definida por padrão, obrigando a digitação do CEP com caracteres numéricos e com a quantidade numérica correta.

### .\Componente\uViaCEP.pas ### 

Componente de acesso a API da ViaCEP, onde é definido pela propriedade ModoPesquisa se será utilizado a consulta via JSON ou XML.

### .\Classes\uEnum.pas ### 

Unit para centração das definições de enumeradores como:\
TModoPesquisa é a definição se irá realizar a pesquisa utilizando o CEP ou Endereço.\
TSitePesquisa é a definição se irá utilizar a API de JSON ou de XML.

###  .\Classes\uViaCEPFactory.pas ### 

Classe utilizando o conceito do Pattern Factory onde irá criar o objeto concreto da interface IViaCEPSite com as regras de acesso a API com formato JSON ou o objeto com as regras de XML.

### .\Classes\uViaCEPSitePadrao.pas ### 

Classe padrão de acesso a API da ViaCEP que disponibiliza um método que irá efetuar a requisição e devolver o retorno da API utilizando o componente THTTPClient nativo do Delphi.

### .\Classes\uViaCEPSiteJson.pas ### 

Classe com as regras da API de JSON da ViaCEP, onde irá herdar da classe TViaCEPSitePadrao e implementar os métodos da interface IViaCEPSite.

### .\Classes\uViaCEPSiteXml.pas ### 

Classe com as regras da API de XML da ViaCEP, onde irá herdar da classe TViaCEPSitePadrao e implementar os métodos da interface IViaCEPSite.

### .\Classes\uEndereco.pas ###

Classe para representar um endereço, onde irá possuir as informações como CEP, Logradouro, Complemento, Bairro, Cidade e UF.

### .\Classes\uDadosPesquisa.pas ###

Classe que irá conter as informações solicitadas para pesquisa,ela implementa as interfaces IDadosPesquisa e a ISerializavel.\
Está classe é serializada na tela e enviada em formato JSON para o componente uViaCEP, que nas classes uViaCEPSiteJson e uViaCEPSiteXml será feito a deserialização para o objeto.

### .\Classes\uDadosResultado.pas ###

Classe que irá conter os endereços retornados da API e se ocorreu um erro durante a busca, ela implementa as interfaces IDadosResultado e a ISerializavel.\
Essa classe é serializada nas classes uViaCEPSiteJson e uViaCEPSiteXml onde será usada na tela a partir do retorno do componente uViaCEP.

### .\Classes\uDBConnectionMySQL.pas ###

Classe que implementa a interface IDBConnection que é responsável por definir um acesso ao Banco de Dados MySQL, utilizando o componente FireDAC do Delphi.

### .\Classes\uDBCheckMySQL.pas ###

Classe que implementa a interface IDBCheck que é responsável por validar se o database “consultacep” e a tabela “viacep” estão criadas no banco de dados disponibilizado, caso não estejam criados ela é responsável pela criação dos mesmos.

### .\Classes\uDBTableViaCep.pas ###

Classe que implementa a interface IDBTableViaCep que possui as regras de inserção, atualização e consulta da tabela “viacep” do MySQL.

### .\Cliente\uConsultaCEPView.pas ###

Formulário padrão do projeto ConsultaCEP para entrada das informações de pesquisa e exibição dos endereços pesquisados. Esta tela possui duas páginas, a primeira “Consultar” que fica responsável por exibir todos os CEPs já pesquisados e a segunda é “Novo” responsável por pesquisar novos CEP.

### .\Cliente\uConsultaCEPController.pas ###

Classe para centralização das regras do formulário de Consulta de CEP e também responsável por chamar a classe uConsultaCEPModel para gravação de dados.

### .\Cliente\uConsultaCEPModel.pas ###

Classe para centralizar as regras de acesso ao banco de dados e utilização da classe uDBTableViaCep.

