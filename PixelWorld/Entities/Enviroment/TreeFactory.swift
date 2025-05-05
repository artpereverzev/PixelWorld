//
//  TreeFactory.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 03.05.2025.
//
import GameplayKit
import SpriteKit

class TreeFactory {
    private let treeTextures: [SKTexture] = [
        SKTexture(imageNamed: "treeLeaf_type1_0"),
        SKTexture(imageNamed: "treeLeaf_type2_0"),
        SKTexture(imageNamed: "treeLeaf_type3_0"),
        SKTexture(imageNamed: "tree_type1_0"),
        SKTexture(imageNamed: "tree_type2_0"),
        SKTexture(imageNamed: "tree_type3_0")
    ]
    
    init(scene: SKScene) {
        
    }
    
    func createTrees(count: Int, in area: CGRect) -> [GKEntity] {
        return (0..<count).map { _ in
            let entity = GKEntity()
            
            let randomTexture = treeTextures.randomElement()!
            let randomX = CGFloat.random(in: area.minX...area.maxX)
            //let randomY = CGFloat.random(in: area.minY...area.maxY)
            
            // Основные компоненты
            entity.addComponent(RenderComponent(texture: randomTexture, scale: 1.5, entity: entity))
            entity.addComponent(PositionComponent(position: CGPoint(x: randomX, y: 450), zPos: 20))
            
            return entity
        }
    }
    
}



