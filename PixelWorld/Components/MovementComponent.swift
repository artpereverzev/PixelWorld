//
//  MovementComponent.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 08.04.2025.
//
import GameplayKit
import SpriteKit

class MovementComponent: GKComponent {
    weak var spriteNode: SKSpriteNode?
    
    var countJumps: UInt = 0
    var jumpForce: CGFloat = 3000.0
    
    var isGrounded = false
    var isMoving: Bool = false
    var isJumping: Bool = false
    
    var direction: CGVector = .zero

    var velocity = CGVector(dx: 0, dy: 0)
    let maxSpeed: CGFloat = 200
    let acceleration: CGFloat = 20
    
    var facingRight = true
}
