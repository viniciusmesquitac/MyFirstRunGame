//
//  SpriteButton.swift
//  MyFirstGame
//
//  Created by Vinicius Mesquita on 06/07/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import SpriteKit

class SpriteButton: SKNode {
    
    var button: SKSpriteNode
    
    var mask: SKSpriteNode
    
    var cropNode: SKCropNode
    
    private var action = { () -> Void in return }
    
    var isEnable: Bool = true
    
    init(imageNamed: String) {
//        button = SKSpriteNode(imageNamed: imageNamed)
        button = SKSpriteNode(color: .blue, size: CGSize(width: 100.0, height: 40.0))
        self.button.color = .blue
        self.mask = SKSpriteNode(color: .black, size: button.size)
        mask.alpha = 0.0
        cropNode = SKCropNode()
        cropNode.maskNode = button
        cropNode.zPosition = 3
        cropNode.addChild(mask)
        super.init()
        
        isUserInteractionEnabled = true
        
        button.zPosition = 0
        addChild(button)
        addChild(cropNode)
        
    }
    
    
    func setAction(action: @escaping () -> Void) {
        self.action = action
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnable {
            for touch in touches {
                let location = touch.location(in: self)
                
                if button.contains(location) {
                    disable()
                    action()
                    run(SKAction.sequence([SKAction.wait(forDuration: 0.1), SKAction.run({
                        self.enable()
                    })]))
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnable {
            for touch in touches {
                let location: CGPoint = touch.location(in: self)
                
                if button.contains(location) {
                    mask.alpha = 0.5
                } else {
                    mask.alpha = 0.0
                }
            }
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func enable() {
        isEnable = true
        mask.alpha = 0.0
        button.alpha = 1.0
    }
    
    func disable() {
        isEnable = false
        mask.alpha = 0.0
        button.alpha = 0.5
    }
}

