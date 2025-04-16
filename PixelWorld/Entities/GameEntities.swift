//
//  GameEntities.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 08.04.2025.
//
import GameplayKit
import SpriteKit

class GameEntity: GKEntity {
    let uuid = UUID()
    var tag = Set<String>()
}
