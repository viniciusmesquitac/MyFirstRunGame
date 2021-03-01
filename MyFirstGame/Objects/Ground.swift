//
//  Ground.swift
//  MyFirstGame
//
//  Created by Vinicius Mesquita on 08/07/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import SpriteKit

class Ground: SKSpriteNode {
    
    var groundTexture: SKTexture? = SKTexture(imageNamed: "ground")


    init(size: CGSize) {
        let groundSize = CGSize(width: size.width, height: 40)
        super.init(texture: groundTexture, color: .brown, size: groundSize)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Init
    func setup() {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false
    }
    
}
