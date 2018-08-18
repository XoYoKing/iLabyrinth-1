//
//  labyrinthClass.swift
//  iLabyrinth
//
//  Created by TONY on 02/08/2018.
//  Copyright © 2018 TONY COMPANY. All rights reserved.
//

import Foundation

class Labyrinth {
    
    var labySize: Int
    var labyrinthMatrix: [[Room]]
    
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
    
    func getRandom(min: Int, max: Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min)))
    }
    
    func initInventory() {
        self.labyrinthMatrix[getRandom(min: 5, max: self.labySize)][getRandom(min: 5, max: self.labySize)].inventory.append(Inventory.key)
        self.labyrinthMatrix[getRandom(min: 5, max: self.labySize)][getRandom(min: 5, max: self.labySize)].inventory.append(Inventory.chest)
        
        for _ in 1...10 {
            self.labyrinthMatrix[getRandom(min: 5, max: self.labySize)][getRandom(min: 5, max: self.labySize)].inventory.append(Inventory.apple)
            self.labyrinthMatrix[getRandom(min: 5, max: self.labySize)][getRandom(min: 5, max: self.labySize)].inventory.append(Inventory.torch)
        }
    }
    
    func initPerimeter(index: Int, way: Directions) {
        if way == .north {
            if index == 0 {
                for i in 1..<self.labySize - 1 {
                    self.labyrinthMatrix[i][index].directions.append(.north)
                    self.labyrinthMatrix[i][index].directions.append(.south)
                    if getRandom(min: 0, max: 2) == 1 {
                        self.labyrinthMatrix[index][i].directions.append(.east)
                    }
                }
            } else {
                for i in 1..<self.labySize - 1 {
                    self.labyrinthMatrix[i][index].directions.append(.north)
                    self.labyrinthMatrix[i][index].directions.append(.south)
                    if getRandom(min: 0, max: 2) == 1 {
                        self.labyrinthMatrix[index][i].directions.append(.west)
                    }
                }
            }
        } else {
            if index == 0 {
                for i in 1..<self.labySize - 1 {
                    self.labyrinthMatrix[index][i].directions.append(.west)
                    self.labyrinthMatrix[index][i].directions.append(.east)
                    if getRandom(min: 0, max: 2) == 1 {
                        self.labyrinthMatrix[index][i].directions.append(.north)
                    }
                }
            } else {
                for i in 1..<self.labySize - 1 {
                    self.labyrinthMatrix[index][i].directions.append(.west)
                    self.labyrinthMatrix[index][i].directions.append(.east)
                    if getRandom(min: 0, max: 2) == 1 {
                        self.labyrinthMatrix[index][i].directions.append(.south)
                    }
                }
            }
        }
    }
    
    func initCenter(x: Int, y: Int) {
        let doors = getRandom(min: 1, max: 5)
        
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
    
    func initDirections() {
        self.labyrinthMatrix[0][0].directions.append(.north)
        self.labyrinthMatrix[0][0].directions.append(.east)
        
        initPerimeter(index: 0, way: .north)
        initPerimeter(index: 0, way: .east)
        initPerimeter(index: self.labySize - 1, way: .north)
        initPerimeter(index: self.labySize - 1, way: .east)
        
        for i in 1..<self.labySize - 2 {
            for j in 1..<self.labySize - 2 {
                initCenter(x: i, y: j)
            }
        }
    }
    
    func can(playerOpenChest: Player) -> Bool {
        if playerOpenChest.Is(playerHaveItem: .key) && labyrinthMatrix[playerOpenChest.currentX][playerOpenChest.currentY].Is(itemHere: .chest) {
            return true
        } else {
            return false
        }
    }
    
}
