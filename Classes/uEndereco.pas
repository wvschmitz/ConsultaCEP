unit uEndereco;

{
  Classe para representar um endereço, onde irá possuir as informações como CEP,
  Logradouro, Complemento, Bairro, Cidade e UF.
}

interface

type
  TEndereco = class
  private
    FcCep : String;
    FcLogradouro: String;
    FcComplemento: String;
    FcBairro: String;
    FcCidade: String;
    FcUf: String;
  public
    procedure SetCep(AValue : String);
    function GetCep : String;

    procedure SetLogradouro(AValue : String);
    function GetLogradouro: String;

    procedure SetComplemento(AValue : String);
    function GetComplemento: String;

    procedure SetBairro(AValue : String);
    function GetBairro: String;

    procedure SetCidade(AValue : String);
    function GetCidade: String;

    procedure SetUf(AValue : String);
    function GetUf: String;
  end;

implementation

{ TEndereco }


function TEndereco.GetBairro: String;
begin
  Result := FcBairro;
end;

function TEndereco.GetCep: String;
begin
  Result := FcCep;
end;

function TEndereco.GetCidade: String;
begin
  Result := FcCidade;
end;

function TEndereco.GetComplemento: String;
begin
  Result := FcComplemento;
end;

function TEndereco.GetLogradouro: String;
begin
  Result := FcLogradouro;
end;

function TEndereco.GetUf: String;
begin
  Result := FcUf;
end;

procedure TEndereco.SetBairro(AValue : String);
begin
  FcBairro := AValue;
end;

procedure TEndereco.SetCep(AValue : String);
begin
  FcCep := AValue;
end;

procedure TEndereco.SetCidade(AValue : String);
begin
  FcCidade := AValue;
end;

procedure TEndereco.SetComplemento(AValue : String);
begin
  FcComplemento := AValue;
end;

procedure TEndereco.SetLogradouro(AValue : String);
begin
  FcLogradouro := AValue;
end;

procedure TEndereco.SetUf(AValue : String);
begin
  FcUf := AValue;
end;

end.
