//
//  TaskViewController.swift
//  TaskManager
//
//  Created by Admin Mac on 11/03/21.
//

import UIKit

class TaskViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    @IBOutlet var popView: UIView!
    @IBOutlet weak var tabView: UITableView!
    @IBOutlet weak var AddtaskBtn: UIButton!
    @IBOutlet weak var tasknameField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var viewtaskaddbtn: UIButton!
    
    var insert = [insertData]()
    var urlpath:String?
    var dateset = UIDatePicker()
  


    @IBAction func animatedout(_ sender: Any) {
    animatedismiss(desiredView: popView)
    }
    
    @IBAction func addclicked(_ sender: Any) {
        animateIn(desiredView: popView)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabView.delegate = self
        tabView.dataSource = self
        popView.layer.cornerRadius = 10
        popView.layer.borderColor = UIColor.black.cgColor
        popView.layer.borderWidth = 0.3
        popView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.4)
        downloadItems()
        viewtaskaddbtn.layer.cornerRadius = 13
        tasknameField.layer.cornerRadius = 10
        tasknameField.layer.borderWidth = 0.3
        tasknameField.layer.borderColor = UIColor.black.cgColor
        dateField.layer.cornerRadius = 10
        dateField.layer.borderWidth = 0.3
        dateField.layer.borderColor = UIColor.black.cgColor
        datepicker()
        doneselect()
        
    }
    func animateIn(desiredView:UIView){
        let backgroundView = self.view
        backgroundView?.addSubview(desiredView)
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = backgroundView?.center as! CGPoint
        UIView.animate(withDuration: 0.3, animations: {
        desiredView.transform = CGAffineTransform(scaleX: 1.0 , y: 1.0)
        desiredView.alpha = 1
        })
    }
    

    func  animatedismiss(desiredView:UIView){
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.0 , y: 1.0)
            desiredView.alpha = 0
        },completion: { _ in desiredView.removeFromSuperview()} )
    }
    
    
    
    @IBAction func AddbtnActionTapped(_ sender: Any) {
        insert.removeAll()
        animatedismiss(desiredView: popView)
        let request = NSMutableURLRequest(url: NSURL(string: "https://appstudio.co/iOS/Task.php")! as URL)
        request.httpMethod = "POST"
        let postString = "date=\(dateField.text!)&username=shaahid@gmail.com&TaskName=\(tasknameField.text!)&TaskStatus=Pending"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task1 = URLSession.shared.dataTask(with: request as URLRequest) {
        data, response, error in
        if error != nil {
        print("error=\(String(describing: error))")
        return
        }
        print("response = \(String(describing: response))")
        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print("responseString = \(String(describing: responseString))")
            self.downloadItems()
        }
        task1.resume()
        tasknameField.text = ""
        dateField.text = ""
        self.tabView.reloadData()
        
        
        
    }
    func downloadItems() {
        let request = NSMutableURLRequest(url: NSURL(string: urlpath ?? "https://appstudio.co/iOS/Retrieve_1.php")! as URL)
            request.httpMethod = "POST"
            let postString = "username=shaahid@gmail.com"
            print("postString \(postString)")
            request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
              data, response, error in
              if error != nil {
                print("error=\(String(describing: error))")
                return
              }
              self.parseJSON(data!)
              print("response = \(String(describing: response))")
              let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
              print("responseString = \(String(describing: responseString))")
            }
            task.resume()
        
    }
    
    func parseJSON(_ data:Data) {
        var jsonResult = NSArray()
            do{
                jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            } catch let error as NSError {
                print(error)
            }
            var jsonElement = NSDictionary()
        let stocks = NSMutableArray()
        for i in 0 ..< jsonResult.count
             {
            print("The count is \(jsonResult.count)")
            jsonElement = jsonResult[i] as! NSDictionary
                //the following insures none of the JsonElement values are nil through optional binding
            if let TaskName = jsonElement["Taskname"] as? String,
            let TaskStatus = jsonElement["TaskStatus"] as? String,
            let TaskDate = jsonElement["date"] as? String
            {
            print(TaskName)
            print(TaskStatus)
                
                insert.append(insertData(TaskName: TaskName, TaskStatus: TaskStatus,TaskDate: TaskDate))
                

                }
            }
        DispatchQueue.main.async(execute: { [self] () -> Void in
                itemsDownloaded(items: stocks)
        })
        }
    
    
    func itemsDownloaded(items: NSArray) {
       
        self.tabView.reloadData()
      }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      return UITableView.automaticDimension
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return insert.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 113
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskViewCell
        
        cell.tasknamelab.text = insert[indexPath.row].TaskName
        cell.taskdatelab.text = insert[indexPath.row].TaskDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let id2 = insert[indexPath.row]
           if editingStyle == .delete {
           insert.remove(at: indexPath.row)
           tableView.deleteRows(at: [indexPath], with: .fade)
            let request = NSMutableURLRequest(url: NSURL(string: "https://appstudio.co/iOS/delete.php")! as URL)
            request.httpMethod = "POST"
            let postString = "TaskName=\(id2.TaskName as! String)"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            let task3 = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
            print("error=\(String(describing: error))")
            return
            }
            print("response = \(String(describing: response))")
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(String(describing: responseString))")
            }
            task3.resume()
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let closeAction = UIContextualAction(style: .normal, title:  "Close", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
             print("OK, marked as Closed")
             success(true)
         })
       //  closeAction.image = UIImage(named: "tick")
        closeAction.title = "Completed"
         closeAction.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)

         return UISwipeActionsConfiguration(actions: [closeAction])
    }
    
    
    
    func datepicker(){
        let toolbar=UIToolbar()
        toolbar.sizeToFit()
        let done=UIBarButtonItem(barButtonSystemItem: .done, target:nil, action:#selector(doneselect))
        toolbar.setItems([done], animated: false)
        dateField.inputAccessoryView=toolbar
        dateField.inputView=dateset
        dateset.datePickerMode = .date
        
    }
    
    @objc func doneselect(){
        let dateformat=DateFormatter()
        dateformat.dateStyle = .medium
        dateformat.timeStyle = .none
        dateformat.dateFormat = "yyyy-MM-dd"
        let datestring = dateformat.string(from: dateset.date)
        dateField.text="\(datestring)"
        self.view.endEditing(true)
    }
    
    
    
}

struct insertData {
var TaskName:String
var TaskStatus:String?
var TaskDate: String?
}

