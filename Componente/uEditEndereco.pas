unit uEditEndereco;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.Dialogs;

type
  TEditEndereco = class(TEdit)
  private
    FMinLength : Integer;

    procedure SetMinLength(const Value: Integer);
  protected
  public
    procedure DoExit; override;
  published
    property MinLength :  Integer read FMinLength write SetMinLength;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('ConsultaCEP', [TEditEndereco]);
end;

{ TEditEndereco }

procedure TEditEndereco.DoExit;
begin
  inherited;

  if GetTextLen = 0 then
    Exit;

  if GetTextLen < MinLength then
    begin
      ShowMessage('A quantidade de caracteres informada deve ser superior a '+ IntToStr(MinLength-1)+'.');
      SetFocus;
    end;
end;


procedure TEditEndereco.SetMinLength(const Value: Integer);
begin
  FMinLength := Value;
end;

end.
