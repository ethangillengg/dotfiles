{
  bash,
  coreutils,
  curl,
  fetchFromGitHub,
  gnugrep,
  gnused,
  gawk,
  iproute2,
  jq,
  lib,
  resholve,
  wireguard-tools,
  openresolv,
}:
resholve.mkDerivation rec {
  pname = "wgnord";
  version = "0.2.2";

  src = fetchFromGitHub {
    owner = "phirecc";
    repo = pname;
    rev = "0.2.2";
    hash = "sha256-K7O3SI24bkaLuEF+7FmbXUx7H0gPKsLttEmSCc3PT2c=";
  };

  postPatch = ''
    substituteInPlace wgnord \
      --replace '$conf_dir/countries.txt' "$out/share/countries.txt" \
      --replace '$conf_dir/countries_iso31662.txt' "$out/share/countries_iso31662.txt" \
      --replace '/var/lib/wgnord' "/etc/var/lib/wgnord" \
  '';

  dontBuild = true;

  installPhase = ''
    install -Dm 755 wgnord -t $out/bin/
    install -Dm 644 countries.txt -t $out/share/
    install -Dm 644 countries_iso31662.txt -t $out/share/
    install -Dm 644 template.conf -t $out/share/
  '';

  solutions.default = {
    scripts = ["bin/wgnord"];
    interpreter = "${bash}/bin/sh";
    inputs = [
      coreutils
      curl
      gnugrep
      gnused
      gawk
      iproute2
      jq
      wireguard-tools
      openresolv
    ];
    fake = {
      alias = ["query"];
    };

    execer = [
      "cannot:${iproute2}/bin/ip"
      "cannot:${wireguard-tools}/bin/wg-quick"
    ];
  };

  meta = with lib; {
    description = "A NordVPN Wireguard (NordLynx) client in POSIX shell";
    homepage = "https://github.com/phirecc/wgnord";
    changelog = "https://github.com/phirecc/wgnord/releases/tag/v${version}";
    maintainers = with lib.maintainers; [urandom];
    license = licenses.mit;
  };
}
