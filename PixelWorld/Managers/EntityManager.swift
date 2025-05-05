//
//  EntityManager.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 03.05.2025.
//

import SpriteKit
import GameplayKit

// MARK: - Протокол для обертки систем компонентов
protocol GKComponentSystemProtocol: AnyObject {
    func update(deltaTime: TimeInterval)
    func addComponent(foundIn entity: GKEntity)
    func removeComponent(foundIn entity: GKEntity)
}

// MARK: - Обертка для GKComponentSystem
final class ComponentSystemWrapper<T: GKComponent>: GKComponentSystemProtocol {
    let system: GKComponentSystem<T>
    
    init(_ system: GKComponentSystem<T>) {
        self.system = system
    }
    
    func update(deltaTime: TimeInterval) {
        system.update(deltaTime: deltaTime)
    }
    
    func addComponent(foundIn entity: GKEntity) {
        if let component = entity.component(ofType: T.self) {
            system.addComponent(component)
        }
    }
    
    func removeComponent(foundIn entity: GKEntity) {
        if let component = entity.component(ofType: T.self) {
            system.removeComponent(component)
        }
    }
}

// MARK: - EntityManager
final class EntityManager {
    
    // Ссылка на сцену SpriteKit
    let scene: SKScene
    
    // Все сущности
    private var entities = Set<GKEntity>()
    
    // Все системы компонентов
    var componentSystems = [GKComponentSystemProtocol]()
    
    // Для быстрого поиска сущности по ноде
    private var entitiesForNodes = [SKNode: GKEntity]()
    
    // Группы сущностей
    private var entityGroups = [String: Set<GKEntity>]()
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    // MARK: - Управление сущностями
    
    func add(_ entity: GKEntity) {
        entities.insert(entity)
        
        // Если есть RenderComponent, добавляем ноду на сцену
        if let spriteNode = entity.component(ofType: RenderComponent.self)?.spriteNode {
            entitiesForNodes[spriteNode] = entity
        }
        
        // Добавляем компоненты сущности во все системы
        for system in componentSystems {
            system.addComponent(foundIn: entity)
        }
    }
    
    func remove(_ entity: GKEntity) {
        guard entities.contains(entity) else { return }
        
        // Удаляем ноду со сцены
        if let spriteNode = entity.component(ofType: RenderComponent.self)?.spriteNode {
            spriteNode.removeFromParent()
            entitiesForNodes.removeValue(forKey: spriteNode)
        }
        
        // Удаляем удаляем все компоненты у сущности
        for component in entity.components {
            entity.removeComponent(ofType: type(of: component))
        }
        
        // Удаляем из всех систем
        for system in componentSystems {
            system.removeComponent(foundIn: entity)
        }
        
        // Удаляем из групп
        for (group, _) in entityGroups where entityGroups[group]?.contains(entity) == true {
            entityGroups[group]?.remove(entity)
        }
        
        // Удаляем сущность
        entities.remove(entity)
    }
    
    // MARK: - Управление системами
    
    func addSystem<T: GKComponent>(_ system: GKComponentSystem<T>) {
        let wrapper = ComponentSystemWrapper(system)
        componentSystems.append(wrapper)
        
        // Добавляем все подходящие компоненты в систему
        for entity in entities {
            wrapper.addComponent(foundIn: entity)
        }
    }
    
    func removeSystem<T: GKComponent>(_ system: GKComponentSystem<T>) {
        componentSystems.removeAll { wrapper in
            guard let wrapper = wrapper as? ComponentSystemWrapper<T> else { return false }
            return wrapper.system === system
        }
    }
    
    // MARK: - Группировка сущностей
    
    func add(_ entity: GKEntity, toGroup group: String) {
        if entityGroups[group] == nil {
            entityGroups[group] = Set<GKEntity>()
        }
        entityGroups[group]?.insert(entity)
    }
    
    func remove(_ entity: GKEntity, fromGroup group: String) {
        entityGroups[group]?.remove(entity)
    }
    
    func entities(inGroup group: String) -> [GKEntity] {
        return Array(entityGroups[group] ?? [])
    }
    
    // MARK: - Вспомогательные методы
    
    func entity(for node: SKNode) -> GKEntity? {
        return entitiesForNodes[node]
    }
    
    func update(_ deltaTime: CFTimeInterval) {
        for system in componentSystems {
            system.update(deltaTime: deltaTime)
        }
    }
    
    func components<T: GKComponent>(ofType type: T.Type) -> [T] {
        return entities.compactMap { $0.component(ofType: type) }
    }
    
    func entities(with componentTypes: [GKComponent.Type]) -> [GKEntity] {
        return entities.filter { entity in
            componentTypes.allSatisfy { type in
                entity.component(ofType: type) != nil
            }
        }
    }
    
    func countEntities() -> Int {
        return entities.count
    }
}


