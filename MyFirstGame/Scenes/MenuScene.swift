//
//  MenuScene.swift
//  MyFirstGame
//
//  Created by Vinicius Mesquita on 05/07/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    lazy var playButton: SKSpriteNode = {
        let button = SKSpriteNode(texture: nil, color: .blue, size: CGSize(width: 100, height: 40))
        return button
    }()
    
    
    override func sceneDidLoad() {
        backgroundColor = .myColor
        setupNode()
        addNodes()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            if touch == touches.first {
                let transition = SKTransition.moveIn(with: .up, duration: 1.0)
                ACTManager.shared.transition(self, toScene: .GamePlay, transition: transition)
            }
            
        }
    }
    
    
    func setupNode() {
        playButton.position = CGPoint(x: size.width/2, y: size.height/2)

    }
    
    func addNodes() {
        addChild(playButton)
    }
}
