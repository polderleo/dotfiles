# Copied and stripped down from:
# https://github.com/nix-community/home-manager/blob/master/modules/programs/tmux.nix

{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.programs.my-tmux;

  pluginName = p: if types.package.check p then p.pname else p.plugin.pname;

  pluginModule = types.submodule {
    options = {
      plugin = mkOption {
        type = types.package;
        description = "Path of the configuration file to include.";
      };

      extraConfig = mkOption {
        type = types.lines;
        description = "Additional configuration for the associated plugin.";
        default = "";
      };
    };
  };

  configPlugins = {
    assertions = [
      (
        let
          hasBadPluginName = p: !(hasPrefix "tmuxplugin" (pluginName p));
          badPlugins = filter hasBadPluginName cfg.plugins;
        in
        {
          assertion = badPlugins == [ ];
          message = ''Invalid tmux plugin (not prefixed with "tmuxplugins"): ''
            + concatMapStringsSep ", " pluginName badPlugins;
        }
      )
    ];

    xdg.configFile."tmux/tmux.conf".text = ''
      # ============================================= #
      # Load plugins with Home Manager                #
      # --------------------------------------------- #

      ${(concatMapStringsSep "\n\n" (p: ''
        # ${pluginName p}
        # ---------------------
        ${p.extraConfig or ""}
        run-shell ${if types.package.check p then p.rtp else p.plugin.rtp}
      '') cfg.plugins)}
      # ============================================= #
    '';
  };

in
{
  options = {
    programs.my-tmux = {
      enable = mkEnableOption "tmux";

      package = mkOption {
        type = types.package;
        default = pkgs.tmux;
        defaultText = literalExpression "pkgs.tmux";
        example = literalExpression "pkgs.tmux";
        description = "The tmux package to install";
      };

      configuration = mkOption {
        type = types.lines;
        default = "";
        description = ''
          Configuration for {file}`tmux.conf`.
        '';
      };

      plugins = mkOption {
        type = with types;
          listOf (either package pluginModule) // {
            description = "list of plugin packages or submodules";
          };
        description = ''
          List of tmux plugins to be included at the end of your tmux
          configuration.
        '';
        default = [ ];
        example = literalExpression ''
          with pkgs.tmuxPlugins; [
            sensible
            cpu
            resurrect
          ]
        '';
      };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    { home.packages = [ cfg.package ]; }
    { xdg.configFile."tmux/tmux.conf".text = mkBefore cfg.configuration; }
    (mkIf (cfg.plugins != [ ]) configPlugins)
  ]);
}
