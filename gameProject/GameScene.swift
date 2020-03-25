//
//  GameScene.swift
//  gameProject
//
//  Created by Camosun Mac on 2020-03-25.
//  Copyright © 2020 Camosun Mac. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var sprite : SKSpriteNode!
    let spriteCategory1 : UInt32 = 0b1
    let spriteCategory2 : UInt32 = 0b10
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView){
        sprite = SKSpriteNode(imageNamed: "GameSprite")
        sprite.position = CGPoint(x: size.width / 2,y: size.height / 2)
        addChild(sprite)
        
        let opponentSprite = SKSpriteNode(imageNamed: "OpponentSprite")
        opponentSprite.position = CGPoint(x: size.width / 2, y: size.height)
        addChild(opponentSprite)
        
        let downMovement = SKAction.move(to: CGPoint(x: size.width / 2, y: 0), duration: 2)
        let upMovement = SKAction.move(to: CGPoint(x: size.width / 2, y: size.height), duration: 2)
        let movement = SKAction.sequence([downMovement, upMovement])
        opponentSprite.run(SKAction.repeatForever(movement))
        
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        opponentSprite.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        sprite.physicsBody?.categoryBitMask = spriteCategory1
        sprite.physicsBody?.contactTestBitMask = spriteCategory1
        sprite.physicsBody?.collisionBitMask = spriteCategory1
        opponentSprite.physicsBody?.categoryBitMask = spriteCategory1
        opponentSprite.physicsBody?.contactTestBitMask = spriteCategory1
        opponentSprite.physicsBody?.collisionBitMask = spriteCategory1
        
        self.physicsWorld.contactDelegate = self
    }
    
    func touchDown(atPoint pos : CGPoint) {
        sprite.run(SKAction.move(to: pos, duration:1))
    }
    func touchMoved(toPoint pos : CGPoint){
    }
    func touchUp(atPoint pos : CGPoint){
        sprite.run(SKAction.move(to: pos, duration: 1))
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?){
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
}
