# Christian PomoFocus

Repositório do aplicativo nativo para iOS Christian PomoFocus, com desenvolvimento previsto em Swift e preferência por SwiftUI para a interface.

## Estado do projeto

O projeto está na etapa de preparação e validação do ambiente de desenvolvimento. A implementação do aplicativo ainda não foi iniciada.

A arquitetura, a versão mínima do iOS, a persistência e as dependências externas permanecem em avaliação.

## Tecnologias e ferramentas

| Componente | Definição atual |
|---|---|
| Plataforma de destino | iOS |
| Linguagem | Swift |
| Interface | Preferência por SwiftUI |
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

A estratégia de acesso a esse ambiente ainda não foi definida.

## Processo de contribuição

As alterações devem possuir uma Issue correspondente, com contexto, objetivo, escopo e critérios de aceitação.

O fluxo de trabalho é:

Issue → branch → alteração → validação → revisão do diff → commit → push → pull request → revisão → merge → exclusão da branch remota pela interface web do GitHub → sincronização local.

### Branches

A branch principal é `main`. As branches de trabalho seguem o formato `issue/NUMERO-descricao-curta`, com o número da Issue, letras minúsculas e palavras separadas por hífens, sem espaços ou acentos.

### Commits

As mensagens seguem Conventional Commits, com descrição em português e referência à Issue: `tipo: descrição (#NUMERO)`.

Os tipos utilizados inicialmente são `feat`, `fix`, `docs`, `test`, `refactor` e `chore`. O escopo entre parênteses é opcional.

Uma branch pode conter vários commits. Cada commit deve representar uma mudança pequena, com objetivo claro e restrito ao escopo da Issue.

### Revisão e integração

Antes do commit, devem ser revisados os arquivos preparados e o diff, além das validações pertinentes à alteração.

As pull requests têm `main` como destino e utilizam Merge commit, preservando os commits individuais. O diff e os resultados das validações devem ser conferidos antes da integração.

Quando concluir a Issue, a descrição da pull request deve incluir `Closes #NUMERO`.

Após o merge, a branch remota deve ser excluída pela interface web do GitHub. Em seguida, o repositório local deve ser sincronizado e a branch local removida após a confirmação da integração.

Alterações produzidas com assistência de IA seguem os mesmos critérios de revisão e validação.

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
