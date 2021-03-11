//
//  ViewController.swift
//  TaskManager
//
//  Created by Admin Mac on 10/03/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var licensekeyText: UITextField!
    
    @IBOutlet weak var sendBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailText.layer.borderWidth = 2
        emailText.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        emailText.layer.cornerRadius = 10
        licensekeyText.layer.borderWidth = 2
        licensekeyText.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        licensekeyText.layer.cornerRadius = 10
        sendBtn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }


}

