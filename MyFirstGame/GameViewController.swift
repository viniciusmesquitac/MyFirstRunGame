//
//  GameViewController.swift
//  MyFirstGame
//
//  Created by Vinicius Mesquita on 22/02/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene size'
            let scene = GameScene(size: view.bounds.size)
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
                
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

}
