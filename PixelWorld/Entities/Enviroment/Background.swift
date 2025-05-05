//
//  Background.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 17.04.2025.
//
import GameplayKit
import SpriteKit

class Background: GameEntity {
    
    override init(){
        super.init()
        self.tag.insert(.background)
        
        let backgroundComponent = BackgroundComponent()
        backgroundComponent.allBackgroundImages = [
            .firstLayer: BackgroundImage(
                texture: SKTexture(imageNamed: "sky"),
                zPosition: 0.1,
                size: CGSize(width: 384 * 100, height: 216 * 100),
                position: .zero,
                parallaxSpeed: 0.0
            ),
            .secondLayer: BackgroundImage(
                texture: SKTexture(imageNamed: "glacial_mountains"),
                zPosition: 0.2,
                size: CGSize(width: 384 * 3, height: 216 * 3),
                position: CGPoint(x: 0.0, y: 500.0),
                parallaxSpeed: 0.7
            ),
            .thirdLayer: BackgroundImage(
                texture: SKTexture(imageNamed: "clouds_bg"),
                zPosition: 0.3,
                size: CGSize(width: 384 * 3, height: 216 * 3),
                position: CGPoint(x: 0.0, y: 500.0),
                parallaxSpeed: 0.8
                
            ),
            .fourthLayer: BackgroundImage(
                texture: SKTexture(imageNamed: "clouds_mg_2"),
                zPosition: 0.4,
                size: CGSize(width: 384 * 3, height: 216 * 3),
                position: CGPoint(x: 0.0, y: 600.0),
                parallaxSpeed: 1.0
            )
        ]
        
        self.addComponent(backgroundComponent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
