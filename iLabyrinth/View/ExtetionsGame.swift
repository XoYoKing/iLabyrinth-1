//
//  ExtetionsGame.swift
//  iLabyrinth
//
//  Created by TONY on 18/08/2018.
//  Copyright © 2018 TONY COMPANY. All rights reserved.
//

import Foundation
import UIKit

extension GameViewController {
    
    func setUpButtoms () {
        let backButton = UIButton(frame: CGRect(x: 10, y: 30, width: 60, height: 30))
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(UIColor.white, for: .normal)
        backButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        positionLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 70, height: 30))
        positionLabel.textColor = UIColor.white
        positionLabel.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(positionLabel)
        
        stepsLabel = UILabel(frame: CGRect(x: 20, y: 140, width: 70, height: 30))
        stepsLabel.textColor = UIColor.white
        stepsLabel.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(stepsLabel)
        
        keyButton = UIButton(frame: CGRect(x: 10, y: 200, width: 60, height: 30))
        keyButton.setImage(UIImage(named: "art.scnassets/key.png"), for: .normal)
        self.view.addSubview(keyButton)
        
        torchButton = UIButton(frame: CGRect(x: 10, y: 250, width: 60, height: 30))
        torchButton.setImage(UIImage(named: "art.scnassets/torch.png"), for: .normal)
        backButton.addTarget(self, action: #selector(dropTorch), for: .touchUpInside)
        self.view.addSubview(torchButton)
        
    }
    
    func loadButtoms() {
        positionLabel.text = "[\(self.player.currentX);\(self.player.currentY)]"
        
        stepsLabel.text = "\(self.player.stepsHave)"
        
        if self.player.Is(playerHaveItem: .key) {
            keyButton.isHidden = false
        } else {
            keyButton.isHidden = true
        }
        
        if self.player.Is(playerHaveItem: .torch) {
            torchButton.isHidden = false
        } else {
            torchButton.isHidden = true
        }
    }
    
    func loadRoom() {
        
        loadButtoms()
        
        let thisRoom = self.labyrinth.labyrinthMatrix[self.player.currentX][self.player.currentY]
        
        //if dark
        if thisRoom.isDarkNow(player: self.player) {
            
            self.scene.rootNode.childNode(withName: "ceiling", recursively: true)!.isHidden = true
            self.scene.rootNode.childNode(withName: "floor", recursively: true)!.isHidden = true
            
            self.scene.rootNode.childNode(withName: "wall-Z", recursively: true)!.isHidden = true
            self.scene.rootNode.childNode(withName: "wallZ", recursively: true)!.isHidden = true
            self.scene.rootNode.childNode(withName: "wall-X", recursively: true)!.isHidden = true
            self.scene.rootNode.childNode(withName: "wallX", recursively: true)!.isHidden = true
        } else {
            self.scene.rootNode.childNode(withName: "ceiling", recursively: true)!.isHidden = false
            self.scene.rootNode.childNode(withName: "floor", recursively: true)!.isHidden = false
            
            self.scene.rootNode.childNode(withName: "wall-Z", recursively: true)!.isHidden = false
            self.scene.rootNode.childNode(withName: "wallZ", recursively: true)!.isHidden = false
            self.scene.rootNode.childNode(withName: "wall-X", recursively: true)!.isHidden = false
            self.scene.rootNode.childNode(withName: "wallX", recursively: true)!.isHidden = false
            
            setUpInventory(in: thisRoom)
        }
        
        //set up doors
        if !thisRoom.isThere(direction: .north) {
            self.scene.rootNode.childNode(withName: "doorNorth", recursively: true)!.isHidden = true
        } else {
            self.scene.rootNode.childNode(withName: "doorNorth", recursively: true)!.isHidden = false
        }
        
        if !thisRoom.isThere(direction: .east) {
            self.scene.rootNode.childNode(withName: "doorEast", recursively: true)!.isHidden = true
        } else {
            self.scene.rootNode.childNode(withName: "doorEast", recursively: true)!.isHidden = false
        }
        
        if !thisRoom.isThere(direction: .west) {
            self.scene.rootNode.childNode(withName: "doorWest", recursively: true)!.isHidden = true
        } else {
            self.scene.rootNode.childNode(withName: "doorWest", recursively: true)!.isHidden = false
        }
        
        if !thisRoom.isThere(direction: .south) {
            self.scene.rootNode.childNode(withName: "doorSouth", recursively: true)!.isHidden = true
        } else {
            self.scene.rootNode.childNode(withName: "doorSouth", recursively: true)!.isHidden = false
        }
    }
    
    func setUpInventory(in room: Room) {
        if room.Is(itemHere: .chest) {
            self.scene.rootNode.childNode(withName: "chest", recursively: true)!.isHidden = false
        } else {
            self.scene.rootNode.childNode(withName: "chest", recursively: true)!.isHidden = true
        }
        
        if room.Is(itemHere: .key) {
            self.scene.rootNode.childNode(withName: "key", recursively: true)!.isHidden = false
        } else {
            self.scene.rootNode.childNode(withName: "key", recursively: true)!.isHidden = true
        }
        
        if room.Is(itemHere: .torch) {
            self.scene.rootNode.childNode(withName: "torch", recursively: true)!.isHidden = false
        } else {
            self.scene.rootNode.childNode(withName: "torch", recursively: true)!.isHidden = true
        }
        
        if room.Is(itemHere: .apple) {
            self.scene.rootNode.childNode(withName: "apple", recursively: true)!.isHidden = false
        } else {
            self.scene.rootNode.childNode(withName: "apple", recursively: true)!.isHidden = true
        }
    }
    
    func gameCheck() {
        let thisRoom = self.labyrinth.labyrinthMatrix[self.player.currentX][self.player.currentY]
        
        if thisRoom.isTrap() {
            self.performSegue(withIdentifier: "GameToEnd", sender: false)
        }
        
        if self.player.stepsHave == 0 {
            self.performSegue(withIdentifier: "GameToEnd", sender: false)
        }
    }
}
