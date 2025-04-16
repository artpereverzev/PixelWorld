//
//  JoystickComponent.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 12.04.2025.
//
import GameplayKit
import SpriteKit

class JoystickComponent: GKComponent {
    let baseNode = SKShapeNode(circleOfRadius: 50)

    let stickNode = SKShapeNode(circleOfRadius: 20)
    
    var currentTouch: UITouch?
    
    var isActive = false
    
    var direction = CGVector.zero
    
    override func didAddToEntity() {
        baseNode.fillColor = .gray.withAlphaComponent(0.5)
        baseNode.strokeColor = .clear
        baseNode.zPosition = 1000
        
        stickNode.fillColor = .darkGray.withAlphaComponent(0.8)
        stickNode.strokeColor = .clear
        stickNode.zPosition = 1001
    }
}
