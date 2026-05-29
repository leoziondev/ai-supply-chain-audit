# Release Checklist

Use este checklist antes de publicar uma release ou tornar o repositorio publico.

## Conteudo

- [ ] README renderiza com banner, badges e links rapidos.
- [ ] Prompt principal preserva formato obrigatorio de findings.
- [ ] Checklists e exemplos usam dados ficticios ou sanitizados.
- [ ] Nenhum arquivo orienta clonar este toolkit dentro do projeto auditado por padrao.
- [ ] SECURITY.md explica como reportar problemas de conteudo.
- [ ] CHANGELOG.md registra a mudanca.

## Branding

- [ ] `assets/logo.svg` renderiza corretamente.
- [ ] `assets/banner.svg` renderiza corretamente no README.
- [ ] `assets/social-preview.svg` foi configurado como social preview do GitHub, se aplicavel.
- [ ] BRAND.md reflete nome, tagline, paleta e uso esperado.

## Validacao

- [ ] `powershell -ExecutionPolicy Bypass -File scripts/validate-content.ps1` passa localmente.
- [ ] GitHub Actions `Validate content` passa.
- [ ] Skill `skills/supply-chain-audit/SKILL.md` continua compacta.
- [ ] Issue templates e PR template foram revisados.

## Publicacao

- [ ] Repository description configurada com a descricao SEO curta.
- [ ] Topics adicionados: `supply-chain-security`, `appsec`, `devsecops`, `npm-security`, `composer`, `github-actions`, `lgpd`, `incident-response`.
- [ ] License detectada como MIT.
- [ ] Security policy habilitada.
