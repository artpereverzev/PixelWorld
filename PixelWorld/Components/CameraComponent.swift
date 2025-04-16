//
//  CameraComponent.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 12.04.2025.
//
import GameplayKit
import SpriteKit

class CameraComponent: GKComponent {
    weak var spriteNode: SKSpriteNode?
    
    var cameraNode: SKCameraNode
    var followTarget: SKNode? // За кем следить (например, игрок)
    var smoothness: CGFloat = 0.1 // Плавность слежения (0 — резко, 1 — плавно)
    var zoom: CGFloat = 1.0 // Масштаб
    
    init(followTarget: SKNode?) {
        self.cameraNode = SKCameraNode()
        self.followTarget = followTarget
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
