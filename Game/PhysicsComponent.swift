//
//  PhysicsComponent.swift
//  Game
//
//  Created by Ruben Christian Buhl on 18.09.17.
//  Copyright © 2017 Ruben Christian Buhl. All rights reserved.
//

import UIKit
import GameplayKit

class PhysicsComponent: GKComponent {
    let physicsBody: SKPhysicsBody
    let backgroundPhysicsBody: SKPhysicsBody?

    let stateMachine = GKStateMachine(states: [IdleState(), RunningState(), JumpingState(), FallingState()])

    init(physicsBody: SKPhysicsBody, backgroundPhysicsBody: SKPhysicsBody?) {
        self.physicsBody = physicsBody
        self.backgroundPhysicsBody = backgroundPhysicsBody

//        self.physicsBody.usesPreciseCollisionDetection = true
        self.physicsBody.allowsRotation = false
        self.physicsBody.restitution = 0
        self.physicsBody.friction = 0
        self.physicsBody.categoryBitMask = 1
        self.physicsBody.collisionBitMask = 1
        self.physicsBody.contactTestBitMask = 1

        super.init()

        stateMachine.enter(IdleState.self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        if physicsBody.velocity.dy.rounded() > 0 {
            stateMachine.enter(JumpingState.self)
        } else if physicsBody.velocity.dy.rounded() < 0 {
            stateMachine.enter(FallingState.self)
        } else if physicsBody.velocity.dx.rounded() != 0 {
            stateMachine.enter(RunningState.self)
        } else {
            stateMachine.enter(IdleState.self)
        }

        stateMachine.update(deltaTime: seconds)
    }

    func hasGroundRight() -> Bool {
        var hasGroundRight = false

        if let node = physicsBody.node {
            var nodePosition = node.position
            var nodeSize = node.frame.size

            var contactedBodies = physicsBody.allContactedBodies()

            if let backgroundPhysicsBody = backgroundPhysicsBody, let backgroundNode = backgroundPhysicsBody.node, let scene = node.scene {
                nodePosition = node.convert(backgroundNode.position, to: scene)
                nodeSize = backgroundNode.frame.size

                contactedBodies = backgroundPhysicsBody.allContactedBodies()
            }

            for contactedBody in contactedBodies {
                if let contactedBodyNode = contactedBody.node {
                    if nodePosition.y - (nodeSize.height / 2) > contactedBodyNode.position.y && nodePosition.x + (nodeSize.width / 2) - 10 < contactedBodyNode.position.x + (contactedBodyNode.frame.size.width / 2) {
                        hasGroundRight = true
                    }
                }
            }
        }

        return hasGroundRight
    }

    func hasGroundLeft() -> Bool {
        var hasGroundLeft = false

        if let node = physicsBody.node {
            var nodePosition = node.position
            var nodeSize = node.frame.size

            var contactedBodies = physicsBody.allContactedBodies()

            if let backgroundPhysicsBody = backgroundPhysicsBody, let backgroundNode = backgroundPhysicsBody.node, let scene = node.scene {
                nodePosition = node.convert(backgroundNode.position, to: scene)
                nodeSize = backgroundNode.frame.size

                contactedBodies = backgroundPhysicsBody.allContactedBodies()
            }

            for contactedBody in contactedBodies {
                if let contactedBodyNode = contactedBody.node {
                    if nodePosition.y - (nodeSize.height / 2) > contactedBodyNode.position.y && nodePosition.x - (nodeSize.width / 2) + 10 > contactedBodyNode.position.x - (contactedBodyNode.frame.size.width / 2) {
                        hasGroundLeft = true
                    }
                }
            }
        }

        return hasGroundLeft
    }
}
