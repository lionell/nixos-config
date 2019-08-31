# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot = {
    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable      = true;
      efi.canTouchEfiVariables = true;

      timeout = 1;
    };
  };

  networking = {
    hostName = "lionell";

    wireless.enable = true;
    wireless.networks = {
      "OnePlus 7"                    = { psk = "password"; };
      "home"                         = { psk = "dlinkdir320"; };
      "735_5G"                       = { psk = "thehardestpassword"; };
      "Hopefull_5G"                  = { psk = "thehardestpassword"; };
      "KyivStar-Net18"               = { psk = "irjkmyfzctnm"; };
      "VIP"                          = {};
      "OpenWorld"                    = { psk = "20131209"; };
      "fbguest"                      = { psk = "m0vefast"; };
      "Matthew's Redmi"              = { psk = "19216811?"; };
      "SocNet"                       = { psk = "sociologyNETW"; };
      "unicyb_new"                   = { psk = "cybernetics"; };
      "0x258"                        = { psk = "12345678"; };
      "mechmat-22"                   = { psk = "Mathematics!"; };
      "Mister Cat Penthouse"         = {};
      "Free Boryspil WiFi"           = {};
      "Airport-Frankfurt"            = {};
      "In Blockchain We Trust_5GHz"  = { psk = "3123949429"; };
      "GoogleGuest"                  = {};
      "101freeway_5G"                = { psk = "NEWPASS2012"; };
      "sjcfreewifi"                  = {};
      "EGHQ102"                      = { psk = "aboda2773"; };
      "Free Wifi - Munich Airport"   = {};
      "Бродяги"                      = { psk = "ZinoviiYaroslavSAP1202"; };
      "Intertelecom_5G"              = {};
      ".Salateira|WiFi Bar"          = {};
      "HashCode"                     = { psk = "GoogleHash"; };
      "DAN.IT-Student"               = { psk = "Secur567"; };
      "WebCube4-7B2C"                = { psk = "HJHDX38R"; };
      "Don Camillo"                  = {};
      "ZinoviiiPhone"                = { psk = "10000001"; };
      "4 Sure Land"                  = { psk = "BigMeetChamps2k16"; };
      "iPhone Mykyta"                = { psk = "glorytoukraine"; };
    };
  };

  hardware = {
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };

    opengl.driSupport32Bit = true;
  };

  # Select internationalisation properties.
  i18n.consoleUseXkbConfig = true;

  # Set your time zone.
  time.timeZone = "Europe/Kiev";
  # time.timeZone = "America/Los_Angeles";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    gcc gdb gnumake gnum4 autoconf cmake
    binutils # ld, as, gprof, nm, strip
    lsof

    wget
    git
    rlwrap
    jq
    xsel
    arandr
    powertop
    stow
    termite
    chromium
    zip unzip unar
    file
    tree
    psmisc
    htop

    python37Full
    # ghc stack
    # go
    # ocaml opam ocamlPackages.ocpIndent ocamlPackages.utop ocamlPackages.merlin
    # bazel
    # sbcl
    # flex bison antlr4
    # google-cloud-sdk
    # nasm
    # nmap
    # usbutils

    # fortune cowsay
    # texlive.combined.scheme-full
    # valgrind
    vlc
    docker_compose
    scrot
    # love
    drive
    # maven jetbrains.idea-community
    # scala sbt
    # geeqie
    # aspell # emacs
    # sqlite
    # gnu-smalltalk
    # mosh sshpass
    # exfat
    # playerctl
    # vscode
    # clojure
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
    ssh.startAgent    = true;
    java.enable       = true;
    fish.enable       = true;
    vim.defaultEditor = true;

    tmux = {
      enable    = true;
      shortcut  = "a";
      baseIndex = 1;
      keyMode   = "vi";

      extraTmuxConf = ''
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'tmux-plugins/tmux-pain-control'
      set -g @plugin 'tmux-plugins/tmux-yank'
      set -g @plugin 'lionell/tmux-themepack'
      set -g @themepack 'double/orange'
      run '/home/lionell/.tmux/plugins/tpm/tpm'
      '';
    };
  };

  fonts = {
    fonts = with pkgs; [
      source-code-pro
      font-awesome-ttf
      powerline-fonts
    ];
  };

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;

      windowManager.i3 = {
        enable  = true;
        package = pkgs.i3-gaps;
        extraPackages = with pkgs; [
          feh
          rofi
          i3status
          i3lock-pixeled
          xorg.xbacklight
          xorg.xmodmap
          xorg.xev
        ];
      };

      displayManager.slim = {
        enable = true;
        defaultUser = "lionell";
        theme = pkgs.fetchurl {
          url    = "https://github.com/lionell/boxy-slim-theme/archive/v1.0.tar.gz";
          sha256 = "0lxz8wi87rxck0ss663hv7r4vdmqy6dqkbl8iasg5fzza7wqln0a";
        };
      };

      layout     = "us, ua";
      xkbVariant = "colemak,";
      xkbOptions = "altwin:ctrl_alt_win, grp:caps_toggle";

      libinput.enable = true; # Enable touchpad support.
    };

    transmission = {
      enable = true;
      home = "/home/torrent";
    };

    emacs.enable    = true;
    printing.enable = true; # Enable CUPS to print documents.
    tlp.enable      = true; # Power management
  };

  virtualisation = {
    docker.enable = true;
    virtualbox.host.enable = true;
  };

  users.extraUsers.lionell = {
    isNormalUser = true;
    uid          = 1000;
    extraGroups  = [ "wheel" "docker" "transmission" ];
    shell        = pkgs.fish;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
