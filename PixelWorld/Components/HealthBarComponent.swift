//
//  HealthBarComponent.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 20.04.2025.
//
import GameplayKit
import SpriteKit

class HealthBarComponent: GKComponent {
    private(set) var backgroundNode: SKSpriteNode?//SKShapeNode?
    private(set) var foregroundNode: SKSpriteNode?//SKShapeNode?
    let style: HealthBarStyle
    
    init(style: HealthBarStyle = HealthBarStyle()) {
        self.style = style
        super.init()
    }
    
    func createNodes() -> (background: SKNode, foreground: SKNode) {
        // Создаём текстуры для нод
        let backgroundTexture = SKTexture(imageNamed: "healthBarEmpty")
        let foregroundTexture = SKTexture(imageNamed: "healthBarFull")
        
        let background = SKSpriteNode(texture: backgroundTexture, size: style.size)
        let foreground = SKSpriteNode(texture: foregroundTexture, size: style.size)
        
        // Настройка
        background.anchorPoint = CGPoint(x: 0, y: 0.5)
        foreground.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        background.zPosition = style.zPosition
        foreground.zPosition = style.zPosition + 1
        
        self.backgroundNode = background
        self.foregroundNode = foreground
        
        return (background, foreground)
    }
    
    override func willRemoveFromEntity() {
        backgroundNode?.removeFromParent()
        foregroundNode?.removeFromParent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct HealthBarStyle {
    let size: CGSize
    let offset: CGPoint
    let cornerRadius: CGFloat
    let backgroundColor: UIColor
    let foregroundColor: UIColor
    let borderColor: UIColor
    let zPosition: CGFloat
    
    init(size: CGSize = CGSize(width: 100, height: 8),
         offset: CGPoint = CGPoint(x: -50, y: 30),
         cornerRadius: CGFloat = 4,
         backgroundColor: UIColor = .darkGray,
         foregroundColor: UIColor = .green,
         borderColor: UIColor = .black,
         zPosition: CGFloat = 100) {
        
        self.size = size
        self.offset = offset
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.borderColor = borderColor
        self.zPosition = zPosition
    }
}
