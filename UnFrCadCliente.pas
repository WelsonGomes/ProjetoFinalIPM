unit UnFrCadCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unDataMudule, ActnList, StdCtrls, Buttons, Mask, UnCliente;

type
  TFrCadCliente = class(TForm)
    btnGravar: TBitBtn;
    actlstCadCliente: TActionList;
    actGravar: TAction;
    edtCodigo: TEdit;
    Label1: TLabel;
    lblNome: TLabel;
    edtNome: TEdit;
    lblCPF: TLabel;
    lblTelefone: TLabel;
    edtEndereco: TEdit;
    lblEndereco: TLabel;
    edtCpf: TMaskEdit;
    edtTelefone: TMaskEdit;
    lblSituacao: TLabel;
    edtSituacao: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
  private
    FbNovo: Boolean;
    { Private declarations }
  public
    property bNovo:  Boolean read FbNovo write FbNovo;
  end;

var
  FrCadCliente: TFrCadCliente;

implementation

{$R *.dfm}

procedure TFrCadCliente.FormShow(Sender: TObject);
var
  iCodigo: Integer;
begin
  if bNovo then begin
    Caption := 'Novo Cadastro do Cliente';
    edtNome.Text:= '';
    edtCpf.Text:= '';
    edtTelefone.Text:= '';
    edtEndereco.Text:= '';
    edtSituacao.Text:= '';
    dm.qryPersistencia.SQL.Text:= 'select max(codigo_cliente) + 1 as novo_codigo from biblioteca.cliente';
    dm.qryPersistencia.Open;
    iCodigo:= dm.qryPersistencia.FieldByName('novo_codigo').AsInteger;
    edtCodigo.Text:= IntToStr(iCodigo);
    edtCodigo.Enabled:= False;
    edtNome.SetFocus;
  end else
    Caption := 'Alterar Cadastro do cliente'

end;


procedure TFrCadCliente.actGravarExecute(Sender: TObject);
var
  oCliente: Tcliente;
begin
  if (edtNome.Text <> '') and (edtCpf.Text <> '') and (edtTelefone.Text <> '') and (edtEndereco.Text <> '') and (edtSituacao.Text <> '') then begin
    oCliente:= TCliente.Create;
    oCliente.Codigo := StrToIntDef(edtCodigo.Text,0);
    oCliente.nome := edtNome.Text;
    oCliente.Cpf := edtCpf.Text;
    oCliente.Telefone := edtTelefone.Text;
    oCliente.Endereco := edtEndereco.Text;
    oCliente.Situacao:= edtSituacao.Text;

    if bNovo then
      oCliente.processaInsercao
    else
      oCliente.processaAlteracao;


    Close;
  end else
    ShowMessage('Campos de preenchimento obrigatórios.');
end;

end.
