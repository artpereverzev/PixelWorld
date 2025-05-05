//
//  CameraComponent.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 12.04.2025.
//
import GameplayKit
import SpriteKit

class CameraComponent: GKComponent {
    
    var cameraNode: SKCameraNode
    var followTarget: SKNode?
    var smoothness: CGFloat = 0.1 // Greater - Smoother
    var zoom: CGFloat = 1.0 // Camera Zoom (1.0 - default, without scale)
    
    init(followTarget: SKNode?) {
        self.cameraNode = SKCameraNode()
        self.followTarget = followTarget
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
