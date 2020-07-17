//
//  Player.swift
//  Game
//
//  Created by Ruben Christian Buhl on 18.09.17.
//  Copyright © 2017 Ruben Christian Buhl. All rights reserved.
//

import UIKit
import GameplayKit

class Player: GKEntity {
    let rootNode: SKNode

    let graphicComponent: GraphicComponent
    let physicsComponent: PhysicsComponent
    let movementComponent: MovementComponent

    let agent = GKAgent2D()

    init(position: CGPoint, color: UIColor) {
//        let graphicNode = SKShapeNode(rectOf: CGSize(width: 100, height: 100))
        let graphicNode = SKShapeNode(circleOfRadius: 50)

        graphicNode.fillColor = color
        graphicNode.lineWidth = 0

        let backgroundGraphicNode = SKShapeNode(rectOf: CGSize(width: 110, height: 110))

        backgroundGraphicNode.fillColor = .white
        backgroundGraphicNode.alpha = 0.25
        backgroundGraphicNode.lineWidth = 0

        graphicComponent = GraphicComponent(graphicNode: graphicNode, position: position)

//        let physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 100))
        let physicsBody = SKPhysicsBody(circleOfRadius: 50)

        let backgroundPhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 110, height: 110))

        backgroundPhysicsBody.mass = 0.01
        backgroundPhysicsBody.categoryBitMask = 2
        backgroundPhysicsBody.collisionBitMask = 0
        backgroundPhysicsBody.contactTestBitMask = 1

        backgroundGraphicNode.physicsBody = backgroundPhysicsBody

        graphicNode.addChild(backgroundGraphicNode)

        physicsComponent = PhysicsComponent(physicsBody: physicsBody, backgroundPhysicsBody: backgroundPhysicsBody)

        movementComponent = MovementComponent(physicsBody: physicsComponent.physicsBody)

        graphicComponent.graphicNode.physicsBody = physicsComponent.physicsBody

        rootNode = graphicComponent.graphicNode

        super.init()

        agent.radius = 50

        addComponent(graphicComponent)
        addComponent(physicsComponent)
        addComponent(movementComponent)
        addComponent(agent)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)

        switch physicsComponent.stateMachine.currentState {
            case is RunningState:
                graphicComponent.setFillColor(color: .green)
            case is JumpingState:
                graphicComponent.setFillColor(color: .blue)
            case is FallingState:
                graphicComponent.setFillColor(color: .yellow)
            default:
                graphicComponent.setFillColor(color: .red)
        }

        agent.position = float2(Float(rootNode.position.x), Float(rootNode.position.y))
    }

    func addBackgroundPhysicsBody(physicsWorld: SKPhysicsWorld) {
        if let bodyA = rootNode.physicsBody, let bodyB = rootNode.children[0].physicsBody {
            let physicsJointFixed = SKPhysicsJointFixed.joint(withBodyA: bodyA, bodyB: bodyB, anchor: rootNode.position)

            physicsWorld.add(physicsJointFixed)
        }
    }
}
