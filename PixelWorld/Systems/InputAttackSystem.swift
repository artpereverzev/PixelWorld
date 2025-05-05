//
//  InputAttackSystem.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 01.05.2025.
//
import GameplayKit
import SpriteKit

class InputAttackSystem: GKComponentSystem<InputAttackComponent> {
    private var previousJumpState = false
    
    override init() {
        super.init(componentClass: InputAttackComponent.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        for component in components {
            guard let attackJoystick = component.entity?.component(ofType: AttackJoystickComponent.self),
                  let attackState = component.entity?.component(ofType: AttackStateComponent.self) else {
                continue
            }
            
            component.moveAttackX = attackJoystick.direction.dx
            component.moveAttackY = attackJoystick.direction.dy
            
            if attackJoystick.direction.dy > 0.7 {
                attackState.isAttacking = true
            } else if attackJoystick.direction.dy < -0.7 {
                attackState.isAttacking = true
            } else if attackJoystick.direction.dx > 0.7 || attackJoystick.direction.dx < -0.7 {
                attackState.isAttacking = true
            } else {
                attackState.isAttacking = false
            }
        }
    }
}
