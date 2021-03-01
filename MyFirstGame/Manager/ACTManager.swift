//
//  ACTManager.swift
//  MyFirstGame
//
//  Created by Vinicius Mesquita on 05/07/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import SpriteKit

class ACTManager {
    
    static let shared = ACTManager()
    private init() {}
    
    enum SceneType: Int {
        case MainMenu = 0, GamePlay
    }
    
    public func launch() {
        firstLaunch()
    }
    
    private func firstLaunch() {
        if !UserDefaults.standard.bool(forKey: "isFirstLaunch") {
            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
            UserDefaults.standard.synchronize()
        }
    }
    
    func transition(_ fromScene: SKScene, toScene: SceneType, transition: SKTransition? = nil) {
        guard let scene = getScene(toScene) else { return }
        
        if let transition = transition {
            scene.scaleMode = .resizeFill
            fromScene.view?.presentScene(scene, transition: transition)
        } else {
            scene.scaleMode = .resizeFill
            fromScene.view?.presentScene(scene)
        }
    }
    
    
    func getScene(_ sceneType: SceneType) -> SKScene? {
        
        switch sceneType {
        case .MainMenu:
            return MenuScene(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        case .GamePlay:
            return GameScene(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        }
        
    }
}


