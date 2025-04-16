//
//  InputSystem.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 09.04.2025.
//
import GameplayKit
import SpriteKit

class InputSystem: GKComponentSystem<InputComponent> {
    private var previousJumpState = false
    
    override init() {
        super.init(componentClass: InputComponent.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        for component in components {
            // Обновляем ввод от джойстика
            //component.moveX = joystick.direction.dx
            guard let joystick = component.entity?.component(ofType: JoystickComponent.self),
                  let attackJoystick = component.entity?.component(ofType: AttackJoystickComponent.self) else {
                continue
            }
            component.moveX = joystick.direction.dx
            component.moveY = joystick.direction.dy
            
            component.moveAttackX = attackJoystick.direction.dx
            component.moveAttackY = attackJoystick.direction.dy
            
            
            // Определяем состояние прыжка
            if joystick.direction.dy > 0.7 {
                component.jumpPressed = true
            } else {
                component.jumpPressed = false
            }
            
            if attackJoystick.direction.dy > 0.7 {
                component.isAttacking = true
            } else if attackJoystick.direction.dy < -0.7 {
               component.isAttacking = true
            } else if attackJoystick.direction.dx > 0.7 || attackJoystick.direction.dx < -0.7 {
                component.isAttacking = true
            } else {
                component.isAttacking = false
            }
        }
    }
}
