//
//  securityView.swift
//  TaskManager
//
//  Created by Admin Mac on 11/03/21.
//

import UIKit

class securityView: UIViewController {
    
    @IBOutlet weak var securityText: UITextField!
    @IBOutlet weak var activateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        securityText.layer.borderWidth = 2
        securityText.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        securityText.layer.cornerRadius = 10

        activateBtn.layer.cornerRadius = 10
             // Do any additional setup after loading the view.
    }
    


}
