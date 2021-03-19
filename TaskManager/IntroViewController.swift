
import UIKit

class IntroViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var PAGECONTROL: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!

    var count = 0
    var pageImages = ["1.png", "onboardfav.png", "onboardcomplete.png"]
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        PAGECONTROL.numberOfPages = 3
        PAGECONTROL.currentPage = 0
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let pageSide = self.collectionView.frame.width
            let offset = scrollView.contentOffset.x
            count = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        PAGECONTROL.currentPage = count
            print("currentPage " + count.description )
        }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! InroCell
            //as! introScreenTableViewCell
        Cell.ImView.image = UIImage(named: "\(pageImages[indexPath.row])")
        
        return Cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:  249, height: 249)
    }
    @IBAction func Loginintro(_ sender: Any) {
        performSegue(withIdentifier: "LoginScreen", sender: self)
    }
    
    
}
