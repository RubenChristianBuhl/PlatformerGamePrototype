//
//  Button.swift
//  Game
//
//  Created by Ruben Christian Buhl on 17.09.17.
//  Copyright © 2017 Ruben Christian Buhl. All rights reserved.
//

import UIKit
import GameplayKit

class Button: GKEntity {
    let rootNode: SKNode

    let graphicComponent: GraphicComponent
    let inputComponent: InputComponent

    init(label: String, position: CGPoint) {
        let graphicNode = SKLabelNode(text: label)

        graphicComponent = GraphicComponent(graphicNode: graphicNode, position: position)
        inputComponent = InputComponent()

        rootNode = inputComponent.inputNode

        inputComponent.inputNode.addChild(graphicComponent.graphicNode)

        super.init()

        addComponent(graphicComponent)
        addComponent(inputComponent)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
