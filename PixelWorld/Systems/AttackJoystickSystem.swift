//
//  AttackJoystickSystem.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 16.04.2025.
//
import GameplayKit
import SpriteKit

class AttackJoystickSystem: GKComponentSystem<AttackJoystickComponent> {
    let scene: SKScene
    let margin: CGFloat = 100
    
    init(scene: SKScene) {
        self.scene = scene
        super.init(componentClass: AttackJoystickComponent.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        for component in components {
            
            component.baseAttackNode.position = CGPoint(
                x: (scene.viewRight - margin - scene.insets.right),
                y: (scene.viewBottom + margin + scene.insets.bottom)
            )
            
            if component.baseAttackNode.parent == nil {
                scene.addChild(component.baseAttackNode)
            }
                
            if component.stickAttackNode.parent != component.baseAttackNode {
                component.stickAttackNode.removeFromParent()
                component.baseAttackNode.addChild(component.stickAttackNode)
                component.stickAttackNode.position = .zero
            }
                
            if !component.isAttackActive {
                component.stickAttackNode.position = .zero
            }
        }
    }
    
    func startTracking(with touch: UITouch, location: CGPoint) {
        let sceneLocation = touch.location(in: scene)
        
        for component in components {
            if component.baseAttackNode.contains(sceneLocation) {
                component.currentAttackTouch = touch
                component.isAttackActive = true
                updateStickPosition(for: component, location: sceneLocation)
                break
            }
        }
    }
    
    func updateTracking(with touch: UITouch, location: CGPoint) {
        let sceneLocation = touch.location(in: scene)
        
        for component in components {
            if touch == component.currentAttackTouch {
                updateStickPosition(for: component, location: sceneLocation)
                break
            }
        }
    }
    
    func endTracking() {
        for component in components {
            if component.isAttackActive {
                component.currentAttackTouch = nil
                component.isAttackActive = false
                resetStick(for: component)
            }
        }
    }
    
    private func updateStickPosition(for component: AttackJoystickComponent, location: CGPoint) {
        let localTouchPos = component.baseAttackNode.convert(location, from: scene)
        
        let vector = CGVector(dx: localTouchPos.x,
                             dy: localTouchPos.y)
        
        let distance = hypot(vector.dx, vector.dy)
        let maxDistance: CGFloat = 50
        
        let limitedDistance = min(distance, maxDistance)
        
        let normalizedVector = distance > 0 ?
            CGVector(dx: vector.dx/distance, dy: vector.dy/distance) :
            .zero
        
        component.stickAttackNode.position = CGPoint(
            x: normalizedVector.dx * limitedDistance,
            y: normalizedVector.dy * limitedDistance
        )
        
        component.direction = CGVector(
            dx: normalizedVector.dx * (limitedDistance/maxDistance),
            dy: normalizedVector.dy * (limitedDistance/maxDistance)
        )
    }
    
    private func resetStick(for component: AttackJoystickComponent) {
        let resetAction = SKAction.move(to: CGPoint(x: 0.0, y: 0.0), duration: 0.2)
        resetAction.timingMode = .easeOut
        component.stickAttackNode.run(resetAction)
        component.direction = .zero
    }
}

