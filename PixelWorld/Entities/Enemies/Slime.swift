//
//  Slime.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 18.04.2025.
//
import SpriteKit
import GameplayKit

class Slime: GameEntity {
    var defaultTexture: SKTexture = SKTexture(imageNamed: "slime_idle_0")
    
    var idleTextures = SKTexture.loadTextures(atlas: "slime",
                                              prefix: "slime_idle_",
                                              startsAt: 0,
                                              stopAt: 3)
    var randomPosX: CGFloat = CGFloat.random(in: 100...300)
    
    override init(){
        super.init()
        self.tag.insert(.enemy)
        let renderComponent = RenderComponent(texture: defaultTexture, scale: 1.5, entity: self)
        let physicsComponent = PhysicsComponent(bodyCategory: .monster, bodyShape: .rect)
        let animationComponent = AnimationComponent()
        let positionComponent = PositionComponent(position: CGPoint(x: randomPosX, y: 500), zPos: 100)
        let movementComponent = MovementComponent()
        let healthComponent = HealthComponent(maxHealth: 50, currentHealth: 50)
        let healthBarComponent = HealthBarComponent()
        
        animationComponent.allAnimations = [
            .idle: Animation(textures: idleTextures, timePerFrame: 0.1)
        ]
        
        self.addComponent(renderComponent)
        self.addComponent(physicsComponent)
        self.addComponent(animationComponent)
        self.addComponent(positionComponent)
        self.addComponent(healthComponent)
        self.addComponent(healthBarComponent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
