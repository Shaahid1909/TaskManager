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
    
    @IBOutlet weak var layerView: UIView!
    var insert = [insertData]()
    var urlpath:String?
    var dateset = UIDatePicker()
    var taskCategory: String?


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
       // layerView.layer.cornerRadius = 10
        popView.bounds = CGRect(x: -13, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.4)
        
        layerView.layer.borderWidth = 0.5
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
        layerView.layer.masksToBounds = false
        layerView.layer.shadowRadius = 4
        layerView.layer.shadowOpacity = 1
        layerView.layer.shadowColor = UIColor.gray.cgColor
        layerView.layer.shadowOffset = CGSize(width: 0 , height:10)
    }
    
    @IBAction func ShoppingAction(_ sender: Any) {
        taskCategory = "Shopping"
      }
      @IBAction func Dollar(_ sender: Any) {
        taskCategory = "Expense"
      }
      @IBAction func inbox(_ sender: Any) {
        taskCategory = "inbox"
      }
      @IBAction func Personal(_ sender: Any) {
        taskCategory = "Personal Notes"
      }
      @IBAction func personalDiary(_ sender: Any) {
        taskCategory = "Personal Diary"
      }
      @IBAction func Appointments(_ sender: Any) {
        taskCategory = "Appointment"
      }
      @IBAction func TasksCompleted(_ sender: Any) {
        taskCategory = "Tasks"
      }
      @IBAction func Business(_ sender: Any) {
        taskCategory = "Business"
      }
      @IBAction func Travel(_ sender: Any) {
        taskCategory = "Travel"
      }
      @IBAction func Gift(_ sender: Any) {
        taskCategory = "Gift"
      }
      @IBAction func Home(_ sender: Any) {
        taskCategory = "Home"
      }

    func animateIn(desiredView:UIView){
        self.navigationItem.title = "Add Tasks"

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
        self.navigationItem.title = "Tasks"
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.0 , y: 1.0)
            desiredView.alpha = 0
        },completion: { _ in desiredView.removeFromSuperview()} )
    }
    
    
    
    @IBAction func AddbtnActionTapped(_ sender: Any) {
    
        insert.removeAll()
        animatedismiss(desiredView: popView)
        let request = NSMutableURLRequest(url: NSURL(string: "https://appstudio.co/iOS/Task_N.php")! as URL)
        request.httpMethod = "POST"
        let postString = "TaskDate=\(dateField.text!)&username=shaahid@gmail.com&TaskName=\(tasknameField.text!)&TaskStatus=Pending&FavouriteStatus=Not Favourite&Category=\(taskCategory ?? "")"
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
        let request = NSMutableURLRequest(url: NSURL(string: urlpath ?? "https://appstudio.co/iOS/Retrieve_N.php")! as URL)
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
            let TaskDate = jsonElement["TaskDate"] as? String,
            let Category = jsonElement["Category"] as? String,
            let FavouriteStatus = jsonElement["FavouriteStatus"]as? String
{
                            let formatter = DateFormatter()
                                        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                                        let datetime = formatter.date(from: "\(jsonElement["TaskDate"] as! String) 13:37:00 +0100")
                                        let dateformatter = DateFormatter()
                                        dateformatter.dateFormat = "E,d MMM"
                                        let datetostring = dateformatter.string(from: datetime!)
                                        print("datetime \(datetime) \(jsonElement["TaskDate"] as? String) \(datetostring)")
            print(TaskName)
            print(TaskStatus)
                
                insert.append(insertData(TaskName: TaskName, TaskStatus: TaskStatus,TaskDate: datetostring,FavouriteStatus: FavouriteStatus,Category: Category))
                

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
        return 93
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskViewCell
        
        cell.tasknamelab.text = insert[indexPath.row].TaskName
        cell.taskdatelab.text = insert[indexPath.row].TaskDate
        cell.favcheck.tag = indexPath.row
        cell.favcheck.addTarget(self, action: #selector(cellbtntapped(sender:)), for: .touchUpInside)
        if insert[indexPath.row].Category == "Home"{
              cell.categoryImg.image = UIImage(named: "Group 35")
            }else if insert[indexPath.row].Category == "Shopping" {
              cell.categoryImg.image = UIImage(named: "Group 24")
            }else if insert[indexPath.row].Category == "Expense" {
              cell.categoryImg.image = UIImage(named: "Group 25")
            }else if insert[indexPath.row].Category == "inbox" {
              cell.categoryImg.image = UIImage(named: "Group 26")
            }else if insert[indexPath.row].Category == "Personal Notes" {
              cell.categoryImg.image = UIImage(named: "Group 29")
            }else if insert[indexPath.row].Category == "Personal Diary" {
              cell.categoryImg.image = UIImage(named: "Group 28")
            }else if insert[indexPath.row].Category == "Appointment" {
              cell.categoryImg.image = UIImage(named: "Group 30")
            }else if insert[indexPath.row].Category == "Tasks" {
              cell.categoryImg.image = UIImage(named: "Group 31")
            }else if insert[indexPath.row].Category == "Business" {
              cell.categoryImg.image = UIImage(named: "Group 27")
            }else if insert[indexPath.row].Category == "Travel" {
              cell.categoryImg.image = UIImage(named: "Group 33")
            }else if insert[indexPath.row].Category == "Gift" {
                cell.categoryImg.image = UIImage(named: "Group 34")
            }
     
        if insert[indexPath.row].FavouriteStatus == "Not Favourite"{
        cell.favcheck.setImage(#imageLiteral(resourceName: "Heart unchecked"), for: .normal)
        } else{
            cell.favcheck.setImage(#imageLiteral(resourceName: "Path"), for: .normal)
        }
                return cell
        }
    func refreshresponse(){
        insert.removeAll()
        downloadItems()
        
    }
    
    @objc func cellbtntapped(sender:UIButton){
        let tag = sender.tag
        let indexPath = IndexPath(row: tag, section: 0)
        let id = insert[indexPath.row]
        if sender.isSelected{
        sender.isSelected = false
        sender.setImage(#imageLiteral(resourceName: "Heart unchecked"), for: .normal)
        print("fav Deselected")
        let request = NSMutableURLRequest(url: NSURL(string: "https://appstudio.co/iOS/FavouriteStatus.php")! as URL)
        request.httpMethod = "POST"
        let postString = "TaskName=\(id.TaskName as! String)&FavouriteStatus=Not Favourite"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
        data, response, error in
        if error != nil {
        print("error=\(String(describing: error))")
        return
        }
        print("response = \(String(describing: response))")
        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print("responseString = \(String(describing: responseString))")
 //     self.refreshresponse()
        }
        task.resume()
        }else{
        sender.isSelected = true
        sender.setImage(#imageLiteral(resourceName: "Path"), for: .normal)
        print("fav Selected")
        let request = NSMutableURLRequest(url: NSURL(string: "https://appstudio.co/iOS/FavouriteStatus.php")! as URL)
        request.httpMethod = "POST"
        let postString = "TaskName=\(id.TaskName as! String)&FavouriteStatus=Favourite"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
        data, response, error in
        if error != nil {
        print("error=\(String(describing: error))")
        return
        }
        print("response = \(String(describing: response))")
        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print("responseString = \(String(describing: responseString))")
      //self.refreshresponse()
        }
        task.resume()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let id2 = insert[indexPath.row]
           if editingStyle == .delete {
           insert.remove(at: indexPath.row)
           tableView.deleteRows(at: [indexPath], with: .fade)
            let request = NSMutableURLRequest(url: NSURL(string: "https://appstudio.co/iOS/delete_N.php")! as URL)
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
    
/*    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let closeAction = UIContextualAction(style: .normal, title:  "Close", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
             print("OK, marked as Closed")
             success(true)
         })
       //  closeAction.image = UIImage(named: "tick")
        closeAction.title = "Completed"
         closeAction.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
        
        
        
        
        

         return UISwipeActionsConfiguration(actions: [closeAction])
    }
*/
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let CompletedAction = UIContextualAction(style: .normal, title: "Close", handler: {[self] (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
           print("OK, marked as Closed")
          let requesting = NSMutableURLRequest(url: NSURL(string: "https://appstudio.co/iOS/update_N.php")! as URL)
          requesting.httpMethod = "POST"
          let postStr = "TaskName=\(insert[indexPath.row].TaskName)&TaskStatus=Completed"
          print("leadingSwipeActions \(postStr)")
          requesting.httpBody = postStr.data(using: String.Encoding.utf8)
          let task = URLSession.shared.dataTask(with: requesting as URLRequest) {
            data, response, error in
            if error != nil {
              print("error=\(String(describing: error))")
              return
            }
            print("response = \(String(describing: response))")
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(String(describing: responseString))")
            print("Checked Selected")
          }
          task.resume()
           success(true)
         })
        // closeAction.image = UIImage(named: "tick")
        CompletedAction.title = "Completed"
        CompletedAction.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
         return UISwipeActionsConfiguration(actions: [CompletedAction])
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
var FavouriteStatus: String?
var Category: String?
}

