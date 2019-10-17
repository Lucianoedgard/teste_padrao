object FrmCadastro: TFrmCadastro
  Left = 0
  Top = 0
  Caption = 'Tela de Cadastro'
  ClientHeight = 411
  ClientWidth = 615
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 615
    Height = 411
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object lbl1: TLabel
      Left = 24
      Top = 8
      Width = 27
      Height = 13
      Caption = 'Nome'
      FocusControl = dbedtNome
    end
    object lbl2: TLabel
      Left = 24
      Top = 48
      Width = 52
      Height = 13
      Caption = 'Identidade'
      FocusControl = dbedtIdentidade
    end
    object lbl3: TLabel
      Left = 164
      Top = 48
      Width = 19
      Height = 13
      Caption = 'CPF'
      FocusControl = dbedtCPF
    end
    object lbl4: TLabel
      Left = 265
      Top = 48
      Width = 24
      Height = 13
      Caption = 'Email'
      FocusControl = dbedtEmail
    end
    object dbedtNome: TMaskEdit
      Tag = 1
      Left = 24
      Top = 24
      Width = 577
      Height = 21
      TabOrder = 0
    end
    object dbedtIdentidade: TMaskEdit
      Tag = 2
      Left = 24
      Top = 64
      Width = 134
      Height = 21
      TabOrder = 1
    end
    object dbedtCPF: TMaskEdit
      Tag = 3
      Left = 164
      Top = 64
      Width = 93
      Height = 21
      EditMask = '000\.000\.000\-99;0'
      MaxLength = 14
      TabOrder = 2
    end
    object dbedtEmail: TMaskEdit
      Tag = 4
      Left = 265
      Top = 64
      Width = 336
      Height = 21
      TabOrder = 3
    end
    object grp1: TGroupBox
      Left = 24
      Top = 91
      Width = 577
      Height = 278
      Caption = 'Endere'#231'o'
      TabOrder = 4
      object lbl10: TLabel
        Left = 12
        Top = 220
        Width = 33
        Height = 13
        Caption = 'Cidade'
        FocusControl = dbedtCidade
      end
      object lbl11: TLabel
        Left = 159
        Top = 220
        Width = 33
        Height = 13
        Caption = 'Estado'
        FocusControl = dbedtEstado
      end
      object lbl12: TLabel
        Left = 204
        Top = 220
        Width = 19
        Height = 13
        Caption = 'Pais'
        FocusControl = dbedtPais
      end
      object lbl5: TLabel
        Left = 12
        Top = 17
        Width = 19
        Height = 13
        Caption = 'CEP'
        FocusControl = dbedtCEP
      end
      object lbl6: TLabel
        Left = 12
        Top = 57
        Width = 55
        Height = 13
        Caption = 'Logradouro'
        FocusControl = dbedtLogradouro
      end
      object lbl7: TLabel
        Left = 12
        Top = 97
        Width = 37
        Height = 13
        Caption = 'Numero'
        FocusControl = dbedtNumero
      end
      object lbl8: TLabel
        Left = 12
        Top = 137
        Width = 65
        Height = 13
        Caption = 'Complemento'
        FocusControl = dbedtComplemento
      end
      object lbl9: TLabel
        Left = 12
        Top = 177
        Width = 28
        Height = 13
        Caption = 'Bairro'
        FocusControl = dbedtBairro
      end
      object dbedtBairro: TMaskEdit
        Tag = 9
        Left = 12
        Top = 193
        Width = 264
        Height = 21
        TabOrder = 4
      end
      object dbedtCEP: TMaskEdit
        Tag = 5
        Left = 12
        Top = 33
        Width = 63
        Height = 21
        EditMask = '00000\-999;0;_'
        MaxLength = 9
        TabOrder = 0
      end
      object dbedtCidade: TMaskEdit
        Tag = 10
        Left = 12
        Top = 239
        Width = 134
        Height = 21
        TabOrder = 5
      end
      object dbedtComplemento: TMaskEdit
        Tag = 8
        Left = 12
        Top = 153
        Width = 456
        Height = 21
        TabOrder = 3
      end
      object dbedtEstado: TMaskEdit
        Tag = 11
        Left = 159
        Top = 239
        Width = 30
        Height = 21
        TabOrder = 6
      end
      object dbedtLogradouro: TMaskEdit
        Tag = 6
        Left = 12
        Top = 70
        Width = 456
        Height = 21
        TabOrder = 1
      end
      object dbedtNumero: TMaskEdit
        Tag = 7
        Left = 12
        Top = 113
        Width = 134
        Height = 21
        TabOrder = 2
      end
      object dbedtPais: TMaskEdit
        Tag = 12
        Left = 204
        Top = 239
        Width = 264
        Height = 21
        TabOrder = 7
      end
    end
    object btnSalvar: TButton
      Left = 442
      Top = 375
      Width = 75
      Height = 25
      Caption = 'Salvar'
      TabOrder = 5
      OnClick = btnSalvarClick
    end
    object btnEnvio: TButton
      Left = 526
      Top = 375
      Width = 75
      Height = 25
      Caption = 'Enviar Email'
      TabOrder = 6
      OnClick = btnEnvioClick
    end
  end
  object jvm1: TRxMemoryData
    FieldDefs = <>
    Left = 248
    object jvm1Nome: TStringField
      Tag = 1
      FieldName = 'Nome'
      Size = 100
    end
    object jvm1Identidade: TStringField
      Tag = 2
      FieldName = 'Identidade'
    end
    object jvm1CPF: TStringField
      Tag = 3
      FieldName = 'CPF'
      Size = 14
    end
    object jvm1Email: TStringField
      Tag = 4
      FieldName = 'Email'
    end
    object jvm1CEP: TStringField
      Tag = 5
      FieldName = 'CEP'
      Size = 10
    end
    object jvm1Logradouro: TStringField
      Tag = 6
      FieldName = 'Logradouro'
      Size = 40
    end
    object jvm1Numero: TIntegerField
      Tag = 7
      FieldName = 'Numero'
    end
    object jvm1Complemento: TStringField
      Tag = 8
      FieldName = 'Complemento'
      Size = 30
    end
    object jvm1Bairro: TStringField
      Tag = 9
      FieldName = 'Bairro'
    end
    object jvm1Cidade: TStringField
      Tag = 10
      FieldName = 'Cidade'
    end
    object jvm1Estado: TStringField
      Tag = 11
      FieldName = 'Estado'
      Size = 2
    end
    object jvm1Pais: TStringField
      Tag = 12
      FieldName = 'Pais'
    end
  end
end
