# AGENTS.md

## Projeto

Aplicativo nativo para iPhone/iOS, em Swift e SwiftUI. Priorizar simplicidade e APIs nativas. Aprovar com o responsável decisões de produto, arquitetura, persistência, dependências e versão mínima do iOS; propostas não são requisitos aprovados.

## Autorização e execução

- Leituras, consultas e revisão de diffs são livres, inclusive pelo terminal. Edições solicitadas por ferramenta de edição podem ocorrer no escopo aprovado.
- Comandos de terminal que modifiquem arquivos ou sistemas, builds e testes são executados pelo usuário por padrão; execução pela IA exige autorização explícita. Apresentar objetivo, ações, impacto, riscos e verificação antes de solicitá-la.
- Aprovar um plano não autoriza sua execução. Respeitar o conjunto autorizado, inclusive correções e repetições previstas; pedir nova autorização somente para ações não cobertas.
- Commits, pushes, merges, instalações, configurações globais e operações destrutivas pela IA exigem autorização explícita. Não criar subagentes sem autorização.

## Checklist Humano ↔ IA

- Consultar obrigatoriamente [docs/fluxo-de-trabalho.md](docs/fluxo-de-trabalho.md) ao iniciar uma Issue e adotar seu modelo padrão em cada entrega, preservando cabeçalho, cinco fases, ordem, próxima ação e legenda. Atualizar estados e responsáveis; detalhar subitens sem substituir a estrutura.
- Usar fases e itens com identificadores estáveis: `1`, `1.1`, `1.2`. Cada item deve indicar estado, ação verificável e responsável (Humano ou IA).
- Estados: `[ ]` pendente; `[-]` em andamento; `[x]` concluído e validado; `[!]` bloqueado ou aguardando decisão/autorização; `[?]` atenção ou decisão relevante.
- Registrar executor e evidência ao concluir. Distinguir relato humano de resultado conferido pela IA; não afirmar validação sem evidência. Aprovação do escopo e autorização de execução são itens distintos.
- Concluir uma fase somente quando seus itens obrigatórios estiverem concluídos. Explicar bloqueios e quem pode resolvê-los; não marcar tarefa apenas futura como bloqueada.
- Ao encerrar cada etapa, mostrar a fase atual e resumir as anteriores, preservando pendências. Terminar com a próxima ação e seu responsável.

## Fluxo e Git

- Exigir Issue antes de alterar código, documentação ou configuração; propor escopo, exclusões, critérios de aceite e labels. Preservar alterações existentes e manter mudanças pequenas.
- Seguir: Issue → branch vinculada/publicada → alteração → validação → revisão do diff → commit → push → PR → revisão humana → merge.
- Branches novas seguem [Conventional Branch 1.1.0](https://conventionalbranch.org/pt-br/): `tipo/NUMERO-descricao-curta`, com `feature` para funcionalidades, `fix` para bugs, `hotfix` para correções urgentes e `chore` para manutenção/documentação; `release/vX.Y.Z` para releases. Usar minúsculas ASCII, números e hífens, sem espaços, acentos ou hífens consecutivos/iniciais/finais; pontos apenas nas versões. Branches já publicadas no padrão anterior `issue/NUMERO-descricao-curta` podem concluir seu fluxo como exceção de transição, sem renomeação automática.
- Commits seguem [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/): `tipo(escopo opcional): descrição em português (#NUMERO)`. Usar `feat` para funcionalidades, `fix` para bugs e tipos pertinentes como `docs`, `test`, `refactor`, `chore`, `build`, `ci` e `perf`; sinalizar incompatibilidades com `!` antes de `:` ou rodapé `BREAKING CHANGE: descrição`. Permitir vários commits com objetivos claros dentro da mesma Issue.
- PR vinculada à Issue, com evidências e limitações. Usar Merge commit; integração direta em `main` exige exceção explícita para a alteração.
- Após o merge, excluir a branch remota pela interface web do GitHub; depois sincronizar `main` e remover a branch local com segurança. Só então encerrar o checklist da entrega e conferir Issue/Project.

## Validação e DFE

- Inspecionar antes de editar. Seguir `docs/testes.md`, com verificações proporcionais e execução autorizada; não repetir testes sem necessidade.
- Distinguir lógica Swift validada no Linux de aplicativo/interface iOS validado em macOS/Xcode. Registrar plataforma, resultados e limitações.
- DFE somente quando solicitada ou com análise aprovada: consultar `.agents/skills/evidence-based-decisions/SKILL.md`. Não iniciar pesquisa extensa automaticamente.
- `../referências/livros/` é somente leitura; não modificar, versionar ou publicar PDFs.

## Documentação

- Manter `AGENTS.md` único, na raiz e versionado, como ponto de entrada das regras estáveis; não duplicá-lo no Vault.
- `docs/fluxo-de-trabalho.md` é a fonte única do modelo completo e do procedimento; `docs/testes.md` define a estratégia técnica de testes.
- Issue/PR guardam checklist e evidências da entrega; Project guarda prioridade e andamento; chat acompanha a execução; Vault guarda decisões e aprendizados com links, sem quadro paralelo de tarefas.
