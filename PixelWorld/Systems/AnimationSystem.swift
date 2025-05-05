//
//  AnimationSystem.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 08.04.2025.
//
import GameplayKit
import SpriteKit

class AnimationSystem: GKComponentSystem<AnimationComponent> {
    
    override init() {
        super.init(componentClass: AnimationComponent.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        for component in components {
            guard let render = component.entity?.component(ofType: RenderComponent.self) else {
                continue
            }
            let spriteNode = render.spriteNode
            
            // Определяем тип анимации на основе компонентов сущности
            let requestedType = determineAnimationType(for: component)
            
            // Применяем анимацию, если она изменилась
            if requestedType != component.currentAnimationType,
               let animation = component.allAnimations[requestedType] {
                startAnimation(animation, on: spriteNode)
                component.currentAnimationType = requestedType
            }
        }
    }
    
    /// Определяет тип анимации на основе компонентов сущности
    private func determineAnimationType(for component: AnimationComponent) -> AnimationType {
        guard let entity = component.entity else {
            return .idle
        }
        
        // Приоритетная логика для специальных сущностей (например, Slime)
        if entity is Slime {
            //return .idle
        }
        
        if let attackState = component.entity?.component(ofType: AttackStateComponent.self),
           let jumpState = component.entity?.component(ofType: JumpStateComponent.self),
           let movementState = component.entity?.component(ofType: MovementStateComponent.self) {
            
            if attackState.isAttacking {
                return .attacking
            } else if jumpState.isJumping {
                return .jumping
            } else if movementState.isMoving {
                return .moving
            }
        }
        
        return .idle
    }
    
    private func startAnimation(_ animation: Animation, on node: SKSpriteNode) {
        node.removeAllActions()
        
        let animationAction = SKAction.animate(with: animation.textures, timePerFrame: animation.timePerFrame)
        
        if animation.repeatTexturesForever {
            node.run(.repeatForever(animationAction))
        } else {
            node.run(animationAction)
        }
    }
}
