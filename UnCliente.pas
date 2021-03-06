unit UnCliente;

interface

uses
  Windows, unDataMudule, SysUtils;

type
  Tcliente = class
  private
    FCodigo: Integer;
    FEndereco: string;
    FTelefone: string;
    FCpf: string;
    FNome: string;
    FSituacao: string;
  public
     property Codigo : Integer  read FCodigo write FCodigo;
     property Nome : string read FNome write FNome;
     property Cpf:  string read FCpf write FCpf;
     property Telefone: string read FTelefone write fTelefone;
     property Endereco: string read FEndereco write FEndereco;
     property Situacao: string read FSituacao write FSituacao;
     procedure processaAlteracao;
     procedure processaInsercao;
     end;
implementation
{TCliente}

procedure TCliente.ProcessaAlteracao;
begin
  dm.qryPersistencia.SQL.Text :=
    'update biblioteca.cliente set nome = '+ QuotedStr(Nome)+
    ', cpf = '+QuotedStr(Cpf)+
    ', telefone = '+QuotedStr(Telefone)+
    ', endereco = '+QuotedStr(Endereco)+
    ', situacao = '+QuotedStr(Situacao)+
    '  Where codigo_cliente = '+IntToStr(Codigo);
    dm.qryPersistencia.ExecSql;
end;

procedure  TCliente.ProcessaInsercao;
var
  iCodigo: Integer;
begin
  dm.qryPersistencia.SQL.Text:= 'select max(codigo_cliente) + 1 as novo_codigo from biblioteca.cliente';
  dm.qryPersistencia.Open;
  if dm.qryPersistencia.Eof then
    iCodigo:= 1
  else
    iCodigo:= dm.qryPersistencia.FieldByName('novo_codigo').AsInteger;


  dm.qryPersistencia.SQL.Text :=
  'insert into biblioteca.cliente (codigo_cliente, nome, cpf, telefone, endereco, situacao) '+
  ' values('+
    IntToStr(iCodigo)+','+
    QuotedStr(Nome)+','+
    QuotedStr(Cpf)+','+
    QuotedStr(Telefone)+','+
    QuotedStr(Endereco)+','+
    QuotedStr(Situacao)+')';
  dm.qryPersistencia.ExecSql;
end;

end.
