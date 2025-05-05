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
            guard let position = component.entity?.component(ofType: PositionComponent.self) else {
                continue
            }

            if component.spriteNode.parent == nil {
                component.spriteNode.position = position.position
                component.spriteNode.zPosition = position.zPos
                scene.addChild(component.spriteNode)
            }
        }
    }
}

