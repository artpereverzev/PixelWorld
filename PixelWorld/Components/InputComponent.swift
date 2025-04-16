//
//  InputComponent.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 09.04.2025.
//
import GameplayKit
import SpriteKit

class InputComponent: GKComponent {
    var moveLeft = false
    var moveRight = false
    
    var moveX: CGFloat = 0
    var moveY: CGFloat = 0
    
    var moveAttackX: CGFloat = 0
    var moveAttackY: CGFloat = 0
    
    var jumpPressed: Bool = false
    var jumpJustPressed: Bool = false
    
    var isAttacking: Bool = false
}
