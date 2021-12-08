unit unFrPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, unDataMudule, StdCtrls, Buttons, UnFrCliente, UnFrLivro, UnFrEmprestimo,
  XPMan, ExtCtrls, jpeg, ComCtrls;

type
  TFrPrincipal = class(TForm)
    btnClientes: TBitBtn;
    btnLivros: TBitBtn;
    btnEmprestimos: TBitBtn;
    actlstPrincipal: TActionList;
    actClientes: TAction;
    actLivros: TAction;
    actEmprestimos: TAction;
    xpmnfst1: TXPManifest;
    pnlTopo: TPanel;
    imgBanner: TImage;
    imgPrincipal: TImage;
    lblPrincipal: TLabel;
    procedure actClientesExecute(Sender: TObject);
    procedure actLivrosExecute(Sender: TObject);
    procedure actEmprestimosExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrPrincipal: TFrPrincipal;

implementation

{$R *.dfm}

procedure TFrPrincipal.actClientesExecute(Sender: TObject);
begin
  // Exibição do formulario dos Clientes
  FrCliente.ShowModal;
end;

procedure TFrPrincipal.actLivrosExecute(Sender: TObject);
begin
  // Exibição do formulario dos Livros
  FrLivro.ShowModal;
end;


procedure TFrPrincipal.actEmprestimosExecute(Sender: TObject);
begin
// Exibição do formulario dos Emprestimos
  FrEmprestimo.ShowModal;
end;



procedure TFrPrincipal.FormCreate(Sender: TObject);
var
  iTamWidth, iTamHeigth: Integer;
begin
  iTamWidth:= Screen.Width;
  iTamHeigth:= Screen.Height;
  imgPrincipal.Left:= iTamWidth - 249;
  imgBanner.Width:= iTamWidth;
  imgBanner.Height:= iTamHeigth - 50;
  lblPrincipal.Left:= (iTamWidth - 900) div 2;
  lblPrincipal.Top:= (iTamHeigth - 96) div 2;
end;

end.
