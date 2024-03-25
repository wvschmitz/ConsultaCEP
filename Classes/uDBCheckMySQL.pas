unit uDBCheckMySQL;

{
  Classe que implementa a interface IDBCheck que é responsável por validar se o
  database “consultacep” e a tabela “viacep” estão criadas no banco de dados
  disponibilizado, caso não estejam criados ela é responsável pela criação
  dos mesmos
}

interface

uses
  System.SysUtils, uIDBCheck, FireDAC.Comp.Client, FireDAC.Comp.Script,
  FireDAC.Comp.ScriptCommands;

type
  TDBCheckMySQL = class(TInterfacedObject, IDBCheck)
  private
    FoScript : TFdScript;

    procedure ValidarDataBase;
    procedure ValidarTableViaCep;
  public
    Constructor Create(AoConnection : TFdConnection); reintroduce;
    Destructor Destroy; override;

    procedure Execute;
  end;

implementation

{ TDBCheckMySQL }

Constructor TDBCheckMySQL.Create(AoConnection : TFdConnection);
begin
  FoScript := TFdScript.Create(nil);
  FoScript.Connection := AoConnection;
end;

destructor TDBCheckMySQL.Destroy;
begin
  FreeAndNil(FoScript);
  inherited;
end;

procedure TDBCheckMySQL.Execute;
begin
  ValidarDataBase;
  ValidarTableViaCep;
end;

procedure TDBCheckMySQL.ValidarDataBase;
var
  oSqlScript : TFDSQLScript;
begin
  FoScript.SQLScripts.Clear;
  oSqlScript := FoScript.SQLScripts.Add;
  oSqlScript.Name := 'CreateDataBase';
  oSqlScript.SQL.Text := 'CREATE DATABASE IF NOT EXISTS consultacep;';

  FoScript.ExecuteAll;
end;

procedure TDBCheckMySQL.ValidarTableViaCep;
var
  oSqlScript : TFDSQLScript;
begin
  FoScript.SQLScripts.Clear;
  oSqlScript := FoScript.SQLScripts.Add;
  oSqlScript.Name := 'CreateTable';
  oSqlScript.SQL.Text := 'CREATE TABLE IF NOT EXISTS consultacep.viacep (' +
                         '  codigo INT NOT NULL AUTO_INCREMENT,' +
                         '  cep VARCHAR(9) NULL,' +
                         '  logradouro VARCHAR(50) NULL,' +
                         '  complemento VARCHAR(50) NULL,' +
                         '  bairro VARCHAR(50) NULL,' +
                         '  localidade VARCHAR(50) NULL,' +
                         '  uf VARCHAR(2) NULL,' +
                         '  PRIMARY KEY (codigo));';

  FoScript.ExecuteAll;
end;

end.
