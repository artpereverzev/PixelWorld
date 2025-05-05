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
    private let entityManager: EntityManager
    
    init(scene: SKScene, entityManager: EntityManager) {
        self.scene = scene
        self.entityManager = entityManager
        super.init()
        scene.physicsWorld.contactDelegate = self
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        // Player vs TileMap
        if collision == (PhysicsBody.player.rawValue | PhysicsBody.tileMap.rawValue) {
            handlePlayerTileMapCollision(contact, began: true)
        // Monster vs TileMap
        } else if collision == (PhysicsBody.monster.rawValue | PhysicsBody.tileMap.rawValue) {
            handlePlayerTileMapCollision(contact, began: true)
        // Player vs Monster
        } else if collision == (PhysicsBody.player.rawValue | PhysicsBody.monster.rawValue) {
            handlePlayerMonsterCollision(contact, began: true)
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
              let jumpState = entity.component(ofType: JumpStateComponent.self) else {
            return
        }
        
        jumpState.isGrounded = true
        
        // Здесь можно добавить логику обработки столкновения
        // Например:
        // 1. Остановить игрока
        // 2. Воспроизвести звук
        // 3. Обновить статистику
    }
    
    private func handlePlayerMonsterCollision(_ contact: SKPhysicsContact, began: Bool) {
        
        // Определяем какой body принадлежит игроку
        let playerBody = contact.bodyA.categoryBitMask == PhysicsBody.player.rawValue ?
        contact.bodyA : contact.bodyB
        let monsterBody = contact.bodyA.categoryBitMask == PhysicsBody.monster.rawValue ?
        contact.bodyA : contact.bodyB
        
        // Получаем ноду игрока
        guard let playerNode = playerBody.node,
              let monsterNode = monsterBody.node,
              let entity = playerNode.userData?["entity"] as? GKEntity,
              let monsterEntity = monsterNode.userData?["entity"] as? GKEntity,
              let health = entity.component(ofType: HealthComponent.self),
              let monsterHealth = monsterEntity.component(ofType: HealthComponent.self) else {
            return
        }
        if health.currentHealth > 0 {
            health.currentHealth -= 1
            print("Player collide with a monster")
        }
        
        if monsterHealth.currentHealth > 0 {
            monsterHealth.currentHealth -= 1
            print("Monster collide with a player")
        } else if monsterHealth.currentHealth == 0 {
            print("Monster should die")
            entityManager.remove(monsterEntity)
//            removeEntity(monsterEntity)
        }
        
        // Здесь можно добавить логику обработки столкновения
        // Например:
        // 1. Остановить игрока
        // 2. Воспроизвести звук
        // 3. Обновить статистику
    }
    
    private func removeEntity(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: RenderComponent.self)?.spriteNode {
            spriteNode.removeAllActions()  // Отменяем анимации
            spriteNode.physicsBody = nil  // Удаляем физическое тело
            spriteNode.removeFromParent()
        }
        print(entity.components)
        entity.removeComponent(ofType: RenderComponent.self)
        entity.removeComponent(ofType: PhysicsComponent.self)
        entity.removeComponent(ofType: AnimationComponent.self)
        entity.removeComponent(ofType: PositionComponent.self)
        entity.removeComponent(ofType: MovementComponent.self)
        entity.removeComponent(ofType: HealthComponent.self)
        entity.removeComponent(ofType: HealthBarComponent.self)
        print(entity.components)
    }
}
