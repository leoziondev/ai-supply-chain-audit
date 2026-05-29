# Checklist: Next.js Security e Supply Chain

## Versoes e advisories

- [ ] Versao de `next` conferida no `package.json` e lockfile.
- [ ] CVE-2025-29927 avaliado para apps que usam middleware para auth.
- [ ] Pacotes `react-server-dom-webpack`, `react-server-dom-parcel` e `react-server-dom-turbopack` revisados quando RSC/Server Functions existem.
- [ ] Versoes corrigidas foram aplicadas dentro da release line suportada.
- [ ] Diferenca entre Vercel-hosted e self-hosted foi documentada.

## Middleware e autorizacao

- [ ] `middleware.ts` ou `middleware.js` revisado.
- [ ] Middleware nao e a unica barreira de autorizacao para rotas sensiveis.
- [ ] Backend, route handlers e APIs validam sessao/permissao novamente.
- [ ] Requests externos com `x-middleware-subrequest` sao bloqueados quando aplicavel.
- [ ] Rotas admin, billing, export e dados sensiveis foram testadas sem depender apenas de UI.

## Rewrites, proxy e headers

- [ ] `next.config.*` revisado para `rewrites`, `redirects` e `headers`.
- [ ] Rewrites para backends externos exigem auth no backend de destino.
- [ ] Metodos `DELETE` e `OPTIONS` em rewrites foram avaliados.
- [ ] `Transfer-Encoding` e `Content-Length` sao tratados por edge/proxy confiavel.
- [ ] CORS, CSP, clickjacking e cookies foram revisados.

## Server Actions, RSC e data boundaries

- [ ] Server Actions recebem validacao runtime de input.
- [ ] Dados sensiveis nao sao serializados para client components.
- [ ] `use server` e route handlers foram inventariados.
- [ ] Source maps publicos foram avaliados.
- [ ] Secrets nao aparecem em bundles, logs ou erro de hydration.

## Resposta a suspeita

- [ ] Versao vulneravel e janela de exposicao foram registradas.
- [ ] Logs de requests para rotas protegidas foram preservados.
- [ ] Rotas acessadas durante a janela foram revisadas.
- [ ] Tokens de sessao, API keys ou cookies sensiveis foram rotacionados quando necessario.
- [ ] Deploy corrigido foi validado em ambiente equivalente ao de producao.
