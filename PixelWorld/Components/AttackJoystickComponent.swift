//
//  AttackJoystickComponent.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 16.04.2025.
//
import GameplayKit
import SpriteKit

class AttackJoystickComponent: GKComponent {
    let baseAttackNode = SKShapeNode(circleOfRadius: 50)

    let stickAttackNode = SKShapeNode(circleOfRadius: 20)
    
    var currentAttackTouch: UITouch?
    
    var isAttackActive = false
    
    var direction = CGVector.zero
    
    override func didAddToEntity() {
        baseAttackNode.fillColor = .gray.withAlphaComponent(0.5)
        baseAttackNode.strokeColor = .clear
        baseAttackNode.zPosition = 1000
        
        stickAttackNode.fillColor = .darkGray.withAlphaComponent(0.8)
        stickAttackNode.strokeColor = .clear
        stickAttackNode.zPosition = 1001
    }
}
