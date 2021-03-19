//
//  IntroScreen.swift
//  TaskManager
//
//  Created by Admin Mac on 17/03/21.
//

import UIKit
import Foundation

class IntroScreen: UIViewController,UIScrollViewDelegate {
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var pageCon: UIPageControl!
    
    @IBOutlet weak var headla: UILabel!
    @IBOutlet weak var shead: UILabel!
    
    var images = ["1.png", "onboardfav.png", "onboardcomplete.png"]

    var pageHeadings = ["Manage your daily todo", "Manage your favorite todo", "Manage your Completed todo"]
    
    var pageSubHeadings = ["Be organised and work more with todo", "Organise Favourite and work more with todo", "Organise Completed and work more with todo"]
    
    
    override func viewDidLoad() {
       
        // Initialization code
        pageCon.numberOfPages = images.count
        for index in 0..<images.count {
            view.frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            view.frame.size = scrollView.frame.size
            
            let imgView = UIImageView(frame: view.frame)
            imgView.image = UIImage(named: images[index])
            
            headla.text = pageHeadings[index]
            shead.text = pageSubHeadings[index]
            
            self.scrollView.addSubview(imgView)
            
            
            
        }
        scrollView.contentSize = CGSize(width:(scrollView.frame.size.width * CGFloat(images.count)), height:scrollView.frame.size.height)
        scrollView.delegate = self
        

    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageCon.currentPage = Int(pageNumber)
    }
    



    
}
