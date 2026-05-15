{...}: {
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPorts = [];
  };

  networking.hosts."127.0.0.1" = [
      "chatgpt.com" "www.chatgpt.com" "openai.com" "www.openai.com" "api.openai.com" "chat.openai.com" "platform.openai.com"

      "gemini.google.com" "bard.google.com" "ai.google.com" "makersuite.google.com"

      "anthropic.com" "www.anthropic.com" "claude.ai" "www.claude.ai" "api.anthropic.com"

      "perplexity.ai" "www.perplexity.ai" "labs.perplexity.ai" "api.perplexity.ai"

      "meta.ai" "www.meta.ai" "ai.facebook.com"

      "mistral.ai" "www.mistral.ai" "api.mistral.ai"

      "x.ai" "www.x.ai" "grok.x.ai" "api.x.ai"

      "cohere.com" "www.cohere.com" "api.cohere.ai"

      "cloud.ibm.com" "watson.ibm.com"
    ];
}
