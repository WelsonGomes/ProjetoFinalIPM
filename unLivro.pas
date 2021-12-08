unit unLivro;

interface

uses
  Windows, unDataMudule, SysUtils;

type
  TLivro = class
  private
    FCodigo_livro: Integer;
    FCodigo_autor: Integer;
    FCodigo_prateleira: Integer;
    FExemplares: Integer;
    FTitulo: string;
  public
    property Codigo_livro: Integer read FCodigo_livro write FCodigo_livro;
    property Titulo: string read FTitulo write FTitulo;
    property Exemplares: Integer read FExemplares write FExemplares;
    property Codigo_prateleira: Integer read FCodigo_prateleira write FCodigo_prateleira;
    property Codigo_autor: Integer read FCodigo_autor write FCodigo_autor;
    procedure processaAlteracao;
    procedure processaInsercao;
  end;

implementation

procedure TLivro.processaAlteracao;
begin
  dm.qryPersistencia.SQL.Text :=
   'update biblioteca.livro set titulo = '+QuotedStr(Titulo)+','+
   '   exemplares = '+ IntToStr(Exemplares) +','+
	 '   codigo_prateleira = '+ IntToStr(Codigo_prateleira) +','+
	 '   codigo_autor = '+ IntToStr(Codigo_autor) +
   'where codigo_livro = '+ IntToStr(Codigo_livro)  ;
   dm.qryPersistencia.ExecSql;
end;

procedure Tlivro.processaInsercao;
var
  iCodigo: Integer;
  
begin
  dm.qryPersistencia.SQL.Text:= 'select max(codigo_livro) + 1 as novo_codigo from biblioteca.livro';
  dm.qryPersistencia.Open;
  if dm.qryPersistencia.Eof then
    iCodigo:= 1
  else
    iCodigo:= dm.qryPersistencia.FieldByName('novo_codigo').AsInteger;


  dm.qryPersistencia.SQL.Text :=
  'insert into biblioteca.livro (codigo_livro, titulo, exemplares, codigo_prateleira, codigo_autor) '+
  ' values('+IntToStr(iCodigo)+','+QuotedStr(Titulo)+','+IntToStr(exemplares)+','+IntToStr(codigo_prateleira)+','+IntToStr(codigo_autor)+')';
  dm.qryPersistencia.ExecSql;
end;

end.
