unit uIDBTableViaCep;

interface

uses
  uEndereco, System.Generics.Collections, Data.DB;

type
  IDBTableViaCep = interface
    ['{7B036FE8-71E1-4607-97A2-01EABAD0E876}']

    function GetDataSet : TDataSet;
    function ConsultarCEP(AcCep: String): TList<TEndereco>;
    function ConsultarLogradouro(AcUf, AcCidade, AcLogradouro: String): TList<TEndereco>;
    procedure ConsultarTodosRegistros;
  end;

implementation

end.
