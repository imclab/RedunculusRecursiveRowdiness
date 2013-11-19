
#handle rocket stuff
FW.Rockets = class Rockets
  rnd = FW.rnd
  constructor: ()->
    rnd = FW.rnd
    @rockets = []
    @launchSound = new Audio('./assets/launch.mp3');
    @explodeSound = new Audio('./assets/explosion.mp3');
    @crackleSound = new Audio('./assets/crackle.mp3');
    @soundOn = false
    @color = new THREE.Color()
    @color.setRGB(200, 10, 0)


    @firework = new FW.Firework(@color)

    @projector = new THREE.Projector()
    @targetVec = new THREE.Vector3()
    @launchSpeed = 0.8
    @explosionDelay = 500
    @shootDirection = new THREE.Vector3()
    @explosionLightIntensity = 1.0

    @rocketMat= new THREE.ShaderMaterial({
    uniforms: uniforms1,
    vertexShader: document.getElementById('vertexShader').textContent,
    fragmentShader: document.getElementById('fragment_shader1').textContent

    })
    @rocketGeo = new THREE.CylinderGeometry(.1, 1, 1);

    #LIGHTS
    @light = new THREE.PointLight(0xffeeee, 0.0, 500)
    @light.position.set(1, 1, 1);
    FW.myWorld.scene.add(@light)




  explode: (position)->
    @light.intensity = @explosionLightIntensity
    @light.position.set position.x, position.y, position.z
    @firework.createExplosion(position)
    
    #set timeout for speed of sound delay!
    if @soundOn
        setTimeout(()=>
          @explodeSound.play()
          setTimeout(()=>
            @crackleSound.play()
          400)
        800)


  launchRocket: ()->
    @launchSound.load();
    @explodeSound.load()
    @crackleSound.load()
    rocket = new THREE.Mesh(@rocketGeo, @rocketMat)
    rocket.position.set(FW.myWorld.camera.position.x, FW.myWorld.camera.position.y, FW.myWorld.camera.position.z)
    @rockets.push(rocket)
    vector = new THREE.Vector3()
    vector.set(0,0,1)
    @projector.unprojectVector(vector, FW.myWorld.camera)
    ray = new THREE.Ray(FW.myWorld.camera.position, vector.sub(FW.myWorld.camera.position).normalize() );
    FW.myWorld.scene.add(rocket)
    @target =  vector.sub(FW.myWorld.camera.position).normalize()
    rocket.shootDirection = new THREE.Vector3()
    rocket.shootDirection.x = ray.direction.x;
    rocket.shootDirection.y = ray.direction.y;
    rocket.shootDirection.z = ray.direction.z;
    if @soundOn
        @launchSound.play();
    @rockets.push(rocket)
    setTimeout(()=>
      FW.myWorld.scene.remove(rocket)
      @explode(rocket.position)
    @explosionDelay)

  update: ()->
    if @light.intensity > 0
      @light.intensity -= 0.01 * @explosionLightIntensity
    @updateRocket rocket for rocket in @rockets
    @firework.tick()


  updateRocket: (rocket)->
    rocket.translateX(@launchSpeed * rocket.shootDirection.x)
    rocket.translateY( @launchSpeed * rocket.shootDirection.y)
    rocket.translateZ(@launchSpeed * rocket.shootDirection.z)
