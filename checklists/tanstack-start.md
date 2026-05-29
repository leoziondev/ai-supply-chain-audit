# Checklist: TanStack Start / Router Supply Chain

## Dependencias `@tanstack/*`

- [ ] `package.json` e lockfile revisados para todos os pacotes `@tanstack/*`.
- [ ] Versoes instaladas foram comparadas contra advisories recentes.
- [ ] Installs na janela de 2026-05-11 19:20-19:26 UTC foram investigados quando aplicavel.
- [ ] Dependencias git, `optionalDependencies` e pacotes fora do registry foram avaliados.
- [ ] Tarballs suspeitos foram inspecionados sem executar install scripts.

## Indicadores do incidente TanStack

- [ ] Presenca de `@tanstack/setup` investigada.
- [ ] Presenca de `router_init.js` investigada.
- [ ] Presenca de `tanstack_runner.js` investigada.
- [ ] Git ref `github:tanstack/router#79ac49eedf774dd4b0cfa308722bc463cfe5885c` investigado.
- [ ] Outbound para `filev2.getsession.org` ou `seed*.getsession.org` investigado em logs.

## Server functions e fronteiras

- [ ] `createServerFn` usa validacao runtime de input.
- [ ] Server functions exigem auth e autorizacao por request.
- [ ] Middleware de server function foi revisado.
- [ ] CSRF e metodos HTTP foram avaliados.
- [ ] Client-sent context nao e tratado como confiavel.

## Env vars e bundle cliente

- [ ] Env vars sao lidas em contexto server-side apropriado.
- [ ] Secrets nao sao lidos em module scope quando isso pode vazar ou quebrar em edge runtimes.
- [ ] Bundles e source maps foram revisados para secrets.
- [ ] Logs de server functions nao imprimem tokens ou dados sensiveis.

## Resposta a suspeita

- [ ] Lockfile e install logs preservados.
- [ ] Credenciais acessiveis ao install process foram rotacionadas.
- [ ] Hosts/runners que executaram install foram reconstruidos.
- [ ] Pacotes foram pinados para versoes conhecidas como boas.
- [ ] Cache de package manager e GitHub Actions foi invalidado.
