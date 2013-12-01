FW.Meteor = class Meteor
  rnd = FW.rnd
  constructor: ()->
    #create a few different emmitters and add to pool

    
    @meteorGroup = new ShaderParticleGroup({
      texture: THREE.ImageUtils.loadTexture('assets/star.png'),
      blending: THREE.AdditiveBlending,
      maxAge: 6
    });

    @emitterSettings = 
      size: rnd(0.01, 1.3),
      sizeSpread: rnd(0.1, 1.0),
      velocity: new THREE.Vector3(rnd(-1, 1), rnd(-1, 1), rnd(-1, 1))
      acceleration: new THREE.Vector3(0, -0.01, 0),
      accelerationSpread: new THREE.Vector3(rnd(-2, 0), rnd(-2, 0), rnd(-2, 0)),
      particlesPerSecond: rnd(100, 500),
      alive: 0,  
      emitterDuration: rnd(1.0, 5.0)
      opacityEnd: 0.5

    @meteorGroup.addPool(5, @emitterSettings, true)

  startShower: ->
    setInterval(()=>
      console.log "Spakrle!!!!"
      @meteorGroup.triggerPoolEmitter(1, FW.startingPos)
    1000) 

    
  tick: ->
    @meteorGroup.tick(0.16)
    


