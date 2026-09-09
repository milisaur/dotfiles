{pkgs, ...}: let
  java21 = pkgs.writeShellScriptBin "java21" ''
    exec ${pkgs.jdk21}/bin/java "$@"
  '';

  javac21 = pkgs.writeShellScriptBin "javac21" ''
    exec ${pkgs.jdk21}/bin/javac "$@"
  '';

  jshell21 = pkgs.writeShellScriptBin "jshell21" ''
    exec ${pkgs.jdk21}/bin/jshell "$@"
  '';

  java25 = pkgs.writeShellScriptBin "java25" ''
    exec ${pkgs.jdk25}/bin/java "$@"
  '';

  javac25 = pkgs.writeShellScriptBin "javac25" ''
    exec ${pkgs.jdk25}/bin/javac "$@"
  '';

  jshell25 = pkgs.writeShellScriptBin "jshell25" ''
    exec ${pkgs.jdk25}/bin/jshell "$@"
  '';

  jdk21Shell = pkgs.writeShellScriptBin "jdk21" ''
    export JAVA_HOME="${pkgs.jdk21}"
    export PATH="$JAVA_HOME/bin:$PATH"

    echo "Java 21 environment"
    java -version

    exec ${pkgs.zsh}/bin/zsh
  '';

  jdk25Shell = pkgs.writeShellScriptBin "jdk25" ''
    export JAVA_HOME="${pkgs.jdk25}"
    export PATH="$JAVA_HOME/bin:$PATH"

    echo "Java 25 environment"
    java -version

    exec ${pkgs.zsh}/bin/zsh
  '';
in {
  home.packages = [
    # Default Java
    pkgs.jdk25

    # Explicit version commands
    java21
    javac21
    jshell21

    java25
    javac25
    jshell25

    # Full version-specific environments
    jdk21Shell
    jdk25Shell
  ];

  home.sessionVariables = {
    JAVA_HOME = "${pkgs.jdk25}";
  };
}
