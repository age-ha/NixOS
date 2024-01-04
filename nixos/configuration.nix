# sudo nixos-rebuild switch --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store"

{ config, pkgs, ... }:

{
    imports = [ ./hardware-configuration.nix
    ];
    services.openssh.enable = true;
    i18n.defaultLocale = "zh_CN.UTF-8";
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [ 
    ];

    fontconfig = {
    	defaultFonts = {
      	    serif = [ "Microsoft YaHei" ];
      	    sansSerif = [ "Microsoft YaHei" ];
      	    monospace = [ "Microsoft YaHei" ];
        };
      };
    };
    boot.supportedFilesystems = [ "ntfs" ];
    boot.kernelPackages = pkgs.linuxPackages_zen;
    hardware.bluetooth.enable = true;
    security.rtkit.enable = true;
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.initrd.kernelModules=["amdgpu"];
    networking.networkmanager.enable = true;
    time.timeZone = "Asia/Shanghai";
    console = {
      font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    };
    system.stateVersion = "24.05";     
    
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    environment.etc = {
      "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text =  ''
      bluez_monitor.properties = {
	["bluez5.enable-sbc-xq"] = true,
	["bluez5.enable-msbc"] = true,
	["bluez5.enable-hw-volume"] = true,
	["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
	}
	'';
    };
  
    programs.neovim = {
      enable = true;
      configure = {
        #customRC = '' set number '';
      };
    };

    programs.fish.enable = true;
    programs.hyprland.enable = true;
    environment.systemPackages = with pkgs; [
      home-manager
      git
      ffmpeg
      pavucontrol
      kitty
      google-chrome
      font-manager
      xfce.thunar
      mpv
      yt-dlp
      v2raya
      unzip 
      waylock
      swaybg
      neofetch
      distrobox
      ffmpegthumbnailer
      ranger
      cmus
      tmux
      bluetuith
      pamixer 
      cava
      podman 
      ];
    security.pam.services.waylock = {
      text = '' auth include login '';
    };
    nix.settings.trusted-users = [ "root" "ageha" ];
    #networking.proxy.default = "http://127.0.0.1:20172";
    nixpkgs.config.allowUnfree = true;
    environment.sessionVariables = rec { GTK_THEME=Adwaita:dark; };
    users.users.ageha = {
	isNormalUser = true;
	extraGroups = ["wheel"];
	shell = pkgs.fish;

	packages = with pkgs;
	[
	];

  	};
 
}

