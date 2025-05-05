//
//  JumpComponent.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 19.04.2025.
//
import GameplayKit
import SpriteKit

class JumpComponent: GKComponent {
    var jumpForce: CGFloat
    var jumpCooldown: TimeInterval
    var cooldownTimer: TimeInterval = 0
    
    init(force: CGFloat, cooldown: TimeInterval) {
        self.jumpForce = force
        self.jumpCooldown = cooldown
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
