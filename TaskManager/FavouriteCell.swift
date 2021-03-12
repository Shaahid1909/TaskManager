//
//  FavouriteCell.swift
//  TaskManager
//
//  Created by Admin Mac on 12/03/21.
//

import UIKit

class FavouriteCell: UITableViewCell {
    @IBOutlet weak var favbtn: UIButton!
    @IBOutlet weak var favcatImg: UIImageView!
    @IBOutlet weak var favtextlab: UILabel!
    @IBOutlet weak var favdatelab: UILabel!
    @IBOutlet weak var favcellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        favcellView.layer.masksToBounds = false
        favcellView.layer.shadowRadius = 5
        favcellView.layer.shadowOpacity = 0.5
        favcellView.layer.shadowColor = UIColor.lightGray.cgColor
        favcellView.layer.shadowOffset = CGSize(width: 0 , height:3)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
