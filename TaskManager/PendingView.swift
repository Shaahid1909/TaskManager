//
//  PendingView.swift
//  TaskManager
//
//  Created by Admin Mac on 12/03/21.
//

import UIKit

class PendingView: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var pend = [pendinglist]()
    var urlpath: String?
    
    @IBOutlet weak var pendtable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pendtable.delegate = self
        pendtable.dataSource = self
      
    
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        pend.removeAll()
        downloadItems()
  
         
        }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pend.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let id2 = pend[indexPath.row]
           if editingStyle == .delete {
           pend.remove(at: indexPath.row)
           tableView.deleteRows(at: [indexPath], with: .fade)
            let request = NSMutableURLRequest(url: NSURL(string: "https://appstudio.co/iOS/delete_N.php")! as URL)
            request.httpMethod = "POST"
            let postString = "TaskName=\(id2.pendingTaskname as! String)"
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
        let CompletedAction = UIContextualAction(style: .normal, title: "Close", handler: {[self] (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
           print("OK, marked as Closed")
          let requesting = NSMutableURLRequest(url: NSURL(string: "https://appstudio.co/iOS/update_N.php")! as URL)
          requesting.httpMethod = "POST"
          let postStr = "TaskName=\(pend[indexPath.row].pendingTaskname!)&TaskStatus=Completed"
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pcell = tableView.dequeueReusableCell(withIdentifier: "pendCell", for: indexPath) as! PendingCell
        pcell.pendtextlab.text = pend[indexPath.row].pendingTaskname
        pcell.pendatelab.text = pend[indexPath.row].pendingdate
        pcell.pendfavbtn.tag = indexPath.row
        pcell.pendfavbtn.addTarget(self, action: #selector(cellbtntapped(sender:)), for: .touchUpInside)
        if pend[indexPath.row].Category == "Home"{
            pcell.pencatImg.image = UIImage(named: "Group 35")
            }else if pend[indexPath.row].Category == "Shopping" {
              pcell.pencatImg.image = UIImage(named: "Group 24")
            }else if pend[indexPath.row].Category == "Expense" {
              pcell.pencatImg.image = UIImage(named: "Group 25")
            }else if pend[indexPath.row].Category == "inbox" {
              pcell.pencatImg.image = UIImage(named: "Group 26")
            }else if pend[indexPath.row].Category == "Personal Notes" {
              pcell.pencatImg.image = UIImage(named: "Group 29")
            }else if pend[indexPath.row].Category == "Personal Diary" {
              pcell.pencatImg.image = UIImage(named: "Group 28")
            }else if pend[indexPath.row].Category == "Appointment" {
              pcell.pencatImg.image = UIImage(named: "Group 30")
            }else if pend[indexPath.row].Category == "Tasks" {
              pcell.pencatImg.image = UIImage(named: "Group 31")
            }else if pend[indexPath.row].Category == "Business" {
              pcell.pencatImg.image = UIImage(named: "Group 27")
            }else if pend[indexPath.row].Category == "Travel" {
              pcell.pencatImg.image = UIImage(named: "Group 33")
            }else if pend[indexPath.row].Category == "Gift" {
                pcell.pencatImg.image = UIImage(named: "Group 34")
            }
        if pend[indexPath.row].favstatus == "Not Favourite"{
        pcell.pendfavbtn.setImage(#imageLiteral(resourceName: "Heart unchecked"), for: .normal)
        } else{
            pcell.pendfavbtn.setImage(#imageLiteral(resourceName: "Path"), for: .normal)
        }
              return pcell
    }
    
    @objc func cellbtntapped(sender:UIButton){
        let tag = sender.tag
        let indexPath = IndexPath(row: tag, section: 0)
        let id = pend[indexPath.row]
        if sender.isSelected{
        sender.isSelected = false
        sender.setImage(#imageLiteral(resourceName: "Heart unchecked"), for: .normal)
        print("fav Deselected")
        let request = NSMutableURLRequest(url: NSURL(string: "https://appstudio.co/iOS/FavouriteStatus.php")! as URL)
        request.httpMethod = "POST"
        let postString = "TaskName=\(id.pendingTaskname as! String)&FavouriteStatus=Not Favourite"
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
        let postString = "TaskName=\(id.pendingTaskname as! String)&FavouriteStatus=Favourite"
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
    
    
    
    
    func downloadItems() {
        
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {return}
        
        let request = NSMutableURLRequest(url: NSURL(string:"https://appstudio.co/iOS/Pending_N.php")! as URL)
            request.httpMethod = "POST"
            let postString = "username=\(email)"
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
            print(TaskName)
            print(TaskStatus)
                let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                            let datetime = formatter.date(from: "\(jsonElement["TaskDate"] as! String) 13:37:00 +0100")
                            let dateformatter = DateFormatter()
                            dateformatter.dateFormat = "E,d MMM"
                            let datetostring = dateformatter.string(from: datetime!)
                            print("datetime \(datetime) \(jsonElement["TaskDate"] as? String) \(datetostring)")
                
                pend.append(pendinglist(pendingTaskname: TaskName, pendingdate: datetostring,Category: Category, favstatus: FavouriteStatus))

                }
            }
        DispatchQueue.main.async(execute: { [self] () -> Void in
                itemsDownloaded(items: stocks)
        })
        }
    
    
    func itemsDownloaded(items: NSArray) {
       
        self.pendtable.reloadData()
      }}

struct pendinglist{
    var pendingTaskname: String?
    var pendingdate: String?
    var Category: String?
    var favstatus: String?
    
}
