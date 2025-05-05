//
//  Player.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 08.04.2025.
//
import GameplayKit
import SpriteKit

class Player: GameEntity {
    var defaultTexture: SKTexture = SKTexture(imageNamed: "hero_0")
    
    var idleTextures = SKTexture.loadTextures(atlas: "player",
                                              prefix: "hero_",
                                              startsAt: 0,
                                              stopAt: 6)
    
    var movingTextures = SKTexture.loadTextures(atlas: "player",
                                                 prefix: "heroMove_",
                                                 startsAt: 0,
                                                 stopAt: 5)
    
    var attackingTextures = SKTexture.loadTextures(atlas: "player",
                                                  prefix: "heroAttack_",
                                                  startsAt: 0,
                                                  stopAt: 5)
    
    override init(){
        super.init()
        self.tag.insert(.player)
        let renderComponent = RenderComponent(texture: defaultTexture, scale: 1.0, entity: self)
        let physicsComponent = PhysicsComponent(bodyCategory: .player, bodyShape: .rect)
        let cameraComponent = CameraComponent(followTarget: renderComponent.spriteNode)
        let joystickComponent = JoystickComponent()
        let attackJoystickComponent = AttackJoystickComponent()
        let inputComponent = InputComponent()
        let inputAttackComponent = InputAttackComponent()
        let positionComponent = PositionComponent(position: CGPoint(x: 0, y: 400), zPos: 101)
        let healthComponent = HealthComponent(maxHealth: 100, currentHealth: 100)
        let healthBarComponent = HealthBarComponent()
        let animationComponent = AnimationComponent()
        let movementComponent = MovementComponent()
        let movementStateComponent = MovementStateComponent()
        let jumpComponent = JumpComponent(force: 3000, cooldown: 25500000)
        let jumpStateComponent = JumpStateComponent()
        let attackStateComponent = AttackStateComponent()
        
        animationComponent.allAnimations = [
            .idle: Animation(textures: idleTextures, timePerFrame: 0.1),
            .moving: Animation(textures: movingTextures, timePerFrame: 0.1),
            .attacking: Animation(textures: attackingTextures, timePerFrame: 0.1),
            .jumping: Animation(textures: attackingTextures, timePerFrame: 0.1)
        ]
        
        self.addComponent(renderComponent)
        self.addComponent(physicsComponent)
        self.addComponent(cameraComponent)
        self.addComponent(joystickComponent)
        self.addComponent(attackJoystickComponent)
        self.addComponent(inputComponent)
        self.addComponent(inputAttackComponent)
        self.addComponent(positionComponent)
        self.addComponent(healthComponent)
        self.addComponent(healthBarComponent)
        self.addComponent(animationComponent)
        self.addComponent(movementComponent)
        self.addComponent(movementStateComponent)
        self.addComponent(jumpComponent)
        self.addComponent(jumpStateComponent)
        self.addComponent(attackStateComponent)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
