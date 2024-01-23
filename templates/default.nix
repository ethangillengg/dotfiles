rec {
  hw = {
    path = ./hw;
    description = "A simple template for homework in LaTeX";

    welcomeText = ''
      # LaTeX Homework Template
      ${hw.description}

      ## Usage
      - To watch for changes, run `nix run .#watch`
      - To compile into a PDF, run `nix build`
    '';
  };
  default = hw;
}
