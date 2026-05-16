{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    autocd = true;

    dirHashes = {
      dc = "$HOME/Documents";
      dn = "$HOME/Downloads";
      dr = "$HOME/My Drive";
      dt = "$HOME/Desktop";
    };

    history = {
      append                = true;
      save                  = 1000;
      size                  = 999;
      findNoDups            = true;
      saveNoDups            = false;
      ignoreDups            = true;
      ignoreSpace           = false;
      expireDuplicatesFirst = true;
    };

    localVariables = {
      PROMPT = "$ ";
    };

    sessionVariables = {
      LANG = "en_US.UTF-8";
      VISUAL = "vim";
      EDITOR = "vim";
      PS1 = "$ ";
    };

    shellAliases = {
      a = ''
        eza --all --color=always --grid --icons=always
      '';

      s = ''
        eza --color=always --grid --icons=always
      '';

      tree = ''
        eza --tree --color=always
      '';

      l = ''
        cd "$(command lf -print-last-dir "$@")"
      '';

      ".." = ''
        cd ..
      '';
    };

    syntaxHighlighting = {
      enable = true;
    };

    envExtra = ''
      [ -f "${config.sops.templates."api-tokens.env".path}" ] && source "${config.sops.templates."api-tokens.env".path}"
    '';

    initContent = lib.mkOrder 1500 ''
      neofetch
    '';

  };
}
