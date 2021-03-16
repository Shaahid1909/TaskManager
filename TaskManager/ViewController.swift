//
//  ViewController.swift
//  TaskManager
//
//  Created by Admin Mac on 10/03/21.
//

import UIKit
import Alamofire


class ViewController: UIViewController,UITextFieldDelegate
{
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var licensekeyText: UITextField!
    
    @IBOutlet weak var sendBtn: UIButton!
    
    var username:String?
    var licsensekey:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailText.delegate = self
        licensekeyText.delegate = self
        
        HideKeyboard()
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
        
        
        self.showSpinner(onView: self.view)
        let parameters: Parameters = ["username":emailText.text!,"licensekey":licensekeyText.text!]
         //   activityindicator.isHidden = false
         //   activityindicator.startAnimating()
           // print("checkuser : \(checkuser)")
            if emailText.text!.trimmingCharacters(in: .whitespaces).isEmpty && licensekeyText.text!.trimmingCharacters(in: .whitespaces).isEmpty{
                let alert = UIAlertController(title: "Alert", message: "Fill all the fields", preferredStyle: UIAlertController.Style.alert)
                let cancel = UIAlertAction(title: "Ok", style: .cancel) { (action) -> Void in
                  }
                alert.addAction(cancel)
                present(alert, animated: true, completion: nil)
                self.removeSpinner()
            }else {
                AF.request("https://appstudio.co/iOS/login_N.php", method: .post, parameters: parameters).responseJSON
                {[self] response in
                    if let result = response.value{
                        let jsonData = result as! NSDictionary
                        print("jsonData : \(jsonData.allValues)")

                        for i in jsonData.allValues{
                            if i as! String == "success"{
                                username = emailText.text!

    //                                    mail_add = EmailLog.text
                                        emailText.text = ""
                                        licensekeyText.text = ""
    //                                    SecurityScreen
                                performSegue(withIdentifier: "logintotabbar", sender: self)


                            }else if i as! String == "failure"{
                             
                                let alert = UIAlertController(title: "Alert", message: "Check Username and License key", preferredStyle: UIAlertController.Style.alert)
                                let cancel = UIAlertAction(title: "Ok", style: .cancel) { (action) -> Void in
                                    }
                                alert.addAction(cancel)
                                present(alert, animated: true, completion: nil)
                                self.removeSpinner()
                            }
                        }
                    }
                }}

UserDefaults.standard.set(emailText.text, forKey: "email")
}
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func HideKeyboard() {
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self , action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
    }
 
  //-------DismissKeyboard
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }

    
    @IBAction func continueAction(_ sender: Any) {
        
        
    }
    
  
    
}
