//
//  Character.swift
//  MyFirstGame
//
//  Created by Vinicius Mesquita on 01/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation
import SpriteKit

struct Character {
    
    let woodCutter = SKSpriteNode(imageNamed: "woodCutter")

    init() {
        woodCutter.size = CGSize(width: 100.0, height: 100.0)
        woodCutter.name = "cutter"
        woodCutter.physicsBody = SKPhysicsBody(rectangleOf: woodCutter.size)
    }
    
}
