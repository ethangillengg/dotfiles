{port, ...}: {
  services.ollama = {
    enable = false;
    listenAddress = "0.0.0.0:${toString port}";
  };
}
