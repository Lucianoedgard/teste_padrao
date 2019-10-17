program prjCadastro;

uses
  Forms,
  uFrmCadastro in 'uFrmCadastro.pas' {FrmCadastro},
  uLibAux in 'uLibAux.pas',
  uEndereco in 'uEndereco.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmCadastro, FrmCadastro);
  Application.Run;
end.
