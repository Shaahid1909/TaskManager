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
    var ColdTaskname:String?
    var Cdidselect:String?
    var CsdateSelect: String?
    var CtextField = UITextField()
    var CstextField = UITextField()
    var Cstart_end_date1 = UIDatePicker()
    @IBOutlet weak var cdefaulVeww: UIView!
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
        comptable.reloadData()
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        complete.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        ColdTaskname?.removeAll()
        
 
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {return}

        Cdidselect = "\(complete[indexPath.row].completedTaskname as! String)"
        CsdateSelect = "\(complete[indexPath.row].completeddate as! String)"
     
        let alert = UIAlertController(title: "Edit", message: "", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "update", style: UIAlertAction.Style.default) { [self](action) in
        let alertController = UIAlertController(title: "Edit", message: "Successfully updated!", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: nil))
        self.comptable.reloadData()
      // namo link sever "http://con.test:8888/Task.php"
            
            if CtextField.text!.trimmingCharacters(in: .whitespaces).isEmpty != true && CstextField.text!.trimmingCharacters(in: .whitespaces).isEmpty != true{
            
            
        let request = NSMutableURLRequest(url: NSURL(string: "https://appstudio.co/iOS/Edit_N.php")! as URL)
        request.httpMethod = "POST"
        let postString = "username=\(email)&TaskName=\(CtextField.text as! String)&TaskStatus=\(complete[indexPath.row].completedTaskname as! String)&TaskDate=\(CstextField.text as! String)&Id=\(Int16(complete[indexPath.row].compId as! String) as! Int16)"
                    print("postString : \(postString)")
        complete.removeAll()
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
        downloadItems()
            }
        task.resume()
        self.present(alertController, animated: true, completion: nil)
           
        self.comptable.reloadData()
        
    }else {
          let alert = UIAlertController(title: "Alert", message: "Fill All Fields", preferredStyle: UIAlertController.Style.alert)
          let cancel = UIAlertAction(title: "Ok", style: .cancel) { (action) -> Void in
              }
       
      alert.addAction(cancel)
          present(alert, animated: true, completion: nil)
        }
                }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                    }
        alert.addTextField { [self] (alertTextField) in
        alertTextField.placeholder = "Edit Task name"
        alertTextField.text = Cdidselect
        CtextField = alertTextField
                }
            alert.addTextField { [self] (textField1) in
              let toolbar=UIToolbar()
              toolbar.sizeToFit()
         //   self.start_end_date2 = UIDatePicker(frame:CGRect(x: 0, y: self.view.frame.size.height - 220, width:self.view.frame.size.width, height: 216))
               // start_end_date.datePickerMode = .date
                let done1=UIBarButtonItem(barButtonSystemItem: .done, target:self, action:#selector(start))
                toolbar.setItems([done1], animated: false)
                textField1.inputAccessoryView=toolbar
                textField1.inputView=Cstart_end_date1
                textField1.placeholder = "Edit Task date"
                textField1.text = CsdateSelect
                Cstart_end_date1.datePickerMode = .date
                CstextField = textField1
              
        }
            alert.addAction(action)
    alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
            //   endDate.datePickerMode = .date
              
    }
    
    func datepicker1(){
        let toolbar=UIToolbar()
        toolbar.sizeToFit()
        let done=UIBarButtonItem(barButtonSystemItem: .done, target:nil, action:#selector(start))
        toolbar.setItems([done], animated: false)
        CstextField.inputAccessoryView=toolbar
        CstextField.inputView=Cstart_end_date1
        Cstart_end_date1.datePickerMode = .date
    }
    
    @objc func start(){
        let dateformat=DateFormatter()
        dateformat.dateStyle = .medium
        dateformat.timeStyle = .none
        dateformat.dateFormat = "yyyy-MM-dd"
        let sdatestring = dateformat.string(from: Cstart_end_date1.date)
        CstextField.text="\(sdatestring as! String)"
        self.view.endEditing(true)
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let id2 = complete[indexPath.row]
           if editingStyle == .delete {
           complete.remove(at: indexPath.row)
           tableView.deleteRows(at: [indexPath], with: .fade)
            let request = NSMutableURLRequest(url: NSURL(string: "https://appstudio.co/iOS/delete_N.php")! as URL)
            request.httpMethod = "POST"
            let postString = "TaskName=\(id2.completedTaskname as! String)"
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
            if self.complete.count > 0{
                self.comptable.isHidden = false
                self.cdefaulVeww.isHidden = true
            }else {
                self.comptable.isHidden = true
                self.cdefaulVeww.isHidden = false
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Ccell = tableView.dequeueReusableCell(withIdentifier: "compCell", for: indexPath) as! CompletedCell
        Ccell.comptextlab.text = complete[indexPath.row].completedTaskname
        Ccell.compdatelab.text = complete[indexPath.row].completeddate
        Ccell.favbtn.tag = indexPath.row
        Ccell.favbtn.addTarget(self, action: #selector(cellbtntapped(sender:)), for: .touchUpInside)
        
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
    
    @objc func cellbtntapped(sender:UIButton){
        let tag = sender.tag
        let indexPath = IndexPath(row: tag, section: 0)
        let id = complete[indexPath.row]
        if sender.isSelected{
        sender.isSelected = false
        sender.setImage(#imageLiteral(resourceName: "Heart unchecked"), for: .normal)
        print("fav Deselected")
        let request = NSMutableURLRequest(url: NSURL(string: "https://appstudio.co/iOS/FavouriteStatus.php")! as URL)
        request.httpMethod = "POST"
        let postString = "TaskName=\(id.completedTaskname as! String)&FavouriteStatus=Not Favourite"
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
        let postString = "TaskName=\(id.completedTaskname as! String)&FavouriteStatus=Favourite"
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
        
        let request = NSMutableURLRequest(url: NSURL(string: urlpath ?? "https://appstudio.co/iOS/Completed_N.php")! as URL)
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
            let Id = jsonElement["Id"] as? String,let FavouriteStatus = jsonElement["FavouriteStatus"]as? String
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

                complete.append(completelist(completedTaskname: TaskName,completedTaskstatus: TaskStatus, completeddate: datetostring, Category: Category,compId: Id))

                }
            }
        DispatchQueue.main.async(execute: { [self] () -> Void in
                itemsDownloaded(items: stocks)
            if self.complete.count > 0{
                self.comptable.isHidden = false
                self.cdefaulVeww.isHidden = true
            }else {
                self.comptable.isHidden = true
                self.cdefaulVeww.isHidden = false
            }
        })
        }
    
    
    func itemsDownloaded(items: NSArray) {
       
        self.comptable.reloadData()
      }}

struct completelist{
    var completedTaskname: String?
    var completedTaskstatus: String?
    var completeddate: String?
    var Category: String?
    var favstatus: String?
    var compId: String?
}
