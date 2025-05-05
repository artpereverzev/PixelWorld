//
//  MovementComponent.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 08.04.2025.
//
import GameplayKit
import SpriteKit

class MovementComponent: GKComponent {
    var velocity = CGVector(dx: 0, dy: 0)
    
    let maxSpeed: CGFloat = 200
}
