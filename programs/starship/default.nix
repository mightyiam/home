{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = let
      pink = "#FFC0CB";
      vertical = "[║](${pink})";
      sep = "sep";
    in {
      add_newline = false;
      ## https://starship.rs/config/#prompt
      format = builtins.concatStringsSep "" [
        "\n"
        "$\{custom.${sep}\}"
        vertical
        "$username"
        "$hostname"
        "$kubernetes"
        "$vcsh"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_metrics"
        "$git_status"
        "$hg_branch"
        "$docker_context"
        "$package"
        "$cmake"
        "$dart"
        "$deno"
        "$dotnet"
        "$elixir"
        "$elm"
        "$erlang"
        "$golang"
        "$helm"
        "$java"
        "$julia"
        "$kotlin"
        "$nim"
        "$nodejs"
        "$ocaml"
        "$perl"
        "$php"
        "$purescript"
        "$python"
        "$red"
        "$ruby"
        "$rust"
        "$scala"
        "$swift"
        "$terraform"
        "$vlang"
        "$vagrant"
        "$zig"
        "$nix_shell"
        "$conda"
        "$memory_usage"
        "$aws"
        "$gcloud"
        "$openstack"
        "$env_var"
        "$crystal"
        "$cmd_duration"
        "$lua"
        "$jobs"
        "$battery"
        "\n"
        vertical
        "$directory"
        "\n"
        vertical
        "$status"
        "[ $shell](bold ${pink})"
        "$shlvl"
        "$character"
      ];
      custom."${sep}" = {
        command = builtins.readFile "${./.}/${sep}.sh";
        when = "true";
        format = "[╓($output)\n]($style)";
        style = "bold ${pink}";
      };
      directory = {
        truncation_length = 0;
        format = "[ : $path]($style)[$read_only]($read_only_style) ";
      };
      shell.disabled = false;
      shlvl = {
        disabled = false;
        threshold = 3;
        style = "bold red";
        symbol = "";
      };
      status = {
        disabled = false;
        symbol = " ";
      };
      username = { show_always = true; format = "[  $user]($style) "; };
      git_branch = { format = "[$symbol$branch]($style) ";};
    };
  };
}
