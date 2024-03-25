unit uDBTableViaCep;

interface

uses
  uIDBTableViaCep, uIDBConnection, System.Generics.Collections, uEndereco,
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Param, Data.DB;

type
  TDBTableViaCep = class(TInterfacedObject, IDBTableViaCep)
  private
    FoConnection : IDBConnection;
    FoQuery : TFDQuery;

    function CriarEndereco: TList<TEndereco>;
  public
    Constructor Create; reintroduce;

    function GetDataSet : TDataSet;
    function ConsultarCEP(AcCep: String): TList<TEndereco>;
    function ConsultarLogradouro(AcUf, AcCidade, AcLogradouro: String): TList<TEndereco>;
    procedure ConsultarTodosRegistros;
    procedure AtualizaOuInsereEndereco(AoEndereco: TEndereco);
  end;

implementation

uses
  uDBConnectionMySQL;

{ TDBTableViaCep }

procedure TDBTableViaCep.AtualizaOuInsereEndereco(AoEndereco: TEndereco);
begin
  FoQuery.SQL.Clear;
  FoQuery.SQL.Add('UPDATE consultacep.viacep');
  FoQuery.SQL.Add('SET logradouro = :logradouro,');
  FoQuery.SQL.Add('    complemento = :complemento,');
  FoQuery.SQL.Add('    bairro = :bairro,');
  FoQuery.SQL.Add('    localidade = :localidade,');
  FoQuery.SQL.Add('    uf = :uf');
  FoQuery.SQL.Add('WHERE cep = :cep');

  FoQuery.ParamByName('cep').AsString := AoEndereco.GetCep;
  FoQuery.ParamByName('logradouro').AsString := AoEndereco.GetLogradouro;
  FoQuery.ParamByName('complemento').AsString := AoEndereco.GetComplemento;
  FoQuery.ParamByName('bairro').AsString := AoEndereco.GetBairro;
  FoQuery.ParamByName('localidade').AsString := AoEndereco.GetCidade;
  FoQuery.ParamByName('uf').AsString := AoEndereco.GetUf;

  FoQuery.ExecSQL;

  if FoQuery.RowsAffected = 0 then
    begin
      FoQuery.SQL.Clear;
      FoQuery.SQL.Add('INSERT INTO consultacep.viacep (cep, logradouro, complemento, bairro, localidade, uf)');
      FoQuery.SQL.Add('VALUE (:cep, :logradouro, :complemento, :bairro, :localidade, :uf)');

      FoQuery.ParamByName('cep').AsString := AoEndereco.GetCep;
      FoQuery.ParamByName('logradouro').AsString := AoEndereco.GetLogradouro;
      FoQuery.ParamByName('complemento').AsString := AoEndereco.GetComplemento;
      FoQuery.ParamByName('bairro').AsString := AoEndereco.GetBairro;
      FoQuery.ParamByName('localidade').AsString := AoEndereco.GetCidade;
      FoQuery.ParamByName('uf').AsString := AoEndereco.GetUf;

      FoQuery.ExecSQL;
    end;
end;

function TDBTableViaCep.ConsultarCEP(AcCep: String): TList<TEndereco>;
begin
  FoQuery.Connection := FoConnection.GetConnection;

  FoQuery.SQL.Add('SELECT * FROM consultacep.viacep WHERE cep = :cep');

  FoQuery.Params.ParamByName('cep').AsString := AcCep;

  FoQuery.Open;

  Result := CriarEndereco;
end;

function TDBTableViaCep.ConsultarLogradouro(AcUf, AcCidade, AcLogradouro: String): TList<TEndereco>;
begin
  FoQuery.SQL.Add('SELECT * FROM consultacep.viacep WHERE uf = :uf and localidade = :localidade and logradouro like :logradouro');

  FoQuery.Params.ParamByName('uf').AsString := AcUf;
  FoQuery.Params.ParamByName('localidade').AsString := AcCidade;
  FoQuery.Params.ParamByName('logradouro').AsString := '%'+ AcLogradouro + '%';

  FoQuery.Open;

  Result := CriarEndereco;
end;

procedure TDBTableViaCep.ConsultarTodosRegistros;
begin
  FoQuery.SQL.Clear;
  FoQuery.SQL.Add('SELECT * FROM consultacep.viacep');

  FoQuery.Open;
end;

constructor TDBTableViaCep.Create;
begin
  FoConnection := TDBConnectionMySQL.Create;
  FoQuery := TFDQuery.Create(nil);
  FoQuery.Connection := FoConnection.GetConnection;
end;

function TDBTableViaCep.CriarEndereco: TList<TEndereco>;
var
  oEndereco : TEndereco;
begin
  Result := TList<TEndereco>.Create;

  FoQuery.First;
  while not FoQuery.Eof do
    begin
      oEndereco := TEndereco.Create;

      oEndereco.SetCep(FoQuery.FieldByName('cep').AsString);
      oEndereco.SetLogradouro(FoQuery.FieldByName('logradouro').AsString);
      oEndereco.SetComplemento(FoQuery.FieldByName('complemento').AsString);
      oEndereco.SetBairro(FoQuery.FieldByName('bairro').AsString);
      oEndereco.SetCidade(FoQuery.FieldByName('localidade').AsString);
      oEndereco.SetUf(FoQuery.FieldByName('uf').AsString);

      Result.Add(oEndereco);

      FoQuery.Next;
    end;
end;

function TDBTableViaCep.GetDataSet: TDataSet;
begin
  Result := FoQuery;
end;

end.
