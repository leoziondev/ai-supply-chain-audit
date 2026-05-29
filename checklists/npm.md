# Checklist: npm / Node.js Supply Chain

## Manifestos e lockfiles

- [ ] `package.json` revisado.
- [ ] `package-lock.json`, `pnpm-lock.yaml` ou `yarn.lock` revisado.
- [ ] Manifest e lockfile estao consistentes.
- [ ] Ranges permissivos (`^`, `~`, `latest`, `*`) avaliados.
- [ ] Dependencias recem-adicionadas foram justificadas.
- [ ] Dependencias transitivas criticas foram identificadas.

## Scripts e execucao automatica

- [ ] `preinstall`, `install`, `postinstall`, `prepare` e `prepublishOnly` revisados.
- [ ] Pacotes com campo `bin` revisados.
- [ ] Uso de `child_process`, `exec`, `spawn`, `curl`, `wget` ou PowerShell investigado.
- [ ] Build de triagem pode rodar com `npm ci --ignore-scripts`.
- [ ] Scripts de instalacao nao recebem secrets desnecessarios.

## Registry e identidade do pacote

- [ ] Nomes similares a pacotes populares foram checados.
- [ ] `repository`, `homepage`, `bugs` e maintainer metadata foram revisados.
- [ ] Pacotes recem-criados ou com versao inflada foram investigados.
- [ ] Pacotes removidos, yanked ou com ownership alterado foram verificados.
- [ ] Uso de registry privado/publico esta explicito em `.npmrc`.

## CI/CD e secrets

- [ ] `npm install` ou `npm ci` nao rodam com tokens de publish/cloud sem necessidade.
- [ ] `NPM_TOKEN`, GitHub token e cloud credentials sao escopados e rotacionaveis.
- [ ] Publicacao npm ocorre em job separado e minimo.
- [ ] Cache de `node_modules` nao mistura branches confiaveis e nao confiaveis.

## Resposta a suspeita

- [ ] Lockfile preservado.
- [ ] Logs de build preservados.
- [ ] Tokens expostos rotacionados.
- [ ] Runner/host reconstruido se houve execucao de pacote suspeito.
- [ ] IOCs adicionados a proxy, DNS, EDR ou SIEM.
