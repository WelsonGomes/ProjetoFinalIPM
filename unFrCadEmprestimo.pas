unit unFrCadEmprestimo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, Buttons, unDataMudule, unEmprestimo, ComCtrls,
  ActnList;

type
  TFrCadEmprestimo = class(TForm)
    lblCodigo: TLabel;
    lblCliente: TLabel;
    lblLivro: TLabel;
    edtCodigo: TEdit;
    edtCliente: TComboBox;
    edtLivro: TComboBox;
    btnCadastrar: TBitBtn;
    lblDataEmprestimo: TLabel;
    lblDataDevolucao: TLabel;
    edtDataEmprestimo: TEdit;
    edtDataDevolucao: TEdit;
    actlstEmprestimo: TActionList;
    actGravar: TAction;
    procedure FormShow(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
  private
    FbNovo: Boolean;
    { Private declarations }
  public
    property bNovo:  Boolean read FbNovo write FbNovo;
  end;

var
  FrCadEmprestimo: TFrCadEmprestimo;

implementation

{$R *.dfm}

procedure TFrCadEmprestimo.FormShow(Sender: TObject);
var
  sCliente, sLivro: string;
begin
  if bNovo then begin
    edtDataEmprestimo.Text:= '';
    edtDataDevolucao.Text:= '';
  end;

  edtCliente.Clear;
  edtLivro.Clear;

  dm.qryPersistencia.SQL.Text:= 'select * from biblioteca.cliente';
  dm.qryPersistencia.Open;
  while not dm.qryPersistencia.Eof do begin
    sCliente:= (dm.qryPersistencia.FieldByName('codigo_cliente').AsString);
    sCliente:= sCliente +' - '+ (dm.qryPersistencia.FieldByName('nome').AsString);
    FrCadEmprestimo.edtCliente.Items.Add(sCliente);
    dm.qryPersistencia.Next;
  end;

  dm.qryPersistencia.SQL.Text:= 'select * from biblioteca.livro';
  dm.qryPersistencia.Open;
  while not dm.qryPersistencia.Eof do begin
    sLivro:= (dm.qryPersistencia.FieldByName('codigo_livro').AsString);
    sLivro:= sLivro +' - '+ (dm.qryPersistencia.FieldByName('titulo').AsString);
    FrCadEmprestimo.edtLivro.Items.Add(sLivro);
    dm.qryPersistencia.Next;
  end;
end;

procedure TFrCadEmprestimo.actGravarExecute(Sender: TObject);
var
  oEmprestimo: TEmprestimo;
  index, iCodCliente, iCodLivro: Integer;
  sTxtCodigo_Cliente, sTxtCodigo_Livro, sTeste: string;

begin
  if (edtDataEmprestimo.Text <> '') and (edtDataDevolucao.Text <> '') and (edtCliente.Text <> '') and (edtLivro.Text <> '') then begin
    oEmprestimo:= TEmprestimo.Create;
    oEmprestimo.codigo_emprestimo := StrToIntDef(edtCodigo.Text,0);
    oEmprestimo.data_emprestimo := edtDataEmprestimo.Text;
    oEmprestimo.data_devolucao := edtDataDevolucao.Text;

    //pega o codigo da cliente para salvar no banco de dados
    index := edtCliente.ItemIndex;
    if index < 10 then begin
      sTxtCodigo_Cliente := Copy(edtCliente.Items[Index], 1, 1);
      sTeste:= Copy(edtCliente.Items[Index], 2, 1);
      if sTeste <> ' ' then begin
        sTxtCodigo_Cliente:= sTxtCodigo_Cliente + sTeste;
      end;
      iCodCliente:= StrToInt(sTxtCodigo_Cliente);
      oEmprestimo.codigo_cliente:= iCodCliente;
    end;

    //pega o codigo do autor para salvar no banco de dados
    index := edtLivro.ItemIndex;
    if index < 10 then begin
      sTxtCodigo_Livro := Copy(edtLivro.Items[Index], 1, 1);
      sTeste:= Copy(edtLivro.Items[Index], 2, 1);
      if sTeste <> ' ' then begin
        sTxtCodigo_Livro:= sTxtCodigo_Livro + sTeste;
      end;
      iCodLivro:= StrToInt(sTxtCodigo_Livro);
      oEmprestimo.codigo_livro:= iCodLivro;
    end;


    if bNovo then
      oEmprestimo.processaInsercao
    else
      oEmprestimo.processaAlteracao;


    Close;
  end else
    ShowMessage('Campos de preenchimento obrigat?rios.');
end;

end.
