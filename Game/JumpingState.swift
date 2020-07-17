//
//  JumpingState.swift
//  Game
//
//  Created by Ruben Christian Buhl on 19.09.17.
//  Copyright © 2017 Ruben Christian Buhl. All rights reserved.
//

import UIKit
import GameplayKit

class JumpingState: GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        let isValidNextState: Bool

        switch stateClass {
            case is IdleState.Type, is RunningState.Type , is FallingState.Type:
                isValidNextState = true
            default:
                isValidNextState = false
        }

        return isValidNextState
    }
}
