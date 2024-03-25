unit uConsultaCEPView;

{
  Formulário padrão do projeto ConsultaCEP para entrada das informações de
  pesquisa e exibição dos endereços pesquisados. Esta tela possui duas páginas,
  a primeira “Consultar” que fica responsável por exibir todos os CEPs já
  pesquisados e a segunda é “Novo” responsável por pesquisar novos CEP.
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uViaCEP, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, uMaskEditCep,
  uConsultaCEPController, uEditEndereco, uEditEstados;

type
  TFConsultaCEPView = class(TForm)
    ViaCEP: TViaCEP;
    Panel1: TPanel;
    pgGrigs: TPageControl;
    tsConsultar: TTabSheet;
    tsNovo: TTabSheet;
    grBancoDados: TDBGrid;
    dsPesquisa: TDataSource;
    pnConfiguracao: TPanel;
    rgSitePesquisa: TRadioGroup;
    rgModoPesquisa: TRadioGroup;
    btPesquisar: TButton;
    pnPesquisaCep: TPanel;
    pnPesquisaEndereco: TPanel;
    pnResultados: TPanel;
    lbCEP: TLabel;
    lbUf: TLabel;
    lbCidade: TLabel;
    lbLogradouro: TLabel;
    pnBotao: TPanel;
    edCEP: TMaskEditCep;
    grEnderecos: TDBGrid;
    edUf: TEditEstados;
    edCidade: TEditEndereco;
    edLogradouro: TEditEndereco;
    dsBase: TDataSource;
    procedure rgModoPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btPesquisarClick(Sender: TObject);
  private
    { Private declarations }
    FoController : TConsultaCEPController;
  public
    { Public declarations }
  end;

var
  FConsultaCEPView: TFConsultaCEPView;

implementation

uses
  uDadosPesquisa, uDadosResultado;

{$R *.dfm}

procedure TFConsultaCEPView.btPesquisarClick(Sender: TObject);
begin
  FoController.Pesquisar;
end;

procedure TFConsultaCEPView.FormCreate(Sender: TObject);
begin
  FoController := TConsultaCEPController.Create;

  dsPesquisa.DataSet := FoController.GetModel.GetCdsPesquisa;
  dsBase.DataSet := FoController.GetModel.GetCdsDataBase;

  FoController.SetModoPesquisa(rgModoPesquisa);
  FoController.SetSitePesquisa(rgSitePesquisa);
  FoController.SetCep(edCep);
  FoController.SetUf(edUF);
  FoController.SetCidade(edCidade);
  FoController.SetLogradouro(edLogradouro);
  FoController.SetViaCep(ViaCEP);
end;

procedure TFConsultaCEPView.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FoController)
end;

procedure TFConsultaCEPView.rgModoPesquisaClick(Sender: TObject);
begin
  pnPesquisaCep.Visible := rgModoPesquisa.ItemIndex = 0;
  pnPesquisaEndereco.Visible := rgModoPesquisa.ItemIndex = 1;
  pnBotao.Top := pnPesquisaEndereco.Top +1;
end;

end.
