# Medconnect

Aplicativo de chat médico desenvolvido em Flutter e Firebase para o Projeto Integrador, permitindo que usuários se conectem com profissionais de saúde em um ambiente prático e seguro. O foco principal desta aplicação é a construção de interfaces visuais seguindo o mockup criado no Figma.

## Tabela de Conteúdos
- [Sobre o Projeto](#sobre-o-projeto)
- [Mockup e Design](#mockup-e-design)
- [Pré-requisitos](#pré-requisitos)
- [Instalação](#instalação)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Funcionalidades](#funcionalidades)
- [Licença](#licença)

## Sobre o Projeto

O Medconnect é uma aplicação de chat médico desenvolvida com Flutter e Firebase, projetada para conectar pacientes e médicos em uma plataforma intuitiva. Este projeto foi desenvolvido para o Projeto Integrador do curso de Tecnologia em Sistemas para Internet do Senac. A aplicação permite agendamento de consultas e comunicação direta com profissionais de saúde.

## Mockup e Design

O design do Medconnect foi criado no Figma. As interfaces foram desenvolvidas para garantir uma experiência de usuário agradável e responsiva. A parte visual do projeto é baseada no [mockup do Figma](https://www.figma.com/design/FpFIpRwEUMOa8KzN4DwGSe/PI---DESENVOLVIMENTO-DE-SISTEMAS-WEB-MODULARIZ%C3%81VEIS?node-id=0-1&t=DB4P0Zy7czGF2WXi-1).

## Pré-requisitos

Antes de iniciar, verifique se você possui os seguintes requisitos instalados:
- Flutter SDK
- Dart
- Node.js (para configuração do Firebase)
- Firebase CLI
- Git

## Instalação

1. Clone este repositório:
   ```bash
   git clone https://github.com/TiagoTinoco/medconnect.git
2. Navegue até o diretório do projeto:
   cd medconnect
3. Instale as dependências do Flutter:
   flutter pub get
4. Configure o Firebase (opcional, caso necessário para testes):
   Siga as instruções na documentação oficial do Firebase para integrar o Firebase ao projeto.

## Estrutura do Projeto

O projeto está organizado da seguinte maneira:
- `lib/`: Contém os arquivos principais do Flutter.
  - `main.dart`: Arquivo de entrada do aplicativo.
  - `screens/`: Contém todas as telas do app, baseadas no mockup do Figma.
  - `widgets/`: Componentes visuais reutilizáveis.
  - `models/`: Modelos de dados para integração futura.
  - `services/`: Arquivos para configurar Firebase e outros serviços.

## Funcionalidades

- **Interface de Login e Cadastro**: Página de login e cadastro de usuários médicos e pacientes.
- **Chat Médico**: Interface de mensagens para comunicação entre médicos e pacientes.
- **Agendamento de Consultas**: Visualização de horários disponíveis e agendamento de consultas.
- **Perfis de Usuário**: Tela de perfil com detalhes de cada usuário, seja médico ou paciente.

## Licença

Este projeto está licenciado sob a Licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

