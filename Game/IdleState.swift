//
//  IdleState.swift
//  Game
//
//  Created by Ruben Christian Buhl on 20.09.17.
//  Copyright © 2017 Ruben Christian Buhl. All rights reserved.
//

import UIKit
import GameplayKit

class IdleState: GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        let isValidNextState: Bool

        switch stateClass {
            case is RunningState.Type, is JumpingState.Type, is FallingState.Type:
                isValidNextState = true
            default:
                isValidNextState = false
        }

        return isValidNextState
    }
}
