//
//  RoomClass.swift
//  iLabyrinth
//
//  Created by TONY on 02/08/2018.
//  Copyright © 2018 TONY COMPANY. All rights reserved.
//

import Foundation

class Room {
    
    var x: Int
    var y: Int
    var directions: [Directions]
    var inventory: [Inventory]
    var isDark: Bool
    
    init(x: Int, y: Int, labyrinth: Labyrinth) {
        self.x = x
        self.y = y
        self.directions = []
        self.inventory = []
        self.isDark = arc4random_uniform(2) == 0 ? false : true
    }
    
    func isDarkNow(player: Player) -> Bool {
        if !self.isDark {
            return false
        } else {
            if isObjectHaveLigth(self.inventory) || isObjectHaveLigth(player.inventory) {
                return false
            } else {
                return true
            }
        }
    }
    
    func playerGet(_ item: Inventory) {
        var i = 0
        for invent in self.inventory {
            if invent == item {
                self.inventory.remove(at: i)
            }
            i += 1
        }
    }
    
    func playerDrop(_ item: Inventory) {
        self.inventory.append(item)
    }
    
    func isThere(direction: Directions) -> Bool {
        for dir in self.directions {
            if dir == direction {
                return true
            }
        }
        
        return false
    }
    
    func Is(itemHere: Inventory) -> Bool {
        for item in self.inventory {
            if item == itemHere {
                return true
            }
        }
        
        return false
    }
    
    func countOf(_ inventory: Inventory) -> Int {
        var count = 0
        
        for item in self.inventory {
            if item == inventory {
                count += 1
            }
        }
        
        return count
    }
    
    func isTrap() -> Bool {
        if self.directions.count < 1 {
            return true
        } else {
            return false
        }
    }
}
