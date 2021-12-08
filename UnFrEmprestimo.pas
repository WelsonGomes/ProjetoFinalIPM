unit UnFrEmprestimo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unDataMudule, ActnList, StdCtrls, Buttons, Grids, DBGrids,
  ExtCtrls, unFrCadEmprestimo, DB;

type
  TFrEmprestimo = class(TForm)
    pnlTopo: TPanel;
    dbgrdEmprestimo: TDBGrid;
    pnlMeio: TPanel;
    btnCadastrar: TBitBtn;
    btnEditar: TBitBtn;
    btnExcluir: TBitBtn;
    cbbCampo: TComboBox;
    lblCampo: TLabel;
    lblOperador: TLabel;
    cbbOperador: TComboBox;
    edtValorPesquisa: TEdit;
    lblValor: TLabel;
    btnPesquisar: TBitBtn;
    actlstEmprestimo: TActionList;
    actCadastrar: TAction;
    actEditar: TAction;
    actExcluir: TAction;
    actPesquisar: TAction;
    dsEmprestimo: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actCadastrarExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
  private
    procedure carregaEmprestimo;
  public
    { Public declarations }
  end;

var
  FrEmprestimo: TFrEmprestimo;

implementation

{$R *.dfm}

procedure TFrEmprestimo.carregaEmprestimo;
var
  sFiltro, sCampo, sOperador, sValor: string;
begin
  sValor:= edtValorPesquisa.Text;

  case cbbCampo.ItemIndex of
    0 : sCampo:= 'codigo_emprestimo';
    1 : sCampo:= 'data';
    2 : sCampo:= 'data_devolucao';
    3 : sCampo:= 'cliente.nome';
    4 : sCampo:= 'livro.titulo';
  end;

  case cbbOperador.ItemIndex of
    0 : sOperador:= '=';             //Igual
    1 : sOperador:= '<>';            //Diferente
    2 : begin
      sOperador:= 'ilike';           //Inicia com
      sValor:= sValor+'%';
    end;
    3 : begin
      sOperador:= 'ilike';           //Contem
      sValor:= '%'+sValor+'%';
    end;
    4 : sOperador:= '>';             //Maior
    5 : sOperador:= '<';             //Menor
  end;

  if edtValorPesquisa.Text <> '' then begin
    sFiltro:= 'where '+sCampo+' '+sOperador+' '+QuotedStr(sValor);
  end;
  dm.qryEmprestimo.SQL.Text :=
    'select codigo_emprestimo as "Código",'+
	  '          data as "Emprestimo",'+
	  '   data_devolucao as "Devolução",'+
	  '             cast(nome as varchar (50)) as "Cliente",'+
	  '             cast(titulo as varchar (50)) as "Titulo"'+
    '             from biblioteca.emprestimo'+
    '       inner join biblioteca.livro'+
	  '               on emprestimo.codigo_livro = livro.codigo_livro'+
    '       inner join biblioteca.cliente'+
	  '               on cliente.codigo_cliente = emprestimo.codigo_cliente '+sFiltro+' order by codigo_emprestimo';
  dm.qryEmprestimo.Open;



end;


procedure TFrEmprestimo.FormShow(Sender: TObject);
begin
  carregaEmprestimo;
end;

procedure TFrEmprestimo.actPesquisarExecute(Sender: TObject);
begin
  carregaEmprestimo;
end;

procedure TFrEmprestimo.actCadastrarExecute(Sender: TObject);
begin
  dm.qryPersistencia.SQL.Text:= 'select max(codigo_emprestimo) + 1 as novo_codigo from biblioteca.emprestimo';
  dm.qryPersistencia.Open;
  if dm.qryPersistencia.Eof then
    FrCadEmprestimo.edtCodigo.Text:= IntToStr(1)
  else
    FrCadEmprestimo.edtCodigo.Text:= dm.qryPersistencia.FieldByName('novo_codigo').AsString;

  FrCadEmprestimo.edtCodigo.Enabled:= False;
  FrCadEmprestimo.bNovo:= True;
  FrCadEmprestimo.ShowModal;
  carregaEmprestimo;
end;

procedure TFrEmprestimo.actEditarExecute(Sender: TObject);
begin
  FrCadEmprestimo.bNovo:= False;
  dm.qryPersistencia.SQL.Text:= 'select * from biblioteca.emprestimo where codigo_emprestimo = '+ dm.qryEmprestimo.FieldByName('Código').AsString;
  dm.qryPersistencia.Open;
  FrCadEmprestimo.edtCodigo.Text:= dm.qryPersistencia.FieldByName('codigo_emprestimo').AsString;
  FrCadEmprestimo.edtCodigo.Enabled:= False;
  FrCadEmprestimo.edtDataEmprestimo.Text:= dm.qryPersistencia.FieldByName('data').AsString;
  FrCadEmprestimo.edtDataDevolucao.Text:= dm.qryPersistencia.FieldByName('data_devolucao').AsString;
  FrCadEmprestimo.edtCliente.Text:= dm.qryPersistencia.FieldByName('codigo_cliente').AsString;
  FrCadEmprestimo.edtLivro.Text:= dm.qryPersistencia.FieldByName('codigo_livro').AsString;
  FrCadEmprestimo.ShowModal;
  carregaEmprestimo;
end;

procedure TFrEmprestimo.actExcluirExecute(Sender: TObject);
begin
  //Escluir registro
  if MessageDlg('Deseja realmente excluir o registro?', mtConfirmation,[mbNo,mbYes],0) = mryes then begin
    dm.qryPersistencia.SQL.Text:= 'delete from biblioteca.emprestimo where codigo_emprestimo = '+ dm.qryEmprestimo.FieldByName('Código').AsString;
    dm.qryPersistencia.ExecSQL;
    ShowMessage('Resgistro Excluido!');
    carregaEmprestimo;
  end;
end;

end.


