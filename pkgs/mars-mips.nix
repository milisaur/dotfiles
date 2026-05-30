{
  lib,
  stdenvNoCC,
  fetchurl,
  makeWrapper,
  jdk8,
}:
stdenvNoCC.mkDerivation {
  pname = "mars-mips";
  version = "4.5";

  src = fetchurl {
    url = "https://dpetersanderson.github.io/Mars4_5.jar";
    hash = "sha256-rDQLZ2uitiJGud935i+BrURHvP0ymrU5cWvNCZULcJY=";
  };

  nativeBuildInputs = [makeWrapper];

  dontUnpack = true;

  installPhase = ''
      mkdir -p $out/share/mars
      cp $src $out/share/mars/Mars.jar

      mkdir -p $out/bin
     makeWrapper ${jdk8}/bin/java $out/bin/mars \
      --set _JAVA_AWT_WM_NONREPARENTING 1 \
      --add-flags "-jar $out/share/mars/Mars.jar"

      mkdir -p $out/share/applications

      cat > $out/share/applications/mars.desktop << EOF
    [Desktop Entry]
    Name=MARS MIPS
    Exec=mars
    Terminal=false
    Type=Application
    Categories=Development;Education;
    Icon=utilities-terminal
    EOF
  '';

  meta = {
    description = "MARS MIPS Assembler and Runtime Simulator";
    homepage = "https://github.com/dpetersanderson/MARS";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}
