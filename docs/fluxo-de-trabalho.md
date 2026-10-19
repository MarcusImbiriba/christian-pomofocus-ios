# Fluxo de trabalho Humano ↔ IA

Este documento é a fonte única do modelo de checklist e do procedimento de entrega. As regras essenciais para o agente ficam no [AGENTS.md](../AGENTS.md); a estratégia de testes fica em [testes.md](testes.md).

## Responsabilidades e autorização

O Humano aprova requisitos e decisões, revisa a entrega e executa comandos modificadores, builds, testes e operações Git por padrão. A IA prepara tarefas, apresenta comandos, edita documentos ou código solicitados dentro do escopo aprovado e revisa alterações e evidências.

Leituras, consultas e revisão de diffs são livres. Antes de solicitar execução pela IA de comandos modificadores, builds ou testes, apresentar objetivo, ações, impacto, riscos e verificação. Aprovar o escopo ou o plano não autoriza essa execução. Registrar o conjunto autorizado, responsável e eventuais correções ou repetições previstas; ações não cobertas exigem nova autorização.

Commits, pushes, merges, instalações, configurações globais, operações destrutivas e criação de subagentes pela IA exigem autorização explícita. Não implementar decisões de produto ou técnicas ainda pendentes.

## Uso do checklist

- Preservar cabeçalho, cinco fases, ordem, próxima ação e legenda. Usar identificadores estáveis, como `1.1` e `1.2`, e indicar responsáveis em cada item. Não renumerar itens existentes; acrescentar novos identificadores ou subtarefas quando necessário.
- Separar o checklist de acompanhamento do roteiro de execução. O checklist registra ações verificáveis, estados e responsáveis; comandos e explicações ficam no roteiro, referenciados pelos mesmos identificadores. Detalhar subtarefas somente quando ajudarem a execução.
- Iniciar cada rodada de execução com o checklist resumido das tarefas previstas, explicar o roteiro necessário e terminar com a versão atualizada em bloco de texto editável. Nas rodadas intermediárias, resumir fases concluídas e detalhar a atual, preservando as cinco fases e todas as pendências. Apresentar a versão completa no encerramento da entrega ou quando solicitada. Perguntas pontuais sem avanço da entrega podem receber resposta direta.
- Indicar a etapa atual no cabeçalho. Consolidar evidências e decisões por fase, referenciando os itens: saída de comando, diff, URL ou aprovação explícita, conforme a ação. Registrar executor e origem da evidência sem repetir conteúdo já disponível na Issue, PR ou roteiro.
- Distinguir resultado informado pelo Humano de resultado conferido pela IA. Um relato pode ser registrado como tal, sem afirmar verificação independente. Usar `[x]` somente quando houver evidência suficiente para o critério do item.
- Marcar uma fase concluída somente quando todos os itens obrigatórios estiverem concluídos. Não tratar uma atividade futura como bloqueada.
- Para item não aplicável, substituir sua marcação por `N/A — motivo`, preservando sua posição, identificador e responsável. Não marcá-lo como executado; itens justificadamente não aplicáveis não impedem a conclusão da fase.
- Em erro ou interrupção, marcar o item afetado com `[!]`, registrar mensagem/saída, impacto e responsável pela próxima ação. Preservar os itens concluídos e aguardar a informação ou autorização necessária. Usar `[?]` para atenção sem bloqueio e `[-]` para trabalho em curso.
- O Humano pode editar o checklist e devolvê-lo com resultados, correções ou pedidos de execução. A IA retoma do ponto registrado, conferindo evidências e respeitando o escopo autorizado.
- Nas pendências de decisão, indicar o item, a pergunta e quem pode resolvê-la. Aprovação do escopo e autorização de execução devem permanecer em itens separados. Terminar com uma única próxima ação concreta e seu responsável.

## Modelo padrão

```text
Issue: #<número> — <título>
URL: <link>
Objetivo: <resultado observável>
Branch: <nome e situação>
PR: <link ou ainda não criada>
Etapa atual: <fase/item>
Execução combinada: <responsabilidades e limites da autorização>

[ ] 1. Preparação
    [ ] 1.1 Consultar instruções, contexto e dependências — IA.
    [ ] 1.2 Definir escopo, exclusões e critérios de aceite — IA e Humano.
    [ ] 1.3 Aprovar decisões necessárias e escopo — Humano.
    [ ] 1.4 Conferir Issue, Labels, Project e Milestone — Humano e IA.
    [ ] 1.5 Inspecionar Git e criar/publicar branch vinculada — IA e Humano.
    [ ] 1.6 Registrar autorização e responsáveis pela execução — Humano.
    Evidências: <referências breves aos itens concluídos>
    Pendências/decisões: <item — pergunta ou impedimento — responsável>

[ ] 2. Implementação
    [ ] 2.1 Executar alterações dentro do escopo autorizado — <Humano/IA>.
    [ ] 2.2 Cobrir comportamentos relevantes com testes pertinentes — IA.
    [ ] 2.3 Revisar diff e conferir escopo — IA.
    Evidências: <arquivos, revisão ou referências>
    Pendências/decisões: <preencher quando houver>

[ ] 3. Validação
    [ ] 3.1 Apresentar roteiro e resultados esperados — IA.
    [ ] 3.2 Executar verificações pelo responsável combinado — <Humano/IA>.
    [ ] 3.3 Conferir resultados e registrar limitações — IA.
    [ ] 3.4 Conferir critérios de aceite e aceite humano — IA e Humano.
    Evidências: <executor, ambiente, resultado e origem da evidência>
    Pendências/decisões: <preencher quando houver>

[ ] 4. Entrega e revisão
    [ ] 4.1 Revisar diff final e preparar commit — IA e Humano.
    [ ] 4.2 Executar commit e push — <responsável autorizado>.
    [ ] 4.3 Criar PR vinculada, com validação e metadados — Humano.
    [ ] 4.4 Concluir revisão humana e resolver observações — Humano e IA.
    Evidências: <commits, PR, metadados e aprovação>
    Pendências/decisões: <preencher quando houver>

[ ] 5. Integração
    [ ] 5.1 Realizar Merge commit — Humano.
    [ ] 5.2 Excluir branch remota pela interface GitHub — Humano.
    [ ] 5.3 Sincronizar main e remover branch local com segurança — Humano.
    [ ] 5.4 Conferir encerramento da Issue e atualizar Project — Humano/IA.
    Evidências: <merge, estado Git e situação da Issue/Project>
    Pendências/decisões: <preencher quando houver>

Ajustes solicitados pelo Humano:
<referenciar o item e descrever o ajuste, quando houver>

Próxima ação: <uma ação concreta — responsável>

Legenda:
[ ] Pendente.
[-] Em andamento.
[x] Concluído e validado, com evidência registrada.
[!] Bloqueado ou aguardando decisão/autorização necessária.
[?] Atenção, risco ou decisão relevante.
N/A — Não aplicável; registrar justificativa no próprio item.
```

Substituir os responsáveis entre `<...>` pelo executor combinado. Ajustar responsáveis predefinidos quando houver autorização específica, como criação de PR pela IA. Campos sem ocorrências podem ser preenchidos com `Nenhuma`, sem criar tarefas para preenchê-los.

## Procedimento por fase

### 1. Preparação

Criar a Issue antes de alterar arquivos, com objetivo, escopo, exclusões, critérios de aceite e labels pertinentes. Registrar decisões aprovadas e validações previstas. Inspecionar branch e alterações locais, preservando trabalho existente; criar e publicar a branch vinculada à Issue. Atualizar o Project com os campos existentes.

### 2. Implementação

Executar somente as alterações solicitadas no escopo aprovado. Manter mudanças pequenas e revisar o diff. Incluir testes relevantes conforme [testes.md](testes.md), sem testes que apenas repitam a implementação. Uma Issue pode conter vários commits com objetivos claros.

### 3. Validação

Apresentar comandos e roteiro manual proporcionais à mudança. O responsável combinado executa e compartilha resultados; registrar plataforma, evidências e limitações. Conferir critérios de aceite. Diferenciar testes de lógica Swift no Linux de compilação e interface iOS no macOS/Xcode. Alterações exclusivamente documentais podem ser validadas por leitura, conferência de referências e revisão do diff, sem builds ou testes de comportamento.

### 4. Entrega e revisão

Revisar o diff final e os arquivos preparados antes do commit. Executar commit e push pelo responsável autorizado; criar PR para `main`, vinculada à Issue, com problema, resultado, validações e limitações. Incluir `Closes #NUMERO` quando a PR resolver integralmente a Issue. Realizar revisão humana e resolver observações antes do merge. Integração direta em `main` exige exceção explícita para a alteração.

Ao apresentar os dados para criação de uma PR, informar sempre título, descrição, branches de origem/destino, **Labels**, **Projects** e **Milestone**. Usar metadados pertinentes à Issue e aos registros existentes; quando algum campo não se aplicar, declarar isso. Distinguir valores sugeridos de associações efetivamente conferidas no GitHub, sem presumir que os metadados da Issue foram copiados para a PR.

Conferir esses campos na PR antes da integração e registrar a evidência no item correspondente da fase 4, sem alterar a estrutura do modelo padrão.

### 5. Integração

Integrar por Merge commit, preservando commits individuais. Excluir a branch remota pela interface web do GitHub antes de sincronizar o repositório local. Conferir alterações locais, atualizar `main` e remover a branch local somente após confirmar a integração. Conferir encerramento da Issue e estado do Project; só então concluir o checklist da entrega.

## Convenções Git

### Branches

Seguir [Conventional Branch 1.1.0](https://conventionalbranch.org/pt-br/), com `tipo/NUMERO-descricao-curta`: `feature` para funcionalidades, `fix` para bugs, `hotfix` para correções urgentes e `chore` para manutenção/documentação e tarefas de suporte. Releases usam `release/vX.Y.Z`; a Issue permanece vinculada no GitHub.

Usar minúsculas ASCII, números e hífens, sem espaços, acentos, sublinhados ou hífens consecutivos, iniciais ou finais. Pontos são reservados às versões de release. Branches já publicadas como `issue/NUMERO-descricao-curta` podem concluir o fluxo como exceção de transição; não renomeá-las automaticamente.

### Commits

Seguir [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/): `tipo: descrição (#NUMERO)` ou `tipo(escopo): descrição (#NUMERO)`. Descrição em português e referência à Issue são convenções adicionais do projeto.

Usar `feat` para funcionalidades e `fix` para bugs; outros tipos pertinentes incluem `docs`, `test`, `refactor`, `chore`, `build`, `ci` e `perf`. Escopo, corpo e rodapés são opcionais; separar corpo e rodapés por linha em branco. Sinalizar mudanças incompatíveis com `!` antes de `:` ou rodapé `BREAKING CHANGE: descrição`.

## Registros

Issue e PR guardam requisitos, checklist da entrega e evidências; Project guarda prioridades e andamento. O chat acompanha a execução com o checklist editável. O Vault registra decisões e aprendizados com links para GitHub, sem quadro paralelo de tarefas. Este documento guarda o modelo, não o andamento de cada Issue.
