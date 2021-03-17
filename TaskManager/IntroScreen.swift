//
//  IntroScreen.swift
//  TaskManager
//
//  Created by Admin Mac on 17/03/21.
//

import UIKit

class IntroScreen: UIViewController {

    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextbtnTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "nextpass", sender: self)
    }
    
  
}
