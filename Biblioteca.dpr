program Biblioteca;

uses
  Forms,
  unFrPrincipal in 'unFrPrincipal.pas' {FrPrincipal},
  unDataMudule in 'unDataMudule.pas' {dm: TDataModule},
  UnFrCliente in 'UnFrCliente.pas' {FrCliente},
  UnFrLivro in 'UnFrLivro.pas' {FrLivro},
  UnFrEmprestimo in 'UnFrEmprestimo.pas' {FrEmprestimo},
  UnFrCadCliente in 'UnFrCadCliente.pas' {FrCadCliente},
  UnCliente in 'UnCliente.pas',
  unLivro in 'unLivro.pas',
  unFrCadLivros in 'unFrCadLivros.pas' {FrCadLivro},
  unFrCadEmprestimo in 'unFrCadEmprestimo.pas' {FrCadEmprestimo},
  unEmprestimo in 'unEmprestimo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrPrincipal, FrPrincipal);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TFrCliente, FrCliente);
  Application.CreateForm(TFrLivro, FrLivro);
  Application.CreateForm(TFrEmprestimo, FrEmprestimo);
  Application.CreateForm(TFrCadCliente, FrCadCliente);
  Application.CreateForm(TFrCadLivro, FrCadLivro);
  Application.CreateForm(TFrCadEmprestimo, FrCadEmprestimo);
  Application.Run;
end.
