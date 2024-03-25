unit uConsultaCEPController;

{
  Classe para centralização das regras do formulário de Consulta de CEP e também
  responsável por chamar a classe uConsultaCEPModel para gravação de dados.
}

interface

uses
  uConsultaCEPModel, Vcl.StdCtrls, Vcl.ExtCtrls, uViaCep, Vcl.Dialogs, System.SysUtils,
  uMaskEditCep, uEditEstados, System.UITypes;

type
  TConsultaCEPController = class
  private
    FoModel : TConsultaCEPModel;

    FoModoPesquisa : TRadioGroup;
    FoSitePesquisa : TRadioGroup;
    FoCep: TMaskEditCep;
    FoUf: TEditEstados;
    FoCidade: TCustomEdit;
    FoLogradouro: TCustomEdit;
    FoViaCep :  TViaCep;

    function ValidarCamposVazios : Boolean;
    procedure ValidarCepBase;
    procedure CarregaRetorno(AcJson: String);
    procedure PesquisarInternet;
  public
    Constructor Create; reintroduce;
    Destructor Destroy; override;

    procedure SetModoPesquisa(AoComponent: TRadioGroup);
    procedure SetSitePesquisa(AoComponent: TRadioGroup);
    procedure SetCep(AoComponent: TMaskEditCep);
    procedure SetUf(AoComponent: TEditEstados);
    procedure SetCidade(AoComponent: TCustomEdit);
    procedure SetLogradouro(AoComponent: TCustomEdit);
    procedure SetViaCep(AoComponent: TViaCep);

    function GetModel : TConsultaCEPModel;

    procedure Pesquisar;
  end;

implementation

uses
  uEnum, uDadosResultado, uDadosPesquisa, System.Generics.Collections,
  uEndereco;

{ TConsultaCEPController }

procedure TConsultaCEPController.CarregaRetorno(AcJson: String);
var
  oResultado : TDadosResultado;
begin
  oResultado := TDadosResultado.FromJson(AcJson);

  if oResultado.GetErro then
    begin
      MessageDlg('Ocorreu um erro ao consultar o CEP!' + #13#13 +
                 'Erro retornado: ' + oResultado.GetMensagem, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
    end
  else
    begin
      FoModel.LoadEnderecosPesquisa(oResultado.GetEnderecos.ToArray);
      FoModel.AtualizarEnderecos(oResultado.GetEnderecos.ToArray);
    end;
end;

procedure TConsultaCEPController.ValidarCepBase;
var
  oCollection : TList<TEndereco>;
begin
  oCollection := FoModel.ConsultarCep(TModoPesquisa(FoModoPesquisa.ItemIndex), FoCep.Text, FoUf.UF, FoCidade.Text, FoLogradouro.Text);
  try
    if oCollection.Count > 0 then
      begin
        if MessageDlg('Foi encontrado este Endereço já cadastrado na base de dados!'#13+
                      'Deseja atualizar o CEP buscando novamente na Internet?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbNo, TMsgDlgBtn.mbYes], 0) = mrNo then
          begin
            FoModel.LoadEnderecosPesquisa(oCollection.ToArray);
            Exit;
          end;
      end;

    PesquisarInternet;
  finally
    FreeAndNil(oCollection)
  end;
end;

Constructor TConsultaCEPController.Create;
begin
  inherited;
  FoModel := TConsultaCEPModel.Create;
end;

destructor TConsultaCEPController.Destroy;
begin
  FreeAndNil(FoModel);
  inherited;
end;

function TConsultaCEPController.GetModel: TConsultaCEPModel;
begin
  Result := FoModel;
end;

procedure TConsultaCEPController.Pesquisar;
begin
  FoViaCep.ModoPesquisa := TSitePesquisa(FoSitePesquisa.ItemIndex);

  if ValidarCamposVazios then
    Exit;

  ValidarCepBase;
end;

procedure TConsultaCEPController.PesquisarInternet;
var
  oPesquisa : TDadosPesquisa;
begin
  oPesquisa := TDadosPesquisa.Create;

  oPesquisa.SetModoPesquisa(TModoPesquisa(FoModoPesquisa.ItemIndex));

  if oPesquisa.GetModoPesquisa = mpCEP then
    oPesquisa.SetCEP(FoCep.GetCepNumerico)
  else
    begin
      oPesquisa.SetUF(FoUf.UF);
      oPesquisa.SetCidade(FoCidade.Text);
      oPesquisa.SetLogradouro(FoLogradouro.Text);
    end;

  CarregaRetorno(FoViaCEP.Pesquisar(oPesquisa.ToJson));
end;

procedure TConsultaCEPController.SetCep(AoComponent: TMaskEditCep);
begin
  FoCep := AoComponent;
end;

procedure TConsultaCEPController.SetCidade(AoComponent: TCustomEdit);
begin
  FoCidade := AoComponent;
end;

procedure TConsultaCEPController.SetLogradouro(AoComponent: TCustomEdit);
begin
  FoLogradouro := AoComponent;
end;

procedure TConsultaCEPController.SetModoPesquisa(AoComponent: TRadioGroup);
begin
  FoModoPesquisa := AoComponent;
end;

procedure TConsultaCEPController.SetSitePesquisa(AoComponent: TRadioGroup);
begin
  FoSitePesquisa := AoComponent;
end;

procedure TConsultaCEPController.SetUf(AoComponent: TEditEstados);
begin
  FoUf := AoComponent;
end;

procedure TConsultaCEPController.SetViaCep(AoComponent: TViaCep);
begin
  FoViaCep := AoComponent;
end;

function TConsultaCEPController.ValidarCamposVazios: Boolean;
begin
  Result := True;

  if FoModoPesquisa.ItemIndex = 1 then
    begin
      if FoUf.Text = EmptyStr then
        begin
          MessageDlg('Favor informar o campo Estado.', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], 0);
          Exit;
        end;

      if FoCidade.Text = EmptyStr then
        begin
          MessageDlg('Favor informar o campo Cidade.', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], 0);
          Exit;
        end;

      if FoLogradouro.Text = EmptyStr then
        begin
          MessageDlg('Favor informar o campo Logradouro.', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], 0);
          Exit;
        end;
    end
  else
    begin
      if FoCep.GetCepNumerico = EmptyStr then
        begin
          MessageDlg('Favor informar o campo CEP.', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], 0);
          Exit;
        end;
    end;

  Result := False;
end;

end.
