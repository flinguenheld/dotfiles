{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # nodePackages_latest.nodemon
    nodePackages_latest.vscode-langservers-extracted
    nodePackages_latest.yaml-language-server

    nodePackages_latest.bash-language-server
    shellcheck

    # nodePackages_latest.graphql-language-service-cli

    vscode-langservers-extracted # css, json, html,eslint, markdown, all in one
    vue-language-server
    # lua-language-server
    marksman
    markdown-oxide
    nil
    emmet-language-server
    # buf-language-server
    cmake-language-server
    vscode-extensions.vadimcn.vscode-lldb
    slint-lsp
    terraform-ls
    hyprls

    harper
  ];  
}
