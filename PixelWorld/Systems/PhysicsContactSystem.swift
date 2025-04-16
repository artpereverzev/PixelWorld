//
//  PhysicsContactSystem.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 14.04.2025.
//
import SpriteKit
import GameplayKit

class PhysicsContactSystem: NSObject, SKPhysicsContactDelegate {
    private let scene: SKScene
    
    init(scene: SKScene) {
        self.scene = scene
        super.init()
        scene.physicsWorld.contactDelegate = self
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        // Player vs TileMap
        if collision == (PhysicsBody.player.rawValue | PhysicsBody.tileMap.rawValue) {
            handlePlayerTileMapCollision(contact, began: true)
        }
        
        // Добавьте другие обработчики по аналогии
    }
    
    private func handlePlayerTileMapCollision(_ contact: SKPhysicsContact, began: Bool) {
        
        // Определяем какой body принадлежит игроку
        let playerBody = contact.bodyA.categoryBitMask == PhysicsBody.player.rawValue ?
        contact.bodyA : contact.bodyB
        
        // Получаем ноду игрока
        guard let playerNode = playerBody.node,
              let entity = playerNode.userData?["entity"] as? GKEntity,
              let movement = entity.component(ofType: MovementComponent.self) else {
            return
        }
        movement.isGrounded = true
        movement.isJumping = false
        
        if movement.countJumps > 0 {
            movement.countJumps -= 1
        }
        
        // Здесь можно добавить логику обработки столкновения
        // Например:
        // 1. Остановить игрока
        // 2. Воспроизвести звук
        // 3. Обновить статистику
    }
    
    private func removeEntity(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: RenderComponent.self)?.spriteNode {
            spriteNode.userData?.removeAllObjects()
        }
        // ... остальная логика удаления
    }
}
