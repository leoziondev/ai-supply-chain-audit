# Checklist: Composer / Laravel Supply Chain

## Manifestos e lockfiles

- [ ] `composer.json` revisado.
- [ ] `composer.lock` revisado e commitado.
- [ ] `composer install` usa lockfile em producao.
- [ ] Pacotes diretos e transitivos de alto risco foram identificados.
- [ ] Source URL, dist URL e referencias do lockfile foram conferidos.

## Execucao automatica

- [ ] `scripts` Composer revisados.
- [ ] `autoload.files` revisado.
- [ ] Plugins Composer revisados.
- [ ] Package discovery e service providers revisados.
- [ ] Includes diretos dentro de `vendor` foram justificados.

## Laravel runtime

- [ ] Providers, middleware, commands, jobs e schedulers revisados.
- [ ] `APP_DEBUG=false` em ambientes sensiveis.
- [ ] `.env` nao esta versionado nem exposto.
- [ ] Queues, cache e storage nao permitem execucao ou leitura indevida.
- [ ] Uploads e signed URLs foram revisados.

## Funcoes perigosas

- [ ] `exec`, `shell_exec`, `system`, `passthru`, `popen` e `proc_open` investigados.
- [ ] `eval`, `base64_decode`, `gzuncompress` e `unserialize` investigados.
- [ ] Processos PHP nao iniciam shells inesperados.
- [ ] Outbound nao HTTP/S e bloqueado quando possivel.

## Resposta a suspeita

- [ ] `composer.lock` preservado.
- [ ] Logs Laravel, PHP-FPM e web server preservados.
- [ ] `.env` e credenciais acessiveis ao processo PHP rotacionadas.
- [ ] Hosts reconstruidos se houve evidencia de RAT ou persistencia.
- [ ] Pacotes suspeitos removidos e substituidos por alternativas confiaveis.
