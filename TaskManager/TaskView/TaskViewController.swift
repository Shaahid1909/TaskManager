//
//  TaskViewController.swift
//  TaskManager
//
//  Created by Admin Mac on 11/03/21.
//

import UIKit

class TaskViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
  
    
  //  @IBOutlet var popView: UIView!
    @IBOutlet weak var tabView: UITableView!
    @IBOutlet weak var AddtaskBtn: UIButton!
    @IBOutlet weak var tasknameField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var viewtaskaddbtn: UIButton!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var popBGview: UIView!
    @IBOutlet weak var defaulVeww: UIView!
    @IBOutlet weak var ibgview: UIImageView!
    @IBOutlet weak var popBtn: UIButton!
    @IBOutlet var popView: UIScrollView!
    @IBOutlet weak var layerView: UIView!
    var insert = [insertData]()
    var urlpath:String?
    var dateset = UIDatePicker()
    var taskCategory: String?
    var oldTaskname:String?
    var didselect:String?
    var sdateSelect: String?
    var edateSelect: String?
    var stextField = UITextField()
    var textField = UITextField()
    var start_end_date1 = UIDatePicker()
    @IBOutlet weak var shopBtn: UIButton!
    @IBOutlet weak var dollarBtn: UIButton!
    @IBOutlet weak var inboxBtn: UIButton!
    @IBOutlet weak var personBtn: UIButton!
    @IBOutlet weak var personaldiaryBtn: UIButton!
    @IBOutlet weak var AppointmentBtn: UIButton!
    @IBOutlet weak var taskCompBtn: UIButton!
    @IBOutlet weak var businessBtn: UIButton!
    @IBOutlet weak var travelBtn: UIButton!
    @IBOutlet weak var giftBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    
    
    
    @IBAction func animatedout(_ sender: Any) {
        blurView.alpha = 0
    animatedismiss(desiredView: popView)
    }
    
    @IBAction func addclicked(_ sender: Any) {
        blurView.alpha = 1
        blurView.addSubview(popView)

        animateIn(desiredView: popView)
        
    }
 
    
    @IBAction func poputtonTapped(_ sender: Any) {
        animatedismiss(desiredView: popView)
        blurView.alpha = 0
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
      
        insert.removeAll()
        downloadItems()
        tabView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabView.delegate = self
        tabView.dataSource = self
        tasknameField.delegate = self
  
        HideKeyboard()
       // layerView.layer.cornerRadius = 10
   //     popView.bounds = CGRect(x: 0, y: 0, width: 385, height: 345)
        layerView.layer.cornerRadius = 10
        //layerView.layer.borderWidth = 0.5
        viewtaskaddbtn.layer.cornerRadius = 10
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
        datepicker1()
        start()
        blurView.alpha = 0
    
    }
    
    @IBAction func ShoppingAction(_ sender: Any) {
        taskCategory = "Shopping"
        giftBtn.alpha = 0.5
        giftBtn.layer.borderWidth = 0
        giftBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        dollarBtn.alpha = 0.5
        dollarBtn.layer.borderWidth = 0
        dollarBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        inboxBtn.alpha = 0.5
        inboxBtn.layer.borderWidth = 0
        inboxBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        personBtn.alpha = 0.5
        personBtn.layer.borderWidth = 0
        personBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        homeBtn.alpha = 0.5
        homeBtn.layer.borderWidth = 0
        homeBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        shopBtn.alpha = 1
        shopBtn.layer.borderWidth = 1
        shopBtn.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        travelBtn.alpha = 0.5
        travelBtn.layer.borderWidth = 0
        travelBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        AppointmentBtn.alpha = 0.5
        AppointmentBtn.layer.borderWidth = 0
        AppointmentBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        personaldiaryBtn.alpha = 0.5
        personaldiaryBtn.layer.borderWidth = 0
        personaldiaryBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        businessBtn.alpha = 0.5
        businessBtn.layer.borderWidth = 0
        businessBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        taskCompBtn.alpha = 0.5
        taskCompBtn.layer.borderWidth = 0
        taskCompBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)

      }
      @IBAction func Dollar(_ sender: Any) {
        taskCategory = "Expense"
        
        dollarBtn.alpha = 1
        dollarBtn.layer.borderWidth = 1
        dollarBtn.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        giftBtn.alpha = 0.5
        giftBtn.layer.borderWidth = 0
        giftBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        inboxBtn.alpha = 0.5
        inboxBtn.layer.borderWidth = 0
        inboxBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        personBtn.alpha = 0.5
        personBtn.layer.borderWidth = 0
        personBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        homeBtn.alpha = 0.5
        homeBtn.layer.borderWidth = 0
        homeBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        shopBtn.alpha = 0.5
        shopBtn.layer.borderWidth = 0
        shopBtn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        travelBtn.alpha = 0.5
        travelBtn.layer.borderWidth = 0
        travelBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        AppointmentBtn.alpha = 0.5
        AppointmentBtn.layer.borderWidth = 0
        AppointmentBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        personaldiaryBtn.alpha = 0.5
        personaldiaryBtn.layer.borderWidth = 0
        personaldiaryBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        businessBtn.alpha = 0.5
        businessBtn.layer.borderWidth = 0
        businessBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        taskCompBtn.alpha = 0.5
        taskCompBtn.layer.borderWidth = 0
        taskCompBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        
      }
      @IBAction func inbox(_ sender: Any) {
        taskCategory = "inbox"
        inboxBtn.alpha = 1
        inboxBtn.layer.borderWidth = 1
        inboxBtn.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        giftBtn.alpha = 0.5
        giftBtn.layer.borderWidth = 0
        giftBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        dollarBtn.alpha = 0.5
        dollarBtn.layer.borderWidth = 0
        dollarBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        personBtn.alpha = 0.5
        personBtn.layer.borderWidth = 0
        personBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        homeBtn.alpha = 0.5
        homeBtn.layer.borderWidth = 0
        homeBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        shopBtn.alpha = 0.5
        shopBtn.layer.borderWidth = 0
        shopBtn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        travelBtn.alpha = 0.5
        travelBtn.layer.borderWidth = 0
        travelBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        AppointmentBtn.alpha = 0.5
        AppointmentBtn.layer.borderWidth = 0
        AppointmentBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        personaldiaryBtn.alpha = 0.5
        personaldiaryBtn.layer.borderWidth = 0
        personaldiaryBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        businessBtn.alpha = 0.5
        businessBtn.layer.borderWidth = 0
        businessBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        taskCompBtn.alpha = 0.5
        taskCompBtn.layer.borderWidth = 0
        taskCompBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        
        
      }
      @IBAction func Personal(_ sender: Any) {
        taskCategory = "Personal Notes"
        
        personBtn.alpha = 1
        personBtn.layer.borderWidth = 1
        personBtn.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        giftBtn.alpha = 0.5
        giftBtn.layer.borderWidth = 0
        giftBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        inboxBtn.alpha = 0.5
        inboxBtn.layer.borderWidth = 0
        inboxBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        dollarBtn.alpha = 0.5
        dollarBtn.layer.borderWidth = 0
        dollarBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        homeBtn.alpha = 0.5
        homeBtn.layer.borderWidth = 0
        homeBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        shopBtn.alpha = 0.5
        shopBtn.layer.borderWidth = 0
        shopBtn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        travelBtn.alpha = 0.5
        travelBtn.layer.borderWidth = 0
        travelBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        AppointmentBtn.alpha = 0.5
        AppointmentBtn.layer.borderWidth = 0
        AppointmentBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        personaldiaryBtn.alpha = 0.5
        personaldiaryBtn.layer.borderWidth = 0
        personaldiaryBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        businessBtn.alpha = 0.5
        businessBtn.layer.borderWidth = 0
        businessBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        taskCompBtn.alpha = 0.5
        taskCompBtn.layer.borderWidth = 0
        taskCompBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
      }
      @IBAction func personalDiary(_ sender: Any) {
        taskCategory = "Personal Diary"
        personaldiaryBtn.alpha = 1
        personaldiaryBtn.layer.borderWidth = 1
        personaldiaryBtn.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        giftBtn.alpha = 0.5
        giftBtn.layer.borderWidth = 0
        giftBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        inboxBtn.alpha = 0.5
        inboxBtn.layer.borderWidth = 0
        inboxBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        dollarBtn.alpha = 0.5
        dollarBtn.layer.borderWidth = 0
        dollarBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        homeBtn.alpha = 0.5
        homeBtn.layer.borderWidth = 0
        homeBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        shopBtn.alpha = 0.5
        shopBtn.layer.borderWidth = 0
        shopBtn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        travelBtn.alpha = 0.5
        travelBtn.layer.borderWidth = 0
        travelBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        AppointmentBtn.alpha = 0.5
        AppointmentBtn.layer.borderWidth = 0
        AppointmentBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        personBtn.alpha = 0.5
        personBtn.layer.borderWidth = 0
        personBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        businessBtn.alpha = 0.5
        businessBtn.layer.borderWidth = 0
        businessBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        taskCompBtn.alpha = 0.5
        taskCompBtn.layer.borderWidth = 0
        taskCompBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        
        
      }
      @IBAction func Appointments(_ sender: Any) {
        taskCategory = "Appointment"
        AppointmentBtn.alpha = 1
        AppointmentBtn.layer.borderWidth = 1
        AppointmentBtn.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        giftBtn.alpha = 0.5
        giftBtn.layer.borderWidth = 0
        giftBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        inboxBtn.alpha = 0.5
        inboxBtn.layer.borderWidth = 0
        inboxBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        dollarBtn.alpha = 0.5
        dollarBtn.layer.borderWidth = 0
        dollarBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        homeBtn.alpha = 0.5
        homeBtn.layer.borderWidth = 0
        homeBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        shopBtn.alpha = 0.5
        shopBtn.layer.borderWidth = 0
        shopBtn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        travelBtn.alpha = 0.5
        travelBtn.layer.borderWidth = 0
        travelBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        personaldiaryBtn.alpha = 0.5
        personaldiaryBtn.layer.borderWidth = 0
        personaldiaryBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        personBtn.alpha = 0.5
        personBtn.layer.borderWidth = 0
        personBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        businessBtn.alpha = 0.5
        businessBtn.layer.borderWidth = 0
        businessBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        taskCompBtn.alpha = 0.5
        taskCompBtn.layer.borderWidth = 0
        taskCompBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
      }
      @IBAction func TasksCompleted(_ sender: Any) {
        taskCategory = "Tasks"
        taskCompBtn.alpha = 1
        taskCompBtn.layer.borderWidth = 1
        taskCompBtn.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        giftBtn.alpha = 0.5
        giftBtn.layer.borderWidth = 0
        giftBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        inboxBtn.alpha = 0.5
        inboxBtn.layer.borderWidth = 0
        inboxBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        dollarBtn.alpha = 0.5
        dollarBtn.layer.borderWidth = 0
        dollarBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        homeBtn.alpha = 0.5
        homeBtn.layer.borderWidth = 0
        homeBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        shopBtn.alpha = 0.5
        shopBtn.layer.borderWidth = 0
        shopBtn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        travelBtn.alpha = 0.5
        travelBtn.layer.borderWidth = 0
        travelBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        AppointmentBtn.alpha = 0.5
        AppointmentBtn.layer.borderWidth = 0
        AppointmentBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        personBtn.alpha = 0.5
        personBtn.layer.borderWidth = 0
        personBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        businessBtn.alpha = 0.5
        businessBtn.layer.borderWidth = 0
        businessBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        personaldiaryBtn.alpha = 0.5
        personaldiaryBtn.layer.borderWidth = 0
        personaldiaryBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
      }
      @IBAction func Business(_ sender: Any) {
        taskCategory = "Business"
        businessBtn.alpha = 1
        businessBtn.layer.borderWidth = 1
        businessBtn.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        giftBtn.alpha = 0.5
        giftBtn.layer.borderWidth = 0
        giftBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        inboxBtn.alpha = 0.5
        inboxBtn.layer.borderWidth = 0
        inboxBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        dollarBtn.alpha = 0.5
        dollarBtn.layer.borderWidth = 0
        dollarBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        homeBtn.alpha = 0.5
        homeBtn.layer.borderWidth = 0
        homeBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        shopBtn.alpha = 0.5
        shopBtn.layer.borderWidth = 0
        shopBtn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        travelBtn.alpha = 0.5
        travelBtn.layer.borderWidth = 0
        travelBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        AppointmentBtn.alpha = 0.5
        AppointmentBtn.layer.borderWidth = 0
        AppointmentBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        personBtn.alpha = 0.5
        personBtn.layer.borderWidth = 0
        personBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        taskCompBtn.alpha = 0.5
        taskCompBtn.layer.borderWidth = 0
        taskCompBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        personaldiaryBtn.alpha = 0.5
        personaldiaryBtn.layer.borderWidth = 0
        personaldiaryBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
      }
      @IBAction func Travel(_ sender: Any) {
        taskCategory = "Travel"
        travelBtn.alpha = 1
        travelBtn.layer.borderWidth = 1
        travelBtn.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        giftBtn.alpha = 0.5
        giftBtn.layer.borderWidth = 0
        giftBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        inboxBtn.alpha = 0.5
        inboxBtn.layer.borderWidth = 0
        inboxBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        dollarBtn.alpha = 0.5
        dollarBtn.layer.borderWidth = 0
        dollarBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        homeBtn.alpha = 0.5
        homeBtn.layer.borderWidth = 0
        homeBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        shopBtn.alpha = 0.5
        shopBtn.layer.borderWidth = 0
        shopBtn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        businessBtn.alpha = 0.5
        businessBtn.layer.borderWidth = 0
        businessBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        AppointmentBtn.alpha = 0.5
        AppointmentBtn.layer.borderWidth = 0
        AppointmentBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        personBtn.alpha = 0.5
        personBtn.layer.borderWidth = 0
        personBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        taskCompBtn.alpha = 0.5
        taskCompBtn.layer.borderWidth = 0
        taskCompBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        personaldiaryBtn.alpha = 0.5
        personaldiaryBtn.layer.borderWidth = 0
        personaldiaryBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        
      }
      @IBAction func Gift(_ sender: Any) {
        taskCategory = "Gift"
        
        giftBtn.alpha = 1
        giftBtn.layer.borderWidth = 1
        giftBtn.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        businessBtn.alpha = 0.5
        businessBtn.layer.borderWidth = 0
        businessBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        inboxBtn.alpha = 0.5
        inboxBtn.layer.borderWidth = 0
        inboxBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        dollarBtn.alpha = 0.5
        dollarBtn.layer.borderWidth = 0
        dollarBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        homeBtn.alpha = 0.5
        homeBtn.layer.borderWidth = 0
        homeBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        shopBtn.alpha = 0.5
        shopBtn.layer.borderWidth = 0
        shopBtn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        travelBtn.alpha = 0.5
        travelBtn.layer.borderWidth = 0
        travelBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        AppointmentBtn.alpha = 0.5
        AppointmentBtn.layer.borderWidth = 0
        AppointmentBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        personBtn.alpha = 0.5
        personBtn.layer.borderWidth = 0
        personBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        taskCompBtn.alpha = 0.5
        taskCompBtn.layer.borderWidth = 0
        taskCompBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        personaldiaryBtn.alpha = 0.5
        personaldiaryBtn.layer.borderWidth = 0
        personaldiaryBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
      }
      @IBAction func Home(_ sender: Any) {
        taskCategory = "Home"
        
        homeBtn.alpha = 1
        homeBtn.layer.borderWidth = 1
        homeBtn.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        giftBtn.alpha = 0.5
        giftBtn.layer.borderWidth = 0
        giftBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        inboxBtn.alpha = 0.5
        inboxBtn.layer.borderWidth = 0
        inboxBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        dollarBtn.alpha = 0.5
        dollarBtn.layer.borderWidth = 0
        dollarBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        businessBtn.alpha = 0.5
        businessBtn.layer.borderWidth = 0
        businessBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        shopBtn.alpha = 0.5
        shopBtn.layer.borderWidth = 0
        shopBtn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        travelBtn.alpha = 0.5
        travelBtn.layer.borderWidth = 0
        travelBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        AppointmentBtn.alpha = 0.5
        AppointmentBtn.layer.borderWidth = 0
        AppointmentBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        personBtn.alpha = 0.5
        personBtn.layer.borderWidth = 0
        personBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        taskCompBtn.alpha = 0.5
        taskCompBtn.layer.borderWidth = 0
        taskCompBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        personaldiaryBtn.alpha = 0.5
        personaldiaryBtn.layer.borderWidth = 0
        personaldiaryBtn.layer.borderColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         let touch = touches.first
         if touch?.view != popView {
            animatedismiss(desiredView: popView)
            blurView.alpha = 0
        }
    }


    @IBAction func AddbtnActionTapped(_ sender: Any) {
        
        if tasknameField.text!.trimmingCharacters(in: .whitespaces).isEmpty && dateField.text!.trimmingCharacters(in: .whitespaces).isEmpty || tasknameField.text!.trimmingCharacters(in: .whitespaces).isEmpty {
            let alert = UIAlertController(title: "Alert", message: "Fill all the fields", preferredStyle: UIAlertController.Style.alert)
            let cancel = UIAlertAction(title: "Ok", style: .cancel) { (action) -> Void in
              }
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
         
        }else{
        
        
        
        blurView.alpha = 0
        
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {return}

        insert.removeAll()
        animatedismiss(desiredView: popView)
        let request = NSMutableURLRequest(url: NSURL(string: "https://appstudio.co/iOS/Task_N.php")! as URL)
        request.httpMethod = "POST"
        let postString = "TaskDate=\(dateField.text!)&username=\(email)&TaskName=\(tasknameField.text!)&TaskStatus=Pending&FavouriteStatus=Not Favourite&Category=\(taskCategory ?? "")"
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
        
    }
    func downloadItems() {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {return}


        let request = NSMutableURLRequest(url: NSURL(string: urlpath ?? "https://appstudio.co/iOS/Retrieve_N.php")! as URL)
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
            let Id = jsonElement["Id"] as? String,
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
                
                insert.append(insertData(TaskName: TaskName, TaskStatus: TaskStatus,TaskDate: datetostring,FavouriteStatus: FavouriteStatus,Category: Category,Id: Id))
                

                }
            }
        DispatchQueue.main.async(execute: { [self] () -> Void in
                itemsDownloaded(items: stocks)
            if self.insert.count > 0{
                self.tabView.isHidden = false
                self.defaulVeww.isHidden = true
            }else {
                self.tabView.isHidden = true
                self.defaulVeww.isHidden = false
            }
        })
        }
    
    
    func itemsDownloaded(items: NSArray) {
       
        self.tabView.reloadData()
      }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      return UITableView.automaticDimension
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     //   return insert.count
         var numOfSection: NSInteger = 0

             if insert.count > 0 {

                defaulVeww.alpha = 0
                numOfSection = insert.count
             } else {

                defaulVeww.alpha = 1
             }
            return numOfSection
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  didselect?.removeAll()
       // sdateSelect?.removeAll()
       // edateSelect?.removeAll()
        oldTaskname?.removeAll()
        animatedismiss(desiredView: popView)
      //  Vieww.isHidden = true
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {return}

        didselect = "\(insert[indexPath.row].TaskName as! String)"
        sdateSelect = "\(insert[indexPath.row].TaskDate as! String)"
     
        let alert = UIAlertController(title: "Edit", message: "", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "update", style: UIAlertAction.Style.default) { [self](action) in
        let alertController = UIAlertController(title: "Edit", message: "Successfully updated!", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: nil))
        self.tabView.reloadData()
      // namo link sever "http://con.test:8888/Task.php"
            
            if textField.text!.trimmingCharacters(in: .whitespaces).isEmpty != true && stextField.text!.trimmingCharacters(in: .whitespaces).isEmpty != true{
            
            
        let request = NSMutableURLRequest(url: NSURL(string: "https://appstudio.co/iOS/Edit_N.php")! as URL)
        request.httpMethod = "POST"
        let postString = "username=\(email)&TaskName=\(textField.text as! String)&TaskStatus=\(insert[indexPath.row].TaskStatus as! String)&TaskDate=\(stextField.text as! String)&Id=\(Int16(insert[indexPath.row].Id as! String) as! Int16)"
                    print("postString : \(postString)")
        insert.removeAll()
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
           
        self.tabView.reloadData()
        
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
        alertTextField.text = didselect
        textField = alertTextField
                }
            alert.addTextField { [self] (textField1) in
              let toolbar=UIToolbar()
              toolbar.sizeToFit()
         //   self.start_end_date2 = UIDatePicker(frame:CGRect(x: 0, y: self.view.frame.size.height - 220, width:self.view.frame.size.width, height: 216))
               // start_end_date.datePickerMode = .date
                let done1=UIBarButtonItem(barButtonSystemItem: .done, target:self, action:#selector(start))
                toolbar.setItems([done1], animated: false)
                textField1.inputAccessoryView=toolbar
                textField1.inputView=start_end_date1
                textField1.placeholder = "Edit Task date"
                textField1.text = sdateSelect
                start_end_date1.datePickerMode = .date
                stextField = textField1
              
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
        stextField.inputAccessoryView=toolbar
        stextField.inputView=dateset
        dateset.datePickerMode = .date
    }
    
    @objc func start(){
        let dateformat=DateFormatter()
        dateformat.dateStyle = .medium
        dateformat.timeStyle = .none
        dateformat.dateFormat = "yyyy-MM-dd"
        let sdatestring = dateformat.string(from: dateset.date)
        stextField.text="\(sdatestring as! String)"
        self.view.endEditing(true)
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
            if self.insert.count > 0{
                self.tabView.isHidden = false
                self.defaulVeww.isHidden = true
            }else {
                self.tabView.isHidden = true
                self.defaulVeww.isHidden = false
            }
            
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
        dateField.inputView=start_end_date1
        start_end_date1.datePickerMode = .date
     
     
    }
    
    @objc func doneselect(){
        let dateformat=DateFormatter()
        dateformat.dateStyle = .medium
        dateformat.timeStyle = .none
        dateformat.dateFormat = "yyyy-MM-dd"
        let datestring = dateformat.string(from: start_end_date1.date)
        dateField.text="\(datestring)"
        self.view.endEditing(true)
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
}

struct insertData {
var TaskName:String
var TaskStatus:String?
var TaskDate: String?
var FavouriteStatus: String?
var Category: String?
var Id: String?
}

