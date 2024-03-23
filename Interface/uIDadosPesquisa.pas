unit uIDadosPesquisa;

interface

uses
  uEnum;

type
  IDadosPesquisa = interface
    ['{2F292691-F791-4ED2-867E-A899A9DBF9A6}']

    procedure SetModoPesquisa(AeValue: TModoPesquisa);
    function GetModoPesquisa: TModoPesquisa;

    procedure SetCEP(AcValue: String);
    function GetCEP: String;

    procedure SetUF(AcValue: String);
    function GetUF: String;

    procedure SetCidade(AcValue: String);
    function GetCidade: String;

    procedure SetLogradouro(AcValue: String);
    function GetLogradouro: String;
  end;

implementation

end.
