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

A toolchain Swift e o suporte à linguagem no editor ainda precisam ser configurados e validados. As versões utilizadas serão documentadas após essa validação.

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

Os procedimentos de configuração, compilação e testes serão documentados à medida que forem implementados e validados.

Ainda não há instruções de execução do aplicativo nem uma estratégia de testes estabelecida.
