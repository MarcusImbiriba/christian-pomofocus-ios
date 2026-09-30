# Estratégia de testes

## Objetivo

Proteger comportamentos relevantes do Christian PomoFocus com testes rápidos, reproduzíveis e proporcionais à manutenção por uma pessoa com assistência de IA.

## Ferramentas e plataformas

- Swift Testing para novos testes de cálculos, regras de negócio e estados.
- Swift Testing para integrações quando as APIs utilizadas permitirem.
- XCTest e XCUIAutomation para testes de interface do aplicativo.
- XCTest para medições de desempenho que tenham requisitos definidos.

A lógica independente de APIs Apple pode ser validada no Linux. Integrações específicas do iOS e testes de interface devem ser executados no ambiente macOS/Xcode apropriado.

## Organização e convenções

Em pacotes Swift, organizar os testes em `Tests/<Modulo>Tests/`, agrupados por comportamento ou componente.

Os nomes devem descrever resultados observáveis. Cada caso deve criar seu próprio estado e apresentar preparação, ação e verificação claras.

Utilizar testes parametrizados para diferentes entradas da mesma regra. Manter comportamentos distintos em testes separados.

Os resultados esperados devem decorrer dos requisitos, evitando reproduzir a fórmula da implementação dentro do teste.

Evitar dependência da ordem de execução, estado global mutável, rede real em testes unitários e esperas fixas para sincronização.

## TDD seletivo

Priorizar teste primeiro para bugs reproduzíveis, cálculos, transições de estado e regras críticas que possam ser isoladas.

O ciclo consiste em observar uma falha funcional esperada, implementar o comportamento, verificar a aprovação e refatorar preservando os testes.

Erros de compilação, timeouts e ausência de testes descobertos não comprovam a falha funcional pretendida.

Alterações visuais simples podem ser verificadas por inspeção e no dispositivo, conforme seu risco e comportamento.

## Temporizador

Fornecer o tempo à lógica para permitir testes sem esperas reais.

Planejar casos de início, progresso, pausa, retomada, limite exato, tempo excedido e conclusão. As regras de duração, início repetido, background, recuperação após encerramento e efeitos de conclusão devem ser definidas nas Issues das funcionalidades.

O cálculo isolado de tempo restante validado no laboratório não equivale à implementação do temporizador completo.

## Execução e revisão

Em um pacote Swift, executar `swift test` a partir de sua pasta. Durante o desenvolvimento, selecionar testes relevantes quando isso ajudar; antes de concluir uma alteração pequena, executar a suíte completa.

Conferir a quantidade e os nomes dos testes executados, além do código de saída. Registrar plataforma, resultados e limitações pertinentes na PR.

Alterações produzidas por IA devem receber a mesma revisão de requisitos, casos limite e efeitos externos. Remoções de testes ou mudanças nas expectativas precisam de justificativa baseada no comportamento aprovado.

A cobertura de código pode apoiar a análise, sem substituir a avaliação dos cenários e sem uma meta arbitrária de 100%.

## Referências

- [Swift Testing](https://developer.apple.com/documentation/testing)
- [Testes parametrizados](https://developer.apple.com/documentation/testing/parameterizedtesting)
- [XCTest](https://developer.apple.com/documentation/xctest)