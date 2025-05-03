final: prev: {
  nodejs = prev.nodejs.overrideAttrs (_: {
    doCheck = false;
  });

  nodejs_20 = prev.nodejs_20.overrideAttrs (_: {
    doCheck = false;
  });

  nodejs_22 = prev.nodejs_22.overrideAttrs (_: {
    doCheck = false;
  });
}
