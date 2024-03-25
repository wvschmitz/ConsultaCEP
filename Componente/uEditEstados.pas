unit uEditEstados;

{
  Componente para validar a digitação dos estados brasileiros, obrigando que
  seja informado um estado válido. O componente também é responsável por
  retornar a sigla do estado digitado pelo usuário.
}

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.Dialogs;

type
  TEditEstados = class(TEdit)
  private
    FUF : String;

    function VerificarSeExisteEstado() : boolean;
  protected

  public
    procedure DoExit; override;

    property UF : String read FUF;
  published

  end;

procedure Register;

implementation

const
EstadosMatriz: array[0..26, 0..1] of string = (
    ('Acre', 'AC'),
    ('Alagoas', 'AL'),
    ('Amapá', 'AP'),
    ('Amazonas', 'AM'),
    ('Bahia', 'BA'),
    ('Ceará', 'CE'),
    ('Distrito Federal', 'DF'),
    ('Espírito Santo', 'ES'),
    ('Goiás', 'GO'),
    ('Maranhão', 'MA'),
    ('Mato Grosso', 'MT'),
    ('Mato Grosso do Sul', 'MS'),
    ('Minas Gerais', 'MG'),
    ('Pará', 'PA'),
    ('Paraíba', 'PB'),
    ('Paraná', 'PR'),
    ('Pernambuco', 'PE'),
    ('Piauí', 'PI'),
    ('Rio de Janeiro', 'RJ'),
    ('Rio Grande do Norte', 'RN'),
    ('Rio Grande do Sul', 'RS'),
    ('Rondônia', 'RO'),
    ('Roraima', 'RR'),
    ('Santa Catarina', 'SC'),
    ('São Paulo', 'SP'),
    ('Sergipe', 'SE'),
    ('Tocantins', 'TO')
  );

procedure Register;
begin
  RegisterComponents('ConsultaCEP', [TEditEstados]);
end;

{ TEditEstados }

procedure TEditEstados.DoExit;
begin
  inherited;

  if (GetTextLen > 0) and (not VerificarSeExisteEstado) then
    begin
      ShowMessage('O estado informado é inválido.');
      SetFocus;
    end;
end;

function TEditEstados.VerificarSeExisteEstado: boolean;
var
  i : Integer;
begin
  Result := False;

  for i := Low(EstadosMatriz) to High(EstadosMatriz) do
    if CompareText(EstadosMatriz[i, 0], Trim(Text)) = 0 then
      begin
        FUF := EstadosMatriz[i, 1];
        Result := True;
        Break;
      end;
end;

end.
