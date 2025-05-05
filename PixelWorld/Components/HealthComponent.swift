//
//  HealthComponent.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 17.04.2025.
//
import GameplayKit
import SpriteKit

class HealthComponent: GKComponent {
    let maxHealth: CGFloat
    var currentHealth: CGFloat
    
    init(maxHealth: CGFloat, currentHealth: CGFloat) {
        self.maxHealth = maxHealth
        self.currentHealth = currentHealth
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
