import UIKit

protocol BoardViewControllerDelegate: class {

    func goToOptions()
    func goToBoardCollection()
    func save(board: BoardData)
}

class BoardViewController: UIViewController {
    
    let height = 75.0
    let width = sqrt(3)/2 * 75.0
    
    
    var session: ApplicationSession!
    var model: BoardModel!
    weak var delegate: BoardViewControllerDelegate?
    
    @IBOutlet weak var waterView: UIView!
    @IBOutlet var tileViews: [UIView]!
    @IBOutlet weak var optionsButton: UIButton!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var waterViewSideways: NSLayoutConstraint!
    @IBOutlet weak var waterViewNormal: NSLayoutConstraint!
    
    @IBOutlet weak var boardCollectionButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        waterViewSideways.isActive = false
        createBoard()
        
    }
    
    @IBAction func generateButtonPressed(_ sender: Any) {
        
        
        
        for tileView in self.tileViews {
            tileView.rotate360Degrees(duration: 0.8)
        }
        
        
        deleteBoard()
        createBoard()
    }
    
    @IBAction func optionsButtonPressed(_ sender: Any) {
        
        
        delegate?.goToOptions()
        
    }
    
    @IBAction func boardCollectionButtonPressed(_ sender: Any) {
        
        delegate?.goToBoardCollection()
        
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        
        let board = model.getBoardData()
        session.boards.append(board)
//        delegate?.save(board: board)
        
    }
    
    func deleteBoard(){
        for tileView in tileViews {
            for subview in tileView.subviews {
                subview.removeFromSuperview()
            }
        }
    }
    
    func createBoard(){
        
        model.newBoard()
        
        var tileIndex = 0
        let offset = 2
        
        for i in -2...2 {

            for j in -2...2 {
                //if not the empty tiles in the grid
                //empty tiles indexes  (-2,-2) (-1,-2) (-2,-1) (2,1) (1,2) (2,2)
                if (i == -2 && j == -2) || (i == -1 && j == -2) || (i == -2 && j == -1) || (i == 2 && j == 1) || (i == 1 && j == 2) || (i == 2 && j == 2) {
                    //print("Tile at (\(i),\(j)) is water")
                }
                else{
                    //print("creating hex \(tileIndex) at (\(i),\(j))")
                    
                    
                    if model.tileData[i+offset][j+offset]?.resourceType != .desert {
                    
                    let hexagon = Hexagon(frame: CGRect(x: 0, y: 0, width: Int(width), height: Int(height)), resourceType: (model.tileData[i+offset][j+offset]?.resourceType)!, numberToken: (model.tileData[i+offset][j+offset]?.tileNumberToken)!, width: width, height: height)
                        
                    
                    tileViews[tileIndex].addSubview(hexagon)
                    
                    }
                    else{
                        let hexagon = Hexagon(frame: CGRect(x: 0, y: 0, width: Int(width), height: Int(height)), resourceType: (model.tileData[i+offset][j+offset]?.resourceType)!, numberToken: nil, width: width, height: height)
                        
                        
                        tileViews[tileIndex].addSubview(hexagon)
                    }
                    tileIndex += 1
                }
            }

        }
    }
    
    

}


