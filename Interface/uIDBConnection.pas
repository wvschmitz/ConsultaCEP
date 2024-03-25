unit uIDBConnection;

interface

uses
  FireDAC.Comp.Client, uIDBCheck;

type
  IDBConnection = interface
    ['{5B64F9D0-35DF-4292-A10A-19FB7FDF39F2}']

    function GetConnection : TFDConnection;
    function GetDataBaseCheck : IDBCheck;
  end;

implementation

end.
