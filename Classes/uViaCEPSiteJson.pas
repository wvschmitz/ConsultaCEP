unit uViaCEPSiteJson;

interface

uses
  System.JSON, System.SysUtils, System.Generics.Collections,
  uViaCEPSitePadrao, uIViaCEPSite, uIDadosPesquisa, uEndereco;

type
  TViaCEPSiteJson = class(TViaCEPPadrao, IViaCEPSite)
  private
    procedure PesquisarModoCEP;
    procedure PesquisarModoCompleto;
    function CriarEndereco(AoJson : TJSONObject): TEndereco;
  public
    function SetDadosPesquisa(AcDadosPesquisa : String): IViaCEPSite;
    function Consultar: String;
  end;

implementation

uses
  uDadosPesquisa, uEnum;

const
  _Url_CEP = 'https://viacep.com.br/ws/%s/json/';
  _Url_Completa = 'https://viacep.com.br/ws/%s/%s/%s/json/';

{ TViaCEPSiteJson }

function TViaCEPSiteJson.Consultar: String;
begin
  try
    if FoDadosPesquisa.GetModoPesquisa = mpCEP then
      PesquisarModoCEP
    else
      PesquisarModoCompleto;
  except
    on E: Exception do
      begin
        FoDadosResultado.SetErro(True);
        FoDadosResultado.SetMensagem(E.Message);
      end;
  end;

  Result := FoDadosResultado.ToJson;
end;

function TViaCEPSiteJson.CriarEndereco(AoJson : TJSONObject): TEndereco;
begin
  Result := TEndereco.Create;
  Result.SetCep(AoJson.GetValue('cep').Value);
  Result.SetLogradouro(AoJson.GetValue('logradouro').Value);
  Result.SetComplemento(AoJson.GetValue('complemento').Value);
  Result.SetBairro(AoJson.GetValue('bairro').Value);
  Result.SetCidade(AoJson.GetValue('localidade').Value);
  Result.SetUf(AoJson.GetValue('uf').Value);
end;

procedure TViaCEPSiteJson.PesquisarModoCEP;
var
  cRetorno : String;
  oJson : TJSONObject;
begin
  cRetorno := AcessarSite(Format(_Url_CEP, [FoDadosPesquisa.GetCEP]));

  oJson := TJSONValue.ParseJSONValue(cRetorno) as TJSONObject;
  try
    if oJson.GetValue('erro') <> nil then
      begin
        FoDadosResultado.SetErro(True);
        FoDadosResultado.SetMensagem('CEP não localizado na API!')
      end
    else
      begin
        FoDadosResultado
          .AddEndereco(CriarEndereco(oJson));
      end;
  finally
    FreeAndNil(oJson);
  end;
end;

procedure TViaCEPSiteJson.PesquisarModoCompleto;
var
  cRetorno : String;
  oArray : TJSONArray;
  i: Integer;
begin
  cRetorno := AcessarSite(Format(_Url_Completa, [FoDadosPesquisa.GetUF, FoDadosPesquisa.GetCidade, FoDadosPesquisa.GetLogradouro]));

  oArray := TJSONValue.ParseJSONValue(cRetorno) as TJSONArray;
  try
    if oArray.Count = 0 then
      begin
        FoDadosResultado.SetErro(True);
        FoDadosResultado.SetMensagem('Nenhum endereço localizado!');
        Exit;
      end;

    for i := 0 to oArray.Count -1 do
      begin
        FoDadosResultado
          .AddEndereco(CriarEndereco(TJSONObject(oArray.Items[i])));
      end;
  finally
    FreeAndNil(oArray);
  end;
end;

function TViaCEPSiteJson.SetDadosPesquisa(AcDadosPesquisa : String): IViaCEPSite;
begin
  Result := Self;
  FoDadosPesquisa := TDadosPesquisa.FromJson(AcDadosPesquisa);
end;

end.
