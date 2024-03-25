object FConsultaCEPView: TFConsultaCEPView
  Left = 0
  Top = 0
  Caption = 'Cadastro de CEP'
  ClientHeight = 439
  ClientWidth = 747
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 747
    Height = 439
    Align = alClient
    DragMode = dmAutomatic
    TabOrder = 0
    ExplicitWidth = 743
    ExplicitHeight = 438
    object pgGrigs: TPageControl
      Left = 1
      Top = 1
      Width = 745
      Height = 437
      ActivePage = tsConsultar
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 741
      ExplicitHeight = 436
      object tsConsultar: TTabSheet
        Caption = 'Consultar'
        object grBancoDados: TDBGrid
          Left = 0
          Top = 0
          Width = 737
          Height = 407
          Align = alClient
          DataSource = dsBase
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'CEP'
              Title.Caption = ' CEP'
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LOGRADOURO'
              Title.Caption = 'Logradouro'
              Width = 250
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COMPLEMENTO'
              Title.Caption = 'Complemento'
              Width = 150
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'BAIRRO'
              Title.Caption = 'Bairro'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CIDADE'
              Title.Caption = 'Cidade'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'UF'
              Width = 30
              Visible = True
            end>
        end
      end
      object tsNovo: TTabSheet
        Caption = 'Novo'
        ImageIndex = 1
        object pnConfiguracao: TPanel
          Left = 0
          Top = 0
          Width = 737
          Height = 57
          Align = alTop
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 0
          ExplicitWidth = 733
          object rgSitePesquisa: TRadioGroup
            Left = 412
            Top = 4
            Width = 201
            Height = 47
            Caption = 'Formato de Busca:'
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              'JSON'
              'XML')
            TabOrder = 0
          end
          object rgModoPesquisa: TRadioGroup
            Left = 127
            Top = 5
            Width = 201
            Height = 47
            Caption = 'Consultar por:'
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              'CEP'
              'Endere'#231'o')
            TabOrder = 1
            OnClick = rgModoPesquisaClick
          end
        end
        object pnBotao: TPanel
          Left = 0
          Top = 171
          Width = 737
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 3
          ExplicitWidth = 733
          object btPesquisar: TButton
            Left = 333
            Top = 8
            Width = 75
            Height = 25
            Caption = 'Pesquisar'
            TabOrder = 0
            OnClick = btPesquisarClick
          end
        end
        object pnPesquisaCep: TPanel
          Left = 0
          Top = 57
          Width = 737
          Height = 26
          Align = alTop
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 1
          ExplicitWidth = 733
          object lbCEP: TLabel
            Left = 142
            Top = 6
            Width = 24
            Height = 15
            Caption = 'CEP:'
          end
          object edCEP: TMaskEditCep
            Left = 172
            Top = 2
            Width = 121
            Height = 23
            EditMask = '99999-999;1;_'
            MaxLength = 9
            TabOrder = 0
            Text = '     -   '
          end
        end
        object pnPesquisaEndereco: TPanel
          Left = 0
          Top = 83
          Width = 737
          Height = 88
          Align = alTop
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 2
          Visible = False
          ExplicitWidth = 733
          object lbUf: TLabel
            Left = 128
            Top = 7
            Width = 38
            Height = 15
            Caption = 'Estado:'
          end
          object lbCidade: TLabel
            Left = 126
            Top = 34
            Width = 40
            Height = 15
            Caption = 'Cidade:'
          end
          object lbLogradouro: TLabel
            Left = 101
            Top = 61
            Width = 65
            Height = 15
            Caption = 'Logradouro:'
          end
          object edUf: TEditEstados
            Left = 172
            Top = 4
            Width = 189
            Height = 23
            TabOrder = 0
          end
          object edCidade: TEditEndereco
            Left = 172
            Top = 31
            Width = 441
            Height = 23
            TabOrder = 1
            MinLength = 3
          end
          object edLogradouro: TEditEndereco
            Left = 172
            Top = 58
            Width = 441
            Height = 23
            TabOrder = 2
            MinLength = 3
          end
        end
        object pnResultados: TPanel
          Left = 0
          Top = 212
          Width = 737
          Height = 195
          Align = alClient
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 4
          ExplicitWidth = 733
          ExplicitHeight = 194
          object grEnderecos: TDBGrid
            Left = 0
            Top = 0
            Width = 737
            Height = 195
            Align = alClient
            DataSource = dsPesquisa
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Segoe UI'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'CEP'
                Width = 70
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'LOGRADOURO'
                Title.Caption = 'Logradouro'
                Width = 250
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'COMPLEMENTO'
                Title.Caption = 'Complemento'
                Width = 150
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'BAIRRO'
                Title.Caption = 'Bairro'
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CIDADE'
                Title.Caption = 'Cidade'
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'UF'
                Width = 30
                Visible = True
              end>
          end
        end
      end
    end
  end
  object ViaCEP: TViaCEP
    Left = 696
    Top = 32
  end
  object dsPesquisa: TDataSource
    Left = 696
    Top = 96
  end
  object dsBase: TDataSource
    Left = 693
    Top = 150
  end
end
