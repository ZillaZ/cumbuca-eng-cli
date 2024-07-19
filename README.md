# Desafio CLI Cumbuca
Minha solução para o desafio CLI da Cumbuca.

1. [Preparando o ambiente](#preparando-o-ambiente)
2. [Executando a solução](#executando-a-solução)

## Preparando o ambiente
Existem duas formas de executar a solução.
- [Localmente](#local)
- [Docker Compose](#docker)

### Local
Primeiro, será necessário [instalar o Elixir](https://elixir-lang.org/install.html)
em versão igual ou superior a 1.16.

Se você utiliza NixOs, pode apenas executar `nix-shell` após clonar o repositório, pois ele tem um shell.nix pronto.

Clone o repositório e o accesse:
```
git clone https://github.com/ZillaZ/cumbuca-eng-cli
cd cumbuca-eng-cli
```

### Docker
Primeiro, você precisa ter o [docker](https://docs.docker.com/desktop/install/linux-install) e o [docker compose](https://docs.docker.com/compose/install) instalados.

Com o docker e docker compose instalados, é só iniciar a CLI usando o docker compose:
```
docker compose up
docker compose run royal
```

## Executando a solução

Para rodar os testes, utilize `mix test`. Para executar o programa normalmente, compile a solução com `mix escript.build` e execute o programa com `./desafio_cli`
