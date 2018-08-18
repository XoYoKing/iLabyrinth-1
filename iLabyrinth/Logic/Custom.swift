//
//  Custom.swift
//  iLabyrinth
//
//  Created by TONY on 02/08/2018.
//  Copyright © 2018 TONY COMPANY. All rights reserved.
//

import Foundation

enum Levels {
    case easy
    case medium
    case hard
    case impossible
}

enum Directions {
    case north
    case west
    case east
    case south
}

enum Inventory {
    case key
    case torch
    case apple
    case chest
}

func getXY(from direction: Directions, x: Int, y: Int) -> [Int] {
    switch direction {
    case .north: return [x + 1, y]
    case .east: return [x, y + 1]
    case .west: return [x, y - 1]
    case .south: return [x - 1, y]
    }
}

func isObjectHaveLigth(_ inventory: [Inventory]) -> Bool {
    for inv in inventory {
        if inv == Inventory.torch {
            return true
        }
    }
    
    return false
}
