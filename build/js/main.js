(function() {
  var Main;

  window.FW = {};

  window.onload = function() {
    FW.myWorld = new FW.World();
    FW.myWorld.animate();
    return FW.main = FW.Main();
  };

  FW.Main = Main = (function() {
    function Main() {
      var thing;
      this.g = new grow3.System(FW.myWorld.scene, FW.myWorld.camera, RULES.bush);
      thing = this.g.build(void 0, new THREE.Vector3(-1220, 760, 1250));
      FW.myWorld.camera.lookAt(thing.position);
    }

    return Main;

  })();

}).call(this);
