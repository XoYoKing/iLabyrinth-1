//
//  EnterViewController.swift
//  iLabyrinth
//
//  Created by TONY on 02/08/2018.
//  Copyright © 2018 TONY COMPANY. All rights reserved.
//

import UIKit

class EnterViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //imageView.image? = #imageLiteral(resourceName: "wall.jpg")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func levelChoose(_ sender: UIButton) {
        
        switch sender.currentTitle! {
        case "Easy":
            self.performSegue(withIdentifier: "EnterToGame", sender: Levels.easy)
        case "Medium":
            self.performSegue(withIdentifier: "EnterToGame", sender: Levels.medium)
        case "Hard":
            self.performSegue(withIdentifier: "EnterToGame", sender: Levels.hard)
        case "Impossible":
            self.performSegue(withIdentifier: "EnterToGame", sender: Levels.impossible)
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? GameViewController {
            controller.level = sender! as? Levels
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
