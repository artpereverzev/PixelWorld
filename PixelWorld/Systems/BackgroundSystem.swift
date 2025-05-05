//
//  BackgroundSystem.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 17.04.2025.
//
import GameplayKit
import SpriteKit

class BackgroundSystem: GKComponentSystem<BackgroundComponent> {
    private weak var scene: SKScene?
    
    init(scene: SKScene) {
        self.scene = scene
        super.init(componentClass: BackgroundComponent.self)
    }
    
    func setupLayer(_ type: BackgroundType, image: BackgroundImage) -> SKSpriteNode {
        let containerNode = SKSpriteNode()
        let layer1 = SKSpriteNode(texture: image.texture)
        let layer2 = SKSpriteNode(texture: image.texture)
        
        layer1.zPosition = image.zPosition
        layer2.zPosition = image.zPosition
        
        layer1.position = image.position
        layer2.position = CGPoint(x: image.position.x + image.size.width, y: image.position.y)
        
        layer1.size = image.size
        layer2.size = image.size
        
        containerNode.addChild(layer1)
        containerNode.addChild(layer2)
        
        return containerNode
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        for component in components {
            for (type, image) in component.allBackgroundImages {
                if component.backgroundLayers[type] == nil {
                    let container = setupLayer(type, image: image)
                    scene?.addChild(container)
                    component.backgroundLayers[type] = container
                }
            }
            
            for (type, container) in component.backgroundLayers {
                guard let image = component.allBackgroundImages[type],
                      let camera = scene?.camera else {
                    continue
                }
                
                let cameraPosition = camera.position
                let viewSize = scene?.size ?? .zero
                
                // Обновляем позицию контейнера
                container.position.x = cameraPosition.x * image.parallaxSpeed
                
                // Проверяем и корректируем позиции слоев
                for node in container.children.compactMap({ $0 as? SKSpriteNode }) {
                    guard let scene = scene else {
                        return
                    }
                    let nodePositionInScene = container.convert(node.position, to: scene)
                    
                    if nodePositionInScene.x + node.size.width/2 < cameraPosition.x - viewSize.width/2 {
                        node.position.x += node.size.width * 2
                    }
                    else if nodePositionInScene.x - node.size.width/2 > cameraPosition.x + viewSize.width/2 {
                        node.position.x -= node.size.width * 2
                    }
                }
            }
        }
    }
}
