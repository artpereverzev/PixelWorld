//
//  TileMapSystem.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 14.04.2025.
//
import GameplayKit
import SpriteKit

class TileMapSystem: GKComponentSystem<TileMapComponent> {
    let scene: SKScene
    
    init(scene: SKScene) {
        self.scene = scene
        super.init(componentClass: TileMapComponent.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        for component in components {
            //component.tileSet?.name = "Dirt Tile Set"
            guard component.tileMap == nil,
                  let tileSet = component.tileSet else {
                continue
            }
            
            let tileMap = SKTileMapNode(
                tileSet: tileSet,
                columns: component.columns,
                rows: component.rows,
                tileSize: component.tileSize
            )
            
            tileMap.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
            tileMap.setScale(component.scale)
            component.tileMap = tileMap
            
            if let grassGroup = tileSet.tileGroups.first(where: { $0.name == "Grass" }) {
                for column in 0..<tileMap.numberOfColumns {
                    for row in 0..<tileMap.numberOfRows {
                        tileMap.setTileGroup(grassGroup, forColumn: column, row: row)
                    }
                }
            }
            if let dirtGroup = tileSet.tileGroups.first(where: { $0.name == "Dirt" }) {
                for column in 0..<tileMap.numberOfColumns {
                    for row in 0..<tileMap.numberOfRows {
                        tileMap.setTileGroup(dirtGroup, forColumn: column, row: row)
                    }
                }
            }
            scene.addChild(tileMap)
            
            if let entity = component.entity,
               let physicsComponent = entity.component(ofType: PhysicsComponent.self) {
                physicsComponent.tileMapNode = tileMap
            }
        }
    }
}


