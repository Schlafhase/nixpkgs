{ lib, stdenv, fetchFromGitHub, dotnetCorePackages, makeWrapper }:

stdenv.mkDerivation rec {
  pname = "skiasharp";
  version = "3.119.0";

  src = fetchFromGitHub {
    owner = "mono";
    repo = "SkiaSharp";
    rev = "v${version}";
    sha256 = lib.fakeSha256;
  };

  nativeBuildInputs = [
    dotnetCorePackages.sdk_8_0
  ];

  buildPhase = ''
    ./build.sh
  '';

  installPhase = ''
    mkdir -p $out/lib
    cp -r binding/SkiaSharp/bin/Release/net6.0/* $out/lib/
  '';

  meta = with lib; {
    description = ".NET bindings for Skia graphics library";
    homepage = "https://github.com/mono/SkiaSharp";
    licence = licences.mit;
  };
}
