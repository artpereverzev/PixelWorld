//
//  JoystickSystem.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 12.04.2025.
//
import GameplayKit
import SpriteKit

class JoystickSystem: GKComponentSystem<JoystickComponent> {
    let scene: SKScene
    let margin: CGFloat = 100
    
    init(scene: SKScene) {
        self.scene = scene
        super.init(componentClass: JoystickComponent.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        for component in components {
            
            component.baseNode.position = CGPoint(
                x: (scene.viewLeft + margin + scene.insets.left),
                y: (scene.viewBottom + margin + scene.insets.bottom)
            )
            
            if component.baseNode.parent == nil {
                scene.addChild(component.baseNode)
            }
                
            if component.stickNode.parent != component.baseNode {
                component.stickNode.removeFromParent()
                component.baseNode.addChild(component.stickNode)
                component.stickNode.position = .zero
            }
                
            if !component.isActive {
                component.stickNode.position = .zero
            }
        }
    }
    
    func startTracking(with touch: UITouch, location: CGPoint) {
        let sceneLocation = touch.location(in: scene)
        
        for component in components {
            if component.baseNode.contains(sceneLocation) {
                component.currentTouch = touch
                component.isActive = true
                updateStickPosition(for: component, location: sceneLocation)
                break
            }
        }
    }
    
    func updateTracking(with touch: UITouch, location: CGPoint) {
        let sceneLocation = touch.location(in: scene)
        
        for component in components {
            if touch == component.currentTouch {
                updateStickPosition(for: component, location: sceneLocation)
                break
            }
        }
    }
    
    func endTracking() {
        for component in components {
            if component.isActive {
                component.currentTouch = nil
                component.isActive = false
                resetStick(for: component)
            }
        }
    }
    
    private func updateStickPosition(for component: JoystickComponent, location: CGPoint) {
        let localTouchPos = component.baseNode.convert(location, from: scene)
        
        let vector = CGVector(dx: localTouchPos.x,
                             dy: localTouchPos.y)
        
        let distance = hypot(vector.dx, vector.dy)
        let maxDistance: CGFloat = 50
        
        let limitedDistance = min(distance, maxDistance)
        
        let normalizedVector = distance > 0 ?
            CGVector(dx: vector.dx/distance, dy: vector.dy/distance) :
            .zero
        
        component.stickNode.position = CGPoint(
            x: normalizedVector.dx * limitedDistance,
            y: normalizedVector.dy * limitedDistance
        )
        
        component.direction = CGVector(
            dx: normalizedVector.dx * (limitedDistance/maxDistance),
            dy: normalizedVector.dy * (limitedDistance/maxDistance)
        )
    }
    
    private func resetStick(for component: JoystickComponent) {
        let resetAction = SKAction.move(to: CGPoint(x: 0.0, y: 0.0), duration: 0.2)
        resetAction.timingMode = .easeOut
        component.stickNode.run(resetAction)
        component.direction = .zero
    }
}
