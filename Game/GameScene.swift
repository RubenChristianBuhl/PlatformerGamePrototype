//
//  GameScene.swift
//  Game
//
//  Created by Ruben Christian Buhl on 14.09.17.
//  Copyright © 2017 Ruben Christian Buhl. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var lastUpdateTime : TimeInterval = 0

    private let ground1 = Ground(position: CGPoint(x: 300, y: 125), size: CGSize(width: 600, height: 50), color: .green)
    private let ground2 = Ground(position: CGPoint(x: 1000, y: 225), size: CGSize(width: 400, height: 50), color: .green)
    private let ground3 = Ground(position: CGPoint(x: 1300, y: 225), size: CGSize(width: 200, height: 50), color: .gray)
    private let ground4 = Ground(position: CGPoint(x: 1425, y: 225), size: CGSize(width: 50, height: 50), color: .green)
    private let ground5 = Ground(position: CGPoint(x: 1475, y: 225), size: CGSize(width: 50, height: 50), color: .gray)
    private let ground6 = Ground(position: CGPoint(x: 1525, y: 225), size: CGSize(width: 50, height: 50), color: .green)
    private let ground7 = Ground(position: CGPoint(x: 1575, y: 225), size: CGSize(width: 50, height: 50), color: .gray)

    private let player1 = Player(position: CGPoint(x: 250, y: 850), color: .red)
    private let player2 = Player(position: CGPoint(x: 200, y: 350), color: .blue)
    private let player3 = Player(position: CGPoint(x: 300, y: 1050), color: .yellow)
    private let player4 = Player(position: CGPoint(x: 1200, y: 400), color: .white)

    private let enemy1 = Enemy(position: CGPoint(x: 1000, y: 1000), radius: 50, color: .white)

    private var selectedPlayer: Player?

//    private let leftButton = Button(label: "left", position: CGPoint(x: 50 - 384, y: 50 - 512))
//    private let rightButton = Button(label: "right", position: CGPoint(x: 700 - 384, y: 50 - 512))
//    private let upButton = Button(label: "up", position: CGPoint(x: 300 - 384, y: 50 - 512))
//    private let downButton = Button(label: "down", position: CGPoint(x: 400 - 384, y: 50 - 512))
    private let leftButton = Button(label: "left", position: CGPoint(x: 50 - 334, y: 50 - 188))
    private let rightButton = Button(label: "right", position: CGPoint(x: 500 - 334, y: 50 - 188))
    private let upButton = Button(label: "up", position: CGPoint(x: 200 - 334, y: 50 - 188))
    private let downButton = Button(label: "down", position: CGPoint(x: 300 - 334, y: 50 - 188))

    private let cameraNode = SKCameraNode()

    private let contactDelegate = ContactDelegate()

    override func sceneDidLoad() {
        lastUpdateTime = 0

        self.camera = cameraNode

        upButton.inputComponent.inputNode.action = {
            self.selectedPlayer?.movementComponent.jump()
        }

        downButton.inputComponent.inputNode.action = {
            self.selectedPlayer?.movementComponent.drop()
        }

        player4.addComponent(RulesComponent(physicsComponent: player4.physicsComponent, movementComponent: player4.movementComponent))

        addChild(ground1.rootNode)
        addChild(ground2.rootNode)
        addChild(ground3.rootNode)
        addChild(ground4.rootNode)
        addChild(ground5.rootNode)
        addChild(ground6.rootNode)
        addChild(ground7.rootNode)

        addChild(player1.rootNode)
        addChild(player2.rootNode)
        addChild(player3.rootNode)
        addChild(player4.rootNode)

//        addChild(enemy1.rootNode)

        addChild(cameraNode)

        cameraNode.addChild(leftButton.rootNode)
        cameraNode.addChild(rightButton.rootNode)
        cameraNode.addChild(upButton.rootNode)
        cameraNode.addChild(downButton.rootNode)

        player1.addBackgroundPhysicsBody(physicsWorld: physicsWorld)
        player2.addBackgroundPhysicsBody(physicsWorld: physicsWorld)
        player3.addBackgroundPhysicsBody(physicsWorld: physicsWorld)
        player4.addBackgroundPhysicsBody(physicsWorld: physicsWorld)

        physicsWorld.contactDelegate = contactDelegate

        let runningTextureAtlas = SKTextureAtlas(named: "Spielfigur_running")

        let runningTextureNamesSorted = runningTextureAtlas.textureNames.sorted { textureNameA, textureNameB in
            return textureNameA < textureNameB
        }

        let runningTextures = runningTextureNamesSorted.map { textureName in
            return runningTextureAtlas.textureNamed(textureName)
        }

        let runningAnimation = SKAction.animate(with: runningTextures, timePerFrame: 1 / Double(runningTextureAtlas.textureNames.count))

        enemy1.rootNode = SKSpriteNode(texture: runningTextures[0])

        enemy1.rootNode.run(SKAction.repeatForever(runningAnimation))

        addChild(enemy1.rootNode)
    }

    func touchDown(atPoint pos : CGPoint) {
        if let physicsBody = physicsWorld.body(at: pos) {
            for player in [player1, player2, player3, player4] {
                if physicsBody == player.physicsComponent.physicsBody {
                    selectedPlayer?.graphicComponent.unmark()

                    selectedPlayer = player

                    player.graphicComponent.mark()

                    enemy1.agent.behavior = GKBehavior(goals: [GKGoal(toSeekAgent: player.agent)])

                    cameraNode.constraints = [SKConstraint.distance(SKRange(lowerLimit: 0, upperLimit: 0), to: player.rootNode)]
                }
            }
        }
    }

    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        // Initialize _lastUpdateTime if it has not already been
        if lastUpdateTime == 0 {
            lastUpdateTime = currentTime
        }

        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime

        if leftButton.inputComponent.inputNode.touched {
            selectedPlayer?.movementComponent.moveLeft()
        } else if rightButton.inputComponent.inputNode.touched {
            selectedPlayer?.movementComponent.moveRight()
        } else {
            selectedPlayer?.movementComponent.stop()
        }

        for entity in [ground1, ground2, ground3, ground4, ground5, ground6, ground7, player1, player2, player3, player4, enemy1, leftButton, rightButton, upButton, downButton] {
            entity.update(deltaTime: dt)
        }

        lastUpdateTime = currentTime
    }
}
