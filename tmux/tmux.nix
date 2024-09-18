{ pkgs, configDir, ... }:
{
  programs.my-tmux = {
    enable = true;
    configuration = ''
      # Include my configuration
      source-file ${configDir}/tmux/custom.conf
    '';
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.yank
      tmuxPlugins.resurrect
      {
        plugin = tmuxPlugins.better-mouse-mode;
        extraConfig = ''
          set -g @scroll-speed-num-lines-per-scroll 1
        '';
      }
    ];
  };
}
