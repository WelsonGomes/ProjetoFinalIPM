unit unFrCadLivros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, unDataMudule, unLivro, ActnList, DB, DBClient;

type
  TFrCadLivro = class(TForm)
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    lblTitulo: TLabel;
    edtTitulo: TEdit;
    lblExemplares: TLabel;
    edtExemplares: TEdit;
    lblPrateleira: TLabel;
    cbbPrateleira: TComboBox;
    lblAutor: TLabel;
    cbbAutor: TComboBox;
    btnCadastrar: TBitBtn;
    actlstCadastroLivro: TActionList;
    actCadastrar: TAction;
    dsCombo: TClientDataSet;
    procedure actCadastrarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FbNovo: Boolean;
    { Private declarations }
  public
    property bNovo:  Boolean read FbNovo write FbNovo;
  end;

var
  FrCadLivro: TFrCadLivro;

implementation

{$R *.dfm}

procedure TFrCadLivro.actCadastrarExecute(Sender: TObject);
var
  oLivro: TLivro;
  index, iCodPrateleira,iCodAutor: Integer;
  sTxtCodigo_Prateleira, sTxtCodigo_Autor, sTeste: String;
begin
  //Aqui cadastrarei no banco de dados
  if (edtTitulo.Text <> '') and (edtExemplares.Text <> '') and (cbbPrateleira.Text <> '') and (cbbAutor.Text <> '') then begin
    oLivro:= TLivro.Create;
    edtCodigo.Enabled:= True;
    oLivro.Codigo_livro:= StrToIntDef(edtCodigo.Text,0);
    oLivro.Titulo:= edtTitulo.Text;
    oLivro.Exemplares:= StrToIntDef(edtExemplares.Text,0);

    //pega o codigo da prateleira para salvar no banco de dados
    index := cbbPrateleira.ItemIndex;
    if index < 10 then begin
      sTxtCodigo_Prateleira := Copy(cbbPrateleira.Items[Index], 1, 1);
      sTeste:= Copy(cbbPrateleira.Items[Index], 2, 1);
      if sTeste <> ' ' then begin
        sTxtCodigo_Prateleira:= sTxtCodigo_Prateleira + sTeste;
      end;
      iCodPrateleira:= StrToInt(sTxtCodigo_Prateleira);
      oLivro.Codigo_prateleira:= iCodPrateleira;
    end;

    //pega o codigo do autor para salvar no banco de dados
    index := cbbAutor.ItemIndex;
    if index < 10 then begin
      sTxtCodigo_Autor := Copy(cbbAutor.Items[Index], 1, 1);
      sTeste:= Copy(cbbAutor.Items[Index], 2, 1);
      if sTeste <> ' ' then begin
        sTxtCodigo_Autor:= sTxtCodigo_Autor + sTeste;
      end;
      iCodAutor:= StrToInt(sTxtCodigo_Autor);
      oLivro.Codigo_autor:= iCodAutor;
    end;

    if bNovo then
      oLivro.processaInsercao
    else
      oLivro.processaAlteracao;

    Close;
  end else begin
    ShowMessage('Campos de preenchimento obrigatório.');
  end;

end;

procedure TFrCadLivro.FormShow(Sender: TObject);
var
  iCodigo: Integer;
  sPrateleira, sAutor: string;
begin
  if bNovo then begin
    Caption:= 'Adicionando um novo Livro';
    edtTitulo.Text:= '';
    edtExemplares.Text:= '';
    cbbPrateleira.Text:= '';
    cbbAutor.Text:= '';
    dm.qryPersistencia.SQL.Text:= 'select max(codigo_livro) + 1 as novo_codigo from biblioteca.livro';
    dm.qryPersistencia.Open;
    iCodigo:= dm.qryPersistencia.FieldByName('novo_codigo').AsInteger;
    edtCodigo.Text:= IntToStr(iCodigo);
    edtCodigo.Enabled:= False;
    edtTitulo.SetFocus;
  end else
    Caption:= 'Editando um registro';


  dm.qryPersistencia.SQL.Text:= 'select * from biblioteca.prateleira';
  dm.qryPersistencia.Open;
  while not dm.qryPersistencia.Eof do begin
    sPrateleira:= (dm.qryPersistencia.FieldByName('codigo_prateleira').AsString);
    sPrateleira:= sPrateleira +' - '+ (dm.qryPersistencia.FieldByName('numero').AsString);
    cbbPrateleira.Items.Add(sPrateleira);
    dm.qryPersistencia.Next;
  end;

  dm.qryPersistencia.SQL.Text:= 'select * from biblioteca.autor';
  dm.qryPersistencia.Open;
  while not dm.qryPersistencia.Eof do begin
    sAutor:= (dm.qryPersistencia.FieldByName('codigo_autor').AsString);
    sAutor:= sAutor +' - '+ (dm.qryPersistencia.FieldByName('nome').AsString);
    cbbAutor.Items.Add(sAutor);
    dm.qryPersistencia.Next;
  end;
end;

end.
