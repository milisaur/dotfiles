{
  lib,
  stdenvNoCC,
  makeWrapper,
  jdk21,
}:
stdenvNoCC.mkDerivation {
  pname = "asm-simulator";
  version = "1.0";

  src = ../assets/ASM-Simulator.jar;

  nativeBuildInputs = [makeWrapper];

  dontUnpack = true;

  installPhase = ''
        mkdir -p $out/share/asm-simulator
        cp $src $out/share/asm-simulator/ASM-Simulator.jar

        mkdir -p $out/bin
        makeWrapper ${jdk21}/bin/java $out/bin/asm-simulator \
          --add-flags "-jar $out/share/asm-simulator/ASM-Simulator.jar"

        mkdir -p $out/share/applications

        cat > $out/share/applications/asm-simulator.desktop << EOF
    [Desktop Entry]
    Name=ASM Simulator
    Exec=asm-simulator
    Terminal=false
    Type=Application
    Categories=Development;Education;
    Icon=utilities-terminal
    EOF
  '';

  meta = with lib; {
    description = "ASM Diagram Simulator";
    platforms = platforms.linux;
  };
}
