//
//  CompletedCell.swift
//  TaskManager
//
//  Created by Admin Mac on 12/03/21.
//

import UIKit

class CompletedCell: UITableViewCell {
    
    @IBOutlet weak var completedcellView: UIView!
    @IBOutlet weak var favbtn: UIButton!
    @IBOutlet weak var compcatImg: UIImageView!
    @IBOutlet weak var comptextlab: UILabel!
    @IBOutlet weak var compdatelab: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        completedcellView.layer.masksToBounds = false
        completedcellView.layer.shadowRadius = 5
        completedcellView.layer.shadowOpacity = 0.5
        completedcellView.layer.shadowColor = UIColor.lightGray.cgColor
        completedcellView.layer.shadowOffset = CGSize(width: 0 , height:3)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
