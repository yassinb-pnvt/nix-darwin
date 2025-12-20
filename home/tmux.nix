{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    disableConfirmationPrompt = true;
    historyLimit = 10000;
    prefix = "C-b";
    sensibleOnTop = false;
    shell = "/run/current-system/sw/bin/fish";
    shortcut = "a";
    mouse = true;
    keyMode = "vi";
    escapeTime = 10;
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.cpu;
      }
      {
        plugin = tmuxPlugins.battery;
      }
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          # Set default terminal with truecolor support for transparency
          set-option -g default-terminal "tmux-256color"
          
          # Enable truecolor/RGB for transparency support
          set-option -sa terminal-overrides ",xterm*:Tc"
          set-option -sa terminal-overrides ",*256col*:Tc"

          # Configure the catppuccin plugin
          set -g @catppuccin_flavor "mocha"
          set -g @catppuccin_window_status_style "rounded"

          # Make the status line pretty and add some modules
          set -g status-right-length 100
          set -g status-left-length 100
          set -g status-left ""
          set -g status-right "#{E:@catppuccin_status_application}"
          set -agF status-right "#{E:@catppuccin_status_cpu}"
          set -ag status-right "#{E:@catppuccin_status_session}"
          set -ag status-right "#{E:@catppuccin_status_uptime}"
          set -agF status-right "#{E:@catppuccin_status_battery}"
          '';
      }
    ];
    extraConfig = ''
      if-shell "uname | grep -q Darwin" {
        bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel 'reattach-to-user-namespace pbcopy'
        bind-key -T copy-mode-vi Enter send -X copy-pipe-and-cancel 'reattach-to-user-namespace pbcopy'
      } {
        bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
        bind-key -T copy-mode-vi Enter send -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
      }

      # Enable truecolor/RGB support for transparency
      # This allows applications like lvim to use transparent backgrounds in tmux
      set -as terminal-features ",*:RGB"
      set-option -ga terminal-overrides ",*256col*:RGB"
      set-option -ga terminal-overrides ",xterm-256color:RGB"
      set-option -ga terminal-overrides ",tmux-256color:RGB"
      set-option -ga terminal-overrides ",screen-256color:RGB"
      
      # Enable truecolor capability
      set-option -ga terminal-overrides ",*:Tc"
      
      # Don't set a pane background - allow terminal transparency to show through
      set-option -g pane-active-border-style "fg=default"
      set-option -g pane-border-style "fg=default"
      
      # Set window style to allow transparency (no background color)
      set-option -g window-style "default"
      set-option -g window-active-style "default"
      
      # Don't set a default background color - preserve terminal transparency
      set-option -g default-command ""

      # bind == bind-key
      bind-key c new-window -c "#{pane_current_path}"

      # vim-like pane switching
      bind ^ last-window
      bind k select-pane -U
      bind j select-pane -D
      bind h select-pane -L
      bind l select-pane -R
      
      run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux
      run-shell ${pkgs.tmuxPlugins.battery}/share/tmux-plugins/battery/battery.tmux
      run-shell ${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/tmux/catppuccin.tmux
    '';
  };
}
