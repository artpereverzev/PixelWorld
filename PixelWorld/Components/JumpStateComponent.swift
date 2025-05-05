//
//  JumpStateComponent.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 30.04.2025.
//
import GameplayKit
import SpriteKit

class JumpStateComponent: GKComponent {
    var jumpPressed: Bool = false
    var isJumping: Bool = false
    var isGrounded: Bool = true
    var canJump: Bool = true
}
