//
//  AnimationComponent.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 08.04.2025.
//
import SpriteKit
import GameplayKit

enum AnimationType {
    case idle
    case moving
    case attacking
    case jumping
    case none
}

class AnimationComponent: GKComponent {
    weak var spriteNode: SKSpriteNode?
    
    var currentAnimationType: AnimationType = .none
    var requestedAnimationType: AnimationType?
    
    var allAnimations: [AnimationType: Animation] = [:]
    
}

struct Animation {
    let textures: [SKTexture]
    var timePerFrame: TimeInterval
    
    let repeatTexturesForever: Bool
    let resizeTexture: Bool
    let restoreTexture: Bool
    
    init(textures: [SKTexture],
         timePerFrame: TimeInterval = TimeInterval(1.0 / 5.0),
         repeatTexturesForever: Bool = true,
         resizeTexture: Bool = true,
         restoreTexture: Bool = true) {
        self.textures = textures
        self.timePerFrame = timePerFrame
        self.repeatTexturesForever = repeatTexturesForever
        self.resizeTexture = resizeTexture
        self.restoreTexture = restoreTexture
    }
}


