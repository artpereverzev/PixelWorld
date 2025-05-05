//
//  BackgroundComponent.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 17.04.2025.
//
import GameplayKit
import SpriteKit

enum BackgroundType {
    case firstLayer
    case secondLayer
    case thirdLayer
    case fourthLayer
}

class BackgroundComponent: GKComponent {
    var backgroundLayers: [BackgroundType: SKSpriteNode] = [:]
    var allBackgroundImages: [BackgroundType: BackgroundImage] = [:]
}

struct BackgroundImage {
    let texture: SKTexture
    let zPosition: CGFloat
    let size: CGSize
    let position: CGPoint
    let parallaxSpeed: CGFloat
    
    init(texture: SKTexture, zPosition: CGFloat, size: CGSize, position: CGPoint, parallaxSpeed: CGFloat) {
        self.texture = texture
        self.zPosition = zPosition
        self.size = size
        self.position = position
        self.parallaxSpeed = parallaxSpeed
    }
}
