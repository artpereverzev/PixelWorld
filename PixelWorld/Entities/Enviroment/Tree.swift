//
//  Tree.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 01.05.2025.
//
import GameplayKit
import SpriteKit

class Tree: GameEntity {
    let treeTextures: [SKTexture] = [
        SKTexture(imageNamed: "treeLeaf_type1_0"),
        SKTexture(imageNamed: "treeLeaf_type2_0"),
        SKTexture(imageNamed: "treeLeaf_type3_0"),
        SKTexture(imageNamed: "tree_type1_0"),
        SKTexture(imageNamed: "tree_type2_0"),
        SKTexture(imageNamed: "tree_type3_0")
    ]
    
    override init(){
        super.init()
        self.tag.insert(.tree)
        let renderComponent = RenderComponent(texture: treeTextures[0], scale: 1.5, entity: self)
        let positionComponent = PositionComponent(position: CGPoint(x: 0, y: 440), zPos: 10)
        
        self.addComponent(renderComponent)
        self.addComponent(positionComponent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
