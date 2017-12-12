import UIKit

protocol BoardViewControllerDelegate: class {
//    func logout()
//    func generateBoard()
}

class BoardViewController: UIViewController {
    
    let width = 100
    let height = 100
    
    var session: ApplicationSession!
    var model: BoardModel!
    weak var delegate: BoardViewControllerDelegate?
    
    @IBOutlet weak var waterView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let hexagon = Hexagon(frame: CGRect(x: 100, y: 100, width: width, height: height), resourceType: .brick, numberToken: 2)
        
        hexagon.width = width
        hexagon.height = height
        //set hexagon constraints
        hexagon.centerXAnchor.constraint(equalTo: waterView.centerXAnchor)
        hexagon.centerYAnchor.constraint(equalTo: waterView.centerYAnchor)
        
        waterView.addSubview(hexagon)
    }

    


}

