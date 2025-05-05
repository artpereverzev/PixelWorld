//
//  PositionSystem.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 23.04.2025.
//
import GameplayKit
import SpriteKit

class PositionSystem: GKComponentSystem<PositionComponent> {
    
    override init() {
        super.init(componentClass: PositionComponent.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        for component in components {

        }
    }
}
