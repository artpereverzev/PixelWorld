//
//  RenderComponent.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 08.04.2025.
//
import GameplayKit
import SpriteKit

class RenderComponent: GKComponent {
    var spriteNode: SKSpriteNode
    
    var texture: SKTexture
    var scale: CGFloat
    
    init(texture: SKTexture, scale: CGFloat, entity: GKEntity) {
        self.texture = texture
        self.scale = scale
        self.spriteNode = SKSpriteNode(texture: texture)
        self.spriteNode.setScale(scale)
        
        // Устанавливаем связь между нодой и сущностью
        self.spriteNode.userData = NSMutableDictionary()
        self.spriteNode.userData?.setValue(entity, forKey: "entity")
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

