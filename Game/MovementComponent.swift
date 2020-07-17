//
//  MovementComponent.swift
//  Game
//
//  Created by Ruben Christian Buhl on 18.09.17.
//  Copyright © 2017 Ruben Christian Buhl. All rights reserved.
//

import UIKit
import GameplayKit

class MovementComponent: GKComponent {
    let physicsBody: SKPhysicsBody

    init(physicsBody: SKPhysicsBody) {
        self.physicsBody = physicsBody

        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func moveRight() {
        physicsBody.velocity.dx = 500
    }

    func moveLeft() {
        physicsBody.velocity.dx = -500
    }

    func jump() {
        physicsBody.applyImpulse(CGVector(dx: 0, dy: 500))
    }

    func drop() {
        physicsBody.applyImpulse(CGVector(dx: 0, dy: -500))
    }

    func stop() {
        physicsBody.velocity.dx = 0
    }
}
