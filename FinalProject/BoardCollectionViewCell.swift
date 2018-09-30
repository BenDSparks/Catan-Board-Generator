import UIKit

class BoardCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var tileViews: [UIView]!
    @IBOutlet weak var waterView: UIView!
    
    
    func decorate(board: BoardData) {
        
        
        heightAnchor.constraint(equalToConstant: 200)
        
        createBoard(board: board)
//        classNameLabel.text = gpaEntry.name
//        creditHourLabel.text = String(gpaEntry.creditHours)
//        gradeLabel.text = gpaEntry.projectedGrade
//
//
//
//        if let newGPAEntry = gpaEntry.gpaPoints{
//            gradePointsLabel.text = "+ \(newGPAEntry) GPA Points"
//        }
//        else{
//            gradePointsLabel.text = ""
//        }
        
    }
    
    func createBoard(board: BoardData){
        var numberTokenIndex = 0
        let height = 40.0
        let width = sqrt(3)/2 * 40.0
        
        for i in 0..<board.resourceOrder.count {
            
            switch board.resourceOrder[i] {
            case .brick, .wood, .sheep, .wheat, .ore:
                
                let hexagon = Hexagon(frame: CGRect(x: 0, y: 0, width: width, height: height), resourceType: board.resourceOrder[i], numberToken: board.numberOrder[numberTokenIndex], width: width, height: height)
                tileViews[i].addSubview(hexagon)
                numberTokenIndex += 1
            case .desert:
                
                let hexagon = Hexagon(frame: CGRect(x: 0, y: 0, width: width, height: height), resourceType: board.resourceOrder[i], numberToken: nil, width: width, height: height)
                tileViews[i].addSubview(hexagon)

            }
            
    
        }
    }
}
