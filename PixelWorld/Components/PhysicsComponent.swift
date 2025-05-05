//
//  PhysicsComponent.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 10.04.2025.
//

import SpriteKit
import GameplayKit

enum PhysicsCategory: String {
    case player
    case wall
    case door
    case monster
    case projectile
    case enemyProjectile
    case collectible
    case tileMap
    case exit
}

enum PhysicsShape: String {
    case circle
    case rect
}

struct PhysicsBody: OptionSet, Hashable {
    let rawValue: UInt32
    
    static let player = PhysicsBody(rawValue: 1 << 0) // 1
    static let wall = PhysicsBody(rawValue: 1 << 1) // 2
    static let door = PhysicsBody(rawValue: 1 << 2) // 4
    static let monster = PhysicsBody(rawValue: 1 << 3) // 8
    static let projectile = PhysicsBody(rawValue: 1 << 4) // 16
    static let enemyProjectile = PhysicsBody(rawValue: 1 << 5) // 32
    static let collectible = PhysicsBody(rawValue: 1 << 6) // 64
    static let tileMap = PhysicsBody(rawValue: 1 << 7) // 128
    static let exit = PhysicsBody(rawValue: 1 << 8) // 256
    
    static var collisions: [PhysicsBody: [PhysicsBody]] = [
        .player: [.tileMap],
        .monster: [.tileMap],
        .tileMap: [.player, .monster]
    ]
    
    static var contactTest: [PhysicsBody: [PhysicsBody]] = [
        .player: [.tileMap, .monster],
        .monster: [.tileMap, .player],
        .tileMap: [.player, .monster]
    ]
    
    var categoryBitMask: UInt32 {
        return rawValue
    }
    
    var collisionBitMask: UInt32 {
        let bitMask = PhysicsBody
            .collisions[self]?
            .reduce(PhysicsBody(), { result, physicsBody in
                return result.union(physicsBody) })
        
        return bitMask?.rawValue ?? 0
    }
    
    var contactTestBitMask: UInt32 {
        let bitMask = PhysicsBody
            .contactTest[self]?
            .reduce(PhysicsBody(), { result, physicsBody in
                return result.union(physicsBody) })
        
        return bitMask?.rawValue ?? 0
    }
    
    static func forType(_ type: PhysicsCategory?) -> PhysicsBody? {
        switch type {
        case .player:
            return self.player
        case .wall:
            return self.wall
        case .door:
            return self.door
        case .monster:
            return self.monster
        case .projectile:
            return self.projectile
        case .enemyProjectile:
            return Self.enemyProjectile
        case .collectible:
            return self.collectible
        case .tileMap:
            return Self.tileMap
        case .exit:
            return self.exit
        case .none:
            break
        }
        
        return nil
    }
}

class PhysicsComponent: GKComponent {
    weak var tileMapNode: SKTileMapNode?
    
    var bodyCategory: PhysicsCategory
    var bodyShape: PhysicsShape
    var isEdgeLoop: Bool = false
    
    init(bodyCategory: PhysicsCategory,
         bodyShape: PhysicsShape,
         isEdgeLoop: Bool = false) {
        self.bodyCategory = bodyCategory
        self.bodyShape = bodyShape
        self.isEdgeLoop = isEdgeLoop
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
