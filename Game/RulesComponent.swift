//
//  RulesComponent.swift
//  Game
//
//  Created by Ruben Christian Buhl on 01.10.17.
//  Copyright © 2017 Ruben Christian Buhl. All rights reserved.
//

import UIKit
import GameplayKit

enum MovementState {
    case moveLeft
    case moveRight
    case stop
}

class RulesComponent: GKComponent {
    let physicsComponent: PhysicsComponent
    let movementComponent: MovementComponent

    let ruleSystem: GKRuleSystem = GKRuleSystem()

    var movementState: MovementState = .moveLeft

    init(physicsComponent: PhysicsComponent, movementComponent: MovementComponent) {
        self.physicsComponent = physicsComponent
        self.movementComponent = movementComponent

        super.init()

        self.ruleSystem.add(GKRule(predicate: NSPredicate(format: "$hasGroundLeft == true"), assertingFact: "hasGroundLeft" as NSObjectProtocol, grade: 1))
        self.ruleSystem.add(GKRule(predicate: NSPredicate(format: "$hasGroundLeft == false"), retractingFact: "hasGroundLeft" as NSObjectProtocol, grade: 1))
        self.ruleSystem.add(GKRule(predicate: NSPredicate(format: "$hasGroundRight == true"), assertingFact: "hasGroundRight" as NSObjectProtocol, grade: 1))
        self.ruleSystem.add(GKRule(predicate: NSPredicate(format: "$hasGroundRight == false"), retractingFact: "hasGroundRight" as NSObjectProtocol, grade: 1))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        ruleSystem.state["hasGroundLeft"] = physicsComponent.hasGroundLeft()
        ruleSystem.state["hasGroundRight"] = physicsComponent.hasGroundRight()

        ruleSystem.reset()
        ruleSystem.evaluate()

        let hasGroundLeft = ruleSystem.grade(forFact: "hasGroundLeft" as NSObjectProtocol) > 0
        let hasGroundRight = ruleSystem.grade(forFact: "hasGroundRight" as NSObjectProtocol) > 0

        if movementState == .moveLeft {
            if !hasGroundLeft {
                movementState = .moveRight
            }
        }

        if movementState == .moveRight {
            if !hasGroundRight {
                movementState = .moveLeft
            }
        }

        if !hasGroundLeft && !hasGroundRight {
            movementState = .stop
        } else if movementState == .stop {
            if hasGroundLeft {
                movementState = .moveLeft
            } else if hasGroundRight {
                movementState = .moveRight
            }
        }

        switch movementState {
            case .moveLeft:
                movementComponent.moveLeft()
            case .moveRight:
                movementComponent.moveRight()
            case .stop:
                movementComponent.stop()
        }

//        print("hasGroundLeft: \(hasGroundLeft)    hasGroundRight: \(hasGroundRight)    movementState: \(movementState)")
    }
}
