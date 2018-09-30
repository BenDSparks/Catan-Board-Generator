import UIKit

protocol BoardViewControllerDelegate: class {

    func goToOptions()
    func goToBoardCollection()
    //func save(board: BoardData)
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
    @IBOutlet weak var rotateBoardView: UIView!
    
    
    
    
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
        rotateBoardView.rotate360Degrees(duration: 0.7)
        
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
        
        var numberTokenIndex = 0
        
        for i in 0..<model.resourceOrder.count {

                    
            if model.resourceOrder[i] != .desert {
            
                let hexagon = Hexagon(frame: CGRect(x: 0, y: 0, width: width, height: height), resourceType: model.resourceOrder[i], numberToken: model.numberTokenOrder[numberTokenIndex], width: width, height: height)
                
                
                tileViews[i].addSubview(hexagon)
                numberTokenIndex += 1
                
            }
            else{
                let hexagon = Hexagon(frame: CGRect(x: 0, y: 0, width: width, height: height), resourceType: model.resourceOrder[i], numberToken: nil, width: width, height: height)
            
            
                tileViews[i].addSubview(hexagon)
            }
          
        }
    }
    
    

}


