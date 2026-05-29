# Exemplo: Auditoria Laravel / Composer

Este exemplo mostra como preparar uma entrada para o prompt principal ao investigar uma aplicacao Laravel com suspeita de pacote Composer malicioso.

## Objetivo do exemplo

Validar se o LLM consegue identificar:

- Pacotes Composer suspeitos.
- Service providers e autoloaders como pontos de execucao.
- Risco de RAT ou persistencia em runtime PHP.
- Exposicao de `.env` e credenciais de banco/cloud.
- Necessidade de revisar `composer.lock`, logs e trafego de rede.

## Arquivos que o usuario deve fornecer

```text
composer.json
composer.lock
package.json, se o projeto Laravel tambem usa build frontend
package-lock.json, pnpm-lock.yaml ou yarn.lock, se existirem
.env.example
config/*
app/Providers/*
app/Jobs/*
app/Console/*
routes/*
storage/logs/laravel.log, se possivel
Dockerfile
.github/workflows/*
```

## Entrada de exemplo para o LLM

Use o prompt em `prompts/supply-chain-security-audit.md` e anexe os arquivos abaixo.

### composer.json

```json
{
  "require": {
    "php": "^8.3",
    "laravel/framework": "^11.0",
    "guzzlehttp/guzzle": "^7.9",
    "lara-helper/lara-helper": "^1.2",
    "simple-queue/simple-queue": "^2.0"
  },
  "autoload": {
    "psr-4": {
      "App\\": "app/"
    },
    "files": [
      "bootstrap/helpers.php",
      "vendor/lara-helper/lara-helper/src/bootstrap.php"
    ]
  },
  "scripts": {
    "post-autoload-dump": [
      "Illuminate\\Foundation\\ComposerScripts::postAutoloadDump",
      "@php artisan package:discover --ansi"
    ]
  }
}
```

### app/Providers/AppServiceProvider.php

```php
<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    public function boot(): void
    {
        if (app()->environment('production')) {
            include base_path('vendor/lara-helper/lara-helper/src/runtime.php');
        }
    }
}
```

### .env.example

```dotenv
APP_ENV=production
APP_DEBUG=false
APP_KEY=
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_DATABASE=app
DB_USERNAME=app
DB_PASSWORD=
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
```

### .github/workflows/deploy.yml

```yaml
name: deploy

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: shivammathur/setup-php@v2
        with:
          php-version: "8.3"
      - run: composer install --no-interaction --prefer-dist --optimize-autoloader
        env:
          COMPOSER_AUTH: ${{ secrets.COMPOSER_AUTH }}
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      - run: php artisan config:cache
```

## Riscos que o prompt deve encontrar

- Pacotes Laravel de exemplo com nomes genericos devem ser tratados como suspeitos e confirmados contra Packagist, lockfile e codigo fonte.
- `autoload.files` executa PHP automaticamente quando o autoloader e carregado.
- Service provider inclui codigo dentro de `vendor` em producao.
- `composer install` roda com credenciais cloud e `COMPOSER_AUTH` disponiveis.
- Se um pacote malicioso executou, `.env`, banco, S3 e secrets devem ser considerados expostos.
- Falta `composer.lock` impede confirmar versao, hash, source URL e dist URL.

## Formato esperado da resposta

O LLM deve produzir findings no formato:

| ID | Severidade | Categoria | Evidencia | Impacto | IOC | MITRE ATT&CK | Exploitabilidade | Correcao |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| PHP-001 | Alto | Composer autoload abuse | `composer.json` inclui `vendor/.../bootstrap.php` em `autoload.files` | Codigo de dependencia executa no boot da aplicacao | `autoload.files`, `lara-helper/lara-helper` | T1195.002, T1059 | Executa quando autoloader carrega | Remover pacote, validar `composer.lock`, rotacionar secrets se executado em ambiente com credenciais |

## Validacoes manuais recomendadas

```bash
composer audit
composer show -t
grep -R "autoload.*files\|shell_exec\|proc_open\|base64_decode\|gzuncompress" composer.json app vendor 2>/dev/null
grep -R "lara-helper\|simple-queue" composer.json composer.lock vendor 2>/dev/null
```

Se houver evidencia de execucao de pacote suspeito em producao, preserve logs antes de redeploy ou limpeza.
