//
//  GameScene.swift
//  Minesweeper Shared
//
//  Created by Ben Scheirman on 4/15/20.
//  Copyright © 2020 NSScreencast. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    var board: GameBoard!

    class func newGameScene() -> GameScene {
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }

        Resources.initialize()
        scene.scaleMode = .aspectFit
        
        return scene
    }
    
    func setUpScene() {
        board = GameBoard(size: 10)
        addChild(board.node)
        repositionBoard()
    }

    func repositionBoard() {
        guard board != nil else { return }
        let margin: CGFloat = 20
        let dimension = min(size.width, size.height) - 2*margin
        board.repositionBoard(to: CGSize(width: dimension, height: dimension))
    }

    override func didChangeSize(_ oldSize: CGSize) {
        repositionBoard()
    }
    
    override func didMove(to view: SKView) {
        self.setUpScene()
    }

    override func update(_ currentTime: TimeInterval) {
    }
}

#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
        }
    }
    
   
}
#endif

#if os(OSX)
// Mouse-based event handling
extension GameScene {

    override func mouseDown(with event: NSEvent) {
        var position = event.location(in: board.node)
        // TODO: WHY?!
        position.y += 8
        board.revealTile(at: position)
    }

    override func rightMouseDown(with event: NSEvent) {
        var position = event.location(in: board.node)
        // TODO: WHY?!
        position.y += 8
        board.toggleFlag(at: position)
    }
    
    override func mouseDragged(with event: NSEvent) {
    }
    
    override func mouseUp(with event: NSEvent) {
    }

}
#endif

