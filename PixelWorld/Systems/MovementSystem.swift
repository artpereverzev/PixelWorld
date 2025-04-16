//
//  MovementSystem.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 09.04.2025.
//
import GameplayKit
import SpriteKit


class MovementSystem: GKComponentSystem<MovementComponent> {
    private let scene: SKScene
    private var range: CGFloat = 55.0
    
    init(scene: SKScene) {
        self.scene = scene
        super.init(componentClass: MovementComponent.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        for component in components {
            guard let node = component.spriteNode,
                  let input = component.entity?.component(ofType: InputComponent.self) else {
                continue
            }
            
            let location = CGPoint(x: input.moveX, y: input.moveY)
            let xAxis = CGFloat(location.x.clamped(to: -range...range))
            let yAxis = CGFloat(location.y.clamped(v1: -range, v2: range))
            
            let velocityX = xAxis * component.maxSpeed
            let velocityY = yAxis * component.maxSpeed
            
            if velocityX != 0.0 {
                component.isMoving = true
            } else {
                component.isMoving = false
            }
            
            // 3. Обработка прыжка
            if input.jumpPressed && component.isGrounded && !component.isJumping && component.countJumps == 0 {
                component.countJumps += 1
                component.isJumping = true
                component.isGrounded = false
                component.isMoving = false

                node.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: component.jumpForce / 1.5))//component.jumpForce))
            }
            
            component.direction = CGVector(dx: xAxis, dy: yAxis)
            node.physicsBody?.velocity.dx = CGFloat(component.direction.dx * component.maxSpeed)
            
            if abs(xAxis) > 0.1 {
                component.facingRight = xAxis > 0
                node.xScale = component.facingRight ? abs(node.xScale) : -abs(node.xScale)
            }
        }
    }
}

