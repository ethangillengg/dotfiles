{port, ...}: {
  services.ollama = {
    enable = true;
    listenAddress = "0.0.0.0:${toString port}";
  };
}
