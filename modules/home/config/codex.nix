{
  config,
  lib,
  pkgs,
  ...
}:

let
  codexConfig = pkgs.writeText "codex-config.toml" ''
    model_reasoning_effort = "medium"
    sandbox_mode = "workspace-write"
    approval_policy = "on-request"
    approvals_reviewer = "auto_review"

    [sandbox_workspace_write]
    writable_roots = [
      "${config.home.homeDirectory}/Projects",
      "${config.home.homeDirectory}/Downloads",
      "${config.home.homeDirectory}/nixos-config",
    ]

    [projects."${config.home.homeDirectory}/nixos-config"]
    trust_level = "trusted"

    [tui.model_availability_nux]
    "gpt-5.5" = 1

    [tui.keymap.composer]
    submit = ["ctrl-enter"]

    [tui.keymap.editor]
    insert_newline = ["enter", "shift-enter"]
  '';
in

{
  home.activation.codexConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run rm -f "$HOME/.codex/config.toml"
    run install -Dm600 ${codexConfig} "$HOME/.codex/config.toml"
  '';
}
