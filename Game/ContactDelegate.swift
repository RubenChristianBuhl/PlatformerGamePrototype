//
//  ContactDelegate.swift
//  Game
//
//  Created by Ruben Christian Buhl on 20.09.17.
//  Copyright © 2017 Ruben Christian Buhl. All rights reserved.
//

import UIKit
import GameplayKit

class ContactDelegate: NSObject, SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
//        print("ContactDelegate didBegin    contactPoint x: \(contact.contactPoint.x.rounded())    y: \(contact.contactPoint.y.rounded())")
    }

    func didEnd(_ contact: SKPhysicsContact) {
//        print("ContactDelegate didEnd      contactPoint x: \(contact.contactPoint.x.rounded())    y: \(contact.contactPoint.y.rounded())")
    }
}
