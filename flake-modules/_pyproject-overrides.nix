final: prev:
let
  pkgs = final.python.pkgs.pkgs;
  sharedLibrary = pkgs.stdenv.hostPlatform.extensions.sharedLibrary;
in
{
  weasyprint = final.hacks.nixpkgsPrebuilt {
    from = final.python.pkgs.weasyprint.overridePythonAttrs (_old: rec {
      version = "69.0";
      src = final.python.pkgs.fetchPypi {
        pname = "weasyprint";
        inherit version;
        hash = "sha256-p6MvOcoWvYLvEd6ZyS6ktfFJUckDOvA15FHOT07gqIw=";
      };
      patches = [
        (pkgs.replaceVars ../patches/weasyprint-library-paths.patch {
          fontconfig = "${pkgs.fontconfig.lib}/lib/libfontconfig${sharedLibrary}";
          gobject = "${pkgs.glib.out}/lib/libgobject-2.0${sharedLibrary}";
          harfbuzz = "${pkgs.harfbuzz.out}/lib/libharfbuzz${sharedLibrary}";
          harfbuzz_subset = "${pkgs.harfbuzz.out}/lib/libharfbuzz-subset${sharedLibrary}";
          pango = "${pkgs.pango.out}/lib/libpango-1.0${sharedLibrary}";
          pangoft2 = "${pkgs.pango.out}/lib/libpangoft2-1.0${sharedLibrary}";
        })
      ];
      # The final uv environment supplies the versions pinned in uv.lock.
      dontCheckRuntimeDeps = true;
      dontVersionCheck = true;
      pythonImportsCheck = [ ];
      doCheck = false;
    });
  };

  # Seems packages aren't generally available unless they are explicitly
  # specified in an overlay?
  binaryornot = final.hacks.nixpkgsPrebuilt {
    from = final.python.pkgs.binaryornot;
  };
  #binaryornot = prev.binaryornot;

  django-allauth = prev.django-allauth.overrideAttrs (old: {
    buildInputs = (old.buildInputs or [ ]) ++ [
      prev.setuptools
      prev.wheel
    ];
  });

  django-mailbox = prev.django-mailbox.overrideAttrs (old: {
    buildInputs = (old.buildInputs or [ ]) ++ [
      prev.setuptools
      prev.wheel
    ];
  });

  django-xforwardedfor-middleware = prev.django-xforwardedfor-middleware.overrideAttrs (old: {
    buildInputs = (old.buildInputs or [ ]) ++ [
      prev.setuptools
      prev.wheel
    ];
  });

  dj-rest-auth = prev.dj-rest-auth.overrideAttrs (old: {
    buildInputs = (old.buildInputs or [ ]) ++ [
      prev.setuptools
      prev.wheel
    ];
  });

  odfpy = prev.odfpy.overrideAttrs (old: {
    buildInputs = (old.buildInputs or [ ]) ++ [
      prev.setuptools
      prev.wheel
    ];
  });

  sgmllib3k = prev.sgmllib3k.overrideAttrs (old: {
    buildInputs = (old.buildInputs or [ ]) ++ [
      prev.setuptools
      prev.wheel
    ];
  });

  coreschema = prev.coreschema.overrideAttrs (old: {
    buildInputs = (old.buildInputs or [ ]) ++ [
      prev.setuptools
      prev.wheel
    ];
  });

  invoke = prev.invoke.overrideAttrs (old: {
    buildInputs = (old.buildInputs or [ ]) ++ [
      prev.setuptools
      prev.wheel
    ];
  });
}
