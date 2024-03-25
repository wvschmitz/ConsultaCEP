unit uDadosPesquisa;

{
  Classe que irá conter as informações solicitadas para pesquisa,ela implementa
  as interfaces IDadosPesquisa e a ISerializavel.

  Está classe é serializada na tela e enviada em formato JSON para o componente
  uViaCEP, que nas classes uViaCEPSiteJson e uViaCEPSiteXml será feito a
  deserialização para o objeto.
}

interface

uses
  uIDadosPesquisa, uISerializavel, uEnum;

type
  TDadosPesquisa = class(TInterfacedObject, IDadosPesquisa, ISerializavel)
  private
    FnModoPesquisa: TModoPesquisa;
    FcCEP: String;
    FcUF: String;
    FcCidade: String;
    FcLogradouro: String;
  public
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

    function ToJson: String;
    class function FromJson(AcJson: String): TDadosPesquisa;
  end;

implementation

uses
  Rest.Json;

{ TDadosPesquisa }

class function TDadosPesquisa.FromJson(AcJson: String): TDadosPesquisa;
begin
  Result := TJson.JsonToObject<TDadosPesquisa>(AcJson);
end;

function TDadosPesquisa.GetCEP: String;
begin
  Result := FcCEP;
end;

function TDadosPesquisa.GetCidade: String;
begin
  Result := FcCidade;
end;

function TDadosPesquisa.GetLogradouro: String;
begin
  Result := FcLogradouro;
end;

function TDadosPesquisa.GetModoPesquisa: TModoPesquisa;
begin
  Result := FnModoPesquisa;
end;

function TDadosPesquisa.GetUF: String;
begin
  Result := FcUF;
end;

procedure TDadosPesquisa.SetCEP(AcValue: String);
begin
  FcCEP := AcValue;
end;

procedure TDadosPesquisa.SetCidade(AcValue: String);
begin
  FcCidade := AcValue;
end;

procedure TDadosPesquisa.SetLogradouro(AcValue: String);
begin
  FcLogradouro := AcValue;
end;

procedure TDadosPesquisa.SetModoPesquisa(AeValue: TModoPesquisa);
begin
  FnModoPesquisa := AeValue;
end;

procedure TDadosPesquisa.SetUF(AcValue: String);
begin
  FcUF := AcValue;
end;

function TDadosPesquisa.ToJson: String;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

end.
