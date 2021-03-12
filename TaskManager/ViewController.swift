//
//  ViewController.swift
//  TaskManager
//
//  Created by Admin Mac on 10/03/21.
//

import UIKit
import MessageUI

class ViewController: UIViewController,MFMailComposeViewControllerDelegate
{
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

    @IBAction func sendEmail(_ sender: Any) {
           //TODO:  You should chack if we can send email or not
           if MFMailComposeViewController.canSendMail() {
               let mail = MFMailComposeViewController()
               mail.mailComposeDelegate = self
            mail.setToRecipients(["\(emailText.text as! String               )"])
               mail.setSubject("Verification code")
               mail.setMessageBody("<p>The verification code is 12345</p>", isHTML: true)
               present(mail, animated: true)
           } else {
               print("Application is not able to send an email")
           }
       }

       //MARK: MFMail Compose ViewController Delegate method
       func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
           controller.dismiss(animated: true)
       }
    

}

