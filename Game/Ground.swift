//
//  Ground.swift
//  Game
//
//  Created by Ruben Christian Buhl on 19.09.17.
//  Copyright © 2017 Ruben Christian Buhl. All rights reserved.
//

import UIKit
import GameplayKit

class Ground: GKEntity {
    let rootNode: SKNode

    let graphicComponent: GraphicComponent
    let physicsComponent: PhysicsComponent

    init(position: CGPoint, size: CGSize, color: UIColor) {
        let graphicNode = SKShapeNode(rectOf: size)

        graphicNode.fillColor = color
        graphicNode.lineWidth = 0

        graphicComponent = GraphicComponent(graphicNode: graphicNode, position: position)

        let physicsBody = SKPhysicsBody(rectangleOf: size)

        physicsBody.isDynamic = false

        physicsComponent = PhysicsComponent(physicsBody: physicsBody, backgroundPhysicsBody: nil)

        graphicComponent.graphicNode.physicsBody = physicsComponent.physicsBody

        rootNode = graphicComponent.graphicNode

        super.init()

        addComponent(graphicComponent)
        addComponent(physicsComponent)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
