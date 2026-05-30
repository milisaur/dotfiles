{
  lib,
  stdenvNoCC,
  makeWrapper,
  jdk8,
}:
stdenvNoCC.mkDerivation {
  pname = "hades";
  version = "1.0";

  src = ../assets/Hades_Editor_und_Simulator.jar;

  nativeBuildInputs = [makeWrapper];

  dontUnpack = true;

  installPhase = ''
        mkdir -p $out/share/hades
        cp $src $out/share/hades/Hades_Editor_und_Simulator.jar

        mkdir -p $out/bin
        makeWrapper ${jdk8}/bin/java $out/bin/hades \
          --add-flags "-jar $out/share/hades/Hades_Editor_und_Simulator.jar"

        mkdir -p $out/share/applications

        cat > $out/share/applications/hades.desktop << EOF
    [Desktop Entry]
    Name=HADES
    Exec=hades
    Terminal=false
    Type=Application
    Categories=Development;Education;
    Icon=utilities-terminal
    EOF
  '';

  meta = with lib; {
    description = "HADES digital logic editor and simulator";
    platforms = platforms.linux;
  };
}
