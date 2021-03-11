

import UIKit

class MainViewController: UITabBarController {
  
  @IBOutlet weak var centerButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCenterButton()
  }
  
  fileprivate func setupCenterButton() {
  //  tabBar.addSubview(centerButton)
    self.view.insertSubview(centerButton, aboveSubview: self.tabBar)
  //  centerButton.translatesAutoresizingMaskIntoConstraints = false
  //  centerButton.centerYAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
  //  centerButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor).isActive = true
    let customTabbar = tabBar as! MainMenuTabbar
    customTabbar.centerButton = centerButton
  }
  
  @IBAction fileprivate func unwindToMainViewController(_ segue: UIStoryboardSegue) {}
  
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // safe place to set the frame of button manually
        centerButton.frame = CGRect.init(x: self.tabBar.center.x - 70, y: self.view.bounds.height - 130, width: 130, height: 130)
    }

    
    
    
    
}
