{ pkgs ? import ../../../nix { } }:
let aircosmicd = (pkgs.callPackage ../../../. { });
in
aircosmicd.overrideAttrs (oldAttrs: {
  patches = oldAttrs.patches or [ ] ++ [
    ./broken-aircosmicd.patch
  ];
})
