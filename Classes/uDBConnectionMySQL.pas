unit uDBConnectionMySQL;

interface

uses
  System.SysUtils, uIDBConnection, uIDBCheck, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL, Data.DB, FireDAC.Comp.Client, IniFiles;

type
  TDBConnectionMySQL = class(TInterfacedObject, IDBConnection)
  private
    FoConnection : TFDConnection;

    procedure ConfiguraConexao;
  public
    Constructor Create; reintroduce;
    Destructor Destroy; override;

    class function New: TDBConnectionMySQL;

    function GetConnection : TFDConnection;
    function GetDataBaseCheck : IDBCheck;
  end;

implementation

uses
  uDBCheckMySQL;

{ TDBConnectionMySQL }

procedure TDBConnectionMySQL.ConfiguraConexao;
var
  oIni : TIniFile;
begin
  oIni := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  try
    FoConnection.Params.Values['Server'] := oIni.ReadString('database', 'host', 'localhost');
    FoConnection.Params.Values['Port'] := oIni.ReadString('database', 'port', '3306');
    FoConnection.Params.Values['User_Name'] := oIni.ReadString('database', 'user', '');
    FoConnection.Params.Values['Password'] := oIni.ReadString('database', 'pass', '');
  finally
    FreeAndNil(oIni);
  end;
end;

constructor TDBConnectionMySQL.Create;
begin
  FoConnection := TFDConnection.Create(nil);
  try
    FoConnection.DriverName := 'MySQL';

    ConfiguraConexao;

    FoConnection.Connected := True;
  except
    on E: Exception do
      begin
        if Pos('Access denied for user', E.Message) > 0 then
          begin
            raise Exception.Create('Não foi possível conectar no banco de dados utilizando o Usuário ou a Senha informados.'#13#13+
                                   'Valide as informações contidas no arquivo "' + ChangeFileExt(ParamStr(0), '.ini') + '"');
          end;

        raise Exception.Create('Não foi possível conectar no banco de dados MySQL.'#13+
                               'Conexão utilizada "' + FoConnection.Params.Values['Server'] + ':' + FoConnection.Params.Values['Port'] + '"'#13#13+
                               'Valide as informações contidas no arquivo "' + ChangeFileExt(ParamStr(0), '.ini') + '"');
      end;
  end;
end;

destructor TDBConnectionMySQL.Destroy;
begin
  FreeAndNil(FoConnection);
  inherited;
end;

function TDBConnectionMySQL.GetConnection: TFDConnection;
begin
  Result := FoConnection;
end;

function TDBConnectionMySQL.GetDataBaseCheck: IDBCheck;
begin
  Result := TDBCheckMySQL.Create(FoConnection);
end;

class function TDBConnectionMySQL.New: TDBConnectionMySQL;
begin
  Result := Create;
end;

end.
