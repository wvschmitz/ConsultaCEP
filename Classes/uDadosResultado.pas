unit uDadosResultado;

{
  Classe que irá conter os endereços retornados da API e se ocorreu um erro
  durante a busca, ela implementa as interfaces IDadosResultado e a
  ISerializavel.

  Essa classe é serializada nas classes uViaCEPSiteJson e uViaCEPSiteXml onde
  será usada na tela a partir do retorno do componente uViaCEP.
}

interface

uses
  uIDadosResultado, uISerializavel, uEndereco, System.Generics.Collections,
  System.SysUtils;

type
  TDadosResultado = class(TInterfacedObject, IDadosResultado, ISerializavel)
  private
    FbErro : Boolean;
    FcMensagem : String;
    FoEnderecos : TList<TEndereco>;
  public
    procedure SetErro(AbValue: Boolean);
    function GetErro: Boolean;

    procedure SetMensagem(AcValue: String);
    function GetMensagem: String;

    procedure AddEndereco(const AoValue: TEndereco);
    function GetEnderecos: TEnumerable<TEndereco>;

    function ToJson: String;
    class function FromJson(AcJson: String): TDadosResultado;

    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

uses
  Rest.Json;

{ TDadosResultado }

procedure TDadosResultado.AddEndereco(const AoValue: TEndereco);
begin
  FoEnderecos.Add(AoValue)
end;

constructor TDadosResultado.Create;
begin
  inherited;

  FoEnderecos := TList<TEndereco>.Create;
end;

destructor TDadosResultado.Destroy;
begin
  FreeAndNil(FoEnderecos);
  inherited;
end;

class function TDadosResultado.FromJson(AcJson: String): TDadosResultado;
begin
  Result := TJson.JsonToObject<TDadosResultado>(AcJson);
end;

function TDadosResultado.GetEnderecos: TEnumerable<TEndereco>;
begin
  Result := FoEnderecos;
end;

function TDadosResultado.GetErro: Boolean;
begin
  Result := FbErro;
end;

function TDadosResultado.GetMensagem: String;
begin
  Result := FcMensagem;
end;

procedure TDadosResultado.SetErro(AbValue: Boolean);
begin
  FbErro := AbValue;
end;

procedure TDadosResultado.SetMensagem(AcValue: String);
begin
  FcMensagem := AcValue;
end;

function TDadosResultado.ToJson: String;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

end.
