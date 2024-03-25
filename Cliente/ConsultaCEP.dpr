program ConsultaCEP;

uses
  Vcl.Forms,
  System.SysUtils,
  Vcl.Dialogs,
  System.UITypes,
  uConsultaCEPView in 'uConsultaCEPView.pas' {FConsultaCEPView},
  uConsultaCEPController in 'uConsultaCEPController.pas',
  uConsultaCEPModel in 'uConsultaCEPModel.pas',
  uIDBConnection in '..\Interface\uIDBConnection.pas',
  uDBConnectionMySQL in '..\Classes\uDBConnectionMySQL.pas',
  uDBCheckMySQL in '..\Classes\uDBCheckMySQL.pas',
  uIDBCheck in '..\Interface\uIDBCheck.pas',
  uIDBTableViaCep in '..\Interface\uIDBTableViaCep.pas',
  uDBTableViaCep in '..\Classes\uDBTableViaCep.pas';

{$R *.res}

begin
  Application.Initialize;

  try
    TDBConnectionMySQL
      .New
        .GetDataBaseCheck
          .Execute;
  except
    on E : Exception do
      begin
        MessageDlg(E.Message, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
        Halt(0);
      end;
  end;

  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFConsultaCEPView, FConsultaCEPView);
  Application.Run;
end.
