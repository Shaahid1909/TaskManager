//
//  PendingCell.swift
//  TaskManager
//
//  Created by Admin Mac on 12/03/21.
//

import UIKit

class PendingCell: UITableViewCell {
    
    
    @IBOutlet weak var pendingcellView: UIView!
    @IBOutlet weak var pendfavbtn: UIButton!
    @IBOutlet weak var pencatImg: UIImageView!
    @IBOutlet weak var pendtextlab: UILabel!
    @IBOutlet weak var pendatelab: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pendingcellView.layer.masksToBounds = false
        pendingcellView.layer.shadowRadius = 5
        pendingcellView.layer.shadowOpacity = 0.5
        pendingcellView.layer.shadowColor = UIColor.lightGray.cgColor
        pendingcellView.layer.shadowOffset = CGSize(width: 0 , height:3)
        pendingcellView.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
