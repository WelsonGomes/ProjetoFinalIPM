unit UnFrCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, unDataMudule, Buttons,
  ActnList, UnFrCadCliente, DB;

type
  TFrCliente = class(TForm)
    dbgrdCliente: TDBGrid;
    pnlPesquisa: TPanel;
    pnlAcoes: TPanel;
    cbbCampo: TComboBox;
    lblCampoPesquisa: TLabel;
    Operador: TLabel;
    cbbOperador: TComboBox;
    edtValorPesquisa: TEdit;
    actlstCliente: TActionList;
    actCadastrar: TAction;
    actAlterar: TAction;
    actExcluir: TAction;
    actPesquisar: TAction;
    btnPesquisar: TBitBtn;
    btnCadastrar: TBitBtn;
    btnAlterar: TBitBtn;
    btnExcluir: TBitBtn;
    dsCliente: TDataSource;
    lblValor: TLabel;
    procedure actExcluirExecute(Sender: TObject);
    procedure actCadastrarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actAlterarExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
  private
    procedure carregaCliente;
  public
    { Public declarations }
  end;

var
  FrCliente: TFrCliente;

implementation

{$R *.dfm}

procedure TFrCliente.actExcluirExecute(Sender: TObject);
begin
  if MessageDlg('Deseja realmente excluir o registro?', mtConfirmation,[mbNo,mbYes],0) = mryes then begin
    dm.qryPersistencia.SQL.Text:= 'delete from biblioteca.cliente where codigo_cliente = '+ dm.qryCliente.FieldByName('Código').AsString;
    dm.qryPersistencia.ExecSQL;
    ShowMessage('Resgistro Excluido!');
    carregaCliente;
  end;
end;

procedure TFrCliente.actCadastrarExecute(Sender: TObject);
begin
  //Abre Formulario Gravar Clientes
  FrCadCliente.bNovo := True;
  FrCadCliente.ShowModal;
  carregaCliente;
end;

procedure TFrCliente.actAlterarExecute(Sender: TObject);
begin
  //Abre Formulario Alterar Clientes
  FrCadCliente.bNovo := False;
  dm.qryPersistencia.SQL.Text:= 'select * from biblioteca.cliente where codigo_cliente = '+ dm.qryCliente.FieldByName('Código').AsString;
  dm.qryPersistencia.Open;
  FrCadCliente.edtCodigo.Text:= dm.qryPersistencia.FieldByName('codigo_cliente').AsString;


  FrCadCliente.edtNome.Text:= dm.qryPersistencia.FieldByName('nome').AsString;
  FrCadCliente.edtCpf.Text:= dm.qryPersistencia.FieldByName('cpf').AsString;
  FrCadCliente.edtTelefone.Text:= dm.qryPersistencia.FieldByName('telefone').AsString;
  FrCadCliente.edtEndereco.Text:= dm.qryPersistencia.FieldByName('endereco').AsString;
  FrCadCliente.edtSituacao.Text:= dm.qryPersistencia.FieldByName('situacao').AsString;
  FrCadCliente.ShowModal;
  carregaCliente;
end;

procedure TFrCliente.carregaCliente;
var
  sFiltro, sCampo, sOperador, sValor: string;
begin
  sValor:= edtValorPesquisa.Text;

  case cbbCampo.ItemIndex of
    0 : sCampo:= 'codigo_cliente';
    1 : sCampo:= 'Nome';
    2 : sCampo:= 'Cpf';
    3 : sCampo:= 'Situacao';
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
  dm.qryCliente.SQL.Text :=
    'select codigo_cliente as "Código",'+
    '   cast(nome as varchar(50)) as "Nome",'+
	  '   cast(cpf as varchar(14)) as "Cpf",'+
    '   cast(telefone as varchar(14)) as "Telefone",'+
    '   cast(endereco as varchar(65)) as "Endereço",'+
	  '   cast(situacao as varchar(8)) as "Situação"'+
    ' from biblioteca.cliente '+sFiltro+' order by codigo_cliente';
  dm.qryCliente.Open;



end;

procedure TFrCliente.FormShow(Sender: TObject);
begin
  carregaCliente;
end;

procedure TFrCliente.actPesquisarExecute(Sender: TObject);
begin
  carregaCliente;
end;
end.
