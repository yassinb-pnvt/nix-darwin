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
        plugin = tmuxPlugins.catppuccin;
        # extraConfig = "set -g @catppuccin_flavour 'latte'";
        extraConfig = "set -g @catppuccin_flavour 'mocha'";
      }
    ];

    extraConfig = ''
      set-option -ga terminal-overrides ",xterm-256color:Tc"
      set-option -g default-terminal "tmux-256color"

      # bind == bind-key
      bind-key -r f run-shell "~/.config/nix-darwin/home/dotfiles/scripts/tmux-sessionizer.sh"
      bind-key c new-window -c "#{pane_current_path}"

      # setw -g mode-keys vi
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
      bind P paste-buffer

      # vim-like pane switching
      bind ^ last-window
      bind k select-pane -U
      bind j select-pane -D
      bind h select-pane -L
      bind l select-pane -R

      # window_activity is last time of activity in current window in unix time
      # formatting is done with strftime, see man strftime for more information
      # set -g status-right "maxrn #{t/f/%%H#:%%M %%Y-%%-m-%%d %%A:window_activity} "

      # So session name doesn't get cut off
      set -g status-left-length 30 # could be any number

      # TokyoNight colors for Tmux
      # from: https://github.com/folke/tokyonight.nvim/tree/main/extras/tmux
      #
      # set -g mode-style "fg=#7aa2f7,bg=#3b4261"
      #
      # set -g message-style "fg=#7aa2f7,bg=#3b4261"
      # set -g message-command-style "fg=#7aa2f7,bg=#3b4261"
      #
      # set -g pane-border-style "fg=#3b4261"
      # set -g pane-active-border-style "fg=#7aa2f7"
      #
      # set -g status "on"
      # set -g status-justify "left"
      #
      # set -g status-style "fg=#7aa2f7,bg=#1f2335"
      #
      # set -g status-left-length "100"
      # set -g status-right-length "100"
      #
      # set -g status-left-style NONE
      # set -g status-right-style NONE
      #
      # set -g status-left "#[fg=#1d202f,bg=#7aa2f7,bold] #S #[fg=#7aa2f7,bg=#1f2335,nobold,nounderscore,noitalics]"
      # set -g status-right "#[fg=#1f2335,bg=#1f2335,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#1f2335] #{prefix_highlight} #[fg=#3b4261,bg=#1f2335,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261] %Y-%m-%d  %I:%M %p #[fg=#7aa2f7,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#1d202f,bg=#7aa2f7,bold] #h "
      # if-shell '[ "$(tmux show-option -gqv "clock-mode-style")" == "24" ]' {
      # set -g status-right "#[fg=#1f2335,bg=#1f2335,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#1f2335] #{prefix_highlight} #[fg=#3b4261,bg=#1f2335,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261] %Y-%m-%d  %H:%M #[fg=#7aa2f7,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#1d202f,bg=#7aa2f7,bold] #h "
      # }
      #
      # setw -g window-status-activity-style "underscore,fg=#a9b1d6,bg=#1f2335"
      # setw -g window-status-separator ""
      # setw -g window-status-style "NONE,fg=#a9b1d6,bg=#1f2335"
      # setw -g window-status-format "#[fg=#1f2335,bg=#1f2335,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#1f2335,bg=#1f2335,nobold,nounderscore,noitalics]"
      # setw -g window-status-current-format "#[fg=#1f2335,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261,bold] #I  #W #F #[fg=#3b4261,bg=#1f2335,nobold,nounderscore,noitalics]"
      #
      # # tmux-plugins/tmux-prefix-highlight support
      # set -g @prefix_highlight_output_prefix "#[fg=#e0af68]#[bg=#1f2335]#[fg=#1f2335]#[bg=#e0af68]"
      # set -g @prefix_highlight_output_suffix ""
    '';
  };
}
