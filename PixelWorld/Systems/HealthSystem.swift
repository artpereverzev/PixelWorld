//
//  HealthSystem.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 19.04.2025.
//
import GameplayKit
import SpriteKit

class HealthSystem: GKComponentSystem<HealthComponent> {
    let margin: CGFloat = 100
    
    override init() {
        super.init(componentClass: HealthComponent.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {

    }
}
