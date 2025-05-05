//
//  GameEntities.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 08.04.2025.
//
import GameplayKit
import SpriteKit

enum EntityTag: String, Hashable {
    case player
    case enemy
    case tree
    case background
    case tiles
    case projectile
}

enum EnemyType {
    case slime
}

class GameEntity: GKEntity {
    let uuid = UUID()
    var tag = Set<EntityTag>()
}
