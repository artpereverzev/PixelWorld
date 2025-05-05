//
//  PositionComponent.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 23.04.2025.
//
import GameplayKit
import SpriteKit

class PositionComponent: GKComponent {
    var velocity = CGVector(dx: 0, dy: 0)
    
    var position: CGPoint
    var zPos: CGFloat
    
    init(position: CGPoint, zPos: CGFloat) {
        self.position = position
        self.zPos = zPos
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }  
}
