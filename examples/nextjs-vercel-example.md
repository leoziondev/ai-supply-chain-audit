# Exemplo: Auditoria Next.js / Vercel

Este exemplo mostra como preparar uma entrada para o prompt principal ao investigar um app Next.js que usa middleware para autorizacao e possui deploy em Vercel e ambiente self-hosted.

## Objetivo do exemplo

Validar se o LLM consegue identificar:

- Versao de Next.js vulneravel a bypass de middleware.
- Middleware usado como unica barreira de autorizacao.
- Rewrites para backend externo sem auth duplicada.
- Risco diferente entre deploy Vercel e self-hosted.
- Necessidade de revisar env vars, deployments e logs de plataforma.

## Arquivos que o usuario deve fornecer

```text
package.json
package-lock.json ou pnpm-lock.yaml
next.config.js
middleware.ts
app/**/*
pages/**/*
vercel.json
.github/workflows/*
Vercel activity logs
lista de deployments recentes
inventario de environment variables
```

## Entrada de exemplo para o LLM

Use o prompt em `prompts/supply-chain-security-audit.md` e anexe os arquivos abaixo.

### package.json

```json
{
  "name": "billing-portal",
  "private": true,
  "scripts": {
    "build": "next build",
    "start": "next start"
  },
  "dependencies": {
    "next": "15.2.1",
    "react": "19.0.0",
    "react-dom": "19.0.0"
  }
}
```

### middleware.ts

```ts
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export function middleware(request: NextRequest) {
  const session = request.cookies.get("session")?.value;

  if (!session && request.nextUrl.pathname.startsWith("/admin")) {
    return NextResponse.redirect(new URL("/login", request.url));
  }

  return NextResponse.next();
}

export const config = {
  matcher: ["/admin/:path*", "/billing/:path*"],
};
```

### next.config.js

```js
module.exports = {
  async rewrites() {
    return [
      {
        source: "/internal-api/:path*",
        destination: "https://backend.internal.example/:path*",
      },
    ];
  },
  productionBrowserSourceMaps: true,
};
```

### vercel.json

```json
{
  "framework": "nextjs",
  "env": {
    "NEXT_PUBLIC_ANALYTICS_ID": "demo-public-id"
  }
}
```

## Riscos que o prompt deve encontrar

- `next@15.2.1` esta abaixo da versao corrigida para CVE-2025-29927 na linha 15.x.
- `middleware.ts` parece ser a unica barreira para `/admin` e `/billing`.
- Apps self-hosted precisam bloquear requests externos com `x-middleware-subrequest` se nao puderem atualizar imediatamente.
- `rewrites` para backend externo exigem autorizacao no backend, nao apenas na borda Next.js.
- `productionBrowserSourceMaps: true` pode expor codigo e rotas sensiveis.
- O caso Vercel deve acionar revisao de env vars, activity logs e deployments, mas nao afirmar pacote npm comprometido sem evidencia.

## Formato esperado da resposta

O LLM deve produzir findings no formato:

| ID | Severidade | Categoria | Evidencia | Impacto | IOC | MITRE ATT&CK | Exploitabilidade | Correcao |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| NEXT-001 | Critico | Middleware auth bypass | `package.json` usa `next@15.2.1`; `middleware.ts` protege `/admin` | Atacante pode tentar bypass de auth se a app depende apenas do middleware | `next@15.2.1`, `/admin`, `x-middleware-subrequest` | T1190 | Remoto, sem auth, se self-hosted sem mitigacao | Atualizar Next.js, bloquear header externo, duplicar auth nos route handlers/backend |

## Validacoes manuais recomendadas

```bash
npm ls next react react-dom react-server-dom-webpack react-server-dom-turbopack
grep -R "middleware\|rewrites\|productionBrowserSourceMaps\|use server" next.config.* middleware.* app pages src 2>/dev/null
```

Nao use testes ofensivos contra ambientes de terceiros. Valide em ambiente autorizado e registre logs.
