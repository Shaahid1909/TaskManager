//
//  CompletedView.swift
//  TaskManager
//
//  Created by Admin Mac on 12/03/21.
//

import UIKit

class CompletedView: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var complete = [completelist]()
    var urlpath: String?
    
    @IBOutlet weak var comptable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        comptable.delegate = self
        comptable.dataSource = self
       
       // comptable.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        complete.removeAll()
        downloadItems()
         
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        complete.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Ccell = tableView.dequeueReusableCell(withIdentifier: "compCell", for: indexPath) as! CompletedCell
   Ccell.comptextlab.text = complete[indexPath.row].completedTaskname
    Ccell.compdatelab.text = complete[indexPath.row].completeddate
        if complete[indexPath.row].Category == "Home"{
            Ccell.compcatImg.image = UIImage(named: "Group 35")
            }else if complete[indexPath.row].Category == "Shopping" {
              Ccell.compcatImg.image = UIImage(named: "Group 24")
            }else if complete[indexPath.row].Category == "Expense" {
              Ccell.compcatImg.image = UIImage(named: "Group 25")
            }else if complete[indexPath.row].Category == "inbox" {
              Ccell.compcatImg.image = UIImage(named: "Group 26")
            }else if complete[indexPath.row].Category == "Personal Notes" {
              Ccell.compcatImg.image = UIImage(named: "Group 29")
            }else if complete[indexPath.row].Category == "Personal Diary" {
              Ccell.compcatImg.image = UIImage(named: "Group 28")
            }else if complete[indexPath.row].Category == "Appointment" {
              Ccell.compcatImg.image = UIImage(named: "Group 30")
            }else if complete[indexPath.row].Category == "Tasks" {
              Ccell.compcatImg.image = UIImage(named: "Group 31")
            }else if complete[indexPath.row].Category == "Business" {
              Ccell.compcatImg.image = UIImage(named: "Group 27")
            }else if complete[indexPath.row].Category == "Travel" {
              Ccell.compcatImg.image = UIImage(named: "Group 33")
            }else if complete[indexPath.row].Category == "Gift" {
                Ccell.compcatImg.image = UIImage(named: "Group 34")
            }
        if complete[indexPath.row].favstatus == "Not Favourite"{
        Ccell.favbtn.setImage(#imageLiteral(resourceName: "Heart unchecked"), for: .normal)
        } else{
            Ccell.favbtn.setImage(#imageLiteral(resourceName: "Path"), for: .normal)
        }
        return Ccell
    }
    
    func downloadItems() {
        let request = NSMutableURLRequest(url: NSURL(string: urlpath ?? "https://appstudio.co/iOS/Completed_N.php")! as URL)
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
            print(TaskName)
            print(TaskStatus)
                let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                            let datetime = formatter.date(from: "\(jsonElement["TaskDate"] as! String) 13:37:00 +0100")
                            let dateformatter = DateFormatter()
                            dateformatter.dateFormat = "E,d MMM"
                            let datetostring = dateformatter.string(from: datetime!)
                            print("datetime \(datetime) \(jsonElement["TaskDate"] as? String) \(datetostring)")

                complete.append(completelist(completedTaskname: TaskName, completeddate: datetostring, Category: Category))

                }
            }
        DispatchQueue.main.async(execute: { [self] () -> Void in
                itemsDownloaded(items: stocks)
        })
        }
    
    
    func itemsDownloaded(items: NSArray) {
       
        self.comptable.reloadData()
      }}
struct completelist{
    var completedTaskname: String?
    var completeddate: String?
    var Category: String?
    var favstatus: String?
}
