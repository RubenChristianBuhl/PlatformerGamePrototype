//
//  InputNode.swift
//  Game
//
//  Created by Ruben Christian Buhl on 17.09.17.
//  Copyright © 2017 Ruben Christian Buhl. All rights reserved.
//

import UIKit
import GameplayKit

class InputNode: SKNode {
    var touched = false

    var action: (() -> Void)?

    override init() {
        super.init()

        isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touched = true

        action?()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let view = children[0]

            if touch.location(in: view).x <= -(view.frame.width / 2) || touch.location(in: view).x > view.frame.width / 2 || touch.location(in: view).y <= -(view.frame.height / 2) || touch.location(in: view).y > view.frame.height / 2 {
                touched = false
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touched = false
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touched = false
    }
}
