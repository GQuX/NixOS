{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.git = {
    enable = true;

    userName = "GQuX";
    userEmail = "github.gqux@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;

      # SSH transport configuration (default to personal)
      core.sshCommand = "ssh -i ~/.ssh/id_rsa_personal";

      # URL rewriting for different GitHub accounts
      url = {
        "git@github-personal:" = {
          insteadOf = "https://github.com/GQuX/";
        };
        "git@github-work:" = {
          insteadOf = "https://github.com/GQuX/";
        };
      };

      # Conditional configuration based on directory
      includeIf = {
        "gitdir:~/Code/projects/streamex/" = {
          path = "~/.config/git/work";
        };
      };
    };
  };

  # Create conditional git config for work projects
  home.file.".config/git/work".text = ''
    [user]
      name = GQuX
      email = github.gqux@gmail.com
    [core]
      sshCommand = ssh -i ~/.ssh/id_rsa_work
  '';
}

