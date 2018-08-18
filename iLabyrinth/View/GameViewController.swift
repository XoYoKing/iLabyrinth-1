//
//  GameViewController.swift
//  iLabyrinth
//
//  Created by TONY on 02/08/2018.
//  Copyright © 2018 TONY COMPANY. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    
    var level: Levels!
    var player: Player!
    var labyrinth: Labyrinth!
    
    var positionLabel: UILabel!
    var stepsLabel: UILabel!
    
    var keyButton: UIButton!
    var torchButton: UIButton!
    
    let scene = SCNScene(named: "art.scnassets/room.scn")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = true
        scnView.defaultCameraController.maximumVerticalAngle = 10
        
        let backgroundMusic = SCNAudioSource(named: "art.scnassets/Heartbeat.mp3")!
        backgroundMusic.volume = 0.5
        backgroundMusic.loops = true
        backgroundMusic.load()
        
        self.scene.rootNode.runAction(SCNAction.playAudio(backgroundMusic, waitForCompletion: true))
        
        self.labyrinth = Labyrinth(level: self.level)
        self.player = Player()
        
        setUpButtoms()
        loadRoom()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        let scnView = self.view as! SCNView
        
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        if hitResults.count > 0 {
            let resultNode = hitResults[0].node
            
            let thisRoom = self.labyrinth.labyrinthMatrix[self.player.currentX][self.player.currentY]

            switch resultNode.name! {
            //doors tapped
            case "doorNorth":
                self.player.go(to: .north)
                loadRoom()
                gameCheck()
                
            case "doorWest":
                self.player.go(to: .west)
                loadRoom()
                gameCheck()
                
            case "doorEast":
                self.player.go(to: .east)
                loadRoom()
                gameCheck()
                
            case "doorSouth":
                self.player.go(to: .south)
                loadRoom()
                gameCheck()
                
            //inventory tapped
            case "chest":
                if thisRoom.Is(itemHere: .chest) && !thisRoom.isDarkNow(player: self.player) {
                    if self.player.Is(playerHaveItem: .key) {
                        self.performSegue(withIdentifier: "GameToEnd", sender: true)
                    }
                }
            case "key":
                if thisRoom.Is(itemHere: .key) && !thisRoom.isDarkNow(player: self.player) {
                    self.player.get(item: .key)
                    thisRoom.playerGet(.key)
                    loadButtoms()
                    setUpInventory(in: thisRoom)
                }
                
            case "apple":
                if thisRoom.Is(itemHere: .apple) && !thisRoom.isDarkNow(player: self.player) {
                    self.player.eatApple()
                    thisRoom.playerGet(.apple)
                    setUpInventory(in: thisRoom)
                }
                
            case "torch":
                if thisRoom.Is(itemHere: .torch) && !thisRoom.isDarkNow(player: self.player) {
                    self.player.get(item: .torch)
                    thisRoom.playerGet(.torch)
                    loadButtoms()
                    setUpInventory(in: thisRoom)
                }
                
            default: break
            }
        }
    }
    
    @objc
    func buttonAction() {
        self.performSegue(withIdentifier: "GameToEnter", sender: nil)
    }
    
    @objc
    func dropTorch() {
        let thisRoom = self.labyrinth.labyrinthMatrix[self.player.currentX][self.player.currentY]
        
        thisRoom.playerDrop(.torch)
        self.player.drop(item: .torch)
        
        loadButtoms()
        setUpInventory(in: thisRoom)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? EndViewController {
            controller.isWin = sender! as! Bool
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
