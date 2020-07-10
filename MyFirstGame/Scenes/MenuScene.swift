//
//  MenuScene.swift
//  MyFirstGame
//
//  Created by Vinicius Mesquita on 05/07/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    let playButton: SpriteButton
    
    override init(size: CGSize) {
         playButton = SpriteButton(imageNamed: "button")
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        
        backgroundColor = .myColor
        
        setup()
        buildNodeHierarchy()
    }
    
    
    func setup() {
        
        playButton.position = CGPoint(x: size.width/2, y: size.height/2)
        
        playButton.setAction {
            let transition = SKTransition.moveIn(with: .up, duration: 1.0)
            ACTManager.shared.transition(self, toScene: .GamePlay, transition: transition)
        }
        
    }
    
    func buildNodeHierarchy() {
        addChild(playButton)
    }
}
