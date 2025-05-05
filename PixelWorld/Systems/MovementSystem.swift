//
//  MovementSystem.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 09.04.2025.
//
import GameplayKit
import SpriteKit


class MovementSystem: GKComponentSystem<MovementComponent> {
    private var range: CGFloat = 55.0
    
    override init() {
        super.init(componentClass: MovementComponent.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        for component in components {
            guard let input = component.entity?.component(ofType: InputComponent.self),
                  let node = component.entity?.component(ofType: RenderComponent.self)?.spriteNode,
                  let physicsBody = node.physicsBody,
                  let movementState = component.entity?.component(ofType: MovementStateComponent.self) else {
                continue
            }
            
            // 1. Определяем направление (горизонтальное движение)
            let moveDirection = CGVector(dx: input.moveX, dy: 0)
            
            // 2. Применяем движение
            if moveDirection.dx != 0 {
                movementState.isMoving = true
                movementState.facingRight = moveDirection.dx > 0
                
                // Для SpriteKit physics
                physicsBody.velocity.dx = moveDirection.dx * component.maxSpeed
                
                // ИЛИ для кастомного движения:
                // position.x += moveDirection.dx * component.speed * seconds
            } else {
                movementState.isMoving = false
                physicsBody.velocity.dx = 0 // Торможение
            }
            
            // 3. Отражаем спрайт
            if abs(input.moveX) > 0.1 {
                movementState.facingRight = input.moveX > 0
                node.xScale = movementState.facingRight ? abs(node.xScale) : -abs(node.xScale)
            }
        }
    }
}

