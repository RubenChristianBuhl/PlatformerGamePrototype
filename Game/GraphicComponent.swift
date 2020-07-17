//
//  GraphicComponent.swift
//  Game
//
//  Created by Ruben Christian Buhl on 17.09.17.
//  Copyright © 2017 Ruben Christian Buhl. All rights reserved.
//

import UIKit
import GameplayKit

class GraphicComponent: GKComponent {
    let graphicNode: SKNode

    init(graphicNode: SKNode, position: CGPoint) {
        self.graphicNode = graphicNode
        self.graphicNode.position = position

        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func mark() {
        if let shapeNode = graphicNode as? SKShapeNode {
            shapeNode.strokeColor = .white
            shapeNode.lineWidth = 4
        }
    }

    func unmark() {
        if let shapeNode = graphicNode as? SKShapeNode {
            shapeNode.lineWidth = 0
        }
    }

    func setFillColor(color: UIColor) {
        if let shapeNode = graphicNode as? SKShapeNode {
            shapeNode.fillColor = color
        }
    }
}
