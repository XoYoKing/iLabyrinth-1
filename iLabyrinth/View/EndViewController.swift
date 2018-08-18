//
//  EndViewController.swift
//  iLabyrinth
//
//  Created by TONY on 19/08/2018.
//  Copyright © 2018 TONY COMPANY. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {

    var isWin: Bool!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if isWin {
            imageView.image = UIImage(named: "art.scnassets/gold.png")
        } else {
            imageView.image = UIImage(named: "art.scnassets/gameover.png")
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
