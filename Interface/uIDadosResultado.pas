unit uIDadosResultado;

interface

uses
  uEndereco, System.Generics.Collections;

type
  IDadosResultado = interface
    ['{E4147A30-E993-4301-931B-FE72D86C271A}']
    procedure SetErro(AbValue: Boolean);
    function GetErro: Boolean;

    procedure SetMensagem(AcValue: String);
    function GetMensagem: String;

    procedure AddEndereco(const AoValue: TEndereco);
    function GetEnderecos: TEnumerable<TEndereco>;
  end;

implementation

end.
