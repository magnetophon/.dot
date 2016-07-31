{ stdenv, fetchurl}:

  stdenv.mkDerivation rec {
  version = "0.8.8";
  name = "ddptools-${version}";

  src = fetchurl {
    url = "http://ddp.andreasruge.de/dist/${name}-i386-elf.tar.gz";
    sha256 = "188p7vj17nzjndajb3rxmvmy1cx4r07sfg1qrch43fvshbr15x03";
    };

    buildInputs = [  ];

    phases = [ "unpackPhase" "installPhase" ];

    DDPTOOLS=[ "ddpinfo" "cue2ddp" "cdtinfo" ];

    installPhase = ''
      mkdir -p "$out/bin"
      mkdir -p "$out/share/man"

      for tool in ddpinfo cue2ddp cdtinfo
      do
        # binary
        cp $tool "$out/bin"
        chmod 755 "$out/bin/"$tool
        patchelf --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) \
              "$out/bin/"$tool

        # manpage
        cp doc/$tool.1 "$out/share/man"
        chmod 644 "$out/share/man/"$tool.1
        gzip -9 -f "$out/share/man/"$tool.1
      done
    '';

    meta = {
    description = "Create, inspect, verify and convert DDP 2.00 masters for Red Book CD audio recplicaton";
    homepage =  http://ddp.andreasruge.de;
    license = stdenv.lib.licenses.unfree;
    maintainers = [ stdenv.lib.maintainers.magnetophon ];
    platforms = stdenv.lib.platforms.linux;
  };
}
