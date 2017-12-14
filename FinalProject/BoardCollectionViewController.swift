import UIKit

protocol BoardCollectionViewControllerDelegate: class {
    func goToBoardCreation()
}

class BoardCollectionViewController: UIViewController {
    
    let height = 40.0
    let width = sqrt(3)/2 * 40.0
    
    
    var session: ApplicationSession!
    var model: BoardModel!
    weak var delegate: BoardCollectionViewControllerDelegate?
    
    
    
    
    @IBOutlet weak var boardCollectionView: UICollectionView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var waterView: UIView!
//    @IBOutlet var tileViews: [UIView]!
//    @IBOutlet weak var optionsButton: UIButton!
//    @IBOutlet weak var generateButton: UIButton!
//    @IBOutlet weak var waterViewSideways: NSLayoutConstraint!
//    @IBOutlet weak var waterViewNormal: NSLayoutConstraint!
//
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func backButtonPressed(_ sender: Any) {
        delegate?.goToBoardCreation()
    }
    
}


extension BoardCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return session.boards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoardCollectionCell", for: indexPath) as! BoardCollectionViewCell
        
        //create a test board
//        var board = BoardData()
//        for i in 0...18 {
//            let tile = TileData(xIndex: 0, yIndex: 0, resourceType: .brick, tileNumberToken: i)
//            board.tiles.append(tile)
//        }
        
        
        
        
        cell.decorate(board: session.boards[indexPath.row])
        
        
        
        return cell
    }
    
    
}



