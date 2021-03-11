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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
