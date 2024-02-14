# need this to to avoid the error:
# error: attempt to call something which is not a function but a set
{...}: {
  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };
}
