//
//  Enemy.swift
//  Game
//
//  Created by Ruben Christian Buhl on 24.09.17.
//  Copyright © 2017 Ruben Christian Buhl. All rights reserved.
//

import UIKit
import GameplayKit

class Enemy: GKEntity, GKAgentDelegate {
    var rootNode: SKNode

    let graphicComponent: GraphicComponent

    let agent = GKAgent2D()

    init(position: CGPoint, radius: CGFloat, color: UIColor) {
        let graphicNode = SKShapeNode(circleOfRadius: radius)

        graphicNode.fillColor = color
        graphicNode.lineWidth = 0

        graphicComponent = GraphicComponent(graphicNode: graphicNode, position: position)

        rootNode = graphicComponent.graphicNode

        super.init()

        agent.delegate = self

        agent.position = float2(Float(graphicComponent.graphicNode.position.x), Float(graphicComponent.graphicNode.position.y))

        agent.radius = Float(radius)

        agent.maxSpeed = 100
        agent.maxAcceleration = 100

        addComponent(graphicComponent)
        addComponent(agent)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func agentDidUpdate(_ agent: GKAgent) {
        if let agent = agent as? GKAgent2D {
            rootNode.position = CGPoint(x: CGFloat(agent.position.x), y: CGFloat(agent.position.y))
        }
    }
}
