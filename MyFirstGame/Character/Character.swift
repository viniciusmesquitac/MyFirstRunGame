//
//  WoodCutter.swift
//  MyFirstGame
//
//  Created by Vinicius Mesquita on 02/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation
import SpriteKit

enum Direction {
       case left
       case right
   }

enum PlayerActions: String {
    case run = "Run", attack = "Attack", idle = "Idle", move = "Move"
}

protocol Character {
    
    var velocity: Double { get set }
    var characterSize: CGSize { get set }
    var characterTexture: SKTexture? { get set }
    var movingTo: Direction? { get set }
    var characterxScale: Double { get set }
    
    
    func run(direction: Direction)
    func move()
    func attack(repeatForever: Bool)
    func idle()
    func jump()
    func changePosition(sprite: SKSpriteNode, direction: Direction) -> CGPoint
    
}
