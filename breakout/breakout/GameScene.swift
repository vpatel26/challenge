//
//  GameScene.swift
//  breakout
//
//  Created by A.M. Student on 11/7/19.
//  Copyright © 2019 A.M. Student. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene,SKPhysicsContactDelegate {
    var ball:SKSpriteNode!
    var paddle:SKSpriteNode!
    var score:Int = 0 {
        didSet {
            scorelabel.text = "\(score) Dead bugs"
        }
    }
    var scorelabel:SKLabelNode!
    var audioPlayer:AVAudioPlayer!
    var player:AVAudioPlayer = AVAudioPlayer()
    var player2:AVAudioPlayer = AVAudioPlayer()
    var player3:AVAudioPlayer = AVAudioPlayer()
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "Ball") as! SKSpriteNode
        paddle = self.childNode(withName: "Paddle") as! SKSpriteNode
        scorelabel = self.childNode(withName: "Score") as! SKLabelNode
        let urlpath = Bundle.main.url(forResource: "brick", withExtension: "wav")
        do {
            let AudioPath = Bundle.main.path(forResource: "bgMusic", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: AudioPath!) as URL)
            let AudioPath3 = Bundle.main.path(forResource: "Cleared", ofType: "mp3")
            try player3 = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: AudioPath3!) as URL)
            let AudioPath2 = Bundle.main.path(forResource: "Failed", ofType: "mp3")
            try player2 = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: AudioPath2!) as URL)
        } catch {
            print("Error!")
        }

        
        player.play()
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: urlpath!)
            audioPlayer.prepareToPlay()
        } catch {
            print("Error!")
        }
        ball.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 50))
        
        let border = SKPhysicsBody(edgeLoopFrom: (view.scene?.frame)!)
        border.friction = 0
        self.physicsBody = border
        
        self.physicsWorld.contactDelegate = self
    }
    
    
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchlocation = touch.location(in: self)
            paddle.position.x = touchlocation.x
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchlocation = touch.location(in: self)
            paddle.position.x = touchlocation.x
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyAName = contact.bodyA.node?.name
        let bodyBName = contact.bodyB.node?.name
        
        if bodyAName == "Ball" && bodyBName == "Brick" || bodyAName == "Brick" && bodyBName == "Ball"{
            if bodyAName == "Brick" {
                audioPlayer.play()
                contact.bodyA.node?.removeFromParent()
                score += 1
            } else if bodyBName == "Brick" {
                audioPlayer.play()
                contact.bodyB.node?.removeFromParent()
                score += 1
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if (score == 15) {scorelabel.text = "You Killed all the Ravengers"
            player.stop()
            player3.play()
            self.view?.isPaused = true
        
            
        }
        if (ball.position.y < paddle.position.y) { scorelabel.text = "Humanity was waiped out"
            player.stop()
            player2.play()
            scorelabel.text = "Humanity was waiped out"
            self.view?.isPaused = true


        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
 
}
