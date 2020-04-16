#!/bin/bash

# 1. Criar um bot através do @BotFather (http://t.me/BotFather) 
#    enviando o comando /newbot e copiar o token (HTTP API).
# 2. Obter o seu ChatID, o que pode ser feito através do
#    bot @getidsbot (http://t.me/getidsbot) ou
#    @chatid_echo_bot (http://t.me/chatid_echo_bot).
# 3. Adicionar o script no crontab. Exemplo a cada 2min:
#    */2 * * * * uptimebot.sh >/dev/null 2>&1

BOT_TOKEN=""
CHAT_ID=""
CHECK_URL="httpstat.us/200?sleep=40000"
TIMEOUT="30"

FILE="/tmp/uptimebot.txt"
[[ ! -f "$FILE" ]] && touch "$FILE"

LAST_RESULT=$(curl "$CHECK_URL" -I -s -m $TIMEOUT | head -1)
if [[ -z "$LAST_RESULT" ]]; then
	LAST_RESULT="Timeout ${TIMEOUT}s"
fi

read -r -d '' MESSAGE <<- EOM
	*${LAST_RESULT}*
	$(sed "s/\([\.=]\)/\\\\\1/g" <<< $CHECK_URL)
EOM

if [[ $(< "$FILE") != "$LAST_RESULT" ]]; then
   curl "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
		--max-time 30 \
		--get \
		--data "chat_id=$CHAT_ID" \
		--data "parse_mode=MarkdownV2" \
		--data-urlencode "text=$MESSAGE" 
fi

echo "$LAST_RESULT" > "$FILE"
