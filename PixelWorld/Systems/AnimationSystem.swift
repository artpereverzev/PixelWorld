//
//  AnimationSystem.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 08.04.2025.
//
import GameplayKit
import SpriteKit

class AnimationSystem: GKComponentSystem<AnimationComponent> {
    let scene: SKScene
    
    init(scene: SKScene) {
        self.scene = scene
        super.init(componentClass: AnimationComponent.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        for component in components {
            guard let spriteNode = component.spriteNode else {
                continue
            }
            
            if let movement = component.entity?.component(ofType: MovementComponent.self),
               let input = component.entity?.component(ofType: InputComponent.self) {
                if movement.isMoving && !movement.isJumping && !input.isAttacking {
                    component.requestedAnimationType = .moving
                } else if input.isAttacking {
                    component.requestedAnimationType = .attacking
                } else {
                    component.requestedAnimationType = .idle
                }
            }
            
            if let requestedType = component.requestedAnimationType,
               requestedType != component.currentAnimationType {
                
                if let animation = component.allAnimations[requestedType] {
                    startAnimation(animation, on: spriteNode)
                    component.currentAnimationType = requestedType
                    component.requestedAnimationType = nil
                }
            }
        }
    }
    
    func startAnimation(_ animation: Animation, on node: SKSpriteNode) {
        node.removeAllActions()
        
        let animationAction = SKAction.animate(with: animation.textures, timePerFrame: animation.timePerFrame)
        
        if animation.repeatTexturesForever == true {
            let repeatAction = SKAction.repeatForever(animationAction)
            node.run(repeatAction)
        } else {
            node.run(animationAction)
        }
    }
}
