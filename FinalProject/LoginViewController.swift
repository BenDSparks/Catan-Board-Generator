import UIKit

protocol LoginViewControllerDelegate: class {
    func loginButtonPressed(name: String)
	func usernameUpdated(to userName: String?)
}

class LoginViewController: UIViewController {

	@IBOutlet weak var userNameTextField: UITextField!
	@IBOutlet weak var loginButton: UIButton!
	weak var delegate: LoginViewControllerDelegate?
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
		NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: userNameTextField, queue: nil, using: textFieldTextChanged(_:))
        
		userNameTextField.delegate = self
        
		userNameTextField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)])
        
		loginButton.isEnabled = false
        
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		//userNameTextField.drawUnderline(withWidth: 0.5, opacity: 1.0)
	}
	
	@IBAction func loginButtonPressed(_ sender: UIButton) {
		view.endEditing(true)
        
        guard let name = userNameTextField.text else {return}
        
		delegate?.loginButtonPressed(name: name)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
		super.touchesBegan(touches, with: event)
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
}

extension LoginViewController: UITextFieldDelegate {
	func textFieldTextChanged(_ notification: Notification) {
		let textField = notification.object as! UITextField
		if let text = textField.text {
			loginButton.isEnabled = text.removingWhiteSpaces().count > 2
		}
		delegate?.usernameUpdated(to: textField.text?.trimWhiteSpace())
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if loginButton.isEnabled {
			textField.resignFirstResponder()
            
            guard let loginId = userNameTextField.text else {return false}
            
            delegate?.loginButtonPressed(name: loginId)
		}
		return true
	}
}
