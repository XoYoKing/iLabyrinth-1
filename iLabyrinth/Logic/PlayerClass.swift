//
//  PlayerClass.swift
//  iLabyrinth
//
//  Created by TONY on 02/08/2018.
//  Copyright © 2018 TONY COMPANY. All rights reserved.
//

import Foundation

class Player {
    
    var currentX: Int
    var currentY: Int
    var stepsHave: Int
    var inventory: [Inventory]
    
    init() {
        self.currentX = 0
        self.currentY = 0
        self.inventory = []
        self.stepsHave = 1000
    }
    
    func go(to direction: Directions) {
        let newXY = getXY(from: direction, x: self.currentX, y: self.currentY)
        self.currentX = newXY[0]
        self.currentY = newXY[1]
        self.stepsHave -= 1
    }
    
    func get(item: Inventory) {
        self.inventory.append(item)
    }
    
    func drop(item: Inventory) {
        for invent in self.inventory {
            if invent == item {
                self.inventory.remove(at: invent.hashValue)
            }
        }
    }
    
    func eatApple() {
        self.stepsHave += 10
    }
    
    func Is(playerHaveItem: Inventory) -> Bool {
        for item in self.inventory {
            if item == playerHaveItem {
                return true
            }
        }
        
        return false
    }
}
