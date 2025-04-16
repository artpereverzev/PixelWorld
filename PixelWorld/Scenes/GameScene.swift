//
//  GameScene.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 08.04.2025.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var tileMapSystem: TileMapSystem!
    private var renderSystem: RenderSystem!
    private var physicsSystem: PhysicsSystem!
    private var physicsContactSystem: PhysicsContactSystem!
    private var cameraSystem: CameraSystem!
    private var joystickSystem: JoystickSystem!
    private var attackJoystickSystem: AttackJoystickSystem!
    private var animationSystem: AnimationSystem!
    private var movementSystem: MovementSystem!
    private var inputSystem: InputSystem!
    
    private var player: Player!
    
    var entities = [GKEntity]()
    
    override func didMove(to view: SKView) {
        
        // 1. Включите debug-режим ПЕРВЫМ делом
        view.showsPhysics = true
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -120.0)
        physicsContactSystem = PhysicsContactSystem(scene: self)
        tileMapSystem = TileMapSystem(scene: self)
        renderSystem = RenderSystem(scene: self)
        physicsSystem = PhysicsSystem(scene: self)
        cameraSystem = CameraSystem(scene: self)
        joystickSystem = JoystickSystem(scene: self)
        attackJoystickSystem = AttackJoystickSystem(scene: self)
        animationSystem = AnimationSystem(scene: self)
        movementSystem = MovementSystem(scene: self)
        inputSystem = InputSystem()
        
        guard let tileSetGrass = SKTileSet(named: "Grass Tile Set"),
              let tileSetDirt = SKTileSet(named: "Dirt Tile Set") else {
            fatalError("TileSet not found")
        }
        
        let tileMapFactoryGrass = TileMapFactory(scene: self, tileSet: tileSetGrass)
        //let tileMapFactoryDirt = TileMapFactory(scene: self, tileSet: tileSetDirt)
        let tileMapEntityGrass = tileMapFactoryGrass.createDefaultTileMap()
        //let tileMapEntityDirt = tileMapFactoryDirt.createDefaultTileMap()
        
        player = Player()
        
        entities.append(player)
        entities.append(tileMapEntityGrass)
        //entities.append(tileMapEntityDirt)
        
        
        if let tileMapComponent = tileMapEntityGrass.component(ofType: TileMapComponent.self) {
            tileMapSystem.addComponent(tileMapComponent)
        }
//        if let tileMapComponent = tileMapEntityDirt.component(ofType: TileMapComponent.self) {
//            tileMapSystem.addComponent(tileMapComponent)
//        }
        
        if let physicsComponent = tileMapEntityGrass.component(ofType: PhysicsComponent.self) {
            physicsSystem.addComponent(physicsComponent)
        }
//        if let physicsComponent = tileMapEntityDirt.component(ofType: PhysicsComponent.self) {
//            physicsSystem.addComponent(physicsComponent)
//        }
        
        if let renderComponent = player.component(ofType: RenderComponent.self) {
            renderSystem.addComponent(renderComponent)
        }
        
        if let physicsComponent = player.component(ofType: PhysicsComponent.self) {
            physicsSystem.addComponent(physicsComponent)
        }
        
        if let cameraComponent = player.component(ofType: CameraComponent.self) {
            cameraSystem.addComponent(cameraComponent)
        }
        
        if let joystickComponent = player.component(ofType: JoystickComponent.self) {
            joystickSystem.addComponent(joystickComponent)
        }
        
        if let attackJoystickComponent = player.component(ofType: AttackJoystickComponent.self) {
            attackJoystickSystem.addComponent(attackJoystickComponent)
        }
        
        if let animationComponent = player.component(ofType: AnimationComponent.self) {
            animationSystem.addComponent(animationComponent)
        }
        
        if let movementComponent = player.component(ofType: MovementComponent.self) {
            movementSystem.addComponent(movementComponent)
        }
        
        if let inputComponent = player.component(ofType: InputComponent.self) {
            inputSystem.addComponent(inputComponent)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        tileMapSystem.update(deltaTime: currentTime)
        renderSystem.update(deltaTime: currentTime)
        physicsSystem.update(deltaTime: currentTime)
        cameraSystem.update(deltaTime: currentTime)
        joystickSystem.update(deltaTime: currentTime)
        attackJoystickSystem.update(deltaTime: currentTime)
        animationSystem.update(deltaTime: currentTime)
        movementSystem.update(deltaTime: currentTime)
        inputSystem.update(deltaTime: currentTime)
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
