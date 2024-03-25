unit uEditEstados;

{
  Componente para validar a digita��o dos estados brasileiros, obrigando que
  seja informado um estado v�lido. O componente tamb�m � respons�vel por
  retornar a sigla do estado digitado pelo usu�rio.
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
    ('Amap�', 'AP'),
    ('Amazonas', 'AM'),
    ('Bahia', 'BA'),
    ('Cear�', 'CE'),
    ('Distrito Federal', 'DF'),
    ('Esp�rito Santo', 'ES'),
    ('Goi�s', 'GO'),
    ('Maranh�o', 'MA'),
    ('Mato Grosso', 'MT'),
    ('Mato Grosso do Sul', 'MS'),
    ('Minas Gerais', 'MG'),
    ('Par�', 'PA'),
    ('Para�ba', 'PB'),
    ('Paran�', 'PR'),
    ('Pernambuco', 'PE'),
    ('Piau�', 'PI'),
    ('Rio de Janeiro', 'RJ'),
    ('Rio Grande do Norte', 'RN'),
    ('Rio Grande do Sul', 'RS'),
    ('Rond�nia', 'RO'),
    ('Roraima', 'RR'),
    ('Santa Catarina', 'SC'),
    ('S�o Paulo', 'SP'),
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
      ShowMessage('O estado informado � inv�lido.');
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
