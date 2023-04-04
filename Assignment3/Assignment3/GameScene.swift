//
//  GameScene.swift
//  Assignment3
//
//  Created by  on 2022-11-19.
//

import SpriteKit

struct PhysicsCategory {
    static let None : UInt32 = 0
    static let All : UInt32 = UInt32.max
    static let Rocks : UInt32 = 0b1
    static let TheRocks : UInt32 = 0b10
    static let Ship : UInt32 = 0b11
    static let Projectile : UInt32 = 0b100
    
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var background = SKSpriteNode(imageNamed: "stars")
    var sportNode : SKSpriteNode?
    
    var score : Int?
    var stillCount : Bool?
    var saveScore : Int?
    let scoreIncrement = 1
    var lblScore = SKLabelNode()
    var lblGameOver = SKLabelNode()
    var counter = 0

    func initLabel(){
        lblScore.name = "lblScore"
        lblScore.text = "Score: "
        lblScore.fontSize = 36
        lblScore.fontColor = .white
        lblScore.position = CGPoint(x: 375, y:900)
        lblScore.zPosition = 11
        addChild(lblScore)
        
        lblGameOver.name = "lblGameOver"
        lblGameOver.text = "GAME OVER!"
        lblGameOver.fontSize = 52
        lblGameOver.fontColor = .red
        lblGameOver.position = CGPoint(x: 375, y:600)
        lblGameOver.zPosition = 11
        addChild(lblGameOver)
    }
    
    override func didMove(to view: SKView) {
        
        initLabel()
        background.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        background.alpha = 1.0
        addChild(background)
        
        sportNode = SKSpriteNode(imageNamed: "ship")
        sportNode?.size = CGSize(width:75, height:75)
        sportNode?.position = CGPoint(x:350, y:250)
        addChild(sportNode!)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        sportNode?.physicsBody = SKPhysicsBody(circleOfRadius: (sportNode?.size.width)! / 2)
        sportNode?.physicsBody?.isDynamic = true
        sportNode?.physicsBody?.categoryBitMask = PhysicsCategory.Ship
        sportNode?.physicsBody?.contactTestBitMask = PhysicsCategory.Rocks
        sportNode?.physicsBody?.contactTestBitMask = PhysicsCategory.TheRocks
        sportNode?.physicsBody?.collisionBitMask = PhysicsCategory.None
        sportNode?.physicsBody?.usesPreciseCollisionDetection = true
        let xConstraint = SKConstraint.positionY(SKRange(constantValue: 250))
        sportNode?.constraints = [xConstraint]
        
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addRocks), SKAction.wait(forDuration: 1)])))
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addTheRocks), SKAction.wait(forDuration: 5)])))
        
        
        score = 0
        lblScore.text = "Score: \(score!)"
        
        lblScore.alpha = 0.0
        lblScore.run(SKAction.fadeIn(withDuration: 2.0))
        
        lblGameOver.zPosition = 0
        stillCount = true
        
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min:CGFloat, max:CGFloat) -> CGFloat {
        return random() * (max-min) + min
    }
    
    func addRocks() {
        let rock = SKSpriteNode(imageNamed: "rock")
        rock.size = CGSize(width:75, height:75)
        
        let actualX = random(min: rock.size.height/2, max: size.height-rock.size.height/2)
        rock.position = CGPoint(x: actualX, y: size.height+rock.size.height/2)
        
        addChild(rock)
        
        rock.physicsBody = SKPhysicsBody(circleOfRadius: (rock.size.width) / 2)
        rock.physicsBody?.isDynamic = true
        rock.physicsBody?.categoryBitMask = PhysicsCategory.TheRocks
        rock.physicsBody?.contactTestBitMask = PhysicsCategory.Ship
        rock.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile
        rock.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        
        let actualDuration = random(min: CGFloat(3.0), max: CGFloat(5.0))
        
        let actionMove = SKAction.move(to: CGPoint(x:actualX, y: -rock.size.height/2), duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        
        rock.run(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
    
    func addTheRocks() {
        let theRock = SKSpriteNode(imageNamed: "therock")
        theRock.size = CGSize(width:75, height:75)
        
        let actualX = random(min: theRock.size.height/2, max: size.height-theRock.size.height/2)
        theRock.position = CGPoint(x: actualX, y: size.height+theRock.size.height/2)
        
        addChild(theRock)
        
        theRock.physicsBody = SKPhysicsBody(circleOfRadius: (theRock.size.width) / 2)
        theRock.physicsBody?.isDynamic = true
        theRock.physicsBody?.categoryBitMask = PhysicsCategory.TheRocks
        theRock.physicsBody?.contactTestBitMask = PhysicsCategory.Ship
        theRock.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile
        theRock.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        
        let actualDuration = random(min: CGFloat(1.0), max: CGFloat(3.0))
        
        let actionMove = SKAction.move(to: CGPoint(x:actualX, y: -theRock.size.height/2), duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        
        theRock.run(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
    
    func addProjectile(){
        let projectile = SKSpriteNode(imageNamed: "rock")
        projectile.size = CGSize(width:20, height:20)
        projectile.position = CGPoint(x: (sportNode?.position.x)!, y: (sportNode?.position.y)!+20)
        
        addChild(projectile)
        
        projectile.physicsBody = SKPhysicsBody(circleOfRadius: (projectile.size.width) / 2)
        projectile.physicsBody?.isDynamic = true
        projectile.physicsBody?.categoryBitMask = PhysicsCategory.Projectile
        projectile.physicsBody?.contactTestBitMask = PhysicsCategory.Rocks
        projectile.physicsBody?.contactTestBitMask = PhysicsCategory.TheRocks
        projectile.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        let actionMove = SKAction.move(to: CGPoint(x:(sportNode?.position.x)!, y: 1000), duration: TimeInterval(1.0))
        let actionMoveDone = SKAction.removeFromParent()
        
        projectile.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    func moveShip(pos : CGPoint){
        
        let actionMove = SKAction.move(to: pos, duration: TimeInterval(0.5))
        let actionMoveDone = SKAction.sequence([SKAction.run(addProjectile), SKAction.wait(forDuration: 1)])
        
        sportNode?.run(SKAction.sequence([actionMove, actionMoveDone]))
        
        
 
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let pos : CGPoint = (touches.first?.location(in: self))!
        moveShip(pos: pos)
        
        
    }
    
    func shipDidCollideWithRocks(ship: SKSpriteNode, rock: SKSpriteNode){

        ship.removeFromParent()
        rock.removeFromParent()
        stillCount = false
        saveScore = score
        lblGameOver.zPosition = 11
        lblScore.text = "Score: \(saveScore!)"
        
    }
    
    func shipDidCollideWithTheRocks(ship: SKSpriteNode, rock: SKSpriteNode){

        ship.removeFromParent()
        rock.removeFromParent()
        stillCount = false
        saveScore = score
        lblGameOver.zPosition = 11
        lblScore.text = "Score: \(saveScore!)"
    }
    
    func projectileCollideWithRocks(projectile: SKSpriteNode, rock: SKSpriteNode){
        
        score = score! + 3
        lblScore.text = "Score: \(score!)"
        
        lblScore.alpha = 0.0
        lblScore.run(SKAction.fadeIn(withDuration: 1.0))

    }
    
    func projectileCollideWithTheRocks(projectile: SKSpriteNode, theRock: SKSpriteNode){

        score = score! + 5
        lblScore.text = "Score: \(score!)"
        
        lblScore.alpha = 0.0
        lblScore.run(SKAction.fadeIn(withDuration: 1.0))

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }

        
        if((firstBody.categoryBitMask & PhysicsCategory.TheRocks != 0) && (secondBody.categoryBitMask & PhysicsCategory.Ship != 0)){
            shipDidCollideWithTheRocks(ship: firstBody.node as! SKSpriteNode, rock: secondBody.node as! SKSpriteNode)
        }
        
        if((firstBody.categoryBitMask & PhysicsCategory.Rocks != 0) && (secondBody.categoryBitMask & PhysicsCategory.Ship != 0)){
            shipDidCollideWithRocks(ship: firstBody.node as! SKSpriteNode, rock: secondBody.node as! SKSpriteNode)
        }
        
        if((firstBody.categoryBitMask & PhysicsCategory.TheRocks != 0) && (secondBody.categoryBitMask & PhysicsCategory.Projectile != 0)){
            projectileCollideWithRocks(projectile: firstBody.node as! SKSpriteNode, rock: secondBody.node as! SKSpriteNode)
        }
        
        if((firstBody.categoryBitMask & PhysicsCategory.Rocks != 0) && (secondBody.categoryBitMask & PhysicsCategory.Projectile != 0)){
            projectileCollideWithRocks(projectile: firstBody.node as! SKSpriteNode, rock: secondBody.node as! SKSpriteNode)
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if counter >= 60 && stillCount == true{
            score = score! + scoreIncrement
            lblScore.text = "Score: \(score!)"
            
            lblScore.alpha = 0.0
            lblScore.run(SKAction.fadeIn(withDuration: 1.0))
            
            counter = 0
        } else {
            counter += 1
        }
    }

}
