{pkgs, ...}: {
  programs.mpv = {
    enable = true;

    scripts = with pkgs.mpvScripts; [
      uosc
      thumbfast
      mpris
    ];

    config = {
      # Hardware-accelerated decoding
      hwdec = "auto";

      # Good quality rendering
      profile = "high-quality";

      # Remember where you stopped watching
      save-position-on-quit = true;

      # Automatically find subtitles
      sub-auto = "fuzzy";

      # Prefer German/English audio and subtitles
      alang = "de,deu,ger,en,eng";
      slang = "de,deu,ger,en,eng";
    };
  };

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "video/mp4" = ["mpv.desktop"];
      "video/x-matroska" = ["mpv.desktop"];
      "video/webm" = ["mpv.desktop"];
      "video/x-msvideo" = ["mpv.desktop"];
      "video/quicktime" = ["mpv.desktop"];
      "video/mpeg" = ["mpv.desktop"];
    };
  };
}
