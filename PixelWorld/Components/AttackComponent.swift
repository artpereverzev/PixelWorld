//
//  AttackComponent.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 16.04.2025.
//
import GameplayKit
import SpriteKit

class AttackComponent: GKComponent {
    let isAttacking: Bool = false
    
    let damageMelee: CGFloat = 50.0
    let damageRange: CGFloat = 75.0
    let damageMagic: CGFloat = 100.0
}
