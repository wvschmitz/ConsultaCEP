unit uMaskEditCep;

interface

uses
  System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.Mask, Vcl.Dialogs;

type
  TMaskEditCep = class(TMaskEdit)
  protected
    procedure DoExit; override;
  public
    constructor Create(AOwner: TComponent); override;

    function GetCepNumerico : String;
  end;

procedure Register;

implementation

uses
  System.SysUtils;

procedure Register;
begin
  RegisterComponents('ConsultaCEP', [TMaskEditCep]);
end;

{ TMaskEditCep }

constructor TMaskEditCep.Create(AOwner: TComponent);
begin
  inherited;
  EditMask := '99999-999;1;_';
end;

procedure TMaskEditCep.DoExit;
begin
  if (Length(GetCepNumerico) < 8) and (GetCepNumerico <> '') then
    begin
      ShowMessage('A quantidade de caracteres do CEP está inválida.');
      SetFocus;
      Exit;
    end;

  inherited;
end;

function TMaskEditCep.GetCepNumerico: String;
var
  i : Integer;
begin
  Result := '';
  for I := 1 to Length(Text) do
    if CharInSet(Text[i], ['0'..'9']) then
      Result := Result + Text[i];
end;

end.
