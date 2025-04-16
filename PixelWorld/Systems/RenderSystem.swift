//
//  RenderSystem.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 08.04.2025.
//
import GameplayKit
import SpriteKit

class RenderSystem: GKComponentSystem<RenderComponent> {
    let scene: SKScene
    
    init(scene: SKScene) {
        self.scene = scene
        super.init(componentClass: RenderComponent.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        for component in components {
            if component.spriteNode.parent == nil {
                scene.addChild(component.spriteNode)
                component.spriteNode.position = CGPoint(x: 0, y: 200)
            }
        }
    }
}

