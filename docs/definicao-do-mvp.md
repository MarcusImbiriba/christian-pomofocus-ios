# Definição do MVP

**Status:** Rascunho em análise
**Revisão:** 2026-10-19
**Origem:** conteúdo do VGP v0.3, reorganizado na [Issue #20](https://github.com/MarcusImbiriba/christian-pomofocus-ios/issues/20).

[Visão Geral do Projeto](visao-geral-do-projeto.md)

Este documento preserva propostas e pendências. A reorganização não aprova funcionalidades nem valida hipóteses. Requisitos e critérios de aceite de cada entrega pertencem às Issues correspondentes.

## Objetivo e limites deste documento

Validar o diferencial central com um conjunto pequeno de capacidades. A definição integral do MVP permanece em aberto; os candidatos abaixo não constituem um backlog autorizado.

## Hipótese de MVP

O MVP proposto deverá ser pequeno o suficiente para validar o diferencial central.

Funcionalidades candidatas:

1. Cronômetro de foco.
2. Duração configurável.
3. Intervalos.
4. Biblioteca inicial de aproximadamente 20 a 30 histórias.
5. Gancho narrativo antes da sessão.
6. Desbloqueio do desfecho após conclusão.
7. Reflexões curtas.
8. Passagens bíblicas relacionadas.
9. Questionamentos filosófico-espirituais durante o descanso.
10. Distribuição gradual de mensagens contemplativas.
11. Reflexões sem interação obrigatória.
12. Aproximadamente três ambientes visuais.
13. Aproximadamente três a cinco opções de áudio.
14. Histórico básico de sessões.
15. Total de minutos focados.
16. Sequência de dias de uso.
17. Notificações.
18. Funcionamento offline sempre que possível.

Esses itens são **candidatos ao MVP, não funcionalidades aprovadas**.

O núcleo de foco já foi entregue e uma primeira interface SwiftUI foi aprovada em escopo específico. Isso não aprova todos os candidatos do MVP; consulte as referências abaixo.

Não são prioridades iniciais propostas: contas próprias, redes sociais, rankings, IA integrada ao aplicativo, Apple Watch, sincronização complexa e grandes sistemas de gamificação.

## Conta de Usuário

A direção preferencial é disponibilizar a primeira versão sem exigir uma conta própria.

Fluxo desejado:

**Download → Abrir → Iniciar foco**

Essa abordagem poderá reduzir fricção, infraestrutura e tratamento de dados pessoais.

A ausência de contas ainda precisa ser confirmada durante a definição dos requisitos do MVP.

Sincronização e autenticação poderão ser consideradas futuramente caso exista necessidade concreta.

## Entregas aprovadas e requisitos de referência

- [Issue #13](https://github.com/MarcusImbiriba/christian-pomofocus-ios/issues/13) e [PR #14](https://github.com/MarcusImbiriba/christian-pomofocus-ios/pull/14): núcleo portável de uma sessão de foco integrado. As regras de início, progresso, cancelamento e conclusão pertencem a essa entrega.
- [Issue #15](https://github.com/MarcusImbiriba/christian-pomofocus-ios/issues/15): escopo aprovado para aplicativo SwiftUI integrado ao FocusCore, com execução no Simulator. Aberta na consulta de 2026-10-19; sua aprovação não comprova implementação ou validação iOS.
- Os **60 segundos** previstos na Issue #15 são uma duração técnica de validação, não a duração padrão comercial.
- Estado da implementação, compatibilidade e evidências de ambiente: [README](../README.md).

## Questões de requisitos em aberto

- Duração comercial das sessões, intervalos e limites de configuração.
- Pausa, retomada e demais interrupções não cobertas pelo cancelamento do núcleo.
- Frequência dos questionamentos e possibilidade de descanso silencioso.
- Ambientes e áudios selecionados para o MVP.
- Priorização dos candidatos e escopo integral do MVP.
- Confirmação da ausência de contas, funcionamento offline e necessidades de sincronização.

Critérios editoriais estão em [Experiência e conteúdo](experiencia-e-conteudo.md), critérios de sucesso em [Validação do produto](validacao-do-produto.md) e questões comerciais em [Estratégia de negócio](estrategia-de-negocio.md).

Requisitos detalhados e critérios de aceite de cada entrega devem ser mantidos em sua Issue e referenciados aqui quando necessário, evitando duas listas concorrentes.
