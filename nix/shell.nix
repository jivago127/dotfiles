{ pkgs ? import <nixpkgs> {} }:


pkgs.mkShell {
	nativeBuildInputs = with pkgs; [
		jdk25
		maven
		zlib
		stdenv.cc.cc	
	];

	shellHook = ''
		export JAVA_HOME=${pkgs.jdk25.home}
		echo "Ambiente Quarkus carregado!"
		java -version
	'';

	LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [
		stdenv.cc.cc.lib
		zlib
	]);
}
