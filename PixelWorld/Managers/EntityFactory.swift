//
//  EntityFactory.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 05.05.2025.
//
import GameplayKit
import SpriteKit

protocol EntityFactory {
    func createEnemy(of type: EnemyType, at position: CGPoint) -> GKEntity
}

class GameEntityFactory: EntityFactory {
    
    func createEnemy(of type: EnemyType, at position: CGPoint) -> GKEntity {
        switch type {
        case .slime:
            let slime = Slime()
            slime.addComponent(PositionComponent(position: CGPoint(x: position.x, y: 500), zPos: 100))
            slime.addComponent(MovementComponent())
            // ... другие компоненты
            return slime
        }
    }
}
