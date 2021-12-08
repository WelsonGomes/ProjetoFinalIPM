object unCadLivro: TunCadLivro
  Left = 1332
  Top = 239
  Width = 441
  Height = 675
  Caption = 'Cadastro de Livros'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblCodigo: TLabel
    Left = 40
    Top = 64
    Width = 50
    Height = 20
    Caption = 'Codigo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblTitulo: TLabel
    Left = 40
    Top = 120
    Width = 97
    Height = 20
    Caption = 'Titulo do Livro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblExemplares: TLabel
    Left = 40
    Top = 176
    Width = 83
    Height = 20
    Caption = 'Exemplares'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblPrateleira: TLabel
    Left = 40
    Top = 232
    Width = 120
    Height = 20
    Caption = 'Prateleira do livro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblAutor: TLabel
    Left = 224
    Top = 232
    Width = 76
    Height = 20
    Caption = 'Autor Livro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object edtCodigo: TEdit
    Left = 40
    Top = 83
    Width = 329
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object edtTitulo: TEdit
    Left = 40
    Top = 139
    Width = 329
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object edtExemplares: TEdit
    Left = 40
    Top = 195
    Width = 329
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object cbbPrateleira: TComboBox
    Left = 40
    Top = 251
    Width = 145
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 20
    ParentFont = False
    TabOrder = 3
  end
  object cbbAutor: TComboBox
    Left = 224
    Top = 251
    Width = 145
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 20
    ParentFont = False
    TabOrder = 4
  end
  object btnCadastrar: TBitBtn
    Left = 40
    Top = 288
    Width = 329
    Height = 81
    Caption = 'btnCadastrar'
    TabOrder = 5
  end
end
