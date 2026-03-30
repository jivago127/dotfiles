{ config, pkgs, ... }:

{
  # Versão do Home Manager (ajuste conforme seu sistema)
  home.stateVersion = "25.11"; 

  # Pacotes específicos do seu usuário
  home.packages = with pkgs; [
    andromeda-gtk-theme
    papirus-icon-theme
    temurin-bin-25 
  ];

  # Configuração do Zsh e Oh My Zsh
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      # plugins = [ "git" ];
      theme = "agnoster"; # Sinta-se à vontade para mudar
    };
  };
	# A identação tá ficando uma droga
	programs.gh.enable = true;
	programs.gh.gitCredentialHelper.enable = true;

  # Configuração do Tema GTK (Andromeda)
  gtk = {
    enable = true;
    theme = {
      name = "Andromeda";
      package = pkgs.andromeda-gtk-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  # Cursor (Opcional, mas combina com o Andromeda)
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
  };

 programs.java = {
 	enable = true;
	package = pkgs.temurin-bin-25;
 };
}
