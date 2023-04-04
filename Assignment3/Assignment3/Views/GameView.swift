//
//  GameView.swift
//  Assignment3
//
//  Created by  on 2022-11-17.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    
    var scene : SKScene{
        let scene = GameScene()
        scene.size = CGSize(width: 750, height: 1000)
        scene.scaleMode = .aspectFill
        scene.anchorPoint = CGPoint(x:0, y: 0)
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .frame(width: 750, height: 1000)
            .ignoresSafeArea()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
