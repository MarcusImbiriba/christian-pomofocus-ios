# Christian PomoFocus

Repositório do aplicativo nativo para iPhone/iOS Christian PomoFocus, com Swift e SwiftUI confirmados para a implementação.

## Estado do projeto

O projeto está na etapa de planejamento do produto e desenvolvimento inicial. O núcleo de uma sessão de foco foi integrado no pacote `FocusCore` pela [PR #14](https://github.com/MarcusImbiriba/christian-pomofocus-ios/pull/14), que encerrou a [Issue #13](https://github.com/MarcusImbiriba/christian-pomofocus-ios/issues/13).

A [Issue #15](https://github.com/MarcusImbiriba/christian-pomofocus-ios/issues/15), aberta na consulta de 2026-10-19, define a próxima entrega aprovada: aplicativo SwiftUI integrado ao núcleo e validação no Simulator. O estado de execução dessa entrega pertence à Issue.

A PR #14 registra execução pelo Humano de 24 testes aprovados no Linux, com código de saída 0. Esse registro não comprova compilação ou funcionamento do aplicativo iOS e não representa uma nova execução nesta revisão documental.

A versão mínima aprovada para o aplicativo é **iOS 17**, conforme a Issue #15. Arquitetura completa, persistência, sincronização/armazenamento e dependências externas do aplicativo permanecem em avaliação. O núcleo já entregue é um pacote sem dependências externas; isso não define a arquitetura completa. As escolhas futuras devem privilegiar simplicidade, testabilidade e manutenção.

Permanecem pendentes as regras completas de segundo plano e recuperação após encerramento. A estratégia inicial de testes está em [docs/testes.md](docs/testes.md); testes específicos e evidências da integração iOS serão definidos nas entregas correspondentes.

## Documentação do produto

A [Visão Geral do Projeto](docs/visao-geral-do-projeto.md) apresenta propósito, público, valor e direção. Os detalhes estão em [Definição do MVP](docs/definicao-do-mvp.md), [Experiência e conteúdo](docs/experiencia-e-conteudo.md), [Validação do produto](docs/validacao-do-produto.md) e [Estratégia de negócio](docs/estrategia-de-negocio.md).

O chat “Visão Geral do Projeto” apoia a elaboração desses documentos. Issues/PRs guardam escopo e evidências; o Project guarda prioridade e andamento. O Vault mantém decisões e aprendizados e aponta para o VGP, sem duplicá-lo. A biblioteca local é material de consulta; DFE é utilizada sob demanda e sua preparação não comprova validação das hipóteses do produto.

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

O acesso ao Mac remoto por RDP foi aprovado na Issue #15. A preparação do ambiente será documentada no contexto correspondente, com registro das versões de macOS, Xcode, Swift e Simulator e conferência de compatibilidade com o pacote FocusCore.

A validação de compilação iOS, interface SwiftUI, Simulator e testes específicos da plataforma Apple permanece pendente nas evidências consultadas em 2026-10-19. Limitações ainda não identificadas do ambiente remoto constituem risco operacional; a validação de Swift no Linux não elimina esse risco.

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

Os exercícios anteriores de validação do ambiente foram executados em um laboratório separado. Este repositório agora contém o pacote Swift [`FocusCore`](FocusCore/Package.swift), sem dependências externas, com um módulo de implementação e outro de testes com Swift Testing. O manifesto usa Swift 6.4, conforme o ambiente de referência; isso não define a versão mínima do iOS.

Na raiz do repositório, execute:

```sh
cd FocusCore
swift test
```

O núcleo usa segundos inteiros (`Int`), com precisão de um segundo. A integração com relógio real e as conversões de unidades ficam fora do pacote nesta entrega.

### Núcleo de uma sessão de foco

`FocusSession(durationSeconds:)` cria uma sessão pronta com duração positiva. `start()` inicia a sessão; `update(elapsedSeconds:)` acompanha o progresso; `cancel(elapsedSeconds:)` atualiza o tempo e cancela antes do limite. No limite ou depois dele, a conclusão prevalece sobre o cancelamento.

O argumento `elapsedSeconds` representa o **total desde o início bem-sucedido**, não um incremento. Por exemplo, numa sessão de 60 segundos, atualizar com 10 e depois com 20 deixa 40 segundos restantes. O núcleo não consulta um relógio nem avança sozinho.

As operações retornam o novo estado quando há transição, ou `nil` quando não há. Assim, a conclusão é informada uma única vez. Duração zero ou negativa é rejeitada com `ValidationError.invalidDuration`; em andamento, tempo negativo ou regressivo lança `negativeElapsedTime` ou `regressiveElapsedTime`, preservando a sessão. Repetir o mesmo tempo é permitido.

Atualizar ou cancelar uma sessão pronta não a modifica. Sessões concluídas ou canceladas ignoram operações posteriores, inclusive entradas negativas ou regressivas. No cancelamento, o restante fica congelado; uma nova sessão exige uma nova instância.

A suíte cobre criação, início repetido, progresso, conclusão, cancelamento, entradas inválidas e limites de `Int`, sem rede ou esperas reais. Registrar a saída completa, os testes executados e o código de saída. A validação da lógica no Linux não comprova compilação ou funcionamento do aplicativo iOS.

A compilação do aplicativo iOS e sua validação no Simulator ou em dispositivo serão estabelecidas quando o projeto Xcode for criado.
