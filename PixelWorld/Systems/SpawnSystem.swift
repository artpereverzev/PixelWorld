//
//  SpawnSystem.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 04.05.2025.
//
import GameplayKit
import SpriteKit

class SpawnSystem: GKComponentSystem<SpawnComponent> {
    private let factory: EntityFactory
    private let entityManager: EntityManager
    
    init(factory: EntityFactory, entityManager: EntityManager) {
        self.factory = factory
        self.entityManager = entityManager
        super.init(componentClass: SpawnComponent.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        for component in components {
            if component.isActive {
                component.lastSpawnTime += seconds
                
                if component.lastSpawnTime >= component.cooldown {
                    spawnEnemies(for: component)
                    component.lastSpawnTime = 0
                }
            }
        }
    }
    
    private func spawnEnemies(for spawner: SpawnComponent) {
        for type in spawner.spawnTypes {
            //let count = spawner.spawnTypes.count
            let count = 10
            let enemyLimit = 100
            let enemyCount = entityManager.entities(inGroup: "enemies").count
            print(enemyCount)
            if enemyCount < enemyLimit {
                for _ in 0..<count {
                    let pos = randomPosition(in: spawner.spawnArea)
                    let enemy = factory.createEnemy(of: type, at: pos)
                    entityManager.add(enemy)
                    entityManager.add(enemy, toGroup: "enemies")
                }
            }
        }
    }
    
    private func randomPosition(in area: CGRect) -> CGPoint {
        CGPoint(
            x: CGFloat.random(in: area.minX...area.maxX),
            y: CGFloat.random(in: area.minY...area.maxY)
        )
    }
}
