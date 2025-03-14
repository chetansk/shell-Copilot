aiHelp() {
    if [ -z "$1" ]; then
        echo "Usage: aiHelp \"your question here\""
        return 1
    fi

    API_KEY="Your API Key"
    ## Go to https://platform.openai.com/api-keys to generate API key
    SYSTEM_PROMPT="You are an AI assistant that provides precise, technical responses to user queries on bash shell. The user is running bash shell on $OSTYPE operating system on $MACHTYPE machine."

    RESPONSE=$(curl -s https://api.openai.com/v1/chat/completions \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $API_KEY" \
        -d '{
            "model": "gpt-4",
            "messages": [
                {"role": "system", "content": "'"$SYSTEM_PROMPT"'"},
                {"role": "user", "content": "'"$1"'"}
            ],
            "max_tokens": 200
        }')

    echo "$RESPONSE" | jq -r '.choices[0].message.content'
}
