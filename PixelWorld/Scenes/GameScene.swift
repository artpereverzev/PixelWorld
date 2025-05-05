//
//  GameScene.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 08.04.2025.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var entityManager: EntityManager!
    
    private var tileMapSystem: TileMapSystem!
    private var backgroundSystem: BackgroundSystem!
    private var positionSystem: PositionSystem!
    private var renderSystem: RenderSystem!
    private var physicsSystem: PhysicsSystem!
    private var physicsContactSystem: PhysicsContactSystem!
    private var cameraSystem: CameraSystem!
    private var joystickSystem: JoystickSystem!
    private var attackJoystickSystem: AttackJoystickSystem!
    private var healthSystem: HealthSystem!
    private var healthBarRenderingSystem: HealthBarRenderingSystem!
    private var animationSystem: AnimationSystem!
    private var movementSystem: MovementSystem!
    private var inputSystem: InputSystem!
    private var jumpSystem: JumpSystem!
    private var inputAttackSystem: InputAttackSystem!
    private var spawnSystem: SpawnSystem!
    
    private var player: Player!
    private var slime: Slime!
    
    private var spawner: Spawner!
    
    // TODO: Delete start
    private var slime1: Slime!
    // TODO: Delete end
    
    private var backgroundEntity: Background!
    
    var entities = [GKEntity]()
    let factory = GameEntityFactory()
    
    override func didMove(to view: SKView) {
        entityManager = EntityManager(scene: self)
        
        view.showsPhysics = true
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -120.0)
        
        renderSystem = RenderSystem(scene: self)
        tileMapSystem = TileMapSystem(scene: self)
        physicsSystem = PhysicsSystem()
        physicsContactSystem = PhysicsContactSystem(scene: self, entityManager: entityManager)
        
        backgroundSystem = BackgroundSystem(scene: self)
        
        positionSystem = PositionSystem()
        
        cameraSystem = CameraSystem(scene: self)
        
        joystickSystem = JoystickSystem(scene: self)
        attackJoystickSystem = AttackJoystickSystem(scene: self)
        
        healthSystem = HealthSystem()
        healthBarRenderingSystem = HealthBarRenderingSystem(scene: self)
        
        animationSystem = AnimationSystem()
        
        movementSystem = MovementSystem()
        jumpSystem = JumpSystem()
        inputSystem = InputSystem()
        inputAttackSystem = InputAttackSystem()
        
        spawnSystem = SpawnSystem(factory: factory, entityManager: entityManager)
        

        player = Player()
        slime = Slime()
        spawner = Spawner()
        
        // TODO: Delete start
        slime1 = Slime()
        // TODO: Delete end
        
        backgroundEntity = Background()
        
        guard let tileSetGrass = SKTileSet(named: "Grass Tile Set"),
              let tileSetDirt = SKTileSet(named: "Dirt Tile Set") else {
            fatalError("TileSet not found")
        }
        
        let tileMapFactoryGrass = TileMapFactory(scene: self, tileSet: tileSetGrass)
        let tileMapFactoryDirt = TileMapFactory(scene: self, tileSet: tileSetDirt)
        
        let tileMapEntityGrass = tileMapFactoryGrass.createDefaultTileMap()
        
        let tileMapEntityDirt = tileMapFactoryDirt.createDefaultTileMap()
        
        let treeFactory = TreeFactory(scene: self)
        
        let forestArea = CGRect(x: -4500, y: 450, width: 15000, height: 200)
        let trees = treeFactory.createTrees(count: 500, in: forestArea)
        
        entityManager.addSystem(tileMapSystem)
        entityManager.addSystem(renderSystem)
        entityManager.addSystem(positionSystem)
        entityManager.addSystem(backgroundSystem)
        entityManager.addSystem(physicsSystem)
        entityManager.addSystem(cameraSystem)
        entityManager.addSystem(joystickSystem)
        entityManager.addSystem(attackJoystickSystem)
        entityManager.addSystem(healthSystem)
        entityManager.addSystem(healthBarRenderingSystem)
        entityManager.addSystem(animationSystem)
        entityManager.addSystem(movementSystem)
        entityManager.addSystem(inputSystem)
        entityManager.addSystem(jumpSystem)
        entityManager.addSystem(inputAttackSystem)
        entityManager.addSystem(spawnSystem)
        
        entityManager.add(player)
        entityManager.add(backgroundEntity)
        entityManager.add(slime)
        entityManager.add(slime1)
        entityManager.add(tileMapEntityGrass)
        entityManager.add(tileMapEntityDirt)
        entityManager.add(spawner)
        trees.forEach(entityManager.add)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        renderSystem.update(deltaTime: currentTime)
        tileMapSystem.update(deltaTime: currentTime)
        
        physicsSystem.update(deltaTime: currentTime)
        
        positionSystem.update(deltaTime: currentTime)
        
        animationSystem.update(deltaTime: currentTime)
        
        backgroundSystem.update(deltaTime: currentTime)
        
        cameraSystem.update(deltaTime: currentTime)
        
        joystickSystem.update(deltaTime: currentTime)
        attackJoystickSystem.update(deltaTime: currentTime)
        
        healthSystem.update(deltaTime: currentTime)
        healthBarRenderingSystem.update(deltaTime: currentTime)
        
        inputSystem.update(deltaTime: currentTime)
        inputAttackSystem.update(deltaTime: currentTime)
        
        movementSystem.update(deltaTime: currentTime)
        jumpSystem.update(deltaTime: currentTime)
        
        spawnSystem.update(deltaTime: currentTime)
    }
    
    override func sceneDidLoad() {
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if let attackJoystickSystem = attackJoystickSystem as AttackJoystickSystem? {
            attackJoystickSystem.startTracking(with: touch, location: location)
        }
        if let joystickSystem = joystickSystem as JoystickSystem? {
            joystickSystem.startTracking(with: touch, location: location)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if let attackJoystickSystem = attackJoystickSystem as AttackJoystickSystem? {
            attackJoystickSystem.updateTracking(with: touch, location: location)
        }
        if let joystickSystem = joystickSystem as JoystickSystem? {
            joystickSystem.updateTracking(with: touch, location: location)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let attackJoystickSystem = attackJoystickSystem as AttackJoystickSystem? {
            attackJoystickSystem.endTracking()
        }
        if let joystickSystem = joystickSystem as JoystickSystem? {
            joystickSystem.endTracking()
        }
    }
    
}
