//
//  CameraSystem.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 12.04.2025.
//
import GameplayKit
import SpriteKit

class CameraSystem: GKComponentSystem<CameraComponent> {
    private weak var scene: SKScene?
    
    init(scene: SKScene) {
        self.scene = scene
        super.init(componentClass: CameraComponent.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        for component in components {
            guard let scene = scene,
                  let followTarget = component.followTarget else { continue }
            
            // Если камера еще не добавлена в сцену — добавляем
            if component.cameraNode.parent == nil {
                scene.camera = component.cameraNode
                scene.addChild(component.cameraNode)
            }
            
            // Плавное следование за целью (Lerp)
            let targetPosition = followTarget.position
            let currentPosition = component.cameraNode.position
            let newPosition = CGPoint(
                x: currentPosition.x + (targetPosition.x - currentPosition.x) * component.smoothness,
                y: currentPosition.y + (targetPosition.y - currentPosition.y) * component.smoothness
            )
            
            component.cameraNode.position = newPosition
            component.cameraNode.setScale(component.zoom)
        }
    }
}
