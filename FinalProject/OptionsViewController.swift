import UIKit

protocol OptionsViewControllerDelegate: class {
    func logout()
    func generateBoard()
}

class OptionsViewController: UIViewController {
    
   
    var session: ApplicationSession!
    var model: OptionsModel!
    weak var delegate: OptionsViewControllerDelegate?
    
    @IBOutlet weak var randomTilesButton: UIButton!
    @IBOutlet weak var randomNumbersButton: UIButton!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //set options to on or off
        if model.randomNumbersToggle {
            randomNumbersButton.setTitle("On", for: .normal)
        }
        else{
            randomNumbersButton.setTitle("Off", for: .normal)
        }
        
        if model.randomTilesToggle {
            randomTilesButton.setTitle("On", for: .normal)
        }
        else{
            randomTilesButton.setTitle("Off", for: .normal)
        }
        
        //round generate button
        generateButton.backgroundColor = .clear
        generateButton.layer.cornerRadius = 5
        generateButton.layer.borderWidth = 1
        generateButton.layer.borderColor = UIColor.black.cgColor
        
        nameLabel.text = "\(session.user.name!)'s settings"

    }
    
    @IBAction func randomNumbersButtonPressed(_ sender: Any) {
        print("toggling randomNumberButton")
        model.toggleRandomNumbers()
        
        if model.randomNumbersToggle {
            randomNumbersButton.setTitle("On", for: .normal)
        }
        else{
            randomNumbersButton.setTitle("Off", for: .normal)
        }
    }

    @IBAction func randomTilesButtonPressed(_ sender: Any) {
        print("toggling randomTilesButton")
        model.toggleTilesNumbers()
        
        if model.randomTilesToggle {
            randomTilesButton.setTitle("On", for: .normal)
        }
        else{
            randomTilesButton.setTitle("Off", for: .normal)
        }
        
    }
    
    
    
    
    @IBAction func generateBoardButtonPressed(_ sender: Any) {
        print("Generating Board Pressed")
        delegate?.generateBoard()
    }
    

}
