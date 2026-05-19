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
      size                  = 1000;
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
      VISUAL = "nvim";
      EDITOR = "nvim";
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

      pbcopy = ''
        wl-copy
      '';

      pbpaste = ''
        wl-paste
      '';
    };

    syntaxHighlighting = {
      enable = true;
    };

    envExtra = ''
      [ -f "${config.sops.templates."api-tokens.env".path}" ] && source "${config.sops.templates."api-tokens.env".path}"
    '';

    initContent = lib.mkOrder 1500 ''
      bindkey '^A' beginning-of-line
      bindkey '^E' end-of-line
      bindkey '^F' forward-char
      bindkey '^B' backward-char
      bindkey '\ef' forward-word
      bindkey '\eb' backward-word
      bindkey '^K' kill-line
      bindkey '^U' backward-kill-line
      bindkey '^W' backward-kill-word
      bindkey '\ed' kill-word
      bindkey '^D' delete-char-or-list
      bindkey '^L' clear-screen
      neofetch
    '';

  };
}
