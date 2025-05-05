//
//  Spawner.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 05.05.2025.
//
import GameplayKit
import SpriteKit

class Spawner: GameEntity {
    override init(){
        super.init()
        let renderComponent = RenderComponent(texture: SKTexture(imageNamed: ""), scale: 1.5, entity: self)
        let positionComponent = PositionComponent(position: CGPoint(x: 0, y: 440), zPos: 0)
        let spawnComponent = SpawnComponent(spawnTypes: [.slime], spawnArea: CGRect(x: -200, y: 500, width: 400, height: 100), cooldown: 100000000.0)
        
        self.addComponent(renderComponent)
        self.addComponent(positionComponent)
        self.addComponent(spawnComponent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
