//
//  HealthBarRenderingSystem.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 20.04.2025.
//
import GameplayKit
import SpriteKit

class HealthBarRenderingSystem: GKComponentSystem<HealthBarComponent> {
    private let scene: SKScene
    
    init(scene: SKScene) {
        self.scene = scene
        super.init(componentClass: HealthBarComponent.self)
    }
    
    override func update(deltaTime: TimeInterval) {
        for component in components {
            guard let render = component.entity?.component(ofType: RenderComponent.self) else { continue }
            
            let sprite = render.spriteNode
            
            // Инициализация нод при первом обновлении
            if component.backgroundNode == nil {
                let nodes = component.createNodes()
                scene.addChild(nodes.background)
                scene.addChild(nodes.foreground)
            }
            
            // Позиционирование относительно спрайта
           let spriteWorldPos = sprite.convert(CGPoint.zero, to: scene)
            
            let healthBarPos = CGPoint(
                x: spriteWorldPos.x + component.style.offset.x,
                y: spriteWorldPos.y + sprite.frame.height/2 + component.style.offset.y
            )
            
            component.backgroundNode?.position = healthBarPos
            component.foregroundNode?.position = healthBarPos
            
            // Обновление размера foreground в соответствии с здоровьем
            if let health = component.entity?.component(ofType: HealthComponent.self) {
                let healthPercentage = health.currentHealth / health.maxHealth
                let newWidth = component.style.size.width * healthPercentage
                
                component.foregroundNode?.run(.resize(toWidth: newWidth, duration: 0.1))
            }
        }
    }
}
