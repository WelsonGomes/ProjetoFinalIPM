unit UnFrLivro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, unDataMudule,
  unFrCadLivros, DB;

type
  TFrLivro = class(TForm)
    dbgrdLivros: TDBGrid;
    pnlLivroTop: TPanel;
    a: TPanel;
    btnCadastar: TBitBtn;
    btnAlterar: TBitBtn;
    btnExcluir: TBitBtn;
    cbbCampo: TComboBox;
    lblCampo: TLabel;
    cbbOperador: TComboBox;
    lblOperador: TLabel;
    lblValor: TLabel;
    edtValorPesquisa: TEdit;
    btnPesquisa: TBitBtn;
    actlstLivro: TActionList;
    actCadastrar: TAction;
    actAlterar: TAction;
    actExcluir: TAction;
    actPesquisar: TAction;
    dsLivro: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actCadastrarExecute(Sender: TObject);
    procedure actAlterarExecute(Sender: TObject);
  private
    procedure carregaLivro;
  public
    { Public declarations }
  end;

var
  FrLivro: TFrLivro;

implementation

{$R *.dfm}

procedure TFrLivro.carregaLivro;
var
  sFiltro, sCampo, sOperador, sValor: string;
begin
  sValor:= edtValorPesquisa.Text;

  case cbbCampo.ItemIndex of
    0 : sCampo:= 'codigo_livro';
    1 : sCampo:= 'titulo';
    2 : sCampo:= 'codigo_autor';
  end;

  case cbbOperador.ItemIndex of
    0 : sOperador:= '=';
    1 : sOperador:= '<>';
    2 : begin
      sOperador:= 'ilike';
      sValor:= sValor+'%';
    end;
    3 : begin
      sOperador:= 'ilike';
      sValor:= '%'+sValor+'%';
    end;
    4 : sOperador:= '>';
    5 : sOperador:= '<';
  end;

  if edtValorPesquisa.Text <> '' then begin
    sFiltro:= 'where '+sCampo+' '+sOperador+' '+QuotedStr(sValor);
  end;
  dm.qryLivro.SQL.Text :=
    'select codigo_livro,'+
		'         cast (titulo as varchar(50)) as "Titulo",'+
		'   exemplares as "Exemplares",'+
		'         cast (prateleira.numero as varchar(10)) as "Prateleira",'+
		'         cast (autor.nome as varchar(50)) as "Autor"'+
		'         from biblioteca.livro'+
    '   inner join biblioteca.prateleira'+
    '           on livro.codigo_prateleira = prateleira.codigo_prateleira'+
    '   inner join biblioteca.autor'+
		'           on autor.codigo_autor = livro.codigo_autor '+
    sFiltro +
    ' order by codigo_livro';
  dm.qryLivro.Open;
end;

procedure TFrLivro.FormShow(Sender: TObject);
begin
  carregaLivro;
end;

procedure TFrLivro.actExcluirExecute(Sender: TObject);
begin
  if MessageDlg('Deseja realmente excluir o registro?', mtConfirmation,[mbNo,mbYes],0) = mryes then begin
    dm.qryPersistencia.SQL.Text:= 'delete from biblioteca.livro where codigo_livro = '+ dm.qryLivro.FieldByName('codigo_livro').AsString;
    dm.qryPersistencia.ExecSQL;
    ShowMessage('Resgistro Excluido!');
    carregaLivro;
  end;
end;

procedure TFrLivro.actPesquisarExecute(Sender: TObject);
begin
  carregaLivro;
end;

procedure TFrLivro.actCadastrarExecute(Sender: TObject);
begin
  FrCadLivro.bNovo := True;
  FrCadLivro.ShowModal;
  carregaLivro;
end;

procedure TFrLivro.actAlterarExecute(Sender: TObject);
begin
  //Abre Formulario Alterar Livros
  FrCadLivro.bNovo := False;
  dm.qryPersistencia.SQL.Text:= 'select * from biblioteca.livro where codigo_livro = '+ dm.qryLivro.FieldByName('codigo_livro').AsString;
  dm.qryPersistencia.Open;
  FrCadLivro.edtCodigo.Text:= dm.qryPersistencia.FieldByName('codigo_livro').AsString;
  FrCadLivro.edtCodigo.Enabled:= False;
  FrCadLivro.edtTitulo.Text:= dm.qryPersistencia.FieldByName('titulo').AsString;
  FrCadLivro.edtExemplares.Text:= dm.qryPersistencia.FieldByName('exemplares').AsString;
  FrCadLivro.cbbPrateleira.Text:= dm.qryPersistencia.FieldByName('codigo_prateleira').AsString;
  FrCadLivro.cbbAutor.Text:= dm.qryPersistencia.FieldByName('codigo_autor').AsString;
  FrCadLivro.ShowModal;
  carregaLivro;
end;

end.
