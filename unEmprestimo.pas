unit unEmprestimo;

interface

uses
  Windows, unDataMudule, SysUtils;

type
  TEmprestimo = class
    private
      Fcodigo_cliente: Integer;
      Fcodigo_emprestimo: Integer;
      Fcodigo_livro: Integer;
      Fdata_emprestimo: string;
      Fdata_devolucao: string;
    public
      property codigo_emprestimo: Integer read Fcodigo_emprestimo write Fcodigo_emprestimo;
      property data_emprestimo: string  read Fdata_emprestimo write Fdata_emprestimo;
      property data_devolucao: string read Fdata_devolucao write Fdata_devolucao;
      property codigo_cliente: Integer  read Fcodigo_cliente write Fcodigo_cliente;
      property codigo_livro: Integer read Fcodigo_livro write Fcodigo_livro;
      procedure processaAlteracao;
      procedure processaInsercao;
  end;

implementation

procedure TEmprestimo.processaAlteracao;
begin
  //Aqui processara o salvamento de uma alteração no banco de dados
  dm.qryPersistencia.SQL.Text:=
  'update biblioteca.emprestimo set data = '+QuotedStr(data_emprestimo)+','+
  '   data_devolucao = '+QuotedStr(data_devolucao)+','+
  '   codigo_cliente = '+IntToStr(codigo_cliente)+','+
  '   codigo_livro = '+IntToStr(codigo_livro)+
  ' where codigo_emprestimo = '+IntToStr(codigo_emprestimo);
  dm.qryPersistencia.ExecSQL;


//  dm.qryPersistencia.SQL.Text :=
//   'update biblioteca.livro set titulo = '+QuotedStr(Titulo)+','+
//   '   exemplares = '+ IntToStr(Exemplares) +','+
//	 '   codigo_prateleira = '+ IntToStr(Codigo_prateleira) +','+
//	 '   codigo_autor = '+ IntToStr(Codigo_autor) +
//   'where codigo_livro = '+ IntToStr(Codigo_livro)  ;
//   dm.qryPersistencia.ExecSql;
end;

procedure TEmprestimo.processaInsercao;
begin
  //Aqui processara uma inserção de um novo registro no banco de dados
  dm.qryPersistencia.SQL.Text:=
  'insert into biblioteca.emprestimo (codigo_emprestimo, data, data_devolucao, codigo_cliente, codigo_livro) '+
  ' Values('+
    IntToStr(codigo_emprestimo)+','+
    QuotedStr(data_emprestimo)+','+
    QuotedStr(data_devolucao)+','+
    IntToStr(codigo_cliente)+','+
    IntToStr(codigo_livro)+')';
  dm.qryPersistencia.ExecSql;
end;

end.
