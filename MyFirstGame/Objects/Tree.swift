//
//  Tree.swift
//  MyFirstGame
//
//  Created by Vinicius Mesquita on 05/07/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import SpriteKit

class Tree: SKSpriteNode {
    
    var life = 5
    let myTexture = SKTexture()
    let initialSize = CGSize(width: 30.0, height: 100.0)
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: nil, color: .green, size: initialSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
