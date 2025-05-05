//
//  JumpSystem.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 19.04.2025.
//
import GameplayKit
import SpriteKit

class JumpSystem: GKComponentSystem<JumpComponent> {
    
    override init() {
        super.init(componentClass: JumpComponent.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        for component in components {
            guard let jumpState = component.entity?.component(ofType: JumpStateComponent.self),
                  let render = component.entity?.component(ofType: RenderComponent.self)
                   else {
                continue
            }
            
            let node = render.spriteNode
            let physicsBody = node.physicsBody
            
            guard let physicsBody = physicsBody else {
                continue
            }
            
            // Обработка прыжка
            if jumpState.jumpPressed && jumpState.isGrounded && jumpState.canJump {
                physicsBody.applyImpulse(CGVector(dx: 0, dy: component.jumpForce))
                jumpState.isGrounded = false
                jumpState.isJumping = true
                jumpState.canJump = false
                component.cooldownTimer = component.jumpCooldown
            }
            
            // Обновление кулдауна
            if !jumpState.canJump {
                component.cooldownTimer -= seconds
                if component.cooldownTimer <= 0 {
                    jumpState.canJump = true
                }
            }
            
            // Сброс состояния прыжка при отпускании
            if !jumpState.jumpPressed {
                jumpState.isJumping = false
            }
            
        }
    }
}
