//
//  SettingsViewController.swift
//  TaskManager
//
//  Created by Admin Mac on 12/03/21.
//

import UIKit

class SettingsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    

    @IBOutlet weak var settable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settable.delegate = self
        settable.dataSource = self
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = settable.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! setfirstCell
            return cell
        
        }else if indexPath.row == 1{
            let cell = settable.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! setsecondCell
            return cell
            
        }else if indexPath.row == 2{
            let cell = settable.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath) as! setthirdCell
           
            return cell
        }else if indexPath.row == 3{
            let cell = settable.dequeueReusableCell(withIdentifier: "Cell4", for: indexPath) as! setfourthCell
            return cell
        }else{
            let cell = settable.dequeueReusableCell(withIdentifier: "Cell5", for: indexPath) as! setfifthCell
            
            return cell
    }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
