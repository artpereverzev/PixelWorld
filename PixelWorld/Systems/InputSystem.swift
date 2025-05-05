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
            guard let joystick = component.entity?.component(ofType: JoystickComponent.self),
                  let jumpState = component.entity?.component(ofType: JumpStateComponent.self) else {
                continue
            }
            component.moveX = joystick.direction.dx
            component.moveY = joystick.direction.dy
            
            jumpState.jumpPressed = joystick.direction.dy > 0.7
        }
    }
}
