//
//  labyrinthClass.swift
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

class Labyrinth {
    
    private var labySize: Int
    private(set) var labyrinthMatrix: [[Room]]
    
    init(level: Levels) {
        
        switch level {
        case .easy: self.labySize = 10
        case .medium: self.labySize = 15
        case .hard: self.labySize = 20
        case .impossible: self.labySize = 30
        }
        
        self.labyrinthMatrix = [[]]
        for i in 0..<self.labySize {
            for j in 0..<self.labySize {
                self.labyrinthMatrix[i].append(Room(x: i, y: j, labyrinth: self))
            }
            self.labyrinthMatrix.append([])
        }
        self.labyrinthMatrix.remove(at: self.labyrinthMatrix.endIndex - 1)
        
        initInventory()
        initDirections()
    }
    
    private func initInventory() {
        self.labyrinthMatrix[getRandom(min: 5, max: self.labySize)][getRandom(min: 5, max: self.labySize)].inventory.append(Inventory.key)
        self.labyrinthMatrix[getRandom(min: 5, max: self.labySize)][getRandom(min: 5, max: self.labySize)].inventory.append(Inventory.chest)
        
        for _ in 1...10 {
            self.labyrinthMatrix[getRandom(min: 5, max: self.labySize)][getRandom(min: 5, max: self.labySize)].inventory.append(Inventory.apple)
            self.labyrinthMatrix[getRandom(min: 5, max: self.labySize)][getRandom(min: 5, max: self.labySize)].inventory.append(Inventory.torch)
        }
    }
    
    private func initPerimeter(index: Int, way: Directions) {
        if way == .north {
            if index == 0 {
                for i in 1..<self.labySize - 1 {
                    self.labyrinthMatrix[i][index].directions.append(.north)
                    self.labyrinthMatrix[i][index].directions.append(.south)
                    self.labyrinthMatrix[i][index].directions.append(.east)
                }
            } else {
                for i in 1..<self.labySize - 1 {
                    self.labyrinthMatrix[i][index].directions.append(.north)
                    self.labyrinthMatrix[i][index].directions.append(.south)
                    self.labyrinthMatrix[i][index].directions.append(.west)
                    
                }
            }
        } else {
            if index == 0 {
                for i in 1..<self.labySize - 1 {
                    self.labyrinthMatrix[index][i].directions.append(.west)
                    self.labyrinthMatrix[index][i].directions.append(.east)
                    self.labyrinthMatrix[index][i].directions.append(.north)
                }
            } else {
                for i in 1..<self.labySize - 1 {
                    self.labyrinthMatrix[index][i].directions.append(.west)
                    self.labyrinthMatrix[index][i].directions.append(.east)
                    self.labyrinthMatrix[index][i].directions.append(.south)
                }
            }
        }
    }
    
    private func initCenter(x: Int, y: Int) {
        let doors = getRandom(min: 2, max: 5)
        
        for _ in 1...doors {
            let way = getRandom(min: 0, max: 4)
            switch way {
            case 0: self.labyrinthMatrix[x][y].directions.append(.north)
            case 1: self.labyrinthMatrix[x][y].directions.append(.west)
            case 2: self.labyrinthMatrix[x][y].directions.append(.east)
            case 3: self.labyrinthMatrix[x][y].directions.append(.south)
            default: break
            }
        }
    }
    
    private func initDirections() {
        self.labyrinthMatrix[0][0].directions.append(.north)
        self.labyrinthMatrix[0][0].directions.append(.east)
        
        initPerimeter(index: 0, way: .north)
        initPerimeter(index: 0, way: .east)
        initPerimeter(index: self.labySize - 1, way: .north)
        initPerimeter(index: self.labySize - 1, way: .east)
        
        for i in 1..<self.labySize - 1 {
            for j in 1..<self.labySize - 1 {
                initCenter(x: i, y: j)
            }
        }
    }
    
    private func getRandom(min: Int, max: Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min)))
    }
    
    func can(playerOpenChest: Player) -> Bool {
        if playerOpenChest.Is(playerHaveItem: .key) && labyrinthMatrix[playerOpenChest.currentX][playerOpenChest.currentY].Is(itemHere: .chest) {
            return true
        } else {
            return false
        }
    }
    
}

class Room {
    
    fileprivate var x: Int
    fileprivate var y: Int
    fileprivate var directions: [Directions]
    fileprivate var inventory: [Inventory]
    fileprivate var isDark: Bool
    
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
                return
            }
            i = i + 1
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
    
    /*
    func countOf(_ inventory: Inventory) -> Int {
        var count = 0
        
        for item in self.inventory {
            if item == inventory {
                count += 1
            }
        }
        
        return count
    }
 */
    
    func isTrap() -> Bool {
        if self.directions.count < 1 {
            return true
        } else {
            return false
        }
    }
    
    private func isObjectHaveLigth(_ inventory: [Inventory]) -> Bool {
        for inv in inventory {
            if inv == Inventory.torch {
                return true
            }
        }
        
        return false
    }
}

