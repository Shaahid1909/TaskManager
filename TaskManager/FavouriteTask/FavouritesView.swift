//
//  FavouritesView.swift
//  TaskManager
//
//  Created by Admin Mac on 12/03/21.
//

import UIKit

class FavouritesView: UIViewController,UITableViewDataSource,UITableViewDelegate {
  
    @IBOutlet weak var flayerview: UIView!
    var fav = [list]()
    var urlpath: String?
    
    @IBOutlet weak var favtable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favtable.delegate = self
        favtable.dataSource = self

     //   favtable.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
        fav.removeAll()
        downloadItems()
    
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fav.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let id2 = fav[indexPath.row]
           if editingStyle == .delete {
           fav.remove(at: indexPath.row)
           tableView.deleteRows(at: [indexPath], with: .fade)
            let request = NSMutableURLRequest(url: NSURL(string: "https://appstudio.co/iOS/delete_N.php")! as URL)
            request.httpMethod = "POST"
            let postString = "TaskName=\(id2.favtaskname as! String)"
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
          let postStr = "TaskName=\(fav[indexPath.row].favtaskname)&TaskStatus=Completed"
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
        
        let fcell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavouriteCell
        fcell.favtextlab.text = fav[indexPath.row].favtaskname
        fcell.favdatelab.text = fav[indexPath.row].favdate
        fcell.favbtn.tag = indexPath.row
        fcell.favbtn.addTarget(self, action: #selector(cellbtntapped(sender:)), for: .touchUpInside)
        if fav[indexPath.row].Category == "Home"{
            fcell.favcatImg.image = UIImage(named: "Group 35")
            }else if fav[indexPath.row].Category == "Shopping" {
              fcell.favcatImg.image = UIImage(named: "Group 24")
            }else if fav[indexPath.row].Category == "Expense" {
              fcell.favcatImg.image = UIImage(named: "Group 25")
            }else if fav[indexPath.row].Category == "inbox" {
              fcell.favcatImg.image = UIImage(named: "Group 26")
            }else if fav[indexPath.row].Category == "Personal Notes" {
              fcell.favcatImg.image = UIImage(named: "Group 29")
            }else if fav[indexPath.row].Category == "Personal Diary" {
              fcell.favcatImg.image = UIImage(named: "Group 28")
            }else if fav[indexPath.row].Category == "Appointment" {
              fcell.favcatImg.image = UIImage(named: "Group 30")
            }else if fav[indexPath.row].Category == "Tasks" {
              fcell.favcatImg.image = UIImage(named: "Group 31")
            }else if fav[indexPath.row].Category == "Business" {
              fcell.favcatImg.image = UIImage(named: "Group 27")
            }else if fav[indexPath.row].Category == "Travel" {
              fcell.favcatImg.image = UIImage(named: "Group 33")
            }else if fav[indexPath.row].Category == "Gift" {
                fcell.favcatImg.image = UIImage(named: "Group 34")
            }
        if fav[indexPath.row].favStatus == "Not Favourite"{
        fcell.favbtn.setImage(#imageLiteral(resourceName: "Heart unchecked"), for: .normal)
        } else{
            fcell.favbtn.setImage(#imageLiteral(resourceName: "Path"), for: .normal)
        }
      
        return fcell
    }
    
    @objc func cellbtntapped(sender:UIButton){
        let tag = sender.tag
        let indexPath = IndexPath(row: tag, section: 0)
        let id = fav[indexPath.row]
        if sender.isSelected{
        sender.isSelected = false
        sender.setImage(#imageLiteral(resourceName: "Heart unchecked"), for: .normal)
        print("fav Deselected")
        let request = NSMutableURLRequest(url: NSURL(string: "https://appstudio.co/iOS/FavouriteStatus.php")! as URL)
        request.httpMethod = "POST"
        let postString = "TaskName=\(id.favtaskname as! String)&FavouriteStatus=Not Favourite"
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
        let postString = "TaskName=\(id.favtaskname as! String)&FavouriteStatus=Favourite"
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
        
        let request = NSMutableURLRequest(url: NSURL(string: urlpath ?? "https://appstudio.co/iOS/Favourite.php")! as URL)
            request.httpMethod = "POST"
            let postString = "username=\(email)&FavouriteStatus=Favourite"
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


                fav.append(list(favtaskname: TaskName, favdate: datetostring,Category: Category,favStatus: FavouriteStatus))

                }
            }
        DispatchQueue.main.async(execute: { [self] () -> Void in
                itemsDownloaded(items: stocks)
        })
        }
    
    
    func itemsDownloaded(items: NSArray) {
       
        self.favtable.reloadData()
      }}
struct list{
    var favtaskname: String?
    var favdate: String?
    var Category: String?
    var favStatus: String?
    
}