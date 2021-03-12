//
//  TaskViewCell.swift
//  TaskManager
//
//  Created by Admin Mac on 11/03/21.
//

import UIKit

class TaskViewCell: UITableViewCell {
    
    
    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var tasknamelab: UILabel!
    @IBOutlet weak var taskdatelab: UILabel!
    @IBOutlet weak var favcheck: UIButton!
    @IBOutlet weak var taskcellview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        taskcellview.layer.masksToBounds = false
        taskcellview.layer.shadowRadius = 5
        taskcellview.layer.shadowOpacity = 0.5
        taskcellview.layer.shadowColor = UIColor.lightGray.cgColor
        taskcellview.layer.shadowOffset = CGSize(width: 0 , height:3)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
