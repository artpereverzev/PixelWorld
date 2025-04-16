//
//  TileMapFactory.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 14.04.2025.
//
import GameplayKit
import SpriteKit

class TileMapFactory {
    private let scene: SKScene
    private let tileSet: SKTileSet
    
    init(scene: SKScene, tileSet: SKTileSet) {
        self.scene = scene
        self.tileSet = tileSet
    }
    
    func createDefaultTileMap() -> GKEntity {
        let entity = GKEntity()
        
        // TileMap Component
        let tileMapComponent = TileMapComponent(
            tileMap: nil,
            tileSet: tileSet,
            columns: Int.random(in: 40...200),
            rows: Int.random(in: 1...20),
            tileSize: CGSize(width: 16, height: 16),
            scale: 2.2
        )
        entity.addComponent(tileMapComponent)
        
        // Physics Component
        let physicsComponent = PhysicsComponent(
            bodyCategory: .tileMap,
            bodyShape: .rect,
            isEdgeLoop: true
        )
        entity.addComponent(physicsComponent)
        
        return entity
    }
}
