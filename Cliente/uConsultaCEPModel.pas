unit uConsultaCEPModel;

interface

uses
  System.SysUtils, System.Generics.Collections, uEndereco, Datasnap.DBClient,
  Data.DB, uEnum, uDBTableViaCep;

type
  TConsultaCEPModel = class
  private
    FoCdsPesquisa : TClientDataSet;
    FoCdsAllBase : TDBTableViaCep;

    procedure AddFields;
    procedure AtualizarTodosRegistros;
  public
    Constructor Create; reintroduce;
    Destructor Destroy; override;

    procedure LoadEnderecosPesquisa(AoEnderecos : TArray<TEndereco>);
    function ConsultarCep(AeModoPesquisa : TModoPesquisa; AcCep, AcUf, AcCidade, AcLogradouro: String): TList<TEndereco>;
    procedure AtualizarEnderecos(AoEnderecos : TArray<TEndereco>);

    function GetCdsPesquisa : TDataSet;
    function GetCdsDataBase : TDataSet;
  end;

implementation

{ TConsultaCEPModel }

procedure TConsultaCEPModel.AddFields;
begin
  FoCdsPesquisa.FieldDefs.Clear;
  FoCdsPesquisa.FieldDefs.Add('CEP', ftString, 9);
  FoCdsPesquisa.FieldDefs.Add('LOGRADOURO', ftString, 50);
  FoCdsPesquisa.FieldDefs.Add('COMPLEMENTO', ftString, 100);
  FoCdsPesquisa.FieldDefs.Add('BAIRRO', ftString, 50);
  FoCdsPesquisa.FieldDefs.Add('CIDADE', ftString, 50);
  FoCdsPesquisa.FieldDefs.Add('UF', ftString, 2);
  FoCdsPesquisa.FieldDefs.Add('DDD', ftString, 3);
  FoCdsPesquisa.CreateDataSet;
end;

procedure TConsultaCEPModel.AtualizarEnderecos(AoEnderecos: TArray<TEndereco>);
var
  oEndereco : TEndereco;
  oTableTmp : TDBTableViaCep;
begin
  oTableTmp := TDBTableViaCep.Create;

  for oEndereco in AoEnderecos do
    oTableTmp.AtualizaOuInsereEndereco(oEndereco);

  AtualizarTodosRegistros;
end;

procedure TConsultaCEPModel.AtualizarTodosRegistros;
begin
  FoCdsAllBase.GetDataSet.DisableControls;
  try
    FoCdsAllBase.ConsultarTodosRegistros;
  finally
    FoCdsAllBase.GetDataSet.EnableControls;
  end;
end;

function TConsultaCEPModel.ConsultarCep(AeModoPesquisa: TModoPesquisa; AcCep, AcUf, AcCidade, AcLogradouro: String): TList<TEndereco>;
var
  oTableTmp : TDBTableViaCep;
begin
  oTableTmp := TDBTableViaCep.Create;

  if AeModoPesquisa = mpCEP then
    Result := oTableTmp.ConsultarCEP(AcCep)
  else
    Result := oTableTmp.ConsultarLogradouro(AcUf, AcCidade, AcLogradouro);
end;

constructor TConsultaCEPModel.Create;
begin
  FoCdsPesquisa := TClientDataSet.Create(nil);
  AddFields;
  FoCdsAllBase := TDBTableViaCep.Create;
  AtualizarTodosRegistros;
end;

destructor TConsultaCEPModel.Destroy;
begin
  FreeAndNil(FoCdsPesquisa);
  inherited;
end;

function TConsultaCEPModel.GetCdsDataBase: TDataSet;
begin
  Result := FoCdsAllBase.GetDataSet;
end;

function TConsultaCEPModel.GetCdsPesquisa: TDataSet;
begin
  Result := FoCdsPesquisa;
end;

procedure TConsultaCEPModel.LoadEnderecosPesquisa(AoEnderecos: TArray<TEndereco>);
var
  oEndereco : TEndereco;
begin
  FoCdsPesquisa.DisableControls;
  try
    FoCdsPesquisa.EmptyDataSet;

    for oEndereco in AoEnderecos do
      begin
        FoCdsPesquisa.Insert;

        FoCdsPesquisa.FieldByName('CEP').AsString := oEndereco.GetCep;
        FoCdsPesquisa.FieldByName('LOGRADOURO').AsString := oEndereco.GetLogradouro;
        FoCdsPesquisa.FieldByName('COMPLEMENTO').AsString := oEndereco.GetComplemento;
        FoCdsPesquisa.FieldByName('BAIRRO').AsString := oEndereco.GetBairro;
        FoCdsPesquisa.FieldByName('CIDADE').AsString := oEndereco.GetCidade;
        FoCdsPesquisa.FieldByName('UF').AsString := oEndereco.GetUf;

        FoCdsPesquisa.Post;
      end;
  finally
    FoCdsPesquisa.EnableControls;
  end;
end;

end.
