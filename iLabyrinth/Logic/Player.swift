//
//  PlayerClass.swift
//  iLabyrinth
//
//  Created by TONY on 02/08/2018.
//  Copyright © 2018 TONY COMPANY. All rights reserved.
//

import Foundation

class Player {
    
    private(set) var currentX: Int
    private(set) var currentY: Int
    private(set) var stepsHave: Int
    private(set) var inventory: [Inventory]
    
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
    
    func get(_ item: Inventory) {
        self.inventory.append(item)
    }
    
    func drop(_ item: Inventory) {
        var i = 0
        for invent in self.inventory {
            if invent == item {
                self.inventory.remove(at: i)
                return
            }
            i = i + 1
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
    
    private func getXY(from direction: Directions, x: Int, y: Int) -> [Int] {
        switch direction {
        case .north: return [x + 1, y]
        case .east: return [x, y + 1]
        case .west: return [x, y - 1]
        case .south: return [x - 1, y]
        }
    }
}
