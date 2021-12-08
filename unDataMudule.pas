unit unDataMudule;

interface

uses
  SysUtils, Classes, ImgList, Controls, ActnList, DB, ADODB;

type
  Tdm = class(TDataModule)
    ilIcones: TImageList;
    conBanco: TADOConnection;
    qryPersistencia: TADOQuery;
    qryCliente: TADOQuery;
    qryLivro: TADOQuery;
    qryEmprestimo: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{$R *.dfm}

end.
