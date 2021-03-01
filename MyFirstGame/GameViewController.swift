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
    
    let skView: SKView = {
        let view = SKView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(skView)
        setupConstrains()
        
        
        let scene = MenuScene(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }
    
    
    func setupConstrains() {
        
        NSLayoutConstraint.activate([
            skView.topAnchor.constraint(equalTo: self.view.topAnchor),
            skView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            skView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            skView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
    }

}
