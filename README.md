# Christian PomoFocus

Repositório do aplicativo nativo para iPhone/iOS Christian PomoFocus, com Swift e SwiftUI confirmados para a implementação.

## Estado do projeto

O projeto está na etapa de planejamento do produto e preparação do desenvolvimento. A implementação funcional do aplicativo ainda não foi iniciada; o escopo de cada entrega será definido nas Issues.

A arquitetura, a versão mínima do iOS, a persistência e as dependências externas permanecem em avaliação.

## Tecnologias e ferramentas

| Componente | Definição atual |
|---|---|
| Plataforma de destino | iOS |
| Linguagem | Swift |
| Interface | SwiftUI |
| Ambiente inicial de desenvolvimento | Linux |
| Editor no Linux | Visual Studio Code |
| Assistência ao desenvolvimento | OpenAI Codex |
| Controle de versão | Git |
| Hospedagem e revisão de alterações | GitHub |

## Ambientes de desenvolvimento

### Linux

O ambiente Linux será utilizado para documentação, controle de versão e desenvolvimento de componentes Swift compatíveis com essa plataforma.

O desenvolvimento e os testes de lógica independente das APIs específicas do iOS dependerão das decisões arquiteturais do projeto.

### macOS e Xcode

As atividades que exigem o SDK do iOS, SwiftUI Preview, iOS Simulator, assinatura e distribuição serão realizadas em ambiente macOS com Xcode.

Um Mac remoto estará disponível quando necessário. Sua configuração e validação prática ocorrerão no primeiro teste de interface; compilação iOS, Simulator e testes específicos da plataforma Apple ainda não foram validados.

## Processo de contribuição

Cada alteração deve possuir uma Issue com escopo e critérios de aceite. Consulte o [fluxo de trabalho Humano ↔ IA](docs/fluxo-de-trabalho.md) para o procedimento, o checklist padrão editável, as convenções Git e as responsabilidades de execução e revisão.

As [instruções do agente](AGENTS.md) são o ponto de entrada das regras essenciais. Alterações produzidas com assistência de IA seguem o mesmo fluxo de validação e revisão humana.

## Configuração, execução e testes

O ambiente Linux foi validado para compilação e testes de código Swift independente de APIs específicas do iOS. No VS Code, foram verificados navegação, sugestões de código, diagnósticos, execução de testes e depuração com breakpoint.

### Versões de referência

Versões utilizadas nas validações realizadas em setembro de 2026:

| Componente | Versão |
|---|---|
| Swiftly | 1.2.0 |
| Swift | 6.4 |
| VS Code | 1.139.1 |
| Extensão Swift (`swiftlang.swift-vscode`) | 2.16.7 |
| LLDB DAP (`llvm-vs-code-extensions.lldb-dap`) | 0.4.1 |

Esses registros descrevem o ambiente validado e não estabelecem versões mínimas de compatibilidade do aplicativo.

### Testes

A [estratégia inicial de testes](docs/testes.md) define ferramentas, ambientes de execução e critérios de revisão.

Os exercícios de validação foram executados em um laboratório separado. Este repositório ainda não contém um pacote Swift ou projeto Xcode executável.

A compilação do aplicativo iOS e sua validação no Simulator ou em dispositivo serão estabelecidas quando o projeto Xcode for criado.
