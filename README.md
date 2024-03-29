# conventional-commits
Hooks e script de geração de versão semântica através do conventional commits

## Pre-requisitos
O computador deve ter instalado a(s) tecnologia(s):
- git (https://git-scm.com/)

> [!IMPORTANT]
> Se você está usando o sistema operacional Windows, deve executar todos os comandos atraves da aplicação "git bash"

## Instalação do hooks localmente
Se você deseja instalar o hook em sua máquina, execute dentro da pasta do projeto o script abaixo:
```bash
bash setup.sh
```
Para verificar se foi instalado corretamente, execute o comando:
```bash
git config --global --list | grep .git-template
```
Verifique se as linhas com as chaves `core.hookspath` e `init.templatedir` são exibidas.
Veja a imagem abaixo para ver um exemplo de resposta esperada:

![image](https://github.com/joaojuniormail/conventional-commits/assets/7514536/0697faca-a702-458f-97d8-ca4360faac1b)

Pronto! Você já está com o hook instalado em sua máquina e a partir de agora, todos os seus commits serão validados se seguem o conventional commits. :champagne: :tada:

## Execução de geração de versão automatizada
Para verificar qual será a práxima versão de release, execute o comando:
```bash
bash generateVersion.sh
```
Para gerar uma nova versão de release, gerando uma tag, execute o comando:
```bash
bash generateVersion.sh true
```
