# telegram_uptime
Envia notificação via Telegram quando um site fica offline

## Instruções
* Criar um bot através do [@BotFather](http://t.me/BotFather) enviando o comando `/newbot` e copiar o token (HTTP API).
* Obter o seu ChatID, o que pode ser feito através do bot [@getidsbot](http://t.me/getidsbot) ou [@chatid_echo_bot](http://t.me/chatid_echo_bot).
* Adicionar o script no crontab. Exemplo a cada 2min:
```
*/2 * * * * uptimebot.sh >/dev/null 2>&1
```
