//
//  SpawnComponent.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 04.05.2025.
//
import GameplayKit
import SpriteKit

class SpawnComponent: GKComponent {
    var spawnTypes: [EnemyType] // Типы врагов (слайм, гоблин и т.д.)
    var spawnArea: CGRect       // Зона спавна
    var cooldown: TimeInterval  // Задержка между волнами
    var lastSpawnTime: TimeInterval = 0
    var isActive = true
    
    init(spawnTypes: [EnemyType], spawnArea: CGRect, cooldown: TimeInterval) {
        self.spawnTypes = spawnTypes
        self.spawnArea = spawnArea
        self.cooldown = cooldown
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
