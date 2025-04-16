//
//  PhysicsSystem.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 10.04.2025.
//
import GameplayKit
import SpriteKit

class PhysicsSystem: GKComponentSystem<PhysicsComponent> {
    let scene: SKScene
    let bodyCategory = PhysicsBody()
    
    init(scene: SKScene) {
        self.scene = scene
        super.init(componentClass: PhysicsComponent.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        for component in components {
            guard let bodyCategory = PhysicsBody.forType(component.bodyCategory) else {
                continue
            }
            
            // Обработка обычных спрайтов
            if let sprite = component.spriteNode {
                configurePhysics(for: sprite, component: component, bodyCategory: bodyCategory)
            }
            // Обработка тайловых карт
            else if let tileMap = component.tileMapNode {
                configurePhysics(for: tileMap, component: component, bodyCategory: bodyCategory)
            }
        }
    }
    
    private func configurePhysics(for sprite: SKSpriteNode,
                                  component: PhysicsComponent,
                                  bodyCategory: PhysicsBody) {
        let size = sprite.size
        
        if component.bodyShape == .rect {
            sprite.physicsBody = SKPhysicsBody(rectangleOf: size)
        } else {
            sprite.physicsBody = SKPhysicsBody(circleOfRadius: size.height / 2)
        }
        
        applyCommonPhysics(sprite.physicsBody, component: component, bodyCategory: bodyCategory)
        sprite.physicsBody?.affectedByGravity = true
        sprite.physicsBody?.linearDamping = 0.1
        sprite.physicsBody?.density = 0.7
        sprite.physicsBody?.friction = 0.2
    }
    
    private func configurePhysics(for tileMap: SKTileMapNode,
                                 component: PhysicsComponent,
                                  bodyCategory: PhysicsBody) {
        // Рассчитываем правильный frame с учетом scale
        let scaledWidth = tileMap.frame.width// * tileMap.xScale
        let scaledHeight = tileMap.frame.height// * tileMap.yScale
        let scaledFrame = CGRect(
            x: tileMap.position.x - (scaledWidth / 2),
            y: tileMap.position.y - (scaledHeight / 2),
            width: scaledWidth,
            height: scaledHeight
        )
        
        let scaledHeightMax = tileMap.frame.maxY
        let scaledFrameMax = CGRect(
            x: tileMap.position.x - (scaledWidth / 2),
            y: tileMap.position.y - (scaledHeightMax / 2),
            width: scaledWidth,
            height: scaledHeightMax
        )
        
        if component.isEdgeLoop {
            tileMap.physicsBody = SKPhysicsBody(edgeLoopFrom: scaledFrameMax)
            tileMap.physicsBody = SKPhysicsBody(edgeLoopFrom: scaledFrame)
        } else {
            tileMap.physicsBody = SKPhysicsBody(rectangleOf: scaledFrame.size, center: CGPoint(x: scaledFrame.midX, y: scaledFrame.midY))
        }
        
        applyCommonPhysics(tileMap.physicsBody, component: component, bodyCategory: bodyCategory)
        tileMap.physicsBody?.isDynamic = false
        tileMap.physicsBody?.affectedByGravity = false
        
//        print("TILEMAP: Configuring physics for tileMap at position: \(tileMap.position)")
//        print("TILEMAP: TileMap frame: \(tileMap.frame), scale: \(tileMap.xScale), \(tileMap.yScale)")
//        
//        print("TILEMAP: Final physics body: \(tileMap.physicsBody?.description ?? "nil")")
//        print("TILEMAP: Category: \(tileMap.physicsBody?.categoryBitMask ?? 0)")
//        print("TILEMAP: Collision: \(tileMap.physicsBody?.collisionBitMask ?? 0)")
//        print("TILEMAP: Contact: \(tileMap.physicsBody?.contactTestBitMask ?? 0)")
    }
    
    private func applyCommonPhysics(_ physicsBody: SKPhysicsBody?,
                                    component: PhysicsComponent,
                                    bodyCategory: PhysicsBody) {
        physicsBody?.categoryBitMask = bodyCategory.categoryBitMask
        physicsBody?.collisionBitMask = bodyCategory.collisionBitMask
        physicsBody?.contactTestBitMask = bodyCategory.contactTestBitMask
        physicsBody?.allowsRotation = false
    }
}

