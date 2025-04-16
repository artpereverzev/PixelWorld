//
//  TileMapComponent.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 14.04.2025.
//
import GameplayKit
import SpriteKit

class TileMapComponent: GKComponent {
    weak var tileMap: SKTileMapNode?
    var tileSet: SKTileSet?
    var columns: Int
    var rows: Int
    var tileSize = CGSize(width: 16, height: 16)
    var scale: CGFloat = 1.0
    
    init(tileMap: SKTileMapNode? = nil, tileSet: SKTileSet, columns: Int, rows: Int, tileSize: CGSize, scale: CGFloat) {
        self.tileMap = tileMap
        self.tileSet = tileSet
        self.columns = columns
        self.rows = rows
        self.tileSize = tileSize
        self.scale = scale
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

